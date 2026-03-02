import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String productId;
  final String status; // purchased, pending, error, etc.
  final DateTime timestamp;
  final double amount;
  final String currency;
  final String? platform; // ios, android

  TransactionModel({
    required this.id,
    required this.productId,
    required this.status,
    required this.timestamp,
    this.amount = 0.0,
    this.currency = 'USD',
    this.platform,
  });

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TransactionModel(
      id: doc.id,
      productId: data['productId'] ?? '',
      status: data['status'] ?? 'purchased',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
      currency: data['currency'] ?? 'USD',
      platform: data['platform'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'status': status,
      'timestamp': Timestamp.fromDate(timestamp),
      'amount': amount,
      'currency': currency,
      'platform': platform,
    };
  }
}
