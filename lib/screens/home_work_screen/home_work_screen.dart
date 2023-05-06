// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/apply_attendance_button.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/choose_grade_section.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/reset_attendance_button.dart';
import 'package:student_evaluation/screens/home_work_screen/widgets/home_work_card.dart';
import 'package:student_evaluation/screens/home_work_screen/widgets/home_work_table_title.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

import '../home_screen/widgets/home_screen_appbar.dart';

class HomeWorkScreen extends StatelessWidget {
  static const String routeName = '/HomeWorkScreen';
  const HomeWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorTheme.kBlueColor.withOpacity(.5),
        flexibleSpace: HAppBarFlexibleArea(),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: colorTheme.kBlueColor,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                VSpace(factor: 4),
                Column(
                  children: [
                    VSpace(),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorTheme.backGround,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            largeBorderRadius,
                          ),
                          topRight: Radius.circular(
                            largeBorderRadius,
                          ),
                        ),
                      ),
                      child: PaddingWrapper(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            VSpace(),
                            Text(
                              'Home Work',
                              style: h1TextStyle.copyWith(
                                color: colorTheme.kBlueColor,
                              ),
                            ),
                            VSpace(factor: .2),
                            Text(
                              DateFormat('dd-MM-yyyy | EEEE')
                                  .format(DateTime.now()),
                              style: h4TextStyleInactive,
                            ),
                            VSpace(),
                            HLine(
                              thickness: .4,
                              color: colorTheme.inActiveText,
                              borderRadius: 1000,
                            ),
                            VSpace(),
                            ChooseGradeSection(
                              afterChange: (grade) {},
                              activeStudentGrade: StudentGrade.k1SectionA,
                              onChangeGrade: (grade) {},
                            ),
                            VSpace(factor: .5),
                            UploadDocumentCard(),
                            VSpace(factor: .5),
                            HomeDescCard(),
                            VSpace(factor: .5),
                            HomeWorkDeadlineRow(),
                            VSpace(),
                            HLine(
                              thickness: .4,
                              color: colorTheme.inActiveText,
                              borderRadius: 1000,
                            ),
                            VSpace(),
                            HomeWorkTableTitle(),
                            VSpace(factor: .3),
                            ...List.generate(
                              10,
                              (index) => HomeWorkCard(
                                checked: true,
                                onTap: () {},
                                name: 'Enema',
                              ),
                            ),
                            VSpace(),
                            PaddingWrapper(
                              padding: EdgeInsets.symmetric(
                                horizontal: kHPad * 2,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ResetAttendanceButton(
                                    title: 'Reset',
                                    onTap: () {},
                                  ),
                                  ApplyAttendanceButton(
                                    title: 'Send',
                                    onTap: () {},
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
          ),
        ],
      ),
    );
  }
}

class HomeWorkDeadlineRow extends StatelessWidget {
  const HomeWorkDeadlineRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DateChoosingCard(
          title: 'Start Date',
          onTap: () {},
          dateTime: DateTime.now(),
        ),
        DateChoosingCard(
          title: 'End Date',
          onTap: () {},
          dateTime: DateTime.now().add(
            Duration(
              days: 5,
            ),
          ),
        ),
      ],
    );
  }
}

class DateChoosingCard extends StatelessWidget {
  final String title;
  final DateTime dateTime;
  final VoidCallback onTap;

  const DateChoosingCard({
    super.key,
    required this.title,
    required this.dateTime,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: h3InactiveTextStyle,
        ),
        VSpace(factor: .4),
        ButtonWrapper(
          onTap: onTap,
          padding: EdgeInsets.symmetric(
            horizontal: kHPad / 2,
            vertical: kVPad / 2.5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              mediumBorderRadius,
            ),
            border: Border.all(
              width: .3,
              color: colorTheme.inActiveText.withOpacity(.7),
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/icons/attendance.png',
                color: colorTheme.kBlueColor,
                width: smallIconSize,
              ),
              HSpace(factor: .4),
              Text(
                DateFormat('MMM dd,yyyy').format(
                  dateTime,
                ),
                style: h4TextStyleInactive,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UploadDocumentCard extends StatelessWidget {
  const UploadDocumentCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kHPad / 2,
        vertical: kVPad,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          mediumBorderRadius,
        ),
        border: Border.all(
          width: .3,
          color: colorTheme.inActiveText.withOpacity(.7),
        ),
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          Image.asset(
            'assets/icons/upload.png',
            width: largeIconSize,
          ),
          VSpace(factor: .5),
          Text(
            'Upload Document',
            style: h2TextStyle.copyWith(
              color: colorTheme.inActiveText.withOpacity(.6),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeDescCard extends StatelessWidget {
  const HomeDescCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kHPad / 2,
        vertical: kVPad,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          mediumBorderRadius,
        ),
        border: Border.all(
          width: .3,
          color: colorTheme.inActiveText.withOpacity(.7),
        ),
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          Text(
            'Enter Description',
            style: h2TextStyle.copyWith(
              color: colorTheme.inActiveText.withOpacity(.6),
            ),
          ),
        ],
      ),
    );
  }
}
