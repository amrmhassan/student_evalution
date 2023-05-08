import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/mixins/user_mixins.dart';
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

  Future<void> auth() async {
    try {
      loggingIn = true;
      notifyListeners();
      String email = '${emailController.text}@$emailSuffix';
      String password = passController.text;
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

  // Future<void> signUp({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required String imageLink,
  // }) async {
  //   var cred = await FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(email: email, password: password);
  //   if (cred.user == null) {
  //     throw Exception('User not created');
  //   }
  //   UserModel userModel = UserModel(
  //     email: email,
  //     name: name,
  //     uid: cred.user!.uid,
  //     userImage: imageLink,
  //     userType: UserType.teacher,
  //   );
  //   await FirebaseFirestore.instance
  //       .collection(DBCollections.users)
  //       .doc(userModel.uid)
  //       .set(userModel.toJSON());
  // }
  Future<String> changeUserPhoto(File file) async {
    UserModel me = userModel!;
    // upload the image
    var res = await FirebaseStorage.instance
        .ref(RemoteStorage.usersImages)
        .child(me.uid)
        .putFile(file);
    String imageLink = await res.ref.getDownloadURL();
    // update the new user model locally in hive

    late UserModel newMe;
    if (me.userType == UserType.student) {
      StudentModel oldMe = me as StudentModel;
      newMe = StudentModel(
        email: oldMe.email,
        name: oldMe.name,
        uid: oldMe.uid,
        mobileNumber: oldMe.mobileNumber,
        userImage: imageLink,
        studentGrade: oldMe.studentGrade,
      );
    } else if (me.userType == UserType.teacher) {
      TeacherModel oldMe = me as TeacherModel;
      newMe = TeacherModel(
        email: oldMe.email,
        name: oldMe.name,
        uid: oldMe.uid,
        userImage: imageLink,
        teacherClass: oldMe.teacherClass,
        mobileNumber: oldMe.mobileNumber,
      );
    } else {
      AdminModel oldMe = me as AdminModel;
      newMe = AdminModel(
        email: oldMe.email,
        name: oldMe.name,
        uid: oldMe.uid,
        userImage: imageLink,
        mobileNumber: oldMe.mobileNumber,
      );
    }
    await _saveCurrentUserInfo(newMe);
    userModel = newMe;
    notifyListeners();
    // save the updated user model version on firebase
    await FirebaseFirestore.instance
        .collection(DBCollections.users)
        .doc(newMe.uid)
        .set(newMe.toJSON());

    return imageLink;
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
