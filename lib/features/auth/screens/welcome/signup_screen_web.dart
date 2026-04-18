import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/features/auth/services/auth_service.dart';
import 'package:minvest_forex_app/web/landing/widgets/navbar.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/web/widgets/landing_background.dart';
import 'package:minvest_forex_app/web/theme/breakpoints.dart';

enum SignupStep { personalInfo, password, verification }

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
                          child: const LandingNavBar(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 40, bottom: 40),
                        child: LandingBackgroundWrapper(
                          offsetAdjustment: 100,
                          child: const _SignupMultiStepForm(),
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

class _SignupMultiStepForm extends StatefulWidget {
  const _SignupMultiStepForm();

  @override
  State<_SignupMultiStepForm> createState() => _SignupMultiStepFormState();
}

class _SignupMultiStepFormState extends State<_SignupMultiStepForm> {
  SignupStep _currentStep = SignupStep.personalInfo;
  bool _isGlobalLoading = false;
  
  // Bước 1 Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String _countryCode = 'VN(+84)';

  // Bước 2 Controllers
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreedToTerms = false;

  void _goToStep(SignupStep step) {
    setState(() => _currentStep = step);
  }

  Future<void> _requestVerification() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;

    setState(() => _isGlobalLoading = true);
    try {
      await context.read<AuthService>().requestSignupVerificationCode(email);
      _goToStep(SignupStep.verification);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _isGlobalLoading = false);
    }
  }

  Future<void> _completeSignup(String otp) async {
    final email = _emailController.text.trim();
    final name = _nameController.text.trim();
    final password = _passwordController.text;
    final phone = _phoneController.text.trim();

    setState(() => _isGlobalLoading = true);
    try {
      final isValid = await context.read<AuthService>().verifySignupCode(email, otp);
      if (!isValid) {
        throw Exception("Invalid or expired verification code.");
      }

      await context.read<AuthService>().signUpWithEmailPassword(
        email: email,
        password: password,
        displayName: name,
        phoneNumber: phone.isEmpty ? null : phone,
        countryCode: _countryCode,
      );
      // AuthBloc listener will handle navigation to home
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _isGlobalLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _BaseSignupContainer(
      currentStep: _currentStep,
      child: _buildCurrentStep(),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case SignupStep.personalInfo:
        return _PersonalInfoStep(
          nameController: _nameController,
          emailController: _emailController,
          phoneController: _phoneController,
          countryCode: _countryCode,
          onCountryCodeChanged: (val) => setState(() => _countryCode = val),
          onNext: () => _goToStep(SignupStep.password),
        );
      case SignupStep.password:
        return _PasswordStep(
          passwordController: _passwordController,
          confirmPasswordController: _confirmPasswordController,
          agreedToTerms: _agreedToTerms,
          onAgreedChanged: (val) => setState(() => _agreedToTerms = val),
          onBack: () => _goToStep(SignupStep.personalInfo),
          onNext: _requestVerification,
          isLoading: _isGlobalLoading,
        );
      case SignupStep.verification:
        return _VerificationStep(
          email: _emailController.text,
          onBack: () => _goToStep(SignupStep.password),
          onVerify: _completeSignup,
          isLoading: _isGlobalLoading,
          onResend: () => context.read<AuthService>().requestSignupVerificationCode(_emailController.text),
        );
    }
  }
}

// --- Container chung cho Form Đăng ký ---
class _BaseSignupContainer extends StatelessWidget {
  final SignupStep currentStep;
  final Widget child;

  const _BaseSignupContainer({required this.currentStep, required this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 480),
      child: RepaintBoundary(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 32),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF595959), width: 1),
            boxShadow: const [
              BoxShadow(color: Color(0x7FB49CFF), blurRadius: 12),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Thanh tiến trình
              Row(
                children: [
                  _ProgressSegment(isActive: true),
                  const SizedBox(width: 8),
                  _ProgressSegment(isActive: currentStep != SignupStep.personalInfo),
                  const SizedBox(width: 8),
                  _ProgressSegment(isActive: currentStep == SignupStep.verification),
                ],
              ),
              const SizedBox(height: 24),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressSegment extends StatelessWidget {
  final bool isActive;
  const _ProgressSegment({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF289EFF) : const Color(0xFFD9D9D9).withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

// --- BƯỚC 1: Thông tin cá nhân ---
class _PersonalInfoStep extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final String countryCode;
  final ValueChanged<String> onCountryCodeChanged;
  final VoidCallback onNext;

  const _PersonalInfoStep({
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.countryCode,
    required this.onCountryCodeChanged,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Sign Up Account',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'Be Vietnam Pro', letterSpacing: -1.0),
        ),
        const SizedBox(height: 4),
        const Text(
          'Enter your personal data to create your account',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF9A9A9A), fontSize: 14, fontWeight: FontWeight.w400),
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
        _TextFieldWithRequiredLabel(label: 'Name', hint: 'Enter Name', controller: nameController),
        const SizedBox(height: 16),
        _TextFieldWithRequiredLabel(label: 'Email', hint: 'example123@gmail.com', controller: emailController),
        const SizedBox(height: 16),
        const Text('Phone', style: TextStyle(color: Colors.white, fontSize: 14)),
        const SizedBox(height: 6),
        _PhoneField(countryCode: countryCode, onCountryCodeChanged: onCountryCodeChanged, controller: phoneController),
        const SizedBox(height: 32),
        _PrimaryButton(
          text: 'Continue',
          onPressed: () {
            if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
              onNext();
            }
          },
        ),
      ],
    );
  }
}

