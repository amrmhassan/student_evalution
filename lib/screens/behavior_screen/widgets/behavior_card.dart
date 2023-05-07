// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/round_checkbox.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';

import '../../../models/behavior_model.dart';
import '../../../utils/providers_calls.dart';
import '../../messages_screen/widgets/user_avatar.dart';

class BehaviorCard extends StatelessWidget {
  final UserModel userModel;
  final Function(BehaviorState state) onChange;

  const BehaviorCard({
    super.key,
    required this.userModel,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    var behaveProvider = Providers.behaveP(context);
    var attendModel =
        behaveProvider.getBehaviourModelByUserId(userId: userModel.uid);
    BehaviorState? state = attendModel?.state;

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
            checked: state == BehaviorState.active,
            onChange: () {
              onChange(BehaviorState.active);
            },
          ),
          HSpace(factor: 2),
          // this is absent box
          RoundCheckBox(
            checked: state == BehaviorState.normal,
            onChange: () {
              onChange(BehaviorState.normal);
            },
          ),
          HSpace(factor: 2),
          // this is absent box
          RoundCheckBox(
            checked: state == BehaviorState.worry,
            onChange: () {
              onChange(BehaviorState.worry);
            },
          ),
        ],
      ),
    );
  }
}
