// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/medical_report_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/view_medical_report_screen/view_medical_report_screen.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../core/navigation.dart';
import '../home_screen/widgets/home_screen_appbar.dart';

class MedicalReportsViewScreen extends StatefulWidget {
  static const String routeName = '/MedicalReportsViewScreen';
  const MedicalReportsViewScreen({super.key});

  @override
  State<MedicalReportsViewScreen> createState() =>
      _MedicalReportsViewScreenState();
}

class _MedicalReportsViewScreenState extends State<MedicalReportsViewScreen> {
  bool loadingReports = false;
  List<MedicalReportModel> myMedicalStates = [];

  @override
  void initState() {
    loadData();

    super.initState();
  }

  void loadData() async {
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        loadingReports = true;
        myMedicalStates.clear();
      });
      String studentId = Providers.userPf(context).userModel!.uid;
      var docs = (await FirebaseFirestore.instance
              .collection(DBCollections.medicalReport)
              .where('studentId', isEqualTo: studentId)
              .get())
          .docs;
      for (var doc in docs) {
        MedicalReportModel model = MedicalReportModel.fromJson(doc.data());
        myMedicalStates.add(model);
      }
      setState(() {
        loadingReports = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel? me = Providers.userPf(context).userModel;
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
                              'Medical Reports',
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
                            loadingReports
                                ? Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: colorTheme.kBlueColor,
                                    ),
                                  )
                                : myMedicalStates.isEmpty
                                    ? Container(
                                        constraints:
                                            BoxConstraints(minHeight: 200),
                                        child: Center(
                                          child: Text(
                                            'No medical reports yet',
                                            style: h3InactiveTextStyle,
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          ...myMedicalStates.map(
                                            (e) => Card(
                                              surfaceTintColor:
                                                  Colors.transparent,
                                              color: Colors.white,
                                              child: ButtonWrapper(
                                                onTap: () {
                                                  CNav.pushNamed(
                                                      context,
                                                      ViewMedicalReportScreen
                                                          .routeName,
                                                      arguments: e);
                                                },
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: kHPad,
                                                  vertical: kVPad / 2,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            e.name,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: h3TextStyle,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                e.monthWeek,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    h4TextStyleInactive,
                                                              ),
                                                            ],
                                                          ),
                                                          if (e
                                                              .notes.isNotEmpty)
                                                            Column(
                                                              children: [
                                                                VSpace(),
                                                                Text(
                                                                  e.notes,
                                                                  style:
                                                                      h4TextStyleInactive,
                                                                ),
                                                              ],
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 100,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          mediumBorderRadius,
                                                        ),
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      child: Container(
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        width: 100,
                                                        height: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            mediumBorderRadius,
                                                          ),
                                                        ),
                                                        child: Image.network(
                                                          e.imageLink!,
                                                          width:
                                                              double.infinity,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
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
