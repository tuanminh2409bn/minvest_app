import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  Locale? _locale;
  LanguageProvider() {
    _locale = const Locale('en');
    _loadLocale();
  }
  Locale? get locale => _locale;
  void setLocale(Locale newLocale) async {
    if (_locale != newLocale) {
      _locale = newLocale;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('language_code', newLocale.languageCode);
      notifyListeners();
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