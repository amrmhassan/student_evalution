// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/screens/home_screen/widgets/bottom_line_time_line.dart';
import 'package:student_evaluation/screens/home_screen/widgets/bottom_navbar.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_dashboard.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_screen_search_box.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_screen_tabs_title.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_title.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_widget.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_table_card.dart';
import 'package:student_evaluation/screens/home_screen/widgets/top_line_time_line.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:intl/intl.dart' as intl;

import 'widgets/home_screen_appbar.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorTheme.kBlueColor.withOpacity(.5),
        flexibleSpace: HAppBarFlexibleArea(),
        title: HAppBarTitle(),
        actions: [
          HAppBarActions(),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: colorTheme.kBlueColor,
                    width: double.infinity,
                    height: 400,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: double.infinity),
                        VSpace(factor: 6),
                        TopLineTimeLine(),
                        VSpace(factor: .9),
                        TimeLineTitle(),
                        VSpace(factor: .9),
                        TimeLineWidget(),
                        VSpace(factor: .9),
                        BottomLineTimeLine(),
                        VSpace(),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Column(
                              children: [
                                VSpace(factor: 1.5),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft:
                                            Radius.circular(largeBorderRadius),
                                        topRight:
                                            Radius.circular(largeBorderRadius),
                                      )),
                                  child: Column(
                                    children: [
                                      VSpace(factor: 1.5),
                                      VSpace(),
                                      HomeScreenTabsTitle(),
                                      VSpace(),
                                      HomeDashboard(),
                                      VSpace(),
                                      PaddingWrapper(
                                        child: HLine(
                                          color: colorTheme.inActiveText,
                                          thickness: .8,
                                        ),
                                      ),
                                      VSpace(),
                                      PaddingWrapper(
                                        child: Row(
                                          children: [
                                            Text(
                                              'Time Table',
                                              style: h2TextStyle,
                                            ),
                                            Spacer(),
                                            Text(
                                              'View All',
                                              style:
                                                  h4TextStyleInactive.copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      VSpace(),
                                      // here is the time table items
                                      PaddingWrapper(
                                        child: Column(
                                          children: [
                                            TimeTableCard(),
                                            TimeTableCard(),
                                            TimeTableCard(),
                                          ],
                                        ),
                                      ),

                                      VSpace(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            HomeScreenSearchBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BottomNavBar(),
          ],
        ),
      ),
    );
  }
}
