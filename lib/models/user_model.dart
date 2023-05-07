import 'package:hive_flutter/hive_flutter.dart';

import '../transformers/models_fields.dart';
import '../utils/global_utils.dart';

part 'user_model.g.dart';

String defaultMobileNumber = '011********';
//! add address
//! add phone

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
  @HiveField(4)
  seniorSectionA,
  @HiveField(5)
  seniorSectionB,
  @HiveField(6)
  juniorSectionA,
  @HiveField(7)
  juniorSectionB,
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
  @HiveField(5)
  final String mobileNumber;

  const UserModel({
    required this.email,
    required this.name,
    required this.uid,
    required this.userImage,
    required this.userType,
    required this.mobileNumber,
  });

  Map<String, dynamic> toJSON();

  static UserModel fromJSON(Map<String, dynamic> obj) {
    UserType userType = GlobalUtils.stringToEnum(
      obj[ModelsFields.userType],
      UserType.values,
    );
    if (userType == UserType.admin) {
      return AdminModel._fromJSON(obj);
    } else if (userType == UserType.teacher) {
      return TeacherModel._fromJSON(obj);
    } else {
      return StudentModel._fromJSON(obj);
    }
  }

  static UserModel fromEntries({
    required String uid,
    required String email,
    required String name,
    required UserType userType,
    required TeacherClass teacherClass,
    required StudentGrade studentGrade,
    required String? userImage,
    required String mobileNumber,
  }) {
    if (userType == UserType.admin) {
      return AdminModel(
        email: email,
        name: name,
        uid: uid,
        userImage: userImage,
        mobileNumber: mobileNumber,
      );
    } else if (userType == UserType.teacher) {
      return TeacherModel(
        email: email,
        name: name,
        uid: uid,
        userImage: userImage,
        teacherClass: teacherClass,
        mobileNumber: mobileNumber,
      );
    } else {
      return StudentModel(
        email: email,
        name: name,
        uid: uid,
        userImage: userImage,
        studentGrade: studentGrade,
        mobileNumber: mobileNumber,
      );
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
    required String mobileNumber,
    required String? userImage,
    required this.studentGrade,
  }) : super(
          email: email,
          name: name,
          uid: uid,
          userImage: userImage,
          userType: UserType.student,
          mobileNumber: mobileNumber,
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

  static StudentModel _fromJSON(Map<String, dynamic> obj) {
    return StudentModel(
      email: obj[ModelsFields.email],
      name: obj[ModelsFields.name],
      uid: obj[ModelsFields.uid],
      userImage: obj[ModelsFields.userImage],
      studentGrade: GlobalUtils.stringToEnum(
        obj[ModelsFields.studentGrade],
        StudentGrade.values,
      ),
      mobileNumber: obj[ModelsFields.mobileNumber] ?? defaultMobileNumber,
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
    required String mobileNumber,
  }) : super(
          email: email,
          name: name,
          uid: uid,
          userImage: userImage,
          userType: UserType.teacher,
          mobileNumber: mobileNumber,
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

  static TeacherModel _fromJSON(Map<String, dynamic> obj) {
    return TeacherModel(
      email: obj[ModelsFields.email],
      name: obj[ModelsFields.name],
      uid: obj[ModelsFields.uid],
      userImage: obj[ModelsFields.userImage],
      teacherClass: GlobalUtils.stringToEnum(
        obj[ModelsFields.teacherClass],
        TeacherClass.values,
      ),
      mobileNumber: obj[ModelsFields.mobileNumber] ?? defaultMobileNumber,
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
    required String mobileNumber,
  }) : super(
          email: email,
          name: name,
          uid: uid,
          userImage: userImage,
          userType: UserType.admin,
          mobileNumber: mobileNumber,
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

  static AdminModel _fromJSON(Map<String, dynamic> obj) {
    return AdminModel(
      email: obj[ModelsFields.email],
      name: obj[ModelsFields.name],
      uid: obj[ModelsFields.uid],
      userImage: obj[ModelsFields.userImage],
      mobileNumber: obj[ModelsFields.mobileNumber] ?? defaultMobileNumber,
    );
  }
}
