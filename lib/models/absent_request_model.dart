import 'package:json_annotation/json_annotation.dart';

part 'absent_request_model.g.dart';

@JsonSerializable()
class AbsentRequestModel {
  final DateTime absentDate;
  final String reason;
  final String userId;

  const AbsentRequestModel({
    required this.absentDate,
    required this.reason,
    required this.userId,
  });

  factory AbsentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AbsentRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$AbsentRequestModelToJson(this);
}
