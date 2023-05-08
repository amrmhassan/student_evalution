// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_evaluation/core/types.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

class AddEventImage extends StatelessWidget {
  const AddEventImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var eventProvider = Providers.eventP(context);

    return ButtonWrapper(
      onTap: () async {
        try {
          var res =
              await ImagePicker.platform.pickImage(source: ImageSource.gallery);
          if (res == null) {
            GlobalUtils.showSnackBar(
              context: context,
              message: 'Couldn\'t choose an image',
              snackBarType: SnackBarType.error,
            );
            return;
          }
          File file = File(res.path);
          Providers.eventPf(context).setEventImage(file);
        } catch (e) {
          GlobalUtils.fastSnackBar(
            msg: 'Error uploading image',
            snackBarType: SnackBarType.error,
          );
        }
      },
      padding: EdgeInsets.symmetric(
        horizontal: kHPad / 2,
        vertical: kVPad,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          mediumBorderRadius,
        ),
        border: Border.all(
          width: .3,
          color: colorTheme.inActiveText.withOpacity(.7),
        ),
      ),
      width: double.infinity,
      child: eventProvider.uploadingEventImage
          ? Center(
              child: Column(
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                  VSpace(factor: .4),
                  Text(
                    'Uploading',
                    style: h4TextStyleInactive,
                  ),
                ],
              ),
            )
          : eventProvider.imageName == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: double.infinity),
                    Image.asset(
                      'assets/icons/upload.png',
                      width: largeIconSize,
                    ),
                    VSpace(factor: .5),
                    Text(
                      'Upload Document',
                      style: h2TextStyle.copyWith(
                        color: colorTheme.inActiveText.withOpacity(.6),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: Image.network(
                        eventProvider.imageLink!,
                        fit: BoxFit.contain,
                      ),
                    ),
                    HSpace(),
                    IconButton(
                      onPressed: () {
                        Providers.eventPf(context).clearEventImage();
                      },
                      icon: Icon(
                        Icons.close,
                        color: colorTheme.kDangerColor,
                      ),
                    ),
                  ],
                ),
    );
  }
}
