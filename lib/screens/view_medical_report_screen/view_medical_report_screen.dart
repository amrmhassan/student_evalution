// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/double_modal_button.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/medical_report_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../home_screen/widgets/home_screen_appbar.dart';

class ViewMedicalReportScreen extends StatelessWidget {
  static const String routeName = '/ViewMedicalReportScreen';
  const ViewMedicalReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MedicalReportModel reportModel =
        ModalRoute.of(context)!.settings.arguments as MedicalReportModel;
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
                              reportModel.name,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                VSpace(),
                                Text(
                                  reportModel.monthWeek,
                                  style: h3TextStyle,
                                ),
                                VSpace(factor: .5),
                                Text(
                                  reportModel.notes,
                                  style: h3LiteTextStyle,
                                ),
                                VSpace(),
                                Image.network(reportModel.imageLink!),
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
