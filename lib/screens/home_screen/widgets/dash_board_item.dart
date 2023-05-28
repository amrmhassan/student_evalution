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

class DashboardItem extends StatelessWidget {
  final String title;
  final String? iconName;
  final VoidCallback? onTap;
  final IconData? iconData;
  final Color? color;

  const DashboardItem({
    super.key,
    this.iconName,
    required this.title,
    required this.onTap,
    this.iconData,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (iconData == null && iconName == null) {
      throw Exception('Enter either iconName or iconData');
    }
    return ButtonWrapper(
      onTap: onTap,
      child: Column(
        children: [
          if (iconData == null)
            Image.asset(
              'assets/icons/$iconName.png',
              width: largeIconSize * 1.2,
              color: color,
            )
          else
            Icon(
              iconData,
              size: largeIconSize * 1.2,
              color: color,
            ),
          Text(
            title,
            style: h4TextStyleInactive,
          )
        ],
      ),
    );
  }
}
