// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/screens/login_screen/login_screen.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = '/IntroScreen';
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      CNav.pushReplacementNamed(context, LoginScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/intro.png',
        fit: BoxFit.cover,
        alignment: Alignment.center,
        height: Responsive.getHeight(context),
      ),
    );
  }
}
