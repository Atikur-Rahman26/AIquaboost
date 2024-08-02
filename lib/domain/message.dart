import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String message;
  final String messagePhoto;
  final Timestamp timeStamp;
  final String messageID;
  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.messagePhoto,
    required this.timeStamp,
    required this.messageID,
  });

  Map<String, dynamic> toMap() {
    return {
      'sender_ID': senderId,
      'receiver_ID': receiverId,
      'message': message,
      'message_photo': messagePhoto,
      'timestamp': timeStamp,
      'message_ID': messageID
    };
  }
}
