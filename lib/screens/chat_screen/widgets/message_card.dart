// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/models/message_model.dart';
import 'package:student_evaluation/screens/chat_screen/widgets/server_msg.dart';
import 'package:student_evaluation/screens/messages_screen/messages_screen.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../fast_tools/helpers/responsive.dart';
import '../../../fast_tools/widgets/h_space.dart';
import '../../../theming/constants/sizes.dart';
import '../../../theming/constants/styles.dart';
import '../../../theming/theme_calls.dart';

class MessageCard extends StatelessWidget {
  final MessageModel messageModel;
  final MessagesMode mode;

  const MessageCard({
    super.key,
    required this.messageModel,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    var userProvider = Providers.userP(context);
    String myId = userProvider.userModel!.uid;
    bool mine = messageModel.senderID == myId;

    if (messageModel.messageType == MessageType.server) {
      return ServerMsg(messageModel: messageModel);
    }

    return Row(
      textDirection: mine ? TextDirection.rtl : null,
      children: [
        HSpace(),
        Container(
          margin: EdgeInsets.only(
            bottom: largePadding,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: kHPad,
            vertical: kVPad / 2,
          ),
          decoration: BoxDecoration(
            color: mine
                ? colorTheme.kBlueColor
                : colorTheme.kInactiveColor.withOpacity(
                    .2,
                  ),
            borderRadius: BorderRadius.only(
              topRight: mine
                  ? Radius.zero
                  : Radius.circular(
                      largeBorderRadius,
                    ),
              topLeft: Radius.circular(
                largeBorderRadius,
              ),
              bottomLeft: mine
                  ? Radius.circular(
                      largeBorderRadius,
                    )
                  : Radius.zero,
              bottomRight: Radius.circular(
                largeBorderRadius,
              ),
            ),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: Responsive.getWidth(context) / 1.6,
            ),
            child: Text(
              messageModel.content,
              style: h4TextStyleInactive.copyWith(
                color: mine ? Colors.white : colorTheme.kBlueColor,
              ),
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ),
        ),
      ],
    );
  }
}
