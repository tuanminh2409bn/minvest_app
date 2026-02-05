import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/features/auth/services/auth_service.dart';
import 'package:minvest_forex_app/web/landing/widgets/navbar.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/web/widgets/landing_background.dart';
import 'package:minvest_forex_app/web/theme/breakpoints.dart';

import 'package:minvest_forex_app/features/auth/screens/welcome/forgot_password_screen_web.dart';

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
                        child: LandingBackgroundWrapper(
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

  void _showForgotPasswordDialog() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreenWeb()),
    );
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
                  AppLocalizations.of(context)!.welcomeBack, 
                  textAlign: TextAlign.center, 
                  style: const TextStyle(
                    fontSize: 28, // Reduced size
                    fontWeight: FontWeight.w700, 
                    color: Colors.white,
                    fontFamily: 'Be Vietnam Pro',
                    letterSpacing: -1.0,
                  )
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.signInToContinue, 
                  textAlign: TextAlign.center, 
                  style: const TextStyle(
                    color: Color(0xFF9A9A9A), 
                    fontSize: 14, // Reduced size
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.5,
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
                    Text(
                      AppLocalizations.of(context)!.or, 
                      style: const TextStyle(
                        color: Colors.white, 
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                _TextField(
                  label: AppLocalizations.of(context)!.email, 
                  hint: AppLocalizations.of(context)!.emailHint, 
                  controller: _emailController
                ),
                const SizedBox(height: 16),
                _TextField(
                  label: AppLocalizations.of(context)!.password, 
                  hint: AppLocalizations.of(context)!.enterPassword, 
                  controller: _passwordController, 
                  obscure: true
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft, 
                  child: GestureDetector(
                    onTap: _showForgotPasswordDialog,
                    child: Text(
                      AppLocalizations.of(context)!.forgotPassword, 
                      style: const TextStyle(
                        color: Colors.white, 
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _PrimaryButton(
                  text: AppLocalizations.of(context)!.continueButton, 
                  loading: _loading,
                  onPressed: _loading ? null : _signIn,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.createNewAccount + ' ', 
                        style: const TextStyle(
                          color: Colors.white, 
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed('/signup'),
                        child: Text(
                          AppLocalizations.of(context)!.signUp, 
                          style: const TextStyle(
                            color: Colors.white, 
                            fontWeight: FontWeight.w700, 
                            fontSize: 14,
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
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
      height: 50, // Reduced height
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
               width: 32, // Fixed width for icon container
               alignment: Alignment.center,
               child: icon,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text, 
                style: const TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.w400, 
                  fontSize: 15,
                ),
                textAlign: TextAlign.left, // Aligned left
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
        Text(
          label, 
          style: const TextStyle(
            color: Colors.white, 
            fontSize: 14, 
            fontWeight: FontWeight.w400,
          )
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 45, // Reduced height
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 15,
              fontFamily: 'Be Vietnam Pro',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF9A9A9A), 
                fontSize: 14,
                fontFamily: 'Be Vietnam Pro',
                fontWeight: FontWeight.w400,
              ),
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

class _PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  const _PrimaryButton({required this.text, required this.onPressed, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45, // Reduced height
      width: double.infinity,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF289EFF),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(color: Color(0xFF424242), width: 1),
          ),
          elevation: 0,
        ),
        child: loading
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Text(
                text, 
                style: const TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.w600, 
                  fontSize: 15,
                  fontFamily: 'Be Vietnam Pro',
                )
              ),
      ),
    );
  }
}