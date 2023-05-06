// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/models/attendance_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/round_checkbox.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../messages_screen/widgets/user_avatar.dart';

class AttendanceCard extends StatelessWidget {
  final UserModel userModel;
  final Function(bool present) onChange;

  const AttendanceCard({
    super.key,
    required this.userModel,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    var attendProvider = Providers.attendP(context);
    var attendModel =
        attendProvider.getAttendanceModelByUserId(userId: userModel.uid);
    AttendanceState state = attendModel?.state ?? AttendanceState.absent;

    return Container(
      margin: EdgeInsets.only(
        bottom: kVPad / 2,
      ),
      child: Row(
        children: [
          UserAvatar(userImage: userModel.userImage),
          HSpace(factor: .5),
          Text(
            userModel.name,
            style: h3InactiveTextStyle.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
          Spacer(),
          // this is present box
          RoundCheckBox(
            checked: state == AttendanceState.present,
            onChange: () {
              onChange(true);
            },
          ),
          HSpace(factor: 2),
          // this is absent box
          RoundCheckBox(
            checked: state == AttendanceState.absent,
            onChange: () {
              onChange(false);
            },
          ),
        ],
      ),
    );
  }
}
