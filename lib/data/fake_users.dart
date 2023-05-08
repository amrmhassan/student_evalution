import 'package:student_evaluation/core/constants/global_constants.dart';
import 'package:student_evaluation/models/user_model.dart';

class FakeUsers {
  static const String password = 'aaaaa11111';
  static List<UserModel> fakeUsers = [
    AdminModel(
      email: 'admin@$emailSuffix',
      name: 'Admin',
      uid: 'kdjfklaj',
      userImage: null,
      mobileNumber: defaultMobileNumber,
    ),
    TeacherModel(
      email: 'teacher@$emailSuffix',
      name: 'Teacher 1',
      uid: ';lfkj',
      userImage: null,
      teacherClass: TeacherClass.biology,
      mobileNumber: defaultMobileNumber,
    ),
    StudentModel(
      email: 'student1@$emailSuffix',
      name: 'Student 1',
      uid: ';s;adjfal;',
      userImage: null,
      studentGrade: StudentGrade.k1SectionA,
      mobileNumber: defaultMobileNumber,
    ),
    StudentModel(
      email: 'student2@$emailSuffix',
      name: 'Student 2',
      uid: ';fadhfa',
      userImage: null,
      studentGrade: StudentGrade.k1SectionB,
      mobileNumber: defaultMobileNumber,
    ),
    StudentModel(
      email: 'student3@$emailSuffix',
      name: 'Student 3',
      uid: ';s;akdjfla;',
      userImage: null,
      studentGrade: StudentGrade.k2SectionA,
      mobileNumber: defaultMobileNumber,
    ),
    StudentModel(
      email: 'student4@$emailSuffix',
      name: 'Student 4',
      uid: ';adlkfj',
      userImage: null,
      studentGrade: StudentGrade.k2SectionB,
      mobileNumber: defaultMobileNumber,
    ),
  ];
}
