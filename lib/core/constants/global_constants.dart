// ignore_for_file: prefer_const_constructors

import 'package:student_evaluation/models/message_model.dart';
import 'package:uuid/uuid.dart';

const String emailSuffix = 'kids.corner.edu.eg';
String serverId = 'serverId';

MessageModel firstServerMessage = MessageModel(
  id: Uuid().v4(),
  createdAt: DateTime.now(),
  senderID: serverId,
  content: 'Chat Created 😁',
  messageType: MessageType.server,
);
