// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:student_evaluation/admin_app/screens/admin_add_time_table_screen/admin_add_time_table_screen.dart';
import 'package:student_evaluation/core/constants/classes_images.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/core/types.dart';
import 'package:student_evaluation/fast_tools/widgets/double_modal_button.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/time_table_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_widget.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_table_card.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/transformers/models_fields.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../screens/home_screen/widgets/home_screen_appbar.dart';
import '../../../transformers/collections.dart';
import '../../../transformers/enums_transformers.dart';

class AdminTimeTableScreen extends StatefulWidget {
  static const String routeName = '/AdminTimeTableScreen';
  const AdminTimeTableScreen({super.key});

  @override
  State<AdminTimeTableScreen> createState() => _AdminTimeTableScreenState();
}

class _AdminTimeTableScreenState extends State<AdminTimeTableScreen> {
  bool loading = false;
  StudentGrade studentGrade = StudentGrade.k1SectionA;
  final List<TimeTableModel> _tableItems = [];

  List<TimeTableModel> get tableItems {
    var timeLProvider = Providers.timeLP(context);
    // active
    int weekDay = timeLProvider.currentDay.weekday;
    // current

    var res = _tableItems.where((element) {
      return element.studentGrade == studentGrade && element.weekDay == weekDay;
    }).toList();
    res.sort((a, b) => (a.hour + a.minute).compareTo(b.hour + b.minute));
    return res;
  }

  Future<void> deleteTimeTable(String id) async {
    setState(() {
      _tableItems.removeWhere((element) => element.id == id);
    });
    await FirebaseFirestore.instance
        .collection(DBCollections.timeTable)
        .doc(id)
        .delete();
    GlobalUtils.showSnackBar(
        context: context, message: 'Time table item deleted');
  }

  void setStudentGrade(StudentGrade? grade) {
    setState(() {
      studentGrade = grade!;
    });
    loadCurrentTimeTable();
  }

  void loadCurrentTimeTable() async {
    _tableItems.clear();
    setState(() {
      loading = true;
    });
    try {
      var currentWeekOfDay = Providers.timeLPf(context).currentDay.weekday;
      var docs = (await FirebaseFirestore.instance
              .collection(DBCollections.timeTable)
              .where(
                ModelsFields.studentGrade,
                isEqualTo: studentGrade.name,
              )
              .where(
                ModelsFields.weekDay,
                isEqualTo: currentWeekOfDay,
              )
              .get())
          .docs;
      for (var doc in docs) {
        _tableItems.add(TimeTableModel.fromJSON(doc.data()));
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

  @override
  void initState() {
    loadCurrentTimeTable();
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
          'time-table'.i18n(),
          style: h1TextStyle.copyWith(
            color: Colors.white,
          ),
        ),
        foregroundColor: Colors.white,
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  await CNav.pushNamed(
                    context,
                    AdminAddTimeTableScreen.routeName,
                  );
                  loadCurrentTimeTable();
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              HSpace(factor: .5),
            ],
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: colorTheme.kBlueColor,
                width: double.infinity,
                height: 100,
              ),
              SizedBox(width: double.infinity),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: colorTheme.kBlueColor,
                        ),
                        child: PaddingWrapper(
                          child: Column(
                            children: [
                              TimeLineWidget(
                                onChanged: (dateTime) {
                                  loadCurrentTimeTable();
                                },
                              ),

                              VSpace(),
                              // TimePickerDialog(
                              //   initialTime: TimeOfDay.now(),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      VSpace(),
                      loading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : PaddingWrapper(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Student grade',
                                        style: h3TextStyle,
                                      ),
                                      Spacer(),
                                      DropdownButton(
                                        value: studentGrade,
                                        items: StudentGrade.values
                                            .map(
                                              (e) => DropdownMenuItem(
                                                key: Key(e.name),
                                                value: e,
                                                child: Text(
                                                  gradeTransformer(e),
                                                  style: h3InactiveTextStyle,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: setStudentGrade,
                                      ),
                                    ],
                                  ),
                                  VSpace(),
                                  if (tableItems.isEmpty)
                                    Text(
                                      'Empty table for this class and this grade',
                                      style: h4TextStyleInactive,
                                    ),
                                  ...tableItems.map(
                                    (e) => Dismissible(
                                      key: Key(e.id),
                                      confirmDismiss: (direction) async {
                                        bool delete = false;
                                        var res = await showModalBottomSheet(
                                          context: context,
                                          builder: (context) =>
                                              DoubleButtonsModal(
                                            onOk: () {
                                              Navigator.pop(context, true);
                                            },
                                            onCancel: () {
                                              Navigator.pop(context);
                                            },
                                            okColor: colorTheme.kDangerColor,
                                            cancelColor:
                                                colorTheme.inActiveText,
                                            title: 'Delete this class time?',
                                            autoPop: false,
                                          ),
                                        );
                                        delete = (res == true);
                                        //? delete here
                                        if (delete) {
                                          await deleteTimeTable(e.id);
                                        }
                                        return Future.value(delete);
                                      },
                                      direction: DismissDirection.endToStart,
                                      background: Container(
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(
                                          right: largePadding * 3,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              largeBorderRadius),
                                          color: colorTheme.kDangerColor,
                                        ),
                                        width: double.infinity,
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: TimeTableCard(
                                        title: classTransformer(e.teacherClass),
                                        subTitle: DateFormat('hh:mm aa').format(
                                          DateTime(
                                            0,
                                            0,
                                            0,
                                            e.hour,
                                            e.minute,
                                          ),
                                        ),
                                        imageLink: ConstantImages.getClassImage(
                                            e.teacherClass),
                                      ),
                                    ),
                                  ),
                                  VSpace(),
                                ],
                              ),
                            )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
