import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';

class SignupScreenMobile extends StatefulWidget {
  const SignupScreenMobile({super.key});

  @override
  State<SignupScreenMobile> createState() => _SignupScreenMobileState();
}

class _SignupScreenMobileState extends State<SignupScreenMobile> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!), backgroundColor: Colors.red),
              );
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
                  const SizedBox(height: 60),
                  const Text(
                    'Create your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Email Field
                  _buildGlassTextField(
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
                  
                  const SizedBox(height: 50),
                  
                  // Create Account Button
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state.status == AuthStatus.loading;
                      
                      return GestureDetector(
                        onTap: isLoading ? null : () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              SignUpWithEmailRequested(
                                email: _emailController.text,
                                password: _passwordController.text,
                                displayName: _emailController.text.split('@')[0],
                              ),
                            );
                          }
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
                          child: isLoading
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
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 100), // Đẩy khối dịch xuống dưới thêm
                  
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
                  
                  const SizedBox(height: 30),
                  
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
                        color: Colors.transparent, // Không bọc ngoài hình tròn màu xanh
                        size: 62, // Tăng kích thước từ 56 lên 62
                        padding: 0, // Để logo to bằng kích thước các logo khác
                        onPressed: () => context.read<AuthBloc>().add(SignInWithFacebookRequested()),
                      ),
                      const SizedBox(width: 30),
                      if (Platform.isIOS) ...[
                        _SocialCircleButton(
                          iconPath: 'assets/images/apple_logo.png',
                          color: Colors.transparent, // Bỏ vòng tròn bên ngoài
                          size: 45, // Vòng tròn 45px
                          padding: 5, // Padding 5px
                          iconColor: Colors.white, // Logo màu trắng
                          onPressed: () => context.read<AuthBloc>().add(SignInWithAppleRequested()),
                        ),
                        const SizedBox(width: 30),
                      ],
                      _SocialCircleButton(
                        iconPath: 'assets/images/google_logo.png',
                        color: Colors.white,
                        size: 45, // Vòng tròn 45px
                        padding: 5, // Padding 5px
                        onPressed: () => context.read<AuthBloc>().add(SignInWithGoogleRequested()),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 40), // Giảm 20px từ 60 xuống 40
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
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(color: Colors.white, fontSize: 18),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFF636363), fontSize: 18),
          prefixIcon: Icon(icon, color: const Color(0xFF636363), size: 20),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
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

                  color: Colors.black.withOpacity(0.2),

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


