// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../fast_tools/widgets/h_space.dart';
import '../../../theming/constants/styles.dart';
import '../../../theming/theme_calls.dart';

class HAppBarActions extends StatelessWidget {
  const HAppBarActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
              onPressed: () {
                Providers.userPf(context).logout();
              },
              icon: Image.asset(
                'assets/icons/icon_other.png',
                width: mediumIconSize,
              ),
            ),
            HSpace(factor: .7),
          ],
        ),
      ],
    );
  }
}

class HAppBarTitle extends StatelessWidget {
  const HAppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Moaz Ashraf',
          style: h1LightTextStyle,
        ),
        Text(
          'ID: 11026 | Teacher',
          style:
              h4TextStyleInactive.copyWith(color: Colors.white.withOpacity(.8)),
        ),
      ],
    );
  }
}

class HAppBarFlexibleArea extends StatelessWidget {
  const HAppBarFlexibleArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
        background: BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 3,
        sigmaY: 3,
      ),
      child: Container(
        color: colorTheme.kBlueColor.withOpacity(.5),
      ),
    ));
  }
}
