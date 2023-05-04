// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:intl/intl.dart' as intl;

import 'widgets/home_screen_appbar.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorTheme.kBlueColor.withOpacity(.5),
        flexibleSpace: HAppBarFlexibleArea(),
        title: HAppBarTitle(),
        actions: [
          HAppBarActions(),
        ],
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
                        TopLineTimeLine(),
                        VSpace(factor: .9),
                        TimeLineTitle(),
                        VSpace(factor: .9),
                        TimeLineWidget(),
                        VSpace(factor: .9),
                        BottomLineTimeLine(),
                        VSpace(),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Column(
                              children: [
                                VSpace(factor: 1.5),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft:
                                            Radius.circular(largeBorderRadius),
                                        topRight:
                                            Radius.circular(largeBorderRadius),
                                      )),
                                  child: Column(
                                    children: [
                                      VSpace(factor: 1.5),
                                      VSpace(),
                                      HomeScreenTabsTitle(),
                                      VSpace(),
                                      HomeDashboard(),
                                      VSpace(),
                                      PaddingWrapper(
                                        child: HLine(
                                          color: colorTheme.inActiveText,
                                          thickness: .8,
                                        ),
                                      ),
                                      VSpace(),
                                      PaddingWrapper(
                                        child: Row(
                                          children: [
                                            Text(
                                              'Time Table',
                                              style: h2TextStyle,
                                            ),
                                            Spacer(),
                                            Text(
                                              'View All',
                                              style:
                                                  h4TextStyleInactive.copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      VSpace(),
                                      // here is the time table items
                                      PaddingWrapper(
                                        child: Column(
                                          children: [
                                            TimeTableCard(),
                                            TimeTableCard(),
                                            TimeTableCard(),
                                          ],
                                        ),
                                      ),

                                      VSpace(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            HomeScreenSearchBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: kHPad / 2),
              height: 80,
              decoration: BoxDecoration(
                color: colorTheme.kBlueColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(largeBorderRadius),
                  topRight: Radius.circular(largeBorderRadius),
                ),
              ),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavBarItem(
                    title: 'Home',
                    iconName: 'home',
                    active: true,
                  ),
                  NavBarItem(
                    title: 'Message',
                    iconName: 'message',
                    active: false,
                  ),
                  NavBarItem(
                    title: 'Notification',
                    iconName: 'Notification',
                    active: false,
                  ),
                  NavBarItem(
                    title: 'Settings',
                    iconName: 'setting',
                    active: false,
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

class NavBarItem extends StatelessWidget {
  final String title;
  final bool active;
  final String iconName;

  const NavBarItem({
    super.key,
    required this.title,
    required this.active,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: () {},
      child: active
          ? Container(
              padding: EdgeInsets.symmetric(
                horizontal: kHPad / 2,
                vertical: kVPad / 2,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Text(
                title,
                style: h4TextStyleInactive.copyWith(
                  color: colorTheme.kBlueColor,
                ),
              ),
            )
          : Image.asset(
              'assets/icons/$iconName.png',
            ),
    );
  }
}

class TimeTableCard extends StatelessWidget {
  const TimeTableCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: () {},
      padding: EdgeInsets.all(largePadding),
      margin: EdgeInsets.only(bottom: kVPad / 2),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          largeBorderRadius,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                mediumBorderRadius,
              ),
            ),
            child: Image.network(
              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
              width: largeIconSize * 2,
              height: largeIconSize * 2,
              fit: BoxFit.cover,
            ),
          ),
          HSpace(factor: .8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Science Class',
                style: h3TextStyle,
              ),
              VSpace(factor: .4),
              Text(
                '6th class B Section | 12:00PM',
                style: h4TextStyleInactive,
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.arrow_right,
            color: colorTheme.inActiveText,
          )
        ],
      ),
    );
  }
}

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DashboardItem(
                title: 'Attendance',
                iconName: 'attendance',
              ),
              DashboardItem(title: 'Home Works', iconName: 'home_work'),
              DashboardItem(
                title: 'Behavior',
                iconName: 'behaviour',
              ),
            ],
          ),
          VSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DashboardItem(
                title: 'Time Table',
                iconName: 'time_table',
              ),
              DashboardItem(
                title: 'Messages',
                iconName: 'messages',
              ),
              Opacity(
                opacity: 0,
                child: DashboardItem(
                  title: 'Messages',
                  iconName: 'messages',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  final String title;
  final String iconName;

  const DashboardItem({
    super.key,
    required this.iconName,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: () {},
      child: Column(
        children: [
          Image.asset(
            'assets/icons/$iconName.png',
            width: largeIconSize * 1.2,
          ),
          Text(
            title,
            style: h4TextStyleInactive,
          )
        ],
      ),
    );
  }
}

class HomeScreenTabsTitle extends StatelessWidget {
  const HomeScreenTabsTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      child: Column(
        children: [
          Row(
            children: [
              HomeScreenTabItem(
                active: true,
                title: 'Updates',
                onTap: () {},
              ),
              Spacer(),
              HomeScreenTabItem(
                active: false,
                title: 'Events',
                onTap: () {},
              ),
            ],
          ),
          HLine(
            color: colorTheme.inActiveText,
            thickness: .8,
          ),
        ],
      ),
    );
  }
}

