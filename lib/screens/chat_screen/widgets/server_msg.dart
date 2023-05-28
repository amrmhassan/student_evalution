// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/models/message_model.dart';

import '../../../fast_tools/widgets/padding_wrapper.dart';
import '../../../theming/constants/sizes.dart';
import '../../../theming/constants/styles.dart';
import '../../../theming/theme_calls.dart';

class ServerMsg extends StatelessWidget {
  final MessageModel messageModel;
  const ServerMsg({
    super.key,
    required this.messageModel,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      child: Stack(
        alignment: Alignment.center,
        children: [
          HLine(
            color: colorTheme.inActiveText.withOpacity(.5),
            thickness: .4,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: kHPad / 2,
            ),
            color: colorTheme.backGround,
            child: Text(
              messageModel.content,
              style: h4TextStyleInactive,
            ),
          ),
        ],
      ),
    );
  }
}
