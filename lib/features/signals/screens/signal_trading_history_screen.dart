// lib/features/signals/screens/signal_trading_history_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minvest_forex_app/features/signals/models/signal_model.dart';

class SignalTradingHistoryScreen extends StatelessWidget {
  final Signal signal;

  const SignalTradingHistoryScreen({super.key, required this.signal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Trading History ',
                  style: TextStyle(
                    color: Color(0xFF636363),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 36),

                // TP3 (Nếu có)
                if (signal.hitTps.contains(3))
                  _buildHistoryEvent(
                    title: 'TP3 LIVE',
                    price: signal.takeProfits.length > 2 ? signal.takeProfits[2].toString() : '-',
                    description: 'Target reached',
                    time: signal.createdAt.toDate().add(const Duration(hours: 3)),
                    isPriceGreen: true,
                  ),

                // TP2 (Nếu có)
                if (signal.hitTps.contains(2))
                  _buildHistoryEvent(
                    title: 'TP2 LIVE',
                    price: signal.takeProfits.length > 1 ? signal.takeProfits[1].toString() : '-',
                    description: 'Target reached',
                    time: signal.createdAt.toDate().add(const Duration(hours: 2)),
                    isPriceGreen: true,
                  ),

                // TP1 (Nếu có)
                if (signal.hitTps.contains(1))
                  _buildHistoryEvent(
                    title: 'TP1 LIVE',
                    price: signal.takeProfits.isNotEmpty ? signal.takeProfits[0].toString() : '-',
                    description: 'Target reached',
                    time: signal.createdAt.toDate().add(const Duration(hours: 1)),
                    isPriceGreen: true,
                  ),

                // SL Hit (Nếu có)
                if (signal.result?.toLowerCase() == 'sl hit')
                  _buildHistoryEvent(
                    title: 'SL HIT',
                    price: signal.stopLoss.toString(),
                    description: 'Stop loss triggered',
                    time: signal.createdAt.toDate().add(const Duration(hours: 1)),
                    isPriceGreen: false,
                    titleColor: const Color(0xFFE3001E),
                  ),

                // Matched
                if (signal.isMatched)
                  _buildHistoryEvent(
                    title: 'Signal Matched',
                    price: '',
                    description: 'Matched',
                    time: signal.matchedAt?.toDate() ?? signal.createdAt.toDate().add(const Duration(minutes: 30)),
                    titleColor: const Color(0xFF276EFB),
                  ),

                // Created
                _buildHistoryEvent(
                  title: 'Signal Created',
                  price: '',
                  description: 'Entry: ${signal.entryPrice}',
                  time: signal.createdAt.toDate(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryEvent({
    required String title,
    required String price,
    required String description,
    required DateTime time,
    bool isPriceGreen = false,
    Color titleColor = Colors.white,
  }) {
    final String formattedTime = DateFormat('dd/MM HH:mm').format(time);

    return Container(
      margin: const EdgeInsets.only(bottom: 38),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (price.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Text(
                      price,
                      style: TextStyle(
                        color: isPriceGreen ? const Color(0xFF00BB32) : const Color(0xFFE3001E),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300, // Đổi từ w250 sang w300
                ),
              ),
              Text(
                formattedTime,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}