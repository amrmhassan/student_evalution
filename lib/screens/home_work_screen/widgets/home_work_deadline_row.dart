// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import 'date_choosing_card.dart';

class HomeWorkDeadlineRow extends StatelessWidget {
  const HomeWorkDeadlineRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var homeWorkProvider = Providers.homeWP(context);
    var homeWorkProviderFalse = Providers.homeWPf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DateChoosingCard(
          title: 'Start Date',
          onTap: () async {
            var res = await showDatePicker(
              context: context,
              initialDate: homeWorkProviderFalse.startDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(
                Duration(days: 30),
              ),
            );
            if (res == null) return;
            homeWorkProviderFalse.setStartDate(res);
          },
          dateTime: homeWorkProvider.startDate,
        ),
        DateChoosingCard(
          title: 'End Date',
          onTap: () async {
            var res = await showDatePicker(
              context: context,
              initialDate: homeWorkProviderFalse.endDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(
                Duration(days: 30),
              ),
            );
            if (res == null) return;
            homeWorkProviderFalse.setEndDate(res);
          },
          dateTime: homeWorkProvider.endDate,
        ),
      ],
    );
  }
}
