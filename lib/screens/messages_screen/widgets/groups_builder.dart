// ignore_for_file: prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/models/group_data_model.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import 'group_chat_card.dart';

class GroupsBuilder extends StatelessWidget {
  const GroupsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Providers.msgP(context);

    return StreamBuilder<Object?>(
        stream: Providers.msgPf(context)
            .getGroupsStream(Providers.userPf(context))
            ?.onValue,
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (snapshot.hasData && data is DatabaseEvent) {
            var children = data.snapshot.children.map((e) {
              var test = (e.value as Map<dynamic, dynamic>);

              Map<String, dynamic> data = {};
              test.forEach((key, value) {
                data[key.toString()] = value;
              });
              GroupDataModel model = GroupDataModel.fromJSON(data);
              return model;
            }).toList();

            return Column(
              children: [
                ...children.map((e) => GroupChatCard(
                      groupDataModel: e,
                    )),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
