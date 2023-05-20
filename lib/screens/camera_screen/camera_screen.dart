// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/home_work_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/providers_calls.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../../screens/home_screen/widgets/home_screen_appbar.dart';

class CameraScreen extends StatefulWidget {
  static const String routeName = '/CameraScreen';
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    var userModel = Providers.userPf(context).userModel as StudentModel;

    _controller = VideoPlayerController.network(
      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      httpHeaders: {},
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: colorTheme.backGround,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorTheme.kBlueColor.withOpacity(.5),
        flexibleSpace: HAppBarFlexibleArea(),
        foregroundColor: Colors.white,
      ),
      body: Stack(
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
                            Row(
                              children: [
                                Text(
                                  'Camera',
                                  style: h1TextStyle.copyWith(
                                    color: colorTheme.kBlueColor,
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            VSpace(),
                            HLine(
                              thickness: .4,
                              color: colorTheme.inActiveText,
                              borderRadius: 1000,
                            ),
                            VSpace(),
                            Column(
                              children: [
                                VSpace(factor: .3),
                                //? here the home works
                                AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
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
    );
  }
}

class HomeWorkCard extends StatelessWidget {
  final HomeWorkModel homeWorkModel;
  const HomeWorkCard({
    super.key,
    required this.homeWorkModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VSpace(),
        VSpace(factor: .5),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: kHPad,
            vertical: kVPad / 2,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              mediumBorderRadius,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.3),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                homeWorkModel.description ?? 'No description',
                style: h3TextStyle,
                softWrap: true,
              ),
              VSpace(factor: .5),
              HLine(
                thickness: .3,
                color: colorTheme.inActiveText,
              ),
              VSpace(factor: .5),
              Text(
                'Start date ${homeWorkModel.startDate}',
                style: h4TextStyleInactive,
              ),
              VSpace(factor: .5),
              Text(
                'End date ${homeWorkModel.endDate}',
                style: h4TextStyleInactive,
              ),
              VSpace(factor: .5),
              ButtonWrapper(
                onTap: homeWorkModel.documentLink == null
                    ? null
                    : () {
                        launchUrl(
                          Uri.parse(homeWorkModel.documentLink!),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                padding: EdgeInsets.symmetric(
                    horizontal: kHPad, vertical: kHPad / 2),
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorTheme.backGround,
                  borderRadius: BorderRadius.circular(
                    mediumBorderRadius,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.link,
                      size: smallIconSize,
                      color: colorTheme.inActiveText,
                    ),
                    HSpace(factor: .3),
                    Text(
                      homeWorkModel.documentLink == null
                          ? 'No Document'
                          : 'Home Work Document',
                      style: h4TextStyleInactive,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        VSpace(),
        HLine(
          color: colorTheme.inActiveText.withOpacity(
            .2,
          ),
          thickness: .6,
        ),
      ],
    );
  }
}
