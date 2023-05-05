// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, dead_code

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_line.dart';
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
import 'package:student_evaluation/screens/messages_screen/widgets/group_chat_card.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/message_card.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/messages_screen_tabs_title.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:intl/intl.dart' as intl;

import '../home_screen/widgets/home_screen_appbar.dart';

enum MessageScreenContent { individual, groups }

class MessagesScreen extends StatefulWidget {
  static const String routeName = '/MessagesScreen';
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  MessageScreenContent activeContent = MessageScreenContent.individual;
  void setActiveContent(MessageScreenContent content) {
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
                                  child: Column(
                                    children: [
                                      VSpace(factor: 1.5),
                                      VSpace(),
                                      MessagesTabsTitle(
                                        content: activeContent,
                                        setContent: setActiveContent,
                                      ),
                                      if (activeContent ==
                                          MessageScreenContent.individual)
                                        ...List.generate(
                                          10,
                                          (index) => IndividualChatCard(),
                                        )
                                      else
                                        ...List.generate(
                                          3,
                                          (index) => GroupChatCard(),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            HomeScreenSearchBox(
                              hint: 'Search | Example: Pavithran',
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
