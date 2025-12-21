import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/web/landing/widgets/navbar.dart';
import 'package:minvest_forex_app/web/landing/sections/footer_section.dart';
import 'package:minvest_forex_app/web/theme/text_styles.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/features/admin/screens/admin_panel_screen_web.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _tabIndex = 0; // 0: Overview, 1: Setting, 2: Payment

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!
        : appLocalizations.yourName;
    final email = user?.email ?? '';

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LandingNavBar(),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ProfileSidebar(
                          name: name,
                          email: email,
                          tabIndex: _tabIndex,
                          onTabChanged: (i) => setState(() => _tabIndex = i),
                          appLocalizations: appLocalizations,
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildTabContent(name),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const FooterSection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(String name) {
    switch (_tabIndex) {
      case 0:
        return const _OverviewContent();
      case 1:
        return const _SettingContent();
      case 2:
        return const _PaymentContent();
      default:
        return const SizedBox.shrink();
    }
  }
}

// --- Helpers ---
String _formatDate(dynamic date) {
  if (date == null) return '---';
  if (date is Timestamp) return DateFormat('dd/MM/yyyy').format(date.toDate());
  return '---';
}

dynamic _getMapValueCaseInsensitive(Map<String, dynamic> map, String key) {
  if (map.isEmpty) return null;
  final lowerKey = key.toLowerCase();
  for (final k in map.keys) {
    if (k.toLowerCase() == lowerKey) return map[k];
  }
  return null;
}

dynamic _getPackageDate(Map<String, dynamic> userData, String fieldPrefix, String packageKey) {
  final nested = userData[fieldPrefix];
  if (nested is Map<String, dynamic>) {
    final val = _getMapValueCaseInsensitive(nested, packageKey);
    if (val != null) return val;
  }
  // Fallback for flat keys like "subscriptionsExpiry.gold"
  final targetKey = '$fieldPrefix.$packageKey'.toLowerCase();
  for (final k in userData.keys) {
    if (k.toLowerCase() == targetKey) return userData[k];
  }
  return null;
}

// --- Components ---

class _ProfileSidebar extends StatelessWidget {
  final String name;
  final String email;
  final int tabIndex;
  final ValueChanged<int> onTabChanged;
  final AppLocalizations appLocalizations;

  const _ProfileSidebar({
    required this.name,
    required this.email,
    required this.tabIndex,
    required this.onTabChanged,
    required this.appLocalizations,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userRole = userProvider.role ?? 'user';

    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white24,
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
                    if (email.isNotEmpty)
                      Text(email, style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(appLocalizations.nationality, style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 24),
          _tabButton(appLocalizations.overview, 0),
          _tabButton(appLocalizations.setting, 1),
          _tabButton(appLocalizations.paymentHistory, 2),
          const SizedBox(height: 24),
          if (userRole.toLowerCase().trim() == 'admin') ...[
            const _AdminPanelButton(),
            const SizedBox(height: 10),
          ],
          const _LogoutButton(),
        ],
      ),
    );
  }

  Widget _tabButton(String text, int index) {
    final bool active = tabIndex == index;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => onTabChanged(index),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF151515) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: active ? Colors.white : Colors.white24),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

