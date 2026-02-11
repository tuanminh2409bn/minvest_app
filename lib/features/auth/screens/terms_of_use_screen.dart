import 'package:flutter/material.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Terms of Use',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Be Vietnam Pro',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'By accessing or using this application, you agree to comply with the Terms of Use. This app is provided for informational purposes only, and we do not guarantee the accuracy, completeness, or reliability of any content or signals displayed. You are solely responsible for how you use the information that is provided within the app. We reserve the right to modify, suspend, or terminate the service at any time without prior notice. Continued use of the app constitutes acceptance of any updated terms.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Be Vietnam Pro',
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
