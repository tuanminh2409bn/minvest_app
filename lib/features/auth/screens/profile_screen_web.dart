import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        return _PlaceholderCard(title: 'Setting', content: 'Settings coming soon.');
      case 2:
        return _PlaceholderCard(title: 'Payment History', content: 'No payment history yet.');
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
          Text('Nationality:', style: AppTextStyles.caption.copyWith(color: Colors.white70)),
          const SizedBox(height: 20),
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
          height: 44,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _CardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Signals Plan', style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
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
              Text('AI Minvest', style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Text('10 left', style: AppTextStyles.body.copyWith(color: Colors.greenAccent, fontWeight: FontWeight.w700)),
                    ),
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

class _PlanTile extends StatelessWidget {
  final String title;
  const _PlanTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
              Text(title, style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
              const Spacer(),
              _DeactivateButton(),
            ],
          ),
          const SizedBox(height: 6),
          Text('Start Date:', style: AppTextStyles.caption.copyWith(color: Colors.white70)),
          Text('...', style: AppTextStyles.caption.copyWith(color: Colors.white)),
          const SizedBox(height: 4),
          Text('End Date:', style: AppTextStyles.caption.copyWith(color: Colors.white70)),
          Text('...', style: AppTextStyles.caption.copyWith(color: Colors.white)),
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
      padding: const EdgeInsets.all(16),
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
