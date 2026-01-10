import 'package:flutter/material.dart';
import 'package:minvest_forex_app/web/landing/features_page.dart';
import 'package:minvest_forex_app/web/landing/landing_page.dart';
import 'package:minvest_forex_app/web/landing/ai_signals_page.dart';
import 'package:minvest_forex_app/web/landing/pricing_page.dart';
import 'package:minvest_forex_app/web/landing/news_page.dart';
import 'package:minvest_forex_app/web/landing/contact_page.dart';
import 'package:minvest_forex_app/web/landing/legal/terms_of_registration_page.dart';
import 'package:minvest_forex_app/web/landing/legal/operating_principles_page.dart';
import 'package:minvest_forex_app/web/landing/legal/terms_conditions_page.dart';
import 'package:minvest_forex_app/web/landing/payment_callback_screen.dart';
import 'package:minvest_forex_app/features/auth/screens/welcome/signup_screen_web.dart';
import 'package:minvest_forex_app/features/auth/screens/profile_screen.dart';
import 'package:minvest_forex_app/app/auth_gate.dart';

Map<String, WidgetBuilder> getWebRoutes() {
  return {
    '/': (context) => const LandingPage(),
    '/features': (context) => const FeaturesPage(),
    '/ai-signals': (context) => const AISignalsPage(),
    '/pricing': (context) => const PricingPage(),
    '/news': (context) => const NewsPage(),
    '/contact-us': (context) => const ContactPage(),
    '/signin': (context) => const AuthGate(),
    '/signup': (context) => const SignupScreenWeb(),
    '/profile': (context) => const ProfileScreen(),
    '/terms-of-registration': (context) => const TermsOfRegistrationPage(),
    '/operating-principles': (context) => const OperatingPrinciplesPage(),
    '/terms-conditions': (context) => const TermsConditionsPage(),
    '/payment/success': (context) => const PaymentCallbackScreen(isSuccess: true),
    '/payment/cancel': (context) => const PaymentCallbackScreen(isSuccess: false),
  };
}
