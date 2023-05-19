// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absent_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsentRequestModel _$AbsentRequestModelFromJson(Map<String, dynamic> json) =>
    AbsentRequestModel(
      absentDate: DateTime.parse(json['absentDate'] as String),
      reason: json['reason'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$AbsentRequestModelToJson(AbsentRequestModel instance) =>
    <String, dynamic>{
      'absentDate': instance.absentDate.toIso8601String(),
      'reason': instance.reason,
      'userId': instance.userId,
    };
