import 'package:flutter/material.dart';
import 'package:minvest_forex_app/features/signals/models/signal_model.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/core/providers/language_provider.dart';

class SignalAnalyzeScreen extends StatelessWidget {
  final Signal signal;

  const SignalAnalyzeScreen({super.key, required this.signal});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final locale = languageProvider.locale?.languageCode ?? 'en';

    String reasonText = '';
    if (signal.reason is Map) {
      reasonText = signal.reason[locale] ?? signal.reason['en'] ?? signal.reason['vi'] ?? '';
    } else if (signal.reason is String) {
      reasonText = signal.reason;
    }

    // Tách dòng để xử lý hiển thị đẹp hơn nếu văn bản dài
    // Nếu backend trả về markdown hoặc text thô, ta hiển thị trực tiếp
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33.0), // Padding khớp Figma (left 33)
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Capital Management',
                  style: TextStyle(
                    color: Color(0xFF636363),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 36), // Khoảng cách tới mục đầu tiên

                // Hiển thị nội dung phân tích từ Backend
                // Sử dụng tiêu đề chung nếu không parse được các mục con
                _buildAnalysisSection(
                  'Analysis & Explanation', 
                  reasonText.isEmpty ? 'No detailed analysis available for this signal.' : reasonText
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Be Vietnam Pro', // Sử dụng font của App
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8), // Khoảng cách giữa tiêu đề và nội dung
        Text(
          content,
          style: const TextStyle(
            color: Colors.white, // Màu trắng như Figma
            fontSize: 16,
            fontWeight: FontWeight.w300, // Light weight (w250 in Figma -> w300 in Flutter)
            height: 1.4, // Line height cho dễ đọc
          ),
        ),
        const SizedBox(height: 28), // Khoảng cách giữa các section
      ],
    );
  }
}
