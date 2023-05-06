// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentModelAdapter extends TypeAdapter<StudentModel> {
  @override
  final int typeId = 4;

  @override
  StudentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentModel(
      email: fields[1] as String,
      name: fields[2] as String,
      uid: fields[0] as String,
      userImage: fields[3] as String?,
      studentGrade: fields[5] as StudentGrade,
    );
  }

  @override
  void write(BinaryWriter writer, StudentModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(5)
      ..write(obj.studentGrade)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.userImage)
      ..writeByte(4)
      ..write(obj.userType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TeacherModelAdapter extends TypeAdapter<TeacherModel> {
  @override
  final int typeId = 5;

  @override
  TeacherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeacherModel(
      email: fields[1] as String,
      name: fields[2] as String,
      uid: fields[0] as String,
      userImage: fields[3] as String?,
      teacherClass: fields[5] as TeacherClass,
    );
  }

  @override
  void write(BinaryWriter writer, TeacherModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(5)
      ..write(obj.teacherClass)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.userImage)
      ..writeByte(4)
      ..write(obj.userType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AdminModelAdapter extends TypeAdapter<AdminModel> {
  @override
  final int typeId = 6;

  @override
  AdminModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdminModel(
      email: fields[1] as String,
      name: fields[2] as String,
      uid: fields[0] as String,
      userImage: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AdminModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.userImage)
      ..writeByte(4)
      ..write(obj.userType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserTypeAdapter extends TypeAdapter<UserType> {
  @override
  final int typeId = 1;

  @override
  UserType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UserType.admin;
      case 1:
        return UserType.teacher;
      case 2:
        return UserType.student;
      default:
        return UserType.admin;
    }
  }

  @override
  void write(BinaryWriter writer, UserType obj) {
    switch (obj) {
      case UserType.admin:
        writer.writeByte(0);
        break;
      case UserType.teacher:
        writer.writeByte(1);
        break;
      case UserType.student:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StudentGradeAdapter extends TypeAdapter<StudentGrade> {
  @override
  final int typeId = 2;

  @override
  StudentGrade read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return StudentGrade.k1SectionA;
      case 1:
        return StudentGrade.k1SectionB;
      case 2:
        return StudentGrade.k2SectionA;
      case 3:
        return StudentGrade.k2SectionB;
      default:
        return StudentGrade.k1SectionA;
    }
  }

  @override
  void write(BinaryWriter writer, StudentGrade obj) {
    switch (obj) {
      case StudentGrade.k1SectionA:
        writer.writeByte(0);
        break;
      case StudentGrade.k1SectionB:
        writer.writeByte(1);
        break;
      case StudentGrade.k2SectionA:
        writer.writeByte(2);
        break;
      case StudentGrade.k2SectionB:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentGradeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TeacherClassAdapter extends TypeAdapter<TeacherClass> {
  @override
  final int typeId = 3;

  @override
  TeacherClass read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TeacherClass.science;
      case 1:
        return TeacherClass.math;
      case 2:
        return TeacherClass.biology;
      default:
        return TeacherClass.science;
    }
  }

  @override
  void write(BinaryWriter writer, TeacherClass obj) {
    switch (obj) {
      case TeacherClass.science:
        writer.writeByte(0);
        break;
      case TeacherClass.math:
        writer.writeByte(1);
        break;
      case TeacherClass.biology:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
