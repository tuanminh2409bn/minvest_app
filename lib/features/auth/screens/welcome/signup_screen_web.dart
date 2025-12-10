import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/features/auth/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/web/landing/widgets/navbar.dart';
import 'package:minvest_forex_app/web/landing/sections/footer_section.dart';
import 'package:provider/provider.dart';

class SignupScreenWeb extends StatefulWidget {
  const SignupScreenWeb({super.key});

  @override
  State<SignupScreenWeb> createState() => _SignupScreenWebState();
}

class _SignupScreenWebState extends State<SignupScreenWeb> {
  String _countryCode = 'VN(+84)';
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isVerifying = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double verticalGap = (constraints.maxHeight * 0.16).clamp(70.0, 130.0);
          final bool isNarrow = constraints.maxWidth < 900;
          final double effectiveGap = isNarrow ? 40 : verticalGap;
          final double formPadding = isNarrow ? 24 : verticalGap;
          final double stackHeight = (670 + (effectiveGap * 2)).clamp(720.0, 1050.0);
          final bool showCards = constraints.maxWidth > 900;
          final double topSpace = isNarrow ? 32 : 96;
          final double bottomSpace = isNarrow ? 32 : effectiveGap;

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
                  SizedBox(height: topSpace),
                  if (isNarrow)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _GlowWrapper(
                        child: _buildWebLayout(context, formPadding),
                      ),
                    )
                  else
                    SizedBox(
                      height: stackHeight,
                      child: Stack(
                        children: [
                          Positioned.fill(child: Container(color: Colors.black)),
                          _AuthBackdrop(showCards: showCards),
                          Positioned.fill(child: _buildWebLayout(context, formPadding)),
                        ],
                      ),
                    ),
                  SizedBox(height: bottomSpace),
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
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/');
      });
    }

    final double vPad = verticalPadding.clamp(120.0, 200.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: vPad),
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
                const Text('Sign Up Account', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Colors.white)),
                const SizedBox(height: 6),
                const Text('Enter your personal data to create your account', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
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
                _TextField(label: 'Name *', hint: 'Enter Name', controller: _nameController),
                const SizedBox(height: 12),
                _TextField(label: 'Email *', hint: 'example123@gmail.com', controller: _emailController),
                const SizedBox(height: 12),
                _TextField(label: 'Password *', hint: 'Enter Password', controller: _passwordController, obscure: true),
                const SizedBox(height: 12),
                _PhoneField(
                  countryCode: _countryCode,
                  onChangedCode: (code) => setState(() => _countryCode = code),
                  controller: _phoneController,
                ),
                const SizedBox(height: 16),
                _PrimaryButton(
                  text: 'Continue',
                  onPressed: _submit,
                  loading: _isVerifying,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields.')),
      );
      return;
    }

    setState(() => _isVerifying = true);
    try {
      final authService = context.read<AuthService>();
      await authService.signUpWithEmailPassword(
        email: email,
        password: password,
        displayName: name,
        phoneNumber: phone.isEmpty ? null : phone,
        countryCode: _countryCode,
      );
      // Auth state changes will navigate via AuthGate; show success
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign up failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _isVerifying = false);
    }
  }
}

class _SocialSignInButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onPressed;

  const _SocialSignInButton({required this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: const BorderSide(color: Colors.white12),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon,
              const SizedBox(width: 24),
              Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscure;
  final TextEditingController? controller;

  const _TextField({required this.label, required this.hint, this.controller, this.obscure = false});

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

class _PhoneField extends StatelessWidget {
  final String countryCode;
  final ValueChanged<String> onChangedCode;
  final TextEditingController controller;
  const _PhoneField({
    required this.countryCode,
    required this.onChangedCode,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Phone', style: TextStyle(color: Colors.white70, fontSize: 13)),
        const SizedBox(height: 6),
        Row(
          children: [
            Container(
              width: 100,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF0F0F0F),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<String>(
                value: countryCode,
                isExpanded: true,
                underline: const SizedBox.shrink(),
                dropdownColor: Colors.black,
                style: const TextStyle(color: Colors.white),
                iconEnabledColor: Colors.white,
                items: const [
                  DropdownMenuItem(value: 'VN(+84)', child: Text('VN(+84)')),
                  DropdownMenuItem(value: 'US(+1)', child: Text('US(+1)')),
                  DropdownMenuItem(value: 'SG(+65)', child: Text('SG(+65)')),
                ],
                onChanged: (value) {
                  if (value != null) onChangedCode(value);
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
            controller: controller,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: '+123 567 890',
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
            ),
          ],
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool loading;
  const _PrimaryButton({required this.text, required this.onPressed, this.loading = false});

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

class _AuthBackdrop extends StatelessWidget {
  final bool showCards;
  const _AuthBackdrop({required this.showCards});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 640,
        height: 450,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            const _SigninGlow(),
            if (showCards) const _SigninCards(),
          ],
        ),
      ),
    );
  }
}

class _GlowWrapper extends StatelessWidget {
  final Widget child;
  const _GlowWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.6,
            child: Image.asset(
              'assets/mockups/light.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
        child,
      ],
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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -180,
            top: 120,
            child: _SigninCardColumn(
              cards: cards.sublist(0, 3),
              offsets: const [-60, 0, 40],
              hoverDirectionUp: true,
            ),
          ),
          Positioned(
            right: -180,
            top: 70,
            child: _SigninCardColumn(
              cards: cards.sublist(3, 6),
              offsets: const [-40, 10, 50],
              hoverDirectionUp: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _SigninCardColumn extends StatelessWidget {
  final List<_SigninCardData> cards;
  final List<double> offsets;
  final bool hoverDirectionUp;
  const _SigninCardColumn({required this.cards, required this.offsets, required this.hoverDirectionUp});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(cards.length, (index) {
        final card = cards[index];
        final offsetY = offsets[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _HoverCard(
            image: card.image,
            rotation: card.rotation,
            baseOffsetY: offsetY,
            hoverDirectionUp: hoverDirectionUp,
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

class _HoverCard extends StatefulWidget {
  final String image;
  final double rotation;
  final double baseOffsetY;
  final bool hoverDirectionUp;
  const _HoverCard({
    required this.image,
    required this.rotation,
    required this.baseOffsetY,
    required this.hoverDirectionUp,
  });

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    final double hoverOffset = _isHover ? (widget.hoverDirectionUp ? -10 : 10) : 0;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHover = true),
      onExit: (_) => setState(() => _isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..translate(0.0, widget.baseOffsetY + hoverOffset),
        child: Transform.rotate(
          angle: widget.rotation * 3.1416 / 180,
          child: Image.asset(widget.image, width: 280, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
