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

class BottomLineTimeLine extends StatelessWidget {
  const BottomLineTimeLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      padding: EdgeInsets.symmetric(horizontal: kHPad / 2),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          HLine(
            thickness: .4,
            color: Colors.white.withOpacity(.5),
          ),
          HSpace(),
          Positioned(
            left: kHPad * 2,
            child: SizedBox(
              width: kVPad * 3,
              child: HLine(
                color: Colors.white,
                thickness: 3,
                borderRadius: 1000,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
