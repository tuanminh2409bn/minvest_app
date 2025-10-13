import 'package:flutter/material.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class UpgradeSuccessScreen extends StatelessWidget {
  const UpgradeSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userTier = userProvider.userTier ?? 'N/A';
    final tierInfo = _getTierInfo(userTier, l10n);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D1117), Color(0xFF161B22), Color.fromARGB(255, 20, 29, 110)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 80),
                  const SizedBox(height: 20),
                  Text(
                    l10n.accountUpgradedSuccessfully,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151a2e),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                currentUser?.displayName ?? l10n.yourName,
                                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                userTier.toUpperCase(),
                                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              currentUser?.email ?? l10n.yourEmail,
                              style: const TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                        const Divider(height: 30, color: Colors.blueGrey),
                        ...tierInfo.entries.map((entry) => _buildBenefitRow(entry.key, entry.value)).toList(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Text(
                      '${l10n.returnToHomePage} >',
                      style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14))),
          const SizedBox(width: 16),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Map<String, String> _getTierInfo(String tier, AppLocalizations l10n) {
    switch (tier.toLowerCase()) {
      case 'demo':
        return {
          l10n.signalTime: '8h-17h',
          l10n.lotPerWeek: '0.05',
          l10n.signalQty: '7-8 per day',
        };
      case 'vip':
        return {
          l10n.signalTime: '8h-17h',
          l10n.lotPerWeek: '0.3',
          l10n.signalQty: l10n.tableValueFull,
        };
      case 'elite':
        return {
          l10n.signalTime: l10n.tableValueFulltime,
          l10n.lotPerWeek: '0.5',
          l10n.signalQty: l10n.tableValueFull,
        };
      default:
        return {
          l10n.signalTime: 'N/A',
          l10n.lotPerWeek: 'N/A',
          l10n.signalQty: 'N/A',
        };
    }
  }
}
