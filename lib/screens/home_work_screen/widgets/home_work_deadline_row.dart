// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'date_choosing_card.dart';

class HomeWorkDeadlineRow extends StatelessWidget {
  const HomeWorkDeadlineRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DateChoosingCard(
          title: 'Start Date',
          onTap: () {},
          dateTime: DateTime.now(),
        ),
        DateChoosingCard(
          title: 'End Date',
          onTap: () {},
          dateTime: DateTime.now().add(
            Duration(
              days: 5,
            ),
          ),
        ),
      ],
    );
  }
}
