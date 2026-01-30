import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/features/auth/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/web/landing/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/web/widgets/landing_background.dart';
import 'package:minvest_forex_app/web/theme/breakpoints.dart';

class SignupScreenWeb extends StatelessWidget {
  const SignupScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: isMobile ? const TextScaler.linear(0.6) : const TextScaler.linear(1.0),
      ),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          } else if (state.status == AuthStatus.unauthenticated && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: LandingNavBar(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 40, bottom: 40),
                        child: LandingBackgroundWrapper(
                          child: const _SignupForm(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Refactored to separate the stateful part from the layout to avoid issues
class _SignupForm extends StatefulWidget {
  const _SignupForm();

  @override
  State<_SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<_SignupForm> {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480), // Slightly wider
          child: RepaintBoundary(
            child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 32), 
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF595959), width: 1),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x7FB49CFF),
                  blurRadius: 12,
                  offset: const Offset(0, 0),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.signUpAccount, 
                  textAlign: TextAlign.center, 
                  style: const TextStyle(
                    fontSize: 28, 
                    fontWeight: FontWeight.w700, 
                    color: Colors.white,
                    fontFamily: 'Be Vietnam Pro',
                    letterSpacing: -1.0,
                  )
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.enterPersonalData, 
                  textAlign: TextAlign.center, 
                  style: const TextStyle(
                    color: Color(0xFF9A9A9A), 
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  )
                ),
                const SizedBox(height: 24),
                _SocialSignInButton(
                  icon: Image.asset('assets/images/google_logo.png', height: 24, width: 24),
                  text: AppLocalizations.of(context)!.continueByGoogle,
                  onPressed: () => context.read<AuthBloc>().add(SignInWithGoogleRequested()),
                ),
                const SizedBox(height: 12),
                _SocialSignInButton(
                  icon: Image.asset('assets/images/facebook_logo.png', height: 24, width: 24),
                  text: AppLocalizations.of(context)!.continueByFacebook,
                  onPressed: () => context.read<AuthBloc>().add(SignInWithFacebookRequested()),
                ),
                const SizedBox(height: 12),
                _SocialSignInButton(
                  icon: Image.asset('assets/images/apple_logo.png', height: 24, width: 24, color: Colors.white),
                  text: AppLocalizations.of(context)!.continueByApple,
                  onPressed: () => context.read<AuthBloc>().add(SignInWithAppleRequested()),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Spacer(),
                    Text(AppLocalizations.of(context)!.or, style: const TextStyle(color: Colors.white, fontSize: 14)),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                _TextField(label: AppLocalizations.of(context)!.nameLabel, hint: AppLocalizations.of(context)!.enterNameHint, controller: _nameController),
                const SizedBox(height: 12),
                _TextField(label: AppLocalizations.of(context)!.emailLabel, hint: AppLocalizations.of(context)!.emailHint, controller: _emailController),
                const SizedBox(height: 12),
                _TextField(label: AppLocalizations.of(context)!.passwordLabel, hint: AppLocalizations.of(context)!.enterPassword, controller: _passwordController, obscure: true),
                const SizedBox(height: 12),
                _PhoneField(
                  countryCode: _countryCode,
                  onChangedCode: (code) => setState(() => _countryCode = code),
                  controller: _phoneController,
                ),
                const SizedBox(height: 24),
                _PrimaryButton(
                  text: AppLocalizations.of(context)!.continueButton,
                  onPressed: _submit,
                  loading: _isVerifying,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.fillAllFields)),
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.accountCreatedSuccess)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.signUpFailed(e.toString()))),
        );
      }
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
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          side: const BorderSide(color: Color(0xFF424242), width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          elevation: 0,
        ),
        child: Row(
          children: [
            Container(
              width: 32, 
              alignment: Alignment.center,
              child: icon,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text, 
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),
                textAlign: TextAlign.left,
              ),
            ),
          ],
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
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
        const SizedBox(height: 6),
        SizedBox(
          height: 45,
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: const TextStyle(color: Colors.white, fontSize: 15),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF9A9A9A), fontSize: 14),
              filled: true,
              fillColor: const Color(0xFF111111),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFF424242), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFF289EFF)),
              ),
            ),
          ),
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
        Text(AppLocalizations.of(context)!.phoneLabel, style: const TextStyle(color: Colors.white, fontSize: 14)),
        const SizedBox(height: 6),
        Row(
          children: [
            Container(
              width: 90,
              height: 45,
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFF424242)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButton<String>(
                value: countryCode,
                isExpanded: true,
                underline: const SizedBox.shrink(),
                dropdownColor: Colors.black,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                iconEnabledColor: Colors.white,
                items: const [
                  DropdownMenuItem(value: 'VN(+84)', child: Text('VN(+84)')),
                  DropdownMenuItem(value: 'US(+1)', child: Text('US(+1)')),
                  DropdownMenuItem(value: 'ZH(+86)', child: Text('ZH(+86)')),
                  DropdownMenuItem(value: 'FR(+33)', child: Text('FR(+33)')),
                  DropdownMenuItem(value: 'JA(+81)', child: Text('JA(+81)')),
                  DropdownMenuItem(value: 'KO(+82)', child: Text('KO(+82)')),
                ],
                onChanged: (value) {
                  if (value != null) onChangedCode(value);
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 45,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  decoration: InputDecoration(
                    hintText: '+123 567 890',
                    hintStyle: const TextStyle(color: Color(0xFF9A9A9A), fontSize: 14),
                    filled: true,
                    fillColor: const Color(0xFF111111),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFF424242), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFF289EFF)),
                    ),
                  ),
                ),
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
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF289EFF),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 0,
        ),
        child: loading
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
      ),
    );
  }
}