// lib/features/signals/screens/signal_screen.dart

import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/core/utils/signal_access_helper.dart';
import 'package:minvest_forex_app/features/auth/screens/settings_screen.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';
import 'package:minvest_forex_app/features/notifications/screens/notification_screen.dart';
import 'package:minvest_forex_app/features/signals/models/signal_model.dart';
import 'package:minvest_forex_app/features/signals/screens/signal_analyze_screen.dart';
import 'package:minvest_forex_app/features/signals/services/signal_service.dart';
import 'package:minvest_forex_app/features/signals/widgets/custom_filter_dropdown.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/services/price_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

enum AssetFilter { all, gold, crypto, forex }

class SignalScreen extends StatefulWidget {
  const SignalScreen({super.key});

  @override
  State<SignalScreen> createState() => _SignalScreenState();
}

class _SignalScreenState extends State<SignalScreen> {
  final PriceService _priceService = PriceService();
  final NumberFormat _currencyFormat =
      NumberFormat.currency(symbol: '\$', decimalDigits: 2);

  AssetFilter _assetFilter = AssetFilter.all;
  String _selectedTimezone = 'GMT+7';
  String? _expandedSymbol;

  String _selectedAppName = 'MT4';
  String _selectedAppIosUrl =
      'https://apps.apple.com/vn/app/metatrader-4/id496212596?l=vi';
  String _selectedAppAndroidUrl =
      'https://play.google.com/store/apps/details?id=net.metaquotes.metatrader4&hl=vi';
  String _selectedAppScheme = 'metatrader4://';
  String _selectedAppPackage = 'net.metaquotes.metatrader4';

  final List<String> _timezones = [
    'GMT-12',
    'GMT-11',
    'GMT-10',
    'GMT-9',
    'GMT-8',
    'GMT-7',
    'GMT-6',
    'GMT-5',
    'GMT-4',
    'GMT-3',
    'GMT-2',
    'GMT-1',
    'GMT+0',
    'GMT+1',
    'GMT+2',
    'GMT+3',
    'GMT+4',
    'GMT+5',
    'GMT+6',
    'GMT+7',
    'GMT+8',
    'GMT+9',
    'GMT+10',
    'GMT+11',
    'GMT+12'
  ];

  @override
  void initState() {
    super.initState();
    _priceService.connect();
  }

  @override
  void dispose() {
    _priceService.disconnect();
    super.dispose();
  }

  Future<void> _launchApp(String scheme, String iosUrl, String androidUrl,
      String packageName) async {
    final Uri storeUri = Uri.parse(Platform.isIOS ? iosUrl : androidUrl);

    try {
      if (Platform.isAndroid) {
        // Xử lý đặc biệt cho Axi vì có nhiều Package Name khác nhau
        if (packageName == 'com.lagom') {
          // Thử mở app chính (Axi Trading)
          try {
            await LaunchApp.openApp(
              androidPackageName: 'com.lagom',
              openStore: false, // Không mở store vội để thử mã tiếp theo
            );
            return; // Nếu mở thành công thì dừng
          } catch (_) {
            // Nếu không mở được com.lagom, thử sang com.axi.pelican (Axi Copy Trading)
            try {
              await LaunchApp.openApp(
                androidPackageName: 'com.axi.pelican',
                openStore: true, // Mã cuối cùng nên mở store nếu chưa cài
              );
              return;
            } catch (_) {}
          }
        }

        // Với các App khác dùng Package Name duy nhất
        await LaunchApp.openApp(
          androidPackageName: packageName,
          openStore: true,
        );
      } else {
        // iOS: Sử dụng LaunchApp với URL Scheme
        await LaunchApp.openApp(
          iosUrlScheme: scheme,
          appStoreLink: iosUrl,
          openStore: true,
        );
      }
    } catch (e) {
      await launchUrl(storeUri, mode: LaunchMode.externalApplication);
    }
  }

