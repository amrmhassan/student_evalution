// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import 'add_description_modal.dart';

class HomeDescCard extends StatelessWidget {
  const HomeDescCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var homeWProvider = Providers.homeWP(context);
    return ButtonWrapper(
      onTap: () {
        showBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          builder: (context) => AddDescriptionModal(),
        );
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
          color: colorTheme.inActiveText.withOpacity(.7),
        ),
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              homeWProvider.description ?? 'Enter Description',
              style: homeWProvider.description == null
                  ? h2TextStyle.copyWith(
                      color: colorTheme.inActiveText.withOpacity(.6),
                    )
                  : h4TextStyleInactive,
            ),
          ),
        ],
      ),
    );
  }
}
