import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUserModel {
  final String uid;
  final String displayName;
  final String? email;
  final String subscriptionTier;

  ChatUserModel({
    required this.uid,
    required this.displayName,
    this.email,
    required this.subscriptionTier,
  });

  factory ChatUserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ChatUserModel(
      uid: doc.id,
      // Lấy displayName từ Firebase Auth nếu có, nếu không thì lấy từ user doc
      displayName: data['displayName'] ?? 'Người dùng',
      email: data['email'],
      subscriptionTier: data['subscriptionTier'] ?? 'free',
    );
  }
}