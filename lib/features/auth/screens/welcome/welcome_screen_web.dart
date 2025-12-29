import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/features/auth/services/auth_service.dart';
import 'package:minvest_forex_app/web/landing/widgets/navbar.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/web/widgets/signals_background.dart';
import 'package:minvest_forex_app/web/theme/breakpoints.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    if (FirebaseAuth.instance.currentUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (r) => r.isFirst);
      });
    }

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
                          child: const LandingNavBar(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 40, bottom: 40),
                        child: SignalsBackground(
                          child: const _LoginForm(),
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

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.pleaseEnterEmailPassword)),
      );
      return;
    }
    setState(() => _loading = true);
    try {
      await context.read<AuthService>().signInWithEmailPassword(email: email, password: password);
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (r) => r.isFirst);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.loginFailed(e.toString()))),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                Text(AppLocalizations.of(context)!.welcomeBack, textAlign: TextAlign.center, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Colors.white)),
                const SizedBox(height: 6),
                Text(AppLocalizations.of(context)!.signInToContinue, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 22),
                _SocialSignInButton(
                  icon: Image.asset('assets/images/google_logo.png', height: 20, width: 20),
                  text: AppLocalizations.of(context)!.continueByGoogle,
                  onPressed: () => context.read<AuthBloc>().add(SignInWithGoogleRequested()),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Expanded(child: Divider(color: Colors.white12, thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(AppLocalizations.of(context)!.or, style: const TextStyle(color: Colors.white70)),
                    ),
                    const Expanded(child: Divider(color: Colors.white12, thickness: 1)),
                  ],
                ),
                const SizedBox(height: 12),
                _TextField(label: AppLocalizations.of(context)!.email, hint: AppLocalizations.of(context)!.emailHint, controller: _emailController),
                const SizedBox(height: 12),
                _TextField(label: AppLocalizations.of(context)!.password, hint: AppLocalizations.of(context)!.enterPassword, controller: _passwordController, obscure: true),
                const SizedBox(height: 10),
                Align(alignment: Alignment.centerLeft, child: Text(AppLocalizations.of(context)!.forgotPassword, style: const TextStyle(color: Colors.white70, fontSize: 12))),
                const SizedBox(height: 16),
                _PrimaryButton(
                  text: AppLocalizations.of(context)!.signIn,
                  loading: _loading,
                  onPressed: _loading ? null : _signIn,
                ),
                const SizedBox(height: 14),
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    children: [
                      Text(AppLocalizations.of(context)!.createNewAccount, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed('/signup'),
                        child: Text(AppLocalizations.of(context)!.signUp, style: const TextStyle(color: Color(0xFF3FA9F5), fontWeight: FontWeight.w700, fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: const BorderSide(color: Colors.white12),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 12),
              Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
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

class _PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
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