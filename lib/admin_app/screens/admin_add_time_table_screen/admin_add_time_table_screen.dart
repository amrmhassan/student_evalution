// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/core/types.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/time_table_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_widget.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:student_evaluation/utils/providers_calls.dart';
import 'package:uuid/uuid.dart';

import '../../../screens/home_screen/widgets/home_screen_appbar.dart';
import '../../../transformers/enums_transformers.dart';

class AdminAddTimeTableScreen extends StatefulWidget {
  static const String routeName = '/AdminAddTimeTableScreen';
  const AdminAddTimeTableScreen({super.key});

  @override
  State<AdminAddTimeTableScreen> createState() =>
      _AdminAddTimeTableScreenState();
}

class _AdminAddTimeTableScreenState extends State<AdminAddTimeTableScreen> {
  bool loading = false;
  StudentGrade studentGrade = StudentGrade.k1SectionA;
  TeacherClass teacherClass = TeacherClass.math;

  TimeOfDay pickedTime = TimeOfDay.now();
  void setTimeOfDay(TimeOfDay timeOfDay) {
    setState(() {
      pickedTime = timeOfDay;
    });
  }

  void setStudentGrade(StudentGrade? grade) {
    setState(() {
      studentGrade = grade!;
    });
  }

  void setTeacherClass(TeacherClass? teacherClass) {
    setState(() {
      this.teacherClass = teacherClass!;
    });
  }

  void loadCurrentTimeTable() async {
    // FirebaseFirestore.instance.collection(DBCollections.timeTable).get();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Providers.userP(context);

    if (userProvider.userModel == null) {
      return Scaffold(
        backgroundColor: colorTheme.backGround,
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: colorTheme.backGround,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorTheme.kBlueColor.withOpacity(.5),
        flexibleSpace: HAppBarFlexibleArea(),
        title: Text(
          'Add To Time Table',
          style: h1TextStyle.copyWith(
            color: Colors.white,
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: colorTheme.kBlueColor,
                width: double.infinity,
                height: 100,
              ),
              SizedBox(width: double.infinity),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: colorTheme.kBlueColor,
                        ),
                        child: PaddingWrapper(
                          child: Column(
                            children: [
                              TimeLineWidget(
                                onChanged: (dateTime) {},
                              ),

                              VSpace(),
                              // TimePickerDialog(
                              //   initialTime: TimeOfDay.now(),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      VSpace(),
                      loading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : PaddingWrapper(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      DropdownButton(
                                        value: studentGrade,
                                        items: StudentGrade.values
                                            .map(
                                              (e) => DropdownMenuItem(
                                                key: Key(e.name),
                                                value: e,
                                                child: Text(
                                                  gradeTransformer(e),
                                                  style: h3InactiveTextStyle,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: setStudentGrade,
                                      ),
                                      DropdownButton(
                                        value: teacherClass,
                                        items: TeacherClass.values
                                            .map(
                                              (e) => DropdownMenuItem(
                                                key: Key(e.name),
                                                value: e,
                                                child: Text(
                                                  classTransformer(e),
                                                  style: h3InactiveTextStyle,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: setTeacherClass,
                                      ),
                                    ],
                                  ),
                                  VSpace(),
                                  //?
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Time',
                                        style: h3TextStyle,
                                      ),
                                      ButtonWrapper(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: kHPad,
                                          vertical: kVPad / 2,
                                        ),
                                        backgroundColor: Colors.white,
                                        border: Border.all(
                                          width: 1,
                                          color: colorTheme.kBlueColor,
                                        ),
                                        onTap: () async {
                                          var time = await showTimePicker(
                                            context: context,
                                            initialTime: pickedTime,
                                          );
                                          if (time == null) return;
                                          setTimeOfDay(time);
                                        },
                                        child: Text(
                                          '${pickedTime.hourOfPeriod}:${pickedTime.minute} ${pickedTime.period.name.toUpperCase()}',
                                          style: h3LiteTextStyle.copyWith(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  VSpace(),
                                  ButtonWrapper(
                                    active: !loading,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: kHPad,
                                      vertical: kVPad / 2,
                                    ),
                                    backgroundColor: colorTheme.kBlueColor,
                                    onTap: () async {
                                      try {
                                        String id = Uuid().v4();
                                        var currentDay =
                                            Providers.timeLPf(context)
                                                .currentDay;
                                        var model = TimeTableModel(
                                          id: id,
                                          teacherClass: teacherClass,
                                          studentGrade: studentGrade,
                                          weekDay: currentDay.weekday,
                                          hour: pickedTime.hour,
                                          minute: pickedTime.minute,
                                        );
                                        await FirebaseFirestore.instance
                                            .collection(DBCollections.timeTable)
                                            .doc(id)
                                            .set(model.toJSON());
                                        GlobalUtils.showSnackBar(
                                          context: context,
                                          message: 'Added To Time table',
                                          snackBarType: SnackBarType.success,
                                        );
                                      } catch (e) {
                                        GlobalUtils.showSnackBar(
                                          context: context,
                                          message: e.toString(),
                                          snackBarType: SnackBarType.error,
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Add Class',
                                      style: h3LightTextStyle,
                                    ),
                                  ),

                                  VSpace(),
                                ],
                              ),
                            )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
