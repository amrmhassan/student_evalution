// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/models/home_work_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/transformers/remote_storage.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:uuid/uuid.dart';

import '../transformers/collections.dart';
import '../transformers/models_fields.dart';
import 'package:path/path.dart' as path_utils;

class HomeWorkProvider extends ChangeNotifier {
  bool loadingUsers = false;
  bool sendingHomeWork = false;
  //? document  info
  bool uploadingDocument = false;
  String? documentName;
  int? documentSize;
  String? documentLink;
  TaskSnapshot? taskSnapshot;

  //? other home work info
  StudentGrade activeGrade = StudentGrade.k1SectionA;
  String? description;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(
    Duration(
      days: 2,
    ),
  );
  List<String> assignedUsersIDs = [];
  List<UserModel> gradeUsers = [];

  void setStartDate(DateTime d) {
    startDate = d;
    notifyListeners();
  }

  void setEndDate(DateTime d) {
    endDate = d;
    notifyListeners();
  }

  void setDocumentLink(String link) {
    documentLink = link;
    notifyListeners();
  }

  void setDescription(String d) {
    description = d;
    notifyListeners();
  }

  void setActiveGrade(StudentGrade g) {
    activeGrade = g;
    notifyListeners();
  }

  bool homeWorkAssigned(String userID) {
    return assignedUsersIDs.any((element) => element == userID);
  }

  void toggleAssign(String userID) {
    bool assigned = homeWorkAssigned(userID);
    if (assigned) {
      assignedUsersIDs.remove(userID);
    } else {
      assignedUsersIDs.add(userID);
    }
    notifyListeners();
  }

  Future<void> loadUserGrades() async {
    loadingUsers = true;
    gradeUsers.clear();
    assignedUsersIDs.clear();
    notifyListeners();
    var docs = (await FirebaseFirestore.instance
            .collection(DBCollections.users)
            .where(
              ModelsFields.studentGrade,
              isEqualTo: activeGrade.name,
            )
            .get())
        .docs;
    for (var user in docs) {
      UserModel u = UserModel.fromJSON(user.data());
      gradeUsers.add(u);
    }
    loadingUsers = false;
    notifyListeners();
  }

  Future<void> uploadDocument(File file) async {
    try {
      if (taskSnapshot != null) {
        await taskSnapshot!.ref.delete();
        taskSnapshot = null;
      }
      String docID = Uuid().v4();
      uploadingDocument = true;
      notifyListeners();
      var res = await FirebaseStorage.instance
          .ref(RemoteStorage.homeWorkDocuments)
          .child(docID)
          .putFile(file);

      documentLink = await res.ref.getDownloadURL();
      documentName = path_utils.basename(file.path);
      taskSnapshot = res;
      uploadingDocument = false;
      notifyListeners();
    } catch (e) {
      uploadingDocument = false;
      clearUploadedDoc();
      rethrow;
    }
  }

  void clearUploadedDoc() async {
    await taskSnapshot?.ref.delete();
    documentLink = null;
    documentName = null;
    taskSnapshot = null;
    notifyListeners();
  }

  Future<void> sendHomeWork(TeacherClass teacherClass) async {
    sendingHomeWork = true;
    notifyListeners();
    try {
      String id = Uuid().v4();
      if (endDate.isBefore(startDate)) {
        throw Exception('Start date is after end data');
      }
      if (assignedUsersIDs.isEmpty) {
        throw Exception('Please assign the home work to at least one student');
      }
      if (documentLink == null && description == null) {
        throw Exception('Please set either a description or a document');
      }
      HomeWorkModel homeWorkModel = HomeWorkModel(
        id: id,
        day: GlobalUtils.dateToString(DateTime.now()),
        studentGrade: activeGrade,
        teacherClass: teacherClass,
        documentLink: documentLink,
        description: description,
        startDate: GlobalUtils.dateToString(startDate),
        endDate: GlobalUtils.dateToString(endDate),
        usersIds: assignedUsersIDs,
      );
      await FirebaseDatabase.instance
          .ref(DBCollections.homeWorks)
          .child(activeGrade.name)
          .child(id)
          .set(homeWorkModel.toJSON());
      assignedUsersIDs.clear();
      gradeUsers.clear();
      sendingHomeWork = false;
      documentLink = null;
      documentName = null;
      taskSnapshot = null;
      notifyListeners();
    } catch (e) {
      sendingHomeWork = false;
      notifyListeners();
      rethrow;
    }
  }
}
