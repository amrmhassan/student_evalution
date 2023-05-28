// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalReportModel _$MedicalReportModelFromJson(Map<String, dynamic> json) =>
    MedicalReportModel(
      name: json['name'] as String,
      imageLink: json['imageLink'] as String?,
      notes: json['notes'] as String,
      monthWeek: json['monthWeek'] as String,
      createdAt: json['createdAt'] as String,
      studentId: json['studentId'] as String,
    );

Map<String, dynamic> _$MedicalReportModelToJson(MedicalReportModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imageLink': instance.imageLink,
      'notes': instance.notes,
      'monthWeek': instance.monthWeek,
      'createdAt': instance.createdAt,
      'studentId': instance.studentId,
    };
