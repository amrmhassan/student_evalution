// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: colorTheme.kBlueColor,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Moaz Ashraf',
                style: h1LightTextStyle,
              ),
              Text(
                'ID: 11026 | K1-B Section',
                style: h4TextStyleInactive,
              ),
            ],
          ),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    ButtonWrapper(
                      padding: EdgeInsets.all(largePadding),
                      backgroundColor: colorTheme.backGround,
                      onTap: () {},
                      child: Icon(
                        FontAwesomeIcons.bell,
                        color: colorTheme.kBlueColor,
                      ),
                    ),
                    HSpace(factor: .7),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/icons/icon_other.png',
                        width: mediumIconSize,
                      ),
                    ),
                    HSpace(factor: .7),
                  ],
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: colorTheme.kBlueColor,
                    width: double.infinity,
                    height: 200,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(width: double.infinity),
                        VSpace(factor: 3),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Column(
                              children: [
                                VSpace(factor: 1.5),
                                Container(
                                  width: double.infinity,
                                  height: Responsive.getHeight(context),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft:
                                            Radius.circular(largeBorderRadius),
                                        topRight:
                                            Radius.circular(largeBorderRadius),
                                      )),
                                ),
                              ],
                            ),
                            Container(
                              width: Responsive.getWidth(context) - kHPad * 2,
                              height: 2 * 1.5 * kVPad,
                              decoration: BoxDecoration(
                                color: colorTheme.backGround,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.5),
                                    blurRadius: 10,
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.circular(largeBorderRadius),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: double.infinity),
                                  HSpace(),
                                  Icon(
                                    Icons.search,
                                    color: colorTheme.kInactiveColor,
                                    size: mediumIconSize,
                                  ),
                                  HSpace(factor: .3),
                                  Expanded(
                                    child: CustomTextField(
                                      title: 'Search | Example: Attendance,',
                                    ),
                                  ),
                                ],
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
          ],
        ));
  }
}
