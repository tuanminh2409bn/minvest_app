// lib/features/notifications/services/notification_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/features/notifications/models/notification_model.dart';

class NotificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Lấy danh sách tất cả thông báo của người dùng hiện tại
  Stream<List<NotificationModel>> getNotifications() {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.value([]); // Trả về rỗng nếu chưa đăng nhập
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .limit(50) // Giới hạn 50 thông báo gần nhất để tối ưu hiệu suất
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => NotificationModel.fromFirestore(doc))
        .toList());
  }

  // Lắng nghe số lượng thông báo CHƯA ĐỌC
  Stream<int> getUnreadNotificationCount() {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.value(0);
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('notifications')
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  // Đánh dấu tất cả thông báo là ĐÃ ĐỌC
  Future<void> markAllAsRead() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final notificationsRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('notifications');

    // Lấy tất cả các thông báo chưa đọc
    final unreadSnapshot = await notificationsRef.where('isRead', isEqualTo: false).get();

    if (unreadSnapshot.docs.isEmpty) return;

    // Dùng batch để cập nhật tất cả cùng lúc cho hiệu quả
    final batch = _firestore.batch();
    for (var doc in unreadSnapshot.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }
}