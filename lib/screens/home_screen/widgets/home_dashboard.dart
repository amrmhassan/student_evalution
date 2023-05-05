// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/screens/attendance_screen/attendance_screen.dart';
import 'package:student_evaluation/screens/behavior_screen/behavior_screen.dart';
import 'package:student_evaluation/screens/home_screen/widgets/dash_board_item.dart';
import 'package:student_evaluation/screens/home_work_screen/home_work_screen.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:intl/intl.dart' as intl;

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DashboardItem(
                title: 'Attendance',
                iconName: 'attendance',
                onTap: () {
                  CNav.pushNamed(context, AttendanceScreen.routeName);
                },
              ),
              DashboardItem(
                title: 'Home Works',
                iconName: 'home_work',
                onTap: () {
                  CNav.pushNamed(context, HomeWorkScreen.routeName);
                },
              ),
              DashboardItem(
                title: 'Behavior',
                iconName: 'behaviour',
                onTap: () {
                  CNav.pushNamed(context, BehaviorScreen.routeName);
                },
              ),
            ],
          ),
          VSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DashboardItem(
                title: 'Time Table',
                iconName: 'time_table',
                onTap: () {},
              ),
              DashboardItem(
                title: 'Messages',
                iconName: 'messages',
                onTap: () {},
              ),
              Opacity(
                opacity: 0,
                child: DashboardItem(
                  title: 'Messages',
                  iconName: 'messages',
                  onTap: null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
