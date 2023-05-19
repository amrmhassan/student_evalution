// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalStateModel _$MedicalStateModelFromJson(Map<String, dynamic> json) =>
    MedicalStateModel(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      medicalName: json['medicalName'] as String,
      weekOfDay:
          (json['weekOfDay'] as List<dynamic>).map((e) => e as int).toList(),
      notes: json['notes'] as String,
    );

Map<String, dynamic> _$MedicalStateModelToJson(MedicalStateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'medicalName': instance.medicalName,
      'weekOfDay': instance.weekOfDay,
      'notes': instance.notes,
    };
