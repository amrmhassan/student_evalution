// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/round_checkbox.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';

import '../../messages_screen/widgets/user_avatar.dart';

class AttendanceCard extends StatelessWidget {
  final String name;
  final bool present;
  final Function(bool present) onChange;

  const AttendanceCard({
    super.key,
    required this.name,
    required this.present,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: kVPad / 2,
      ),
      child: Row(
        children: [
          UserAvatar(),
          HSpace(factor: .5),
          Text(
            name,
            style: h3InactiveTextStyle.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
          Spacer(),
          // this is present box
          RoundCheckBox(
            checked: present,
            onChange: () {
              onChange(true);
            },
          ),
          HSpace(factor: 2),
          // this is absent box
          RoundCheckBox(
            checked: !present,
            onChange: () {
              onChange(false);
            },
          ),
        ],
      ),
    );
  }
}
