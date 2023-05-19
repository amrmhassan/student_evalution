// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_evaluation/core/types.dart';
import 'package:student_evaluation/fast_tools/widgets/double_modal_button.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/medical_state_model.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/utils/global_utils.dart';

import '../../core/navigation.dart';
import '../../fast_tools/widgets/custom_text_field.dart';
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
  void deleteMedicalState(String id) async {}
  @override
  void initState() {
    loadData();

    super.initState();
  }

  void loadData() async {
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        loadingStates = true;
      });
      var docs = (await FirebaseFirestore.instance
              .collection(DBCollections.medical)
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorTheme.kBlueColor.withOpacity(.5),
        flexibleSpace: HAppBarFlexibleArea(),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CNav.pushNamed(context, AddMedicalStateScreen.routeName);
        },
        child: Icon(
          Icons.add,
        ),
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
                            loadingStates
                                ? Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: colorTheme.kBlueColor,
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Text('data goes here'),
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

class AddMedicalStateModal extends StatelessWidget {
  const AddMedicalStateModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DoubleButtonsModal(
      onOk: () async {
        GlobalUtils.showSnackBar(
          context: context,
          message: 'Request Sent',
          snackBarType: SnackBarType.success,
        );
        CNav.pop(context);
      },
      title: 'Absent Request',
      okColor: colorTheme.kBlueColor,
      cancelColor: colorTheme.kDangerColor,
      okText: 'Send',
      autoPop: false,
      onCancel: () {
        CNav.pop(context);
      },
      extra: Column(
        children: [
          VSpace(),
          CustomTextField(
            title: 'Reason',
            padding: EdgeInsets.zero,
            autoFocus: true,
          ),
          VSpace(factor: .3),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Date',
                  style: h3TextStyle,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // var date = await showDatePicker(
                  //     context: context,
                  //     initialDate: selectedDate,
                  //     firstDate: DateTime.now(),
                  //     lastDate: DateTime.now().add(Duration(days: 33)));
                  // if (date == null) return;
                },
                child: Text(DateFormat('yyyy/MM/dd').format(DateTime.now())),
              ),
            ],
          ),
          VSpace(),
        ],
      ),
    );
  }
}
