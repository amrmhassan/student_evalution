// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

import '../../theming/constants/sizes.dart';
import '../../theming/constants/styles.dart';
import 'button_wrapper.dart';
import 'h_space.dart';
import 'modal_wrapper.dart';
import 'v_space.dart';

class DoubleButtonsModal extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final VoidCallback onOk;
  final VoidCallback? onCancel;
  final String? okText;
  final String? cancelText;
  final Color? okColor;
  final Color? cancelColor;
  final bool autoPop;
  final bool reverseButtonsOrder;
  final Widget? extra;
  final TextStyle? titleStyle;
  final bool showCancelButton;
  final Widget? titleIcon;
  final bool? okActive;

  const DoubleButtonsModal({
    Key? key,
    required this.onOk,
    this.title,
    this.onCancel,
    this.subTitle,
    this.okText,
    this.cancelText,
    this.okColor,
    this.cancelColor,
    required this.autoPop,
    this.reverseButtonsOrder = false,
    this.okActive,
    this.extra,
    this.showCancelButton = true,
    this.titleStyle,
    this.titleIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var modalButtons = [
      if (showCancelButton)
        Expanded(
          child: ButtonWrapper(
            onTap: () {
              if (onCancel != null) onCancel!();
              if (autoPop) {
                Navigator.pop(context);
              }
            },
            padding: EdgeInsets.symmetric(
                horizontal: kHPad / 2, vertical: kVPad / 2),
            backgroundColor: cancelColor ?? colorTheme.backGround,
            child: Text(
              cancelText ?? 'Cancel',
              style: h4TextStyle.copyWith(color: Colors.white),
            ),
          ),
        ),
      if (showCancelButton) HSpace(),
      Expanded(
        child: ButtonWrapper(
          active: okActive ?? true,
          onTap: () async {
            onOk();
            if (autoPop) {
              Navigator.pop(context);
            }
          },
          padding:
              EdgeInsets.symmetric(horizontal: kHPad / 2, vertical: kVPad / 2),
          backgroundColor: okColor ?? colorTheme.kDangerColor,
          child: Text(
            okText ?? 'Delete',
            style: h4TextStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    ];
    return ModalWrapper(
      showTopLine: false,
      color: colorTheme.cardBackground,
      child: Column(
        children: [
          if (title != null)
            Row(
              children: [
                if (titleIcon != null) titleIcon!,
                Text(
                  title!,
                  style: titleStyle ?? h3TextStyle,
                ),
              ],
            ),
          if (subTitle != null)
            Row(
              children: [
                Expanded(
                  child: Text(
                    subTitle.toString(),
                    style: h4TextStyleInactive,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                ),
              ],
            ),
          if (extra != null) extra! else VSpace(),
          Row(
            children: reverseButtonsOrder
                ? modalButtons.reversed.toList()
                : modalButtons,
          ),
        ],
      ),
    );
  }
}
