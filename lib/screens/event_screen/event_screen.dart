// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:intl/intl.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/absent_table_title.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/apply_attendance_button.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/attendance_card.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/choose_grade_section.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/reset_attendance_button.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

import '../home_screen/widgets/home_screen_appbar.dart';

class EventScreen extends StatelessWidget {
  static const String routeName = '/EventScreen';
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorTheme.kBlueColor.withOpacity(.5),
        flexibleSpace: HAppBarFlexibleArea(),
        foregroundColor: Colors.white,
        title: Text(
          'Event Yoga',
          style: h1TextStyle.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: colorTheme.kBlueColor,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                VSpace(factor: 4),
                Column(
                  children: [
                    VSpace(),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorTheme.backGround,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            largeBorderRadius,
                          ),
                          topRight: Radius.circular(
                            largeBorderRadius,
                          ),
                        ),
                      ),
                      child: PaddingWrapper(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            VSpace(),
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  mediumBorderRadius,
                                ),
                              ),
                              child: Image.network(
                                'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            VSpace(),
                            EventInfoItem(
                              title: 'Event Date',
                              value: DateFormat('dd/MM/yyyy | hh:mm aa').format(
                                DateTime.now(),
                              ),
                            ),
                            VSpace(),
                            EventInfoItem(
                              title: 'Place',
                              value: 'Yoga section in Maadi club',
                            ),
                            VSpace(),
                            Text(
                              'Details:',
                              style: h2TextStyle,
                            ),
                            Text(
                              lorem(paragraphs: 2, words: 100),
                            ),
                            VSpace(),
                            Text(
                              'Notes:',
                              style: h2TextStyle,
                            ),
                            Text(
                              lorem(paragraphs: 2, words: 20),
                            ),
                            VSpace(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EventInfoItem extends StatelessWidget {
  final String title;
  final String value;
  const EventInfoItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: h2TextStyle,
        ),
        Spacer(),
        Text(
          value,
          style: h3InactiveTextStyle,
        ),
      ],
    );
  }
}
