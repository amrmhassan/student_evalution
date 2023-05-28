// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_title.dart';
import 'package:student_evaluation/screens/home_screen/widgets/top_line_time_line.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../screens/home_screen/widgets/home_screen_appbar.dart';

class AdminGroupsScreen extends StatefulWidget {
  static const String routeName = '/AdminGroupsScreen';
  const AdminGroupsScreen({super.key});

  @override
  State<AdminGroupsScreen> createState() => _AdminGroupsScreenState();
}

class _AdminGroupsScreenState extends State<AdminGroupsScreen> {
  bool loading = false;
  StudentGrade studentGrade = StudentGrade.k1SectionA;
  TeacherClass teacherClass = TeacherClass.math;

  // void setStudentGrade(StudentGrade? grade) {
  //   setState(() {
  //     studentGrade = grade!;
  //   });
  //   loadData();
  // }

  // void setTeacherClass(TeacherClass? teacherClass) {
  //   setState(() {
  //     this.teacherClass = teacherClass!;
  //   });
  //   loadData();
  // }

  // void loadData() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   try {
  //     //!
  //     var res = await FirebaseDatabase.instance
  //         .ref(DBCollections.groupsMaps)
  //         .child(DBCollections.studentsGroups)
  //         .child(studentGrade.name)
  //         .child(teacherClass.name)
  //         .get();
  //     var first = res.value;

  //     var groups = res.children.map((e) {
  //       var test = (e.value as Map<dynamic, dynamic>);

  //       Map<String, dynamic> data = {};
  //       test.forEach((key, value) {
  //         data[key.toString()] = value;
  //       });
  //       GroupDataModel model = GroupDataModel.fromJSON(data);
  //       return model;
  //     }).toList();
  //   } catch (e) {
  //     GlobalUtils.showSnackBar(
  //       context: context,
  //       message: e.toString(),
  //       snackBarType: SnackBarType.error,
  //     );
  //   }
  //   setState(() {
  //     loading = false;
  //   });
  // }

  // @override
  // void initState() {
  //   loadData();
  //   super.initState();
  // }

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
          'All Groups',
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
                                              // Row(
                                              //   children: [
                                              //     Text(
                                              //       'Student Sections',
                                              //       style: h3TextStyle,
                                              //     ),
                                              //     Spacer(),
                                              //     DropdownButton(
                                              //       value: studentGrade,
                                              //       items: StudentGrade.values
                                              //           .map(
                                              //             (e) =>
                                              //                 DropdownMenuItem(
                                              //               key: Key(e.name),
                                              //               value: e,
                                              //               child: Text(
                                              //                 gradeTransformer(
                                              //                     e),
                                              //                 style:
                                              //                     h3InactiveTextStyle,
                                              //               ),
                                              //             ),
                                              //           )
                                              //           .toList(),
                                              //       onChanged: setStudentGrade,
                                              //     ),
                                              //   ],
                                              // ),
                                              // VSpace(factor: .5),
                                              // Row(
                                              //   children: [
                                              //     Text(
                                              //       'Student Class',
                                              //       style: h3TextStyle,
                                              //     ),
                                              //     Spacer(),
                                              //     DropdownButton(
                                              //       value: teacherClass,
                                              //       items: TeacherClass.values
                                              //           .map(
                                              //             (e) =>
                                              //                 DropdownMenuItem(
                                              //               key: Key(e.name),
                                              //               value: e,
                                              //               child: Text(
                                              //                 classTransformer(
                                              //                     e),
                                              //                 style:
                                              //                     h3InactiveTextStyle,
                                              //               ),
                                              //             ),
                                              //           )
                                              //           .toList(),
                                              //       onChanged: setTeacherClass,
                                              //     ),
                                              //   ],
                                              // ),

                                              VSpace(),

                                              VSpace(),
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
