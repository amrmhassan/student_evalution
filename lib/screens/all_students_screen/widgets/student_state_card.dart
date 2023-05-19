// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/models/absent_request_model.dart';
import 'package:student_evaluation/models/medical_state_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/absent_request_view_screen/absent_request_view_screen.dart';
import 'package:student_evaluation/screens/medical_tracking_screen/medical_tracking_screen.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../messages_screen/widgets/user_avatar.dart';

class StudentStateCard extends StatefulWidget {
  final StudentModel userModel;

  const StudentStateCard({
    super.key,
    required this.userModel,
  });

  @override
  State<StudentStateCard> createState() => _StudentStateCardState();
}

class _StudentStateCardState extends State<StudentStateCard> {
  bool loadingUserData = false;
  List<MedicalStateModel> medicalState = [];
  List<AbsentRequestModel> absentState = [];

  void loadUserData() async {
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        loadingUserData = true;
      });
      absentState = await Providers.allStudentsPf(context)
          .loadUserAbsentState(widget.userModel.uid);
      medicalState = await Providers.allStudentsPf(context)
          .loadUserMedicalStates(widget.userModel.uid);

      setState(() {
        loadingUserData = false;
      });
    });
  }

  @override
  void initState() {
    loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: kVPad / 2,
      ),
      child: Row(
        children: [
          UserAvatar(userImage: widget.userModel.userImage),
          HSpace(factor: .5),
          Text(
            widget.userModel.name,
            style: h3InactiveTextStyle.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
          loadingUserData
              ? Expanded(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Loading...',
                      style: h4TextStyleInactive,
                    ),
                  ],
                ))
              : Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StudentStateButton(
                        title: 'Medical',
                        active: medicalState.isNotEmpty,
                        onTap: () {
                          CNav.pushNamed(
                            context,
                            MedicalTrackingScreen.routeName,
                            arguments: widget.userModel.uid,
                          );
                        },
                      ),
                      HSpace(factor: .2),
                      StudentStateButton(
                        title: 'Request',
                        active: absentState.isNotEmpty,
                        onTap: () {
                          CNav.pushNamed(
                            context,
                            AbsentRequestViewScreen.routeName,
                            arguments: absentState,
                          );
                        },
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class StudentStateButton extends StatelessWidget {
  final String title;
  final bool active;
  final VoidCallback onTap;

  const StudentStateButton({
    super.key,
    required this.title,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      backgroundColor: active ? colorTheme.kBlueColor : Colors.transparent,
      onTap: onTap,
      active: active,
      inactiveColor: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: kHPad / 2,
        vertical: kVPad / 3,
      ),
      child: Text(
        title,
        style: h3LiteTextStyle.copyWith(
          color: active ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
