import 'package:firebase_core/firebase_core.dart';
import 'package:student_evaluation/core/errors/firebase_errors.dart';

import '../firebase_options.dart';

class FirebaseInit {
  static Future<FirebaseApp> init() async {
    await FirebaseErrors().errorHandler();
    return await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
