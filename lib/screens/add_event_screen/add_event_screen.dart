// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/core/types.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/add_event_screen/widgets/add_event_image.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/apply_attendance_button.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/global_utils.dart';

import '../../fast_tools/widgets/custom_text_field.dart';
import '../../utils/providers_calls.dart';
import '../home_screen/widgets/home_screen_appbar.dart';
import '../home_work_screen/widgets/date_choosing_card.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = '/AddEventScreen';
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var eventProvider = Providers.eventP(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorTheme.kBlueColor.withOpacity(.5),
        flexibleSpace: HAppBarFlexibleArea(),
        foregroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: colorTheme.kBlueColor,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  VSpace(factor: 4),
                  Column(
                    children: [
                      VSpace(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: colorTheme.backGround,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              largeBorderRadius,
                            ),
                            topRight: Radius.circular(
                              largeBorderRadius,
                            ),
                          ),
                        ),
                        child: PaddingWrapper(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VSpace(),
                              Text(
                                'Add Event',
                                style: h1TextStyle.copyWith(
                                  color: colorTheme.kBlueColor,
                                ),
                              ),
                              VSpace(),
                              HLine(
                                thickness: .4,
                                color: colorTheme.inActiveText,
                                borderRadius: 1000,
                              ),
                              VSpace(),
                              eventProvider.uploadingEvent
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        color: colorTheme.kBlueColor,
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        VSpace(factor: .5),
                                        AddEventTextInput(
                                          titleController: titleController,
                                          hint: 'Enter event title',
                                        ),
                                        VSpace(factor: .5),
                                        AddEventTextInput(
                                          titleController: placeController,
                                          hint: 'Enter event place',
                                        ),
                                        VSpace(factor: .5),
                                        AddEventTextInput(
                                          titleController: detailsController,
                                          hint: 'Enter event description',
                                          maxLines: 7,
                                          textInputAction:
                                              TextInputAction.newline,
                                        ),
                                        VSpace(factor: .5),
                                        AddEventTextInput(
                                          titleController: notesController,
                                          hint: 'Enter event notes',
                                          textInputAction:
                                              TextInputAction.newline,
                                          maxLines: 3,
                                        ),
                                        VSpace(factor: .5),
                                        Row(
                                          children: [
                                            DateChoosingCard(
                                              title: 'Event day',
                                              onTap: () async {
                                                var res = await showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      eventProvider.date,
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.now().add(
                                                    Duration(days: 90),
                                                  ),
                                                );
                                                if (res == null) return;
                                                Providers.eventPf(context)
                                                    .setDate(res);
                                              },
                                              dateTime: eventProvider.date,
                                            ),
                                            Spacer(),
                                            DateChoosingCard(
                                              title: 'Event time',
                                              onTap: () async {
                                                var res = await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      eventProvider.timeOfDay,
                                                );

                                                if (res == null) return;
                                                Providers.eventPf(context)
                                                    .setTimeOfDay(res);
                                              },
                                              timeOfDay:
                                                  eventProvider.timeOfDay,
                                            ),
                                          ],
                                        ),
                                        VSpace(factor: .5),
                                        AddEventImage(),
                                        VSpace(factor: .5),
                                        VSpace(),
                                        HLine(
                                          thickness: .4,
                                          color: colorTheme.inActiveText,
                                          borderRadius: 1000,
                                        ),
                                        VSpace(),
                                        PaddingWrapper(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: kHPad * 2,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ApplyAttendanceButton(
                                                active: !eventProvider
                                                    .uploadingEvent,
                                                title: 'Add',
                                                onTap: () async {
                                                  try {
                                                    var eventProviderFalse =
                                                        Providers.eventPf(
                                                            context);
                                                    //
                                                    UserModel me =
                                                        Providers.userPf(
                                                                context)
                                                            .userModel!;
                                                    await Providers.eventPf(
                                                            context)
                                                        .addEvent(
                                                      title:
                                                          titleController.text,
                                                      imageLink:
                                                          eventProviderFalse
                                                              .imageLink,
                                                      date: eventProviderFalse
                                                          .getFullDate,
                                                      place:
                                                          placeController.text,
                                                      details: detailsController
                                                          .text,
                                                      notes:
                                                          notesController.text,
                                                      creatorId: me.uid,
                                                    );
                                                    GlobalUtils.showSnackBar(
                                                      context: context,
                                                      message: 'Event added',
                                                      snackBarType:
                                                          SnackBarType.success,
                                                    );
                                                    CNav.pop(context);
                                                  } catch (e) {
                                                    GlobalUtils.showSnackBar(
                                                      context: context,
                                                      message: e.toString(),
                                                      snackBarType:
                                                          SnackBarType.error,
                                                    );
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        VSpace(),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddEventTextInput extends StatelessWidget {
  const AddEventTextInput({
    super.key,
    required this.titleController,
    required this.hint,
    this.maxLines = 1,
    this.maxLength,
    this.textInputAction,
  });

  final TextEditingController titleController;
  final String hint;
  final int maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      textInputAction: textInputAction,
      maxLength: maxLength,
      maxLines: maxLines,
      title: hint,
      enabled: true,
      errorText: null,
      controller: titleController,
      color: Colors.red,
      backgroundColor: Colors.white,
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
      textStyle: h4LiteTextStyle,
      borderRadius: BorderRadius.circular(
        mediumBorderRadius,
      ),
      padding: EdgeInsets.zero,
    );
  }
}
