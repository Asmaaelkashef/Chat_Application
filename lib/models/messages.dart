import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String id;
  final DateTime createdAt; 

factory Message.fromJson(Map<String, dynamic> json) {
  return Message(
    message: json['message'] as String,
    id: json['id'] as String,
    createdAt: (json['createdAt'] as Timestamp).toDate(),
  );
}


  Message({required this.message, required this.id, required this.createdAt});
}
