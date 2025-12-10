import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/gradients.dart';
import '../theme/spacing.dart';
import 'widgets/navbar.dart';
import 'sections/footer_section.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    try {
      final callable = FirebaseFunctions.instanceFor(region: 'asia-southeast1').httpsCallable('submitContactMessage');
      await callable.call({
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'message': _messageController.text.trim(),
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã gửi thông tin liên hệ thành công.')),
        );
        _formKey.currentState!.reset();
        _firstNameController.clear();
        _lastNameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gửi thông tin thất bại: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  const LandingNavBar(),
                  const SizedBox(height: 32),
                  _header(),
                  const SizedBox(height: 24),
                  _contactCards(),
                  const SizedBox(height: 24),
                  _contactForm(),
                  const SizedBox(height: 64),
                  const FooterSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        Text(
          'Get in Touch with Us',
          style: AppTextStyles.h1.copyWith(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Have questions or need AI solutions? Let us know by filling out the form, and we\'ll be in touch!',
          style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _contactCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool stacked = constraints.maxWidth < 900;
        final cards = const [
          SizedBox(
            width: 420,
            child: _InfoCard(
              title: 'Whatsapp',
              subtitle: '0969 15 6969',
              icon: Icons.chat_bubble_outline,
            ),
          ),
          SizedBox(width: 16, height: 16),
          SizedBox(
            width: 420,
            child: _InfoCard(
              title: 'Phone',
              subtitle: '0969 15 6969',
              icon: Icons.phone_in_talk_outlined,
            ),
          ),
        ];

        if (stacked) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: cards,
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: cards,
        );
      },
    );
  }

  Widget _contactForm() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 860),
        child: Container(
          padding: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: AppGradients.cta,
          ),
          child: Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(9),
              ),
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final bool stacked = constraints.maxWidth < 640;
                      if (stacked) {
                        return Column(
                          children: [
                            _textField(
                              label: 'First Name',
                              hint: 'Enter First Name',
                              controller: _firstNameController,
                              requiredField: true,
                            ),
                            const SizedBox(height: 12),
                            _textField(
                              label: 'Last Name',
                              hint: 'Enter Last Name',
                              controller: _lastNameController,
                              requiredField: true,
                            ),
                          ],
                        );
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: _textField(
                              label: 'First Name',
                              hint: 'Enter First Name',
                              controller: _firstNameController,
                              requiredField: true,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _textField(
                              label: 'Last Name',
                              hint: 'Enter Last Name',
                              controller: _lastNameController,
                              requiredField: true,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final bool stacked = constraints.maxWidth < 640;
                      if (stacked) {
                        return Column(
                          children: [
                            _textField(
                              label: 'Email',
                              hint: 'example123@gmail.com',
                              controller: _emailController,
                              requiredField: true,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 12),
                            _textField(
                              label: 'Phone',
                              hint: '+1 234 567 890',
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        );
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: _textField(
                              label: 'Email',
                              hint: 'example123@gmail.com',
                              controller: _emailController,
                              requiredField: true,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _textField(
                              label: 'Phone',
                              hint: '+1 234 567 890',
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 18),
                  _textArea(
                    label: 'What Are Your Concerns?',
                    hint: 'Write Concerns Here...',
                    controller: _messageController,
                    requiredField: true,
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        textStyle: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700),
                      ),
                      onPressed: _isSubmitting ? null : _submitForm,
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                            )
                          : const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required String label,
    required String hint,
    TextEditingController? controller,
    bool requiredField = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final bool isNarrow = MediaQuery.of(context).size.width < 640;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: (value) {
            if (requiredField && (value == null || value.trim().isEmpty)) {
              return 'Vui lòng nhập $label';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: isNarrow ? 12 : 13),
            filled: true,
            fillColor: const Color(0xFF0F0F0F),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.white12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.white30),
            ),
          ),
          style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: isNarrow ? 13 : 14),
        ),
      ],
    );
  }

  Widget _textArea({
    required String label,
    required String hint,
    TextEditingController? controller,
    bool requiredField = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: 6,
          validator: (value) {
            if (requiredField && (value == null || value.trim().isEmpty)) {
              return 'Vui lòng nhập $label';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 13),
            filled: true,
            fillColor: const Color(0xFF0F0F0F),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.white12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.white30),
            ),
          ),
          style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const _InfoCard({required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        gradient: AppGradients.cta,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          gradient: const LinearGradient(
            colors: [Color(0xFF111325), Color(0xFF070812)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
