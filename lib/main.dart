import 'dart:async';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/app/auth_gate.dart';
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
import 'package:minvest_forex_app/features/chat/screens/chat_screen.dart';
import 'package:minvest_forex_app/features/chat/services/chat_service.dart';
import 'package:minvest_forex_app/app/main_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:minvest_forex_app/app/routes/web_routes_stub.dart' if (dart.library.js_interop) 'package:minvest_forex_app/app/routes/web_routes.dart';
import 'features/auth/screens/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_quill/flutter_quill.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<MainScreenState> mainScreenKey = GlobalKey<MainScreenState>();

Future<void> main() async {
  runZonedGuarded(() async {
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

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      debugPrint('🚨 Flutter Error: ${details.exception}');
      debugPrint('Stack trace: ${details.stack}');
      // Có thể thêm tích hợp Crashlytics ở đây trong tương lai
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      debugPrint('🚨 Platform Error: $error');
      debugPrint('Stack trace: $stack');
      return true;
    };
    
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LanguageProvider()),
          Provider<AuthService>(create: (_) => AuthService()),
          Provider<SessionService>(create: (_) => SessionService()),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authService: context.read<AuthService>(),
              sessionService: context.read<SessionService>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => UserProvider(
              authService: context.read<AuthService>(),
            ),
          ),
          ChangeNotifierProvider(create: (context) => NotificationProvider()),
          ChangeNotifierProvider(create: (context) => PurchaseService()),
          ChangeNotifierProvider(create: (context) => ChatProvider(context.read<AuthService>())),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stack) {
    debugPrint('🚨 Uncaught Error: $error');
    debugPrint('Stack trace: $stack');
  });
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

  Future<void> _initializeCoreServices() async {
    // Initialize AuthService
    await context.read<AuthService>().initialize();

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
      debugPrint("FCM Token: $fcmToken");
    }
  }

  Future<void> _handleNotificationNavigation(Map<String, dynamic> data) async {
    final String? type = data['type'];
    if (type == null) {
      debugPrint('Lỗi: Thông báo không có trường "type"');
      return;
    }

    // Chờ một chút để đảm bảo navigator và provider đã sẵn sàng
    await Future.delayed(const Duration(milliseconds: 800));
    
    if (!mounted) return;
    
    try {
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
          
          final signal = await SignalService().getSignalById(signalId);
          final userTier = userProvider.userTier ?? 'free';
          
          if (signal != null && navigatorKey.currentState != null) {
            navigatorKey.currentState!.push(
              MaterialPageRoute(
                builder: (_) => SignalDetailScreen(signal: signal, userTier: userTier),
              ),
            );
          } else {
            debugPrint('⚠️ Navigator chưa sẵn sàng hoặc không tìm thấy tín hiệu');
          }
          break;

        case 'new_chat_message':
          final String? chatRoomId = data['chatRoomId'];
          if (chatRoomId == null) return;

          if (userRole == 'support') {
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
          } else {
            if (kIsWeb) {
              navigatorKey.currentState?.push(
                MaterialPageRoute(builder: (_) => const ChatScreen()),
              );
            } else {
              mainScreenKey.currentState?.switchToTab(2);
            }
          }
          break;

        default:
          debugPrint('Không nhận dạng được loại thông báo: $type');
      }
    } catch (e) {
      debugPrint('🚨 Lỗi khi xử lý điều hướng thông báo: $e');
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
                if (mounted) {
                   await Provider.of<AuthService>(context, listen: false).signOut();
                }
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
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Signal GPT',
            theme: _buildAppTheme(),
            locale: languageProvider.locale,
            localizationsDelegates: [
              ...AppLocalizations.localizationsDelegates,
              FlutterQuillLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) {
              return GestureDetector(
                onTap: () {
                  // Thu bàn phím khi chạm ra ngoài các ô nhập liệu
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: child!,
                ),
              );
            },
            routes: getWebRoutes(),
            initialRoute: '/',
          );
        }

        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Signal GPT',
          theme: _buildAppTheme(),
          locale: languageProvider.locale,
          localizationsDelegates: [
            ...AppLocalizations.localizationsDelegates,
            FlutterQuillLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) {
            return GestureDetector(
              onTap: () {
                // Thu bàn phím cho phiên bản Mobile
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: child!,
              ),
            );
          },
          home: const AuthGate(),
        );
      },
    );
  }
}

ThemeData _buildAppTheme() {
  final base = ThemeData.dark();
  // Sử dụng font offline đã khai báo trong pubspec.yaml
  final textTheme = base.textTheme.apply(fontFamily: 'Be Vietnam Pro');

  TextStyle? applySpacing(TextStyle? style) {
    if (style == null) return null;
    return style.copyWith(letterSpacing: (style.fontSize ?? 14.0) * 0.02);
  }

  final newTextTheme = textTheme.copyWith(
    displayLarge: applySpacing(textTheme.displayLarge),
    displayMedium: applySpacing(textTheme.displayMedium),
    displaySmall: applySpacing(textTheme.displaySmall),
    headlineLarge: applySpacing(textTheme.headlineLarge),
    headlineMedium: applySpacing(textTheme.headlineMedium),
    headlineSmall: applySpacing(textTheme.headlineSmall),
    titleLarge: applySpacing(textTheme.titleLarge),
    titleMedium: applySpacing(textTheme.titleMedium),
    titleSmall: applySpacing(textTheme.titleSmall),
    bodyLarge: applySpacing(textTheme.bodyLarge),
    bodyMedium: applySpacing(textTheme.bodyMedium),
    bodySmall: applySpacing(textTheme.bodySmall),
    labelLarge: applySpacing(textTheme.labelLarge),
    labelMedium: applySpacing(textTheme.labelMedium),
    labelSmall: applySpacing(textTheme.labelSmall),
  );

  return base.copyWith(
    textTheme: newTextTheme,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.white,
      onSecondary: Colors.black,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    indicatorColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Color(0xFF1F1F1F),
    ),
  );
}
