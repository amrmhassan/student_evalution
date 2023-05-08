import 'dart:math';

import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:student_evaluation/models/events_model.dart';

class FakeEvents {
  static List<EventModel> events = [
    ...List.generate(
      Random().nextInt(10) + 1,
      (index) => EventModel(
        creatorId: 'dlskfjl',
        id: 'dkjfakl;',
        title: lorem(paragraphs: 1, words: 7),
        imageLink: Random().nextBool() ? 'https://picsum.photos/200/200' : null,
        date: DateTime.now().add(
          Duration(
            days: Random().nextInt(100),
            minutes: Random().nextInt(10000),
          ),
        ),
        place: lorem(paragraphs: 1, words: 10),
        details: lorem(paragraphs: 3, words: 50),
        notes: lorem(paragraphs: 1, words: 20),
      ),
    ),
  ];
}
