// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:student_evaluation/admin_app/screens/admin_home_screen/admin_home_screen.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/home_screen/widgets/bottom_line_time_line.dart';
import 'package:student_evaluation/screens/home_screen/widgets/bottom_navbar.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_screen_events.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_screen_search_box.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_screen_tabs_title.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_screen_updates.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_title.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_widget.dart';
import 'package:student_evaluation/screens/home_screen/widgets/top_line_time_line.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

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
  void initState() {
    Providers.langPf(context).loadLocale(context);

    _loadCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Providers.userP(context);

    //? loading the saved user model
    if (userProvider.userModel == null) {
      return Scaffold(
        backgroundColor: colorTheme.backGround,
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colorTheme.backGround,
      extendBodyBehindAppBar: true,
      endDrawer: HomeScreenEndDrawer(),
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
                        if (userProvider.userModel is TeacherModel ||
                            userProvider.userModel is StudentModel)
                          Column(
                            children: [
                              TopLineTimeLine(),
                              VSpace(factor: .9),
                              TimeLineTitle(),
                              VSpace(factor: .9),
                              TimeLineWidget(),
                              VSpace(factor: .9),
                              BottomLineTimeLine(),
                              VSpace(),
                            ],
                          ),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Column(
                              children: [
                                VSpace(factor: 1.5),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: colorTheme.backGround,
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

  void _loadCurrentUser() {
    Future.delayed(Duration.zero).then((value) async {
      var userProvider = Providers.userPf(context);
      if (userProvider.userModel == null) {
        await userProvider.loadCurrentUserInfo();
      }
      if (userProvider.userModel is AdminModel) {
        //? to direct to admin home screen
        CNav.pushReplacementNamed(context, AdminHomeScreen.routeName);
      }
    });
  }
}
