import 'package:student_evaluation/models/user_model.dart';
import 'package:hive/hive.dart';

part 'saved_accounts_model.g.dart';

@HiveType(typeId: 7)
class SavedAccountModel {
  @HiveField(0)
  final UserModel userModel;
  @HiveField(1)
  final String password;

  const SavedAccountModel({
    required this.userModel,
    required this.password,
  });
}
