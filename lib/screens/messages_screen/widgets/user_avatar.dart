// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';

class UserAvatar extends StatelessWidget {
  final String? userImage;
  const UserAvatar({
    super.key,
    required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      width: largeIconSize * 1.2,
      height: largeIconSize * 1.2,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.5),
        borderRadius: BorderRadius.circular(
          1000,
        ),
      ),
      child: userImage == null
          ? Icon(
              Icons.person,
              size: mediumIconSize,
              color: Colors.black.withOpacity(.8),
            )
          : Image.network(
              userImage!,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.topCenter,
            ),
    );
  }
}
