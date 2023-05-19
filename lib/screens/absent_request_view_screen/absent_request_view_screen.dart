// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/absent_request_model.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

import '../add_medical_state_screen/add_medical_state_screen.dart';
import '../home_screen/widgets/home_screen_appbar.dart';

class AbsentRequestViewScreen extends StatelessWidget {
  static const String routeName = '/AbsentRequestViewScreen';
  const AbsentRequestViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<AbsentRequestModel> absentData =
        ModalRoute.of(context)!.settings.arguments as List<AbsentRequestModel>;
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
                              'Medical Tracking',
                              style: h1TextStyle.copyWith(
                                color: colorTheme.kBlueColor,
                              ),
                            ),
                            VSpace(factor: .2),
                            HLine(
                              thickness: .4,
                              color: colorTheme.inActiveText,
                              borderRadius: 1000,
                            ),
                            VSpace(),
                            Column(
                              children: [
                                ...absentData.map((e) => Card(
                                      surfaceTintColor: Colors.transparent,
                                      color: Colors.white,
                                      child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: kHPad,
                                            vertical: kVPad / 2,
                                          ),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Absent Date: ${DateFormat('yyy-MM-dd').format(e.absentDate)}',
                                                    style: h3TextStyle,
                                                  ),
                                                  VSpace(),
                                                  Text(
                                                    e.reason,
                                                    style: h3LiteTextStyle,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    )),
                                VSpace(),
                                HLine(
                                  thickness: .4,
                                  color: colorTheme.inActiveText,
                                  borderRadius: 1000,
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

String _timesToString(List<int> times) {
  return times.fold(
      '', (previousValue, element) => '$previousValue ${getDayName(element)}');
}
