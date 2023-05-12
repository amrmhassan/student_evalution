// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/fast_tools/widgets/modal_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/init/runtime_variables.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/intro_screen/intro_screen.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/user_avatar.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/transformers/enums_transformers.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../core/constants/languages_constants.dart';
import '../../../fast_tools/widgets/button_wrapper.dart';
import '../../../fast_tools/widgets/h_space.dart';
import '../../../models/saved_accounts_model.dart';
import '../../../theming/constants/styles.dart';
import '../../../theming/theme_calls.dart';
import 'notifications_icon.dart';
import 'other_student_accounts.dart';

class HAppBarActions extends StatelessWidget {
  const HAppBarActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var userProvider = Providers.userP(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            if (userProvider.userModel is StudentModel) NotificationsIcon(),
            HSpace(factor: .7),
            IconButton(
              onPressed: () async {
                // await Providers.userPf(context).logout();
                // CNav.pushReplacementNamed(context, IntroScreen.routeName);
                Scaffold.of(context).openEndDrawer();
              },
              icon: Image.asset(
                'assets/icons/icon_other.png',
                width: mediumIconSize,
              ),
            ),
            HSpace(factor: .7),
          ],
        ),
      ],
    );
  }
}

class HAppBarTitle extends StatelessWidget {
  const HAppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var userProvider = Providers.userP(context);
    var userModel = userProvider.userModel as UserModel;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userModel.name,
          style: h1LightTextStyle,
        ),
        GestureDetector(
          onTap: () {
            GlobalUtils.copyToClipboard(
              context: context,
              data: userModel.uid,
              snackContent: 'User id copied',
            );
          },
          child: Text(
            'ID: ${userModel.uid.substring(0, 5)}... | ${userModel.userType.name.capitalize}',
            style: h4TextStyleInactive.copyWith(
              color: Colors.white.withOpacity(.8),
            ),
          ),
        ),
      ],
    );
  }
}

class HAppBarFlexibleArea extends StatelessWidget {
  const HAppBarFlexibleArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
        background: BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 3,
        sigmaY: 3,
      ),
      child: Container(
        color: colorTheme.kBlueColor.withOpacity(.5),
      ),
    ));
  }
}

class HomeScreenEndDrawer extends StatefulWidget {
  const HomeScreenEndDrawer({
    super.key,
  });

  @override
  State<HomeScreenEndDrawer> createState() => _HomeScreenEndDrawerState();
}

class _HomeScreenEndDrawerState extends State<HomeScreenEndDrawer> {
  bool loading = false;
  List<SavedAccountModel> models = [];
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        loading = true;
      });
      models = await Providers.userPf(context).getSavedAccounts();
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Providers.userP(context);
    var userModel = userProvider.userModel;
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 200,
            color: Color(0xffEBEBEB),
            child: PaddingWrapper(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserAvatar(
                    userImage: userProvider.userModel?.userImage,
                    radius: largeIconSize * 2,
                    largeIcon: true,
                  ),
                  HSpace(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProvider.userModel!.name,
                        style: h1TextStyle,
                      ),
                      VSpace(factor: .5),
                      Text(
                        userModel is StudentModel
                            ? gradeTransformer(userModel.studentGrade)
                            : userModel is TeacherModel
                                ? classTransformer(userModel.teacherClass)
                                : '',
                        style: h4TextStyleInactive,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (userModel is StudentModel && models.isNotEmpty)
            OtherStudentAccounts(
              models: models,
            ),
          ListTile(
            onTap: () async {
              CNav.pop(context);
              showModalBottomSheet(
                context: navigatorKey.currentContext!,
                builder: (context) => LanguageModal(),
              );
            },
            leading: Icon(
              Icons.language,
              color: colorTheme.kBlueColor,
            ),
            title: Text(
              'Language',
              style: h3LiteTextStyle.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            onTap: () async {
              await Providers.userPf(context).logout();
              CNav.pushReplacementNamed(context, IntroScreen.routeName);
            },
            leading: Icon(
              Icons.logout,
              color: colorTheme.kDangerColor,
            ),
            title: Text(
              'Logout',
              style: h3LiteTextStyle.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LanguageModal extends StatelessWidget {
  const LanguageModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var langProvider = Providers.langP(context);

    return ModalWrapper(
        padding: EdgeInsets.zero,
        showTopLine: false,
        bottomPaddingFactor: 0,
        afterLinePaddingFactor: 0,
        child: Column(
          children: [
            VSpace(),
            Column(
              children: List.generate(supportedLocales.length, (index) {
                var locale = supportedLocales[index];
                return ButtonWrapper(
                  backgroundColor: langProvider.locale == locale
                      ? colorTheme.cardBackground
                      : null,
                  onTap: () {
                    Providers.langPf(context).setLocale(context, locale);
                    // CustomLocale.changeLocale(context, enLocale);
                    GlobalUtils.showSnackBar(
                      context: context,
                      message: "apply-on-next-startup".i18n(),
                    );
                    CNav.pop(context);
                  },
                  child: ListTile(
                    title: Text(
                      getLanguageNames(supportedLocales)[locale.languageCode] ??
                          'Unknown',
                      style: h4TextStyleInactive,
                    ),
                  ),
                );
              }),
            ),
            VSpace(),
          ],
        ));
  }
}
