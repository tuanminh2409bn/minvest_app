import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/gradients.dart';
import '../theme/spacing.dart';
import 'widgets/navbar.dart';
import 'sections/footer_section.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  const LandingNavBar(),
                  const SizedBox(height: 32),
                  _header(),
                  const SizedBox(height: 24),
                  _contactCards(),
                  const SizedBox(height: 24),
                  _contactForm(),
                  const SizedBox(height: 64),
                  const FooterSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        Text(
          'Get in Touch with Us',
          style: AppTextStyles.h1.copyWith(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Have questions or need AI solutions? Let us know by filling out the form, and we\'ll be in touch!',
          style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _contactCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(
          width: 420,
          child: _InfoCard(
            title: 'Whatsapp',
            subtitle: '0969 15 6969',
            icon: Icons.chat_bubble_outline,
          ),
        ),
        SizedBox(width: 16),
        SizedBox(
          width: 420,
          child: _InfoCard(
            title: 'Phone',
            subtitle: '0969 15 6969',
            icon: Icons.phone_in_talk_outlined,
          ),
        ),
      ],
    );
  }

  Widget _contactForm() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 860),
        child: Container(
          padding: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: AppGradients.cta,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(9),
            ),
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: _textField(label: 'First Name', hint: 'Enter First Name')),
                    const SizedBox(width: 16),
                    Expanded(child: _textField(label: 'Last Name', hint: 'Enter Last Name')),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(child: _textField(label: 'Email', hint: 'example123@gmail.com')),
                    const SizedBox(width: 16),
                    Expanded(child: _textField(label: 'Phone', hint: '+1 234 567 890')),
                  ],
                ),
                const SizedBox(height: 18),
                _textArea(label: 'What Are Your Concerns?', hint: 'Write Concerns Here...'),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      textStyle: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {},
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
        ),
        const SizedBox(height: 6),
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFF0F0F0F),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.centerLeft,
          child: Text(
            hint,
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _textArea({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
        ),
        const SizedBox(height: 6),
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: const Color(0xFF0F0F0F),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          alignment: Alignment.topLeft,
          child: Text(
            hint,
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 13),
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const _InfoCard({required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        gradient: AppGradients.cta,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          gradient: const LinearGradient(
            colors: [Color(0xFF111325), Color(0xFF070812)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
