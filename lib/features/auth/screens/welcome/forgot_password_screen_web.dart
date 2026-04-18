import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minvest_forex_app/features/auth/services/auth_service.dart';
import 'package:minvest_forex_app/web/landing/widgets/navbar.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/web/widgets/landing_background.dart';
import 'package:minvest_forex_app/web/theme/breakpoints.dart';

enum ForgotPasswordStep { email, otp, newPassword, success }

class ForgotPasswordScreenWeb extends StatefulWidget {
  const ForgotPasswordScreenWeb({super.key});

  @override
  State<ForgotPasswordScreenWeb> createState() => _ForgotPasswordScreenWebState();
}

class _ForgotPasswordScreenWebState extends State<ForgotPasswordScreenWeb> {
  ForgotPasswordStep _currentStep = ForgotPasswordStep.email;
  String _email = '';
  String _code = '';

  void _goToStep(ForgotPasswordStep step, {String? email, String? code}) {
    setState(() {
      _currentStep = step;
      if (email != null) _email = email;
      if (code != null) _code = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: isMobile ? const TextScaler.linear(0.6) : const TextScaler.linear(1.0),
      ),
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
                        paddingTop: -20,
                        offsetAdjustment: 100,
                        child: _buildCurrentForm(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCurrentForm() {
    switch (_currentStep) {
      case ForgotPasswordStep.email:
        return _EmailStep(onCodeSent: (email) => _goToStep(ForgotPasswordStep.otp, email: email));
      case ForgotPasswordStep.otp:
        return _OtpStep(
          email: _email, 
          onVerified: (code) => _goToStep(ForgotPasswordStep.newPassword, code: code),
          onBack: () => _goToStep(ForgotPasswordStep.email),
        );
      case ForgotPasswordStep.newPassword:
        return _NewPasswordStep(
          email: _email,
          code: _code,
          onSuccess: () => _goToStep(ForgotPasswordStep.success),
        );
      case ForgotPasswordStep.success:
        return const _SuccessStep();
    }
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
    return _BaseFormContainer(
      title: 'Reset Password',
      subtitle: 'We’ll send you a code to reset your password',
      children: [
        const SizedBox(height: 40),
        _TextField(
          label: 'Enter Your Email',
          hint: AppLocalizations.of(context)!.emailHint,
          controller: _emailController,
        ),
        const SizedBox(height: 32),
        _PrimaryButton(
          text: 'Send Reset Code',
          loading: _isLoading,
          onPressed: () async {
            final email = _emailController.text.trim();
            if (email.isEmpty) return;
            setState(() => _isLoading = true);
            try {
              await context.read<AuthService>().requestPasswordResetCode(email);
              widget.onCodeSent(email);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${e.toString()}')),
              );
            } finally {
              if (mounted) setState(() => _isLoading = false);
            }
          },
        ),
        const SizedBox(height: 24),
        _FooterLink(
          text: 'Remember your password? ',
          linkText: 'Sign In',
          onTap: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

// --- Bước 2: Nhập OTP ---
class _OtpStep extends StatefulWidget {
  final String email;
  final Function(String) onVerified;
  final VoidCallback onBack;
  const _OtpStep({required this.email, required this.onVerified, required this.onBack});

  @override
  State<_OtpStep> createState() => _OtpStepState();
}

class _OtpStepState extends State<_OtpStep> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  bool _isLoading = false;

  Future<void> _verifyOtp() async {
    String code = _controllers.map((c) => c.text).join();
    if (code.length < 6) return;

    setState(() => _isLoading = true);
    try {
      final firestore = FirebaseFirestore.instance;
      final doc = await firestore.collection('password_reset_codes').doc(widget.email).get();
      
      if (doc.exists) {
        final data = doc.data()!;
        final expiresAt = (data['expiresAt'] as Timestamp).toDate();
        if (DateTime.now().isAfter(expiresAt)) {
          throw Exception('Mã xác nhận đã hết hạn.');
        }
        if (data['code'] == code) {
          widget.onVerified(code);
        } else {
          throw Exception('Mã xác nhận không chính xác.');
        }
      } else {
        throw Exception('Mã xác nhận không tồn tại.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _BaseFormContainer(
      title: 'Reset Password',
      subtitle: 'We’ll send you a code to reset your password',
      children: [
        const SizedBox(height: 40),
        Text(
          'Enter the 6-digit code sent to ${widget.email}',
          style: const TextStyle(color: Colors.white70, fontSize: 14, fontFamily: 'Be Vietnam Pro'),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) => _OtpBox(
            controller: _controllers[index],
            onChanged: (value) {
              if (value.length > 1) {
                final pastedText = value.replaceAll(RegExp(r'[^0-9]'), '');
                for (int i = 0; i < pastedText.length && i < 6; i++) {
                  _controllers[i].text = pastedText[i];
                }
                if (pastedText.length == 6) {
                  FocusScope.of(context).unfocus();
                  _verifyOtp();
                } else if (pastedText.isNotEmpty) {
                  FocusScope.of(context).nextFocus();
                }
                return;
              }
              if (value.length == 1 && index < 5) FocusScope.of(context).nextFocus();
              if (value.isEmpty && index > 0) FocusScope.of(context).previousFocus();
            },
          )),
        ),
        const SizedBox(height: 32),
        _PrimaryButton(
          text: 'Verify Code',
          loading: _isLoading,
          onPressed: _verifyOtp,
        ),
        const SizedBox(height: 24),
        _FooterLink(
          text: 'Didn\'t receive the code? ',
          linkText: 'Resend',
          onTap: widget.onBack,
        ),
      ],
    );
  }
}

// --- Bước 3: Nhập Mật khẩu mới ---
class _NewPasswordStep extends StatefulWidget {
  final String email;
  final String code;
  final VoidCallback onSuccess;
  const _NewPasswordStep({required this.email, required this.code, required this.onSuccess});

  @override
  State<_NewPasswordStep> createState() => _NewPasswordStepState();
}

class _NewPasswordStepState extends State<_NewPasswordStep> {
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _BaseFormContainer(
      title: 'Reset Password',
      subtitle: 'Please enter your new password below',
      children: [
        const SizedBox(height: 32),
        _TextFieldWithRequiredLabel(
          label: 'New password',
          hint: 'Enter New Password',
          controller: _passController,
          obscure: true,
        ),
        const SizedBox(height: 20),
        _TextFieldWithRequiredLabel(
          label: 'Confirm Password',
          hint: 'Confirm New Password',
          controller: _confirmPassController,
          obscure: true,
        ),
        const SizedBox(height: 32),
        _PrimaryButton(
          text: 'Reset Password',
          loading: _isLoading,
          onPressed: () async {
            final pass = _passController.text;
            final confirm = _confirmPassController.text;
            if (pass.isEmpty || pass != confirm) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Passwords do not match')),
              );
              return;
            }

            setState(() => _isLoading = true);
            try {
              await context.read<AuthService>().resetPasswordWithCode(
                email: widget.email,
                code: widget.code,
                newPassword: pass,
              );
              widget.onSuccess();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${e.toString()}')),
              );
            } finally {
              if (mounted) setState(() => _isLoading = false);
            }
          },
        ),
        const SizedBox(height: 24),
        _FooterLink(
          text: 'Remember your password? ',
          linkText: 'Sign In',
          onTap: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

// --- Bước 4: Thành công ---
class _SuccessStep extends StatelessWidget {
  const _SuccessStep();

  @override
  Widget build(BuildContext context) {
    return _BaseFormContainer(
      title: 'Success!',
      subtitle: 'Your password has been reset successfully.',
      children: [
        const SizedBox(height: 40),
        const Icon(Icons.check_circle_outline, color: Color(0xFF3BFF00), size: 80),
        const SizedBox(height: 40),
        _PrimaryButton(
          text: 'Back to Sign In',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

// --- Helper Widgets ---

class _BaseFormContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;

  const _BaseFormContainer({required this.title, required this.subtitle, required this.children});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 480),
      child: RepaintBoundary(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 40),
          decoration: BoxDecoration(
            color: const Color(0xFF0B0B0B),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF1E1E1E), width: 1),
            boxShadow: const [
              BoxShadow(color: Colors.black54, blurRadius: 12),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'Be Vietnam Pro', letterSpacing: -1.5)),
              const SizedBox(height: 8),
              Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF9A9A9A), fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: -0.5, fontFamily: 'Be Vietnam Pro')),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  const _OtpBox({required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 55,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1),
        ),
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
          onChanged: onChanged ?? (value) {
            if (value.length == 1) FocusScope.of(context).nextFocus();
          },
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
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'Be Vietnam Pro')),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(1),
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
            child: TextField(
              controller: controller,
              obscureText: obscure,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Be Vietnam Pro'),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Color(0xFF636363), fontSize: 15, fontFamily: 'Be Vietnam Pro'),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TextFieldWithRequiredLabel extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscure;
  final TextEditingController? controller;
  const _TextFieldWithRequiredLabel({required this.label, required this.hint, this.controller, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: label, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'Be Vietnam Pro')),
              const TextSpan(text: ' *', style: TextStyle(color: Colors.red, fontSize: 15)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(1),
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
            child: TextField(
              controller: controller,
              obscureText: obscure,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Be Vietnam Pro'),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Color(0xFF636363), fontSize: 15, fontFamily: 'Be Vietnam Pro'),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: InputBorder.none,
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
    return GestureDetector(
      onTap: loading ? null : onPressed,
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
        child: loading
            ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18, fontFamily: 'Be Vietnam Pro')),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onTap;
  const _FooterLink({required this.text, required this.linkText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: text, style: const TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Be Vietnam Pro')),
              TextSpan(text: linkText, style: const TextStyle(color: Color(0xFF0094FF), fontWeight: FontWeight.w700, fontSize: 15, fontFamily: 'Be Vietnam Pro')),
            ],
          ),
        ),
      ),
    );
  }
}
