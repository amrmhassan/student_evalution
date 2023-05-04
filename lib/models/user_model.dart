import 'package:hive_flutter/hive_flutter.dart';

import '../transformers/models_fields.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String? accessToken;
  @HiveField(4)
  final String provider;
  @HiveField(5)
  final String? providerId;

  const UserModel({
    required this.email,
    required this.name,
    required this.uid,
    required this.accessToken,
    required this.provider,
    required this.providerId,
  });

  static UserModel fromJSON(Map<String, dynamic> obj) {
    return UserModel(
      email: obj[ModelsFields.email],
      name: obj[ModelsFields.name],
      uid: obj[ModelsFields.uid],
      accessToken: obj[ModelsFields.accessToken],
      provider: obj[ModelsFields.provider],
      providerId: obj[ModelsFields.providerId],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      ModelsFields.email: email,
      ModelsFields.uid: uid,
      ModelsFields.name: name,
      ModelsFields.accessToken: accessToken,
      ModelsFields.provider: provider,
      ModelsFields.providerId: providerId,
    };
  }
}
