import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/gradients.dart';
import 'widgets/navbar.dart';
import 'package:minvest_forex_app/web/chat/web_chat_bubble.dart';
import 'package:minvest_forex_app/web/theme/breakpoints.dart';

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
          SnackBar(content: Text(AppLocalizations.of(context)!.contactInfoSentSuccess)),
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
          SnackBar(content: Text(AppLocalizations.of(context)!.contactInfoSentFailed(e.toString()))),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: isMobile ? const TextScaler.linear(0.72) : const TextScaler.linear(1.0),
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        floatingActionButton: const WebChatBubble(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                    _header(context),
                    const SizedBox(height: 24),
                    _contactCards(context),
                    const SizedBox(height: 24),
                    _contactForm(context),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.contactUs247,
          style: AppTextStyles.h1.copyWith(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.contactPageSubtitle,
          style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _contactCards(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool stacked = constraints.maxWidth < 900;
        final List<Widget> cards = [
          _InfoCard(
            title: 'Whatsapp',
            subtitle: '+84 969.15.6969',
            icon: Icons.chat_bubble_outline,
            onTap: () => launchUrl(Uri.parse('https://wa.me/84969156969')),
          ),
          const SizedBox(width: 24, height: 24), // Figma Spacing
          _InfoCard(
            title: AppLocalizations.of(context)!.phone,
            subtitle: '+84 969.15.6969',
            icon: Icons.phone_in_talk_outlined,
            onTap: () => launchUrl(Uri.parse('tel:+84969156969')),
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
          crossAxisAlignment: CrossAxisAlignment.start, // Align to top
          children: cards,
        );
      },
    );
  }

  Widget _contactForm(BuildContext context) {
    return RepaintBoundary(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 823), // Figma width
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: AppGradients.cta, // Gradient border
            ),
            padding: const EdgeInsets.all(1), // Border width
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(11), // Inner radius
              ),
              padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 40), // Approximate padding based on Figma positions
              child: Form(
                key: _formKey,
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
                                context: context,
                                label: AppLocalizations.of(context)!.firstName,
                                hint: AppLocalizations.of(context)!.enterFirstName,
                                controller: _firstNameController,
                                requiredField: true,
                              ),
                              const SizedBox(height: 24),
                              _textField(
                                context: context,
                                label: AppLocalizations.of(context)!.lastName,
                                hint: AppLocalizations.of(context)!.enterLastName,
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
                                context: context,
                                label: AppLocalizations.of(context)!.firstName,
                                hint: AppLocalizations.of(context)!.enterFirstName,
                                controller: _firstNameController,
                                requiredField: true,
                              ),
                            ),
                            const SizedBox(width: 24), // Spacing from Figma (approx)
                            Expanded(
                              child: _textField(
                                context: context,
                                label: AppLocalizations.of(context)!.lastName,
                                hint: AppLocalizations.of(context)!.enterLastName,
                                controller: _lastNameController,
                                requiredField: true,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final bool stacked = constraints.maxWidth < 640;
                        if (stacked) {
                          return Column(
                            children: [
                              _textField(
                                context: context,
                                label: AppLocalizations.of(context)!.yourEmail,
                                hint: 'example123@gmail.com',
                                controller: _emailController,
                                requiredField: true,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 24),
                              _textField(
                                context: context,
                                label: AppLocalizations.of(context)!.phone,
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
                                context: context,
                                label: AppLocalizations.of(context)!.yourEmail,
                                hint: 'example123@gmail.com',
                                controller: _emailController,
                                requiredField: true,
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _textField(
                                context: context,
                                label: AppLocalizations.of(context)!.phone,
                                hint: '+1 234 567 890',
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    _textArea(
                      context: context,
                      label: AppLocalizations.of(context)!.whatAreYourConcerns,
                      hint: AppLocalizations.of(context)!.writeConcernsHere,
                      controller: _messageController,
                      requiredField: true,
                    ),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            textStyle: AppTextStyles.body.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.54,
                              fontFamily: 'Be Vietnam Pro',
                            ),
                          ),
                          onPressed: _isSubmitting ? null : _submitForm,
                          child: _isSubmitting
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                                )
                              : Text(AppLocalizations.of(context)!.send),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required BuildContext context,
    required String label,
    required String hint,
    TextEditingController? controller,
    bool requiredField = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    const labelStyle = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: 'Be Vietnam Pro',
      fontWeight: FontWeight.w400,
      letterSpacing: -0.54,
    );
    
    const inputStyle = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: 'Be Vietnam Pro',
      fontWeight: FontWeight.w400,
      letterSpacing: -0.54,
    );

    const hintStyle = TextStyle(
      color: Color(0xFF9A9A9A),
      fontSize: 18,
      fontFamily: 'Be Vietnam Pro',
      fontWeight: FontWeight.w400,
      letterSpacing: -0.54,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 12),
        SizedBox(
          height: 55,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: (value) {
              if (requiredField && (value == null || value.trim().isEmpty)) {
                return AppLocalizations.of(context)!.pleaseEnter(label);
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: hintStyle,
              filled: true,
              fillColor: const Color(0xFF111111),
              contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFF424242), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.white, width: 1),
              ),
              errorStyle: const TextStyle(height: 0),
            ),
            style: inputStyle,
          ),
        ),
      ],
    );
  }

  Widget _textArea({
    required BuildContext context,
    required String label,
    required String hint,
    TextEditingController? controller,
    bool requiredField = false,
  }) {
    const labelStyle = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: 'Be Vietnam Pro',
      fontWeight: FontWeight.w400,
      letterSpacing: -0.54,
    );
    
    const inputStyle = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: 'Be Vietnam Pro',
      fontWeight: FontWeight.w400,
      letterSpacing: -0.54,
    );

    const hintStyle = TextStyle(
      color: Color(0xFF9A9A9A),
      fontSize: 18,
      fontFamily: 'Be Vietnam Pro',
      fontWeight: FontWeight.w400,
      letterSpacing: -0.54,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller,
          maxLines: 6,
          validator: (value) {
            if (requiredField && (value == null || value.trim().isEmpty)) {
              return AppLocalizations.of(context)!.pleaseEnter(label);
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: hintStyle,
            filled: true,
            fillColor: const Color(0xFF111111),
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF424242), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.white, width: 1),
            ),
          ),
          style: inputStyle,
        ),
      ],
    );
  }
}

