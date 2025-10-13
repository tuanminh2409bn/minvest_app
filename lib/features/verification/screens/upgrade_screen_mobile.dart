// lib/features/verification/screens/upgrade_screen_mobile.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/features/verification/screens/account_verification_screen.dart';
import 'package:minvest_forex_app/features/verification/screens/package_screen_mobile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bool isIos = Platform.isIOS;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          l10n.upgradeAccount,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      l10n.compareTiers,
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTiersTable(l10n),
                  const SizedBox(height: 30),
                  if (!isIos) ...[
                    _buildActionButton(
                      context,
                      text: l10n.openExnessAccount,
                      onPressed: () {
                        _launchURL('https://my.exmarkets.guide/accounts/sign-up/303589?utm_source=partners&ex_ol=1');
                      },
                      isPrimary: true,
                    ),
                    const SizedBox(height: 16),
                    _buildActionButton(
                      context,
                      text: l10n.accountVerificationWithExness,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AccountVerificationScreen()),
                        );
                      },
                      isPrimary: true,
                    ),
                    const SizedBox(height: 16),
                  ],
                  _buildActionButton(
                    context,
                    text: l10n.payInAppToUpgrade,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PackageScreen()),
                      );
                    },
                    isPrimary: true,
                  ),
                  const SizedBox(height: 24),
                  _buildActionButton(
                    context,
                    text: l10n.contactUs, // "Liên Hệ Hỗ Trợ"
                    onPressed: () {
                      _launchURL('https://t.me/HotlineMinvest');
                    },
                    isPrimary: false, // Nút kiểu phụ (viền)
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTiersTable(AppLocalizations l10n) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Table(
        border: TableBorder(
          horizontalInside: BorderSide(color: Colors.blueGrey.withOpacity(0.3), width: 1),
          verticalInside: BorderSide(color: Colors.blueGrey.withOpacity(0.3), width: 1),
        ),
        columnWidths: const {
          0: FlexColumnWidth(1.6),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(1),
        },
        children: [
          _buildTableRow([l10n.feature, l10n.tierDemo, l10n.tierVIP, l10n.tierElite], isHeader: true),
          _buildTableRow([l10n.balance, '< \$200', '> \$200', '> \$500']),
          _buildTableRow([l10n.signalTime, '8h-17h', '8h-17h', l10n.tableValueFulltime]),
          _buildTableRow([l10n.signalQty, '7-8/day', l10n.tableValueFull, l10n.tableValueFull]),
          _buildTableRow([l10n.analysis, 'icon:cancel', 'icon:cancel', 'icon:check']),
          _buildTableRow([l10n.lotPerWeek, '0.05', '0.3', '0.5']),
        ],
      ),
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      decoration: isHeader ? const BoxDecoration(color: Color(0xFF151a2e)) : null,
      children: cells.map((cell) {
        final isFirstCell = cells.indexOf(cell) == 0;
        Widget cellWidget;

        if (cell.startsWith('icon:')) {
          IconData iconData = cell == 'icon:check' ? Icons.check_circle : Icons.cancel;
          Color iconColor = cell == 'icon:check' ? Colors.greenAccent : Colors.redAccent;
          cellWidget = Icon(iconData, color: iconColor, size: 18);
        } else {
          cellWidget = Text(
            cell,
            textAlign: isFirstCell ? TextAlign.left : TextAlign.center,
            softWrap: true,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              color: isHeader ? Colors.white : Colors.white70,
              fontSize: 13,
            ),
          );
        }

        return TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            decoration: (isHeader && !isFirstCell)
                ? const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF172AFE), Color(0xFF3C4BFE), Color(0xFF5E69FD)],
              ),
            )
                : (isHeader && isFirstCell)
                ? const BoxDecoration(
              color: Color(0xFF172AFE),
            )
                : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              child: cellWidget,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButton(BuildContext context, {required String text, required VoidCallback onPressed, required bool isPrimary}) {
    return SizedBox(
      height: 50,
      width: double.infinity, // Thêm để nút luôn rộng tối đa
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: isPrimary
                ? const LinearGradient(
              colors: [Color(0xFF172AFE), Color(0xFF3C4BFE), Color(0xFF5E69FD)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )
                : null,
            color: isPrimary ? null : const Color(0xFF151a2e),
            borderRadius: BorderRadius.circular(12),
            border: isPrimary ? null : Border.all(color: Colors.blueAccent),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}