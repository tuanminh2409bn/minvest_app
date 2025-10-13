import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minvest_forex_app/features/signals/models/signal_model.dart';
import 'package:minvest_forex_app/features/signals/screens/signal_detail_screen.dart';
import 'package:minvest_forex_app/features/verification/screens/upgrade_screen.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class SignalCard extends StatelessWidget {
  final Signal signal;
  final String userTier;
  final bool isLocked;
  final double textScaleFactor;

  const SignalCard({
    super.key,
    required this.signal,
    required this.userTier,
    required this.isLocked,
    this.textScaleFactor = 1.0,
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: textScaleFactor),
      child: GestureDetector(
        onTap: () {
          if (isLocked) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const UpgradeScreen()));
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignalDetailScreen(
                    signal: signal,
                    userTier: userTier,
                  )),
            );
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF151a2e),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blueGrey.withOpacity(0.2)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCardHeader(l10n),
              const Divider(height: 16, color: Colors.blueGrey),
              isLocked ? _buildUpgradeView(l10n) : _buildSignalData(l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardHeader(AppLocalizations l10n) {
    final bool isBuy = signal.type.toLowerCase() == 'buy';
    final Color signalColor = isBuy ? const Color(0xFF238636) : const Color(0xFFDA3633);
    final List<String> flagPaths = _getFlagPathsFromSymbol(signal.symbol);
    final String statusText = signal.getTranslatedResult(l10n);
    final Color statusColor = signal.getStatusColor();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (flagPaths.isNotEmpty)
          SizedBox(
            width: 42, height: 28,
            child: Stack(
              children: List.generate(flagPaths.length, (index) {
                return Positioned(
                  left: index * 14.0,
                  child: CircleAvatar(radius: 14, backgroundColor: Colors.grey.shade800, backgroundImage: AssetImage(flagPaths[index])),
                );
              }),
            ),
          ),
        const SizedBox(width: 8),
        Text(signal.symbol, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: signalColor, borderRadius: BorderRadius.circular(20)),
          child: Text(isBuy ? l10n.buy : l10n.sell, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white)),
        ),
        const Spacer(),
        Text(statusText, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // ... các hàm còn lại không thay đổi
  Widget _buildSignalData(AppLocalizations l10n) {
    const int decimalPlaces = 2;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInfoColumn(l10n.signalEntry, signal.entryPrice.toStringAsFixed(decimalPlaces)),
            _buildInfoColumn(
              l10n.signalSl,
              signal.stopLoss.toStringAsFixed(decimalPlaces),
              valueColor: Colors.redAccent,
              icon: _getStatusIcon('SL', signal.result),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInfoColumn("TP1", signal.takeProfits.isNotEmpty ? signal.takeProfits[0].toStringAsFixed(decimalPlaces) : "---", valueColor: Colors.greenAccent, icon: _getStatusIcon('TP1', signal.result)),
            _buildInfoColumn("TP2", signal.takeProfits.length > 1 ? signal.takeProfits[1].toStringAsFixed(decimalPlaces) : "---", valueColor: Colors.greenAccent, icon: _getStatusIcon('TP2', signal.result)),
            _buildInfoColumn("TP3", signal.takeProfits.length > 2 ? signal.takeProfits[2].toStringAsFixed(decimalPlaces) : "---", valueColor: Colors.greenAccent, icon: _getStatusIcon('TP3', signal.result)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(DateFormat('HH:mm dd/MM/yyyy').format(signal.createdAt.toDate()), style: const TextStyle(color: Colors.white70, fontSize: 11)),
            const Spacer(),
            Row(
              children: [
                Text(l10n.seeDetails, style: const TextStyle(color: Color(0xFF5865F2), fontSize: 11)),
                const Icon(Icons.arrow_forward_ios, size: 11, color: Color(0xFF5865F2)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget? _getStatusIcon(String title, String? result) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle == 'sl' && result?.toLowerCase() == 'sl hit') {
      return const Icon(Icons.cancel, color: Colors.redAccent, size: 16);
    }
    if (lowerTitle.startsWith('tp')) {
      final tpNumber = int.tryParse(lowerTitle.replaceAll('tp', ''));
      if (tpNumber != null && signal.hitTps.contains(tpNumber)) {
        return const Icon(Icons.check_circle, color: Colors.greenAccent, size: 16);
      }
    }
    return null;
  }

  Widget _buildUpgradeView(AppLocalizations l10n) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_buildUpgradeItem(l10n.signalEntry, l10n), _buildUpgradeItem(l10n.signalSl, l10n)]),
        const SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_buildUpgradeItem("TP1", l10n), _buildUpgradeItem("TP2", l10n), _buildUpgradeItem("TP3", l10n)]),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(l10n.upgradeToSeeDetails, style: const TextStyle(color: Colors.grey, fontSize: 11), overflow: TextOverflow.ellipsis)),
            Row(
              children: [
                Text(l10n.upgradeNow, style: const TextStyle(color: Color(0xFF5865F2), fontSize: 11, fontWeight: FontWeight.bold)),
                const Icon(Icons.arrow_forward_ios, size: 11, color: Color(0xFF5865F2)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUpgradeItem(String title, AppLocalizations l10n) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/crown_icon.png', height: 30, width: 30),
              const SizedBox(width: 4),
              Flexible(child: Text(l10n.upgrade, style: const TextStyle(color: Colors.white, fontSize: 17), overflow: TextOverflow.ellipsis)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value, {Color? valueColor, Widget? icon}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: valueColor ?? Colors.white)),
              if (icon != null) ...[const SizedBox(width: 4), icon]
            ],
          )
        ],
      ),
    );
  }
}