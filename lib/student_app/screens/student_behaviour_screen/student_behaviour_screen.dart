// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/student_app/models/behaviour_month_model.dart';
import 'package:student_evaluation/student_app/screens/students_attendance_screen/widgets/teacher_class_chooser.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../screens/home_screen/widgets/home_screen_appbar.dart';

class StudentBehaviorScreen extends StatefulWidget {
  static const String routeName = '/StudentBehaviorScreen';
  const StudentBehaviorScreen({super.key});

  @override
  State<StudentBehaviorScreen> createState() => _StudentBehaviorScreenState();
}

class _StudentBehaviorScreenState extends State<StudentBehaviorScreen> {
  @override
  void initState() {
    loadData();

    super.initState();
  }

  void loadData() async {
    Future.delayed(Duration.zero).then((value) {
      var model = Providers.userPf(context).userModel as StudentModel;
      Providers.studentBehavePf(context).loadBehaveData(model);
    });
  }

  @override
  Widget build(BuildContext context) {
    var studentBehaviourProvider = Providers.studentBehaveP(context);

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
                                  'Behaviour',
                                  style: h1TextStyle.copyWith(
                                    color: colorTheme.kBlueColor,
                                  ),
                                ),
                                Spacer(),
                                //? teacher class chooser
                                TeacherClassChooser(
                                  value: studentBehaviourProvider.activeClass,
                                  onChange: (value) {
                                    Providers.studentBehavePf(context)
                                        .setActiveClass(value);
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
                            studentBehaviourProvider.loading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: colorTheme.kBlueColor,
                                    ),
                                  )
                                : Column(
                                    children: [
                                      VSpace(factor: .3),
                                      //? here the behaviour report
                                      ...studentBehaviourProvider.months.map(
                                        (e) => StudentBehaviourCard(model: e),
                                      ),
                                      if (studentBehaviourProvider
                                          .months.isEmpty)
                                        Container(
                                          alignment: Alignment.center,
                                          padding:
                                              EdgeInsets.only(top: kVPad * 2),
                                          child: Text(
                                            'No Behaviour data yet on this class',
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

class StudentBehaviourCard extends StatelessWidget {
  final BehaviourMonthModel model;
  const StudentBehaviourCard({
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
          alignment: Alignment.center,
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
          child: Row(
            children: [
              Text(
                '${(model.avg * 100).toInt()}%',
                style: h4TextStyleInactive,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: RatingStars(
                    starCount: 5,
                    valueLabelVisibility: false,
                    starSize: largeIconSize,
                    maxValue: 5,
                    value: model.stars,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
