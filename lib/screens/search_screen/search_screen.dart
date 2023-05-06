// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/core/types.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/chat_screen/chat_screen.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_screen_search_box.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/user_avatar.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/SearchScreen';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Providers.userP(context);
    UserModel me = userProvider.userModel!;
    var msgProvider = Providers.msgP(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity),
            VSpace(factor: .5),
            Hero(
              tag: 'search',
              child: HomeScreenSearchBox(
                autoFocus: true,
                hint: 'Search | Example: Pavithran',
                onSearch: (value) async {
                  try {
                    UserType myUserType =
                        Providers.userPf(context).userModel!.userType;
                    await Providers.msgPf(context).searchUsers(
                      myUserType: myUserType,
                      query: value,
                    );
                  } catch (e) {
                    GlobalUtils.showSnackBar(
                      context: context,
                      message: e.toString(),
                      snackBarType: SnackBarType.error,
                    );
                  }
                },
              ),
            ),
            VSpace(),
            msgProvider.searching
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: colorTheme.kBlueColor,
                      ),
                    ),
                  )
                : msgProvider.searchResult.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            me.userType == UserType.student
                                ? 'Start searching teachers'
                                : 'Start searching students',
                            style: h4TextStyleInactive,
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView(
                          children: msgProvider.searchResult
                              .map((e) => ListTile(
                                    onTap: () async {
                                      try {
                                        GlobalUtils.showSnackBar(
                                          context: context,
                                          message: 'Creating private room',
                                        );
                                        String myId = Providers.userPf(context)
                                            .userModel!
                                            .uid;
                                        String roomID =
                                            await Providers.msgPf(context)
                                                .createRoom(
                                          myId: myId,
                                          consumerId: e.uid,
                                        );
                                        CNav.pushReplacementNamed(
                                          context,
                                          ChatScreen.routeName,
                                          arguments: {
                                            'roomId': roomID,
                                            'user': e,
                                          },
                                        );
                                      } catch (e) {
                                        GlobalUtils.showSnackBar(
                                          context: context,
                                          message: e.toString(),
                                          snackBarType: SnackBarType.error,
                                        );
                                      }
                                    },
                                    leading: UserAvatar(userImage: e.userImage),
                                    title: Text(
                                      e.name,
                                      style: h3LiteTextStyle,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
