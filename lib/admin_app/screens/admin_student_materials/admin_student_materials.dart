// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/core/types.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/material_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/home_screen/widgets/bottom_line_time_line.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_title.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_widget.dart';
import 'package:student_evaluation/screens/home_screen/widgets/top_line_time_line.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/transformers/enums_transformers.dart';
import 'package:student_evaluation/transformers/models_fields.dart';
import 'package:student_evaluation/transformers/remote_storage.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:student_evaluation/utils/providers_calls.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../screens/home_screen/widgets/home_screen_appbar.dart';

class AdminMaterialsScreen extends StatefulWidget {
  static const String routeName = '/AdminStudentMaterialScreen';
  const AdminMaterialsScreen({super.key});

  @override
  State<AdminMaterialsScreen> createState() => _AdminMaterialsScreenState();
}

class _AdminMaterialsScreenState extends State<AdminMaterialsScreen> {
  bool loading = false;
  bool uploading = false;
  StudentGrade studentGrade = StudentGrade.k1SectionA;
  TeacherClass teacherClass = TeacherClass.math;
  MaterialModel? model;

  void setStudentGrade(StudentGrade? grade) {
    setState(() {
      studentGrade = grade!;
    });
    loadData();
  }

  void setTeacherClass(TeacherClass? teacherClass) {
    setState(() {
      this.teacherClass = teacherClass!;
    });
    loadData();
  }

  void loadData() async {
    setState(() {
      loading = true;
      model = null;
    });
    try {
      var docs = (await FirebaseFirestore.instance
              .collection(DBCollections.studentsMaterials)
              .where(ModelsFields.teacherClass, isEqualTo: teacherClass.name)
              .where(ModelsFields.studentGrade, isEqualTo: studentGrade.name)
              .get())
          .docs;
      if (docs.isNotEmpty) {
        setState(() {
          model = MaterialModel.fromJSON(docs.first.data());
        });
      }
    } catch (e) {
      GlobalUtils.showSnackBar(
        context: context,
        message: e.toString(),
        snackBarType: SnackBarType.error,
      );
    }
    setState(() {
      loading = false;
    });
  }

  void handleChangeMaterial() async {
    setState(() {
      uploading = true;
    });
    try {
      var res = await FilePicker.platform.pickFiles(allowMultiple: false);
      if (res == null || res.files.isEmpty || res.files.first.path == null) {
        throw Exception('No files chosen');
      }
      String id = Uuid().v4();
      File file = File(res.files.first.path!);
      var snapshot = await FirebaseStorage.instance
          .ref(RemoteStorage.studentsMaterials)
          .child(id)
          .putFile(file);
      String link = await snapshot.ref.getDownloadURL();
      MaterialModel materialModel = MaterialModel(
        id: id,
        studentGrade: studentGrade,
        link: link,
        teacherClass: teacherClass,
      );
      await FirebaseFirestore.instance
          .collection(DBCollections.studentsMaterials)
          .doc(id)
          .set(materialModel.toJSON());
      setState(() {
        model = materialModel;
      });
    } catch (e) {
      GlobalUtils.showSnackBar(
        context: context,
        message: e.toString(),
        snackBarType: SnackBarType.error,
      );
    }
    setState(() {
      uploading = false;
    });
  }

