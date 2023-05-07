// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/message_card.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

class RoomsStreamBuilder extends StatelessWidget {
  const RoomsStreamBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance
          .ref(
            DBCollections.getRef(
              [
                DBCollections.users,
                Providers.userPf(context).userModel!.uid,
                DBCollections.rooms,
              ],
            ),
          )
          .orderByChild(DBCollections.createdAt)
          .onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.snapshot.children.isNotEmpty) {
          return Column(
            children: snapshot.data!.snapshot.children
                .toList()
                .reversed
                .map(
                  (e) => IndividualChatCard(
                    key: Key(e.key!),
                    roomID: e.key!,
                  ),
                )
                .toList(),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: colorTheme.backGround,
            alignment: Alignment.center,
            height: 400,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          );
        } else {
          return Container(
            color: colorTheme.backGround,
            alignment: Alignment.center,
            height: 400,
            child: Center(
              child: Text(
                'No rooms yet',
                style: h4TextStyleInactive,
              ),
            ),
          );
        }
      },
    );
  }
}
