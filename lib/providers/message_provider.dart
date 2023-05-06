// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:student_evaluation/models/message_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/transformers/models_fields.dart';
import 'package:uuid/uuid.dart';

import '../constants/global_constants.dart';

class MessageProvider extends ChangeNotifier {
  Iterable<UserModel> searchResult = [];
  bool searching = false;

  Future<void> searchUsers({
    required UserType myUserType,
    required String query,
  }) async {
    if (query.length < 2) {
      throw Exception('Search query is too short');
    }

    searching = true;
    notifyListeners();
    UserType counterUserType =
        myUserType == UserType.teacher ? UserType.student : UserType.teacher;
    var res = await FirebaseFirestore.instance
        .collection(DBCollections.users)
        .where(
          ModelsFields.userType,
          isEqualTo: counterUserType.name,
        )
        .get();
    searchResult = res.docs.map((e) => UserModel.fromJSON(e.data())).where(
        (element) =>
            element.name.toLowerCase().contains(query.toLowerCase()) ||
            element.email.toLowerCase().contains(query.toLowerCase()) ||
            element.uid.contains(query));
    searching = false;

    notifyListeners();
  }

  Future<String> createRoom({
    required String myId,
    required String consumerId,
  }) async {
    var res = await FirebaseDatabase.instance
        .ref(DBCollections.getRef([
          DBCollections.users,
          myId,
          DBCollections.rooms,
        ]))
        .get();
    for (var room in res.children) {
      var value = room.value;
      // if exists then return and never create a new one
      if (value == consumerId) return room.key!;
    }

    String roomId = Uuid().v4();

    // adding the room in my path
    await FirebaseDatabase.instance
        .ref(DBCollections.getRef([
          DBCollections.users,
          myId,
          DBCollections.rooms,
        ]))
        .child(roomId)
        .set(consumerId);

    // adding the room in the other user path
    await FirebaseDatabase.instance
        .ref(DBCollections.getRef([
          DBCollections.users,
          consumerId,
          DBCollections.rooms,
        ]))
        .child(roomId)
        .set(myId);
    await sendMessage(
      roomId: roomId,
      messageModel: firstServerMessage,
    );

    // creating a room path to watch messages

    return roomId;
  }

  Future<String> sendMessage({
    required String roomId,
    required MessageModel messageModel,
  }) async {
    var res = FirebaseDatabase.instance
        .ref(DBCollections.getRef([DBCollections.rooms]))
        .child(roomId)
        .child(DBCollections.messages)
        .push();
    await res.set(messageModel.toJSON());
    return res.key!;
  }
}
