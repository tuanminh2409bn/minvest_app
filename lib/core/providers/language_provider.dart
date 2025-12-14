import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LanguageProvider with ChangeNotifier {
  Locale? _locale;

  LanguageProvider() {
    _locale = const Locale('en');
    _loadLocale();
  }

  Locale? get locale => _locale;

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('vi'),
    Locale('zh'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
  ];

  void setLocale(Locale newLocale) async {
    if (_locale != newLocale) {
      _locale = newLocale;
      notifyListeners(); // Cập nhật UI ngay lập tức

      // Lưu vào bộ nhớ cục bộ của điện thoại
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('language_code', newLocale.languageCode);

      try {
        final user = FirebaseAuth.instance.currentUser;
        // Chỉ cập nhật khi người dùng đã đăng nhập
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(
            {'languageCode': newLocale.languageCode},
            SetOptions(merge: true), // Dùng set + merge để tự tạo trường nếu chưa có
          );
          debugPrint("✅ [LanguageProvider] Đã cập nhật languageCode lên Firestore: ${newLocale.languageCode}");
        }
      } catch (e) {
        debugPrint("🚨 [LanguageProvider] Lỗi khi cập nhật ngôn ngữ lên Firestore: $e");
      }
    }
  }

  void _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code');
    if (languageCode != null) {
      _locale = Locale(languageCode);
    }
    notifyListeners();
  }
}