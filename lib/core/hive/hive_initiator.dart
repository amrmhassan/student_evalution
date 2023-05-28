import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_evaluation/models/saved_accounts_model.dart';

import '../../models/user_model.dart';

class HiveInitiator {
  Future<void> setup() async {
    await Hive.initFlutter();
    await _registerAdapters();
  }

  Future<void> _registerAdapters() async {
    // Hive.registerAdapter(UserModelAdapter()); //=>0
    Hive.registerAdapter(UserTypeAdapter()); //=>1
    Hive.registerAdapter(StudentGradeAdapter()); //=>2
    Hive.registerAdapter(TeacherClassAdapter()); //=>3
    Hive.registerAdapter(StudentModelAdapter()); //=>4
    Hive.registerAdapter(TeacherModelAdapter()); //=>5
    Hive.registerAdapter(AdminModelAdapter()); //=>6
    Hive.registerAdapter(SavedAccountModelAdapter()); //=>7
  }
}
