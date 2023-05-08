// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/home_work_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/student_app/models/attendance_month_model.dart';
import 'package:student_evaluation/student_app/screens/students_attendance_screen/widgets/teacher_class_chooser.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/providers_calls.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../screens/home_screen/widgets/home_screen_appbar.dart';

class StudentHomeWorkScreen extends StatefulWidget {
  static const String routeName = '/StudentHomeWorkScreen';
  const StudentHomeWorkScreen({super.key});

  @override
  State<StudentHomeWorkScreen> createState() => _StudentHomeWorkScreenState();
}

class _StudentHomeWorkScreenState extends State<StudentHomeWorkScreen> {
  @override
  void initState() {
    loadData();

    super.initState();
  }

  void loadData() async {
    Future.delayed(Duration.zero).then((value) {
      var model = Providers.userPf(context).userModel as StudentModel;
      Providers.studentHWPf(context).loadHomeWorks(model.studentGrade);
    });
  }

  @override
  Widget build(BuildContext context) {
    var studentHWProvider = Providers.studentHWP(context);

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
                                  'Home Works',
                                  style: h1TextStyle.copyWith(
                                    color: colorTheme.kBlueColor,
                                  ),
                                ),
                                Spacer(),
                                //? teacher class chooser
                                TeacherClassChooser(
                                  value: studentHWProvider.activeTeacherClass,
                                  onChange: (value) {
                                    Providers.studentHWPf(context)
                                        .setActiveTeacherClass(value);
                                    loadData();
                                  },
                                ),
                                //? teacher class chooser
                              ],
                            ),
                            VSpace(),
                            HLine(
                              thickness: .4,
                              color: colorTheme.inActiveText,
                              borderRadius: 1000,
                            ),
                            VSpace(),
                            studentHWProvider.loadingHomeWork
                                ? Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: colorTheme.kBlueColor,
                                    ),
                                  )
                                : Column(
                                    children: [
                                      VSpace(factor: .3),
                                      //? here the home works
                                      ...studentHWProvider.homeWorks.map(
                                        (e) => HomeWorkCard(
                                          homeWorkModel: e,
                                        ),
                                      ),
                                      if (studentHWProvider.homeWorks.isEmpty)
                                        Container(
                                          alignment: Alignment.center,
                                          padding:
                                              EdgeInsets.only(top: kVPad * 2),
                                          child: Text(
                                            'No home works yet on this class',
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

class HomeWorkCard extends StatelessWidget {
  final HomeWorkModel homeWorkModel;
  const HomeWorkCard({
    super.key,
    required this.homeWorkModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VSpace(),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                homeWorkModel.description ?? 'No description',
                style: h3TextStyle,
                softWrap: true,
              ),
              VSpace(factor: .5),
              HLine(
                thickness: .3,
                color: colorTheme.inActiveText,
              ),
              VSpace(factor: .5),
              Text(
                'Start date ${homeWorkModel.startDate}',
                style: h4TextStyleInactive,
              ),
              VSpace(factor: .5),
              Text(
                'End date ${homeWorkModel.endDate}',
                style: h4TextStyleInactive,
              ),
              VSpace(factor: .5),
              ButtonWrapper(
                onTap: homeWorkModel.documentLink == null
                    ? null
                    : () {
                        launchUrl(
                          Uri.parse(homeWorkModel.documentLink!),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                padding: EdgeInsets.symmetric(
                    horizontal: kHPad, vertical: kHPad / 2),
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorTheme.backGround,
                  borderRadius: BorderRadius.circular(
                    mediumBorderRadius,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.link,
                      size: smallIconSize,
                      color: colorTheme.inActiveText,
                    ),
                    HSpace(factor: .3),
                    Text(
                      homeWorkModel.documentLink == null
                          ? 'No Document'
                          : 'Home Work Document',
                      style: h4TextStyleInactive,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
