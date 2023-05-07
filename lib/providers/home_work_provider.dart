// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/transformers/remote_storage.dart';
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
}
