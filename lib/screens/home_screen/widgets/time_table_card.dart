// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
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

class TimeTableCard extends StatelessWidget {
  const TimeTableCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: () {},
      padding: EdgeInsets.all(largePadding),
      margin: EdgeInsets.only(bottom: kVPad / 2),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          largeBorderRadius,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                mediumBorderRadius,
              ),
            ),
            child: Image.network(
              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
              width: largeIconSize * 2,
              height: largeIconSize * 2,
              fit: BoxFit.cover,
            ),
          ),
          HSpace(factor: .8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Science Class',
                style: h3TextStyle,
              ),
              VSpace(factor: .4),
              Text(
                '6th class B Section | 12:00PM',
                style: h4TextStyleInactive,
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.arrow_right,
            color: colorTheme.inActiveText,
          )
        ],
      ),
    );
  }
}
