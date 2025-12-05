// lib/features/auth/screens/welcome/welcome_screen_web.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/core/providers/language_provider.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/features/auth/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/web/landing/widgets/navbar.dart';
import 'package:minvest_forex_app/web/theme/text_styles.dart';
import 'package:minvest_forex_app/web/landing/sections/footer_section.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSigningIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleEmailSignIn(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập email và mật khẩu')),
      );
      return;
    }

    setState(() => _isSigningIn = true);
    try {
      final authService = context.read<AuthService>();
      await authService.signInWithEmailPassword(email: email, password: password);
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => route.isFirst);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng nhập thất bại: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSigningIn = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double verticalGap = (constraints.maxHeight * 0.16).clamp(70.0, 130.0);
          final bool isWide = constraints.maxWidth > 800;
          final double stackHeight = (650 + (verticalGap * 2)).clamp(750.0, 1050.0);

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: const LandingNavBar(),
                    ),
                  ),
                  const SizedBox(height: 96),
                  if (isWide)
                    SizedBox(
                      height: stackHeight,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(color: Colors.black),
                          ),
                          const _SigninBackdrop(),
                          Positioned.fill(
                            child: _buildWebLayout(context, verticalGap),
                          ),
                        ],
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildMobileLayout(context, languageProvider),
                    ),
                  SizedBox(height: verticalGap),
                  const FooterSection(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context, double verticalPadding) {
    final l10n = AppLocalizations.of(context)!;
    // Redirect to home if already signed in
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).popUntil((route) => route.settings.name == '/');
        }
        Navigator.of(context).pushReplacementNamed('/');
      });
    }

    final double vPad = verticalPadding.clamp(120.0, 200.0);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: vPad, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFF07080E),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white10),
              boxShadow: const [
                BoxShadow(color: Colors.black54, blurRadius: 20, spreadRadius: 2),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Welcome Back', textAlign: TextAlign.center, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Colors.white)),
                const SizedBox(height: 6),
                const Text('Sign in to your account to continue', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 24),
                _SocialSignInButton(
                  icon: Image.asset('assets/images/google_logo.png', height: 20, width: 20),
                  text: 'Continue with Google',
                  onPressed: () => context.read<AuthBloc>().add(SignInWithGoogleRequested()),
                ),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.white12, thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('or', style: TextStyle(color: Colors.white70)),
                    ),
                    Expanded(child: Divider(color: Colors.white12, thickness: 1)),
                  ],
                ),
                const SizedBox(height: 12),
                _TextField(label: 'Email', hint: 'example123@gmail.com', controller: _emailController),
                const SizedBox(height: 12),
                _TextField(label: 'Password', hint: 'Enter Password', controller: _passwordController, obscure: true),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text('Forgot your password?', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ),
                const SizedBox(height: 16),
                _PrimaryButton(
                  text: 'Continue',
                  loading: _isSigningIn,
                  onPressed: _isSigningIn ? null : () => _handleEmailSignIn(context),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Create new account here! ', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed('/signup'),
                      child: const Text('Sign Up', style: TextStyle(color: Color(0xFF3FA9F5), fontWeight: FontWeight.w700, fontSize: 12)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, LanguageProvider languageProvider) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Align(
                alignment: Alignment.topRight,
                child: PopupMenuButton<Locale>(
                  onSelected: (Locale locale) => languageProvider.setLocale(locale),
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: Locale('en'), child: Text('English')),
                    const PopupMenuItem(value: Locale('vi'), child: Text('Tiếng Việt')),
                  ],
                  child: Consumer<LanguageProvider>(
                    builder: (context, provider, child) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image.asset(
                          provider.locale?.languageCode == 'vi'
                              ? 'assets/images/vn_flag.png'
                              : 'assets/images/us_flag.png',
                          height: 24, width: 36, fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(l10n.welcomeTo, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, color: Colors.white)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Image.asset('assets/images/minvest_logo.png', height: 150),
            ),
            Text(l10n.appSlogan, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.white, height: 1.5)),
            const SizedBox(height: 50),
            Text(l10n.signIn, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 24),
            _SocialSignInButton(
              icon: Image.asset('assets/images/google_logo.png', height: 24, width: 24),
              text: l10n.continueByGoogle,
              onPressed: () => context.read<AuthBloc>().add(SignInWithGoogleRequested()),
            ),
            const SizedBox(height: 16),
            _SocialSignInButton(
              icon: Image.asset('assets/images/facebook_logo.png', height: 24, width: 24),
              text: l10n.continueByFacebook,
              onPressed: () => context.read<AuthBloc>().add(SignInWithFacebookRequested()),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _SocialSignInButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onPressed;

  const _SocialSignInButton({
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0C0938), Color(0xFF141A4C), Color(0xFF1D2B62)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                icon,
                const SizedBox(width: 24),
                Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SigninBackdrop extends StatelessWidget {
  const _SigninBackdrop();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 640,
        height: 450,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: const [
            _SigninGlow(),
            _SigninCards(),
          ],
        ),
      ),
    );
  }
}

class _SigninGlow extends StatelessWidget {
  const _SigninGlow();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 1.5,
            heightFactor: 1.5,
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'assets/mockups/light.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SigninCards extends StatelessWidget {
  const _SigninCards();

  @override
  Widget build(BuildContext context) {
    const cards = [
      _SigninCardData(image: 'assets/mockups/card1.png', rotation: -2),
      _SigninCardData(image: 'assets/mockups/card2.png', rotation: 1),
      _SigninCardData(image: 'assets/mockups/card3.png', rotation: -3),
      _SigninCardData(image: 'assets/mockups/card4.png', rotation: -5),
      _SigninCardData(image: 'assets/mockups/card5.png', rotation: -10),
      _SigninCardData(image: 'assets/mockups/card6.png', rotation: -8),
    ];
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: -180,
              top: 120,
              child: _SigninCardColumn(cards: cards.sublist(0, 3), offsets: const [-60, 0, 40]),
            ),
            Positioned(
              right: -180,
              top: 70,
              child: _SigninCardColumn(cards: cards.sublist(3, 6), offsets: const [-40, 10, 50]),
            ),
          ],
        ),
      ),
    );
  }
}

class _SigninCardColumn extends StatelessWidget {
  final List<_SigninCardData> cards;
  final List<double> offsets;
  const _SigninCardColumn({required this.cards, required this.offsets});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(cards.length, (index) {
        final card = cards[index];
        final offsetY = offsets[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Transform.translate(
            offset: Offset(0, offsetY),
            child: Transform.rotate(
              angle: card.rotation * 3.1416 / 180,
              child: Image.asset(card.image, width: 280, fit: BoxFit.contain),
            ),
          ),
        );
      }),
    );
  }
}

class _SigninCardData {
  final String image;
  final double rotation;
  const _SigninCardData({required this.image, required this.rotation});
}

class _TextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscure;
  final TextEditingController? controller;

  const _TextField({
    required this.label,
    required this.hint,
    this.controller,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
            filled: true,
            fillColor: const Color(0xFF0F0F0F),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3FA9F5)),
            ),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  const _PrimaryButton({
    required this.text,
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2E97FF),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: loading
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
