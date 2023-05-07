// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/core/types.dart';
import 'package:student_evaluation/models/message_model.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../fast_tools/widgets/button_wrapper.dart';
import '../../../fast_tools/widgets/custom_text_field.dart';
import '../../../theming/constants/sizes.dart';

class SendMessageBox extends StatefulWidget {
  final String roomId;
  const SendMessageBox({
    super.key,
    required this.focusNode,
    required this.roomId,
  });

  final FocusNode focusNode;

  @override
  State<SendMessageBox> createState() => _SendMessageBoxState();
}

class _SendMessageBoxState extends State<SendMessageBox> {
  TextEditingController msgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: colorTheme.backGround,
      padding: EdgeInsets.symmetric(
        horizontal: kHPad,
        vertical: kVPad / 2,
      ),
      child: CustomTextField(
        focusNode: widget.focusNode,
        controller: msgController,
        borderRadius: BorderRadius.circular(1000),
        backgroundColor: colorTheme.kBlueColor,
        hintStyle: h4LightTextStyle.copyWith(
          color: Colors.white.withOpacity(
            .7,
          ),
        ),
        textStyle: h4LightTextStyle,
        padding: EdgeInsets.zero,
        title: 'Type Something...',
        color: colorTheme.kBlueColor,
        trailingIcon: ButtonWrapper(
          padding: EdgeInsets.all(largePadding),
          borderRadius: 1000,
          onTap: () async {
            try {
              if (msgController.text.isEmpty) return;
              // here send the message
              String senderId = Providers.userPf(context).userModel!.uid;
              await Providers.msgPf(context).sendMessage(
                roomId: widget.roomId,
                content: msgController.text,
                messageType: MessageType.user,
                receiverId: '',
                senderId: senderId,
              );
              msgController.text = '';
            } catch (e) {
              GlobalUtils.showSnackBar(
                context: context,
                message: e.toString(),
                snackBarType: SnackBarType.error,
              );
            }
          },
          backgroundColor: colorTheme.kBlueColor,
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
