// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/user_avatar.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../fast_tools/widgets/h_space.dart';
import '../../../theming/constants/sizes.dart';
import '../../../theming/constants/styles.dart';

class SenderLittleInfo extends StatefulWidget {
  final String userId;
  const SenderLittleInfo({
    super.key,
    required this.userId,
  });

  @override
  State<SenderLittleInfo> createState() => _SenderLittleInfoState();
}

class _SenderLittleInfoState extends State<SenderLittleInfo> {
  UserModel? userModel;
  bool loading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        loading = true;
      });
      userModel =
          await Providers.userPf(context).getUserModelById(widget.userId);
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UserAvatar(
          userImage: userModel?.userImage,
          radius: smallIconSize,
        ),
        HSpace(factor: .5),
        Text(
          userModel?.name ?? '...',
          style: h4TextStyleInactive,
        ),
      ],
    );
  }
}
