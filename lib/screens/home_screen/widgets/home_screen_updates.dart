// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_dashboard.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_table_card.dart';

import '../../../theming/constants/styles.dart';
import '../../../theming/theme_calls.dart';

class HomeScreenUpdates extends StatelessWidget {
  const HomeScreenUpdates({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeDashboard(),
        VSpace(),
        PaddingWrapper(
          child: HLine(
            color: colorTheme.inActiveText,
            thickness: .8,
          ),
        ),
        VSpace(),
        PaddingWrapper(
          child: Row(
            children: [
              Text(
                'Time Table',
                style: h2TextStyle,
              ),
              Spacer(),
              Text(
                'View All',
                style: h4TextStyleInactive.copyWith(
                  decoration: TextDecoration.underline,
                ),
              )
            ],
          ),
        ),
        VSpace(),
        // here is the time table items
        PaddingWrapper(
          child: Column(
            children: [
              TimeTableCard(
                title: 'Science Class',
                onTap: () {},
              ),
              TimeTableCard(
                title: 'Biology Class',
                onTap: () {},
              ),
              TimeTableCard(
                title: 'Maths Class',
                onTap: () {},
              ),
            ],
          ),
        ),

        VSpace(),
      ],
    );
  }
}
