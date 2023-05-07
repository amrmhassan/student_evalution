// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:ui';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/intro_screen/intro_screen.dart';
import 'package:student_evaluation/screens/loading_screen.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/utils/global_utils.dart';
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
              onPressed: () async {
                await Providers.userPf(context).logout();
                CNav.pushReplacementNamed(context, IntroScreen.routeName);
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
    var userProvider = Providers.userP(context);
    var userModel = userProvider.userModel as UserModel;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userModel.name,
          style: h1LightTextStyle,
        ),
        GestureDetector(
          onTap: () {
            GlobalUtils.copyToClipboard(
              context: context,
              data: userModel.uid,
              snackContent: 'User id copied',
            );
          },
          child: Text(
            'ID: ${userModel.uid.substring(0, 5)}... | ${userModel.userType.name.capitalize}',
            style: h4TextStyleInactive.copyWith(
              color: Colors.white.withOpacity(.8),
            ),
          ),
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
