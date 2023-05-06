// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, sized_box_for_whitespace, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/screen_wrapper.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

class TestScreen extends StatefulWidget {
  static const String routeName = '/TestScreen';
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Providers.msgPf(context).createRoom(
              myId: 'myId',
              consumerId: 'consumerId',
            );
          },
          child: Text('Add'),
        ),
      ),
    );
  }
}
