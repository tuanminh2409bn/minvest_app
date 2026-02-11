import 'package:flutter/material.dart';
import 'package:minvest_forex_app/features/auth/screens/welcome/welcome_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Ảnh nền thay cho nền đen và hiệu ứng ánh sáng
          Positioned.fill(
            child: Image.asset(
              'assets/mockups/start_02.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // Nội dung chính
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  
                  // Logo (Tăng kích thước từ 41 lên 60)
                  Image.asset(
                    'assets/mockups/logo.png',
                    width: 300,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Slogan (Xuống dòng sau dấu "-")
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'The Ultimate AI Engine –\nDesigned by Expert Traders.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                  ),
                  
                  const Spacer(flex: 6),
                  
                  // Nút Get Started
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
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
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}