  void _showAppSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.12),
                  Colors.white.withValues(alpha: 0.04),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withValues(alpha: 0.2),
              ),
            ),
            child: SafeArea(
              bottom: true,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 20),
                      children: [
                        _buildAppOption(
                            context,
                            'MT4',
                            'metatrader4://',
                            'https://apps.apple.com/vn/app/metatrader-4/id496212596?l=vi',
                            'https://play.google.com/store/apps/details?id=net.metaquotes.metatrader4&hl=vi',
                            'assets/icons/mt4.png',
                            'net.metaquotes.metatrader4'),
                        _buildAppOption(
                            context,
                            'MT5',
                            'metatrader5://',
                            'https://apps.apple.com/vn/app/metatrader-5/id413251709?l=vi',
                            'https://play.google.com/store/apps/details?id=net.metaquotes.metatrader5&hl=vi',
                            'assets/icons/mt5.png',
                            'net.metaquotes.metatrader5'),
                        _buildAppOption(
                            context,
                            'Exness',
                            'exness://',
                            'https://apps.apple.com/vn/app/exness-trade-app-giao-d%E1%BB%8Bch/id1359763701?l=vi',
                            'https://play.google.com/store/apps/details?id=com.exness.android.pa&hl=vi',
                            'assets/icons/exness.png',
                            'com.exness.android.pa'),
                        _buildAppOption(
                            context,
                            'XM',
                            'xm://',
                            'https://apps.apple.com/vn/app/xm-app-giao-d%E1%BB%8Bch-th%E1%BA%ADt-t%E1%BB%B1-tin/id1072084799?l=vi',
                            'https://play.google.com/store/apps/details?id=com.xm.webapp&hl=vi',
                            'assets/icons/xm.png',
                            'com.xm.webapp'),
                        _buildAppOption(
                            context,
                            'Bybit',
                            'bybitapp://',
                            'https://apps.apple.com/vn/app/bybit-buy-bitcoin-trade-crypto/id1488296980?l=vi',
                            'https://play.google.com/store/apps/details?id=com.bybit.app&hl=vi',
                            'assets/icons/bybit.png',
                            'com.bybit.app'),
                        _buildAppOption(
                            context,
                            'Binance',
                            'bnc://',
                            'https://apps.apple.com/vn/app/binance-mua-bitcoin-crypto/id1436799971?l=vi',
                            'https://play.google.com/store/apps/details?id=com.binance.dev&hl=vi',
                            'assets/icons/binance.png',
                            'com.binance.dev'),
                        _buildAppOption(
                            context,
                            'LiteFinance',
                            'litefinance://',
                            'https://apps.apple.com/vn/app/litefinance/id1661254805?l=vi',
                            'https://play.google.com/store/apps/details?id=com.litefinance.cabinet&hl=vi',
                            'assets/icons/LiteFinance.png',
                            'com.litefinance.cabinet'),
                        _buildAppOption(
                            context,
                            'Axi',
                            'axi://',
                            'https://apps.apple.com/vn/app/axi-trading-platform/id1537332269?l=vi',
                            'https://play.google.com/store/apps/details?id=com.lagom&hl=vi',
                            'assets/icons/axi.png',
                            'com.lagom'),
                        _buildAppOption(
                            context,
                            'Vantagemarkets',
                            'vantage-trading://',
                            'https://apps.apple.com/vn/app/vantage-all-in-one-trading-app/id1457929724?l=vi',
                            'https://play.google.com/store/apps/details?id=cn.com.vau&hl=vi',
                            'assets/icons/vantagemarkets.png',
                            'cn.com.vau'),
                        _buildAppOption(
                            context,
                            'XTB',
                            'xstation://',
                            'https://apps.apple.com/vn/app/xtb-online-investing/id949905889?l=vi',
                            'https://play.google.com/store/apps/details?id=com.xtb.xmobile2&hl=vi',
                            'assets/icons/xtb.png',
                            'com.xtb.xmobile2'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppOption(BuildContext context, String name, String scheme,
      String iosUrl, String androidUrl, String iconPath, String packageName) {
    bool isSelected = _selectedAppName == name;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAppName = name;
          _selectedAppScheme = scheme;
          _selectedAppIosUrl = iosUrl;
          _selectedAppAndroidUrl = androidUrl;
          _selectedAppPackage = packageName;
        });
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                iconPath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.account_balance_wallet,
                    size: 14,
                    color: Colors.white54),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Container(
              width: 19,
              height: 19,
              decoration: ShapeDecoration(
                color: isSelected
                    ? const Color(0xFF276EFB)
                    : Colors.white.withValues(alpha: 0.1),
                shape: const OvalBorder(),
              ),
              child: Center(
                child: Container(
                  width: 11,
                  height: 11,
                  decoration: ShapeDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    shape: const OvalBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final l10n = AppLocalizations.of(context)!;

    final isElite = (userProvider.userTier ?? '').toLowerCase() == 'elite';
    final tokenBalance = userProvider.tokenBalance;
    final tokenText =
        isElite ? l10n.unlimited : l10n.freeSignalsCount(tokenBalance);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
        title: const Text(
          'Signal GPT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, notificationProvider, child) {
              final bool hasUnread = notificationProvider.unreadCount > 0;
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none,
                        size: 28, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()),
                      );
                    },
                  ),
                  if (hasUnread)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        height: 9,
                        width: 9,
                        decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                            border: Border.fromBorderSide(BorderSide(
                                color: Color(0xFF0D1117), width: 1.5))),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            // Tab bar (Assets / GMT) - Functional Filters
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Assets Filter
                  Expanded(
                    child: CustomFilterDropdown<AssetFilter>(
                      value: _assetFilter,
                      items: [
                        CustomDropdownItem(
                            value: AssetFilter.all, label: l10n.allAssets),
                        CustomDropdownItem(
                            value: AssetFilter.gold, label: l10n.assetGold),
                        CustomDropdownItem(
                            value: AssetFilter.crypto, label: l10n.assetCrypto),
                        CustomDropdownItem(
                            value: AssetFilter.forex, label: l10n.assetForex),
                      ],
                      onChanged: (value) {
                        if (value != null) setState(() => _assetFilter = value);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  // GMT Filter
                  Expanded(
                    child: CustomFilterDropdown<String>(
                      value: _selectedTimezone,
                      items: _timezones
                          .map((tz) => CustomDropdownItem(value: tz, label: tz))
                          .toList(),
                      onChanged: (value) {
                        if (value != null)
                          setState(() => _selectedTimezone = value);
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Dynamic Tokens Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(1), // Độ dày viền
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: LinearGradient(
                    begin: const Alignment(-1.0, -2.0),
                    end: const Alignment(1.0, 2.0),
                    colors: [
                      Colors.white.withValues(alpha: 0.6),
                      Colors.white.withValues(alpha: 0),
                      Colors.white.withValues(alpha: 0),
                      Colors.white.withValues(alpha: 0.8),
                    ],
                    stops: const [0.0, 0.07, 0.88, 1.0],
                  ),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161616),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.tokens,
                        style: const TextStyle(
                          color: Color(0xFF686868),
                          fontSize: 16,
                          fontFamily: 'Be Vietnam Pro',
                        ),
                      ),
                      Text(
                        tokenText,
                        style: const TextStyle(
                          color: Color(0xFF00BB32),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Be Vietnam Pro',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Asset List (Filtered Real-time Prices)
            Expanded(
              child: userProvider.role == 'guest'
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.lock_outline,
                                color: Color(0xFF0CA3ED), size: 64),
                            const SizedBox(height: 16),
                            const Text(
                              'Đăng nhập để xem tín hiệu',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Vui lòng đăng nhập tài khoản để xem tín hiệu Signal GPT và sử dụng đầy đủ tính năng.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF636363),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<AuthBloc>()
                                    .add(SignOutRequested());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0CA3ED),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Đăng nhập ngay',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    )
                  : StreamBuilder<Map<String, double>>(
                stream: _priceService.priceStream,
                initialData: const {'BTC': 0.0, 'ETH': 0.0, 'XAU': 0.0},
                builder: (context, snapshot) {
                  final prices = snapshot.data!;

                  // Filter list based on selected asset filter
                  List<Widget> assetWidgets = [];

                  if (_assetFilter == AssetFilter.all ||
                      _assetFilter == AssetFilter.gold) {
                    assetWidgets.add(_buildAssetItem(
                      symbol: 'XAUUSD',
                      price: prices['XAU'] ?? 0.0,
                      iconPath: 'assets/icons/XAUUSD.png',
                      color: const Color(0xFFFFAD00),
                      priceColor: const Color(0xFF197DFF),
                      userProvider: userProvider,
                      l10n: l10n,
                    ));
                  }

                  if (_assetFilter == AssetFilter.all ||
                      _assetFilter == AssetFilter.crypto) {
                    if (assetWidgets.isNotEmpty)
                      assetWidgets.add(const SizedBox(height: 12));
                    assetWidgets.add(_buildAssetItem(
                      symbol: 'BTC',
                      price: prices['BTC'] ?? 0.0,
                      iconPath: 'assets/icons/BTC.png',
                      color: const Color(0xFFFF8800),
                      priceColor: const Color(0xFF197DFF),
                      userProvider: userProvider,
                      l10n: l10n,
                    ));
                    assetWidgets.add(const SizedBox(height: 12));
                    assetWidgets.add(_buildAssetItem(
                      symbol: 'ETH',
                      price: prices['ETH'] ?? 0.0,
                      iconPath: 'assets/icons/ETH.png',
                      color: Colors.white,
                      priceColor: const Color(0xFFE39300),
                      userProvider: userProvider,
                      l10n: l10n,
                    ));
                  }

                  // Forex is empty for now as no symbols are being streamed
                  if (_assetFilter == AssetFilter.forex &&
                      assetWidgets.isEmpty) {
                    assetWidgets.add(Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(l10n.noForexAssets,
                            style: const TextStyle(color: Colors.white54)),
                      ),
                    ));
                  }

                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: assetWidgets,
                  );
                },
              ),
            ),

            // Open SELECTED APP Button
            Padding(
              padding: const EdgeInsets.only(
                  left: 24.0, right: 24.0, top: 24.0, bottom: 80.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0CA3ED), Color(0xFF276EFB)],
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                        width: 44), // Spacer to balance the right icon
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _launchApp(
                            _selectedAppScheme,
                            _selectedAppIosUrl,
                            _selectedAppAndroidUrl,
                            _selectedAppPackage),
                        behavior: HitTestBehavior.opaque,
                        child: Center(
                          child: Text(
                            l10n.openApp(_selectedAppName.toUpperCase()),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showAppSelection(context),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 44,
                        height: 50,
                        alignment: Alignment.center,
                        child: Container(
                          width: 23,
                          height: 24,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF4998FF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/home.png',
                              width: 22,
                              height: 22,
                              fit: BoxFit.contain,
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
      ),
    );
  }

  Widget _buildAssetItem({
    required String symbol,
    required double price,
    required String iconPath,
    required Color color,
    required Color priceColor,
    required UserProvider userProvider,
    required AppLocalizations l10n,
  }) {
    final bool isExpanded = _expandedSymbol == symbol;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _expandedSymbol = isExpanded ? null : symbol;
            });
          },
          child: Container(
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Row(
              children: [
                // Icon tròn bên trái
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Image.asset(
                    iconPath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.currency_exchange,
                        size: 16,
                        color: Colors.white70),
                  ),
                ),
                const SizedBox(width: 16),
                // Tên Symbol
                Flexible(
                  child: Text(
                    symbol,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Be Vietnam Pro',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Ô chỉ số giá
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    border: Border.all(color: priceColor, width: 1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    _currencyFormat.format(price),
                    style: TextStyle(
                      color: priceColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Be Vietnam Pro',
                    ),
                  ),
                ),
                const SizedBox(
                    width: 12), // Tăng từ 4px lên 12px để đồng bộ khoảng cách
                // Mũi tên nhỏ sát cạnh giá
                RotatedBox(
                  quarterTurns: isExpanded ? 2 : 0,
                  child: Image.asset(
                    'assets/icons/muiten.png',
                    width: 12, // Thu nhỏ mũi tên
                    height: 12,
                    color: const Color(0xFF276EFB),
                  ),
                ),
                const Spacer(),
                // Nút Load chỉ hiện khi mở rộng
                if (isExpanded)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // Logic load lại tín hiệu mới
                        _expandedSymbol = null;
                        Future.delayed(const Duration(milliseconds: 100), () {
                          setState(() {
                            _expandedSymbol = symbol;
                          });
                        });
                      });
                    },
                    child: Image.asset(
                      'assets/icons/load.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          SignalDetailExpandedView(
            symbol: symbol == 'XAUUSD'
                ? 'XAU/USD'
                : (symbol == 'BTC' ? 'BTC/USD' : 'ETH/USD'),
            userTier: userProvider.userTier ?? 'free',
            userProvider: userProvider,
            l10n: l10n,
          ),
      ],
    );
  }
}

