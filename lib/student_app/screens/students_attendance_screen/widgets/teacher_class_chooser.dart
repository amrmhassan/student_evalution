// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../models/user_model.dart';
import '../../../../theming/constants/sizes.dart';
import '../../../../theming/constants/styles.dart';
import '../../../../theming/theme_calls.dart';
import '../../../../transformers/enums_transformers.dart';

class TeacherClassChooser extends StatelessWidget {
  final TeacherClass value;
  final Function(TeacherClass value) onChange;

  const TeacherClassChooser({
    super.key,
    required this.value,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      padding: EdgeInsets.symmetric(
        horizontal: kHPad / 2,
        vertical: kVPad / 2,
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
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Row(
            children: [
              Spacer(),
              Icon(
                FontAwesomeIcons.chevronDown,
                size: smallIconSize,
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: DropdownButton(
              underline: SizedBox(),
              style: h2TextStyle.copyWith(
                color: colorTheme.kBlueColor,
              ),
              icon: SizedBox(),
              value: value,
              items: TeacherClass.values
                  .map(
                    (e) => DropdownMenuItem(
                      key: Key(e.name),
                      value: e,
                      child: Text(
                        classTransformer(e),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                onChange(value!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