class _AdminPanelButton extends StatelessWidget {
  const _AdminPanelButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AdminPanelScreen()),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2C),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.3)),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Icon(Icons.admin_panel_settings, color: Colors.blueAccent, size: 20),
            const SizedBox(width: 12),
            Text(
              l10n.adminPanel,
              style: AppTextStyles.body.copyWith(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () {
        context.read<AuthBloc>().add(SignOutRequested(providersToReset: [
          context.read<UserProvider>(),
          context.read<NotificationProvider>(),
        ]));
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1E0A0A),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Icon(Icons.logout, color: Colors.redAccent, size: 20),
            const SizedBox(width: 12),
            Text(
              l10n.logout,
              style: AppTextStyles.body.copyWith(
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewContent extends StatelessWidget {
  const _OverviewContent();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const SizedBox.shrink();

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final userData = snapshot.data?.data() as Map<String, dynamic>? ?? {};
        final tier = (userData['subscriptionTier'] as String?)?.toLowerCase() ?? 'free';
        final tokenBalance = userData['tokenBalance'] ?? 0;
        final activeSubs = List<String>.from(userData['activeSubscriptions'] ?? []);

        final isElite = tier == 'elite';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Token & Tier Card
            _CardContainer(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Current Plan', style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                        const SizedBox(height: 4),
                        Text(
                          isElite ? 'ELITE' : 'STANDARD',
                          style: AppTextStyles.h2.copyWith(color: isElite ? Colors.purpleAccent : Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 40, color: Colors.white12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Available Tokens', style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                          const SizedBox(height: 4),
                          Text(
                            isElite ? 'UNLIMITED' : '$tokenBalance',
                            style: AppTextStyles.h2.copyWith(
                              color: isElite ? Colors.greenAccent : (tokenBalance > 0 ? Colors.greenAccent : Colors.redAccent),
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Subscriptions List
            Text('Subscriptions', style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 12),
            
            _buildSubscriptionCard(context, 'Gold', 'gold', userData, activeSubs, isElite),
            const SizedBox(height: 12),
            _buildSubscriptionCard(context, 'Forex', 'forex', userData, activeSubs, isElite),
            const SizedBox(height: 12),
            _buildSubscriptionCard(context, 'Crypto', 'crypto', userData, activeSubs, isElite),
          ],
        );
      },
    );
  }

  Widget _buildSubscriptionCard(BuildContext context, String title, String key, Map<String, dynamic> userData, List<String> activeSubs, bool isElite) {
    final isActive = activeSubs.any((s) => s.toLowerCase() == key.toLowerCase());
    final startDate = _getPackageDate(userData, 'subscriptionsStart', key);
    final expiryDate = _getPackageDate(userData, 'subscriptionsExpiry', key);
    
    String statusText = 'Inactive';
    Color statusColor = Colors.grey;
    String detailText = 'Uses 1 Token per view';

    if (isElite) {
      statusText = 'Active (Elite)';
      statusColor = Colors.purpleAccent;
      detailText = 'Unlimited Access';
    } else if (isActive) {
      statusText = 'Active';
      statusColor = Colors.greenAccent;
      detailText = '${_formatDate(startDate)} - ${_formatDate(expiryDate)}';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isActive || isElite ? statusColor.withValues(alpha: 0.3) : Colors.white12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              key == 'gold' ? Icons.monetization_on : (key == 'crypto' ? Icons.currency_bitcoin : Icons.currency_exchange),
              color: statusColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(detailText, style: AppTextStyles.caption.copyWith(color: Colors.white70)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: statusColor.withValues(alpha: 0.3)),
            ),
            child: Text(
              statusText.toUpperCase(),
              style: AppTextStyles.caption.copyWith(color: statusColor, fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingContent extends StatefulWidget {
  const _SettingContent();

  @override
  State<_SettingContent> createState() => _SettingContentState();
}

class _SettingContentState extends State<_SettingContent> {
  bool all = true;
  bool crypto = true;
  bool forex = true;
  bool gold = true;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _CardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(appLocalizations.emailNotificationPreferences, style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
              const SizedBox(height: 6),
              Text(
                appLocalizations.chooseSignalNotificationTypes,
                style: AppTextStyles.caption.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 14),
              _SettingTile(
                label: appLocalizations.allSignalNotifications,
                value: all,
                onChanged: (v) => setState(() => all = v),
              ),
              const SizedBox(height: 10),
              _SettingTile(
                label: appLocalizations.cryptoSignals,
                value: crypto,
                onChanged: (v) => setState(() => crypto = v),
              ),
              const SizedBox(height: 10),
              _SettingTile(
                label: appLocalizations.forexSignals,
                value: forex,
                onChanged: (v) => setState(() => forex = v),
              ),
              const SizedBox(height: 10),
              _SettingTile(
                label: appLocalizations.goldSignals,
                value: gold,
                onChanged: (v) => setState(() => gold = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _CardContainer(
          child: Text(
            appLocalizations.updatePasswordSecure,
            style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class _SettingTile extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _SettingTile({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          Text(label, style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
          const Spacer(),
          Switch(
            value: value,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF04B3E9),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade700,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _PaymentContent extends StatelessWidget {
  const _PaymentContent();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Transaction History', style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 16),
        _CardContainer(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('transactions')
                .orderBy('transactionDate', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text('No transactions found.', style: AppTextStyles.body.copyWith(color: Colors.white54)),
                  ),
                );
              }

              final docs = snapshot.data!.docs;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(Colors.white10),
                  columns: const [
                    DataColumn(label: Text('Date', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Product', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Amount', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Method', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Status', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  ],
                  rows: docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final date = (data['transactionDate'] as Timestamp?)?.toDate();
                    final amount = data['amount'];
                    final product = (data['productId'] as String?)?.toUpperCase() ?? 'N/A';
                    final method = (data['paymentMethod'] as String?) ?? 'N/A';
                    
                    return DataRow(
                      cells: [
                        DataCell(Text(date != null ? DateFormat('dd/MM/yyyy').format(date) : '---', style: const TextStyle(color: Colors.white70))),
                        DataCell(Text(product, style: const TextStyle(color: Colors.white))),
                        DataCell(Text('\$${amount ?? 0}', style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold))),
                        DataCell(Text(method, style: const TextStyle(color: Colors.white70))),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('Success', style: TextStyle(color: Colors.green, fontSize: 11)),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CardContainer extends StatelessWidget {
  final Widget child;
  const _CardContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24),
      ),
      child: child,
    );
  }
}