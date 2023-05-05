// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/round_checkbox.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';

import '../../messages_screen/widgets/user_avatar.dart';

enum BehaviorState {
  active,
  normal,
  worry,
}

class BehaviorCard extends StatelessWidget {
  final String name;
  final BehaviorState behaviorState;
  final Function(BehaviorState state) onChange;

  const BehaviorCard({
    super.key,
    required this.name,
    required this.behaviorState,
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
            checked: behaviorState == BehaviorState.active,
            onChange: () {
              onChange(BehaviorState.active);
            },
          ),
          HSpace(factor: 2),
          // this is absent box
          RoundCheckBox(
            checked: behaviorState == BehaviorState.normal,
            onChange: () {
              onChange(BehaviorState.normal);
            },
          ),
          HSpace(factor: 2),
          // this is absent box
          RoundCheckBox(
            checked: behaviorState == BehaviorState.worry,
            onChange: () {
              onChange(BehaviorState.worry);
            },
          ),
        ],
      ),
    );
  }
}
