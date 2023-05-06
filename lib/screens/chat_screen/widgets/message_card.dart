// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import '../../../fast_tools/helpers/responsive.dart';
import '../../../fast_tools/widgets/h_space.dart';
import '../../../theming/constants/sizes.dart';
import '../../../theming/constants/styles.dart';
import '../../../theming/theme_calls.dart';

class MessageCard extends StatelessWidget {
  final bool mine;

  const MessageCard({
    super.key,
    required this.mine,
  });

  @override
  Widget build(BuildContext context) {
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
              lorem(
                paragraphs: Random().nextInt(5) + 1,
                words: Random().nextInt(20) + 1,
              ),
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