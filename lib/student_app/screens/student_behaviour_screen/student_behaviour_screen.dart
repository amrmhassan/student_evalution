// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/choose_grade_section.dart';
import 'package:student_evaluation/screens/behavior_screen/widgets/behavior_table_title.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

class StudentBehaviorScreen extends StatefulWidget {
  static const String routeName = '/StudentBehaviorScreen';
  const StudentBehaviorScreen({super.key});

  @override
  State<StudentBehaviorScreen> createState() => _StudentBehaviorScreenState();
}

class _StudentBehaviorScreenState extends State<StudentBehaviorScreen> {
  void loadData() async {
    Future.delayed(Duration.zero).then((value) {});
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var behaviourProvider = Providers.behaveP(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorTheme.kBlueColor.withOpacity(.5),
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
                              'Behaviour',
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
                            behaviourProvider.loadingBehaviour
                                ? Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: colorTheme.kBlueColor,
                                    ),
                                  )
                                : Column(
                                    children: [
                                      ChooseGradeSection(
                                        afterChange: (grade) {
                                          loadData();
                                        },
                                        activeStudentGrade:
                                            behaviourProvider.activeGrade,
                                        onChangeGrade:
                                            Providers.behavePf(context)
                                                .setActiveGrade,
                                      ),
                                      VSpace(),
                                      HLine(
                                        thickness: .4,
                                        color: colorTheme.inActiveText,
                                        borderRadius: 1000,
                                      ),
                                      VSpace(),
                                      BehaviorTableTitle(),
                                      VSpace(factor: .3),
                                      VSpace(),
                                    ],
                                  ),
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
