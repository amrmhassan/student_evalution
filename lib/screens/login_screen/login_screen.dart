// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/screens/home_screen/home_screen.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

import '../../providers/user_provider.dart';
import '../../utils/providers_calls.dart';
import 'widgets/login_form_text_filed.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorTheme.kBlueColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: [
            Column(
              children: [
                VSpace(factor: 2),
                Stack(
                  children: [
                    Image.asset('assets/stickers/teacher.png'),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                width: double.infinity,
                height: Responsive.getHeight(context) / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      largeBorderRadius * 2,
                    ),
                    topRight: Radius.circular(
                      largeBorderRadius * 2,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VSpace(factor: 1.7),
                    PaddingWrapper(
                      child: Text(
                        'Login',
                        style: h1TextStyle.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: colorTheme.kBlueColor,
                        ),
                      ),
                    ),
                    VSpace(),
                    Selector<UserProvider, String?>(
                      selector: (p0, p1) => p1.emailError,
                      shouldRebuild: (previous, next) => previous != next,
                      builder: (context, value, child) => LoginFormTextField(
                        errorText: value,
                        controller: Providers.userPf(context).emailController,
                        hint: 'you@example.com',
                        iconPath: 'assets/svg/email.svg',
                        inputType: TextInputType.emailAddress,
                      ),
                    ),
                    VSpace(factor: .5),
                    Selector<UserProvider, String?>(
                      selector: (p0, p1) => p1.passError,
                      shouldRebuild: (previous, next) => previous != next,
                      builder: (context, value, child) => LoginFormTextField(
                        errorText: value,
                        controller: Providers.userPf(context).passController,
                        hint: 'Enter password',
                        iconPath: 'assets/svg/lock.svg',
                        inputType: TextInputType.visiblePassword,
                        password: true,
                      ),
                    ),
                    VSpace(),
                    PaddingWrapper(
                      child: ButtonWrapper(
                        onTap: () {
                          CNav.pushReplacementNamed(
                              context, HomeScreen.routeName);
                        },
                        padding: EdgeInsets.symmetric(
                          horizontal: kHPad,
                          vertical: kVPad / 2,
                        ),
                        backgroundColor: colorTheme.kBlueColor,
                        child: Text(
                          'Login',
                          style: h2LightTextStyle,
                        ),
                      ),
                    ),
                    VSpace(factor: 2),
                    PaddingWrapper(
                      child: SelectableText(
                        'Need Help? \ncall 011********',
                        style: h3InactiveTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
