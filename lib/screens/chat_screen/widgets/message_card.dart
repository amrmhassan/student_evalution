// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/message_model.dart';
import 'package:student_evaluation/screens/chat_screen/widgets/sender_little_info.dart';
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!mine && mode == MessagesMode.groups)
              SenderLittleInfo(
                userId: messageModel.senderID,
              ),
            VSpace(factor: .2),
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
                  topLeft: !mine
                      ? Radius.zero
                      : Radius.circular(
                          largeBorderRadius,
                        ),
                  topRight: Radius.circular(
                    largeBorderRadius,
                  ),
                  bottomRight: !mine
                      ? Radius.circular(
                          largeBorderRadius,
                        )
                      : Radius.zero,
                  bottomLeft: Radius.circular(
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
        ),
      ],
    );
  }
}
