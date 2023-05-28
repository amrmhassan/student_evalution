// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/screens/home_screen/home_screen.dart';
import 'package:student_evaluation/screens/home_screen/widgets/navbar_item.dart';
import 'package:student_evaluation/screens/messages_screen/messages_screen.dart';
import 'package:student_evaluation/screens/settings_screen/settings_screen.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:intl/intl.dart' as intl;
import 'package:student_evaluation/utils/providers_calls.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appStateProvider = Providers.appSP(context);
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
            active: appStateProvider.activeNavBarIndex == 0,
            onTap: () {
              Providers.appSPf(context).setActiveNavBar(0);
              CNav.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),
          NavBarItem(
            title: 'Message',
            iconName: 'message',
            active: appStateProvider.activeNavBarIndex == 1,
            onTap: () {
              Providers.appSPf(context).setActiveNavBar(1);

              CNav.pushReplacementNamed(context, MessagesScreen.routeName);
            },
          ),
          // NavBarItem(
          //   title: 'Notification',
          //   iconName: 'Notification',
          //   active: appStateProvider.activeNavBarIndex == 2,
          //   onTap: () {
          //     Providers.appSPf(context).setActiveNavBar(2);
          //   },
          // ),
          NavBarItem(
            title: 'Settings',
            iconName: 'setting',
            active: appStateProvider.activeNavBarIndex == 2,
            onTap: () {
              Providers.appSPf(context).setActiveNavBar(2);
              CNav.pushReplacementNamed(context, SettingsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
