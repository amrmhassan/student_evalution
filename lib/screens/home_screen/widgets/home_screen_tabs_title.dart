// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_screen_tab_item.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:intl/intl.dart' as intl;

class HomeScreenTabsTitle extends StatelessWidget {
  const HomeScreenTabsTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      child: Column(
        children: [
          Row(
            children: [
              HomeScreenTabItem(
                active: true,
                title: 'Updates',
                onTap: () {},
              ),
              Spacer(),
              HomeScreenTabItem(
                active: false,
                title: 'Events',
                onTap: () {},
              ),
            ],
          ),
          HLine(
            color: colorTheme.inActiveText,
            thickness: .8,
          ),
        ],
      ),
    );
  }
}
