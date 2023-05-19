// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/medical_state_model.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:student_evaluation/utils/providers_calls.dart';
import 'package:uuid/uuid.dart';

import '../../core/types.dart';
import '../../transformers/collections.dart';
import '../home_screen/widgets/home_screen_appbar.dart';

class AddMedicalStateScreen extends StatefulWidget {
  static const String routeName = '/AddMedicalStateScreen';
  const AddMedicalStateScreen({super.key});

  @override
  State<AddMedicalStateScreen> createState() => _AddMedicalStateScreenState();
}

class _AddMedicalStateScreenState extends State<AddMedicalStateScreen> {
  List<int> activeDays = [];
  void toggleNumber(int n) {
    if (activeDays.contains(n)) return;
    activeDays.add(n);
    setState(() {});
  }

  TextEditingController medicineNameController = TextEditingController();
  TextEditingController notesController = TextEditingController();

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
                              'Add Medical State',
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
                                CustomTextField(
                                  controller: medicineNameController,
                                  title: 'Enter medicine name',
                                  padding: EdgeInsets.zero,
                                ),
                                VSpace(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    7,
                                    (index) => GestureDetector(
                                      onTap: () {
                                        toggleNumber(index + 1);
                                      },
                                      child: DatePickerDay(
                                        dayNumber: index,
                                        active: activeDays.contains(index + 1),
                                      ),
                                    ),
                                  ),
                                ),
                                VSpace(),
                                CustomTextField(
                                  controller: notesController,
                                  title: 'Any Notes',
                                  padding: EdgeInsets.zero,
                                  maxLines: 3,
                                  textInputAction: TextInputAction.newline,
                                ),
                                VSpace(),
                                HLine(
                                  thickness: .4,
                                  color: colorTheme.inActiveText,
                                  borderRadius: 1000,
                                ),
                                ButtonWrapper(
                                  onTap: () async {
                                    String name = medicineNameController.text;
                                    String notes = notesController.text;
                                    if (name.isEmpty) return;
                                    String id = Uuid().v4();
                                    String userId = Providers.userPf(context)
                                        .userModel!
                                        .uid;
                                    MedicalStateModel stateModel =
                                        MedicalStateModel(
                                      id: id,
                                      studentId: userId,
                                      medicalName: name,
                                      weekOfDay: activeDays,
                                      notes: notes,
                                    );
                                    await FirebaseFirestore.instance
                                        .collection(DBCollections.medical)
                                        .doc(id)
                                        .set(stateModel.toJson());
                                    GlobalUtils.showSnackBar(
                                        context: context,
                                        message: 'Medical Tracking State Sent',
                                        snackBarType: SnackBarType.success);
                                    CNav.pop(context);
                                  },
                                  backgroundColor: colorTheme.kBlueColor,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: kHPad,
                                    vertical: kVPad / 2,
                                  ),
                                  child: Text(
                                    'Send',
                                    style: h3LightTextStyle,
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

class DatePickerDay extends StatelessWidget {
  final int dayNumber;
  final bool active;
  const DatePickerDay({
    super.key,
    required this.dayNumber,
    this.active = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: active ? colorTheme.kBlueColor : null,
        borderRadius: BorderRadius.circular(
          1000,
        ),
      ),
      padding: EdgeInsets.all(largePadding),
      child: Text(
        getDayName(dayNumber + 1),
        style: h4LiteTextStyle.copyWith(color: active ? Colors.white : null),
      ),
    );
  }
}

String getDayName(int dayNumber) {
  switch (dayNumber) {
    case 1:
      return DateFormat.E().format(DateTime(2023, 1, 1));
    case 2:
      return DateFormat.E().format(DateTime(2023, 1, 2));
    case 3:
      return DateFormat.E().format(DateTime(2023, 1, 3));
    case 4:
      return DateFormat.E().format(DateTime(2023, 1, 4));
    case 5:
      return DateFormat.E().format(DateTime(2023, 1, 5));
    case 6:
      return DateFormat.E().format(DateTime(2023, 1, 6));
    case 7:
      return DateFormat.E().format(DateTime(2023, 1, 7));
    default:
      return '';
  }
}
