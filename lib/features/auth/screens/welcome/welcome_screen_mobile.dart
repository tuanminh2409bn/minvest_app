import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/features/auth/screens/welcome/login_screen_mobile.dart';
import 'package:minvest_forex_app/features/auth/screens/welcome/signup_screen_mobile.dart';
// Removed unused import

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            if (context.mounted) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          } else if (state.status == AuthStatus.unauthenticated && state.errorMessage != null) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!), backgroundColor: Colors.red),
              );
            }
          }
        },
        child: Stack(
          children: [
          // Status bar placeholder (44px from Figma)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 44,
            child: Container(), // Empty for now, handled by SafeArea
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  
                  // Title
                  const Text(
                    'Let’s Get You In!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Social Login Buttons
                  _SocialButton(
                    iconPath: 'assets/images/facebook_logo.png',
                    text: 'Continue With Facebook',
                    color: const Color(0xFF1877F2),
                    onPressed: () => context.read<AuthBloc>().add(SignInWithFacebookRequested()),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _SocialButton(
                    iconPath: 'assets/images/google_logo.png',
                    text: 'Continue With Google',
                    color: Colors.white,
                    textColor: Colors.white, // Đã đổi từ black sang white
                    onPressed: () => context.read<AuthBloc>().add(SignInWithGoogleRequested()),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  if (Platform.isIOS)
                    _SocialButton(
                      iconPath: 'assets/images/apple_logo.png',
                      text: 'Continue With Apple',
                      color: const Color(0xFF121212),
                      onPressed: () => context.read<AuthBloc>().add(SignInWithAppleRequested()),
                    ),
                  
                  const Spacer(),
                  
                  // "or" text
                  const Text(
                    'or',
                    style: TextStyle(
                      color: Color(0xFF636363),
                      fontSize: 18,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Sign In Button
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const LoginScreenMobile()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFF0CA3ED), Color(0xFF276EFB)],
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Create Account Link
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        'Don’t have an account? ',
                        style: TextStyle(
                          color: Color(0xFF636363),
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const SignupScreenMobile()),
                          );
                        },
                        child: const Text(
                          'Create Account',
                          style: TextStyle(
                            color: Color(0xFF0094FF),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String iconPath;
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.iconPath,
    required this.text,
    required this.color,
    this.textColor = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1), // Figma shows translucent backgrounds
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1,
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.white.withValues(alpha: 0.1),
              Colors.white.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Image.asset(iconPath, width: 28, height: 28), // Tăng kích thước từ 20 lên 28
              ),
            ),
            Center(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
