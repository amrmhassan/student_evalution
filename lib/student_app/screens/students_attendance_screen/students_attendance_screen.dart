// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/student_app/models/attendance_month_model.dart';
import 'package:student_evaluation/student_app/screens/students_attendance_screen/widgets/teacher_class_chooser.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../screens/home_screen/widgets/home_screen_appbar.dart';

class StudentAttendanceScreen extends StatefulWidget {
  static const String routeName = '/StudentAttendanceScreen';
  const StudentAttendanceScreen({super.key});

  @override
  State<StudentAttendanceScreen> createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  @override
  void initState() {
    loadData();

    super.initState();
  }

  void loadData() async {
    Future.delayed(Duration.zero).then((value) {
      var model = Providers.userPf(context).userModel as StudentModel;
      Providers.studentAttendPf(context).loadAttendData(model);
    });
  }

  @override
  Widget build(BuildContext context) {
    var studentAttendProvider = Providers.studentAttendP(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: colorTheme.backGround,
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
                            Row(
                              children: [
                                Text(
                                  'Attendance',
                                  style: h1TextStyle.copyWith(
                                    color: colorTheme.kBlueColor,
                                  ),
                                ),
                                Spacer(),
                                //? teacher class chooser
                                TeacherClassChooser(
                                  value: studentAttendProvider.activeClass,
                                  onChange: (value) {
                                    Providers.studentAttendPf(context)
                                        .setActiveClass(value);
                                    loadData();
                                  },
                                ),
                                //? teacher class chooser
                              ],
                            ),

                            // VSpace(factor: .2),
                            // Text(
                            //   DateFormat('dd-MM-yyyy | EEEE')
                            //       .format(timeLineProvider.currentDay),
                            //   style: h4TextStyleInactive,
                            // ),
                            VSpace(),
                            HLine(
                              thickness: .4,
                              color: colorTheme.inActiveText,
                              borderRadius: 1000,
                            ),
                            VSpace(),
                            studentAttendProvider.loading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: colorTheme.kBlueColor,
                                    ),
                                  )
                                : Column(
                                    children: [
                                      VSpace(factor: .3),
                                      //? here the attendance report
                                      ...studentAttendProvider.months.map(
                                        (e) => MonthAttendanceReportCard(
                                          model: e,
                                        ),
                                      ),
                                      if (studentAttendProvider.months.isEmpty)
                                        Container(
                                          alignment: Alignment.center,
                                          padding:
                                              EdgeInsets.only(top: kVPad * 2),
                                          child: Text(
                                            'No Attendance data yet on this class',
                                            style: h4TextStyleInactive,
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

class MonthAttendanceReportCard extends StatelessWidget {
  final AttendanceMonthModel model;

  const MonthAttendanceReportCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VSpace(),
        Text(
          model.month,
          style: h2TextStyle.copyWith(
            color: colorTheme.inActiveText,
          ),
        ),
        VSpace(factor: .5),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: kHPad,
            vertical: kVPad / 2,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              mediumBorderRadius,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.3),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(children: [
            Container(
              padding: EdgeInsets.all(ultraLargePadding),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        model.attended.toString(),
                        style: h2TextStyle.copyWith(height: 1),
                      ),
                      VSpace(factor: .5),
                      Text(
                        'Days \nPresent',
                        style: h4TextStyleInactive.copyWith(height: 1),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: largeIconSize * 3 - ultraLargePadding * 2,
                    height: largeIconSize * 3 - ultraLargePadding * 2,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      color: colorTheme.kBlueColor,
                      value: model.attended / (model.getWorkingDays),
                      // value: 1,
                    ),
                  ),
                ],
              ),
            ),
            HSpace(factor: .6),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Working Days',
                    style: h3TextStyle.copyWith(
                      color: colorTheme.kBlueColor,
                    ),
                  ),
                  VSpace(factor: .1),
                  Text(
                    '${(model.getWorkingDays)} days',
                    style: h4TextStyleInactive,
                  ),
                  VSpace(),
                  Text(
                    'Official Leaves',
                    style: h3TextStyle.copyWith(
                      color: colorTheme.kBlueColor,
                    ),
                  ),
                  VSpace(factor: .1),
                  Text(
                    '${(model.getHolidaysDays)} days',
                    style: h4TextStyleInactive,
                  ),
                ],
              ),
            ),
          ]),
        ),
        VSpace(),
        HLine(
          color: colorTheme.inActiveText.withOpacity(
            .2,
          ),
          thickness: .6,
        ),
      ],
    );
  }
}
