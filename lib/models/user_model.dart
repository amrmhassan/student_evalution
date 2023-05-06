import 'package:hive_flutter/hive_flutter.dart';

import '../transformers/models_fields.dart';
import '../utils/global_utils.dart';

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

@HiveType(typeId: 2)
enum StudentGrade {
  @HiveField(0)
  k1SectionA,
  @HiveField(1)
  k1SectionB,
  @HiveField(2)
  k2SectionA,
  @HiveField(3)
  k2SectionB,
}

@HiveType(typeId: 3)
enum TeacherClass {
  @HiveField(0)
  science,
  @HiveField(1)
  math,
  @HiveField(2)
  biology,
}

// @HiveType(typeId: 0)
abstract class UserModel {
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

  Map<String, dynamic> toJSON();

  static UserModel fromJSON(Map<String, dynamic> obj) {
    UserType userType = GlobalUtils.stringToEnum(
      obj[ModelsFields.userType],
      UserType.values,
    );
    if (userType == UserType.admin) {
      return AdminModel.fromJSON(obj);
    } else if (userType == UserType.teacher) {
      return TeacherModel.fromJSON(obj);
    } else {
      return StudentModel.fromJSON(obj);
    }
  }
}

@HiveType(typeId: 4)
class StudentModel extends UserModel {
  @HiveField(5)
  final StudentGrade studentGrade;
  StudentModel({
    required String email,
    required String name,
    required String uid,
    required String? userImage,
    required this.studentGrade,
  }) : super(
          email: email,
          name: name,
          uid: uid,
          userImage: userImage,
          userType: UserType.student,
        );

  @override
  Map<String, dynamic> toJSON() {
    return {
      ModelsFields.email: email,
      ModelsFields.uid: uid,
      ModelsFields.name: name,
      ModelsFields.userImage: userImage,
      ModelsFields.userType: userType.name,
      ModelsFields.studentGrade: studentGrade.name,
    };
  }

  static StudentModel fromJSON(Map<String, dynamic> obj) {
    return StudentModel(
      email: obj[ModelsFields.email],
      name: obj[ModelsFields.name],
      uid: obj[ModelsFields.uid],
      userImage: obj[ModelsFields.userImage],
      studentGrade: GlobalUtils.stringToEnum(
        obj[ModelsFields.studentGrade],
        StudentGrade.values,
      ),
    );
  }
}

@HiveType(typeId: 5)
class TeacherModel extends UserModel {
  @HiveField(5)
  final TeacherClass teacherClass;
  TeacherModel({
    required String email,
    required String name,
    required String uid,
    required String? userImage,
    required this.teacherClass,
  }) : super(
          email: email,
          name: name,
          uid: uid,
          userImage: userImage,
          userType: UserType.teacher,
        );

  @override
  Map<String, dynamic> toJSON() {
    return {
      ModelsFields.email: email,
      ModelsFields.uid: uid,
      ModelsFields.name: name,
      ModelsFields.userImage: userImage,
      ModelsFields.userType: userType.name,
      ModelsFields.teacherClass: teacherClass.name,
    };
  }

  static TeacherModel fromJSON(Map<String, dynamic> obj) {
    return TeacherModel(
      email: obj[ModelsFields.email],
      name: obj[ModelsFields.name],
      uid: obj[ModelsFields.uid],
      userImage: obj[ModelsFields.userImage],
      teacherClass: GlobalUtils.stringToEnum(
        obj[ModelsFields.teacherClass],
        TeacherClass.values,
      ),
    );
  }
}

@HiveType(typeId: 6)
class AdminModel extends UserModel {
  AdminModel({
    required String email,
    required String name,
    required String uid,
    required String? userImage,
  }) : super(
          email: email,
          name: name,
          uid: uid,
          userImage: userImage,
          userType: UserType.admin,
        );

  @override
  Map<String, dynamic> toJSON() {
    return {
      ModelsFields.email: email,
      ModelsFields.uid: uid,
      ModelsFields.name: name,
      ModelsFields.userImage: userImage,
      ModelsFields.userType: userType.name,
    };
  }

  static AdminModel fromJSON(Map<String, dynamic> obj) {
    return AdminModel(
      email: obj[ModelsFields.email],
      name: obj[ModelsFields.name],
      uid: obj[ModelsFields.uid],
      userImage: obj[ModelsFields.userImage],
    );
  }
}
