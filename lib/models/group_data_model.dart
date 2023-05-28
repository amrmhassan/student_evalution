import 'package:student_evaluation/transformers/models_fields.dart';

class GroupDataModel {
  final String name;
  final String id;
  const GroupDataModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJSON() {
    return {
      ModelsFields.id: id,
      ModelsFields.name: name,
    };
  }

  static GroupDataModel fromJSON(Map<String, dynamic> obj) {
    return GroupDataModel(
      id: obj[ModelsFields.id],
      name: obj[ModelsFields.name],
    );
  }
}
