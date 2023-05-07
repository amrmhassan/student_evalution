// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/screens/home_screen/widgets/bottom_navbar.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_screen_search_box.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/groups_builder.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/messages_screen_tabs_title.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/rooms_stream_builder.dart';
import 'package:student_evaluation/screens/search_screen/search_screen.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

import '../home_screen/widgets/home_screen_appbar.dart';

enum MessagesMode { individual, groups }

class MessagesScreen extends StatefulWidget {
  static const String routeName = '/MessagesScreen';
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  MessagesMode activeContent = MessagesMode.individual;
  void setActiveContent(MessagesMode content) {
    setState(() {
      activeContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: colorTheme.kBlueColor.withOpacity(.5),
        flexibleSpace: HAppBarFlexibleArea(),
        title: Text(
          'Messages',
          style: h1TextStyle.copyWith(
            color: Colors.white,
          ),
        ),
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
                        VSpace(factor: 5),
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
                                    ),
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(minHeight: 400),
                                    child: Column(
                                      children: [
                                        VSpace(factor: 1.5),
                                        VSpace(),
                                        MessagesTabsTitle(
                                          content: activeContent,
                                          setContent: setActiveContent,
                                        ),
                                        if (activeContent ==
                                            MessagesMode.individual)
                                          RoomsStreamBuilder()
                                        else
                                          GroupsBuilder(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                CNav.pushNamed(context, SearchScreen.routeName);
                              },
                              child: Hero(
                                tag: 'search',
                                child: HomeScreenSearchBox(
                                  hint: 'Search | Example: Pavithran',
                                  enabled: false,
                                  onSearch: (value) {},
                                ),
                              ),
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
