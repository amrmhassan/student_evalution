// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_evaluation/core/constants/classes_images.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_dashboard.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_table_card.dart';
import 'package:student_evaluation/transformers/enums_transformers.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../theming/constants/styles.dart';
import '../../../theming/theme_calls.dart';
import 'package:localization/localization.dart';

class HomeScreenUpdates extends StatefulWidget {
  const HomeScreenUpdates({
    super.key,
  });

  @override
  State<HomeScreenUpdates> createState() => _HomeScreenUpdatesState();
}

class _HomeScreenUpdatesState extends State<HomeScreenUpdates> {
  @override
  void initState() {
    var userModel = Providers.userPf(context).userModel;
    Future.delayed(Duration.zero).then((value) {
      Providers.timeLPf(context).loadTimeTable(userModel: userModel);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var timeLineProvider = Providers.timeLP(context);
    var userProvider = Providers.userP(context);
    var userModel = userProvider.userModel;

    return Column(
      children: [
        HomeDashboard(),
        VSpace(),
        PaddingWrapper(
          child: HLine(
            color: colorTheme.inActiveText,
            thickness: .8,
          ),
        ),
        VSpace(),
        timeLineProvider.loadingTimeTable
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  PaddingWrapper(
                    child: Row(
                      children: [
                        Text(
                          'time-table'.i18n(),
                          style: h2TextStyle,
                        ),
                        Spacer(),
                        Text(
                          userModel is TeacherModel
                              ? classTransformer(userModel.teacherClass)
                              : userModel is StudentModel
                                  ? gradeTransformer(
                                      userModel.studentGrade,
                                    )
                                  : '',
                          style: h4TextStyleInactive,
                        )
                      ],
                    ),
                  ),
                  VSpace(),
                  // here is the time table items
                  if (timeLineProvider.timeTable.isEmpty)
                    PaddingWrapper(
                        child: Column(
                      children: [
                        VSpace(factor: 2),
                        Text(
                          'Empty Time Table',
                          style: h4TextStyleInactive,
                        )
                      ],
                    )),
                  PaddingWrapper(
                    child: userModel is TeacherModel
                        ? Column(
                            children: [
                              ...timeLineProvider.timeTable.map(
                                (e) => TimeTableCard(
                                  title: gradeTransformer(e.studentGrade),
                                  imageLink: ConstantImages.getGradeImage(
                                    e.studentGrade,
                                  ),
                                  subTitle: DateFormat('hh:mm aa').format(
                                    DateTime(
                                      0,
                                      0,
                                      0,
                                      e.hour,
                                      e.minute,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              ...timeLineProvider.timeTable.map(
                                (e) => TimeTableCard(
                                  title: classTransformer(e.teacherClass),
                                  imageLink: ConstantImages.getClassImage(
                                    e.teacherClass,
                                  ),
                                  subTitle: DateFormat('hh:mm aa').format(
                                    DateTime(
                                      0,
                                      0,
                                      0,
                                      e.hour,
                                      e.minute,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                ],
              ),
        VSpace(),
      ],
    );
  }
}
