import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/features/auth/services/auth_service.dart';
import 'package:minvest_forex_app/features/auth/screens/welcome/email_verification_screen.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/core/services/affiliate_tracker.dart';
import 'package:minvest_forex_app/core/services/affiliate_tracker_stub.dart';

class SignupScreenMobile extends StatefulWidget {
  const SignupScreenMobile({super.key});

  @override
  State<SignupScreenMobile> createState() => _SignupScreenMobileState();
}

class _SignupScreenMobileState extends State<SignupScreenMobile> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _referralController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLocalLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  void _showAccountExistsDialog(String email) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161616),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.white10),
        ),
        title: const Text('Tài khoản đã tồn tại', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text(
          'Email $email đã được đăng ký trong hệ thống. Vui lòng đăng nhập hoặc sử dụng tính năng quên mật khẩu.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng', style: TextStyle(color: Color(0xFF276EFB))),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLocalLoading = true);

    try {
      final email = _emailController.text.trim();
      final referralCode = _referralController.text.trim();

      // Nếu có mã giới thiệu, lưu vào AffiliateTracker trước khi đăng ký
      if (referralCode.isNotEmpty) {
        await AffiliateTracker().saveRef(referralCode);
      }

      debugPrint('Attempting to send code to: $email');
      
      // Gọi Cloud Function gửi mã
      await context.read<AuthService>().requestSignupVerificationCode(email);
      
      debugPrint('Code sent successfully, navigating...');
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EmailVerificationScreen(
              email: email,
              password: _passwordController.text,
              displayName: email.split('@')[0],
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error sending code: $e');
      if (mounted) {
        final errorString = e.toString().toLowerCase();
        if (errorString.contains('already-exists') || errorString.contains('đã được đăng ký')) {
          _showAccountExistsDialog(_emailController.text.trim());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Lỗi hệ thống: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } finally {
      if (mounted) setState(() => _isLocalLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            if (mounted) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          } else if (state.status == AuthStatus.unauthenticated && state.errorMessage != null) {
            if (mounted) {
              final error = state.errorMessage!.toLowerCase();
              if (error.contains('already-exists') || error.contains('email-already-in-use')) {
                _showAccountExistsDialog('này');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!), backgroundColor: Colors.red),
                );
              }
            }
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Create your account',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Email Field
                  _buildGlassTextField(
                    key: const ValueKey('signup_email_field'),
                    controller: _emailController,
                    hintText: 'Email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter your email';
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Password Field
                  _buildGlassTextField(
                    key: const ValueKey('signup_password_field'),
                    controller: _passwordController,
                    hintText: 'Password',
                    icon: Icons.lock_outline,
                    obscureText: _obscurePassword,
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                      child: Icon(
                        _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: const Color(0xFF636363),
                        size: 20,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter your password';
                      if (value.length < 6) return 'Password must be at least 6 characters';
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Confirm Password Field
                  _buildGlassTextField(
                    key: const ValueKey('signup_confirm_password_field'),
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    icon: Icons.lock_outline,
                    obscureText: _obscureConfirmPassword,
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                      child: Icon(
                        _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: const Color(0xFF636363),
                        size: 20,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please confirm your password';
                      if (value != _passwordController.text) return 'Passwords do not match';
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Referral Code Field (Optional)
                  _buildGlassTextField(
                    key: const ValueKey('signup_referral_field'),
                    controller: _referralController,
                    hintText: 'Referral Code (Optional)',
                    icon: Icons.card_giftcard_outlined,
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Create Account Button
                  GestureDetector(
                    onTap: _isLocalLoading ? null : _handleSignup,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFF0CA3ED), Color(0xFF276EFB)],
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: _isLocalLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Text(
                              'Create Account',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Be Vietnam Pro',
                              ),
                            ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.white.withOpacity(0.3), thickness: 1)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'or',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF636363),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.white.withOpacity(0.3), thickness: 1)),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  const Text(
                    'Sign in with',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF636363),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Social Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SocialCircleButton(
                        iconPath: 'assets/images/facebook_logo.png',
                        color: Colors.transparent, 
                        size: 62, 
                        padding: 0, 
                        onPressed: () => context.read<AuthBloc>().add(SignInWithFacebookRequested()),
                      ),
                      const SizedBox(width: 30),
                      if (Platform.isIOS) ...[
                        _SocialCircleButton(
                          iconPath: 'assets/images/apple_logo.png',
                          color: Colors.transparent, 
                          size: 45, 
                          padding: 5, 
                          iconColor: Colors.white, 
                          onPressed: () => context.read<AuthBloc>().add(SignInWithAppleRequested()),
                        ),
                        const SizedBox(width: 30),
                      ],
                      _SocialCircleButton(
                        iconPath: 'assets/images/google_logo.png',
                        color: Colors.white,
                        size: 45, 
                        padding: 5, 
                        onPressed: () => context.read<AuthBloc>().add(SignInWithGoogleRequested()),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    Key? key,
  }) {
    return Container(
      key: key,
      width: double.infinity,
      padding: const EdgeInsets.all(1), // Độ dày viền
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: LinearGradient(
          begin: const Alignment(-1.0, -2.0),
          end: const Alignment(1.0, 2.0),
          colors: [
            Colors.white.withOpacity(0.6),
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(0.8),
          ],
          stops: const [0.0, 0.07, 0.88, 1.0],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextFormField(
          key: key != null ? ValueKey('${key.toString()}_input') : null,
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Be Vietnam Pro',
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF636363),
              fontSize: 18,
              fontFamily: 'Be Vietnam Pro',
            ),
            prefixIcon: Icon(icon, color: const Color(0xFF636363), size: 20),
            suffixIcon: suffixIcon,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}

class _SocialCircleButton extends StatelessWidget {
  final String iconPath;
  final Color color;
  final VoidCallback onPressed;
  final double padding;
  final double size;
  final Color? iconColor;

  const _SocialCircleButton({
    required this.iconPath,
    required this.color,
    required this.onPressed,
    this.padding = 12,
    this.size = 56,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: (color == Colors.transparent || color == Colors.black)
            ? null 
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
        ),
        padding: EdgeInsets.all(padding),
        child: Image.asset(
          iconPath, 
          fit: BoxFit.contain,
          color: iconColor,
        ),
      ),
    );
  }
}