class SignalDetailExpandedView extends StatefulWidget {
  final String symbol;
  final String userTier;
  final UserProvider userProvider;
  final AppLocalizations l10n;

  const SignalDetailExpandedView({
    super.key,
    required this.symbol,
    required this.userTier,
    required this.userProvider,
    required this.l10n,
  });

  @override
  State<SignalDetailExpandedView> createState() =>
      _SignalDetailExpandedViewState();
}

class _SignalDetailExpandedViewState extends State<SignalDetailExpandedView> {
  late final Stream<List<Signal>> _signalStream;
  final SignalService _signalService = SignalService();

  @override
  void initState() {
    super.initState();
    _signalStream = _signalService.getSignals(
      isLive: true,
      userTier: widget.userTier,
      symbol: widget.symbol,
      limit: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Signal>>(
      stream: _signalStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.redAccent, fontSize: 12),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Khi không có tín hiệu mới, tạo một placeholder để hiện lớp phủ mờ
          final dummySignal = Signal(
            id: 'placeholder',
            symbol: widget.symbol,
            type: 'buy',
            status: 'running',
            entryPrice: 0.0,
            stopLoss: 0.0,
            takeProfits: [],
            createdAt: Timestamp.now(),
            matchStatus: 'NOT MATCHED',
          );
          return Stack(
            alignment: Alignment.center,
            children: [
              _buildSignalDetails(dummySignal, widget.l10n),
              _buildBlurredOverlay(
                  context, dummySignal, widget.userProvider, false),
            ],
          );
        }

        final signal = snapshot.data!.first;

        // LOGIC MỚI: Luôn kiểm tra xem đã unlock chưa (dựa trên ID trong unlockedSignals)
        final bool isUnlocked =
            widget.userProvider.unlockedSignals.contains(signal.id);

        // Kiểm tra quyền miễn phí (Elite/Subscribed)
        final bool isEliteOrSubscribed = SignalAccessHelper.canViewEntry(
          signal,
          widget.userProvider.userTier,
          widget.userProvider.activeSubscriptions,
        );

        return Stack(
          alignment: Alignment.center,
          children: [
            _buildSignalDetails(signal, widget.l10n),
            if (!isUnlocked)
              _buildBlurredOverlay(
                  context, signal, widget.userProvider, isEliteOrSubscribed),
          ],
        );
      },
    );
  }

  Widget _buildSignalDetails(Signal signal, AppLocalizations l10n) {
    final bool isJustMatched =
        signal.status == 'running' && signal.isMatched && signal.hitTps.isEmpty;
    final Color statusColor =
        isJustMatched ? const Color(0xFF197DFF) : signal.getStatusColor();
    final bool isPlaceholder = signal.id == 'placeholder';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSignalInfoBox(
                label: l10n.signalStatus,
                value: isPlaceholder ? '-' : signal.getTranslatedResult(l10n),
                valueColor: isPlaceholder ? Colors.white54 : statusColor,
              ),
              _buildSignalInfoBox(
                label: l10n.signalEntryLabel,
                value: isPlaceholder
                    ? '-'
                    : signal.entryPrice
                        .toStringAsFixed(signal.symbol.contains('XAU') ? 2 : 5),
                valueColor: const Color(0xFF00BB32),
              ),
              _buildSignalInfoBox(
                label: l10n.signalSlLabel,
                value: isPlaceholder
                    ? '-'
                    : signal.stopLoss
                        .toStringAsFixed(signal.symbol.contains('XAU') ? 2 : 5),
                valueColor: const Color(0xFFE3001E),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSignalInfoBox(
                label: l10n.signalTp1Label,
                value: !isPlaceholder && signal.takeProfits.isNotEmpty
                    ? signal.takeProfits[0].toString()
                    : '-',
                valueColor: Colors.white,
              ),
              _buildSignalInfoBox(
                label: l10n.signalTp2Label,
                value: !isPlaceholder && signal.takeProfits.length > 1
                    ? signal.takeProfits[1].toString()
                    : '-',
                valueColor: Colors.white,
              ),
              _buildSignalInfoBox(
                label: l10n.signalTp3Label,
                value: !isPlaceholder && signal.takeProfits.length > 2
                    ? signal.takeProfits[2].toString()
                    : '-',
                valueColor: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignalAnalyzeScreen(signal: signal),
                ),
              );
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/analyze.png',
                        width: 24,
                        height: 24,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.analytics_outlined,
                          size: 24,
                          color: Color(0xFF636363),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        l10n.analyze,
                        style: const TextStyle(
                          color: Color(0xFF636363),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Be Vietnam Pro',
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Color(0xFF636363),
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurredOverlay(BuildContext context, Signal signal,
      UserProvider userProvider, bool isFreeUnlock) {
    final l10n = AppLocalizations.of(context)!;
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Dark base layer to kill text contrast while keeping it "glassy"
            Container(
              color: Colors.black.withValues(alpha: 0.7),
            ),
            // Brighter liquid blobs for visual distortion and aesthetics
            Positioned(
              top: -15,
              left: -15,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF276EFB).withValues(alpha: 0.25),
                      const Color(0xFF276EFB).withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -20,
              right: -20,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF00D2FF).withValues(alpha: 0.2),
                      const Color(0xFF00D2FF).withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.12),
                      Colors.white.withValues(alpha: 0.04),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        l10n.useTokenToView,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Be Vietnam Pro',
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (signal.id == 'placeholder') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.waitingNewSignals)),
                          );
                          return;
                        }
                        if (isFreeUnlock) {
                          await userProvider.unlockSignal(signal.id,
                              freeUnlock: true);
                        } else {
                          if (userProvider.tokenBalance > 0) {
                            final success = await userProvider
                                .unlockSignal(signal.id, freeUnlock: false);
                            if (!success && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(l10n.failedUnlockSignal)),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l10n.notEnoughTokens)),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF276EFB),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 14),
                        elevation: 12,
                        shadowColor:
                            const Color(0xFF276EFB).withValues(alpha: 0.6),
                      ),
                      child: Text(
                        l10n.viewNow,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Be Vietnam Pro'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Premium border detail
            IgnorePointer(
              child: CustomPaint(
                size: Size.infinite,
                painter: GradientPainter(
                  strokeWidth: 1.2,
                  radius: 12,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.5),
                      Colors.white.withValues(alpha: 0.05),
                      Colors.white.withValues(alpha: 0.05),
                      Colors.white.withValues(alpha: 0.4),
                    ],
                    stops: const [0.0, 0.2, 0.8, 1.0],
                  ),
                ),
                child: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignalInfoBox({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF686868),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Be Vietnam Pro',
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 107,
          height: 41,
          child: Container(
            padding: const EdgeInsets.all(1), // Độ dày viền 1px
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.6),
                  Colors.white.withValues(alpha: 0),
                  Colors.white.withValues(alpha: 0),
                  Colors.white.withValues(alpha: 0.7),
                ],
                stops: const [0.0, 0.12, 0.88, 1.0],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF161616),
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                    color: valueColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Be Vietnam Pro',
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GradientPainter extends CustomPainter {
  final double strokeWidth;
  final double radius;
  final Gradient gradient;

  GradientPainter(
      {required this.strokeWidth,
      required this.radius,
      required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
