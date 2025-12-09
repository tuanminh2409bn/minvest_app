// lib/features/signals/services/signal_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/features/signals/models/signal_model.dart';

class SignalService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Signal>> getSignals({
    required bool isLive,
    required String userTier,
    bool allowUnauthenticated = false,
  }) {
    if (_auth.currentUser == null && !allowUnauthenticated) {
      return Stream.value([]);
    }

    Query query = _firestore.collection('signals');

    if (isLive) {
      query = query.where('status', isEqualTo: 'running');
    }

    query = query.orderBy('createdAt', descending: true);

    if (isLive && userTier == 'demo') {
      query = query.limit(20);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Signal.fromFirestore(doc)).toList();
    });
  }

  Future<Signal?> getSignalById(String signalId) async {
    try {
      final docSnapshot =
      await _firestore.collection('signals').doc(signalId).get();
      if (docSnapshot.exists) {
        return Signal.fromFirestore(docSnapshot);
      }
    } catch (e) {
      print('Lỗi khi lấy tín hiệu theo ID: $e');
    }
    return null;
  }
}
