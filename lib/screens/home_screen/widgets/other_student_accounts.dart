// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/screens/home_screen/home_screen.dart';
import 'package:student_evaluation/screens/intro_screen/intro_screen.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/user_avatar.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../models/saved_accounts_model.dart';

class OtherStudentAccounts extends StatelessWidget {
  final List<SavedAccountModel> models;
  const OtherStudentAccounts({
    super.key,
    required this.models,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HSpace(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpace(factor: .5),
              Text(
                'Other Accounts',
                style: h4TextStyleInactive,
              ),
              VSpace(factor: .5),
              ...models.map(
                (e) => ListTile(
                  leading: UserAvatar(userImage: e.userModel.userImage),
                  onTap: () async {
                    var userProviderF = Providers.userPf(context);
                    CNav.pop(context);
                    await userProviderF.logout();
                    await userProviderF.auth(
                      savedEmail: e.userModel.email,
                      savedPassword: e.password,
                    );
                    CNav.pushReplacementNamed(context, HomeScreen.routeName);
                  },
                  title: Text(
                    e.userModel.name,
                    style: h3TextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
