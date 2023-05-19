// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/core/types.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/medical_state_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../core/navigation.dart';
import '../add_medical_state_screen/add_medical_state_screen.dart';
import '../home_screen/widgets/home_screen_appbar.dart';

class MedicalTrackingScreen extends StatefulWidget {
  static const String routeName = '/MedicalTrackingScreen';
  const MedicalTrackingScreen({super.key});

  @override
  State<MedicalTrackingScreen> createState() => _MedicalTrackingScreenState();
}

class _MedicalTrackingScreenState extends State<MedicalTrackingScreen> {
  bool loadingStates = false;
  List<MedicalStateModel> myMedicalStates = [];
  void addMedicalState() async {}
  void deleteMedicalState(String id) async {
    await FirebaseFirestore.instance
        .collection(DBCollections.medical)
        .doc(id)
        .delete();
    setState(() {
      myMedicalStates.removeWhere((element) => element.id == id);
    });
    GlobalUtils.showSnackBar(
      context: context,
      message: 'Deleted',
      snackBarType: SnackBarType.info,
    );
  }

  @override
  void initState() {
    loadData();

    super.initState();
  }

  void loadData() async {
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        loadingStates = true;
        myMedicalStates.clear();
      });
      String studentId = ModalRoute.of(context)!.settings.arguments as String;
      var docs = (await FirebaseFirestore.instance
              .collection(DBCollections.medical)
              .where('studentId', isEqualTo: studentId)
              .get())
          .docs;
      for (var doc in docs) {
        MedicalStateModel model = MedicalStateModel.fromJson(doc.data());
        myMedicalStates.add(model);
      }
      setState(() {
        loadingStates = false;
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
      floatingActionButton: me is StudentModel
          ? FloatingActionButton(
              onPressed: () async {
                await CNav.pushNamed(context, AddMedicalStateScreen.routeName);
                loadData();
              },
              child: Icon(
                Icons.add,
              ),
            )
          : null,
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
                            loadingStates
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
                                            'No medical states added',
                                            style: h3InactiveTextStyle,
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          ...myMedicalStates.map((e) =>
                                              Dismissible(
                                                onDismissed: (direction) {
                                                  deleteMedicalState(e.id);
                                                },
                                                key: UniqueKey(),
                                                direction: me is StudentModel
                                                    ? DismissDirection
                                                        .endToStart
                                                    : DismissDirection.none,
                                                background: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  padding: EdgeInsets.only(
                                                      right: kHPad),
                                                  color:
                                                      colorTheme.kDangerColor,
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                child: Card(
                                                  surfaceTintColor:
                                                      Colors.transparent,
                                                  color: Colors.white,
                                                  child: Container(
                                                      width: double.infinity,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: kHPad,
                                                        vertical: kVPad / 2,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                e.medicalName,
                                                                style:
                                                                    h3TextStyle,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '${e.timeOfDay} / ${_timesToString(e.weekOfDay)}',
                                                                    style:
                                                                        h4TextStyleInactive,
                                                                  ),
                                                                ],
                                                              ),
                                                              if (e.notes
                                                                  .isNotEmpty)
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
                                                        ],
                                                      )),
                                                ),
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
