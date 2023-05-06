// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_line.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/models/message_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/chat_screen/widgets/message_card.dart';
import 'package:student_evaluation/screens/home_screen/widgets/bottom_line_time_line.dart';
import 'package:student_evaluation/screens/home_screen/widgets/bottom_navbar.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_dashboard.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_screen_search_box.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_screen_tabs_title.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_title.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_widget.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_table_card.dart';
import 'package:student_evaluation/screens/home_screen/widgets/top_line_time_line.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/message_card.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/messages_screen_tabs_title.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/user_avatar.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:intl/intl.dart' as intl;
import 'package:student_evaluation/transformers/collections.dart';

import '../home_screen/widgets/home_screen_appbar.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/ChatScreen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  ScrollController controller = ScrollController();
  FocusNode focusNode = FocusNode();
  bool loadingMessages = false;
  StreamSubscription? messagesListener;
  List<MessageModel> messages = [];
  late UserModel otherUser;

  @override
  void initState() {
    scrollToEnd();
    loadMessages();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNode.addListener(() {
        scrollToEnd();
      });
    });

    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    controller.dispose();
    messagesListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: colorTheme.kBlueColor.withOpacity(.5),
        flexibleSpace: HAppBarFlexibleArea(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jasmine',
              style: h1LightTextStyle,
            ),
            Text(
              'F: Jane Cooper | 6th 8',
              style: h4TextStyleInactive.copyWith(
                  color: Colors.white.withOpacity(.8)),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              UserAvatar(
                userImage: null,
              ),
              HSpace(),
            ],
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: colorTheme.kBlueColor,
                    width: double.infinity,
                    height: 400,
                  ),
                  SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: double.infinity),
                        VSpace(factor: 5),
                        Column(
                          children: [
                            VSpace(factor: 1.5),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    largeBorderRadius,
                                  ),
                                  topRight: Radius.circular(
                                    largeBorderRadius,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  VSpace(factor: 1.5),
                                  VSpace(),
                                  ...List.generate(
                                    100,
                                    (index) => MessageCard(
                                      mine: Random().nextBool(),
                                    ),
                                  ),
                                ],
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
            SendMessageBox(focusNode: focusNode),
          ],
        ),
      ),
    );
  }

  void loadMessages() async {
    Future.delayed(Duration.zero).then((value) async {
      var passedData =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      String roomId = passedData['roomId'];
      setState(() {
        loadingMessages = true;
      });
      setOtherUser();
      await loadAllMessages(roomId);

      setState(() {
        loadingMessages = false;
      });

      runMessagesListener(roomId);
    });
  }

  void runMessagesListener(String roomId) {
    messagesListener = FirebaseDatabase.instance
        .ref(DBCollections.getRef(
            [DBCollections.rooms, roomId, DBCollections.messages]))
        .limitToLast(1)
        .onValue
        .listen((msgJson) {
      var test = (msgJson.snapshot.value as Map<dynamic, dynamic>);
      Map<String, dynamic> data = {};
      test.forEach((key, value) {
        data[key.toString()] = value;
      });
      MessageModel model = MessageModel.fromJSON(data);
      messages.add(model);
    });
  }

  Future<void> loadAllMessages(String roomId) async {
    var data = await FirebaseDatabase.instance
        .ref(DBCollections.getRef(
            [DBCollections.rooms, roomId, DBCollections.messages]))
        .get();
    for (var msgJson in data.children) {
      var test = (msgJson.value as Map<dynamic, dynamic>);
      Map<String, dynamic> data = {};
      test.forEach((key, value) {
        data[key.toString()] = value;
      });
      MessageModel model = MessageModel.fromJSON(data);
      messages.add(model);
    }
  }

  void scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
      );
    });
  }

  void setOtherUser() {
    var data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
      otherUser = data['user'];
    });
  }
}

class SendMessageBox extends StatelessWidget {
  const SendMessageBox({
    super.key,
    required this.focusNode,
  });

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: colorTheme.backGround,
      padding: EdgeInsets.symmetric(
        horizontal: kHPad,
        vertical: kVPad / 2,
      ),
      child: CustomTextField(
        focusNode: focusNode,
        borderRadius: BorderRadius.circular(1000),
        backgroundColor: colorTheme.kBlueColor,
        hintStyle: h4LightTextStyle.copyWith(
          color: Colors.white.withOpacity(
            .7,
          ),
        ),
        textStyle: h4LightTextStyle,
        padding: EdgeInsets.zero,
        title: 'Type Something...',
        color: colorTheme.kBlueColor,
        trailingIcon: ButtonWrapper(
          padding: EdgeInsets.all(largePadding),
          borderRadius: 1000,
          onTap: () {},
          backgroundColor: colorTheme.kBlueColor,
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