// --- BƯỚC 2: Thiết lập mật khẩu ---
class _PasswordStep extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool agreedToTerms;
  final ValueChanged<bool> onAgreedChanged;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final bool isLoading;

  const _PasswordStep({
    required this.passwordController,
    required this.confirmPasswordController,
    required this.agreedToTerms,
    required this.onAgreedChanged,
    required this.onBack,
    required this.onNext,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Security Setup',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'Be Vietnam Pro', letterSpacing: -1.0),
        ),
        const SizedBox(height: 4),
        const Text(
          'Create a secure password for your account',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF9A9A9A), fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 32),
        _TextFieldWithRequiredLabel(label: 'Password', hint: 'Enter Password', controller: passwordController, obscure: true),
        const SizedBox(height: 8),
        const Text(
          'Password must be at least 6 characters',
          style: TextStyle(color: Color(0xFF484848), fontSize: 13, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 20),
        _TextFieldWithRequiredLabel(label: 'Confirm Password', hint: 'Confirm Password', controller: confirmPasswordController, obscure: true),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: agreedToTerms,
                onChanged: (val) => onAgreedChanged(val ?? false),
                side: const BorderSide(color: Color(0xFF424242)),
                activeColor: const Color(0xFF289EFF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'I have read and agreed to the ', style: TextStyle(color: Color(0xFF484848), fontSize: 14)),
                    TextSpan(
                      text: 'Terms & Conditions', 
                      style: const TextStyle(color: Color(0xFF289EFF), fontSize: 14),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamed('/terms-conditions');
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            SizedBox(
              width: 100, // Increased from 80 to prevent 'Back' wrapping
              height: 45,
              child: OutlinedButton(
                onPressed: onBack,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text('Back', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _PrimaryButton(
                text: 'Continue',
                loading: isLoading,
                onPressed: () {
                  if (passwordController.text.length >= 6 && 
                      passwordController.text == confirmPasswordController.text &&
                      agreedToTerms) {
                    onNext();
                  }
                },
              ),
            ),
          ],
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

// --- BƯỚC 3: Xác thực OTP (Figma Group 467) ---
class _VerificationStep extends StatefulWidget {
  final String email;
  final VoidCallback onBack;
  final Function(String) onVerify;
  final Function() onResend;
  final bool isLoading;

  const _VerificationStep({
    required this.email,
    required this.onBack,
    required this.onVerify,
    required this.onResend,
    this.isLoading = false,
  });

  @override
  State<_VerificationStep> createState() => _VerificationStepState();
}

class _VerificationStepState extends State<_VerificationStep> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  int _resendCountdown = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _resendCountdown = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown == 0) {
        timer.cancel();
      } else {
        setState(() => _resendCountdown--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Verification',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'Be Vietnam Pro', letterSpacing: -1.0),
        ),
        const SizedBox(height: 4),
        const Text(
          'A verification code has been sent to your email.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF289EFF), fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 8),
        Text(
          widget.email,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 32),
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
                  String otp = _controllers.map((c) => c.text).join();
                  widget.onVerify(otp);
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
          text: 'Confirm Verification',
          loading: widget.isLoading,
          onPressed: () {
            String otp = _controllers.map((c) => c.text).join();
            if (otp.length == 6) widget.onVerify(otp);
          },
        ),
        const SizedBox(height: 24),
        Center(
          child: Column(
            children: [
              const Text('Didn’t receive code?', style: TextStyle(color: Colors.white, fontSize: 14)),
              const SizedBox(height: 8),
              _resendCountdown > 0 
                ? Text(
                    'Resend code in: ${(_resendCountdown ~/ 60).toString().padLeft(2, '0')}:${(_resendCountdown % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(color: Color(0xFF9A9A9A), fontSize: 14),
                  )
                : TextButton(
                    onPressed: () {
                      widget.onResend();
                      _startTimer();
                    },
                    child: const Text('Resend Now', style: TextStyle(color: Color(0xFF289EFF))),
                  ),
            ],
          ),
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

// --- Helper Widgets ---

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  const _OtpBox({required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 55,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xFF111111),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFF424242))),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFF289EFF))),
        ),
        onChanged: onChanged ?? (value) {
          if (value.length == 1) FocusScope.of(context).nextFocus();
        },
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
            Container(width: 32, alignment: Alignment.center, child: icon),
            const SizedBox(width: 12),
            Expanded(child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15), textAlign: TextAlign.left)),
          ],
        ),
      ),
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
              TextSpan(text: label, style: const TextStyle(color: Colors.white, fontSize: 14)),
              const TextSpan(text: ' *', style: TextStyle(color: Colors.red, fontSize: 14)),
            ],
          ),
        ),
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFF424242))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFF289EFF))),
            ),
          ),
        ),
      ],
    );
  }
}

class _PhoneField extends StatelessWidget {
  final String countryCode;
  final ValueChanged<String> onCountryCodeChanged;
  final TextEditingController controller;
  const _PhoneField({required this.countryCode, required this.onCountryCodeChanged, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 110, // Increased from 90 to prevent 'VN(+84)' wrapping
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
              if (value != null) onCountryCodeChanged(value);
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
                hintText: '+1 234 567 890',
                hintStyle: const TextStyle(color: Color(0xFF9A9A9A), fontSize: 14),
                filled: true,
                fillColor: const Color(0xFF111111),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFF424242))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFF289EFF))),
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
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(text: text, style: const TextStyle(color: Colors.white, fontSize: 14)),
              TextSpan(text: linkText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
