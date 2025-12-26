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
import 'package:minvest_forex_app/web/theme/breakpoints.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _tabIndex = 0; // 0: Overview, 1: Setting, 2: Payment

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    final appLocalizations = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!
        : appLocalizations.yourName;
    final email = user?.email ?? '';

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: isMobile ? const TextScaler.linear(0.6) : const TextScaler.linear(1.0),
      ),
      child: Scaffold(
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
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isMobileLayout = constraints.maxWidth < 800;
                          if (isMobileLayout) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _ProfileSidebar(
                                  name: name,
                                  email: email,
                                  tabIndex: _tabIndex,
                                  onTabChanged: (i) => setState(() => _tabIndex = i),
                                  appLocalizations: appLocalizations,
                                  isMobile: true,
                                ),
                                const SizedBox(height: 24),
                                _buildTabContent(name),
                              ],
                            );
                          }
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ProfileSidebar(
                                name: name,
                                email: email,
                                tabIndex: _tabIndex,
                                onTabChanged: (i) => setState(() => _tabIndex = i),
                                appLocalizations: appLocalizations,
                                isMobile: false,
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: _buildTabContent(name),
                              ),
                            ],
                          );
                        },
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
  final bool isMobile;

  const _ProfileSidebar({
    required this.name,
    required this.email,
    required this.tabIndex,
    required this.onTabChanged,
    required this.appLocalizations,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userRole = userProvider.role ?? 'user';

    return Container(
      width: isMobile ? double.infinity : 260,
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
          if (isMobile) ...[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _tabButton(appLocalizations.overview, 0, horizontal: true),
                  const SizedBox(width: 8),
                  _tabButton(appLocalizations.setting, 1, horizontal: true),
                  const SizedBox(width: 8),
                  _tabButton(appLocalizations.paymentHistory, 2, horizontal: true),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (userRole.toLowerCase().trim() == 'admin') ...[
                  const Expanded(child: _AdminPanelButton(horizontal: true)),
                  const SizedBox(width: 8),
                ],
                const Expanded(child: _LogoutButton(horizontal: true)),
              ],
            ),
          ] else ...[
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
        ],
      ),
    );
  }

  Widget _tabButton(String text, int index, {bool horizontal = false}) {
    final bool active = tabIndex == index;
    return Padding(
      padding: horizontal ? EdgeInsets.zero : const EdgeInsets.only(bottom: 10),
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
          alignment: horizontal ? Alignment.center : Alignment.centerLeft,
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
  final bool horizontal;
  const _AdminPanelButton({this.horizontal = false});

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
        alignment: horizontal ? Alignment.center : Alignment.centerLeft,
        child: Row(
          mainAxisSize: horizontal ? MainAxisSize.min : MainAxisSize.max,
          children: [
            const Icon(Icons.admin_panel_settings, color: Colors.blueAccent, size: 20),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                l10n.adminPanel,
                style: AppTextStyles.body.copyWith(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final bool horizontal;
  const _LogoutButton({this.horizontal = false});

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
        alignment: horizontal ? Alignment.center : Alignment.centerLeft,
        child: Row(
          mainAxisSize: horizontal ? MainAxisSize.min : MainAxisSize.max,
          children: [
            const Icon(Icons.logout, color: Colors.redAccent, size: 20),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                l10n.logout,
                style: AppTextStyles.body.copyWith(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                overflow: TextOverflow.ellipsis,
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
    final l10n = AppLocalizations.of(context)!;

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
                        Text(l10n.currentPlan, style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                        const SizedBox(height: 4),
                        Text(
                          isElite ? l10n.tierElite.toUpperCase() : l10n.standard,
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
                          Text(l10n.availableTokens, style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                          const SizedBox(height: 4),
                          Text(
                            isElite ? l10n.unlimited.toUpperCase() : '$tokenBalance',
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
            Text(l10n.subscriptions, style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 12),
            
            _buildSubscriptionCard(context, l10n.goldSignals, 'gold', userData, activeSubs, isElite),
            const SizedBox(height: 12),
            _buildSubscriptionCard(context, l10n.forexSignals, 'forex', userData, activeSubs, isElite),
            const SizedBox(height: 12),
            _buildSubscriptionCard(context, l10n.cryptoSignals, 'crypto', userData, activeSubs, isElite),
          ],
        );
      },
    );
  }

  Widget _buildSubscriptionCard(BuildContext context, String title, String key, Map<String, dynamic> userData, List<String> activeSubs, bool isElite) {
    final l10n = AppLocalizations.of(context)!;
    final isActive = activeSubs.any((s) => s.toLowerCase() == key.toLowerCase());
    final startDate = _getPackageDate(userData, 'subscriptionsStart', key);
    final expiryDate = _getPackageDate(userData, 'subscriptionsExpiry', key);
    
    String statusText = l10n.inactive;
    Color statusColor = Colors.grey;
    String detailText = l10n.usesTokenPerView;

    if (isElite) {
      statusText = l10n.activeElite;
      statusColor = Colors.purpleAccent;
      detailText = l10n.unlimitedAccess;
    } else if (isActive) {
      statusText = l10n.active;
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          final settings = data['notificationSettings'] as Map<String, dynamic>? ?? {};
          if (mounted) {
            setState(() {
              all = settings['all'] ?? true;
              crypto = settings['crypto'] ?? true;
              forex = settings['forex'] ?? true;
              gold = settings['gold'] ?? true;
              _isLoading = false;
            });
          }
        } else {
           if (mounted) setState(() => _isLoading = false);
        }
      } catch (e) {
        if (mounted) setState(() => _isLoading = false);
      }
    } else {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _updateSetting(String key, bool value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Optimistic UI update
    setState(() {
      if (key == 'all') all = value;
      else if (key == 'crypto') crypto = value;
      else if (key == 'forex') forex = value;
      else if (key == 'gold') gold = value;
    });

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'notificationSettings': {
          'all': all,
          'crypto': crypto,
          'forex': forex,
          'gold': gold,
        }
      }, SetOptions(merge: true));
    } catch (e) {
      // Revert if failed
      _loadSettings();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update settings')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final userProvider = Provider.of<UserProvider>(context);
    final tier = userProvider.userTier?.toLowerCase() ?? 'free';
    final activeSubs = userProvider.activeSubscriptions;

    final isElite = tier == 'elite';
    // Elite users can toggle everything.
    // Single package users can only toggle their specific package.
    final canToggleGold = isElite || activeSubs.contains('gold');
    final canToggleForex = isElite || activeSubs.contains('forex');
    final canToggleCrypto = isElite || activeSubs.contains('crypto');
    // "All" switch is reserved for Elite users who have access to everything
    final canToggleAll = isElite;
    
    // Check if user is effectively free (no access to any notification toggles)
    final isFree = !canToggleGold && !canToggleForex && !canToggleCrypto;

    if (_isLoading) {
      return const Center(child: Padding(
        padding: EdgeInsets.all(40.0),
        child: CircularProgressIndicator(color: Color(0xFF04B3E9)),
      ));
    }

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
                enabled: canToggleAll,
                onChanged: (v) => _updateSetting('all', v),
              ),
              const SizedBox(height: 10),
              _SettingTile(
                label: appLocalizations.cryptoSignals,
                value: crypto,
                enabled: canToggleCrypto,
                onChanged: (v) => _updateSetting('crypto', v),
              ),
              const SizedBox(height: 10),
              _SettingTile(
                label: appLocalizations.forexSignals,
                value: forex,
                enabled: canToggleForex,
                onChanged: (v) => _updateSetting('forex', v),
              ),
              const SizedBox(height: 10),
              _SettingTile(
                label: appLocalizations.goldSignals,
                value: gold,
                enabled: canToggleGold,
                onChanged: (v) => _updateSetting('gold', v),
              ),
            ],
          ),
        ),
        if (isFree) ...[
          const SizedBox(height: 12),
          Text(
            appLocalizations.featureForVipOnly,
            style: AppTextStyles.caption.copyWith(color: Colors.redAccent, fontStyle: FontStyle.italic),
          ),
        ],
        const SizedBox(height: 16),
        _CardContainer(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  appLocalizations.updatePasswordSecure,
                  style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const _ChangePasswordDialog(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF04B3E9),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text(appLocalizations.changePassword),
              ),
            ],
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
  final bool enabled;

  const _SettingTile({
    required this.label,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.body.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Switch(
              value: value,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xFF04B3E9),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey.shade700,
              onChanged: enabled ? onChanged : null,
            ),
          ],
        ),
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
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.transactionHistory, style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 18)),
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
                    child: Text(l10n.noTransactionsFound, style: AppTextStyles.body.copyWith(color: Colors.white54)),
                  ),
                );
              }

              final docs = snapshot.data!.docs;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(Colors.white10),
                  columns: [
                    DataColumn(label: Text(l10n.colDate, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(l10n.colProduct, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(l10n.colAmount, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(l10n.colMethod, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(l10n.colStatus, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
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
                            child: Text(l10n.statusSuccess, style: const TextStyle(color: Colors.green, fontSize: 11)),
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

class _ChangePasswordDialog extends StatefulWidget {
  const _ChangePasswordDialog();

  @override
  State<_ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<_ChangePasswordDialog> {
  final _currentPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();
  bool _isLoading = false;
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    final l10n = AppLocalizations.of(context)!;
    if (_newPassController.text != _confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.passwordsDoNotMatch)),
      );
      return;
    }
    if (_newPassController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password must be at least 6 characters")),
      );
      return;
    }

    setState(() => _isLoading = true);
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      try {
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: _currentPassController.text,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(_newPassController.text);
        
        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.passwordUpdateSuccess), backgroundColor: Colors.green),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          String errorMsg = l10n.passwordUpdateFailed(e.message ?? 'Unknown error');
          if (e.code == 'wrong-password') {
            errorMsg = l10n.reauthFailed;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMsg), backgroundColor: Colors.red),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.passwordUpdateFailed(e.toString())), backgroundColor: Colors.red),
          );
        }
      }
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Dialog(
      backgroundColor: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.changePassword,
              style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _currentPassController,
              label: l10n.currentPassword,
              obscure: _obscureCurrent,
              onToggle: () => setState(() => _obscureCurrent = !_obscureCurrent),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _newPassController,
              label: l10n.newPassword,
              obscure: _obscureNew,
              onToggle: () => setState(() => _obscureNew = !_obscureNew),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _confirmPassController,
              label: l10n.confirmNewPassword,
              obscure: _obscureConfirm,
              onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _changePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF04B3E9),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: _isLoading
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : Text(l10n.changePassword, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.black54,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: Colors.white54),
          onPressed: onToggle,
        ),
      ),
    );
  }
}