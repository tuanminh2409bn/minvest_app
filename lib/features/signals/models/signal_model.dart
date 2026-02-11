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
  final Timestamp? matchedAt;
  final String? result;
  final num? pips;
  final dynamic reason;
  final String matchStatus;
  final List<int> hitTps;
  final bool isMatched;
  final String? leverage;
  final double? closedPrice;
  final double? closedPips;

  Signal({
    required this.id,
    required this.symbol,
    required this.type,
    required this.status,
    required this.entryPrice,
    required this.stopLoss,
    required this.takeProfits,
    required this.createdAt,
    this.matchedAt,
    this.result,
    this.pips,
    this.reason,
    required this.matchStatus,
    this.hitTps = const [],
    this.isMatched = false,
    this.leverage,
    this.closedPrice,
    this.closedPips,
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
      matchedAt: data['matchedAt'],
      result: data['result'],
      pips: data['pips'],
      reason: data['reason'],
      matchStatus: data['matchStatus'] ?? 'NOT MATCHED',
      hitTps: List<int>.from(data['hitTps'] ?? []),
      isMatched: data['isMatched'] ?? false,
      leverage: data['leverage'],
      closedPrice: data['closedPrice'] != null ? (data['closedPrice'] as num).toDouble() : null,
      closedPips: data['closedPips'] != null ? (data['closedPips'] as num).toDouble() : null,
    );
  }

  String getTranslatedResult(AppLocalizations l10n) {
    if (hitTps.contains(3)) return l10n.tp3Hit;
    if (hitTps.contains(2)) return l10n.tp2Hit;
    if (hitTps.contains(1)) return l10n.tp1Hit;

    final lowercasedResult = result?.toLowerCase() ?? '';
    switch (lowercasedResult) {
      case 'sl hit':
        return l10n.slHit;
      case 'cancelled':
      case 'cancelled (new signal)':
        return l10n.cancelled;
      case 'exited by admin':
        return l10n.exitedByAdmin;
    }

    if (status == 'running') {
      return isMatched ? l10n.matched : l10n.notMatched;
    }

    return result ?? l10n.signalClosed;
  }

  Color getStatusColor() {
    if (hitTps.isNotEmpty) return Colors.greenAccent.shade400;

    final lowercasedResult = result?.toLowerCase() ?? '';
    switch (lowercasedResult) {
      case 'sl hit':
        return Colors.redAccent;
      case 'cancelled':
      case 'cancelled (new signal)':
      case 'exited by admin':
        return Colors.grey;
    }

    if (status == 'running') {
      return isMatched ? Colors.greenAccent.shade400 : Colors.amber.shade400;
    }

    return Colors.blueGrey.shade200;
  }
}