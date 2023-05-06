// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/transformers/enums_transformers.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

class ChooseGradeSection extends StatelessWidget {
  final Function(StudentGrade grade) afterChange;
  const ChooseGradeSection({
    super.key,
    required this.afterChange,
  });

  @override
  Widget build(BuildContext context) {
    // var timeLineProvider = Providers.timeLP(context);
    var attendProvider = Providers.attendP(context);

    return Column(
      children: [
        // Container(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: kHPad / 2,
        //     vertical: kVPad / 2,
        //   ),
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(
        //       mediumBorderRadius,
        //     ),
        //     border: Border.all(
        //       width: .3,
        //       color: colorTheme.inActiveText.withOpacity(.7),
        //     ),
        //   ),
        //   child: Row(
        //     children: [
        //       Text(
        //         '6th Grade B Section',
        //         style: h2TextStyle.copyWith(
        //           color: colorTheme.kBlueColor,
        //         ),
        //       ),
        //       Spacer(),
        //       Icon(
        //         FontAwesomeIcons.chevronDown,
        //         size: smallIconSize,
        //       )
        //     ],
        //   ),
        // ),
        //! add flutter_typeahead package to make the custom dropdown menu
        Container(
          width: double.infinity,
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
                  value: attendProvider.activeGrade,
                  items: StudentGrade.values
                      .map(
                        (e) => DropdownMenuItem(
                          key: Key(e.name),
                          value: e,
                          child: Text(
                            gradeTransformer(e),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    Providers.attendPf(context).setActiveGrade(value!);
                    afterChange(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
