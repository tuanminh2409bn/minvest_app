import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minvest_forex_app/features/chat/models/chat_message_model.dart';
import 'package:minvest_forex_app/features/chat/models/chat_room_model.dart';
import 'package:minvest_forex_app/features/chat/models/chat_user_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Bổ sung các service cần thiết
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickAndSendImage({
    required String chatRoomId,
    required bool isSentBySupport,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      // 1. Chọn ảnh từ thư viện
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70, // Nén ảnh để tải lên nhanh hơn
        maxWidth: 1500,    // Giới hạn kích thước ảnh
      );

      if (image == null) return; // Người dùng không chọn ảnh

      final File imageFile = File(image.path);

      // 2. Tạo đường dẫn lưu trữ duy nhất
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final Reference storageRef = _storage.ref('chat_images/$chatRoomId/$fileName');

      // 3. Tải file lên Firebase Storage
      final UploadTask uploadTask = storageRef.putFile(imageFile);

      // 4. Lấy URL của ảnh sau khi tải lên thành công
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      // 5. Gửi tin nhắn hình ảnh
      await _sendImageMessage(
        chatRoomId: chatRoomId,
        imageUrl: downloadUrl,
        senderId: user.uid,
        senderName: user.displayName ?? (isSentBySupport ? 'Hỗ trợ' : 'Người dùng'),
        isSentBySupport: isSentBySupport,
      );

    } catch (e) {
      print('Lỗi khi gửi ảnh: $e');
    }
  }

  Future<void> _sendImageMessage({
    required String chatRoomId,
    required String imageUrl,
    required String senderId,
    required String senderName,
    required bool isSentBySupport,
  }) async {
    final timestamp = Timestamp.now();
    final message = ChatMessage(
      id: '',
      senderId: senderId,
      senderName: senderName,
      timestamp: timestamp,
      type: MessageType.image, // Loại tin nhắn là image
      imageUrl: imageUrl,
    );

    final chatRoomRef = _firestore.collection('chat_rooms').doc(chatRoomId);

    // Cập nhật thông tin phòng chat
    await chatRoomRef.set({
      'lastMessageText': 'Đã gửi một hình ảnh', // Hiển thị text chung cho ảnh
      'lastMessageTimestamp': timestamp,
      'lastMessageSenderId': senderId,
      'isReadBySupport': isSentBySupport,
      'isReadByUser': !isSentBySupport,
    }, SetOptions(merge: true));

    // Thêm tin nhắn ảnh vào subcollection
    await chatRoomRef.collection('messages').add(message.toFirestore());
  }

  // Gửi một tin nhắn văn bản (Hàm cũ được giữ lại và điều chỉnh)
  Future<void> sendTextMessage({
    required String userId,
    required String text,
    required String senderId,
    required String senderName,
    required bool isSentBySupport,
  }) async {
    if (text.trim().isEmpty) return;

    final timestamp = Timestamp.now();
    final message = ChatMessage(
      id: '',
      senderId: senderId,
      senderName: senderName,
      timestamp: timestamp,
      type: MessageType.text, // Loại tin nhắn là text
      text: text,
    );

    // Logic cập nhật phòng chat và thêm tin nhắn
    final chatRoomRef = _firestore.collection('chat_rooms').doc(userId);
    final messagesRef = chatRoomRef.collection('messages');

    await _firestore.runTransaction((transaction) async {
      transaction.set(messagesRef.doc(), message.toFirestore());
      transaction.set(
        chatRoomRef,
        {
          'userId': userId,
          if (!isSentBySupport) 'userName': senderName,
          'lastMessageText': text, // Nội dung tin nhắn
          'lastMessageTimestamp': timestamp,
          'lastMessageSenderId': senderId,
          'isReadBySupport': isSentBySupport,
          'isReadByUser': !isSentBySupport,
        },
        SetOptions(merge: true),
      );
    });
  }

  Stream<List<ChatMessage>> getMessagesStream(String userId) {
    return _firestore
        .collection('chat_rooms')
        .doc(userId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ChatMessage.fromFirestore(doc)).toList();
    });
  }

  Stream<List<ChatRoom>> getChatRoomsStream() {
    return _firestore
        .collection('chat_rooms')
        .orderBy('lastMessageTimestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ChatRoom.fromFirestore(doc)).toList();
    });
  }

  Future<void> markAsReadBySupport(String userId) {
    final chatRoomRef = _firestore.collection('chat_rooms').doc(userId);
    return chatRoomRef.update({'isReadBySupport': true});
  }

  Future<void> markAsReadByUser(String userId) {
    final chatRoomRef = _firestore.collection('chat_rooms').doc(userId);
    return chatRoomRef.update({'isReadByUser': true});
  }

  Future<void> updateTypingStatus({
    required String chatRoomId,
    required String typingUserId,
    required bool isTyping,
  }) {
    final chatRoomRef = _firestore.collection('chat_rooms').doc(chatRoomId);
    return chatRoomRef.set(
      {'typingStatus': {typingUserId: isTyping}},
      SetOptions(merge: true),
    );
  }

  Stream<ChatRoom?> getChatRoomStream(String userId) {
    return _firestore
        .collection('chat_rooms')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return ChatRoom.fromFirestore(snapshot);
      }
      return null;
    });
  }

  Future<ChatUserModel?> getUserDetails(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return ChatUserModel.fromFirestore(doc);
      }
    } catch (e) {
      print('Lỗi khi lấy thông tin người dùng chat: $e');
    }
    return null;
  }
}