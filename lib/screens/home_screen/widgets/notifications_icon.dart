// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/screens/notifications_screen/notifications_screen.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../theming/theme_calls.dart';

class NotificationsIcon extends StatefulWidget {
  const NotificationsIcon({
    super.key,
  });

  @override
  State<NotificationsIcon> createState() => _NotificationsIconState();
}

class _NotificationsIconState extends State<NotificationsIcon> {
  StreamSubscription? sub;

  @override
  void initState() {
    //?
    Future.delayed(Duration.zero).then((value) {
      var userModel = Providers.userPf(context).userModel!;

      Providers.notifyPf(context).listenToHomeWorks(context);
      Providers.notifyPf(context).loadWatchedHomeWorks(userModel.uid);
    });

    super.initState();
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var notifyProvider = Providers.notifyP(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ButtonWrapper(
          padding: EdgeInsets.all(largePadding),
          backgroundColor: colorTheme.backGround,
          onTap: () {
            CNav.pushNamed(context, NotificationsScreen.routeName);
          },
          child: Icon(
            FontAwesomeIcons.bell,
            color: colorTheme.kBlueColor,
          ),
        ),
        if (notifyProvider.unwatchedHomeworks.isNotEmpty)
          Positioned(
            top: -smallIconSize / 8,
            left: -smallIconSize / 8,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(smallPadding),
              width: smallIconSize,
              height: smallIconSize,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(
                  1000,
                ),
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  notifyProvider.unwatchedHomeworks.length.toString(),
                  style: h4TextStyleInactive.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