class HomeScreenTabItem extends StatelessWidget {
  final bool active;
  final String title;
  final VoidCallback onTap;

  const HomeScreenTabItem({
    super.key,
    required this.active,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: onTap,
      padding: EdgeInsets.symmetric(
        horizontal: kHPad / 5,
        vertical: kVPad / 3,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: active
              ? BorderSide(
                  color: colorTheme.kBlueColor,
                  width: 3,
                )
              : BorderSide.none,
        ),
      ),
      child: Text(
        title,
        style: h2TextStyle.copyWith(
          color: active
              ? colorTheme.kBlueColor
              : colorTheme.activeText.withOpacity(.5),
        ),
      ),
    );
  }
}

class TimeLineWidget extends StatelessWidget {
  const TimeLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final startDate = DateTime.now();
    final endDate = startDate.add(Duration(days: 7));

    return PaddingWrapper(
      padding: EdgeInsets.symmetric(horizontal: kHPad / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var date = DateTime.now();
              date.isBefore(endDate);
              date = date.add(Duration(days: 1)))
            Expanded(child: TimeLineItem(dateTime: date))
        ],
      ),
    );
  }
}

class TimeLineItem extends StatelessWidget {
  final DateTime dateTime;
  const TimeLineItem({
    super.key,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    bool equal = intl.DateFormat('yyyy-mm-dd').format(dateTime) ==
        intl.DateFormat('yyyy-mm-dd').format(now);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: kVPad,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(largeBorderRadius),
        color: equal ? Colors.white : Colors.transparent,
      ),
      child: Column(
        children: [
          Text(
            intl.DateFormat('E').format(dateTime).substring(0, 2).toUpperCase(),
            style: h3TextStyle.copyWith(
              color: equal ? colorTheme.kBlueColor : Colors.white,
            ),
          ),
          VSpace(factor: .5),
          Text(
            intl.DateFormat('dd').format(dateTime),
            style: h3LightTextStyle.copyWith(
              color: equal ? colorTheme.kBlueColor : null,
            ),
          ),
        ],
      ),
    );
  }
}

class TopLineTimeLine extends StatelessWidget {
  const TopLineTimeLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      padding: EdgeInsets.symmetric(horizontal: kHPad / 2),
      child: HLine(
        thickness: .4,
        color: Colors.white.withOpacity(.5),
      ),
    );
  }
}

class BottomLineTimeLine extends StatelessWidget {
  const BottomLineTimeLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      padding: EdgeInsets.symmetric(horizontal: kHPad / 2),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          HLine(
            thickness: .4,
            color: Colors.white.withOpacity(.5),
          ),
          HSpace(),
          Positioned(
            left: kHPad * 2,
            child: SizedBox(
              width: kVPad * 3,
              child: HLine(
                color: Colors.white,
                thickness: 3,
                borderRadius: 1000,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeLineTitle extends StatelessWidget {
  const TimeLineTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      padding: EdgeInsets.symmetric(horizontal: kHPad / 2),
      child: Row(
        children: [
          Text(
            'Select Date',
            style: h2LightTextStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          HSpace(factor: .5),
          Image.asset(
            'assets/icons/warning.png',
            color: Colors.white,
            width: mediumIconSize * .5,
          ),
          Spacer(),
          Image.asset(
            'assets/icons/attendance.png',
            color: Colors.white,
            width: mediumIconSize * .8,
          ),
          HSpace(factor: .5),
          Text(
            intl.DateFormat('MMM yyyy').format(DateTime.now()),
            style: h3LightTextStyle,
          ),
        ],
      ),
    );
  }
}

class HomeScreenSearchBox extends StatelessWidget {
  const HomeScreenSearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.getWidth(context) - kHPad * 2,
      height: 2 * 1.5 * kVPad,
      decoration: BoxDecoration(
        color: colorTheme.backGround,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(largeBorderRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(height: double.infinity),
          HSpace(),
          Icon(
            Icons.search,
            color: colorTheme.kInactiveColor,
            size: mediumIconSize,
          ),
          // HSpace(factor: .3),
          Expanded(
            child: CustomTextField(
              padding: EdgeInsets.zero,
              title: 'Search | Example: Attendance',
              hintStyle: h3InactiveTextStyle.copyWith(
                  color: colorTheme.activeText.withOpacity(.3)),
              borderColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
