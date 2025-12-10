import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/web/landing/widgets/navbar.dart';
import 'package:minvest_forex_app/web/landing/sections/footer_section.dart';
import 'package:minvest_forex_app/web/theme/colors.dart';
import 'package:minvest_forex_app/web/theme/text_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _tabIndex = 0; // 0: Overview, 1: Setting, 2: Payment

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!
        : 'User';
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

class _ProfileSidebar extends StatelessWidget {
  final String name;
  final String email;
  final int tabIndex;
  final ValueChanged<int> onTabChanged;
  const _ProfileSidebar({
    required this.name,
    required this.email,
    required this.tabIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
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
          Text('Nationality:', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 24),
          _tabButton('Overview', 0),
          _tabButton('Setting', 1),
          _tabButton('Payment History', 2),
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

class _OverviewContent extends StatelessWidget {
  const _OverviewContent();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _CardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Signals Plan', style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Expanded(child: _PlanTile(title: 'Gold Signals')),
                  SizedBox(width: 12),
                  Expanded(child: _PlanTile(title: 'Forex Signals')),
                  SizedBox(width: 12),
                  Expanded(child: _PlanTile(title: 'Crypto Signals')),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _CardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('AI Minvest', style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  children: [
                    Text('Your Tokens', style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 12),
                    _TokenBadge(uid: user?.uid),
                    const SizedBox(width: 8),
                    const Icon(Icons.help_outline, size: 16, color: Colors.white54),
                  ],
                ),
              ),
            ],
          ),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _CardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email Notification Preferences', style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
              const SizedBox(height: 6),
              Text(
                'Choose which types of signal notifications you want to receive via email',
                style: AppTextStyles.caption.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 14),
              _SettingTile(
                label: 'All Signal Notifications',
                value: all,
                onChanged: (v) => setState(() => all = v),
              ),
              const SizedBox(height: 10),
              _SettingTile(
                label: 'Crypto Signals',
                value: crypto,
                onChanged: (v) => setState(() => crypto = v),
              ),
              const SizedBox(height: 10),
              _SettingTile(
                label: 'Forex Signals',
                value: forex,
                onChanged: (v) => setState(() => forex = v),
              ),
              const SizedBox(height: 10),
              _SettingTile(
                label: 'Gold Signals',
                value: gold,
                onChanged: (v) => setState(() => gold = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _CardContainer(
          child: Text(
            'Update your password to keep your account secure',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _CardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Payment History', style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
              const SizedBox(height: 6),
              Text(
                'Choose which types of signal notifications you want to receive via email',
                style: AppTextStyles.caption.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Text('Search:', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFF111111),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white24),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Write Concerns Here...',
                        style: AppTextStyles.caption.copyWith(color: Colors.white38),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text('Filter by:', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12)),
                  const SizedBox(width: 8),
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF111111),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Row(
                      children: [
                        Text('All Time', style: AppTextStyles.caption.copyWith(color: Colors.white)),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_drop_down, color: Colors.white70),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 260,
          decoration: BoxDecoration(
            color: const Color(0xFF101010),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white24),
          ),
        ),
      ],
    );
  }
}

class _PlanTile extends StatelessWidget {
  final String title;
  const _PlanTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
              const Spacer(),
              _DeactivateButton(),
            ],
          ),
          const SizedBox(height: 6),
          Text('Start Date:', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 13)),
          Text('...', style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13)),
          const SizedBox(height: 4),
          Text('End Date:', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 13)),
          Text('...', style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13)),
        ],
      ),
    );
  }
}

class _DeactivateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        'Deactivate',
        style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
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

class _PlaceholderCard extends StatelessWidget {
  final String title;
  final String content;
  const _PlaceholderCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Text(content, style: AppTextStyles.caption.copyWith(color: Colors.white70)),
        ],
      ),
    );
  }
}

class _TokenBadge extends StatelessWidget {
  final String? uid;
  const _TokenBadge({this.uid});

  @override
  Widget build(BuildContext context) {
    final userTier = Provider.of<UserProvider?>(context, listen: false)?.userTier?.toLowerCase() ?? 'free';
    final isElite = userTier == 'elite';
    if (isElite) {
      return _badge(text: 'Unlimited', color: Colors.greenAccent);
    }
    if (uid == null) {
      return _badge(text: '10 left', color: Colors.greenAccent);
    }
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return _badge(text: '10 left', color: Colors.greenAccent);
        }
        final data = snapshot.data!.data() ?? {};
        final storedDate = (data['freeTokensDate'] ?? '') as String;
        final used = (data['freeTokensUsed'] ?? 0) as int;
        final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
        final effectiveUsed = storedDate == todayKey ? used : 0;
        final left = (10 - effectiveUsed).clamp(0, 10);
        return _badge(text: '$left left', color: left > 0 ? Colors.greenAccent : Colors.redAccent);
      },
    );
  }

  Widget _badge({required String text, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(text, style: AppTextStyles.body.copyWith(color: color, fontWeight: FontWeight.w700)),
    );
  }
}
