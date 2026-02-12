// lib/features/signals/screens/signal_screen.dart

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:minvest_forex_app/core/providers/language_provider.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/core/utils/signal_access_helper.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/features/notifications/screens/notification_screen.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';
import 'package:minvest_forex_app/services/price_service.dart';
import 'package:minvest_forex_app/features/signals/models/signal_model.dart';
import 'package:minvest_forex_app/features/signals/screens/signal_analyze_screen.dart';
import 'package:minvest_forex_app/features/signals/services/signal_service.dart';
import 'package:minvest_forex_app/features/auth/screens/settings_screen.dart';
import 'package:minvest_forex_app/features/signals/widgets/custom_filter_dropdown.dart';
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
  final NumberFormat _currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
  
  AssetFilter _assetFilter = AssetFilter.all;
  String _selectedTimezone = 'GMT+7';
  String? _expandedSymbol;
  
  String _selectedAppName = 'Exness';
  String _selectedAppWebUrl = 'https://my.exmarkets.guide/accounts/sign-up/303589?utm_source=partners&ex_ol=1';
  String _selectedAppUrl = '';

  final List<String> _timezones = [
    'GMT+0', 'GMT+7', 'GMT+8'
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

  Future<void> _launchApp(String url, String webUrl) async {
    final Uri appUri = Uri.parse(url);
    final Uri webUri = Uri.parse(webUrl);
    try {
      if (await canLaunchUrl(appUri)) {
        await launchUrl(appUri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      }
    }
  }

  void _showAppSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.00, 0.78),
                end: const Alignment(1.00, 0.20),
                colors: [
                  const Color(0xFF1E1E1E).withValues(alpha: 0.9),
                  const Color(0xFF0D0D0D).withValues(alpha: 0.8)
                ],
              ),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.white10,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
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
                      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
                      children: [
                        _buildAppOption(context, 'BingX', 'https://bingx.com/invite/S6UV9A', '', 'assets/icons/bingx.png'),
                        _buildAppOption(context, 'Binance', 'https://www.binance.com/vi/register?ref=12345678', '', 'assets/icons/binance.png'),
                        _buildAppOption(context, 'Exness', 'https://my.exmarkets.guide/accounts/sign-up/303589?utm_source=partners&ex_ol=1', '', 'assets/icons/exness.png'),
                        _buildAppOption(context, 'ByBit', 'https://www.bybit.com/invite?ref=MINVEST', '', 'assets/icons/bybit.png'),
                        _buildAppOption(context, 'Bitget', 'https://www.bitget.com/expressly?languageType=0&channelCode=minvest&vipCode=minvest', '', 'assets/icons/bitget.png'),
                        _buildAppOption(context, 'MEXC', 'https://www.mexc.com/register?inviteCode=mexc-MINVEST', '', 'assets/icons/mexc.png'),
                        _buildAppOption(context, 'OKX', 'https://www.okx.com/join/minvest', '', 'assets/icons/okx.png'),
                        _buildAppOption(context, 'MT4', 'https://metatrader4.com', '', 'assets/icons/mt4.png'),
                        _buildAppOption(context, 'MT5', 'https://metatrader5.com', '', 'assets/icons/mt5.png'),
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

  Widget _buildAppOption(BuildContext context, String name, String webUrl, String appUrl, String iconPath) {
    bool isSelected = _selectedAppName == name;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAppName = name;
          _selectedAppWebUrl = webUrl;
          _selectedAppUrl = appUrl;
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
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.account_balance_wallet, size: 14, color: Colors.white54),
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
                color: isSelected ? const Color(0xFF276EFB) : Colors.white.withValues(alpha: 0.1),
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

  String _getAssetLabel(AssetFilter filter, AppLocalizations l10n) {
    switch (filter) {
      case AssetFilter.all:
        return l10n.allAssets;
      case AssetFilter.gold:
        return 'Gold';
      case AssetFilter.crypto:
        return 'Crypto';
      case AssetFilter.forex:
        return 'Forex';
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final l10n = AppLocalizations.of(context)!;
    
    final isElite = (userProvider.userTier ?? '').toLowerCase() == 'elite';
    final tokenBalance = userProvider.tokenBalance;
    final tokenText = isElite ? l10n.unlimited : l10n.freeSignalsCount(tokenBalance);

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
                    icon: const Icon(Icons.notifications_none, size: 28, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NotificationScreen()),
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
                            border: Border.fromBorderSide(BorderSide(color: Color(0xFF0D1117), width: 1.5))
                        ),
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
                        CustomDropdownItem(value: AssetFilter.all, label: l10n.allAssets),
                        CustomDropdownItem(value: AssetFilter.gold, label: 'Gold'),
                        CustomDropdownItem(value: AssetFilter.crypto, label: 'Crypto'),
                        CustomDropdownItem(value: AssetFilter.forex, label: 'Forex'),
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
                      items: _timezones.map((tz) => CustomDropdownItem(value: tz, label: tz)).toList(),
                      onChanged: (value) {
                        if (value != null) setState(() => _selectedTimezone = value);
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.00, 1.00),
                    end: const Alignment(1.00, 0.12),
                    colors: [
                      Colors.white.withValues(alpha: 0.15),
                      Colors.white.withValues(alpha: 0.05)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tokens',
                      style: TextStyle(color: Color(0xFF686868), fontSize: 16),
                    ),
                    Text(
                      tokenText,
                      style: const TextStyle(color: Color(0xFF00BB32), fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),

            // Asset List (Filtered Real-time Prices)
            Expanded(
              child: StreamBuilder<Map<String, double>>(
                stream: _priceService.priceStream,
                initialData: const {'BTC': 0.0, 'ETH': 0.0, 'XAU': 0.0},
                builder: (context, snapshot) {
                  final prices = snapshot.data!;
                  
                  // Filter list based on selected asset filter
                  List<Widget> assetWidgets = [];
                  
                  if (_assetFilter == AssetFilter.all || _assetFilter == AssetFilter.gold) {
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
                  
                  if (_assetFilter == AssetFilter.all || _assetFilter == AssetFilter.crypto) {
                    if (assetWidgets.isNotEmpty) assetWidgets.add(const SizedBox(height: 12));
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
                  if (_assetFilter == AssetFilter.forex && assetWidgets.isEmpty) {
                    assetWidgets.add(const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Text('No Forex assets available', style: TextStyle(color: Colors.white54)),
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
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0, bottom: 85.0),
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
                    const SizedBox(width: 44), // Spacer to balance the right icon
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _launchApp(_selectedAppUrl, _selectedAppWebUrl),
                        behavior: HitTestBehavior.opaque,
                        child: Center(
                          child: Text(
                            'Open ${_selectedAppName.toUpperCase()}',
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
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.black,
              border: Border(bottom: BorderSide(color: Color(0xFF1E1E1E))),
            ),
            child: Row(
              children: [
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
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.currency_exchange, size: 16, color: Colors.white70),
                  ),
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Text(
                      symbol,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: const Color(0xFF276EFB),
                      size: 20,
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: priceColor),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    _currencyFormat.format(price),
                    style: TextStyle(
                      color: priceColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          SignalDetailExpandedView(
            symbol: symbol == 'XAUUSD' ? 'XAU/USD' : (symbol == 'BTC' ? 'BTC/USD' : 'ETH/USD'),
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
  State<SignalDetailExpandedView> createState() => _SignalDetailExpandedViewState();
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Text(widget.l10n.noSignalsAvailable, style: const TextStyle(color: Colors.white54))),
          );
        }

        final signal = snapshot.data!.first;
        
        // LOGIC MỚI: Luôn kiểm tra xem đã unlock chưa (dựa trên ID trong unlockedSignals)
        // Thay vì chỉ kiểm tra quyền (canViewEntry)
        final bool isUnlocked = widget.userProvider.unlockedSignals.contains(signal.id);
        
        // Kiểm tra quyền miễn phí (Elite/Subscribed)
        final bool isEliteOrSubscribed = SignalAccessHelper.canViewEntry(
          signal,
          widget.userProvider.userTier,
          widget.userProvider.activeSubscriptions,
          // Không truyền unlockedSignals vào đây vì ta muốn kiểm tra quyền "gốc"
        );

        return Stack(
          alignment: Alignment.center,
          children: [
            _buildSignalDetails(signal, widget.l10n),
            if (!isUnlocked)
              _buildBlurredOverlay(context, signal, widget.userProvider, isEliteOrSubscribed),
          ],
        );
      },
    );
  }

  Widget _buildSignalDetails(Signal signal, AppLocalizations l10n) {
    // Xác định màu sắc cho Status: Nếu là Matched (và chưa hit TP) thì dùng xanh dương
    final bool isJustMatched = signal.status == 'running' && signal.isMatched && signal.hitTps.isEmpty;
    final Color statusColor = isJustMatched ? const Color(0xFF197DFF) : signal.getStatusColor();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSignalInfoBox(
                label: 'Status',
                value: signal.getTranslatedResult(l10n),
                valueColor: statusColor,
              ),
              _buildSignalInfoBox(
                label: 'ENTRY',
                value: signal.entryPrice.toStringAsFixed(signal.symbol.contains('XAU') ? 2 : 5),
                valueColor: const Color(0xFF00BB32),
              ),
              _buildSignalInfoBox(
                label: 'SL',
                value: signal.stopLoss.toStringAsFixed(signal.symbol.contains('XAU') ? 2 : 5),
                valueColor: const Color(0xFFE3001E),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSignalInfoBox(
                label: 'TP1',
                value: signal.takeProfits.isNotEmpty ? signal.takeProfits[0].toString() : '-',
                valueColor: Colors.white,
              ),
              _buildSignalInfoBox(
                label: 'TP2',
                value: signal.takeProfits.length > 1 ? signal.takeProfits[1].toString() : '-',
                valueColor: Colors.white,
              ),
              _buildSignalInfoBox(
                label: 'TP3',
                value: signal.takeProfits.length > 2 ? signal.takeProfits[2].toString() : '-',
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
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // Thêm vertical padding cho dễ bấm
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/analyze.png',
                        width: 24,
                        height: 24,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.analytics_outlined,
                          size: 24,
                          color: Color(0xFF636363),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Analyze',
                        style: TextStyle(
                          color: Color(0xFF636363),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Reddit Sans',
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

  Widget _buildBlurredOverlay(BuildContext context, Signal signal, UserProvider userProvider, bool isFreeUnlock) {
    return Container(
      width: double.infinity,
      height: 210, // Tăng chiều cao
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: const Alignment(-0.00, 1.00),
                end: const Alignment(1.09, -0.05),
                colors: [
                  Colors.black.withValues(alpha: 0.25), // Tăng độ trong suốt (giảm alpha)
                  Colors.black.withValues(alpha: 0.05),
                ],
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'Use Token to view Signal', // Luôn hiển thị dòng chữ này
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (isFreeUnlock) {
                      await userProvider.unlockSignal(signal.id, freeUnlock: true);
                    } else {
                      if (userProvider.tokenBalance > 0) {
                        final success = await userProvider.unlockSignal(signal.id, freeUnlock: false);
                        if (!success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Failed to unlock signal')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Not enough tokens')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF276EFB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  ),
                  child: const Text(
                    'View Now',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
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
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 107,
          height: 41,
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0.00, 1.00),
              end: const Alignment(1.00, 0.12),
              colors: [
                const Color(0xFF1E1E1E).withValues(alpha: 0.9),
                const Color(0xFF1E1E1E).withValues(alpha: 0.6),
              ],
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Colors.white.withValues(alpha: 0.15),
              ),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: valueColor,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class _LanguageSwitcher extends StatelessWidget {
  const _LanguageSwitcher();

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    return PopupMenuButton<Locale>(
      onSelected: (Locale locale) => languageProvider.setLocale(locale),
      itemBuilder: (context) => [
        const PopupMenuItem(value: Locale('en'), child: Text('English')),
        const PopupMenuItem(value: Locale('vi'), child: Text('Tiếng Việt')),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, provider, child) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.asset(
              provider.locale?.languageCode == 'vi'
                  ? 'assets/images/vn_flag.png'
                  : 'assets/images/us_flag.png',
              height: 24,
              width: 36,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
