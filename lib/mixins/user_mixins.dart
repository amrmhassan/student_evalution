import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/transformers/models_fields.dart';

import '../transformers/collections.dart';

mixin UserMixin {
  Future<UserModel> getUserModelById(String uid) async {
    var data = (await FirebaseFirestore.instance
            .collection(DBCollections.users)
            .doc(uid)
            .get())
        .data();
    return UserModel.fromJSON(data!);
  }

  Future<UserModel> getUserModelByEmail(String email) async {
    var data = (await FirebaseFirestore.instance
            .collection(DBCollections.users)
            .where(ModelsFields.email, isEqualTo: email)
            .get())
        .docs
        .first
        .data();
    return UserModel.fromJSON(data);
  }
}
