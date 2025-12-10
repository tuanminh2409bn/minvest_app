//lib/features/signals/screens/signal_detail_screen_web.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minvest_forex_app/core/providers/language_provider.dart';
import 'package:minvest_forex_app/features/signals/models/signal_model.dart';
import 'package:minvest_forex_app/features/verification/screens/upgrade_screen.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SignalDetailScreen extends StatelessWidget {
  final Signal signal;
  final String userTier;

  const SignalDetailScreen({
    super.key,
    required this.signal,
    required this.userTier,
  });

  static const Map<String, String> _currencyFlags = {
    'AUD': 'assets/images/aud_flag.png',
    'CHF': 'assets/images/chf_flag.png',
    'EUR': 'assets/images/eur_flag.png',
    'GBP': 'assets/images/gbp_flag.png',
    'JPY': 'assets/images/jpy_flag.png',
    'NZD': 'assets/images/nzd_flag.png',
    'USD': 'assets/images/us_flag.png',
    'XAU': 'assets/images/crown_icon.png',
  };

  List<String> _getFlagPathsFromSymbol(String symbol) {
    final parts = symbol.toUpperCase().split('/');
    if (parts.length == 2) {
      final path1 = _currencyFlags[parts[0]];
      final path2 = _currencyFlags[parts[1]];
      return [if (path1 != null) path1, if (path2 != null) path2];
    }
    return [];
  }

  // ▼▼▼ HÀM ĐÃ ĐƯỢC SỬA LẠI ĐỂ AN TOÀN TUYỆT ĐỐI ▼▼▼
  String _getTranslatedReason(BuildContext context, AppLocalizations l10n) {
    final currentLocale =
        Provider.of<LanguageProvider>(context, listen: false).locale;
    final dynamic reasonData = signal.reason; // Giữ kiểu là dynamic

    // Trường hợp 1: Dữ liệu là dạng Map (cấu trúc mới)
    // Kiểm tra tường minh `is Map` để Dart hiểu và cho phép truy cập key
    if (reasonData is Map) {
      final langCode = currentLocale?.languageCode ?? 'en';

      // Lấy bản dịch và kiểm tra kiểu an toàn
      final translatedText = reasonData[langCode];
      if (translatedText is String && translatedText.isNotEmpty) {
        return translatedText;
      }

      // Nếu không có, dự phòng về tiếng Anh
      final fallbackText = reasonData['en'];
      if (fallbackText is String && fallbackText.isNotEmpty) {
        return fallbackText;
      }
    }

    // Trường hợp 2: Dữ liệu là String (tương thích ngược với tín hiệu cũ)
    if (reasonData is String && reasonData.isNotEmpty) {
      return reasonData;
    }

    // Trường hợp 3: Dữ liệu null, rỗng hoặc không đúng định dạng
    return l10n.noReasonProvided;
  }
  // ▲▲▲ KẾT THÚC SỬA LỖI ▲▲▲

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final List<String> flagPaths = _getFlagPathsFromSymbol(signal.symbol);
    final String statusText = signal.getTranslatedResult(l10n);
    const Color statusColor = Color(0xFF289EFF);
    final String reasonText = _getTranslatedReason(context, l10n);

    final DateTime created = _toDateTime(signal.createdAt);
    final String createdLabel =
        '(GMT +7) ${DateFormat('dd/MM/yyyy, HH:mm:ss').format(created)}';

    final String entryText = _formatPrice(signal.entryPrice);
    final String slText = _formatPrice(signal.stopLoss);
    final String tp1 = signal.takeProfits.isNotEmpty
        ? _formatPrice(signal.takeProfits[0])
        : '—';
    final String tp2 = signal.takeProfits.length > 1
        ? _formatPrice(signal.takeProfits[1])
        : '—';
    final String tp3 = signal.takeProfits.length > 2
        ? _formatPrice(signal.takeProfits[2])
        : '—';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        scrolledUnderElevation: 0,
        elevation: 0,
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Colors.black),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Header(
                    flagPaths: flagPaths,
                    symbol: signal.symbol,
                    statusText: statusText,
                    type: signal.type,
                    createdLabel: createdLabel,
                  ),
                  const SizedBox(height: 16),
                  _SectionCard(
                    title: 'Price Levels',
                    child: _PriceGrid(
                      topItems: [
                        PriceCell(
                            label: 'ENTRY',
                            value: entryText,
                            color: const Color(0xFF289EFF)),
                        PriceCell(
                            label: 'SL',
                            value: slText,
                            color: const Color(0xFFE54747)),
                      ],
                      bottomItems: [
                        PriceCell(
                            label: 'TP1',
                            value: tp1,
                            color: const Color(0xFF3BFF00)),
                        PriceCell(
                            label: 'TP2',
                            value: tp2,
                            color: const Color(0xFF3BFF00)),
                        PriceCell(
                            label: 'TP3',
                            value: tp3,
                            color: const Color(0xFF3BFF00)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SectionCard(
                    title: 'Capital Management',
                    child: Text(
                      reasonText,
                      style: const TextStyle(
                          color: Colors.white70, height: 1.6, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (userTier != 'elite') const _UpgradeSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTime _toDateTime(dynamic createdAt) {
    if (createdAt is Timestamp) return createdAt.toDate().toLocal();
    if (createdAt is DateTime) return createdAt.toLocal();
    return DateTime.now();
  }

  String _formatPrice(num? value) {
    if (value == null) return '—';
    return value.toStringAsFixed(5);
  }

  Color _statusColor(String status) {
    final lower = status.toLowerCase();
    if (lower.contains('pending')) return const Color(0xFFFFA726);
    if (lower.contains('run') || lower.contains('live'))
      return const Color(0xFF18D46F);
    if (lower.contains('sl')) return const Color(0xFFE54747);
    return Colors.white;
  }
}

class _TokenCounter extends StatelessWidget {
  const _TokenCounter();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Text('10 free signals left', style: TextStyle(color: Color(0xFF289EFF), fontSize: 13, fontWeight: FontWeight.w700));
    }
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text('10 free signals left', style: TextStyle(color: Color(0xFF289EFF), fontSize: 13, fontWeight: FontWeight.w700));
        }
        final data = snapshot.data!.data() ?? {};
        final tier = (data['subscriptionTier'] ?? 'free').toString().toLowerCase();
        if (tier == 'elite') {
          return const Text('Unlimited signals', style: TextStyle(color: Color(0xFF289EFF), fontSize: 13, fontWeight: FontWeight.w700));
        }
        final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
        final storedDate = (data['freeTokensDate'] ?? '') as String;
        final used = (data['freeTokensUsed'] ?? 0) as int;
        final effectiveUsed = storedDate == todayKey ? used : 0;
        final left = (10 - effectiveUsed).clamp(0, 10);
        return Text('$left free signals left', style: const TextStyle(color: Color(0xFF289EFF), fontSize: 13, fontWeight: FontWeight.w700));
      },
    );
  }
}

class _Header extends StatelessWidget {
  final List<String> flagPaths;
  final String symbol;
  final String statusText;
  final String type;
  final String createdLabel;
  const _Header({
    required this.flagPaths,
    required this.symbol,
    required this.statusText,
    required this.type,
    required this.createdLabel,
  });

  @override
  Widget build(BuildContext context) {
    final isBuy = type.toLowerCase() == 'buy';
    final typeColor = isBuy ? const Color(0xFF18D46F) : const Color(0xFFE54747);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F111A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (flagPaths.isNotEmpty)
                SizedBox(
                  width: 52,
                  height: 32,
                  child: Stack(
                    children: List.generate(flagPaths.length, (index) {
                      return Positioned(
                        left: index * 16.0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey.shade800,
                          backgroundImage: AssetImage(flagPaths[index]),
                        ),
                      );
                    }),
                  ),
                ),
              if (flagPaths.isNotEmpty) const SizedBox(width: 10),
              Text(
                symbol.toUpperCase(),
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
              const SizedBox(width: 10),
              Text(
                statusText,
                style: const TextStyle(
                    color: Color(0xFF289EFF),
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 12),
              Row(
                children: [
                  Icon(isBuy ? Icons.north_east : Icons.south_east,
                      color: typeColor, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    isBuy ? 'Buy' : 'Sell',
                    style: TextStyle(
                        color: typeColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 16),
                label: const Text('Go back',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.white70, size: 16),
              const SizedBox(width: 6),
              Text(
                createdLabel,
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F111A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.widgets_outlined,
                  color: Colors.white70, size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class PriceCell {
  final String label;
  final String value;
  final Color color;
  PriceCell({required this.label, required this.value, required this.color});
}

class _PriceGrid extends StatelessWidget {
  final List<PriceCell> topItems;
  final List<PriceCell> bottomItems;
  const _PriceGrid({required this.topItems, required this.bottomItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: _rowChildren(topItems, fillTo: 3),
        ),
        const SizedBox(height: 12),
        Row(
          children: _rowChildren(bottomItems, fillTo: 3),
        ),
      ],
    );
  }

  List<Widget> _rowChildren(List<PriceCell> cells, {required int fillTo}) {
    final padded = List<PriceCell?>.from(cells);
    while (padded.length < fillTo) {
      padded.add(null);
    }
    final widgets = <Widget>[];
    for (int i = 0; i < padded.length; i++) {
      widgets.add(
        Expanded(
          child: padded[i] == null
              ? const SizedBox()
              : _PriceBox(cell: padded[i]!),
        ),
      );
      if (i != padded.length - 1) widgets.add(const SizedBox(width: 12));
    }
    return widgets;
  }
}

class _PriceBox extends StatelessWidget {
  final PriceCell cell;
  const _PriceBox({required this.cell});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0E16),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${cell.label}:',
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            cell.value,
            style: TextStyle(
                color: cell.color, fontSize: 15, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _UpgradeSection extends StatelessWidget {
  const _UpgradeSection();

  @override
  Widget build(BuildContext context) {
    const List<String> perks = [
      'Continuously updating market data 24/7',
      'Providing the best signals in real time',
      'Includes Entry, SL, TP',
      'Detailed analysis and evaluation of each signal',
      'Real-time notifications via email',
      'Signal performance statistics',
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F111A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              _TokenCounter(),
              Spacer(),
              Text('Gold Plan',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('\$78',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w800)),
                  SizedBox(height: 6),
                  Text('/month',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
              const Spacer(),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pushNamed('/pricing'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color(0xFF04B3E9),
                        Color(0xFF2E60FF),
                        Color(0xFFD500F9)
                      ]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      child: Text('Upgrade Now',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: perks.map((p) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C0E16),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white12),
                ),
                child: Text(p,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