  @override
  void initState() {
    // loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Providers.userP(context);

    if (userProvider.userModel == null) {
      return Scaffold(
        backgroundColor: colorTheme.backGround,
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: colorTheme.backGround,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorTheme.kBlueColor.withOpacity(.5),
        flexibleSpace: HAppBarFlexibleArea(),
        title: Text(
          'Student Materials',
          style: h1TextStyle.copyWith(
            color: Colors.white,
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: colorTheme.kBlueColor,
                    width: double.infinity,
                    height: 400,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: double.infinity),
                        VSpace(factor: 6),
                        if (userProvider.userModel is TeacherModel)
                          Column(
                            children: [
                              TopLineTimeLine(),
                              VSpace(factor: .9),
                              TimeLineTitle(),
                              VSpace(factor: .9),
                              TimeLineWidget(),
                              VSpace(factor: .9),
                              BottomLineTimeLine(),
                              VSpace(),
                            ],
                          ),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Column(
                              children: [
                                VSpace(factor: 1.5),
                                Container(
                                  constraints: BoxConstraints(minHeight: 500),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: colorTheme.backGround,
                                      borderRadius: BorderRadius.only(
                                        topLeft:
                                            Radius.circular(largeBorderRadius),
                                        topRight:
                                            Radius.circular(largeBorderRadius),
                                      )),
                                  child: loading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : PaddingWrapper(
                                          child: Column(
                                            children: [
                                              VSpace(factor: 1.5),
                                              //?
                                              Row(
                                                children: [
                                                  Text(
                                                    'Student Sections',
                                                    style: h3TextStyle,
                                                  ),
                                                  Spacer(),
                                                  DropdownButton(
                                                    value: studentGrade,
                                                    items: StudentGrade.values
                                                        .map(
                                                          (e) =>
                                                              DropdownMenuItem(
                                                            key: Key(e.name),
                                                            value: e,
                                                            child: Text(
                                                              gradeTransformer(
                                                                  e),
                                                              style:
                                                                  h3InactiveTextStyle,
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: setStudentGrade,
                                                  ),
                                                ],
                                              ),
                                              VSpace(factor: .5),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Student Class',
                                                    style: h3TextStyle,
                                                  ),
                                                  Spacer(),
                                                  DropdownButton(
                                                    value: teacherClass,
                                                    items: TeacherClass.values
                                                        .map(
                                                          (e) =>
                                                              DropdownMenuItem(
                                                            key: Key(e.name),
                                                            value: e,
                                                            child: Text(
                                                              classTransformer(
                                                                  e),
                                                              style:
                                                                  h3InactiveTextStyle,
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: setTeacherClass,
                                                  ),
                                                ],
                                              ),

                                              VSpace(),
                                              ButtonWrapper(
                                                onTap: handleChangeMaterial,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: kHPad,
                                                  vertical: kVPad / 2,
                                                ),
                                                width: double.infinity,
                                                backgroundColor: Colors.white,
                                                child: Center(
                                                  child: uploading
                                                      ? CircularProgressIndicator()
                                                      : Text(
                                                          'Click to choose document',
                                                          style:
                                                              h3InactiveTextStyle,
                                                        ),
                                                ),
                                              ),
                                              VSpace(),
                                              if (model != null)
                                                ButtonWrapper(
                                                  onTap: () {
                                                    launchUrl(
                                                      Uri.parse(model!.link),
                                                      mode: LaunchMode
                                                          .externalApplication,
                                                    );
                                                  },
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: kHPad,
                                                    vertical: kVPad / 2,
                                                  ),
                                                  border: Border.all(
                                                    color:
                                                        colorTheme.kBlueColor,
                                                    width: 1,
                                                  ),
                                                  width: double.infinity,
                                                  backgroundColor: Colors.white,
                                                  child: Center(
                                                    child: uploading
                                                        ? CircularProgressIndicator()
                                                        : Text(
                                                            'Click to view material',
                                                            style:
                                                                h3InactiveTextStyle,
                                                          ),
                                                  ),
                                                ),
                                              VSpace(),
                                              // ButtonWrapper(
                                              //   padding: EdgeInsets.symmetric(
                                              //     horizontal: kHPad,
                                              //     vertical: kVPad / 2,
                                              //   ),
                                              //   onTap: () {},
                                              //   backgroundColor:
                                              //       colorTheme.kBlueColor,
                                              //   child: Text(
                                              //     'Save',
                                              //     style: h3TextStyle.copyWith(
                                              //         color: Colors.white),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
