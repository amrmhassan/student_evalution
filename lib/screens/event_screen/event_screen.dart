// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/events_model.dart';
import 'package:student_evaluation/screens/event_screen/widgets/event_info_item.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

import '../home_screen/widgets/home_screen_appbar.dart';

class EventScreen extends StatelessWidget {
  static const String routeName = '/EventScreen';
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EventModel eventModel =
        ModalRoute.of(context)!.settings.arguments as EventModel;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorTheme.kBlueColor.withOpacity(.5),
        flexibleSpace: HAppBarFlexibleArea(),
        foregroundColor: Colors.white,
        title: Text(
          eventModel.title,
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
                            if (eventModel.imageLink != null)
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    mediumBorderRadius,
                                  ),
                                ),
                                child: Image.network(
                                  eventModel.imageLink!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            VSpace(),
                            EventInfoItem(
                              title: 'Event Date',
                              value: DateFormat('dd/MM/yyyy | hh:mm aa').format(
                                eventModel.date,
                              ),
                            ),
                            VSpace(),
                            EventInfoItem(
                              title: 'Place',
                              value: eventModel.place,
                            ),
                            VSpace(),
                            Text(
                              'Details:',
                              style: h2TextStyle,
                            ),
                            Text(
                              eventModel.details,
                            ),
                            VSpace(),
                            Text(
                              'Notes:',
                              style: h2TextStyle,
                            ),
                            Text(
                              eventModel.notes,
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
          ),
        ],
      ),
    );
  }
}
