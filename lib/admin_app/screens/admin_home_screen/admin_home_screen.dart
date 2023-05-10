// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:student_evaluation/admin_app/screens/signup_screen/signup_screen.dart';
import 'package:student_evaluation/admin_app/screens/users_screen/users_screen.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/home_screen/widgets/bottom_line_time_line.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_title.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_widget.dart';
import 'package:student_evaluation/screens/home_screen/widgets/top_line_time_line.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../screens/home_screen/widgets/home_screen_appbar.dart';
import '../../../screens/intro_screen/intro_screen.dart';
import '../admin_student_materials/admin_student_materials.dart';

class AdminHomeScreen extends StatefulWidget {
  static const String routeName = '/AdminHomeScreen';
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Providers.userP(context);

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorTheme.kBlueColor.withOpacity(.5),
        flexibleSpace: HAppBarFlexibleArea(),
        title: HAppBarTitle(),
        actions: [
          IconButton(
            onPressed: () async {
              await Providers.userPf(context).logout();
              CNav.pushReplacementNamed(context, IntroScreen.routeName);
            },
            icon: Image.asset(
              'assets/icons/icon_other.png',
              width: mediumIconSize,
            ),
          ),
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
                        if (userProvider.userModel is TeacherModel)
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
                                  constraints: BoxConstraints(minHeight: 500),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: colorTheme.backGround,
                                      borderRadius: BorderRadius.only(
                                        topLeft:
                                            Radius.circular(largeBorderRadius),
                                        topRight:
                                            Radius.circular(largeBorderRadius),
                                      )),
                                  child: PaddingWrapper(
                                    child: Column(
                                      children: [
                                        VSpace(factor: 1.5),
                                        AdminUnitCard(
                                          onTap: () {
                                            CNav.pushNamed(context,
                                                SignUpScreen.routeName);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.person_add_alt,
                                                color: colorTheme.kBlueColor,
                                              ),
                                              HSpace(),
                                              Text(
                                                'Create User',
                                                style: h3InactiveTextStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                        VSpace(factor: .5),
                                        AdminUnitCard(
                                          onTap: () {
                                            CNav.pushNamed(context,
                                                AdminUsersScreen.routeName);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.person,
                                                color: colorTheme.kBlueColor,
                                              ),
                                              HSpace(),
                                              Text(
                                                'Edit User',
                                                style: h3InactiveTextStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                        VSpace(factor: .5),
                                        AdminUnitCard(
                                          onTap: () {
                                            CNav.pushNamed(context,
                                                AdminMaterialsScreen.routeName);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.book,
                                                color: colorTheme.kBlueColor,
                                              ),
                                              HSpace(),
                                              Text(
                                                'Student Materials',
                                                style: h3InactiveTextStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                        VSpace(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}

class AdminUnitCard extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const AdminUnitCard({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: onTap,
      padding: EdgeInsets.symmetric(
        horizontal: kHPad,
        vertical: kVPad,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          mediumBorderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 10,
          ),
        ],
      ),
      width: double.infinity,
      child: child,
    );
  }
}
