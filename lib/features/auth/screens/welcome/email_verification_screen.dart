import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/features/auth/services/auth_service.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  final String password;
  final String displayName;

  const EmailVerificationScreen({
    super.key,
    required this.email,
    required this.password,
    required this.displayName,
  });

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  Future<void> _verifyCode() async {
    String code = _otpController.text;
    if (code.length < 6) {
      setState(() => _errorMessage = 'Please enter all 6 digits');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final authService = context.read<AuthService>();
      final isValid = await authService.verifySignupCode(widget.email, code);

      if (isValid) {
        if (mounted) {
          context.read<AuthBloc>().add(
            SignUpWithEmailRequested(
              email: widget.email,
              password: widget.password,
              displayName: widget.displayName,
            ),
          );
        }
      } else {
        setState(() {
          _errorMessage = 'Invalid or expired verification code';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
        _isLoading = false;
      });
    }
  }

  Future<void> _resendCode() async {
    setState(() => _isLoading = true);
    try {
      await context.read<AuthService>().requestSignupVerificationCode(widget.email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification code resent!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to resend code: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (state.status == AuthStatus.unauthenticated && state.errorMessage != null) {
            setState(() {
              _errorMessage = state.errorMessage!;
              _isLoading = false;
            });
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                const SizedBox(height: 40),
                const Text(
                  'Verify Your Email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Please enter the 6 digit code\nsent to your email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF9A9A9A),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 40),
                
                // 6-Digit Code Input
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) => _buildCodeBox(index)),
                    ),
                    Positioned.fill(
                      child: TextField(
                        controller: _otpController,
                        focusNode: _otpFocusNode,
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(6)],
                        autocorrect: false,
                        enableSuggestions: false,
                        showCursor: false,
                        cursorColor: Colors.transparent,
                        style: const TextStyle(color: Colors.transparent, fontSize: 20),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.transparent,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (value) {
                          setState(() {});
                          if (value.length == 6) {
                            _otpFocusNode.unfocus();
                            _verifyCode();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.redAccent, fontSize: 14),
                    ),
                  ),
                
                const SizedBox(height: 30),
                
                GestureDetector(
                  onTap: _isLoading ? null : _resendCode,
                  child: const Text(
                    'Resend code',
                    style: TextStyle(
                      color: Color(0xFF9A9A9A),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Verify Button
                GestureDetector(
                  onTap: _isLoading ? null : _verifyCode,
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
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text(
                            'Verify',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Be Vietnam Pro',
                            ),
                          ),
                  ),
                ),
                
                const SizedBox(height: 60),
                
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
                    _SocialCircleSmallButton(
                      iconPath: 'assets/images/facebook_logo.png',
                      color: Colors.transparent,
                      size: 62,
                      padding: 0,
                      onPressed: () => context.read<AuthBloc>().add(SignInWithFacebookRequested()),
                    ),
                    const SizedBox(width: 30),
                    if (Platform.isIOS) ...[
                      _SocialCircleSmallButton(
                        iconPath: 'assets/images/apple_logo.png',
                        color: Colors.transparent,
                        size: 45,
                        padding: 5,
                        iconColor: Colors.white,
                        onPressed: () => context.read<AuthBloc>().add(SignInWithAppleRequested()),
                      ),
                      const SizedBox(width: 30),
                    ],
                    _SocialCircleSmallButton(
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
    );
  }

  Widget _buildCodeBox(int index) {
    String char = '';
    if (_otpController.text.length > index) {
      char = _otpController.text[index];
    }
    
    bool isFocused = _otpController.text.length == index || (_otpController.text.length == 6 && index == 5);
    if (!_otpFocusNode.hasFocus) isFocused = false;

    return Container(
      key: ValueKey('code_box_container_$index'),
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isFocused ? const Color(0xFF289EFF) : const Color(0xFF7B7B7B),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          char,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _SocialCircleSmallButton extends StatelessWidget {
  final String iconPath;
  final Color color;
  final VoidCallback onPressed;
  final double padding;
  final double size;
  final Color? iconColor;

  const _SocialCircleSmallButton({
    required this.iconPath,
    required this.color,
    required this.onPressed,
    this.padding = 10,
    this.size = 45,
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
