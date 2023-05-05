// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/screens/home_screen/home_screen.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_screen_tab_item.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:intl/intl.dart' as intl;

class HomeScreenTabsTitle extends StatelessWidget {
  final HomeScreenContent content;
  final Function(HomeScreenContent content) setContent;
  const HomeScreenTabsTitle({
    super.key,
    required this.content,
    required this.setContent,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      child: Column(
        children: [
          Row(
            children: [
              HomeScreenTabItem(
                active: content == HomeScreenContent.updates,
                title: 'Updates',
                onTap: () {
                  setContent(HomeScreenContent.updates);
                },
              ),
              Spacer(),
              HomeScreenTabItem(
                active: content == HomeScreenContent.events,
                title: 'Events',
                onTap: () {
                  setContent(HomeScreenContent.events);
                },
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
