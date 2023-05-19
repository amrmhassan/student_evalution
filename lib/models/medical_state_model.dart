import 'package:json_annotation/json_annotation.dart';

part 'medical_state_model.g.dart';

@JsonSerializable()
class MedicalStateModel {
  final String id;
  final String studentId;
  final String medicalName;
  final List<int> weekOfDay;
  final String notes;
  final String timeOfDay;

  const MedicalStateModel({
    required this.id,
    required this.studentId,
    required this.medicalName,
    required this.weekOfDay,
    required this.notes,
    required this.timeOfDay,
  });

  factory MedicalStateModel.fromJson(Map<String, dynamic> json) =>
      _$MedicalStateModelFromJson(json);
  Map<String, dynamic> toJson() => _$MedicalStateModelToJson(this);
}
