//lib/features/signals/screens/signal_detail_screen_mobile.dart

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
    'AUD': 'assets/images/aud_flag.png', 'CHF': 'assets/images/chf_flag.png',
    'EUR': 'assets/images/eur_flag.png', 'GBP': 'assets/images/gbp_flag.png',
    'JPY': 'assets/images/jpy_flag.png', 'NZD': 'assets/images/nzd_flag.png',
    'USD': 'assets/images/us_flag.png', 'XAU': 'assets/images/crown_icon.png',
  };

  List<String> _getFlagPathsFromSymbol(String symbol) {
    final parts = symbol.toUpperCase().split('/');
    if (parts.length == 2) {
      final path1 = _currencyFlags[parts[0]];
      final path2 = _currencyFlags[parts[1]];
      return [ if (path1 != null) path1, if (path2 != null) path2 ];
    }
    return [];
  }

  // ▼▼▼ HÀM ĐÃ ĐƯỢC SỬA LẠI ĐỂ AN TOÀN TUYỆT ĐỐI ▼▼▼
  String _getTranslatedReason(BuildContext context, AppLocalizations l10n) {
    final currentLocale = Provider.of<LanguageProvider>(context, listen: false).locale;
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
    final bool canViewReason = userTier == 'elite';
    final List<String> flagPaths = _getFlagPathsFromSymbol(signal.symbol);
    final String statusText = signal.getTranslatedResult(l10n);
    final Color statusColor = signal.getStatusColor();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            if (flagPaths.isNotEmpty)
              SizedBox(
                width: 42,
                height: 28,
                child: Stack(
                  children: List.generate(flagPaths.length, (index) {
                    return Positioned(
                      left: index * 14.0,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.grey.shade800,
                        backgroundImage: AssetImage(flagPaths[index]),
                      ),
                    );
                  }),
                ),
              ),
            const SizedBox(width: 10),
            Text(
              signal.symbol,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D1117), Color(0xFF161B22), Color.fromARGB(255, 20, 29, 110)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea( // <-- Thêm SafeArea ở đây
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildDetailCard(context, canViewReason, statusText, statusColor, l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(BuildContext context, bool canViewReason, String statusText, Color statusColor, AppLocalizations l10n) {
    const int decimalPlaces = 2;
    final String reasonText = _getTranslatedReason(context, l10n);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151a2e),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(l10n.status, statusText, valueColor: statusColor),
          _buildInfoRow(l10n.sentOn, DateFormat('HH:mm dd/MM/yyyy').format(signal.createdAt.toDate())),
          const Divider(height: 30, color: Colors.blueGrey),
          _buildPriceRow(l10n.entryPrice, signal.entryPrice.toStringAsFixed(decimalPlaces), signal.result),
          _buildPriceRow(l10n.stopLossFull, signal.stopLoss.toStringAsFixed(decimalPlaces), signal.result),
          _buildPriceRow(l10n.takeProfitFull1, signal.takeProfits.isNotEmpty ? signal.takeProfits[0].toStringAsFixed(decimalPlaces) : '—', signal.result),
          _buildPriceRow(l10n.takeProfitFull2, signal.takeProfits.length > 1 ? signal.takeProfits[1].toStringAsFixed(decimalPlaces) : '—', signal.result),
          _buildPriceRow(l10n.takeProfitFull3, signal.takeProfits.length > 2 ? signal.takeProfits[2].toStringAsFixed(decimalPlaces) : '—', signal.result),
          const Divider(height: 30, color: Colors.blueGrey),
          Text(
            l10n.reason,
            style: const TextStyle(color: Color(0xFF5865F2), fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          canViewReason
              ? Text(
            reasonText,
            style: const TextStyle(color: Colors.white70, height: 1.5, fontSize: 14),
          )
              : _buildUpgradeToView(context, reasonText, l10n),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: valueColor ?? Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String title, String value, String? result) {
    Icon? statusIcon;
    final String lowerTitle = title.toLowerCase().replaceAll(' ', '');

    if ((lowerTitle == 'stoploss' || lowerTitle == 'dừnglỗ') && result?.toLowerCase() == 'sl hit') {
      statusIcon = const Icon(Icons.cancel, color: Color(0xFFDA3633), size: 18);
    }

    if (lowerTitle.contains('take') || lowerTitle.contains('chốt')) {
      final tpNumber = int.tryParse(lowerTitle.replaceAll(RegExp(r'[^0-9]'), ''));
      if (tpNumber != null && signal.hitTps.contains(tpNumber)) {
        statusIcon = const Icon(Icons.check_circle, color: Colors.greenAccent, size: 18);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14))
          ),
          Row(
            children: [
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
              if (statusIcon != null) ...[
                const SizedBox(width: 8),
                statusIcon,
              ]
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradeToView(BuildContext context, String reason, AppLocalizations l10n) {
    if (reason == l10n.noReasonProvided) {
      return Column(
        children: [
          Text(
            l10n.upgradeToViewReason,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, height: 1.5, fontSize: 14),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UpgradeScreen())),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
              child: Ink(
                decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF172AFE), Color(0xFF3C4BFE), Color(0xFF5E69FD)], begin: Alignment.centerLeft, end: Alignment.centerRight), borderRadius: BorderRadius.circular(12)),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/crown_icon.png', height: 24, width: 24),
                      const SizedBox(width: 8),
                      Text(l10n.upgradeAccount, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.transparent],
              stops: [0.6, 1.0],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: Text(
            reason,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70, height: 1.5, fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UpgradeScreen())),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
              child: Ink(
                decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF172AFE), Color(0xFF3C4BFE), Color(0xFF5E69FD)], begin: Alignment.centerLeft, end: Alignment.centerRight), borderRadius: BorderRadius.circular(12)),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/crown_icon.png', height: 24, width: 24),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                            l10n.upgradeToViewFullAnalysis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}