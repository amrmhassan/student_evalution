// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/data/fake_events.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_table_card.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

import '../../../core/navigation.dart';
import '../../event_screen/event_screen.dart';

class HomeScreenEvents extends StatelessWidget {
  const HomeScreenEvents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Events on June 14, 2022',
                style: h2TextStyle,
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/icons/add.png',
                  width: largeIconSize,
                  color: colorTheme.inActiveText,
                ),
              ),
            ],
          ),
          // VSpace(factor: .4),
          ...FakeEvents.events.map(
            (e) => TimeTableCard(
              title: e.title,
              subTitle: e.subTitle,
              imageLink: e.imageLink,
              onTap: () {
                CNav.pushNamed(
                  context,
                  EventScreen.routeName,
                  arguments: e,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
