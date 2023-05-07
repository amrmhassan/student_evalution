// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:student_evaluation/mixins/user_mixins.dart';
import 'package:student_evaluation/models/message_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/transformers/models_fields.dart';
import 'package:uuid/uuid.dart';

import '../constants/global_constants.dart';
import '../init/runtime_variables.dart';
import '../transformers/enums_transformers.dart';

class MessageProvider extends ChangeNotifier with UserMixin {
  //# messages stuff
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

  // returns the created room id (created or existing)
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
    DateTime creatingTime = DateTime.now();

    // adding the room in my path
    await FirebaseDatabase.instance
        .ref(DBCollections.getRef([
          DBCollections.users,
          myId,
          DBCollections.rooms,
        ]))
        .child(roomId)
        .child(DBCollections.otherUser)
        .set(consumerId);

    // adding the room in the other user path
    await FirebaseDatabase.instance
        .ref(DBCollections.getRef([
          DBCollections.users,
          consumerId,
          DBCollections.rooms,
        ]))
        .child(roomId)
        .child(DBCollections.otherUser)
        .set(myId);
    // creating time for the consumer user
    await FirebaseDatabase.instance
        .ref(DBCollections.getRef([
          DBCollections.users,
          consumerId,
          DBCollections.rooms,
        ]))
        .child(roomId)
        .child(DBCollections.createdAt)
        .set(creatingTime.toIso8601String());
    // creating time for the creator user
    await FirebaseDatabase.instance
        .ref(DBCollections.getRef([
          DBCollections.users,
          myId,
          DBCollections.rooms,
        ]))
        .child(roomId)
        .child(DBCollections.createdAt)
        .set(creatingTime.toIso8601String());

    // add the users ids to the room
    await FirebaseDatabase.instance
        .ref(DBCollections.getRef([DBCollections.rooms]))
        .child(roomId)
        .child(DBCollections.users)
        .set([myId, consumerId]);

    // add the creation time to the room
    await FirebaseDatabase.instance
        .ref(DBCollections.getRef([DBCollections.rooms]))
        .child(roomId)
        .child(DBCollections.createdAt)
        .set(creatingTime.toIso8601String());

    await sendMessage(
      roomId: roomId,
      content: firstServerMessage.content,
      messageType: firstServerMessage.messageType,
      receiverId: firstServerMessage.receiverID,
      senderId: firstServerMessage.senderID,
    );

    // creating a room path to watch messages

    return roomId;
  }

  Future<String> sendMessage({
    required String roomId,
    required String senderId,
    required String receiverId,
    required String content,
    required MessageType messageType,
  }) async {
    String msgId = Uuid().v4();
    DateTime createdAt = DateTime.now();

    MessageModel messageModel = MessageModel(
      id: msgId,
      createdAt: createdAt,
      senderID: senderId,
      receiverID: receiverId,
      content: content,
      messageType: messageType,
    );
    var res = FirebaseDatabase.instance
        .ref(DBCollections.getRef([DBCollections.rooms]))
        .child(roomId)
        .child(DBCollections.messages)
        .push();
    await res.set(messageModel.toJSON());
    return res.key!;
  }

  Future<UserModel?> getUserModelFromRoom({
    required String myId,
    required String roomId,
  }) async {
    var res = await FirebaseDatabase.instance
        .ref(DBCollections.getRef(
            [DBCollections.rooms, roomId, DBCollections.users]))
        .get();
    var users = res.children.map((e) => e.value).toList();
    if (users.isEmpty) return null;
    String otherUserId =
        users.where((element) => element != myId).first.toString();
    UserModel userModel = await getUserModelById(otherUserId);
    return userModel;
  }

  //# groups stuff

  //? this will just run once after setting the enum TeacherClass values and  enum StudentGrade values to create
  //? the groups that will appear on students screen and teachers screen
  Future<void> createClassesGradesGroups() async {
    // i want to create a groups mapping for teachers like grade1, grade2, grade3
    // and groups for students like science, biology
    // and these groups will map to each other like
    for (var teacherClass in TeacherClass.values) {
      for (var studentGrade in StudentGrade.values) {
        String groupId = Uuid().v4();
        String teacherGroupName = gradeTransformer(studentGrade);
        String studentGroupName = classTransformer(teacherClass);

        // creating groups for the teachers, (teachers will listen for these groups of their students) this will appear on the teachers screen
        await FirebaseDatabase.instance
            .ref(DBCollections.groupsMaps)
            .child(DBCollections.teachersGroups)
            .child(teacherClass.name)
            .child(studentGrade.name)
            .set({'id': groupId, 'name': teacherGroupName});

        // creating groups for the students, (students will listen for these groups of their teachers) this will appear on the student screen
        await FirebaseDatabase.instance
            .ref(DBCollections.groupsMaps)
            .child(DBCollections.studentsGroups)
            .child(studentGrade.name)
            .child(teacherClass.name)
            .set({'id': groupId, 'name': studentGroupName});

        // then create the actual group with the first message
        await FirebaseDatabase.instance
            .ref(DBCollections.groups)
            .child(groupId)
            .child(DBCollections.messages)
            .push()
            .set(firstServerMessage.toJSON());
      }
    }
    logger.i('All Groups created');
  }
}
