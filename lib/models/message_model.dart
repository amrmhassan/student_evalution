import 'package:student_evaluation/transformers/models_fields.dart';
import 'package:student_evaluation/utils/global_utils.dart';

enum MessageType {
  user,
  server,
}

class MessageModel {
  final String id;
  final DateTime createdAt;
  final String senderID;
  final String receiverID;
  final String content;
  final MessageType messageType;

  const MessageModel({
    required this.id,
    required this.createdAt,
    required this.senderID,
    required this.receiverID,
    required this.content,
    required this.messageType,
  });

  Map<String, dynamic> toJSON() {
    return {
      ModelsFields.id: id,
      ModelsFields.createdAt: createdAt.toIso8601String(),
      ModelsFields.senderID: senderID,
      ModelsFields.receiverId: receiverID,
      ModelsFields.content: content,
      ModelsFields.messageType: messageType.name,
    };
  }

  static MessageModel fromJSON(Map<String, dynamic> obj) {
    return MessageModel(
      id: obj[ModelsFields.id],
      createdAt: DateTime.parse(obj[ModelsFields.createdAt]),
      senderID: obj[ModelsFields.senderID],
      receiverID: obj[ModelsFields.receiverId],
      content: obj[ModelsFields.content],
      messageType: GlobalUtils.stringToEnum(
        obj[ModelsFields.messageType],
        MessageType.values,
      ),
    );
  }
}
