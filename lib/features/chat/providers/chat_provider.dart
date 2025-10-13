import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatProvider with ChangeNotifier {
  int _unreadRoomsCount = 0;
  StreamSubscription<QuerySnapshot>? _chatRoomsSubscription;

  int get unreadRoomsCount => _unreadRoomsCount;

  ChatProvider() {
    // Lắng nghe sự thay đổi trạng thái đăng nhập
    FirebaseAuth.instance.authStateChanges().listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? user) {
    if (user != null) {
      // Khi người dùng đăng nhập, bắt đầu lắng nghe dữ liệu chat
      _listenToChatRooms();
    } else {
      // Khi người dùng đăng xuất, dừng lắng nghe và reset
      _stopListening();
    }
  }

  void _listenToChatRooms() {
    _stopListening(); // Đảm bảo không có listener nào bị trùng lặp

    _chatRoomsSubscription = FirebaseFirestore.instance
        .collection('chat_rooms')
        .where('isReadBySupport', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      _unreadRoomsCount = snapshot.docs.length;
      notifyListeners(); // Thông báo cho UI cập nhật
    }, onError: (error) {
      print('Lỗi khi lắng nghe phòng chat chưa đọc: $error');
      _unreadRoomsCount = 0;
      notifyListeners();
    });
  }

  void _stopListening() {
    _chatRoomsSubscription?.cancel();
    _chatRoomsSubscription = null;
    _unreadRoomsCount = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    _chatRoomsSubscription?.cancel();
    super.dispose();
  }
}