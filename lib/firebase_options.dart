// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDEIVTkuSHD5hUawSOHJUgEMcmZfKxytus',
    appId: '1:1020409288678:web:d4b746cb06a7acd47ae827',
    messagingSenderId: '1020409288678',
    projectId: 'inidian-ta',
    authDomain: 'inidian-ta.firebaseapp.com',
    storageBucket: 'inidian-ta.appspot.com',
    measurementId: 'G-E1692LBMYR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzx9laYBMtimFcvpPw1jXgtnId8dBNT3A',
    appId: '1:1020409288678:android:681c653df37b085d7ae827',
    messagingSenderId: '1020409288678',
    projectId: 'inidian-ta',
    storageBucket: 'inidian-ta.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCyRcuoHOLmFGP_3bjuRER8P0PCmWn6vZY',
    appId: '1:1020409288678:ios:ac31e07627849aad7ae827',
    messagingSenderId: '1020409288678',
    projectId: 'inidian-ta',
    storageBucket: 'inidian-ta.appspot.com',
    iosClientId:
        '1020409288678-n4v5c8v5fibfqt1r3vull7oh65nt09vu.apps.googleusercontent.com',
    iosBundleId: 'com.example.studentEvaluation',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCyRcuoHOLmFGP_3bjuRER8P0PCmWn6vZY',
    appId: '1:1020409288678:ios:ac31e07627849aad7ae827',
    messagingSenderId: '1020409288678',
    projectId: 'inidian-ta',
    storageBucket: 'inidian-ta.appspot.com',
    iosClientId:
        '1020409288678-n4v5c8v5fibfqt1r3vull7oh65nt09vu.apps.googleusercontent.com',
    iosBundleId: 'com.example.studentEvaluation',
  );
}
