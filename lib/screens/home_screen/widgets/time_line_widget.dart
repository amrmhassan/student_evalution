// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_item.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:intl/intl.dart' as intl;
import 'package:student_evaluation/utils/providers_calls.dart';

class TimeLineWidget extends StatelessWidget {
  const TimeLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final startDate = DateTime.now();
    final endDate = startDate.add(Duration(days: 7));

    return PaddingWrapper(
      padding: EdgeInsets.symmetric(horizontal: kHPad / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var date = DateTime.now();
              date.isBefore(endDate);
              date = date.add(Duration(days: 1)))
            Expanded(child: TimeLineItem(dateTime: date))
        ],
      ),
    );
  }
}
