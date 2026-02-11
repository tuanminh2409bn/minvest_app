import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';
import 'package:app_settings/app_settings.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Be Vietnam Pro',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              
              // Device Settings Hint
              GestureDetector(
                onTap: () => AppSettings.openAppSettings(type: AppSettingsType.notification),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF636363)),
                      ),
                      child: const Icon(Icons.notifications_none, size: 16, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enable notifications in device settings to view new updates on the lock screen',
                            style: TextStyle(
                              color: Color(0xFF636363),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Navigate to the device settings.',
                            style: TextStyle(
                              color: Color(0xFF276EFB),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Settings List
              Consumer<NotificationProvider>(
                builder: (context, provider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildToggleSection(
                        title: 'All Signal Notifications',
                        subtitle: provider.isAllEnabled ? 'Turn off all notifications' : 'Pause all notifications',
                        value: provider.isAllEnabled,
                        onChanged: (val) => provider.toggleAll(val),
                      ),
                      const SizedBox(height: 24),
                      _buildToggleSection(
                        title: 'Crypto Signals',
                        subtitle: 'Turn on crypto signals',
                        value: provider.isCryptoEnabled,
                        onChanged: (val) => provider.toggleCrypto(val),
                      ),
                      const SizedBox(height: 24),
                      _buildToggleSection(
                        title: 'Forex Signals',
                        subtitle: 'Turn on forex signals',
                        value: provider.isForexEnabled,
                        onChanged: (val) => provider.toggleForex(val),
                      ),
                      const SizedBox(height: 24),
                      _buildToggleSection(
                        title: 'Gold Signals',
                        subtitle: 'Turn on gold signals',
                        value: provider.isGoldEnabled,
                        onChanged: (val) => provider.toggleGold(val),
                      ),
                    ],
                  );
                },
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleSection({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Color(0xFF636363),
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        _CustomSwitch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _CustomSwitch({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 40,
        height: 20,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: value ? const Color(0xFF289EFF) : const Color(0xFF636363),
            width: 1,
          ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              gradient: value
                  ? const LinearGradient(
                      colors: [Color(0xFF0CA3ED), Color(0xFF276EFB)],
                    )
                  : const LinearGradient(
                      colors: [Color(0xFF636363), Color(0xFF636363)],
                    ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
