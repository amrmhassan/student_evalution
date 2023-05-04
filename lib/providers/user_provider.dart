import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/hive/hive_helper.dart';
import '../init/runtime_variables.dart';
import '../models/user_model.dart';

enum AuthType {
  facebook,
  google,
  signup,
  emailLogin,
}

class UserProvider extends ChangeNotifier {
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

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    // facebook logout

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

  //# validation
  String? emailError;
  String? passError;
}
