// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_line.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/init/runtime_variables.dart';
import 'package:student_evaluation/models/message_model.dart';
import 'package:student_evaluation/models/room_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/screens/chat_screen/widgets/message_card.dart';
import 'package:student_evaluation/screens/chat_screen/widgets/send_msg_box.dart';
import 'package:student_evaluation/screens/home_screen/widgets/bottom_line_time_line.dart';
import 'package:student_evaluation/screens/home_screen/widgets/bottom_navbar.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_dashboard.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_screen_search_box.dart';
import 'package:student_evaluation/screens/home_screen/widgets/home_screen_tabs_title.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_title.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_line_widget.dart';
import 'package:student_evaluation/screens/home_screen/widgets/time_table_card.dart';
import 'package:student_evaluation/screens/home_screen/widgets/top_line_time_line.dart';
import 'package:student_evaluation/screens/messages_screen/messages_screen.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/individual_chat_card.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/messages_screen_tabs_title.dart';
import 'package:student_evaluation/screens/messages_screen/widgets/user_avatar.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:intl/intl.dart' as intl;
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/transformers/enums_transformers.dart';

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
  StreamSubscription? keyboardListener;
  List<MessageModel> messages = [];
  UserModel? otherUser;
  String? roomId;
  MessagesMode? mode;

  @override
  void initState() {
    loadMessages();
    _listenToKeyboardVisibility();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    controller.dispose();
    messagesListener?.cancel();
    keyboardListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: colorTheme.backGround,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: colorTheme.kBlueColor.withOpacity(.5),
        flexibleSpace: HAppBarFlexibleArea(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              otherUser?.name ?? '...',
              style: h1LightTextStyle,
            ),
            Text(
              otherUser is StudentModel
                  ? gradeTransformer((otherUser as StudentModel).studentGrade)
                  : otherUser is TeacherModel
                      ? classTransformer(
                          (otherUser as TeacherModel).teacherClass)
                      : '',
              style: h4TextStyleInactive.copyWith(
                  color: Colors.white.withOpacity(.8)),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              UserAvatar(
                userImage: otherUser?.userImage,
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
                              child: Column(
                                children: [
                                  VSpace(factor: 1.5),
                                  VSpace(),
                                  Container(
                                    color: colorTheme.backGround,
                                    alignment: Alignment.topCenter,
                                    constraints: BoxConstraints(
                                      minHeight:
                                          Responsive.getHeight(context) / 2,
                                    ),
                                    child: loadingMessages
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                            ),
                                          )
                                        : Column(
                                            children: messages
                                                .map((e) => MessageCard(
                                                      messageModel: e,
                                                      mode: mode ??
                                                          MessagesMode
                                                              .individual,
                                                    ))
                                                .toList(),
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
            if (roomId != null)
              SendMessageBox(
                focusNode: focusNode,
                roomId: roomId!,
                mode: mode ?? MessagesMode.individual,
              ),
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
      MessagesMode mode = passedData['mode'];
      setState(() {
        this.roomId = roomId;
        this.mode = mode;
        loadingMessages = true;
      });
      setOtherUser();
      await loadAllMessages(roomId);
      scrollToEnd();

      setState(() {
        loadingMessages = false;
      });

      runMessagesListener(roomId);
    });
  }

  String get getRefListener {
    if (mode == MessagesMode.groups) {
      return DBCollections.getRef(
        [
          DBCollections.groups,
          roomId!,
          DBCollections.messages,
        ],
      );
    } else {
      return DBCollections.getRef(
        [
          DBCollections.rooms,
          roomId!,
          DBCollections.messages,
        ],
      );
    }
  }

  void runMessagesListener(String roomId) {
    messagesListener = FirebaseDatabase.instance
        .ref(getRefListener)
        .limitToLast(1)
        .onValue
        .listen((msgJson) {
      var test = (msgJson.snapshot.value as Map<dynamic, dynamic>);
      var oneMsgJson = test.entries.first.value;
      Map<String, dynamic> data = {};
      oneMsgJson.forEach((key, value) {
        data[key.toString()] = value;
      });
      MessageModel model = MessageModel.fromJSON(data);
      if (messages.any((element) => element.id == model.id)) return;
      setState(() {
        messages.add(model);
      });
      scrollToEnd();
    });
  }

  Future<void> loadAllMessages(String roomId) async {
    var data = await FirebaseDatabase.instance.ref(getRefListener).get();
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
      double maxExtent = controller.position.maxScrollExtent;
      var bottomHeight = MediaQuery.of(context).viewInsets.bottom;
      logger.e('scrolling to ${maxExtent.toInt()} ${bottomHeight.toInt()}');
      controller.animateTo(
        maxExtent + bottomHeight,
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

  void _listenToKeyboardVisibility() {
    keyboardListener =
        KeyboardVisibilityController().onChange.listen((bool visible) {
      if (visible) {
        if (!mounted) return;
        setState(() {
          scrollToEnd();
        });
      }
    });
  }
}
