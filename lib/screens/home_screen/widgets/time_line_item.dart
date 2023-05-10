// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:intl/intl.dart' as intl;
import 'package:student_evaluation/utils/providers_calls.dart';

class TimeLineItem extends StatelessWidget {
  final DateTime dateTime;
  final Function(DateTime dateTime)? onClick;
  const TimeLineItem({
    super.key,
    required this.dateTime,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    var timeLineProvider = Providers.timeLP(context);
    String myDate = intl.DateFormat('yyyy-MM-dd').format(dateTime);
    String activeData =
        intl.DateFormat('yyyy-MM-dd').format(timeLineProvider.currentDay);
    bool equal = myDate == activeData;

    return ButtonWrapper(
      onTap: () {
        Providers.timeLPf(context).setCurrentDay(dateTime);
        if (onClick != null) {
          onClick!(dateTime);
        }
      },
      padding: EdgeInsets.symmetric(
        vertical: kVPad,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(largeBorderRadius),
        color: equal ? Colors.white : Colors.transparent,
      ),
      child: Column(
        children: [
          Text(
            intl.DateFormat('E').format(dateTime).substring(0, 2).toUpperCase(),
            style: h3TextStyle.copyWith(
              color: equal ? colorTheme.kBlueColor : Colors.white,
            ),
          ),
          VSpace(factor: .5),
          Text(
            intl.DateFormat('dd').format(dateTime),
            style: h3LightTextStyle.copyWith(
              color: equal ? colorTheme.kBlueColor : null,
            ),
          ),
        ],
      ),
    );
  }
}
