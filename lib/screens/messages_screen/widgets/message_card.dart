// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/chat_screen/chat_screen.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/small_vertical_dash.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/user_avatar.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../theming/constants/sizes.dart';

class IndividualChatCard extends StatefulWidget {
  final String roomID;
  const IndividualChatCard({
    super.key,
    required this.roomID,
  });

  @override
  State<IndividualChatCard> createState() => _IndividualChatCardState();
}

class _IndividualChatCardState extends State<IndividualChatCard> {
  bool loading = true;
  UserModel? userModel;

  void loadUserModel() {
    Future.delayed(Duration.zero).then((value) async {
      String myId = Providers.userPf(context).userModel!.uid;
      UserModel model = await Providers.msgPf(context)
          .getUserModelFromRoom(myId: myId, roomId: widget.roomID);
      setState(() {
        userModel = model;

        loading = false;
      });
    });
  }

  @override
  void initState() {
    loadUserModel();
    super.initState();
  }

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
                  userImage: userModel?.userImage,
                ),
                HSpace(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userModel?.name ?? '...',
                      style: h2TextStyle,
                    ),
                    Text(
                      'F: Jane Cooper | 6th 8',
                      style: h4TextStyleInactive,
                    ),
                  ],
                ),
                Spacer(),
                SmallVerticalDash(),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/icons/phone.png',
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
