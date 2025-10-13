// lib/features/notifications/models/notification_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  // THAY ĐỔI 1: Chuyển từ String sang Map để chứa các bản dịch
  final Map<String, dynamic> titleLoc;
  final Map<String, dynamic> bodyLoc;
  final String type;
  final String? signalId;
  final Timestamp timestamp;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.titleLoc, // Cập nhật constructor
    required this.bodyLoc,  // Cập nhật constructor
    required this.type,
    this.signalId,
    required this.timestamp,
    required this.isRead,
  });

  // THAY ĐỔI 2: Thêm các hàm helper để lấy đúng ngôn ngữ
  /// Lấy tiêu đề theo mã ngôn ngữ (ví dụ: 'vi' hoặc 'en')
  /// Có logic dự phòng để tránh lỗi
  String getTitle(String langCode) {
    return titleLoc[langCode] ?? titleLoc['vi'] ?? titleLoc['en'] ?? 'No Title';
  }

  /// Lấy nội dung theo mã ngôn ngữ (ví dụ: 'vi' hoặc 'en')
  /// Có logic dự phòng để tránh lỗi
  String getBody(String langCode) {
    return bodyLoc[langCode] ?? bodyLoc['vi'] ?? bodyLoc['en'] ?? 'No Body';
  }


  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // THAY ĐỔI 3: Cập nhật logic đọc dữ liệu từ Firestore
    // Ưu tiên đọc trường mới `title_loc`.
    // Nếu không có, nó sẽ tự tạo từ trường `title` cũ để tương thích ngược.
    final titleData = data['title_loc'] is Map
        ? Map<String, dynamic>.from(data['title_loc'])
        : {'vi': data['title'] ?? 'No Title', 'en': data['title'] ?? 'No Title'};

    final bodyData = data['body_loc'] is Map
        ? Map<String, dynamic>.from(data['body_loc'])
        : {'vi': data['body'] ?? 'No Body', 'en': data['body'] ?? 'No Body'};

    return NotificationModel(
      id: doc.id,
      titleLoc: titleData,
      bodyLoc: bodyData,
      type: data['type'] ?? 'unknown',
      signalId: data['signalId'],
      timestamp: data['timestamp'] ?? Timestamp.now(),
      isRead: data['isRead'] ?? false,
    );
  }
}