// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/screens/event_screen/event_screen.dart';
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

import 'widgets/home_screen_appbar.dart';

enum HomeScreenContent { updates, events }

class HomeScreen extends StatefulWidget {
  static const String routeName = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenContent activeContent = HomeScreenContent.updates;
  void setActiveContent(HomeScreenContent content) {
    setState(() {
      activeContent = content;
    });
  }

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
                                      HomeScreenTabsTitle(
                                        content: activeContent,
                                        setContent: setActiveContent,
                                      ),
                                      VSpace(),
                                      activeContent == HomeScreenContent.updates
                                          ? HomeScreenUpdates()
                                          : HomeScreenEvents(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            HomeScreenSearchBox(
                              hint: 'Search | Example: Attendance',
                              onSearch: (value) {},
                            ),
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

class HomeScreenEvents extends StatelessWidget {
  const HomeScreenEvents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Events on June 14, 2022',
                style: h2TextStyle,
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/icons/add.png',
                  width: largeIconSize,
                  color: colorTheme.inActiveText,
                ),
              ),
            ],
          ),
          // VSpace(factor: .4),
          TimeTableCard(
            title: 'Personal Trainings',
            onTap: () {
              CNav.pushNamed(context, EventScreen.routeName);
            },
          ),
          TimeTableCard(
            title: 'Yoga',
            onTap: () {
              CNav.pushNamed(context, EventScreen.routeName);
            },
          ),
          TimeTableCard(
            title: 'Stretch',
            onTap: () {
              CNav.pushNamed(context, EventScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}

class HomeScreenUpdates extends StatelessWidget {
  const HomeScreenUpdates({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                style: h4TextStyleInactive.copyWith(
                  decoration: TextDecoration.underline,
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
              TimeTableCard(
                title: 'Science Class',
                onTap: () {},
              ),
              TimeTableCard(
                title: 'Biology Class',
                onTap: () {},
              ),
              TimeTableCard(
                title: 'Maths Class',
                onTap: () {},
              ),
            ],
          ),
        ),

        VSpace(),
      ],
    );
  }
}