class _InfoCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const _InfoCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  State<_InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<_InfoCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth < 430 ? screenWidth - 32 : 399;

    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: cardWidth,
            height: 132,
            transform: _isHovering ? Matrix4.diagonal3Values(1.02, 1.02, 1.02) : Matrix4.identity(),
            child: Container(
              decoration: BoxDecoration(
                gradient: AppGradients.cta,
                borderRadius: BorderRadius.circular(13),
                boxShadow: _isHovering
                    ? [
                        BoxShadow(
                          color: const Color(0xFF4779D4).withValues(alpha: 0.3),
                          blurRadius: 15,
                          spreadRadius: 1,
                        )
                      ]
                    : [],
              ),
              padding: const EdgeInsets.all(1),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                      left: -266.39,
                      top: -60.60,
                      child: Container(
                        width: 932.25,
                        height: 491.37,
                        decoration: const ShapeDecoration(
                          gradient: RadialGradient(
                            center: Alignment(0.50, 0.50),
                            radius: 0.50,
                            colors: [
                              Color(0xFF3E42BD),
                              Colors.transparent,
                            ],
                          ),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(widget.icon, color: Colors.white, size: 24),
                              const SizedBox(width: 12),
                              Text(
                                widget.title,
                                style: AppTextStyles.body.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Be Vietnam Pro',
                                  letterSpacing: -0.54,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.subtitle,
                            style: AppTextStyles.body.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Be Vietnam Pro',
                              letterSpacing: -0.54,
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
        ),
      ),
    );
  }
}
