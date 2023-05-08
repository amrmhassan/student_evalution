import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:student_evaluation/transformers/models_fields.dart';

class EventModel {
  final String id;
  final String title;
  final String? imageLink;
  final DateTime date;
  final String place;
  final String details;
  final String notes;
  final String creatorId;

  const EventModel({
    required this.id,
    required this.title,
    required this.imageLink,
    required this.date,
    required this.place,
    required this.details,
    required this.notes,
    required this.creatorId,
  });
  String get subTitle => DateFormat('MMM dd HH:mm').format(date);

  Map<String, dynamic> toJSON() {
    return {
      ModelsFields.id: id,
      ModelsFields.title: title,
      ModelsFields.imageLink: imageLink,
      ModelsFields.date: date,
      ModelsFields.place: place,
      ModelsFields.details: details,
      ModelsFields.notes: notes,
      ModelsFields.creatorId: creatorId,
    };
  }

  static EventModel fromJson(Map<String, dynamic> obj) {
    return EventModel(
      id: obj[ModelsFields.id],
      title: obj[ModelsFields.title],
      imageLink: obj[ModelsFields.imageLink],
      date: (obj[ModelsFields.date] as Timestamp).toDate(),
      place: obj[ModelsFields.place],
      details: obj[ModelsFields.details],
      notes: obj[ModelsFields.notes],
      creatorId: obj[ModelsFields.creatorId],
    );
  }
}
