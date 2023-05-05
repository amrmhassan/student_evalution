// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/round_checkbox.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';

class HomeWorkCard extends StatelessWidget {
  final String name;
  final bool checked;
  final VoidCallback onTap;

  const HomeWorkCard({
    super.key,
    required this.name,
    required this.checked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: kVPad / 2,
      ),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            width: largeIconSize * 1.2,
            height: largeIconSize * 1.2,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.5),
              borderRadius: BorderRadius.circular(
                1000,
              ),
            ),
            // child: Icon(
            //   Icons.person,
            //   size: largeIconSize * .8,
            // ),
            child: Image.network(
              'http://t2.gstatic.com/licensed-image?q=tbn:ANd9GcTU1MURjziCWT9mgqPfr5LCHHK53Gmd2d7P_AbKZdawtgNVkUSpHJY6lEQDUniH_Jp2FsaFGjpX3s_hp_DbUyo',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.topCenter,
            ),
          ),
          HSpace(factor: .5),
          Text(
            name,
            style: h3InactiveTextStyle.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
          Spacer(),
          // this is present box
          RoundCheckBox(
            checked: checked,
            onChange: onTap,
          ),
        ],
      ),
    );
  }
}
