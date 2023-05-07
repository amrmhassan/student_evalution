// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/core/types.dart';
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
import 'package:student_evaluation/utils/global_utils.dart';

import '../../utils/providers_calls.dart';
import '../home_screen/widgets/home_screen_appbar.dart';

class HomeWorkScreen extends StatefulWidget {
  static const String routeName = '/HomeWorkScreen';
  const HomeWorkScreen({super.key});

  @override
  State<HomeWorkScreen> createState() => _HomeWorkScreenState();
}

class _HomeWorkScreenState extends State<HomeWorkScreen> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    Future.delayed(Duration.zero).then((value) {
      Providers.homeWPf(context).loadUserGrades();
    });
  }

  @override
  Widget build(BuildContext context) {
    var homeWProvider = Providers.homeWP(context);
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
                            homeWProvider.loadingUsers
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
                                            homeWProvider.activeGrade,
                                        onChangeGrade: (grade) {
                                          Providers.homeWPf(context)
                                              .setActiveGrade(grade);
                                        },
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
                                      ...homeWProvider.gradeUsers.map((e) {
                                        return HomeWorkCard(
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
                                              onTap: () {},
                                            ),
                                            ApplyAttendanceButton(
                                              active: !homeWProvider
                                                  .sendingHomeWork,
                                              title: 'Send',
                                              onTap: () async {
                                                try {
                                                  TeacherClass teacherClass =
                                                      (Providers.userPf(context)
                                                                  .userModel
                                                              as TeacherModel)
                                                          .teacherClass;
                                                  await Providers.homeWPf(
                                                          context)
                                                      .sendHomeWork(
                                                          teacherClass);
                                                  GlobalUtils.showSnackBar(
                                                    context: context,
                                                    message:
                                                        'Home work assigned',
                                                    snackBarType:
                                                        SnackBarType.success,
                                                  );
                                                  CNav.pop(context);
                                                } catch (e) {
                                                  GlobalUtils.showSnackBar(
                                                    context: context,
                                                    message: e.toString(),
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
