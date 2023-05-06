import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_evaluation/utils/global_utils.dart';

import '../transformers/models_fields.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
enum UserType {
  @HiveField(0)
  admin,
  @HiveField(1)
  teacher,
  @HiveField(2)
  student,
}

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String? userImage;
  @HiveField(4)
  final UserType userType;

  const UserModel({
    required this.email,
    required this.name,
    required this.uid,
    required this.userImage,
    required this.userType,
  });

  static UserModel fromJSON(Map<String, dynamic> obj) {
    return UserModel(
      email: obj[ModelsFields.email],
      name: obj[ModelsFields.name],
      uid: obj[ModelsFields.uid],
      userImage: obj[ModelsFields.userImage],
      userType: GlobalUtils.stringToEnum(
        obj[ModelsFields.userType],
        UserType.values,
      ),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      ModelsFields.email: email,
      ModelsFields.uid: uid,
      ModelsFields.name: name,
      ModelsFields.userImage: userImage,
      ModelsFields.userType: userType.name,
    };
  }
}
