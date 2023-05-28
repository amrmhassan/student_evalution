// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/models/events_model.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/transformers/remote_storage.dart';
import 'package:uuid/uuid.dart';

class EventProvider extends ChangeNotifier {
  String? imageLink;
  TaskSnapshot? imageRef;

  DateTime date = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();

  void setDate(DateTime d) {
    date = d;
    notifyListeners();
  }

  void setTimeOfDay(TimeOfDay d) {
    timeOfDay = d;
    notifyListeners();
  }

  DateTime get getFullDate => DateTime(
        date.year,
        date.month,
        date.day,
        timeOfDay.hour,
        timeOfDay.minute,
      );

  final List<EventModel> _events = [];
  List<EventModel> get events => [..._events];
  bool loadingEvents = false;
  bool uploadingEventImage = false;
  bool uploadingEvent = false;

  Future<void> loadAllEvents() async {
    _events.clear();
    loadingEvents = true;
    notifyListeners();
    try {
      var res = (await FirebaseFirestore.instance
              .collection(DBCollections.events)
              .get())
          .docs;
      for (var doc in res) {
        EventModel eventModel = EventModel.fromJson(doc.data());
        _events.add(eventModel);
      }
      _events.sort((a, b) => a.date.compareTo(b.date));
      loadingEvents = false;
      notifyListeners();
    } catch (e) {
      loadingEvents = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<EventModel> addEvent({
    required String title,
    required String? imageLink,
    required DateTime date,
    required String place,
    required String details,
    required String notes,
    required String creatorId,
  }) async {
    uploadingEvent = true;
    notifyListeners();
    EventModel eventModel = EventModel(
      id: Uuid().v4(),
      title: title,
      imageLink: imageLink,
      date: date,
      place: place,
      details: details,
      notes: notes,
      creatorId: creatorId,
    );

    await FirebaseFirestore.instance
        .collection(DBCollections.events)
        .doc(eventModel.id)
        .set(eventModel.toJSON());

    _events.add(eventModel);
    uploadingEvent = false;

    notifyListeners();
    imageLink = null;
    imageRef = null;

    return eventModel;
  }

  Future<String> setEventImage(File file) async {
    uploadingEventImage = true;
    notifyListeners();
    var ref = await FirebaseStorage.instance
        .ref(RemoteStorage.eventsImages)
        .child(Uuid().v4())
        .putFile(file);
    imageRef = ref;
    String imageLink = await ref.ref.getDownloadURL();
    uploadingEventImage = false;
    this.imageLink = imageLink;
    notifyListeners();
    return imageLink;
  }

  Future<void> clearEventImage() async {
    imageLink = null;
    await imageRef?.ref.delete();
    imageRef = null;
    notifyListeners();
  }
}
