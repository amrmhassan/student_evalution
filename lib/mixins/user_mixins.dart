import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_evaluation/models/user_model.dart';

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
}
