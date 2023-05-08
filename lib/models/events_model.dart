import 'package:intl/intl.dart';

class EventModel {
  final String title;
  final String? imageLink;
  final DateTime date;
  final String place;
  final String details;
  final String notes;

  const EventModel({
    required this.title,
    required this.imageLink,
    required this.date,
    required this.place,
    required this.details,
    required this.notes,
  });
  String get subTitle => DateFormat('MMM dd HH:mm').format(date);
}
