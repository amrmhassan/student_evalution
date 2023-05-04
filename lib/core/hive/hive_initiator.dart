import 'package:hive_flutter/hive_flutter.dart';

import '../../models/user_model.dart';

class HiveInitiator {
  Future<void> setup() async {
    await Hive.initFlutter();
    await _registerAdapters();
  }

  Future<void> _registerAdapters() async {
    Hive.registerAdapter(UserModelAdapter()); //=>0
  }
}
