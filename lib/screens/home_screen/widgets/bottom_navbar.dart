// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/screens/home_screen/widgets/navbar_item.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:intl/intl.dart' as intl;

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kHPad / 2),
      height: 80,
      decoration: BoxDecoration(
        color: colorTheme.kBlueColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(largeBorderRadius),
          topRight: Radius.circular(largeBorderRadius),
        ),
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavBarItem(
            title: 'Home',
            iconName: 'home',
            active: true,
          ),
          NavBarItem(
            title: 'Message',
            iconName: 'message',
            active: false,
          ),
          NavBarItem(
            title: 'Notification',
            iconName: 'Notification',
            active: false,
          ),
          NavBarItem(
            title: 'Settings',
            iconName: 'setting',
            active: false,
          ),
        ],
      ),
    );
  }
}
