import 'package:student_evaluation/utils/global_utils.dart';

import '../transformers/models_fields.dart';

// part 'user_model.g.dart';

enum UserType {
  admin,
  teacher,
  student,
}

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String? userImage;
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
