import 'package:student_evaluation/transformers/models_fields.dart';

class RoomModel {
  String? id;
  final String ownerId;
  final String consumerId;

  RoomModel({
    required this.consumerId,
    required this.id,
    required this.ownerId,
  });

  Map<String, dynamic> toJSON() {
    return {
      ModelsFields.id: id,
      ModelsFields.ownerUser: ownerId,
      ModelsFields.consumerUser: consumerId,
    };
  }
}
