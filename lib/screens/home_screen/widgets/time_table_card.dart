// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class TimeTableCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String? subTitle;
  final String? imageLink;
  // final String desc;
  // final String imageURL;

  const TimeTableCard({
    super.key,
    required this.title,
    this.onTap,
    required this.imageLink,
    this.subTitle,
    // required this.desc,
    // required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: onTap,
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
            child: imageLink == null
                ? Container(
                    width: largeIconSize * 2,
                    height: largeIconSize * 2,
                    color: Colors.grey.withOpacity(.3),
                    child: Icon(
                      Icons.photo,
                      size: largeIconSize,
                      color: Colors.grey,
                    ),
                  )
                : Image.network(
                    imageLink!,
                    width: largeIconSize * 2,
                    height: largeIconSize * 2,
                    fit: BoxFit.cover,
                  ),
          ),
          HSpace(factor: .8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: double.infinity),
                Text(
                  title,
                  style: h3TextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subTitle != null) VSpace(factor: .4),
                if (subTitle != null)
                  Text(
                    subTitle!,
                    style: h4TextStyleInactive,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          if (onTap != null)
            Icon(
              FontAwesomeIcons.chevronRight,
              size: smallIconSize,
              color: colorTheme.inActiveText,
            )
        ],
      ),
    );
  }
}
