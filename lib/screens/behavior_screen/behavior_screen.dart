// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/behavior_model.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/apply_attendance_button.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/choose_grade_section.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/reset_attendance_button.dart';
import 'package:student_evaluation/screens/behavior_screen/widgets/behavior_card.dart';
import 'package:student_evaluation/screens/behavior_screen/widgets/behavior_table_title.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../core/types.dart';
import '../../models/user_model.dart';
import '../../utils/global_utils.dart';
import '../home_screen/widgets/home_screen_appbar.dart';

class BehaviorScreen extends StatefulWidget {
  static const String routeName = '/BehaviorScreen';
  const BehaviorScreen({super.key});

  @override
  State<BehaviorScreen> createState() => _BehaviorScreenState();
}

class _BehaviorScreenState extends State<BehaviorScreen> {
  void loadData() async {
    Future.delayed(Duration.zero).then((value) {
      TeacherClass currentTeacherClass =
          (Providers.userPf(context).userModel as TeacherModel).teacherClass;
      DateTime activeDate = Providers.timeLPf(context).currentDay;
      Providers.behavePf(context).loadBehaviourData(
        currentTeacherClass,
        activeDate,
      );
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var behaviourProvider = Providers.behaveP(context);
    TeacherModel teacherModel =
        Providers.userPf(context).userModel as TeacherModel;
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
                                      ...behaviourProvider.gradeUsers.map((e) {
                                        StudentModel studentModel =
                                            e as StudentModel;
                                        return BehaviorCard(
                                          onChange: (state) {
                                            Providers.behavePf(context)
                                                .changeBehaviourState(
                                              state: state,
                                              userId: studentModel.uid,
                                              studentGrade:
                                                  studentModel.studentGrade,
                                              teacherClass:
                                                  teacherModel.teacherClass,
                                              currentDate:
                                                  Providers.timeLPf(context)
                                                      .currentDay,
                                            );
                                          },
                                          userModel: e,
                                        );
                                      }),
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
                                              onTap: () {
                                                loadData();
                                              },
                                            ),
                                            ApplyAttendanceButton(
                                              title: 'Apply',
                                              onTap: () {
                                                try {
                                                  Providers.behavePf(context)
                                                      .applyBehaveData(
                                                    (Providers.userPf(context)
                                                                .userModel
                                                            as TeacherModel)
                                                        .teacherClass,
                                                    Providers.timeLPf(context)
                                                        .currentDay,
                                                  );
                                                  GlobalUtils.showSnackBar(
                                                    context: context,
                                                    message:
                                                        'Saved Successfully',
                                                    snackBarType:
                                                        SnackBarType.success,
                                                  );
                                                } catch (e) {
                                                  GlobalUtils.showSnackBar(
                                                    context: context,
                                                    message: 'Error occurred',
                                                    snackBarType:
                                                        SnackBarType.error,
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
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
