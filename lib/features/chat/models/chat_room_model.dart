import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String userId;
  final String userName;
  final String lastMessageText;
  final Timestamp lastMessageTimestamp;
  final String? lastMessageSenderId; // Thêm trường này để biết ai gửi tin cuối
  final bool isReadBySupport;
  final bool isReadByUser; // Thêm trường này
  final bool isUserTyping;
  final bool isSupportTyping;

  ChatRoom({
    required this.userId,
    required this.userName,
    required this.lastMessageText,
    required this.lastMessageTimestamp,
    this.lastMessageSenderId,
    required this.isReadBySupport,
    required this.isReadByUser, // Thêm vào constructor
    this.isUserTyping = false,
    this.isSupportTyping = false,
  });

  factory ChatRoom.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final typingStatus = data['typingStatus'] as Map<String, dynamic>? ?? {};

    return ChatRoom(
      userId: doc.id,
      userName: data['userName'] ?? 'Unknown User',
      lastMessageText: data['lastMessageText'] ?? '',
      lastMessageTimestamp: data['lastMessageTimestamp'] ?? Timestamp.now(),
      lastMessageSenderId: data['lastMessageSenderId'],
      isReadBySupport: data['isReadBySupport'] ?? true,
      isReadByUser: data['isReadByUser'] ?? true, // Đọc giá trị từ Firestore
      isUserTyping: typingStatus[doc.id] ?? false,
      isSupportTyping: typingStatus['support'] ?? false,
    );
  }
}