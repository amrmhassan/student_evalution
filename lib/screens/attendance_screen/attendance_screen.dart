// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_evaluation/core/types.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/attendance_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/absent_table_title.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/apply_attendance_button.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/attendance_card.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/choose_grade_section.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/reset_attendance_button.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../home_screen/widgets/home_screen_appbar.dart';

class AttendanceScreen extends StatefulWidget {
  static const String routeName = '/AttendanceScreen';
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      TeacherClass currentTeacherClass =
          (Providers.userPf(context).userModel as TeacherModel).teacherClass;
      DateTime activeDate = Providers.timeLPf(context).currentDay;
      Providers.attendPf(context).loadAttendanceData(
        currentTeacherClass,
        activeDate,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var timeLineProvider = Providers.timeLP(context);
    var attendanceProvider = Providers.attendP(context);
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
                              'Attendance',
                              style: h1TextStyle.copyWith(
                                color: colorTheme.kBlueColor,
                              ),
                            ),
                            VSpace(factor: .2),
                            Text(
                              DateFormat('dd-MM-yyyy | EEEE')
                                  .format(timeLineProvider.currentDay),
                              style: h4TextStyleInactive,
                            ),
                            VSpace(),
                            HLine(
                              thickness: .4,
                              color: colorTheme.inActiveText,
                              borderRadius: 1000,
                            ),
                            VSpace(),
                            attendanceProvider.loadingAttendance
                                ? Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: colorTheme.kBlueColor,
                                    ),
                                  )
                                : Column(
                                    children: [
                                      ChooseGradeSection(),
                                      VSpace(),
                                      HLine(
                                        thickness: .4,
                                        color: colorTheme.inActiveText,
                                        borderRadius: 1000,
                                      ),
                                      VSpace(),
                                      AbsentTableTitle(),
                                      VSpace(factor: .3),
                                      ...attendanceProvider.gradeUsers.map((e) {
                                        StudentModel studentModel =
                                            e as StudentModel;
                                        return AttendanceCard(
                                          present: false,
                                          onChange: (present) {
                                            Providers.attendPf(context)
                                                .changeAttendanceState(
                                              state: present
                                                  ? AttendanceState.present
                                                  : AttendanceState.absent,
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
                                                Providers.attendPf(context)
                                                    .loadAttendanceData(
                                                  (Providers.userPf(context)
                                                              .userModel
                                                          as TeacherModel)
                                                      .teacherClass,
                                                  Providers.timeLPf(context)
                                                      .currentDay,
                                                );
                                              },
                                            ),
                                            ApplyAttendanceButton(
                                              title: 'Apply',
                                              onTap: () {
                                                try {
                                                  Providers.attendPf(context)
                                                      .applyAttendData(
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
