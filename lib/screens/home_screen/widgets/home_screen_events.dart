// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/add_event_screen/add_event_screen.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_table_card.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../core/navigation.dart';
import '../../event_screen/event_screen.dart';

class HomeScreenEvents extends StatefulWidget {
  const HomeScreenEvents({
    super.key,
  });

  @override
  State<HomeScreenEvents> createState() => _HomeScreenEventsState();
}

class _HomeScreenEventsState extends State<HomeScreenEvents> {
  DateTime? latestEventDate;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await Providers.eventPf(context).loadAllEvents();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var eventProvider = Providers.eventP(context);
    var userProvider = Providers.userP(context);

    return Container(
      constraints: BoxConstraints(minHeight: 400),
      child: PaddingWrapper(
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                if (userProvider.userModel is TeacherModel)
                  IconButton(
                    onPressed: () {
                      CNav.pushNamed(context, AddEventScreen.routeName);
                    },
                    icon: Image.asset(
                      'assets/icons/add.png',
                      width: largeIconSize,
                      color: colorTheme.inActiveText,
                    ),
                  ),
              ],
            ),
            // VSpace(factor: .4),
            eventProvider.loadingEvents
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var event in eventProvider.events)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Builder(
                              builder: (context) {
                                bool equals =
                                    datesChecker(event.date, latestEventDate);
                                if (!equals) {
                                  latestEventDate = event.date;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${DateFormat('MMM, yyy').format(event.date)} Events',
                                        style: h2TextStyle,
                                      ),
                                      VSpace(factor: .5),
                                    ],
                                  );
                                } else {
                                  return SizedBox();
                                }
                              },
                            ),
                            TimeTableCard(
                              title: event.title,
                              subTitle: event.subTitle,
                              imageLink: event.imageLink,
                              onTap: () {
                                CNav.pushNamed(
                                  context,
                                  EventScreen.routeName,
                                  arguments: event,
                                );
                              },
                            ),
                          ],
                        ),
                      if (eventProvider.events.isEmpty)
                        Text(
                          'No Events Yet',
                          style: h4TextStyleInactive,
                        ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

bool datesChecker(DateTime? dateTime1, DateTime? dateTime2) {
  // for null checker
  if (dateTime1 == dateTime2) {
    return true;
  }
  if (dateTime1 == null) return false;
  if (dateTime2 == null) return false;
  int year1 = dateTime1.year;
  int month1 = dateTime1.month;
  int day1 = dateTime1.day;
  //
  int year2 = dateTime2.year;
  int month2 = dateTime2.month;
  int day2 = dateTime2.day;
  //

  return year1 == year2 && month1 == month2 && day1 == day2;
}
