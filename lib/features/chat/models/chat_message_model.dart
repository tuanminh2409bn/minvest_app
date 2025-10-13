import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image }

class ChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final Timestamp timestamp;
  final MessageType type;

  // Dành cho tin nhắn văn bản
  final String? text;
  // Dành cho tin nhắn hình ảnh
  final String? imageUrl;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.timestamp,
    required this.type,
    this.text,
    this.imageUrl,
  });

  factory ChatMessage.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Mặc định là tin nhắn văn bản
    MessageType type = MessageType.text;
    if (data['type'] == 'image') {
      type = MessageType.image;
    }

    return ChatMessage(
      id: doc.id,
      senderId: data['senderId'] ?? '',
      senderName: data['senderName'] ?? 'Unknown',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      type: type,
      text: data['text'],
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'timestamp': timestamp,
      'type': type.name, // Lưu tên của enum (vd: 'text', 'image')
      'text': text,
      'imageUrl': imageUrl,
    };
  }
}