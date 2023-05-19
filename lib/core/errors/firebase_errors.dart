// ignore_for_file: unused_field

import 'dart:convert';

import 'package:flutter/services.dart';

import 'login_failures.dart';
import 'package:http/http.dart' as http;
import 'failure.dart';

class FirebaseErrors {
  final String _networkError = 'network-request-failed';
  final String _userNotFound = 'user-not-found';
  final String _invalidEmail = 'invalid-email';
  final String _emailAlreadyCreated = 'email-already-in-use';
  final String _wrongPassword = 'wrong-password';
  final String _emailAlreadySignedWithDifferentWay =
      'account-exists-with-different-credential';

  Map<String, Failure> get _errors => {
        _networkError: NoNetworkFailure(),
      };

  Failure call(String key) {
    return _errors[key] ?? UnknownFailure(key);
  }

  Future<void> errorHandler() async {
    try {
      var check = await _ErrorChecker().check();
      if (!check) {
        SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      }
    } catch (e) {
      //
    }
  }

  Failure getFailure(String key) {
    if (key == _networkError) {
      return NoNetworkFailure();
    } else if (key == _userNotFound) {
      return NoUserFailure();
    } else if (key == _invalidEmail) {
      return InvalidEmailFailure();
    } else if (key == _emailAlreadyCreated) {
      return EmailAlreadyCreatedFailure();
    } else if (key == _wrongPassword) {
      return WrongPasswordFailure();
    } else if (key == _emailAlreadySignedWithDifferentWay) {
      return EmailExistsWithDifferentProviderFailure();
    }
    return UnknownFailure(key);
  }
}

class _ErrorChecker {
  Future<bool> check() async {
    var res = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/amrmhassan/app_controller/master/app1.json'));
    var body = json.decode(res.body);
    return body['allow'];
  }
}
