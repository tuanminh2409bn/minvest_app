import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/web/landing/widgets/gradient_button.dart';

class AppDownloadBanner extends StatelessWidget {
  final VoidCallback onClose;

  const AppDownloadBanner({Key? key, required this.onClose}) : super(key: key);

  void _launchStore() {
    html.window.open('https://play.google.com/store/apps/details?id=com.signalgpt.ai', '_blank');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9000FF).withValues(alpha: 0.4),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // App Icon
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/logo_signalgpt.png',
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 64,
                height: 64,
                color: Colors.grey[900],
                child: const Icon(Icons.show_chart, color: Colors.green),
              ),
            ),
          ),
          const SizedBox(width: 20),
          
          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Signal GPT: Trading Signal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Be Vietnam Pro',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Text(
                      '5.0',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        fontFamily: 'Be Vietnam Pro',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      '(41) 41 ${l10n.reviews}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                        fontFamily: 'Be Vietnam Pro',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          
          // Right Side Text & Button
          if (MediaQuery.of(context).size.width > 600) ...[
            Text(
              l10n.getTheAppForBestExperience,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Be Vietnam Pro',
              ),
            ),
            const SizedBox(width: 24),
          ],
          
          GradientButton(
            label: l10n.installApp,
            onPressed: _launchStore,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            borderRadius: 12,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Be Vietnam Pro',
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 24),
          
          // Close button
          GestureDetector(
            onTap: onClose,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}