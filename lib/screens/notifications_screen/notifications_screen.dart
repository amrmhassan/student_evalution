// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_evaluation/core/constants/classes_images.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_table_card.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/transformers/enums_transformers.dart';

import '../../utils/providers_calls.dart';
import '../home_screen/widgets/home_screen_appbar.dart';

class NotificationsScreen extends StatefulWidget {
  static const String routeName = '/NotificationsScreen';
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    loadData();

    super.initState();
  }

  void loadData() async {
    Future.delayed(Duration.zero).then((value) {
      var userModel = Providers.userPf(context).userModel!;
      Providers.notifyPf(context).watchAllNotifications(userModel.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    var notifyProvider = Providers.notifyPf(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorTheme.kBlueColor.withOpacity(.5),
        flexibleSpace: HAppBarFlexibleArea(),
        foregroundColor: Colors.white,
        title: Text(
          'Notifications',
          style: h1TextStyle.copyWith(
            color: Colors.white,
          ),
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
                      constraints: BoxConstraints(minHeight: 400),
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
                            VSpace(factor: 2),
                            if (notifyProvider.unwatchedHomeworks.isEmpty)
                              Center(
                                child: Text(
                                  'No recent notifications',
                                  style: h4TextStyleInactive,
                                ),
                              ),
                            ...notifyProvider.unwatchedHomeworks.map(
                              (e) => TimeTableCard(
                                title:
                                    '${classTransformer(e.teacherClass)} home work',
                                subTitle: e.description,
                                imageLink: ConstantImages.getClassImage(
                                  e.teacherClass,
                                ),
                              ),
                            ),
                            VSpace(factor: 1),
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
