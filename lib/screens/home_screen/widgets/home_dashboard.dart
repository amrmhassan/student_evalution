// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/double_modal_button.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/init/runtime_variables.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/attendance_screen/attendance_screen.dart';
import 'package:student_evaluation/screens/behavior_screen/behavior_screen.dart';
import 'package:student_evaluation/screens/home_screen/widgets/dash_board_item.dart';
import 'package:student_evaluation/screens/home_work_screen/home_work_screen.dart';
import 'package:student_evaluation/screens/medical_tracking_screen/medical_tracking_screen.dart';
import 'package:student_evaluation/screens/messages_screen/messages_screen.dart';
import 'package:student_evaluation/student_app/screens/student_behaviour_screen/student_behaviour_screen.dart';
import 'package:student_evaluation/student_app/screens/student_homework_screen/student_homework_screen.dart';
import 'package:student_evaluation/student_app/screens/student_materials_screen/student_materials_screen.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:intl/intl.dart' as intl;

import '../../../student_app/screens/students_attendance_screen/students_attendance_screen.dart';
import '../../../utils/providers_calls.dart';
import 'absent_modal.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var timeLineProvider = Providers.timeLP(context);
    var today = DateTime.now();
    bool future = timeLineProvider.currentDay
        .isAfter(DateTime(today.year, today.month, today.day + 1));
    UserType userType = Providers.userPf(context).userModel!.userType;

    return PaddingWrapper(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!future)
                DashboardItem(
                  title: 'Attendance',
                  iconName: 'attendance',
                  onTap: () {
                    if (userType == UserType.student) {
                      CNav.pushNamed(
                          context, StudentAttendanceScreen.routeName);
                    } else {
                      CNav.pushNamed(context, AttendanceScreen.routeName);
                    }
                  },
                ),
              DashboardItem(
                title: 'Home Works',
                iconName: 'home_work',
                onTap: () {
                  if (userType == UserType.student) {
                    CNav.pushNamed(context, StudentHomeWorkScreen.routeName);
                  } else {
                    CNav.pushNamed(context, HomeWorkScreen.routeName);
                  }
                },
              ),
              if (!future)
                DashboardItem(
                  title: 'Behavior',
                  iconName: 'behaviour',
                  onTap: () {
                    if (userType == UserType.student) {
                      CNav.pushNamed(context, StudentBehaviorScreen.routeName);
                    } else {
                      CNav.pushNamed(context, BehaviorScreen.routeName);
                    }
                  },
                ),
            ],
          ),
          if (userType == UserType.student)
            Column(
              children: [
                VSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DashboardItem(
                      title: 'Materials',
                      iconData: Icons.book_outlined,
                      onTap: () {
                        CNav.pushNamed(
                          context,
                          StudentMaterialsScreen.routeName,
                        );
                      },
                      color: colorTheme.kBlueColor,
                    ),
                    DashboardItem(
                      title: 'Medical Tracking',
                      iconData: Icons.medication_liquid_outlined,
                      onTap: () {
                        CNav.pushNamed(
                          context,
                          MedicalTrackingScreen.routeName,
                        );
                      },
                      color: colorTheme.kDangerColor,
                    ),
                    DashboardItem(
                      title: 'Absent Request',
                      iconData: Icons.remove_circle_outline,
                      onTap: () {
                        showBottomSheet(
                          context: context,
                          builder: (context) => AbsentModal(),
                        );
                      },
                      color: colorTheme.kGreenColor,
                    ),
                    // DashboardItem(
                    //   title: 'Time Table',
                    //   iconName: 'time_table',
                    //   onTap: () {},
                    // ),
                    // DashboardItem(
                    //   title: 'Messages',
                    //   iconName: 'messages',
                    //   onTap: () {
                    //     CNav.pushReplacementNamed(
                    //         context, MessagesScreen.routeName);
                    //     Providers.appSPf(context).setActiveNavBar(1);
                    //   },
                    // ),
                    // Opacity(
                    //   opacity: 0,
                    //   child: DashboardItem(
                    //     title: 'Messages',
                    //     iconName: 'messages',
                    //     onTap: null,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
