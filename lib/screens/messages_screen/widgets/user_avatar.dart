import 'package:flutter/material.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
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
      child: Image.network(
        'http://t2.gstatic.com/licensed-image?q=tbn:ANd9GcTU1MURjziCWT9mgqPfr5LCHHK53Gmd2d7P_AbKZdawtgNVkUSpHJY6lEQDUniH_Jp2FsaFGjpX3s_hp_DbUyo',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
