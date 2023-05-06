// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/apply_attendance_button.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/choose_grade_section.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/reset_attendance_button.dart';
import 'package:student_evaluation/screens/home_work_screen/widgets/home_desc_card.dart';
import 'package:student_evaluation/screens/home_work_screen/widgets/home_work_card.dart';
import 'package:student_evaluation/screens/home_work_screen/widgets/home_work_deadline_row.dart';
import 'package:student_evaluation/screens/home_work_screen/widgets/home_work_table_title.dart';
import 'package:student_evaluation/screens/home_work_screen/widgets/upload_doc_card.dart';
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
                              'New Home Work',
                              style: h1TextStyle.copyWith(
                                color: colorTheme.kBlueColor,
                              ),
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
