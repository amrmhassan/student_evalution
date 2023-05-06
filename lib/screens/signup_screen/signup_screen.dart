// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, sized_box_for_whitespace, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/constants/global_constants.dart';
import 'package:student_evaluation/core/types.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/screen_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:student_evaluation/validation/login_validation.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/SignUpScreen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController imageLinkController = TextEditingController();
  UserType userType = UserType.student;

  String? emailError;
  String? passwordError;
  String? nameError;

  bool loading = false;
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      // backgroundColor: colorTheme.kBlueColor,
      body: SingleChildScrollView(
        child: PaddingWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpace(factor: 5),
              CustomTextField(
                padding: EdgeInsets.zero,
                title: 'User email',
                backgroundColor: Colors.white,
                controller: emailController,
                trailingIcon: Text(
                  '@$emailSuffix',
                  style: h4TextStyleInactive,
                ),
                errorText: emailError,
              ),
              VSpace(factor: .5),
              CustomTextField(
                padding: EdgeInsets.zero,
                title: 'Enter password',
                backgroundColor: Colors.white,
                controller: passwordController,
                errorText: passwordError,
                enabled: !loading,
              ),
              VSpace(factor: .5),
              CustomTextField(
                padding: EdgeInsets.zero,
                title: 'Enter name',
                backgroundColor: Colors.white,
                controller: nameController,
                errorText: nameError,
                enabled: !loading,
              ),
              VSpace(factor: .5),
              CustomTextField(
                padding: EdgeInsets.zero,
                title: 'Enter image link',
                backgroundColor: Colors.white,
                controller: imageLinkController,
                enabled: !loading,
              ),
              VSpace(factor: .5),
              VSpace(),
              Text(
                'User Role',
                style: h3TextStyle,
              ),
              VSpace(factor: .3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  UserTypeChooser(
                    activeType: userType,
                    title: 'Student',
                    myType: UserType.student,
                    onTap: () {
                      updateUserType(UserType.student);
                    },
                  ),
                  UserTypeChooser(
                    activeType: userType,
                    title: 'Teacher',
                    myType: UserType.teacher,
                    onTap: () {
                      updateUserType(UserType.teacher);
                    },
                  ),
                  UserTypeChooser(
                    activeType: userType,
                    title: 'Admin',
                    myType: UserType.admin,
                    onTap: () {
                      updateUserType(UserType.admin);
                    },
                  ),
                ],
              ),
              VSpace(),
              ButtonWrapper(
                active: !loading,
                padding: EdgeInsets.symmetric(
                  horizontal: kHPad,
                  vertical: kVPad / 2,
                ),
                backgroundColor: colorTheme.kBlueColor,
                onTap: signUp,
                child: Text(
                  'Sign User',
                  style: h3LightTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateUserType(UserType t) {
    if (loading) return;
    setState(() {
      userType = t;
    });
  }

  bool _validateInfo(
    String email,
    String password,
    String name,
  ) {
    if (!clicked) return false;
    setState(() {
      emailError = EmailValidation().error(email);
      passwordError = PasswordValidation().error(password);
      nameError = NameValidation().error(name);
    });
    return emailError == null && passwordError == null && nameError == null;
  }

  Future<void> signUp() async {
    setState(() {
      loading = true;
      clicked = true;
    });
    try {
      String email = '${emailController.text}@$emailSuffix';
      String password = passwordController.text;
      String name = nameController.text;
      String imageLink = imageLinkController.text;
      bool validResult = _validateInfo(email, password, name);
      if (!validResult) {
        GlobalUtils.showSnackBar(
          context: context,
          message: 'Please fix your input',
          snackBarType: SnackBarType.error,
        );
        setState(() {
          loading = false;
          clicked = false;
        });
        return;
      }
      var cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (cred.user == null) {
        GlobalUtils.showSnackBar(
          context: context,
          message: 'no user created',
          snackBarType: SnackBarType.error,
        );
        setState(() {
          loading = false;
          clicked = false;
        });
        return;
      }

      UserModel userModel = AdminModel(
        email: email,
        name: name,
        uid: cred.user!.uid,
        userImage: imageLink,
      );
      await FirebaseFirestore.instance
          .collection(DBCollections.users)
          .doc(userModel.uid)
          .set(userModel.toJSON());
      GlobalUtils.showSnackBar(
        context: context,
        message: 'User created',
        snackBarType: SnackBarType.success,
      );
    } catch (e) {
      GlobalUtils.showSnackBar(
        context: context,
        message:
            'Please remove user manually from auth firebase ${e.toString()}',
        snackBarType: SnackBarType.error,
      );
    }

    setState(() {
      loading = false;
      clicked = false;
    });
  }
}

class UserTypeChooser extends StatelessWidget {
  final String title;
  final UserType activeType;
  final UserType myType;
  final VoidCallback onTap;

  const UserTypeChooser({
    super.key,
    required this.activeType,
    required this.title,
    required this.myType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Checkbox(
            value: activeType == myType,
            onChanged: (value) {
              onTap();
            },
          ),
          Text(
            title,
            style: TextStyle(
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
