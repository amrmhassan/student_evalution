// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';

class UserAvatar extends StatelessWidget {
  final String? userImage;
  final bool group;
  final double radius;
  final bool largeIcon;

  const UserAvatar({
    super.key,
    required this.userImage,
    this.group = false,
    this.radius = largeIconSize * 1.2,
    this.largeIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.5),
        borderRadius: BorderRadius.circular(
          1000,
        ),
      ),
      child: userImage == null
          ? Container(
              padding: EdgeInsets.all(smallPadding),
              child: Icon(
                group ? Icons.group : Icons.person,
                size: largeIcon
                    ? (radius - smallPadding * 7)
                    : (radius - smallPadding * 2) > mediumIconSize
                        ? mediumIconSize
                        : (radius - smallPadding * 2),
                color: Colors.black.withOpacity(.6),
              ),
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
