import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/mixins/user_mixins.dart';
import 'package:student_evaluation/models/saved_accounts_model.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/transformers/models_fields.dart';
import 'package:student_evaluation/transformers/remote_storage.dart';
import 'package:student_evaluation/validation/login_validation.dart';

import '../core/constants/global_constants.dart';
import '../core/hive/hive_helper.dart';
import '../init/runtime_variables.dart';
import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider extends ChangeNotifier with UserMixin {
  //# inputs
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool loggingIn = false;
  UserModel? userModel;

  // i should have a function here that accepts an Auth  class
  // auth(AuthProvider) this auth provider might be loginRepo class or signUpRepo class
  // and this function will just return either a failure or a userModel
  // this is just to unify data sources and apply the pipelines concept

  // the repos available now are LoginRepo, SignUpRepo or NormalLoginImpl

  Future<void> auth({
    String? savedEmail,
    String? savedPassword,
  }) async {
    try {
      loggingIn = true;
      notifyListeners();
      String email = savedEmail ?? '${emailController.text}@$emailSuffix';

      String password = savedPassword ?? passController.text;
      bool valid = _validateLogin(email: email, password: password);
      if (!valid) {
        loggingIn = false;
        notifyListeners();
        throw Exception('Please check your inputs');
      }
      UserModel? remoteUser = await _getUserByEmail(email);
      if (remoteUser == null) {
        throw Exception('Authentication error');
      }
      userModel = remoteUser;
      notifyListeners();
      await _saveCurrentUserInfo(remoteUser);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //? if the user model is a student model then save his data( email, password )
      if (remoteUser is StudentModel) {
        await _addStudentUser(remoteUser, password);
      } else {
        await _deleteSavedStudentUsers();
      }

      //?
      loggingIn = false;
      notifyListeners();
    } catch (e) {
      loggingIn = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<UserModel?> _getUserByEmail(String email) async {
    try {
      var res = (await FirebaseFirestore.instance
              .collection(DBCollections.users)
              .where(ModelsFields.email, isEqualTo: email)
              .get())
          .docs
          .first
          .data();
      UserModel userModel = UserModel.fromJSON(res);
      return userModel;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    // delete saved user data
    await _deleteCurrentUserInfo();
  }

  //# saved user info related methods
  Future<void> _saveCurrentUserInfo(UserModel userModel) async {
    var box = await HiveBox.currentUser;
    await box.put(userModel.uid, userModel);
  }

  Future<void> _deleteCurrentUserInfo() async {
    var box = await HiveBox.currentUser;
    await box.clear();
  }

  Future<void> loadCurrentUserInfo() async {
    try {
      var box = await HiveBox.currentUser;
      if (box.values.isEmpty) return;
      var data = box.values.first as UserModel;
      userModel = data;
      notifyListeners();
    } catch (e) {
      logger.e(e);
    }
  }

  Future<UserModel> changeUserPhotoOnStorageOnly({
    required File file,
    required UserModel userModel,
  }) async {
    var res = await FirebaseStorage.instance
        .ref(RemoteStorage.usersImages)
        .child(userModel.uid)
        .putFile(file);
    String imageLink = await res.ref.getDownloadURL();

    late UserModel newUserModel;
    if (userModel.userType == UserType.student) {
      StudentModel oldMe = userModel as StudentModel;
      newUserModel = StudentModel(
        email: oldMe.email,
        name: oldMe.name,
        uid: oldMe.uid,
        mobileNumber: oldMe.mobileNumber,
        userImage: imageLink,
        studentGrade: oldMe.studentGrade,
      );
    } else if (userModel.userType == UserType.teacher) {
      TeacherModel oldMe = userModel as TeacherModel;
      newUserModel = TeacherModel(
        email: oldMe.email,
        name: oldMe.name,
        uid: oldMe.uid,
        userImage: imageLink,
        teacherClass: oldMe.teacherClass,
        mobileNumber: oldMe.mobileNumber,
        studentGrades: [],
      );
      throw Exception('Edit student grades');
    } else {
      AdminModel oldMe = userModel as AdminModel;
      newUserModel = AdminModel(
        email: oldMe.email,
        name: oldMe.name,
        uid: oldMe.uid,
        userImage: imageLink,
        mobileNumber: oldMe.mobileNumber,
      );
    }
    return newUserModel;
  }

  Future<String> changeMyPhoto(File file) async {
    UserModel me = userModel!;
    // upload the image
    // update the new user model locally in hive

    UserModel newMe =
        await changeUserPhotoOnStorageOnly(file: file, userModel: me);

    await _saveCurrentUserInfo(newMe);
    userModel = newMe;
    notifyListeners();
    // save the updated user model version on firebase

    await updateUserModel(newMe);
    return newMe.userImage!;
  }

  Future<void> updateUserModel(UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection(DBCollections.users)
        .doc(userModel.uid)
        .set(userModel.toJSON());
  }

  Future<void> _addStudentUser(
    StudentModel studentModel,
    String password,
  ) async {
    var box = await HiveBox.studentUsers;
    SavedAccountModel savedAccountModel = SavedAccountModel(
      userModel: studentModel,
      password: password,
    );
    await box.add(savedAccountModel);
  }

  Future<void> _deleteSavedStudentUsers() async {
    var box = await HiveBox.studentUsers;
    await box.clear();
  }

  Future<List<SavedAccountModel>> getSavedAccounts() async {
    var box = await HiveBox.studentUsers;
    List<SavedAccountModel> models = box.values.toList().cast();
    if (userModel != null) {
      models.removeWhere((element) => element.userModel.uid == userModel!.uid);
    }
    return models;
  }

  //# validation
  String? emailError;
  String? passError;

  bool _validateLogin({
    required String email,
    required String password,
  }) {
    emailError = EmailValidation().error(email);
    passError = PasswordValidation().error(password);
    notifyListeners();
    return emailError == null && passError == null;
  }
}
