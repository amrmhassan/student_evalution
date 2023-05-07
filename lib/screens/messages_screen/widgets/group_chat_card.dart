// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/group_data_model.dart';
import 'package:student_evaluation/screens/chat_screen/chat_screen.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/small_vertical_dash.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/user_avatar.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

class GroupChatCard extends StatelessWidget {
  final GroupDataModel groupDataModel;
  const GroupChatCard({
    super.key,
    required this.groupDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: () {
        CNav.pushNamed(context, ChatScreen.routeName);
      },
      child: PaddingWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            VSpace(factor: .4),
            Row(
              children: [
                UserAvatar(
                  userImage: null,
                ),
                HSpace(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupDataModel.name,
                      style: h2TextStyle,
                    ),
                    // Text(
                    //   'F: Jane Cooper | 6th 8',
                    //   style: h4TextStyleInactive,
                    // ),
                  ],
                ),
                Spacer(),
                SmallVerticalDash(),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/icons/message2.png',
                    color: colorTheme.kBlueColor,
                    width: mediumIconSize,
                  ),
                ),
                SmallVerticalDash(),
              ],
            ),
            VSpace(factor: .4),
            HLine(
              thickness: .4,
              color: colorTheme.inActiveText.withOpacity(
                .5,
              ),
            ),
            VSpace(factor: .4),
          ],
        ),
      ),
    );
  }
}
