// lib/main.dart

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/app/auth_gate.dart';
import 'package:minvest_forex_app/app/main_screen_web.dart';
import 'package:minvest_forex_app/core/providers/language_provider.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/core/services/purchase_service.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/features/auth/services/auth_service.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';
import 'package:minvest_forex_app/features/signals/screens/signal_detail_screen.dart';
import 'package:minvest_forex_app/features/signals/services/signal_service.dart';
import 'package:minvest_forex_app/firebase_options.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/services/session_service.dart';
import 'package:flutter/services.dart';
import 'package:minvest_forex_app/features/chat/providers/chat_provider.dart';
import 'package:minvest_forex_app/features/chat/screens/support_chat_screen.dart';
import 'package:minvest_forex_app/features/chat/services/chat_service.dart';
import 'package:minvest_forex_app/app/main_screen_mobile.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'web/landing/features_page.dart';
import 'web/landing/landing_page.dart';
import 'web/landing/ai_signals_page.dart';
import 'web/landing/pricing_page.dart';
import 'web/landing/news_page.dart';
import 'web/landing/contact_page.dart';
import 'features/auth/screens/welcome/signup_screen_web.dart';
import 'features/auth/screens/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<MainScreenState> mainScreenKey = GlobalKey<MainScreenState>();
final GlobalKey<MainScreenWebState> mainScreenWebKey = GlobalKey<MainScreenWebState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<SessionService>(create: (_) => SessionService()),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authService: context.read<AuthService>(),
            sessionService: context.read<SessionService>(),
          ),
        ),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(
          create: (context) => UserProvider(
            authService: context.read<AuthService>(),
          ),
        ),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => PurchaseService()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<String>? _forceLogoutSubscription;
  bool _isLogoutDialogShowing = false;

  @override
  void initState() {
    super.initState();
    _initializeCoreServices();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final authService = context.read<AuthService>();
        _forceLogoutSubscription = authService.forceLogoutStream.listen((reason) {
          if (mounted && !_isLogoutDialogShowing) {
            setState(() { _isLogoutDialogShowing = true; });
            _showLogoutDialog(reason);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _forceLogoutSubscription?.cancel();
    super.dispose();
  }

  // --- THAY ĐỔI 3: GỌI SERVICE MỚI ĐỂ KHỞI TẠO VÀ XỬ LÝ THÔNG BÁO ---
  Future<void> _initializeCoreServices() async {
    // Khởi tạo PurchaseService
    context.read<PurchaseService>().initialize();
    debugPrint("✅ Đã gọi initialize() cho PurchaseService từ MyApp.");

    // Khởi tạo NotificationService
    await NotificationService().initialize(
      onNotificationTapped: (data) {
        _handleNotificationNavigation(data);
      },
    );

    final fcmToken = await NotificationService().getFcmToken();
    if (fcmToken != null) {
    }
  }

  Future<void> _handleNotificationNavigation(Map<String, dynamic> data) async {
    final String? type = data['type'];
    if (type == null) {
      print('Lỗi: Thông báo không có trường "type"');
      return;
    }

    await Future.delayed(const Duration(milliseconds: 500));
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userRole = userProvider.role;

    switch (type) {
      case 'new_signal':
      case 'signal_matched':
      case 'tp1_hit':
      case 'tp2_hit':
      case 'tp3_hit':
      case 'sl_hit':
      final String? signalId = data['signalId'];
      if (signalId == null) return;
      try {
        final signal = await SignalService().getSignalById(signalId);
        final userTier = userProvider.userTier ?? 'free';
        if (signal != null && navigatorKey.currentState != null) {
          navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => SignalDetailScreen(signal: signal, userTier: userTier),
            ),
          );
        }
      } catch (e) {
        print('Lỗi khi điều hướng từ thông báo tín hiệu: $e');
      }
      break;

      case 'new_chat_message':
        final String? chatRoomId = data['chatRoomId'];
        if (chatRoomId == null) return;

        if (userRole == 'support') {
          try {
            final chatUser = await ChatService().getUserDetails(chatRoomId);
            if (chatUser != null && navigatorKey.currentState != null) {
              navigatorKey.currentState!.push(
                MaterialPageRoute(
                  builder: (_) => SupportChatScreen(
                    userId: chatUser.uid,
                    userName: chatUser.displayName,
                  ),
                ),
              );
            }
          } catch (e) {
            print('Lỗi khi điều hướng support đến màn hình chat: $e');
          }
        }
        else {
          if (kIsWeb) {
            // Nếu là Web, dùng key của Web và index 1
            mainScreenWebKey.currentState?.switchToTab(1);
          } else {
            // Nếu là Mobile, dùng key của Mobile và index 2
            mainScreenKey.currentState?.switchToTab(2);
          }
        }
        break;

      default:
        print('Không nhận dạng được loại thông báo: $type');
    }
  }

  void _showLogoutDialog(String? reason) {
    final context = navigatorKey.currentContext;
    if (context == null) {
      if (mounted) setState(() => _isLogoutDialogShowing = false);
      return;
    }
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(l10n.logoutDialogTitle),
          content: Text(reason ?? l10n.logoutDialogDefaultReason),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.ok),
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await Provider.of<AuthService>(context, listen: false).signOut();
              },
            ),
          ],
        );
      },
    ).then((_) {
      if (mounted) {
        setState(() {
          _isLogoutDialogShowing = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        if (kIsWeb) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Minvest Forex App',
            theme: _buildAppTheme(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routes: {
              '/': (context) => const LandingPage(),
              '/features': (context) => const FeaturesPage(),
              '/ai-signals': (context) => const AISignalsPage(),
              '/pricing': (context) => const PricingPage(),
              '/news': (context) => const NewsPage(),
              '/contact-us': (context) => const ContactPage(),
              '/signin': (context) => const AuthGate(),
              '/signup': (context) => const SignupScreenWeb(),
              '/profile': (context) => const ProfileScreen(),
            },
            initialRoute: '/',
          );
        }

        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Minvest Forex App',
          theme: _buildAppTheme(),
          locale: languageProvider.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const AuthGate(),
        );
      },
    );
  }
}

ThemeData _buildAppTheme() {
  final base = ThemeData.dark();
  return base.copyWith(
    textTheme: GoogleFonts.beVietnamProTextTheme(base.textTheme),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Color(0xFF1F1F1F),
    ),
  );
}
