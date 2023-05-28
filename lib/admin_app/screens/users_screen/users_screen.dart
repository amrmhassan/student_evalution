// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/admin_app/screens/signup_screen/signup_screen.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/core/types.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/home_screen/widgets/bottom_line_time_line.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_title.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_widget.dart';
import 'package:student_evaluation/screens/home_screen/widgets/top_line_time_line.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/user_avatar.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../screens/home_screen/widgets/home_screen_appbar.dart';

class AdminUsersScreen extends StatefulWidget {
  static const String routeName = '/AdminUsersScreen';
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  bool loading = false;
  List<UserModel> users = [];

  void loadUsers() async {
    setState(() {
      users.clear();
      loading = true;
    });
    try {
      var docs = (await FirebaseFirestore.instance
              .collection(DBCollections.users)
              .get())
          .docs;
      for (var doc in docs) {
        users.add(UserModel.fromJSON(doc.data()));
      }
      setState(() {});
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
    loadUsers();
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
          'Users',
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
                                  child: PaddingWrapper(
                                    child: Column(
                                      children: [
                                        VSpace(factor: 1.5),
                                        //?
                                        loading
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : Column(
                                                children: users
                                                    .map((e) => Card(
                                                          surfaceTintColor:
                                                              Colors
                                                                  .transparent,
                                                          color: Colors.white,
                                                          child: ButtonWrapper(
                                                              onTap: () {
                                                                CNav.pushReplacementNamed(
                                                                  context,
                                                                  SignUpScreen
                                                                      .routeName,
                                                                  arguments: e,
                                                                );
                                                              },
                                                              width: double
                                                                  .infinity,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                horizontal:
                                                                    kHPad,
                                                                vertical:
                                                                    kVPad / 2,
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  UserAvatar(
                                                                    userImage: e
                                                                        .userImage,
                                                                  ),
                                                                  HSpace(),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        e.name,
                                                                        style:
                                                                            h3TextStyle,
                                                                      ),
                                                                      Text(
                                                                        e.email,
                                                                        style:
                                                                            h4TextStyleInactive,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              )),
                                                        ))
                                                    .toList(),
                                              ),

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
