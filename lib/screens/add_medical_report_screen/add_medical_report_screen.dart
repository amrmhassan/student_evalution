// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/medical_report_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/transformers/remote_storage.dart';
import 'package:uuid/uuid.dart';

import '../../core/navigation.dart';
import '../../core/types.dart';
import '../../fast_tools/widgets/custom_text_field.dart';
import '../../fast_tools/widgets/h_space.dart';
import '../../transformers/collections.dart';
import '../../utils/global_utils.dart';
import '../home_screen/widgets/home_screen_appbar.dart';

class AddMedicalReportScreen extends StatefulWidget {
  static const String routeName = '/AddMedicalReportScreen';
  const AddMedicalReportScreen({super.key});

  @override
  State<AddMedicalReportScreen> createState() => _AddMedicalReportScreenState();
}

class _AddMedicalReportScreenState extends State<AddMedicalReportScreen> {
  DateTime now = DateTime.now();
  int get weekOfMonth => ((now.day - 1) ~/ 7) + 1;
  String get month => DateFormat('MMMM').format(now);

  List<String> get monthWeeks =>
      List.generate(5, (index) => '$month/${now.year}  - week ${index + 1}');

  int activeWeek = 0;
  late StudentModel studentModel;
  TaskSnapshot? ref;

  String? imageLink;
  bool uploading = false;
  Future<void> uploadDocument(File file) async {
    setState(() {
      uploading = true;
    });
    String userId = studentModel.uid;
    ref = await FirebaseStorage.instance
        .ref(RemoteStorage.medicalReports)
        .child(userId)
        .putFile(file);
    imageLink = await ref?.ref.getDownloadURL();
    setState(() {
      uploading = false;
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      studentModel = ModalRoute.of(context)!.settings.arguments as StudentModel;
    });

    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  bool sendingReport = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorTheme.backGround,
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
                              'Add Medical Report',
                              style: h1TextStyle.copyWith(
                                color: colorTheme.kBlueColor,
                              ),
                            ),
                            Text(
                              'We are in $month - week $weekOfMonth',
                              style: h3InactiveTextStyle,
                            ),
                            VSpace(),
                            HLine(
                              thickness: .4,
                              color: colorTheme.inActiveText,
                              borderRadius: 1000,
                            ),
                            VSpace(),
                            Column(
                              children: [
                                Text(
                                  'Week 5 is just the remaining 2 days in the month at the end',
                                  style: h4TextStyleInactive,
                                ),
                                VSpace(
                                  factor: .5,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: kHPad / 2,
                                        vertical: kVPad / 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          mediumBorderRadius,
                                        ),
                                        border: Border.all(
                                          width: .3,
                                          color: colorTheme.inActiveText
                                              .withOpacity(.7),
                                        ),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          Row(
                                            children: [
                                              Spacer(),
                                              Icon(
                                                FontAwesomeIcons.chevronDown,
                                                size: smallIconSize,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: DropdownButton(
                                              underline: SizedBox(),
                                              style: h2TextStyle.copyWith(
                                                color: colorTheme.kBlueColor,
                                              ),
                                              icon: SizedBox(),
                                              value: monthWeeks[activeWeek],
                                              items: monthWeeks
                                                  .map(
                                                    (e) => DropdownMenuItem(
                                                      key: Key(e),
                                                      value: e,
                                                      child: Text(
                                                        e,
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  activeWeek = monthWeeks
                                                      .indexOf(value!);
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                VSpace(),
                                HLine(
                                  thickness: .4,
                                  color: colorTheme.inActiveText,
                                  borderRadius: 1000,
                                ),
                                VSpace(),
                                CustomTextField(
                                  title: 'Enter report name',
                                  padding: EdgeInsets.zero,
                                  controller: nameController,
                                ),
                                VSpace(),
                                ButtonWrapper(
                                  onTap: () async {
                                    try {
                                      var res = await ImagePicker.platform
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (res == null) {
                                        GlobalUtils.showSnackBar(
                                          context: context,
                                          message: 'Couldn\'t choose an image',
                                          snackBarType: SnackBarType.error,
                                        );
                                        return;
                                      }
                                      File file = File(res.path);
                                      await uploadDocument(file);
                                    } catch (e) {
                                      GlobalUtils.fastSnackBar(
                                        msg: 'Error uploading image',
                                        snackBarType: SnackBarType.error,
                                      );
                                    }
                                  },
                                  padding: EdgeInsets.symmetric(
                                    horizontal: kHPad / 2,
                                    vertical: kVPad,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      mediumBorderRadius,
                                    ),
                                    border: Border.all(
                                      width: .3,
                                      color: colorTheme.inActiveText
                                          .withOpacity(.7),
                                    ),
                                  ),
                                  width: double.infinity,
                                  child: uploading
                                      ? Center(
                                          child: Column(
                                            children: [
                                              CircularProgressIndicator(
                                                strokeWidth: 3,
                                              ),
                                              VSpace(factor: .4),
                                              Text(
                                                'Uploading',
                                                style: h4TextStyleInactive,
                                              ),
                                            ],
                                          ),
                                        )
                                      : imageLink == null
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    width: double.infinity),
                                                Image.asset(
                                                  'assets/icons/upload.png',
                                                  width: largeIconSize,
                                                ),
                                                VSpace(factor: .5),
                                                Text(
                                                  'Upload Document',
                                                  style: h2TextStyle.copyWith(
                                                    color: colorTheme
                                                        .inActiveText
                                                        .withOpacity(.6),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Expanded(
                                                  child: Image.network(
                                                    imageLink!,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                HSpace(),
                                                IconButton(
                                                  onPressed: () async {
                                                    await ref?.ref.delete();
                                                    setState(() {
                                                      imageLink = null;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.close,
                                                    color:
                                                        colorTheme.kDangerColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                ),
                                VSpace(factor: .5),
                                CustomTextField(
                                  controller: notesController,
                                  title: 'Enter notes',
                                  padding: EdgeInsets.zero,
                                  maxLines: 3,
                                  textInputAction: TextInputAction.newline,
                                ),
                                VSpace(),
                                ButtonWrapper(
                                  active: !sendingReport,
                                  onTap: () async {
                                    String name = nameController.text;
                                    String notes = notesController.text;
                                    if (name.isEmpty || imageLink == null) {
                                      return;
                                    }
                                    setState(() {
                                      sendingReport = true;
                                    });
                                    String id = Uuid().v4();
                                    MedicalReportModel model =
                                        MedicalReportModel(
                                      name: name,
                                      imageLink: imageLink,
                                      notes: notes,
                                      monthWeek: monthWeeks[activeWeek],
                                      createdAt:
                                          DateTime.now().toIso8601String(),
                                      studentId: studentModel.uid,
                                    );

                                    await FirebaseFirestore.instance
                                        .collection(DBCollections.medicalReport)
                                        .doc(id)
                                        .set(model.toJson());
                                    GlobalUtils.showSnackBar(
                                        context: context,
                                        message: 'Medical report saved',
                                        snackBarType: SnackBarType.success);
                                    setState(() {
                                      sendingReport = false;
                                    });
                                    CNav.pop(context);
                                  },
                                  backgroundColor: colorTheme.kBlueColor,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: kHPad,
                                    vertical: kVPad / 2,
                                  ),
                                  child: Text(
                                    'Save',
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
