// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/round_checkbox.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../messages_screen/widgets/user_avatar.dart';

class HomeWorkCard extends StatelessWidget {
  final UserModel userModel;

  const HomeWorkCard({
    super.key,
    required this.userModel,
  });

  void toggleAssigned(BuildContext context) {
    Providers.homeWPf(context).toggleAssign(userModel.uid);
  }

  @override
  Widget build(BuildContext context) {
    bool checked = Providers.homeWP(context).homeWorkAssigned(userModel.uid);
    return Container(
      margin: EdgeInsets.only(
        bottom: kVPad / 2,
      ),
      child: Row(
        children: [
          UserAvatar(
            userImage: userModel.userImage,
          ),
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
            checked: checked,
            onChange: () {
              toggleAssigned(context);
            },
          ),
        ],
      ),
    );
  }
}
