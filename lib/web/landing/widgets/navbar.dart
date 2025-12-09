import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/content.dart';
import '../../theme/text_styles.dart';
import '../../theme/gradients.dart';
import '../../theme/spacing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/app/main_screen_web.dart';

class LandingNavBar extends StatelessWidget {
  const LandingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pushNamed('/'),
            child: Image.asset('assets/mockups/logo.png', height: 42, fit: BoxFit.contain),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final navSpacing = constraints.maxWidth < 900 ? 12.0 : 20.0;
                final fontSize = constraints.maxWidth < 900 ? 16.0 : 18.0;
                return Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const SizedBox(width: 50),
                              ...LandingContent.navItems.map(
                                (item) => Padding(
                                  padding: EdgeInsets.symmetric(horizontal: navSpacing / 2),
                                  child: InkWell(
                                    onTap: () {
                                      if (item == 'Features') {
                                        Navigator.of(context).pushNamed('/features');
                                      } else if (item == 'AI Signals') {
                                        Navigator.of(context).pushNamed('/ai-signals');
                                      } else if (item == 'Pricing') {
                                        Navigator.of(context).pushNamed('/pricing');
                                      } else if (item == 'News') {
                                        Navigator.of(context).pushNamed('/news');
                                      } else if (item == 'Contact Us') {
                                        Navigator.of(context).pushNamed('/contact-us');
                                      }
                                    },
                                    child: Text(
                                      item,
                                      style: AppTextStyles.h3.copyWith(
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (user == null) ...[
                          _ctaButton('Get Signals now'),
                          const SizedBox(width: AppSpacing.sm),
                          _outlineButton(
                            'Sign in',
                            onTap: () => Navigator.of(context).pushNamed('/signin'),
                          ),
                        ] else ...[
                          _userNameChip(
                            user,
                            onTap: () => Navigator.of(context).pushNamed('/profile'),
                          ),
                        ],
                        const SizedBox(width: AppSpacing.sm),
                        Container(
                          width: 44,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset('assets/images/us_flag.png', fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _ctaButton(String text) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () => Navigator.of(context).pushNamed('/signup'),
        child: Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [Color(0xFF00BFFF), Color(0xFFD500F9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(color: Colors.black54, blurRadius: 12, offset: Offset(0, 6)),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.transparent,
            ),
            child: Text(
              text,
              style: AppTextStyles.h3.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _outlineButton(String text, {VoidCallback? onTap}) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: AppGradients.cta,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black,
            ),
            child: Text(
              text,
              style: AppTextStyles.h3.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userAvatar(User user, {VoidCallback? onTap}) {
    final photoUrl = user.photoURL;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
          image: photoUrl != null
              ? DecorationImage(image: NetworkImage(photoUrl), fit: BoxFit.cover)
              : null,
          color: photoUrl == null ? Colors.white24 : null,
        ),
        child: photoUrl == null
            ? const Icon(Icons.person, color: Colors.white, size: 18)
            : null,
      ),
    );
  }

  Widget _userNameChip(User user, {VoidCallback? onTap}) {
    final name = (user.displayName ?? user.email ?? 'User').trim();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
          color: Colors.white.withOpacity(0.06),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _userAvatar(user, onTap: onTap),
            const SizedBox(width: 8),
            Text(
              name,
              style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
