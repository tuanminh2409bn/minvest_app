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
  final int initialTabIndex;
  const ProfileScreen({super.key, this.initialTabIndex = 0}); 

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late int _tabIndex;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is int) {
      _tabIndex = args;
    } else {
      _tabIndex = widget.initialTabIndex;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabIndex = widget.initialTabIndex;
  }

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
                constraints: const BoxConstraints(maxWidth: 1221),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const LandingNavBar(),
                      const SizedBox(height: 60),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isMobileLayout = constraints.maxWidth < 900;
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
                              const SizedBox(width: 60),
                              Expanded(
                                child: _buildTabContent(name),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 80),
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
        return const RepaintBoundary(child: _OverviewContent());
      case 1:
        return const RepaintBoundary(child: _SettingContent());
      case 2:
        return const RepaintBoundary(child: _PaymentContent());
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
      width: isMobile ? double.infinity : 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.9,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: const TextStyle(
              color: Color(0xFFAAAAAA),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 36),
          Text(
            '${appLocalizations.nationality} ',
            style: const TextStyle(
              color: Color(0xFFAAAAAA),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.white, thickness: 1),
          const SizedBox(height: 20),
          _menuItem(appLocalizations.overview, 0),
          const SizedBox(height: 8),
          _menuItem(appLocalizations.setting, 1),
          const SizedBox(height: 8),
          _menuItem(appLocalizations.paymentHistory, 2),
          const SizedBox(height: 24),
          if (userRole.toLowerCase().trim() == 'admin') ...[
            const _AdminPanelButton(),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  Widget _menuItem(String title, int index) {
    final isActive = tabIndex == index;
    return InkWell(
      onTap: () => onTabChanged(index),
      borderRadius: BorderRadius.circular(3),
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF161616) : Colors.black,
          borderRadius: BorderRadius.circular(3),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 34),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFFAAAAAA),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.9,
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
      borderRadius: BorderRadius.circular(3),
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 34),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.3)),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          l10n.adminPanel,
          style: const TextStyle(
            color: Color(0xFFAAAAAA),
            fontWeight: FontWeight.w600,
            fontSize: 18,
            letterSpacing: -0.9,
          ),
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
          children: [
            // Signals Plan Box
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFF3F3F3F), width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0xFF3F3F3F), width: 2)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 30),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.signalsPlan,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: -0.9),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(21),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isSmall = constraints.maxWidth < 600;
                        if (isSmall) {
                          return Column(
                            children: [
                              _planCol(l10n.goldSignals, 'gold', userData, activeSubs, isElite, context),
                              const Divider(color: Color(0xFF3F3F3F)),
                              _planCol(l10n.forexSignals, 'forex', userData, activeSubs, isElite, context),
                              const Divider(color: Color(0xFF3F3F3F)),
                              _planCol(l10n.cryptoSignals, 'crypto', userData, activeSubs, isElite, context),
                            ],
                          );
                        }
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _planCol(l10n.goldSignals, 'gold', userData, activeSubs, isElite, context)),
                            Expanded(child: _planCol(l10n.forexSignals, 'forex', userData, activeSubs, isElite, context)),
                            Expanded(child: _planCol(l10n.cryptoSignals, 'crypto', userData, activeSubs, isElite, context)),
                          ],
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // AI Minvest Box
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFF3F3F3F), width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0xFF3F3F3F), width: 2)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 30),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.aiSignalGPT,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: -0.9),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(21),
                    child: Row(
                      children: [
                        Text(
                          l10n.yourTokens,
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.8),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF313131),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            isElite ? l10n.unlimited.toUpperCase() : '$tokenBalance left',
                            style: const TextStyle(color: Color(0xFF3BFF00), fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.8),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Tooltip(
                          message: "Tokens are used to view signal details. Elite users have unlimited access.",
                          child: Container(
                            width: 18,
                            height: 20,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF474747)),
                            alignment: Alignment.center,
                            child: const Text('?', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Abril Fatface')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _planCol(String title, String key, Map<String, dynamic> userData, List<String> activeSubs, bool isElite, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isActive = activeSubs.any((s) => s.toLowerCase() == key.toLowerCase());
    final startDate = _getPackageDate(userData, 'subscriptionsStart', key);
    final expiryDate = _getPackageDate(userData, 'subscriptionsExpiry', key);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: -0.9),
            ),
            const SizedBox(width: 8),
            if (isActive || isElite)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF313131),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  l10n.deactivate,
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          '${l10n.startDate}: ${_formatDate(startDate)}',
          style: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.8),
        ),
        const SizedBox(height: 4),
        Text(
          '${l10n.endDate}: ${_formatDate(expiryDate)}',
          style: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.8),
        ),
      ],
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
    final canToggleGold = isElite || activeSubs.contains('gold');
    final canToggleForex = isElite || activeSubs.contains('forex');
    final canToggleCrypto = isElite || activeSubs.contains('crypto');
    final canToggleAll = isElite;
    
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
        // Main Notification Settings Box (Figma Group 480)
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF111111),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFF3F3F3F), width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 21),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFF3F3F3F), width: 2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations.emailNotificationPreferences,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: -0.9),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      appLocalizations.chooseSignalNotificationTypes,
                      style: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.8),
                    ),
                  ],
                ),
              ),
              // Tiles Area
              Padding(
                padding: const EdgeInsets.all(23),
                child: Column(
                  children: [
                    _SettingTile(
                      label: appLocalizations.allSignalNotifications,
                      value: all,
                      enabled: canToggleAll,
                      onChanged: (v) => _updateSetting('all', v),
                    ),
                    const SizedBox(height: 11),
                    _SettingTile(
                      label: appLocalizations.cryptoSignals,
                      value: crypto,
                      enabled: canToggleCrypto,
                      onChanged: (v) => _updateSetting('crypto', v),
                    ),
                    const SizedBox(height: 11),
                    _SettingTile(
                      label: appLocalizations.forexSignals,
                      value: forex,
                      enabled: canToggleForex,
                      onChanged: (v) => _updateSetting('forex', v),
                    ),
                    const SizedBox(height: 11),
                    _SettingTile(
                      label: appLocalizations.goldSignals,
                      value: gold,
                      enabled: canToggleGold,
                      onChanged: (v) => _updateSetting('gold', v),
                    ),
                  ],
                ),
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
        const SizedBox(height: 24),
        // Update Password Box
        Container(
          width: double.infinity,
          height: 90,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: const Color(0xFF111111),
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: const Color(0xFF3F3F3F), width: 2),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  appLocalizations.updatePasswordSecure,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
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
                  backgroundColor: const Color(0xFF289EFF),
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
        height: 62,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        decoration: BoxDecoration(
          color: const Color(0xFF232323),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.9,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Custom-styled Switch to match Figma look
            Transform.scale(
              scale: 0.8,
              child: Switch(
                value: value,
                activeColor: const Color(0xFFD9D9D9),
                activeTrackColor: const Color(0xFF289EFF),
                inactiveThumbColor: const Color(0xFFD9D9D9),
                inactiveTrackColor: const Color(0xFF474747),
                onChanged: enabled ? onChanged : null,
              ),
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

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF3F3F3F), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 21),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFF3F3F3F), width: 2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.paymentHistory,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: -0.9),
                ),
                const SizedBox(height: 7),
                Text(
                  "View and manage your recent transactions",
                  style: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.8),
                ),
              ],
            ),
          ),
          // Table Area
          Padding(
            padding: const EdgeInsets.all(23),
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
                      child: Text(l10n.noTransactionsFound, style: const TextStyle(color: Colors.white54)),
                    ),
                  );
                }

                final docs = snapshot.data!.docs;

                return Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: const Color(0xFF3F3F3F),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(const Color(0xFF232323)),
                      headingRowHeight: 50,
                      dataRowMinHeight: 55,
                      dataRowMaxHeight: 65,
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
                            DataCell(Text('\$${amount ?? 0}', style: const TextStyle(color: Color(0xFF3BFF00), fontWeight: FontWeight.bold))),
                            DataCell(Text(method, style: const TextStyle(color: Colors.white70))),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                                ),
                                child: Text(l10n.statusSuccess, style: const TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 653),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 40),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF595959), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x7FB49CFF),
                blurRadius: 12,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.changePassword,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Be Vietnam Pro',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                l10n.updatePasswordSecure,
                style: const TextStyle(
                  color: Color(0xFF9A9A9A),
                  fontSize: 18,
                  fontFamily: 'Be Vietnam Pro',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.9,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildTextField(
                controller: _currentPassController,
                label: l10n.currentPassword,
                hint: 'Enter Current Password',
                obscure: _obscureCurrent,
                onToggle: () => setState(() => _obscureCurrent = !_obscureCurrent),
              ),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _newPassController,
                label: l10n.newPassword,
                hint: 'Enter New Password',
                obscure: _obscureNew,
                onToggle: () => setState(() => _obscureNew = !_obscureNew),
              ),
              const SizedBox(height: 12),
              const Text(
                'Password must be at least 6 characters',
                style: TextStyle(
                  color: Color(0xFF9A9A9A),
                  fontSize: 18,
                  fontFamily: 'Be Vietnam Pro',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.9,
                ),
              ),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _confirmPassController,
                label: l10n.confirmNewPassword,
                hint: 'Confirm New Password',
                obscure: _obscureConfirm,
                onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
              ),
              const SizedBox(height: 48),
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2))
                      : const Text(
                          'Update Password',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.9,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Be Vietnam Pro',
            fontWeight: FontWeight.w400,
            letterSpacing: -0.9,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 55,
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0x7F9A9A9A), fontSize: 18),
              filled: true,
              fillColor: const Color(0xFF111111),
              contentPadding: const EdgeInsets.symmetric(horizontal: 18),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFF424242), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFF289EFF), width: 1),
              ),
              suffixIcon: IconButton(
                icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: Colors.white54),
                onPressed: onToggle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}