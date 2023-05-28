// ignore_for_file: prefer_const_constructors

import 'package:student_evaluation/init/runtime_variables.dart';
import 'package:student_evaluation/models/message_model.dart';
import 'package:student_evaluation/utils/providers_calls.dart';
import 'package:uuid/uuid.dart';

const String emailSuffix = 'kids.corner.edu.eg';
const String doctorEmail = 'doctor@$emailSuffix';
bool get isDoctor {
  var userModel = Providers.userPf(navigatorKey.currentContext!).userModel;
  return userModel?.email == doctorEmail;
}

String serverId = 'serverId';

MessageModel firstServerMessage = MessageModel(
  id: Uuid().v4(),
  createdAt: DateTime.now(),
  senderID: serverId,
  content: 'Chat Created 😁',
  messageType: MessageType.server,
);
