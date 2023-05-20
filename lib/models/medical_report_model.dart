import 'package:json_annotation/json_annotation.dart';

part 'medical_report_model.g.dart';

@JsonSerializable()
class MedicalReportModel {
  final String name;
  final String? imageLink;
  final String notes;
  final String monthWeek;
  final String createdAt;
  final String studentId;

  const MedicalReportModel({
    required this.name,
    required this.imageLink,
    required this.notes,
    required this.monthWeek,
    required this.createdAt,
    required this.studentId,
  });
  factory MedicalReportModel.fromJson(Map<String, dynamic> json) =>
      _$MedicalReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$MedicalReportModelToJson(this);
}
