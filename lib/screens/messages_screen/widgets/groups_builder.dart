// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';

import 'group_chat_card.dart';

class GroupsBuilder extends StatelessWidget {
  const GroupsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          3,
          (index) => GroupChatCard(),
        )
      ],
    );
  }
}
