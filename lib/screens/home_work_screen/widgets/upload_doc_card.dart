// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/core/types.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

class UploadDocumentCard extends StatelessWidget {
  const UploadDocumentCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var homeWorkProvider = Providers.homeWP(context);
    return ButtonWrapper(
      onTap: () async {
        try {
          var res = await FilePicker.platform.pickFiles(allowMultiple: false);
          if (res == null ||
              res.files.isEmpty ||
              res.files.first.path == null) {
            GlobalUtils.showSnackBar(
              context: context,
              message: 'Couldn\'t choose a file',
              snackBarType: SnackBarType.error,
            );
            return;
          }
          File file = File(res.files.first.path!);
          Providers.homeWPf(context).uploadDocument(file);
        } catch (e) {
          GlobalUtils.fastSnackBar(
            msg: 'Error uploading document',
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
      child: homeWorkProvider.uploadingDocument
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
          : homeWorkProvider.documentName == null
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
                      child: Text(
                        homeWorkProvider.documentName!,
                        style: h2TextStyle.copyWith(
                          color: colorTheme.inActiveText.withOpacity(.6),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    HSpace(),
                    IconButton(
                      onPressed: () {
                        Providers.homeWPf(context).clearUploadedDoc();
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
