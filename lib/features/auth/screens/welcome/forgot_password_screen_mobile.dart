import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/features/auth/services/auth_service.dart';

enum ForgotPasswordStep { email, verifyAndReset }

class ForgotPasswordScreenMobile extends StatefulWidget {
  const ForgotPasswordScreenMobile({super.key});

  @override
  State<ForgotPasswordScreenMobile> createState() => _ForgotPasswordScreenMobileState();
}

class _ForgotPasswordScreenMobileState extends State<ForgotPasswordScreenMobile> {
  ForgotPasswordStep _currentStep = ForgotPasswordStep.email;
  String _email = '';
  bool _isLoading = false;

  void _onCodeSent(String email) {
    setState(() {
      _email = email;
      _currentStep = ForgotPasswordStep.verifyAndReset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header based on Figma
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        if (_currentStep == ForgotPasswordStep.verifyAndReset) {
                          setState(() => _currentStep = ForgotPasswordStep.email);
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
                    ),
                  ),
                  Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _currentStep == ForgotPasswordStep.email ? 30 : 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: _currentStep == ForgotPasswordStep.email 
                ? _EmailStep(onCodeSent: _onCodeSent)
                : _VerifyAndResetStep(email: _email),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Bước 1: Nhập Email ---
class _EmailStep extends StatefulWidget {
  final Function(String) onCodeSent;
  const _EmailStep({required this.onCodeSent});

  @override
  State<_EmailStep> createState() => _EmailStepState();
}

class _EmailStepState extends State<_EmailStep> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            '''Please input the email address you used to sign up your account

We will send a verification code to your email address.''',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF636363),
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 60),
          
          _buildGlassTextField(
            controller: _emailController,
            hintText: 'Email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          
          const SizedBox(height: 60),
          
          GestureDetector(
            onTap: _sendCode,
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
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : const Text(
                    'send',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Be Vietnam Pro'),
                  ),
            ),
          ),
          
          const SizedBox(height: 180),
          
          const Text(
            'If you are unable to receive the email, please contact us email @gmail.com',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF636363), fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }

  Future<void> _sendCode() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;
    
    setState(() => _isLoading = true);
    try {
      await context.read<AuthService>().requestPasswordResetCode(email);
      widget.onCodeSent(email);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(1), // Độ dày viền
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: LinearGradient(
          begin: const Alignment(-1.0, -2.0),
          end: const Alignment(1.0, 2.0),
          colors: [
            Colors.white.withValues(alpha: 0.6),
            Colors.white.withValues(alpha: 0),
            Colors.white.withValues(alpha: 0),
            Colors.white.withValues(alpha: 0.8),
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
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Be Vietnam Pro'),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF636363), fontSize: 18, fontFamily: 'Be Vietnam Pro'),
            prefixIcon: Icon(icon, color: const Color(0xFF636363), size: 20),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}

// --- Bước 2: Xác thực & Đặt lại mật khẩu ---
class _VerifyAndResetStep extends StatefulWidget {
  final String email;
  const _VerifyAndResetStep({required this.email});

  @override
  State<_VerifyAndResetStep> createState() => _VerifyAndResetStepState();
}

class _VerifyAndResetStepState extends State<_VerifyAndResetStep> {
  final List<TextEditingController> _codeControllers = List.generate(6, (_) => TextEditingController());
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Circle Icon Placeholder from Figma
          Container(
            width: 57,
            height: 57,
            decoration: const BoxDecoration(
              color: Color(0xFF11172E),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.mark_email_read_outlined, color: Color(0xFF0CA3ED), size: 30),
          ),
          const SizedBox(height: 24),
          const Text(
            'We’ve sent a verification code to',
            style: TextStyle(color: Color(0xFF9A9A9A), fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            widget.email,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          
          // 6-digit code input
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) => _buildCodeBox(index)),
          ),
          
          const SizedBox(height: 40),
          
          _buildGlassTextField(
            controller: _newPasswordController,
            hintText: 'New Password',
            icon: Icons.lock_outline,
            obscureText: _obscureNew,
            suffixIcon: GestureDetector(
              onTap: () => setState(() => _obscureNew = !_obscureNew),
              child: Icon(_obscureNew ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: const Color(0xFF636363), size: 20),
            ),
          ),
          
          const SizedBox(height: 16),
          
          _buildGlassTextField(
            controller: _confirmPasswordController,
            hintText: 'Confirm New Password',
            icon: Icons.lock_outline,
            obscureText: _obscureConfirm,
            suffixIcon: GestureDetector(
              onTap: () => setState(() => _obscureConfirm = !_obscureConfirm),
              child: Icon(_obscureConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: const Color(0xFF636363), size: 20),
            ),
          ),
          
          const SizedBox(height: 40),
          
          GestureDetector(
            onTap: _resetPassword,
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
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : const Text(
                    'Reset Password',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Be Vietnam Pro'),
                  ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildCodeBox(int index) {
    return Container(
      width: 45,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: TextField(
        controller: _codeControllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(counterText: '', border: InputBorder.none),
        onChanged: (value) {
          if (value.length == 1 && index < 5) FocusScope.of(context).nextFocus();
          if (value.isEmpty && index > 0) FocusScope.of(context).previousFocus();
        },
      ),
    );
  }

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(1), // Độ dày viền
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: LinearGradient(
          begin: const Alignment(-1.0, -2.0),
          end: const Alignment(1.0, 2.0),
          colors: [
            Colors.white.withValues(alpha: 0.6),
            Colors.white.withValues(alpha: 0),
            Colors.white.withValues(alpha: 0),
            Colors.white.withValues(alpha: 0.8),
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
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Be Vietnam Pro'),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF636363), fontSize: 18, fontFamily: 'Be Vietnam Pro'),
            prefixIcon: Icon(icon, color: const Color(0xFF636363), size: 20),
            suffixIcon: suffixIcon,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  Future<void> _resetPassword() async {
    final code = _codeControllers.map((c) => c.text).join();
    final newPass = _newPasswordController.text;
    final confirmPass = _confirmPasswordController.text;
    
    if (code.length < 6) return;
    if (newPass.isEmpty || newPass != confirmPass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match'), backgroundColor: Colors.red),
      );
      return;
    }
    
    setState(() => _isLoading = true);
    try {
      await context.read<AuthService>().resetPasswordWithCode(
        email: widget.email,
        code: code,
        newPassword: newPass,
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset successful!'), backgroundColor: Colors.green),
        );
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
