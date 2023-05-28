// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_evaluation/core/constants/classes_images.dart';
import 'package:student_evaluation/core/types.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/home_work_model.dart';
import 'package:student_evaluation/models/material_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/transformers/enums_transformers.dart';
import 'package:student_evaluation/transformers/models_fields.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:student_evaluation/utils/providers_calls.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../screens/home_screen/widgets/home_screen_appbar.dart';
import '../../../screens/messages_screen/widgets/user_avatar.dart';

class StudentMaterialsScreen extends StatefulWidget {
  static const String routeName = '/StudentMaterialsScreen';
  const StudentMaterialsScreen({super.key});

  @override
  State<StudentMaterialsScreen> createState() => _StudentMaterialsScreenState();
}

class _StudentMaterialsScreenState extends State<StudentMaterialsScreen> {
  List<MaterialModel> materials = [];
  var loading = false;
  @override
  void initState() {
    loadData();

    super.initState();
  }

  void loadData() async {
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        materials.clear();

        loading = true;
      });
      try {
        var model = Providers.userPf(context).userModel as StudentModel;
        var docs = (await FirebaseFirestore.instance
                .collection(DBCollections.studentsMaterials)
                .where(
                  ModelsFields.studentGrade,
                  isEqualTo: model.studentGrade.name,
                )
                .get())
            .docs;
        for (var doc in docs) {
          materials.add(MaterialModel.fromJSON(doc.data()));
        }
        setState(() {});
      } catch (e) {
        GlobalUtils.showSnackBar(
          context: context,
          message: e.toString(),
          snackBarType: SnackBarType.error,
        );
      }

      setState(() {
        loading = false;
      });
    });
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
                                  'Material',
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
                            loading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: colorTheme.kBlueColor,
                                    ),
                                  )
                                : Column(
                                    children: [
                                      VSpace(factor: .3),
                                      //? here the home works
                                      ...materials.map((e) => Card(
                                            surfaceTintColor:
                                                Colors.transparent,
                                            color: Colors.white,
                                            child: ButtonWrapper(
                                                onTap: () {
                                                  launchUrl(
                                                    Uri.parse(e.link),
                                                    mode: LaunchMode
                                                        .externalApplication,
                                                  );
                                                },
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: kHPad,
                                                  vertical: kVPad / 2,
                                                ),
                                                child: Row(
                                                  children: [
                                                    UserAvatar(
                                                      defaultIcon: Icons.book,
                                                      userImage: ConstantImages
                                                          .getClassImage(
                                                        e.teacherClass,
                                                      ),
                                                      borderRadius:
                                                          mediumBorderRadius,
                                                    ),
                                                    HSpace(),
                                                    Expanded(
                                                      child: Text(
                                                        classTransformer(
                                                            e.teacherClass),
                                                        style: h3TextStyle,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        FontAwesomeIcons
                                                            .chevronRight,
                                                        size: smallIconSize,
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          )),

                                      if (materials.isEmpty)
                                        Container(
                                          alignment: Alignment.center,
                                          padding:
                                              EdgeInsets.only(top: kVPad * 2),
                                          child: Text(
                                            'No materials added yet',
                                            style: h4TextStyleInactive,
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
