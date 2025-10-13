import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class Signal {
  final String id;
  final String symbol;
  final String type;
  final String status;
  final double entryPrice;
  final double stopLoss;
  final List<dynamic> takeProfits;
  final Timestamp createdAt;
  final String? result;
  final num? pips;
  final dynamic reason;
  final String matchStatus;
  final List<int> hitTps;
  final bool isMatched;

  Signal({
    required this.id,
    required this.symbol,
    required this.type,
    required this.status,
    required this.entryPrice,
    required this.stopLoss,
    required this.takeProfits,
    required this.createdAt,
    this.result,
    this.pips,
    this.reason,
    required this.matchStatus,
    this.hitTps = const [],
    this.isMatched = false,
  });

  factory Signal.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Signal(
      id: doc.id,
      symbol: data['symbol'] ?? '',
      type: data['type'] ?? 'buy',
      status: data['status'] ?? 'running',
      entryPrice: (data['entryPrice'] ?? 0.0).toDouble(),
      stopLoss: (data['stopLoss'] ?? 0.0).toDouble(),
      takeProfits: List.from(data['takeProfits'] ?? []),
      createdAt: data['createdAt'] ?? Timestamp.now(),
      result: data['result'],
      pips: data['pips'],
      reason: data['reason'],
      matchStatus: data['matchStatus'] ?? 'NOT MATCHED',
      hitTps: List<int>.from(data['hitTps'] ?? []),
      isMatched: data['isMatched'] ?? false,
    );
  }

  String getTranslatedResult(AppLocalizations l10n) {
    // --- ƯU TIÊN 1: Hiển thị thành tích TP cao nhất đã đạt được ---
    if (hitTps.contains(3)) return l10n.tp3Hit;
    if (hitTps.contains(2)) return l10n.tp2Hit;
    if (hitTps.contains(1)) return l10n.tp1Hit;

    // --- ƯU TIÊN 2: Nếu chưa có TP, hiển thị các trạng thái khác ---
    final lowercasedResult = result?.toLowerCase() ?? '';
    switch (lowercasedResult) {
    // (Không cần case cho TP nữa vì đã xử lý ở trên)
      case 'sl hit':
        return l10n.slHit;
      case 'cancelled':
      case 'cancelled (new signal)':
        return l10n.cancelled;
      case 'exited by admin':
        return l10n.exitedByAdmin;
    }

    // --- ƯU TIÊN 3: Xử lý các tín hiệu đang chạy ---
    if (status == 'running') {
      return isMatched ? l10n.matched : l10n.notMatched;
    }

    // --- DỰ PHÒNG: Trả về trạng thái gốc nếu không khớp ---
    return result ?? l10n.signalClosed;
  }

  Color getStatusColor() {
    // --- ƯU TIÊN 1: Màu cho thành tích TP ---
    if (hitTps.isNotEmpty) return Colors.greenAccent.shade400;

    // --- ƯU TIÊN 2: Màu cho các trạng thái khác ---
    final lowercasedResult = result?.toLowerCase() ?? '';
    switch (lowercasedResult) {
      case 'sl hit':
        return Colors.redAccent;
      case 'cancelled':
      case 'cancelled (new signal)':
      case 'exited by admin':
        return Colors.grey;
    }

    // --- ƯU TIÊN 3: Màu cho các tín hiệu đang chạy ---
    if (status == 'running') {
      return isMatched ? Colors.greenAccent.shade400 : Colors.amber.shade400;
    }

    // Màu dự phòng
    return Colors.blueGrey.shade200;
  }
}