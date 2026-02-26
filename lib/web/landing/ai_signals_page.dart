import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minvest_forex_app/features/signals/models/signal_model.dart';
import 'package:minvest_forex_app/features/signals/screens/signal_detail_screen_web.dart' as web_detail;
import 'package:minvest_forex_app/features/signals/services/signal_service.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/spacing.dart';
import '../theme/gradients.dart';
import 'widgets/navbar.dart';
import 'sections/footer_section.dart';
import 'sections/pricing_tab.dart';
import 'package:minvest_forex_app/core/utils/signal_access_helper.dart';
import 'package:minvest_forex_app/web/theme/breakpoints.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:minvest_forex_app/web/widgets/signal_history_table.dart';

enum AISignalsTab { aiSignals, performance, history, pricing }
enum AssetFilter { all, gold, crypto, forex }

class AISignalsPage extends StatefulWidget {
  const AISignalsPage({super.key});

  @override
  State<AISignalsPage> createState() => _AISignalsPageState();
}

class _AISignalsPageState extends State<AISignalsPage> {
  AISignalsTab selectedTab = AISignalsTab.aiSignals;
  AssetFilter _assetFilter = AssetFilter.all;
  String _selectedCommodity = 'All Commodities';
  String _selectedTimezone = 'GMT+7'; // Default for Vietnam context
  String _selectedStatus = 'ALL';
  DateTimeRange? _dateRange;

  final List<String> _allCommodities = [
    'XAU/USD',
    'EUR/USD', 'GBP/USD', 'USD/JPY', 'USD/CHF', 
    'AUD/USD', 'USD/CAD', 'NZD/USD',
    'ETH/USDT', 'BTC/USDT'
  ];

  final List<String> _statusOptions = [
    'ALL',
    'TP1',
    'TP2',
    'TP3',
    'SL',
    'CANCELLED',
    'EXIT',
  ];

  List<String> get _currentCommodities {
    switch (_assetFilter) {
      case AssetFilter.gold:
        return ['XAU/USD'];
      case AssetFilter.forex:
        return [
          'All Currency Pairs',
          'EUR/USD', 'GBP/USD', 'USD/JPY', 'USD/CHF', 
          'AUD/USD', 'USD/CAD', 'NZD/USD',
          'EUR/GBP', 'EUR/JPY', 'GBP/JPY', 'AUD/JPY'
        ];
      case AssetFilter.crypto:
        return [
          'All Crypto Pairs',
          'ETH/USDT', 'BTC/USDT'
        ];
      case AssetFilter.all:
      default:
        return ['All Commodities', ..._allCommodities];
    }
  }

  void _onAssetFilterChanged(AssetFilter value) {
    setState(() {
      _assetFilter = value;
      // Reset selected commodity based on new filter
      if (value == AssetFilter.gold) {
        _selectedCommodity = 'XAU/USD';
      } else if (value == AssetFilter.forex) {
        _selectedCommodity = 'All Currency Pairs';
      } else if (value == AssetFilter.crypto) {
        _selectedCommodity = 'All Crypto Pairs';
      } else {
        _selectedCommodity = 'All Commodities';
      }
    });
  }

  final List<String> _timezones = [
    for (int i = -12; i <= 14; i++) 'GMT${i >= 0 ? '+' : ''}$i',
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: isMobile ? const TextScaler.linear(0.9) : const TextScaler.linear(1.0),
            ),
            child: Scaffold(        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8), // Giảm từ 16 xuống 8
                    child: LandingNavBar(),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8), // Giảm từ 16 xuống 8
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _TitleSection(isMobile: isMobile),
                        const SizedBox(height: 24),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: _TabBar(
                                  selected: selectedTab,
                                  onSelect: (tab) {
                                    setState(() => selectedTab = tab);
                                  },
                                ),
                              ),
                            ),
                            if (!isMobile && FirebaseAuth.instance.currentUser != null)
                               const _UserSubscriptionStatus(),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: Colors.white, thickness: 1.2),
                        const SizedBox(height: 24),
                        if (selectedTab == AISignalsTab.aiSignals || selectedTab == AISignalsTab.history) ...[
                          _FiltersRow(
                            assetFilter: _assetFilter,
                            selectedPair: _selectedCommodity,
                            selectedTimezone: _selectedTimezone,
                            selectedStatus: _selectedStatus,
                            dateRange: _dateRange,
                            availablePairs: _currentCommodities,
                            availableTimezones: _timezones,
                            availableStatuses: _statusOptions,
                            onAssetChanged: _onAssetFilterChanged,
                            onPairChanged: (value) => setState(() => _selectedCommodity = value),
                            onTimezoneChanged: (value) => setState(() => _selectedTimezone = value),
                            onStatusChanged: (value) => setState(() => _selectedStatus = value),
                            onDateRangeChanged: (value) => setState(() => _dateRange = value),
                            showBanner: selectedTab == AISignalsTab.aiSignals,
                          ),
                          const SizedBox(height: 32),
                        ],
                        if (selectedTab == AISignalsTab.aiSignals) ...[
                          _SignalGridLive(
                            assetFilter: _assetFilter,
                            selectedPair: _selectedCommodity,
                            selectedTimezone: _selectedTimezone,
                            selectedStatus: _selectedStatus,
                            dateRange: _dateRange,
                          ),
                        ] else if (selectedTab == AISignalsTab.performance) ...[
                          _PerformanceSection(
                            assetFilter: AssetFilter.all, // Always show All Assets
                            selectedPair: 'All Commodities', // Always show All Pairs
                            selectedTimezone: _selectedTimezone,
                            dateRange: null, // Ignore parent date range, use internal time filter
                          ),
                        ] else if (selectedTab == AISignalsTab.history) ...[
                          _HistorySection(
                            assetFilter: _assetFilter,
                            selectedPair: _selectedCommodity,
                            selectedTimezone: _selectedTimezone,
                            selectedStatus: _selectedStatus,
                            dateRange: _dateRange,
                          ),
                        ] else ...const [
                          PricingTab(),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  final bool isMobile;
  const _TitleSection({this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final title = Text(
      AppLocalizations.of(context)!.aiSignal,
      textAlign: TextAlign.center,
      style: AppTextStyles.h1.copyWith(
        fontSize: isMobile ? 28 : 34,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: isMobile ? -1 : null,
      ),
    );

    if (isMobile) {
      return Center(child: title);
    }

    return title;
  }
}

class _TabBar extends StatelessWidget {
  final AISignalsTab selected;
  final ValueChanged<AISignalsTab> onSelect;
  const _TabBar({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    if (isMobile) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _TabChip(
                  label: AppLocalizations.of(context)!.aiSignal,
                  isActive: selected == AISignalsTab.aiSignals,
                  onTap: () => onSelect(AISignalsTab.aiSignals),
                  isMobile: true,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _TabChip(
                  label: AppLocalizations.of(context)!.performance,
                  isActive: selected == AISignalsTab.performance,
                  onTap: () => onSelect(AISignalsTab.performance),
                  isMobile: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: _TabChip(
                  label: AppLocalizations.of(context)!.history,
                  isActive: selected == AISignalsTab.history,
                  onTap: () => onSelect(AISignalsTab.history),
                  isMobile: true,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _TabChip(
                  label: AppLocalizations.of(context)!.pricing,
                  isActive: selected == AISignalsTab.pricing,
                  onTap: () => onSelect(AISignalsTab.pricing),
                  isMobile: true,
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _TabChip(
          label: AppLocalizations.of(context)!.aiSignal,
          isActive: selected == AISignalsTab.aiSignals,
          onTap: () => onSelect(AISignalsTab.aiSignals),
          isMobile: isMobile,
        ),
        _TabChip(
          label: AppLocalizations.of(context)!.performance,
          isActive: selected == AISignalsTab.performance,
          onTap: () => onSelect(AISignalsTab.performance),
          isMobile: isMobile,
        ),
        _TabChip(
          label: AppLocalizations.of(context)!.history,
          isActive: selected == AISignalsTab.history,
          onTap: () => onSelect(AISignalsTab.history),
          isMobile: isMobile,
        ),
        _TabChip(
          label: AppLocalizations.of(context)!.pricing,
          isActive: selected == AISignalsTab.pricing,
          onTap: () => onSelect(AISignalsTab.pricing),
          isMobile: isMobile,
        ),
      ],
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool isMobile;
  const _TabChip({
    required this.label, 
    required this.isActive, 
    required this.onTap,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isMobile ? null : 136,
        height: isMobile ? 35 : 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), // Tăng nhẹ radius cho cân đối
          gradient: isActive 
              ? const LinearGradient(
                  colors: [Color(0xFFD500F9), Color(0xFF2E60FF), Color(0xFF04B3E9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isActive ? null : Colors.transparent,
          boxShadow: isActive ? const [
            BoxShadow(
              color: Color(0x3F2E60FF),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ] : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.body.copyWith(
            color: Colors.white,
            fontSize: isMobile ? 16 : 18,
            fontWeight: FontWeight.w600,
            letterSpacing: isMobile ? -0.6 : null,
          ),
        ),
      ),
    );
  }
}

class _FiltersRow extends StatelessWidget {
  final AssetFilter assetFilter;
  final String selectedPair;
  final String selectedTimezone;
  final String selectedStatus;
  final DateTimeRange? dateRange;
  final List<String> availablePairs;
  final List<String> availableTimezones;
  final List<String> availableStatuses;
  final ValueChanged<AssetFilter> onAssetChanged;
  final ValueChanged<String> onPairChanged;
  final ValueChanged<String> onTimezoneChanged;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<DateTimeRange?> onDateRangeChanged;
  final bool showBanner;

  const _FiltersRow({
    required this.assetFilter,
    required this.selectedPair,
    required this.selectedTimezone,
    required this.selectedStatus,
    required this.dateRange,
    required this.availablePairs,
    required this.availableTimezones,
    required this.availableStatuses,
    required this.onAssetChanged,
    required this.onPairChanged,
    required this.onTimezoneChanged,
    required this.onStatusChanged,
    required this.onDateRangeChanged,
    this.showBanner = false,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;
    final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;

    if (isMobile) {
      if (isLoggedIn) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hàng 1: Asset & Orders
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Asset'),
                      const SizedBox(height: 4),
                      _AssetDropdown(value: assetFilter, onChanged: onAssetChanged, isMobile: true, height: 32),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Orders'),
                      const SizedBox(height: 4),
                      _PairDropdown(label: '', value: selectedPair, items: availablePairs, onChanged: onPairChanged, isMobile: true, height: 32),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Hàng 2: Date Range, Status, Time
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Date Range'),
                      const SizedBox(height: 4),
                      _DateRangePicker(dateRange: dateRange, onChanged: onDateRangeChanged, isMobile: true, height: 32),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Status'),
                      const SizedBox(height: 4),
                      _StatusDropdown(value: selectedStatus, items: availableStatuses, onChanged: onStatusChanged, isMobile: true, height: 32),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Time'),
                      const SizedBox(height: 4),
                      _TimezoneDropdown(value: selectedTimezone, items: availableTimezones, onChanged: onTimezoneChanged, isMobile: true, height: 32),
                    ],
                  ),
                ),
              ],
            ),
            if (showBanner) ...[
              const SizedBox(height: 20),
              _freeSignalsBanner(context),
            ],
          ],
        );
      }

      // Giao diện cho người dùng CHƯA đăng nhập (giữ nguyên như yêu cầu)
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _AssetDropdown(
                  value: assetFilter,
                  onChanged: onAssetChanged,
                  isMobile: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _PairDropdown(
                  label: AppLocalizations.of(context)!.currencyPairs,
                  value: selectedPair,
                  items: availablePairs,
                  onChanged: onPairChanged,
                  isMobile: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _DateRangePicker(
                  dateRange: dateRange,
                  onChanged: onDateRangeChanged,
                  isMobile: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _TimezoneDropdown(
                  value: selectedTimezone,
                  items: availableTimezones,
                  onChanged: onTimezoneChanged,
                  isMobile: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _StatusDropdown(
            value: selectedStatus,
            items: availableStatuses,
            onChanged: onStatusChanged,
            isMobile: true,
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 3,
          child: _AssetDropdown(
            value: assetFilter,
            onChanged: onAssetChanged,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: _PairDropdown(
            label: AppLocalizations.of(context)!.currencyPairs,
            value: selectedPair,
            items: availablePairs,
            onChanged: onPairChanged,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: _DateRangePicker(
            dateRange: dateRange,
            onChanged: onDateRangeChanged,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: _TimezoneDropdown(
            value: selectedTimezone,
            items: availableTimezones,
            onChanged: onTimezoneChanged,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: _StatusDropdown(
            value: selectedStatus,
            items: availableStatuses,
            onChanged: onStatusChanged,
          ),
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontFamily: 'Be Vietnam Pro',
        fontWeight: FontWeight.w600,
        letterSpacing: -0.60,
      ),
    );
  }

  Widget _freeSignalsBanner(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final l10n = AppLocalizations.of(context)!;
    
    final isElite = (userProvider.userTier ?? '').toLowerCase() == 'elite';
    final tokenBalance = userProvider.tokenBalance;

    // Sử dụng đúng các chuỗi localization như trên Desktop
    String text = isElite ? l10n.unlimited : l10n.freeSignalsCount(tokenBalance);

    return Container(
      width: double.infinity,
      height: 32,
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF474747)),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFF3BFF00),
          fontSize: 18,
          fontFamily: 'Be Vietnam Pro',
          fontWeight: FontWeight.w600,
          letterSpacing: -0.90,
        ),
      ),
    );
  }
}

class _PairDropdown extends StatefulWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final bool isMobile;
  final double? height;

  const _PairDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isMobile = false,
    this.height,
  });

  @override
  State<_PairDropdown> createState() => _PairDropdownState();
}

class _PairDropdownState extends State<_PairDropdown> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.isMobile && widget.label.isNotEmpty) ...[
          Text(
            widget.label,
            style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(height: 8),
        ],
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: Container(
            width: double.infinity,
            height: widget.height ?? 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(widget.isMobile ? 2 : 8),
              border: Border.all(color: _isHovered ? const Color(0xFF289EFF) : const Color(0xFF474747)),
            ),
            child: DropdownButtonHideUnderline(
              child: Theme(
                data: Theme.of(context).copyWith(
                  hoverColor: const Color(0xFF289EFF),
                ),
                child: DropdownButton<String>(
                  value: widget.items.contains(widget.value) ? widget.value : widget.items.first,
                  dropdownColor: const Color(0xFF0D0D0D),
                  focusColor: Colors.transparent,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 18),
                  style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14),
                  isExpanded: true,
                  menuMaxHeight: 500,
                  itemHeight: 48,
                  selectedItemBuilder: (context) {
                    return widget.items.map((pair) {
                      String display = pair;
                      if (pair == 'All Commodities') display = AppLocalizations.of(context)!.allCommodities;
                      else if (pair == 'All Currency Pairs') display = AppLocalizations.of(context)!.allCurrencyPairs;
                      else if (pair == 'All Crypto Pairs') display = AppLocalizations.of(context)!.allCryptoPairs;
                      return Align(alignment: Alignment.centerLeft, child: Text(display, overflow: TextOverflow.ellipsis));
                    }).toList();
                  },
                  items: widget.items.map((pair) {
                    final isSelected = widget.value == pair;
                    String display = pair;
                    if (pair == 'All Commodities') display = AppLocalizations.of(context)!.allCommodities;
                    else if (pair == 'All Currency Pairs') display = AppLocalizations.of(context)!.allCurrencyPairs;
                    else if (pair == 'All Crypto Pairs') display = AppLocalizations.of(context)!.allCryptoPairs;

                    return DropdownMenuItem<String>(
                      value: pair,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.white, width: 0.5)),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            if (isSelected)
                              Positioned.fill(
                                left: -16,
                                right: -16,
                                child: Container(color: const Color(0xFF289EFF)),
                              ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                display,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) widget.onChanged(v);
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TimezoneDropdown extends StatefulWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final bool isMobile;
  final double? height;

  const _TimezoneDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    this.isMobile = false,
    this.height,
  });

  @override
  State<_TimezoneDropdown> createState() => _TimezoneDropdownState();
}

class _TimezoneDropdownState extends State<_TimezoneDropdown> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.isMobile) ...[
          Text(
            AppLocalizations.of(context)!.timeGmt7, // Reusing key or create 'Timezone'
            style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(height: 8),
        ],
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: Container(
            width: double.infinity,
            height: widget.height ?? 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(widget.isMobile ? 2 : 8),
              border: Border.all(color: _isHovered ? const Color(0xFF289EFF) : const Color(0xFF3F3F3F)),
            ),
            child: DropdownButtonHideUnderline(
              child: Theme(
                data: Theme.of(context).copyWith(
                  hoverColor: const Color(0xFF289EFF),
                ),
                child: DropdownButton<String>(
                  value: widget.items.contains(widget.value) ? widget.value : widget.items.first,
                  dropdownColor: const Color(0xFF0D0D0D),
                  focusColor: Colors.transparent,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 18),
                  style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14),
                  isExpanded: true,
                  menuMaxHeight: 500,
                  itemHeight: 48,
                  selectedItemBuilder: (context) {
                    return widget.items.map((tz) => Align(alignment: Alignment.centerLeft, child: Text(tz))).toList();
                  },
                  items: widget.items.map((tz) {
                    final isSelected = widget.value == tz;
                    return DropdownMenuItem<String>(
                      value: tz,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.white, width: 0.5)),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            if (isSelected)
                              Positioned.fill(
                                left: -16,
                                right: -16,
                                child: Container(color: const Color(0xFF289EFF)),
                              ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                tz,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) widget.onChanged(v);
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusDropdown extends StatefulWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final bool isMobile;
  final double? height;

  const _StatusDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    this.isMobile = false,
    this.height,
  });

  @override
  State<_StatusDropdown> createState() => _StatusDropdownState();
}

class _StatusDropdownState extends State<_StatusDropdown> {
  bool _isHovered = false;

  String _getLocalizedStatus(BuildContext context, String code) {
    final l10n = AppLocalizations.of(context)!;
    switch (code) {
      case 'ALL': return l10n.filterStatusAll;
      case 'TP1': return l10n.filterStatusTp1;
      case 'TP2': return l10n.filterStatusTp2;
      case 'TP3': return l10n.filterStatusTp3;
      case 'SL': return l10n.filterStatusSl;
      case 'CANCELLED': return l10n.filterStatusCancelled;
      case 'EXIT': return l10n.filterStatusExitByAdmin;
      default: return code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.isMobile) ...[
          Text(
            AppLocalizations.of(context)!.filterStatusLabel,
            style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(height: 8),
        ],
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: Container(
            width: double.infinity,
            height: widget.height ?? 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(widget.isMobile ? 2 : 8),
              border: Border.all(color: _isHovered ? const Color(0xFF289EFF) : const Color(0xFF3F3F3F)),
            ),
            child: DropdownButtonHideUnderline(
              child: Theme(
                data: Theme.of(context).copyWith(
                  hoverColor: const Color(0xFF289EFF),
                ),
                child: DropdownButton<String>(
                  value: widget.items.contains(widget.value) ? widget.value : widget.items.first,
                  dropdownColor: const Color(0xFF0D0D0D),
                  focusColor: Colors.transparent,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 18),
                  style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14),
                  isExpanded: true,
                  menuMaxHeight: 500,
                  itemHeight: 48,
                  selectedItemBuilder: (context) {
                    return widget.items.map((code) => Align(alignment: Alignment.centerLeft, child: Text(_getLocalizedStatus(context, code), overflow: TextOverflow.ellipsis))).toList();
                  },
                  items: widget.items.map((code) {
                    final isSelected = widget.value == code;
                    final display = _getLocalizedStatus(context, code);
                    return DropdownMenuItem<String>(
                      value: code,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.white, width: 0.5)),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            if (isSelected)
                              Positioned.fill(
                                left: -16,
                                right: -16,
                                child: Container(color: const Color(0xFF289EFF)),
                              ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                display,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) widget.onChanged(v);
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AssetDropdown extends StatefulWidget {
  final AssetFilter value;
  final ValueChanged<AssetFilter> onChanged;
  final bool isMobile;
  final double? height;

  const _AssetDropdown({
    required this.value,
    required this.onChanged,
    this.isMobile = false,
    this.height,
  });

  @override
  State<_AssetDropdown> createState() => _AssetDropdownState();
}

class _AssetDropdownState extends State<_AssetDropdown> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.isMobile) ...[
          Text(
            AppLocalizations.of(context)!.asset,
            style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(height: 8),
        ],
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: Container(
            width: double.infinity,
            height: widget.height ?? 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(widget.isMobile ? 2 : 8),
              border: Border.all(color: _isHovered ? const Color(0xFF289EFF) : const Color(0xFF474747)),
            ),
            child: DropdownButtonHideUnderline(
              child: Theme(
                data: Theme.of(context).copyWith(
                  hoverColor: const Color(0xFF289EFF),
                ),
                child: DropdownButton<AssetFilter>(
                  value: widget.value,
                  dropdownColor: const Color(0xFF0D0D0D),
                  focusColor: Colors.transparent,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 18),
                  style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14),
                  menuMaxHeight: 500,
                  itemHeight: 48,
                  selectedItemBuilder: (context) {
                    return [AssetFilter.all, AssetFilter.gold, AssetFilter.crypto, AssetFilter.forex].map((val) {
                      String label = '';
                      if (val == AssetFilter.all) label = AppLocalizations.of(context)!.allAssets;
                      else if (val == AssetFilter.gold) label = 'Gold';
                      else if (val == AssetFilter.crypto) label = 'Crypto';
                      else if (val == AssetFilter.forex) label = 'Forex';
                      return Align(alignment: Alignment.centerLeft, child: Text(label));
                    }).toList();
                  },
                  items: [
                    AssetFilter.all,
                    AssetFilter.gold,
                    AssetFilter.crypto,
                    AssetFilter.forex,
                  ].map((val) {
                    final isSelected = widget.value == val;
                    String label = '';
                    if (val == AssetFilter.all) label = AppLocalizations.of(context)!.allAssets;
                    else if (val == AssetFilter.gold) label = 'Gold';
                    else if (val == AssetFilter.crypto) label = 'Crypto';
                    else if (val == AssetFilter.forex) label = 'Forex';

                    return DropdownMenuItem<AssetFilter>(
                      value: val,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.white, width: 0.5)),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            if (isSelected)
                              Positioned.fill(
                                left: -16,
                                right: -16,
                                child: Container(color: const Color(0xFF289EFF)),
                              ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                label,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) widget.onChanged(v);
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DateRangePicker extends StatefulWidget {
  final DateTimeRange? dateRange;
  final ValueChanged<DateTimeRange?> onChanged;
  final bool isMobile;
  final double? height;

  const _DateRangePicker({
    required this.dateRange,
    required this.onChanged,
    this.isMobile = false,
    this.height,
  });

  @override
  State<_DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<_DateRangePicker> {
  final GlobalKey _key = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  bool _isHovered = false;

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final overlay = Overlay.of(context);
    
    // Calculate position: below the input field
    final top = offset.dy + size.height + 8; // 8px spacing
    final left = offset.dx;

    // Adjust width for mobile if needed, or stick to default 320
    final dropdownWidth = 320.0;
    
    // Adjust left position if it goes off screen (simple check)
    double actualLeft = left;
    final screenWidth = MediaQuery.of(context).size.width;
    if (actualLeft + dropdownWidth > screenWidth) {
        actualLeft = screenWidth - dropdownWidth - 16; // 16px padding
    }

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: _closeDropdown,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
            Positioned(
              top: top,
              left: actualLeft,
              width: dropdownWidth,
              child: _DateRangeDropdownContent(
                initialRange: widget.dateRange,
                onRangeSelected: (range) {
                  widget.onChanged(range);
                  _closeDropdown();
                },
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    String label;
    if (widget.dateRange == null) {
      label = AppLocalizations.of(context)!.selectDateRange;
    } else {
      label =
          '${DateFormat('dd/MM/yyyy').format(widget.dateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(widget.dateRange!.end)}';
    }
    
    final bool isActive = _isOpen || _isHovered;

    return Column(
      key: _key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.isMobile) ...[
          Text(
            AppLocalizations.of(context)!.dateRange,
            style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(height: 8),
        ],
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: InkWell(
            onTap: _toggleDropdown,
            child: Container(
              width: double.infinity,
              height: widget.height ?? 44,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                borderRadius: BorderRadius.circular(widget.isMobile ? 2 : 8),
                border: Border.all(color: isActive ? const Color(0xFF289EFF) : const Color(0xFF474747)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (widget.dateRange != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () {
                          widget.onChanged(null);
                          },
                        child: const Icon(Icons.close, color: Colors.white70, size: 16),
                      ),
                    ),
                  Icon(
                      Icons.calendar_today,
                      color: isActive ? const Color(0xFF289EFF) : Colors.white70,
                      size: 16
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DateRangeDropdownContent extends StatefulWidget {
  final DateTimeRange? initialRange;
  final ValueChanged<DateTimeRange> onRangeSelected;

  const _DateRangeDropdownContent({
    required this.initialRange,
    required this.onRangeSelected,
  });

  @override
  State<_DateRangeDropdownContent> createState() => _DateRangeDropdownContentState();
}

class _DateRangeDropdownContentState extends State<_DateRangeDropdownContent> {
  DateTime? _tempStart;
  DateTime? _tempEnd;

  @override
  void initState() {
    super.initState();
    _tempStart = widget.initialRange?.start;
    _tempEnd = widget.initialRange?.end;
  }

  void _handleDateChanged(DateTime date) {
    setState(() {
      if (_tempStart == null || (_tempStart != null && _tempEnd != null)) {
        _tempStart = date;
        _tempEnd = null;
      } else if (_tempStart != null && date.isBefore(_tempStart!)) {
        _tempStart = date;
      } else {
        _tempEnd = date;
        // Delay callback slightly to allow UI update and prevent conflicts
        Future.microtask(() {
          widget.onRangeSelected(DateTimeRange(start: _tempStart!, end: _tempEnd!));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      color: const Color(0xFF0D0D0D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.white12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF289EFF),
              onPrimary: Colors.white,
              surface: Color(0xFF1A1A1A),
              onSurface: Colors.white,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _tempStart == null 
                    ? 'Select Start Date' 
                    : (_tempEnd == null ? 'Select End Date' : 'Selected Range'),
                style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 300,
                child: CalendarDatePicker(
                  initialDate: _tempStart ?? DateTime.now(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2100),
                  onDateChanged: _handleDateChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _SignalGridLive extends StatefulWidget {
  final AssetFilter assetFilter;
  final String selectedPair;
  final String selectedTimezone;
  final String selectedStatus;
  final DateTimeRange? dateRange;
  const _SignalGridLive({
    required this.assetFilter,
    required this.selectedPair,
    required this.selectedTimezone,
    required this.selectedStatus,
    required this.dateRange,
  });

  @override
  State<_SignalGridLive> createState() => _SignalGridLiveState();
}

class _SignalGridLiveState extends State<_SignalGridLive> {
  final SignalService _signalService = SignalService();
  static const int _pageSizeAll = 5;
  static const int _pageSizeSpecific = 15;
  
  int _goldPage = 0;
  int _cryptoPage = 0;
  int _forexPage = 0;
  int _specificPage = 0;

  @override
  void didUpdateWidget(covariant _SignalGridLive oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetFilter != widget.assetFilter || 
        oldWidget.dateRange != widget.dateRange ||
        oldWidget.selectedPair != widget.selectedPair ||
        oldWidget.selectedStatus != widget.selectedStatus ||
        oldWidget.selectedTimezone != widget.selectedTimezone) {
      _goldPage = 0;
      _cryptoPage = 0;
      _forexPage = 0;
      _specificPage = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool stacked = constraints.maxWidth < 900;
      final double columnWidthAll = stacked ? constraints.maxWidth : (constraints.maxWidth - 32) / 3;
      final double itemWidthSpecific = stacked ? constraints.maxWidth : (constraints.maxWidth - 32) / 3;

      final user = FirebaseAuth.instance.currentUser;
      
      if (user == null) {
        return _buildSampleData(columnWidthAll, stacked);
      }

      return StreamBuilder<List<Signal>>(
        stream: _signalService.getSignals(isLive: true, userTier: 'web'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: AppTextStyles.body.copyWith(color: Colors.white),
              ),
            );
          }
          
          final allSignals = _filteredSignals(snapshot.data ?? []);

          if (widget.assetFilter != AssetFilter.all) {
             return _buildSpecificAssetView(allSignals, itemWidthSpecific, stacked);
          }

          return _buildAllAssetsView(allSignals, columnWidthAll, stacked);
        },
      );
    });
  }

  Widget _buildSpecificAssetView(List<Signal> signals, double itemWidth, bool stacked) {
    if (signals.isEmpty) {
      return Center(
        child: Container(
          width: double.infinity,
          height: 150,
          constraints: const BoxConstraints(maxWidth: 600),
          decoration: BoxDecoration(
            color: const Color(0xFF0F0F0F),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search_off, size: 48, color: Colors.white24),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.noSignalsAvailable,
                style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      );
    }

    final totalItems = signals.length;
    final totalPages = (totalItems / _pageSizeSpecific).ceil();
    final currentPage = _specificPage.clamp(0, totalPages > 0 ? totalPages - 1 : 0);
    final pagedSignals = signals.skip(currentPage * _pageSizeSpecific).take(_pageSizeSpecific).toList();

    return Column(
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: pagedSignals.map((signal) {
            return SizedBox(
              width: itemWidth,
              child: _SignalWebCard(signal: signal, timeZone: widget.selectedTimezone),
            );
          }).toList(),
        ),
        if (totalPages > 1) ...[
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _NavButton(
                enabled: currentPage > 0,
                icon: Icons.arrow_back_ios_new,
                onTap: () => setState(() => _specificPage = currentPage - 1),
              ),
              const SizedBox(width: 24),
              Text(
                '${AppLocalizations.of(context)!.page} ${currentPage + 1} / $totalPages',
                style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(width: 24),
              _NavButton(
                enabled: currentPage < totalPages - 1,
                icon: Icons.arrow_forward_ios,
                onTap: () => setState(() => _specificPage = currentPage + 1),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildAllAssetsView(List<Signal> signals, double columnWidth, bool stacked) {
    final goldAll = signals.where(_isGold).toList();
    final cryptoAll = signals.where(_isCrypto).toList();
    final forexAll = signals.where(_isForex).toList();

    final goldPage = _normalizePage(_goldPage, goldAll.length, _pageSizeAll);
    final cryptoPage = _normalizePage(_cryptoPage, cryptoAll.length, _pageSizeAll);
    final forexPage = _normalizePage(_forexPage, forexAll.length, _pageSizeAll);

    final goldPaged = _paginate(goldAll, goldPage, _pageSizeAll);
    final cryptoPaged = _paginate(cryptoAll, cryptoPage, _pageSizeAll);
    final forexPaged = _paginate(forexAll, forexPage, _pageSizeAll);

    final hasPrevGold = goldPage > 0;
    final hasPrevCrypto = cryptoPage > 0;
    final hasPrevForex = forexPage > 0;
    final hasNextGold = goldAll.length > (goldPage + 1) * _pageSizeAll;
    final hasNextCrypto = cryptoAll.length > (cryptoPage + 1) * _pageSizeAll;
    final hasNextForex = forexAll.length > (forexPage + 1) * _pageSizeAll;

    final liveColumns = [
      SizedBox(
        width: columnWidth,
        child: _SignalColumnLive(
          title: 'GOLD',
          icon: Icons.emoji_events_outlined,
          signals: goldPaged,
          page: goldPage,
          onPageChanged: (p) => setState(() => _goldPage = p),
          hasPrev: hasPrevGold,
          hasNext: hasNextGold,
          timezone: widget.selectedTimezone,
        ),
      ),
      if (!stacked) const SizedBox(width: 16),
      if (stacked) const SizedBox(height: 16),
      SizedBox(
        width: columnWidth,
        child: cryptoPaged.isEmpty
            ? const _EmptyColumn(title: 'CRYPTO', icon: Icons.workspace_premium_outlined)
            : _SignalColumnLive(
                title: 'CRYPTO',
                icon: Icons.workspace_premium_outlined,
                signals: cryptoPaged,
                page: cryptoPage,
                onPageChanged: (p) => setState(() => _cryptoPage = p),
                hasPrev: hasPrevCrypto,
                hasNext: hasNextCrypto,
                timezone: widget.selectedTimezone,
              ),
      ),
      if (!stacked) const SizedBox(width: 16),
      if (stacked) const SizedBox(height: 16),
      SizedBox(
        width: columnWidth,
        child: forexPaged.isEmpty
            ? const _EmptyColumn(title: 'FOREX', icon: Icons.verified)
            : _SignalColumnLive(
                title: 'FOREX',
                icon: Icons.verified,
                signals: forexPaged,
                page: forexPage,
                onPageChanged: (p) => setState(() => _forexPage = p),
                hasPrev: hasPrevForex,
                hasNext: hasNextForex,
                timezone: widget.selectedTimezone,
              ),
      ),
    ];

    if (stacked) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: liveColumns,
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: liveColumns,
    );
  }

  Widget _buildSampleData(double columnWidth, bool stacked) {
    final now = DateTime.now();
    final random = math.Random();

    Timestamp randomTime(int daysAgo) {
      final date = now.subtract(Duration(days: daysAgo));
      final hour = random.nextInt(24);
      final minute = random.nextInt(60);
      return Timestamp.fromDate(DateTime(date.year, date.month, date.day, hour, minute));
    }

    final sampleGoldSignals = [
      Signal(id: 's1', symbol: 'XAU/USD', type: 'buy', status: 'running', entryPrice: 0, stopLoss: 0, takeProfits: const [], createdAt: randomTime(0), matchStatus: 'NOT MATCHED', isMatched: false),
      Signal(id: 's2', symbol: 'XAU/USD', type: 'sell', status: 'running', entryPrice: 0, stopLoss: 0, takeProfits: const [], createdAt: randomTime(1), matchStatus: 'NOT MATCHED', isMatched: false),
      Signal(id: 's3', symbol: 'XAU/USD', type: 'buy', status: 'running', entryPrice: 0, stopLoss: 0, takeProfits: const [], createdAt: randomTime(2), matchStatus: 'NOT MATCHED', isMatched: false),
    ];
    final sampleCryptoSignals = [
      Signal(id: 'c1', symbol: 'BTC/USDT', type: 'buy', status: 'running', entryPrice: 0, stopLoss: 0, takeProfits: const [], createdAt: randomTime(0), matchStatus: 'NOT MATCHED', isMatched: false),
      Signal(id: 'c2', symbol: 'ETH/USDT', type: 'sell', status: 'running', entryPrice: 0, stopLoss: 0, takeProfits: const [], createdAt: randomTime(1), matchStatus: 'NOT MATCHED', isMatched: false),
    ];

    final goldPaged = _paginate(sampleGoldSignals, _goldPage, _pageSizeAll);
    final cryptoPaged = _paginate(sampleCryptoSignals, _cryptoPage, _pageSizeAll);

    final hasPrevGold = _goldPage > 0;
    final hasNextGold = sampleGoldSignals.length > (_goldPage + 1) * _pageSizeAll;
    final hasPrevCrypto = _cryptoPage > 0;
    final hasNextCrypto = sampleCryptoSignals.length > (_cryptoPage + 1) * _pageSizeAll;
    
    final sampleColumns = [
      SizedBox(
        width: columnWidth,
        child: _SignalColumnLive(
          title: 'GOLD',
          icon: Icons.emoji_events_outlined,
          signals: goldPaged,
          page: _goldPage,
          onPageChanged: (p) => setState(() => _goldPage = p),
          hasPrev: hasPrevGold,
          hasNext: hasNextGold,
          timezone: widget.selectedTimezone,
          isSample: true,
        ),
      ),
      if (!stacked) const SizedBox(width: 16),
      if (stacked) const SizedBox(height: 16),
      SizedBox(
        width: columnWidth,
        child: _SignalColumnLive(
          title: 'CRYPTO',
          icon: Icons.workspace_premium_outlined,
          signals: cryptoPaged,
          page: _cryptoPage,
          onPageChanged: (p) => setState(() => _cryptoPage = p),
          hasPrev: hasPrevCrypto,
          hasNext: hasNextCrypto,
          timezone: widget.selectedTimezone,
          isSample: true,
        ),
      ),
      if (!stacked) const SizedBox(width: 16),
      if (stacked) const SizedBox(height: 16),
      SizedBox(
        width: columnWidth,
        child: const _EmptyColumn(title: 'FOREX', icon: Icons.verified),
      ),
    ];

    if (stacked) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sampleColumns);
    }
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: sampleColumns);
  }

  List<Signal> _paginate(List<Signal> list, int page, int pageSize) {
    final start = page * pageSize;
    return list.skip(start).take(pageSize).toList();
  }

  int _normalizePage(int page, int totalItems, int pageSize) {
    if (totalItems <= 0 || pageSize <= 0) return 0;
    final totalPages = (totalItems / pageSize).ceil();
    if (totalPages <= 0) return 0;
    final maxPage = totalPages - 1;
    if (page > maxPage) return maxPage;
    if (page < 0) return 0;
    return page;
  }

  bool _isGold(Signal s) => s.symbol.toUpperCase().contains('XAU');
  bool _isCrypto(Signal s) {
    final sym = s.symbol.toUpperCase();
    return sym.contains('BTC') || sym.contains('ETH') || sym.contains('BNB') || sym.contains('USDT') || sym.contains('CRYPTO');
  }
  bool _isForex(Signal s) {
    final sym = s.symbol.toUpperCase();
    return sym.contains('/') && !sym.contains('XAU') && !_isCrypto(s);
  }

  List<Signal> _filteredSignals(List<Signal> signals) {
    Iterable<Signal> filtered = signals;
    switch (widget.assetFilter) {
      case AssetFilter.gold:
        filtered = filtered.where(_isGold);
        break;
      case AssetFilter.crypto:
        filtered = filtered.where(_isCrypto);
        break;
      case AssetFilter.forex:
        filtered = filtered.where(_isForex);
        break;
      case AssetFilter.all:
        break;
    }

    if (widget.selectedPair != 'All Commodities' && 
        widget.selectedPair != 'All Currency Pairs' &&
        widget.selectedPair != 'All Crypto Pairs') {
      filtered = filtered.where((s) => s.symbol == widget.selectedPair);
    }

    // Status Filter Logic
    if (widget.selectedStatus != 'ALL') {
      final matchTarget = widget.selectedStatus;
      
      filtered = filtered.where((s) {
         if (matchTarget == 'CANCELLED') {
             final res = (s.result ?? '').toLowerCase();
             return s.status.toLowerCase() == 'cancelled' || res.contains('cancelled');
         }

         if (matchTarget == 'TP3') return s.hitTps.contains(3);
         if (matchTarget == 'TP2') return s.hitTps.contains(2) && !s.hitTps.contains(3);
         if (matchTarget == 'TP1') return s.hitTps.contains(1) && !s.hitTps.contains(2);
         
         final res = (s.result ?? '').toUpperCase();
         if (matchTarget == 'SL') return res.contains('SL HIT');
         if (matchTarget == 'EXIT') return (res.contains('EXIT') || res.contains('MANUAL_EXIT') || res.contains('EXITED BY ADMIN')) && s.hitTps.isEmpty;
         
         return false;
      });
    } else {
      // Default: Show all except CANCELLED
      filtered = filtered.where((s) {
         final res = (s.result ?? '').toLowerCase();
         return s.status.toLowerCase() != 'cancelled' && !res.contains('cancelled');
      });
    }

    if (widget.dateRange != null) {
      final start = widget.dateRange!.start;
      final end = widget.dateRange!.end.add(const Duration(days: 1));
      filtered = filtered.where((s) {
        if (s.createdAt is! Timestamp) return true;
        final dt = (s.createdAt as Timestamp).toDate();
        return dt.isAfter(start) && dt.isBefore(end);
      });
    }
    return filtered.toList();
  }
}

class _SignalColumnLive extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Signal> signals;
  final int page;
  final bool hasPrev;
  final bool hasNext;
  final String timezone;
  final ValueChanged<int> onPageChanged;
  final bool isSample;

  const _SignalColumnLive({
    required this.title,
    required this.icon,
    required this.signals,
    required this.page,
    required this.hasPrev,
    required this.hasNext,
    required this.timezone,
    required this.onPageChanged,
    this.isSample = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white70, size: 16),
            const SizedBox(width: 6),
            Text(
              title,
              style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (signals.isEmpty)
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: const Color(0xFF0F0F0F),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white12),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.noSignalsAvailable,
                    style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context)!.signalsWillAppearHere,
                    style: AppTextStyles.body.copyWith(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          )
        else
          ...signals.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: isSample 
                  ? _SampleSignalWebCard(signal: s, timeZone: timezone)
                  : _SignalWebCard(signal: s, timeZone: timezone),
              )),
        if (signals.isNotEmpty) ...[
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavButton(
                enabled: hasPrev,
                icon: Icons.arrow_back_ios_new,
                onTap: () => onPageChanged(page - 1),
              ),
              Text(
                '${AppLocalizations.of(context)!.page} ${page + 1}',
                style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 11),
              ),
              _NavButton(
                enabled: hasNext,
                icon: Icons.arrow_forward_ios,
                onTap: () => onPageChanged(page + 1),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _SampleSignalWebCard extends StatelessWidget {
  final Signal signal;
  final String timeZone;
  const _SampleSignalWebCard({required this.signal, required this.timeZone});

  @override
  Widget build(BuildContext context) {
    DateTime date = signal.createdAt.toDate();
    if (timeZone.isNotEmpty) {
       int offset = 0;
        try {
          final sign = timeZone.contains('+') ? 1 : -1;
          final parts = timeZone.replaceAll('GMT', '').split(RegExp(r'[+-]'));
          if (parts.isNotEmpty && parts.last.isNotEmpty) {
            offset = int.parse(parts.last) * sign;
          }
        } catch (e) {
          offset = 0; 
        }
        date = date.toUtc().add(Duration(hours: offset));
    }

    final isBuy = signal.type.toLowerCase() == 'buy';
    final actionColor = isBuy ? const Color(0xFF3BFF00) : const Color(0xFFD81400);
    final typeText = isBuy ? AppLocalizations.of(context)!.buy : AppLocalizations.of(context)!.sell;
    
    return RepaintBoundary(
      child: GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            bool isPopupHovered = false;
            return Dialog(
              backgroundColor: Colors.transparent, // Background handled by inner container
              elevation: 0,
              child: StatefulBuilder(
                builder: (context, setPopupState) {
                  return MouseRegion(
                    onEnter: (_) => setPopupState(() => isPopupHovered = true),
                    onExit: (_) => setPopupState(() => isPopupHovered = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 444,
                      height: 313,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isPopupHovered ? const Color(0xFF289EFF) : Colors.white12,
                          width: 1.2,
                        ),
                        boxShadow: isPopupHovered ? [
                          BoxShadow(
                            color: const Color(0xFF289EFF).withOpacity(0.4),
                              blurRadius: 20,
                            spreadRadius: 2,
                          )
                        ] : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                                                                          color: Color(0xFF289EFF),
                                                                          shape: BoxShape.circle,
                                                                        ),
                                                                        child: Center(
                                                                          child: SvgPicture.asset(
                                                                            'assets/icons/lock.svg',
                                                                            width: 28,
                                                                            height: 28,
                                                                            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(height: 24),                          Text(
                            AppLocalizations.of(context)!.popupMasterMarket,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            AppLocalizations.of(context)!.popupLoginExplore,
                            style: const TextStyle(
                              color: Color(0xFF9A9A9A),
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).pushNamed('/signin');
                            },
                            child: Container(
                              width: 100,
                              height: 38,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF04B3E9), Color(0xFF2E60FF), Color(0xFFD500F9)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              padding: const EdgeInsets.all(1.5), // Border width
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(1.5),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.signIn,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      child: Container(
        constraints: const BoxConstraints(minHeight: 150),
        decoration: BoxDecoration(
          color: const Color(0xFF0F0F0F),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _FlagStack(symbol: signal.symbol),
                const SizedBox(width: 8),
                Text(
                  signal.symbol,
                  style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D1D1D),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Text(
                    signal.status.toUpperCase(),
                    style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isBuy ? Icons.north_east : Icons.south_east,
                  size: 14,
                  color: actionColor,
                ),
                const SizedBox(width: 4),
                Text(
                  typeText,
                  style: AppTextStyles.body.copyWith(
                    color: actionColor,
                    fontSize: 12, // Smaller font size
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('dd/MM/yyyy HH:mm').format(date),
              style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 12),
            // Replaced Created line with Buy/Sell type, original button remains below
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.detail,
                  style: AppTextStyles.body.copyWith(color: Colors.white70, fontSize: 13),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 14),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class _NavButton extends StatelessWidget {
  final bool enabled;
  final IconData icon;
  final VoidCallback onTap;
  const _NavButton({required this.enabled, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 32,
        height: 28,
        decoration: BoxDecoration(
          color: enabled ? const Color(0xFF151515) : const Color(0xFF0D0D0D),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.white12),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 14, color: enabled ? Colors.white : Colors.white38),
      ),
    );
  }
}

class _EmptyColumn extends StatelessWidget {
  final String title;
  final IconData icon;
  const _EmptyColumn({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white70, size: 16),
            const SizedBox(width: 6),
            Text(
              title,
              style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: const Color(0xFF0F0F0F),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white12),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.noSignalsAvailable,
                  style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.signalsWillAppearHere, // Add translation if needed
                  style: AppTextStyles.body.copyWith(color: Colors.white70, fontSize: 12),
                ),],
            ),
          ),
        ),
      ],
    );
  }
}

class _SignalWebCard extends StatelessWidget {
  final Signal signal;
  final String timeZone;
  const _SignalWebCard({required this.signal, required this.timeZone});

  Future<bool> _consumeFreeToken(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    final userProvider = Provider.of<UserProvider?>(context, listen: false);
    final tier = userProvider?.userTier?.toLowerCase() ?? 'free';
    if (tier == 'elite') return true;

    final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    try {
      final result = await FirebaseFirestore.instance.runTransaction<bool>((tx) async {
        final snap = await tx.get(docRef);
        if (!snap.exists) return false;

        final data = snap.data() as Map<String, dynamic>? ?? {};
        final currentBalance = (data['tokenBalance'] ?? 0) as int;

        if (currentBalance > 0) {
          tx.update(docRef, {
            'tokenBalance': FieldValue.increment(-1),
            'unlockedSignals': FieldValue.arrayUnion([signal.id])
          });
          return true;
        } else {
          return false;
        }
      });
      return result;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Không thể trừ token: $e')),
        );
      }
      return false;
    }
  }

  void _showTokenLimitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF0F0F0F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(AppLocalizations.of(context)!.tokenExpired, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text(
          AppLocalizations.of(context)!.tokenLimitReachedDesc,
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.later, style: const TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigation to pricing tab if needed or scroll
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E97FF)),
            child: Text(AppLocalizations.of(context)!.upgrade),
          ),
        ],
      ),
    );
  }

  bool _isSignalUnlocked(Signal signal, List<String> activeSubs) {
    final symbol = signal.symbol.toUpperCase();
    if (activeSubs.contains('gold') && symbol.contains('XAU')) return true;
    
    final isCrypto = symbol.contains('BTC') || symbol.contains('ETH') || symbol.contains('BNB') || symbol.contains('CRYPTO');
    if (activeSubs.contains('crypto') && isCrypto) return true;

    final isForex = symbol.contains('/') && !symbol.contains('XAU') && !isCrypto;
    if (activeSubs.contains('forex') && isForex) return true;
    
    return false;
  }

  Future<void> _openDetail(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      showDialog(
        context: context,
        builder: (context) {
          bool isPopupHovered = false;
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: StatefulBuilder(
              builder: (context, setPopupState) {
                return MouseRegion(
                  onEnter: (_) => setPopupState(() => isPopupHovered = true),
                  onExit: (_) => setPopupState(() => isPopupHovered = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 444,
                    height: 313,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isPopupHovered ? const Color(0xFF289EFF) : Colors.white12,
                        width: 1.2,
                      ),
                      boxShadow: isPopupHovered ? [
                        BoxShadow(
                          color: const Color(0xFF289EFF).withOpacity(0.4),
                            blurRadius: 20,
                          spreadRadius: 2,
                        )
                      ] : [],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                                                Container(
                                                  width: 64,
                                                  height: 64,
                                                  decoration: const BoxDecoration(
                                                    color: Color(0xFF289EFF),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      'assets/icons/lock.svg',
                                                      width: 28,
                                                      height: 28,
                                                      colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 24),                        Text(
                          AppLocalizations.of(context)!.popupMasterMarket,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          AppLocalizations.of(context)!.popupLoginExplore,
                          style: const TextStyle(
                            color: Color(0xFF9A9A9A),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).pushNamed('/signin');
                          },
                          child: Container(
                            width: 100,
                            height: 38,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF04B3E9), Color(0xFF2E60FF), Color(0xFFD500F9)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            padding: const EdgeInsets.all(1.5), // Border width
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(1.5),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context)!.signIn,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
      return;
    }
    final userProvider = Provider.of<UserProvider?>(context, listen: false);
    final tier = userProvider?.userTier?.toLowerCase() ?? 'free';
    final activeSubs = userProvider?.activeSubscriptions ?? [];
    final unlockedSignals = userProvider?.unlockedSignals ?? [];

    // Check if user has Elite access, active subscription for this signal, OR has already unlocked it with token
    if (tier == 'elite' || _isSignalUnlocked(signal, activeSubs) || unlockedSignals.contains(signal.id)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => web_detail.SignalDetailScreen(
            signal: signal,
            userTier: 'web',
          ),
        ),
      );
      return;
    }

    final ok = await _consumeFreeToken(context);
    if (!ok) {
      _showTokenLimitDialog(context);
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => web_detail.SignalDetailScreen(
          signal: signal,
          userTier: 'web',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = signal.createdAt.toDate();
    if (timeZone.isNotEmpty) {
       int offset = 0;
        try {
          final sign = timeZone.contains('+') ? 1 : -1;
          final parts = timeZone.replaceAll('GMT', '').split(RegExp(r'[+-]'));
          if (parts.isNotEmpty && parts.last.isNotEmpty) {
            offset = int.parse(parts.last) * sign;
          }
        } catch (e) {
          offset = 0; 
        }
        date = date.toUtc().add(Duration(hours: offset));
    }

    final isBuy = signal.type.toLowerCase() == 'buy';
    final actionColor = isBuy ? const Color(0xFF3BFF00) : const Color(0xFFD81400);
    final typeText = isBuy ? AppLocalizations.of(context)!.buy : AppLocalizations.of(context)!.sell;
    
    // Check permission to view Entry
    final userProvider = Provider.of<UserProvider?>(context);
    final canViewEntry = userProvider != null && 
        SignalAccessHelper.canViewEntry(
            signal, 
            userProvider.userTier, 
            userProvider.activeSubscriptions,
            unlockedSignals: userProvider.unlockedSignals
        );

    return RepaintBoundary(
      child: GestureDetector(
      onTap: () => _openDetail(context),
      child: Container(
        constraints: const BoxConstraints(minHeight: 150),
        decoration: BoxDecoration(
          color: const Color(0xFF0F0F0F),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _FlagStack(symbol: signal.symbol),
                const SizedBox(width: 8),
                Text(
                  signal.symbol,
                  style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D1D1D),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Text(
                    signal.status.toUpperCase(),
                    style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isBuy ? Icons.north_east : Icons.south_east,
                      size: 14,
                      color: actionColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      typeText,
                      style: AppTextStyles.body.copyWith(
                        color: actionColor,
                        fontSize: 12, // Smaller font size
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                if (canViewEntry)
                  Row(
                    children: [
                      Text(
                        'Entry:',
                        style: AppTextStyles.body.copyWith(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        signal.entryPrice.toString(),
                        style: AppTextStyles.body.copyWith(color: const Color(0xFF289EFF), fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('dd/MM/yyyy HH:mm').format(date),
              style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.detail,
                  style: AppTextStyles.body.copyWith(color: Colors.white70, fontSize: 13),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 14),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class _FlagStack extends StatelessWidget {
  final String symbol;
  const _FlagStack({required this.symbol});

  static const Map<String, String> _currencyFlags = {
    'AUD': 'assets/images/aud_flag.png',
    'CHF': 'assets/images/chf_flag.png',
    'EUR': 'assets/images/eur_flag.png',
    'GBP': 'assets/images/gbp_flag.png',
    'JPY': 'assets/images/jpy_flag.png',
    'NZD': 'assets/images/nzd_flag.png',
    'USD': 'assets/images/us_flag.png',
    'XAU': 'assets/images/crown_icon.png',
    'BTC': 'assets/images/btc.png',
    'USDT': 'assets/images/usdt.png',
    'ETH': 'assets/images/eth.png',
  };

  Widget _buildCryptoIcon(String code) {
    if (_currencyFlags.containsKey(code)) {
      return CircleAvatar(
        radius: 14,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(_currencyFlags[code]!),
      );
    }

    IconData iconData = Icons.currency_bitcoin;
    Color color = Colors.orange;

    if (code.contains('BTC')) {
      iconData = Icons.currency_bitcoin;
      color = const Color(0xFFF7931A);
    } else if (code.contains('ETH')) {
      iconData = Icons.currency_exchange; // Placeholder for ETH
      color = const Color(0xFF627EEA);
    } else if (code.contains('USDT')) {
      iconData = Icons.attach_money;
      color = const Color(0xFF26A17B);
    } else if (code.contains('BNB')) {
      iconData = Icons.token;
      color = const Color(0xFFF3BA2F);
    } else {
      iconData = Icons.token; // Generic
      color = Colors.grey;
    }

    return CircleAvatar(
      radius: 14,
      backgroundColor: color.withOpacity(0.2),
      child: Icon(iconData, color: color, size: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    final parts = symbol.toUpperCase().split('/');
    if (parts.length != 2) {
       // Single symbol or non-standard
       if (symbol.toUpperCase().contains('BTC')) return _buildCryptoIcon('BTC');
       return const Icon(Icons.flag_circle_outlined, color: Colors.white, size: 18);
    }

    final base = parts[0];
    final quote = parts[1];
    
    // Check if it's a crypto pair (e.g., BTC/USD) where base is crypto
    final isBaseCrypto = ['BTC', 'ETH', 'BNB', 'SOL', 'XRP', 'DOGE', 'ADA', 'AVAX'].contains(base);
    final isQuoteCrypto = ['USDT', 'USDC', 'BTC', 'ETH'].contains(quote);

    if (isBaseCrypto || isQuoteCrypto) {
         return SizedBox(
          width: 42,
          height: 28,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: isBaseCrypto 
                  ? _buildCryptoIcon(base) 
                  : (_currencyFlags[base] != null 
                      ? CircleAvatar(radius: 14, backgroundColor: Colors.grey.shade800, backgroundImage: AssetImage(_currencyFlags[base]!))
                      : _buildCryptoIcon(base)),
              ),
              Positioned(
                left: 14,
                child: isQuoteCrypto
                  ? _buildCryptoIcon(quote)
                  : (_currencyFlags[quote] != null
                      ? CircleAvatar(radius: 14, backgroundColor: Colors.grey.shade800, backgroundImage: AssetImage(_currencyFlags[quote]!))
                      : _buildCryptoIcon(quote)),
              ),
            ],
          ),
        );
    }

    // Standard Forex/Gold
    final p1 = _currencyFlags[base];
    final p2 = _currencyFlags[quote];

    if (p1 == null && p2 == null) {
       return const Icon(Icons.show_chart, color: Colors.white, size: 18);
    }

    return SizedBox(
      width: 42,
      height: 28,
      child: Stack(
        children: [
          if (p1 != null)
            Positioned(
              left: 0,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.grey.shade800,
                backgroundImage: AssetImage(p1),
              ),
            ),
          if (p2 != null)
            Positioned(
              left: 14,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.grey.shade800,
                backgroundImage: AssetImage(p2),
              ),
            ),
        ],
      ),
    );
  }
}

class _PerformanceSection extends StatefulWidget {
  final AssetFilter assetFilter;
  final String selectedPair;
  final String selectedTimezone;
  final DateTimeRange? dateRange;

  const _PerformanceSection({
    required this.assetFilter,
    required this.selectedPair,
    required this.selectedTimezone,
    required this.dateRange,
  });

  @override
  State<_PerformanceSection> createState() => _PerformanceSectionState();
}

class _PerformanceSectionState extends State<_PerformanceSection> {
  int _selectedFilterIndex = 0; // 0: All Time, 1: 7D, 2: 14D, 3: 30D, 4: 90D

  Map<String, dynamic> _processStats(List<QueryDocumentSnapshot> docs, double winRateAdjustment) {
    if (docs.isEmpty) {
      return {
        'totalPips': 0.0,
        'count': 0,
        'winRate': (0.0 + winRateAdjustment).clamp(0.0, 100.0),
        'chartData': <_ChartPoint>[],
        'distribution': <_DistributionBarData>[],
      };
    }

    double totalPips = 0;
    int totalTp = 0;
    int totalSl = 0;
    
    // Distribution stats specific to XAU when viewing All
    int goldTp = 0;
    int goldSl = 0;
    int goldCount = 0;
    
    List<_ChartPoint> chartPoints = [];
    double runningPips = 0;

    // Apply Date Filter locally
    DateTime? startDate;
    DateTime? endDate;

    if (widget.dateRange != null) {
      startDate = widget.dateRange!.start;
      endDate = widget.dateRange!.end.add(const Duration(days: 1));
    } else if (_selectedFilterIndex > 0) {
      final now = DateTime.now();
      final Duration lookback;
      switch (_selectedFilterIndex) {
        case 1: lookback = const Duration(days: 7); break;
        case 2: lookback = const Duration(days: 14); break;
        case 3: lookback = const Duration(days: 30); break;
        case 4: lookback = const Duration(days: 90); break;
        default: lookback = Duration.zero;
      }
      startDate = now.subtract(lookback);
    }

    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>;
      final date = (data['date'] as Timestamp).toDate();

      if (startDate != null && date.isBefore(startDate)) continue;
      if (endDate != null && date.isAfter(endDate)) continue;

      double dailyPips = 0;
      
      // Determine which data to use based on AssetFilter
      if (widget.assetFilter == AssetFilter.gold) {
         if (data['xau'] != null) {
            dailyPips = (data['xau']['pips'] ?? 0).toDouble();
            totalTp += (data['xau']['tpCount'] ?? 0) as int;
            totalSl += (data['xau']['slCount'] ?? 0) as int;
         }
      } else {
         // Default to ALL
         // Priority 1: Use 'all' data if available (End of Day report)
         if (data['all'] != null && (data['all']['pips'] ?? 0) != 0) {
            dailyPips = (data['all']['pips'] ?? 0).toDouble();
            totalTp += (data['all']['tpCount'] ?? 0) as int;
            totalSl += (data['all']['slCount'] ?? 0) as int;
         } 
         // Priority 2: Fallback to component sums (e.g., xau) for real-time intraday updates
         else if (data['xau'] != null) {
            dailyPips = (data['xau']['pips'] ?? 0).toDouble();
            totalTp += (data['xau']['tpCount'] ?? 0) as int;
            totalSl += (data['xau']['slCount'] ?? 0) as int;
         }
         
         // Aggregate Gold for distribution breakdown
         if (data['xau'] != null) {
             final gTp = (data['xau']['tpCount'] ?? 0) as int;
             final gSl = (data['xau']['slCount'] ?? 0) as int;
             goldTp += gTp;
             goldSl += gSl;
             goldCount += (gTp + gSl);
         }
      }

      totalPips += dailyPips;
      runningPips += dailyPips;
      chartPoints.add(_ChartPoint(date: date, value: runningPips));
    }

    // Win Rate Calculation
    // Use TP vs SL only for simplicity as Exit is neutral
    int totalOutcomes = totalTp + totalSl;
    double baseWinRate = totalOutcomes > 0 ? (totalTp / totalOutcomes) * 100 : 0.0;
    double winRate = (baseWinRate + winRateAdjustment).clamp(0.0, 100.0);

    // Distribution Data
    List<_DistributionBarData> distribution = [];
    
    if (widget.assetFilter == AssetFilter.all) {
        // Luôn hiển thị 3 cột: Gold, Crypto, Forex để giữ layout ổn định
        
        // 1. Gold (Lấy từ dữ liệu XAU đã tổng hợp)
        int goldTotal = goldTp + goldSl;
        double goldBaseWinRate = goldTotal > 0 ? goldTp / goldTotal : 0.0;
        double goldWinRate = (goldBaseWinRate + (winRateAdjustment / 100)).clamp(0.0, 1.0);
        
        distribution.add(_DistributionBarData(
            label: 'Gold', 
            value: goldTotal > 0 ? goldTotal.toDouble() : 0.1, // Để 0.1 để cột hiện 1 chút nếu 0
            winRate: goldWinRate, 
            wins: goldTp, 
            losses: goldSl
        ));

        // 2. Crypto (Placeholder - Chưa có dữ liệu tách biệt từ Tele)
        distribution.add(const _DistributionBarData(
            label: 'Crypto', 
            value: 0.1, // Placeholder visual
            winRate: 0.0, 
            wins: 0, 
            losses: 0
        ));

        // 3. Forex (Placeholder - Chưa có dữ liệu tách biệt từ Tele)
        distribution.add(const _DistributionBarData(
            label: 'Forex', 
            value: 0.1, // Placeholder visual
            winRate: 0.0, 
            wins: 0, 
            losses: 0
        ));
        
    } else if (widget.assetFilter == AssetFilter.gold) {
         if (totalOutcomes > 0) {
             double goldWinRate = (winRate / 100).clamp(0.0, 1.0);
             distribution.add(_DistributionBarData(
                label: 'Gold', 
                value: totalOutcomes.toDouble(), 
                winRate: goldWinRate, 
                wins: totalTp, 
                losses: totalSl
            ));
         }
    }

    return {
      'totalPips': totalPips,
      'count': totalOutcomes, // Changed from totalSignals to reflect TP+SL count
      'winRate': winRate,
      'chartData': chartPoints,
      'distribution': distribution,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final timeFilters = [
      l10n.allTime,
      l10n.last7Days,
      l10n.last14Days,
      l10n.last30Days,
      l10n.last90Days,
    ];

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('settings').doc('app_config').snapshots(),
      builder: (context, configSnapshot) {
        final configData = configSnapshot.data?.data() as Map<String, dynamic>?;
        final double adjustment = (configData?['winRateAdjustment'] ?? 8.0).toDouble();

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('profit_stats').orderBy('date').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
               return const SizedBox(
                 height: 400, 
                 child: Center(child: CircularProgressIndicator())
               );
            }

            if (snapshot.hasError) {
              return SizedBox(
                 height: 400, 
                 child: Center(child: Text('Error loading stats: ${snapshot.error}', style: const TextStyle(color: Colors.white)))
               );
            }

            final stats = _processStats(snapshot.data?.docs ?? [], adjustment);

            final totalPips = stats['totalPips'] as double;
            final count = stats['count'] as int;
            final winRate = stats['winRate'] as double;
            final distribution = stats['distribution'] as List<_DistributionBarData>;

            final pipsFormatter = NumberFormat('#,##0.0', 'en_US');

            return LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth > 900;
                final gap = 32.0;
                final columnWidth = isDesktop 
                    ? (constraints.maxWidth - gap) / 2 
                    : constraints.maxWidth;
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.performanceOverview,
                          style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        if (widget.dateRange == null)
                          _buildTimeFilterDropdown(timeFilters),
                      ],
                    ),
                    const SizedBox(height: 24),
                    if (isDesktop)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: columnWidth,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _MetricCard(
                                        title: l10n.totalProfitPips,
                                        value: pipsFormatter.format(totalPips),
                                        valueColor: totalPips >= 0 ? const Color(0xFF3DCC5C) : const Color(0xFFE54747),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _MetricCard(
                                        title: l10n.completionSignal,
                                        value: count.toString(),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _ProfitChart(docs: snapshot.data?.docs ?? [], assetFilter: widget.assetFilter),
                              ],
                            ),
                          ),
                          SizedBox(width: gap),
                          SizedBox(
                            width: columnWidth,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _MetricCard(
                                        title: l10n.winRatePercent,
                                        value: '${winRate.toStringAsFixed(1)}%',
                                        valueColor: winRate >= 50 ? const Color(0xFF3DCC5C) : const Color(0xFFE54747),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _MetricCard(
                                        title: l10n.activeMember,
                                        value: '+10,500',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _DistributionChart(data: distribution),
                              ],
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                           Row(
                            children: [
                              Expanded(
                                child: _MetricCard(
                                  title: l10n.totalProfitPips, 
                                  value: pipsFormatter.format(totalPips),
                                  valueColor: totalPips >= 0 ? const Color(0xFF3DCC5C) : const Color(0xFFE54747),
                                )
                              ),
                              const SizedBox(width: 16),
                              Expanded(child: _MetricCard(title: l10n.completionSignal, value: count.toString())),
                            ],
                          ),
                          const SizedBox(height: 16),
                           Row(
                            children: [
                              Expanded(
                                child: _MetricCard(
                                  title: l10n.winRatePercent, 
                                  value: '${winRate.toStringAsFixed(1)}%',
                                  valueColor: winRate >= 50 ? const Color(0xFF3DCC5C) : const Color(0xFFE54747),
                                )
                              ),
                              const SizedBox(width: 16),
                              Expanded(child: _MetricCard(title: l10n.activeMember, value: '+10,500')),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _ProfitChart(docs: snapshot.data?.docs ?? [], assetFilter: widget.assetFilter),
                          const SizedBox(height: 24),
                          _DistributionChart(data: distribution),
                        ],
                      ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildTimeFilterDropdown(List<String> filters) {
    if (_selectedFilterIndex >= filters.length) _selectedFilterIndex = 0;

    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white12),
      ),
      child: DropdownButtonHideUnderline(
        child: Theme(
          data: Theme.of(context).copyWith(
            hoverColor: const Color(0xFF289EFF),
          ),
          child: DropdownButton<int>(
            value: _selectedFilterIndex,
            dropdownColor: const Color(0xFF0D0D0D),
            focusColor: Colors.transparent,
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 16),
            style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 13),
            menuMaxHeight: 300,
            itemHeight: 48,
            selectedItemBuilder: (context) {
              return filters.map((f) => Align(alignment: Alignment.centerLeft, child: Text(f))).toList();
            },
            items: List.generate(filters.length, (index) {
              final isSelected = _selectedFilterIndex == index;
              return DropdownMenuItem<int>(
                value: index,
                alignment: Alignment.centerLeft,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                                            if (isSelected)
                                              Positioned.fill(
                                                left: -16,
                                                right: -16,
                                                child: Container(color: const Color(0xFF289EFF)),
                                              ),                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        filters[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            onChanged: (v) {
              if (v != null) setState(() => _selectedFilterIndex = v);
            },
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  const _MetricCard({required this.title, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.h1.copyWith(
              color: valueColor ?? const Color(0xFF1DA1F2), 
              fontSize: 26
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartPoint {
  final DateTime date;
  final double value;
  _ChartPoint({required this.date, required this.value});
}

class _ProfitChart extends StatefulWidget {
  final List<QueryDocumentSnapshot> docs; // Changed from List<_ChartPoint> data
  final AssetFilter assetFilter; // Need to know if we are filtering Gold vs All

  const _ProfitChart({required this.docs, required this.assetFilter});

  @override
  State<_ProfitChart> createState() => _ProfitChartState();
}

class _ProfitChartState extends State<_ProfitChart> with SingleTickerProviderStateMixin {
  // 0: Daily (Intraday of Today), 1: Weekly (This Week), 2: Monthly (This Month)
  int _selectedPeriodIndex = 0;
  int? _hoveredIndex;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant _ProfitChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.docs.length != widget.docs.length || oldWidget.assetFilter != widget.assetFilter) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<_ChartPoint> _processData() {
    if (widget.docs.isEmpty) return [];

    final now = DateTime.now();
    List<_ChartPoint> points = [];

    if (_selectedPeriodIndex == 0) {
      // === DAILY (Intraday) ===
      final todayStr = DateFormat('yyyy-MM-dd').format(now);
      
      // Try to find today's doc by ID directly (ID format is YYYY-MM-DD)
      QueryDocumentSnapshot? todayDoc;
      try {
        todayDoc = widget.docs.firstWhere((d) => d.id == todayStr);
      } catch (e) {
        // No doc for today
      }

      if (todayDoc != null) {
          final data = todayDoc.data() as Map<String, dynamic>;
          
          // Logic: Nếu chọn Gold -> Chỉ hiện XAU Intraday
          // Nếu chọn All -> Cũng hiện XAU Intraday (vì hiện tại chưa có All Intraday)
          // Tương lai nếu có Crypto/Forex Intraday thì cần gộp lại.
          
          if (data['xau_intraday'] != null) {
              final List<dynamic> snapshots = data['xau_intraday'];
              for (var snap in snapshots) {
                  if (snap['timestamp'] != null && snap['pips'] != null) {
                      points.add(_ChartPoint(
                          date: (snap['timestamp'] as Timestamp).toDate(),
                          value: (snap['pips'] as num).toDouble()
                      ));
                  }
              }
          }
      }

    } else {
      // === WEEKLY / MONTHLY (Aggregated Daily - CUMULATIVE) ===
      DateTime startDate;
      if (_selectedPeriodIndex == 1) {
        // Weekly (Mon - Sun)
        startDate = now.subtract(Duration(days: now.weekday - 1));
        startDate = DateTime(startDate.year, startDate.month, startDate.day);
      } else {
        // Monthly (1st - Now)
        startDate = DateTime(now.year, now.month, 1);
      }

      double runningPips = 0; // Biến tích lũy

      for (var doc in widget.docs) {
         final data = doc.data() as Map<String, dynamic>;
         final date = (data['date'] as Timestamp).toDate();

         if (date.isBefore(startDate)) continue;

         double dailyPips = 0;
         if (widget.assetFilter == AssetFilter.gold) {
             if (data['xau'] != null) {
                 dailyPips = (data['xau']['pips'] ?? 0).toDouble();
             }
         } else {
             // Default All
             // Ưu tiên lấy 'all' (số liệu chốt ngày)
             if (data['all'] != null && (data['all']['pips'] ?? 0) != 0) {
                 dailyPips = (data['all']['pips'] ?? 0).toDouble();
             } 
             // Nếu chưa có 'all' (hoặc = 0), fallback sang lấy tổng các thành phần (hiện tại là xau)
             // Điều này giúp hiển thị dữ liệu realtime trong ngày khi chưa có báo cáo EOD
             else if (data['xau'] != null) {
                 dailyPips = (data['xau']['pips'] ?? 0).toDouble();
             }
         }
         
         runningPips += dailyPips; // Cộng dồn
         points.add(_ChartPoint(date: date, value: runningPips));
      }
    }

    // Sort by date/time
    points.sort((a, b) => a.date.compareTo(b.date));
    return points;
  }

  void _onHover(Offset localPosition, Size size, List<_ChartPoint> data) {
    if (data.isEmpty) return;
    
    const double leftPadding = 40.0;
    final chartWidth = size.width - leftPadding;
    
    double relativeX = localPosition.dx - leftPadding;
    if (relativeX < 0) relativeX = 0;
    if (relativeX > chartWidth) relativeX = chartWidth;
    
    final index = ((relativeX / chartWidth) * (data.length - 1)).round();
    final safeIndex = index.clamp(0, data.length - 1);
    
    if (_hoveredIndex != safeIndex) {
      setState(() {
        _hoveredIndex = safeIndex;
      });
    }
  }

  void _changePeriod(int index) {
      if (_selectedPeriodIndex == index) return;
      setState(() {
          _selectedPeriodIndex = index;
          _hoveredIndex = null;
      });
      _controller.reset();
      _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final periods = [l10n.daily, l10n.weekly, l10n.monthly];
    final processedData = _processData();

    return Container(
      width: double.infinity,
      height: 340,
      decoration: BoxDecoration(
        color: const Color(0xFF0B0D14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.profitStatistics,
                style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Row(
                children: List.generate(periods.length, (index) {
                  final isSelected = _selectedPeriodIndex == index;
                  return GestureDetector(
                    onTap: () => _changePeriod(index),
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white10 : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: isSelected ? Border.all(color: Colors.white12) : null,
                      ),
                      child: Text(
                        periods[index],
                        style: AppTextStyles.caption.copyWith(
                          color: isSelected ? Colors.white : Colors.white54,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: processedData.isEmpty 
              ? Center(child: Text(l10n.noSignalsAvailable, style: const TextStyle(color: Colors.white54)))
              : LayoutBuilder(
                  builder: (context, constraints) {
                    return MouseRegion(
                      onHover: (event) => _onHover(event.localPosition, constraints.biggest, processedData),
                      onExit: (_) => setState(() => _hoveredIndex = null),
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return CustomPaint(
                            size: Size(constraints.maxWidth, constraints.maxHeight),
                            painter: _LineChartPainter(
                                data: processedData, 
                                hoveredIndex: _hoveredIndex,
                                animationValue: _animation.value,
                                isDaily: _selectedPeriodIndex == 0
                            ),
                          );
                        }
                      ),
                    );
                  }
                ),
          ),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<_ChartPoint> data;
  final int? hoveredIndex;
  final double animationValue;
  final bool isDaily;
  
  _LineChartPainter({required this.data, this.hoveredIndex, required this.animationValue, required this.isDaily});

  @override
  void paint(Canvas canvas, Size size) {
    const double leftPadding = 40.0;
    const double bottomPadding = 20.0;
    final chartRect = Rect.fromLTWH(
      leftPadding, 
      0, 
      size.width - leftPadding, 
      size.height - bottomPadding
    );

    final paintGrid = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final paintLine = Paint()
      ..color = const Color(0xFF2E97FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    final paintFill = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF123F7A), Color(0x00123F7A)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(chartRect);

    // Calculate Min/Max for Scaling
    double minVal = 0;
    double maxVal = 100;
    if (data.isNotEmpty) {
      minVal = data.map((e) => e.value).reduce(math.min);
      maxVal = data.map((e) => e.value).reduce(math.max);
      
      final range = maxVal - minVal;
      if (range == 0) {
          maxVal += 50;
          minVal -= 50;
      } else {
          maxVal += range * 0.1;
          minVal -= range * 0.1;
      }
    }

    // Draw Grid & Y-Axis Labels
    const gridCount = 5;
    final textStyle = const TextStyle(color: Colors.white24, fontSize: 10);

    for (int i = 0; i <= gridCount; i++) {
      final y = chartRect.bottom - (chartRect.height / gridCount * i);
      canvas.drawLine(Offset(chartRect.left, y), Offset(chartRect.right, y), paintGrid);

      final value = minVal + ((maxVal - minVal) / gridCount * i);
      final textSpan = TextSpan(text: value.toInt().toString(), style: textStyle);
      final textPainter = TextPainter(text: textSpan, textDirection: ui.TextDirection.ltr);
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, y - textPainter.height / 2));
    }

    // Draw X-Axis Labels (First and Last date)
    if (data.isNotEmpty) {
        final formatStr = isDaily ? 'HH:mm' : 'dd/MM';
        final firstDate = DateFormat(formatStr).format(data.first.date);
        final lastDate = DateFormat(formatStr).format(data.last.date);
        
        final tpFirst = TextPainter(text: TextSpan(text: firstDate, style: textStyle), textDirection: ui.TextDirection.ltr)..layout();
        tpFirst.paint(canvas, Offset(chartRect.left, size.height - tpFirst.height));

        final tpLast = TextPainter(text: TextSpan(text: lastDate, style: textStyle), textDirection: ui.TextDirection.ltr)..layout();
        tpLast.paint(canvas, Offset(chartRect.right - tpLast.width, size.height - tpLast.height));
    }

    // Draw Line Path with Animation
    if (data.isNotEmpty) {
      final path = Path();
      Offset? hoverOffset;

      if (data.length == 1) {
        // Special case: Only 1 point, draw from Bottom-Left to Center-Value (Diagonal rising)
        final dotX = chartRect.left + (chartRect.width / 2);
        final y = chartRect.bottom - ((data[0].value - minVal) / (maxVal - minVal) * chartRect.height);
        
        // Define path: Start at bottom-left, go to data point
        path.moveTo(chartRect.left, chartRect.bottom);
        path.lineTo(dotX, y);

        // 1. Create Animated Path
        final pathMetrics = path.computeMetrics();
        final animatedPath = Path();
        
        for (final metric in pathMetrics) {
          animatedPath.addPath(
            metric.extractPath(0.0, metric.length * animationValue),
            Offset.zero,
          );
        }

        // 2. Draw Fill
        if (animationValue > 0) {
            final metrics = animatedPath.computeMetrics().toList();
            if (metrics.isNotEmpty) {
                final lastMetric = metrics.last;
                // Get current end point of the animation
                final endPoint = lastMetric.getTangentForOffset(lastMetric.length)?.position ?? Offset(chartRect.left, chartRect.bottom);
                
                final fillPath = Path()
                  ..moveTo(chartRect.left, chartRect.bottom) // Start corner
                  ..lineTo(endPoint.dx, endPoint.dy) // Current line end
                  ..lineTo(endPoint.dx, chartRect.bottom) // Drop down
                  ..close();
                
                canvas.drawPath(fillPath, paintFill);
            }
            canvas.drawPath(animatedPath, paintLine);
        }

        // Draw Dot at the end (only if fully animated)
        if (animationValue >= 0.95) {
           canvas.drawCircle(Offset(dotX, y), 4, paintLine);
           canvas.drawCircle(Offset(dotX, y), 2, Paint()..color = Colors.white);
        }
        
        if (hoveredIndex == 0) {
           hoverOffset = Offset(dotX, y);
        }
      } else {
        // Normal case: Multiple points, draw a line
        for (int i = 0; i < data.length; i++) {
          // Fix division by zero if only 1 point
          double progress = 0.5; // Default center for 1 point
          if (data.length > 1) {
              progress = i / (data.length - 1);
          }
          
          final x = chartRect.left + (chartRect.width * progress);
          final normalizedValue = (data[i].value - minVal) / (maxVal - minVal);
          final y = chartRect.bottom - (normalizedValue * chartRect.height);
          
          if (i == 0) {
            path.moveTo(x, y);
          } else {
            path.lineTo(x, y);
          }

          if (hoveredIndex == i) {
             hoverOffset = Offset(x, y);
          }
        }

        // 1. Create Animated Path
        final pathMetrics = path.computeMetrics();
        final animatedPath = Path();
        
        for (final metric in pathMetrics) {
          animatedPath.addPath(
            metric.extractPath(0.0, metric.length * animationValue),
            Offset.zero,
          );
        }

        // 2. Draw Fill
        if (animationValue > 0) {
            final fillPath = Path.from(animatedPath);
            final metrics = animatedPath.computeMetrics().toList();
            if (metrics.isNotEmpty) {
                final lastMetric = metrics.last;
                final endPoint = lastMetric.getTangentForOffset(lastMetric.length)?.position ?? Offset(chartRect.left, chartRect.bottom);
                final startPoint = metrics.first.getTangentForOffset(0)?.position ?? Offset(chartRect.left, chartRect.bottom);
                
                fillPath.lineTo(endPoint.dx, chartRect.bottom);
                fillPath.lineTo(startPoint.dx, chartRect.bottom);
                fillPath.close();
                
                canvas.drawPath(fillPath, paintFill);
            }
            canvas.drawPath(animatedPath, paintLine);
        }
      }

      // Draw Tooltip (Only if fully animated)
      if (animationValue >= 0.95 && hoverOffset != null && hoveredIndex != null && hoveredIndex! < data.length) {
          final hoverPoint = data[hoveredIndex!];
          canvas.drawLine(
             Offset(hoverOffset.dx, chartRect.top),
             Offset(hoverOffset.dx, chartRect.bottom),
             Paint()..color = Colors.white54..strokeWidth = 1..style = PaintingStyle.stroke
          );

          canvas.drawCircle(hoverOffset, 4, Paint()..color = const Color(0xFF2E97FF));
          canvas.drawCircle(hoverOffset, 2, Paint()..color = Colors.white);

          final dateStr = DateFormat(isDaily ? 'HH:mm' : 'dd/MM').format(hoverPoint.date);
          final valueStr = '${hoverPoint.value.toStringAsFixed(1)} Pips';
          final textSpan = TextSpan(
              style: const TextStyle(color: Colors.white, fontSize: 12),
              children: [
                 TextSpan(text: '$dateStr\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                 TextSpan(text: valueStr),
              ]
          );
          final tp = TextPainter(text: textSpan, textDirection: ui.TextDirection.ltr, textAlign: TextAlign.center)..layout();
          
          final tooltipWidth = tp.width + 16;
          final tooltipHeight = tp.height + 12;
          double tooltipX = hoverOffset.dx - tooltipWidth / 2;
          double tooltipY = hoverOffset.dy - tooltipHeight - 10;

          if (tooltipX < 0) tooltipX = 0;
          if (tooltipX + tooltipWidth > size.width) tooltipX = size.width - tooltipWidth;
          if (tooltipY < 0) tooltipY = hoverOffset.dy + 10;

          final rrect = RRect.fromRectAndRadius(
              Rect.fromLTWH(tooltipX, tooltipY, tooltipWidth, tooltipHeight), 
              const Radius.circular(6)
          );
          
          canvas.drawRRect(rrect, Paint()..color = const Color(0xFF1E1E1E).withOpacity(0.9));
          canvas.drawRRect(rrect, Paint()..color = Colors.white24..style = PaintingStyle.stroke);
          
          tp.paint(canvas, Offset(tooltipX + 8, tooltipY + 6));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue || 
           oldDelegate.hoveredIndex != hoveredIndex ||
           oldDelegate.data != data;
  }
}

class _DistributionBarData {
  final String label;
  final double value;
  final double winRate;
  final int wins;
  final int losses;
  const _DistributionBarData({
    required this.label, 
    required this.value, 
    required this.winRate,
    this.wins = 0,
    this.losses = 0,
  });
}

class _DistributionChart extends StatefulWidget {
  final List<_DistributionBarData> data;
  const _DistributionChart({required this.data});

  @override
  State<_DistributionChart> createState() => _DistributionChartState();
}

class _DistributionChartState extends State<_DistributionChart> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    if (widget.data.isEmpty) {
       return Container(
        width: double.infinity,
        height: 340,
        decoration: BoxDecoration(
          color: const Color(0xFF0B0D14),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white12),
        ),
        child: Center(child: Text(l10n.noSignalsAvailable, style: const TextStyle(color: Colors.white54))),
      );
    }

    final maxValue = widget.data.map((b) => b.value).reduce((a, b) => a > b ? a : b);
    final gridSteps = [1.0, 0.75, 0.5, 0.25, 0.0];

    return Container(
      width: double.infinity,
      height: 340,
      decoration: BoxDecoration(
        color: const Color(0xFF0B0D14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.winrateOfAllSignals,
             style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Grid
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: gridSteps.map((step) {
                          return Row(
                            children: [
                              SizedBox(
                                width: 35,
                                child: Text(
                                  (maxValue * step).toInt().toString(),
                                  style: AppTextStyles.caption.copyWith(color: Colors.white24, fontSize: 10),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Container(height: 1, color: Colors.white.withOpacity(0.05)),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      // Bars
                      Padding(
                        padding: const EdgeInsets.only(left: 43),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: widget.data.asMap().entries.map((entry) {
                            final index = entry.key;
                            final bar = entry.value;
                            final heightFactor = maxValue > 0 ? bar.value / maxValue : 0.0;
                            final isHovered = _hoveredIndex == index;

                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _hoveredIndex = _hoveredIndex == index ? null : index;
                                  });
                                },
                                child: MouseRegion(
                                  onEnter: (_) => setState(() => _hoveredIndex = index),
                                  onExit: (_) => setState(() => _hoveredIndex = null),
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.bottomCenter,
                                                child: LayoutBuilder(
                                                  builder: (context, constraints) {
                                                    final isDesktop = MediaQuery.of(context).size.width > 900;
                                                    return FractionallySizedBox(
                                                      heightFactor: heightFactor,
                                                      widthFactor: isDesktop ? 0.50 : 0.85,
                                                      child: AnimatedContainer(
                                                      duration: const Duration(milliseconds: 200),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(4),
                                                        border: isHovered ? Border.all(color: Colors.white, width: 1.5) : null,
                                                        boxShadow: isHovered ? [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 8)] : null,
                                                      ),
                                                      clipBehavior: Clip.antiAlias,
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                            flex: (bar.losses * 100).toInt() == 0 && (bar.wins * 100).toInt() == 0 ? 1 : (bar.losses * 100).toInt(),
                                                            child: Container(color: const Color(0xFFE54747)),
                                                          ),
                                                          Expanded(
                                                            flex: (bar.wins * 100).toInt(),
                                                            child: Container(color: const Color(0xFF1DA1F2)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            bar.label,
                                            style: AppTextStyles.caption.copyWith(
                                                color: isHovered ? Colors.white : Colors.white70,
                                                fontSize: 13,
                                                fontWeight: isHovered ? FontWeight.bold : FontWeight.w600
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isHovered)
                                      Positioned(
                                        bottom: (heightFactor * 250) + 10,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF1E1E1E).withOpacity(0.95),
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.white24),
                                            boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 4, offset: Offset(0, 2))],
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(bar.label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                                              const SizedBox(height: 6),
                                              _TooltipRow(color: const Color(0xFF1DA1F2), label: l10n.wins, value: '${bar.wins} (${(bar.winRate * 100).toStringAsFixed(1)}%)'),
                                              const SizedBox(height: 4),
                                              _TooltipRow(color: const Color(0xFFE54747), label: l10n.losses, value: '${bar.losses} (${((1 - bar.winRate) * 100).toStringAsFixed(1)}%)'),
                                              const Divider(color: Colors.white10),
                                              Text(l10n.totalOrdersCount(bar.value.toInt()), style: const TextStyle(color: Colors.white54, fontSize: 10)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _LegendItem(color: const Color(0xFF1DA1F2), label: l10n.winRate),
                    const SizedBox(width: 24),
                    _LegendItem(color: const Color(0xFFE54747), label: l10n.lossRate),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TooltipRow extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  const _TooltipRow({required this.color, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text('$label: ', style: const TextStyle(color: Colors.white70, fontSize: 11)),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }
}

class _ComingSoonSection extends StatelessWidget {
  const _ComingSoonSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white12),
      ),
      child: Center(
        child: Text(
          AppLocalizations.of(context)!.comingSoon,
          style: AppTextStyles.h3.copyWith(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }
}

class _HistorySection extends StatefulWidget {
  final AssetFilter assetFilter;
  final String selectedPair;
  final String selectedTimezone;
  final String selectedStatus;
  final DateTimeRange? dateRange;

  const _HistorySection({
    required this.assetFilter,
    required this.selectedPair,
    required this.selectedTimezone,
    required this.selectedStatus,
    required this.dateRange,
  });

  @override
  State<_HistorySection> createState() => _HistorySectionState();
}

class _HistorySectionState extends State<_HistorySection> {
  static const int _pageSize = 10;
  int _page = 0;
  late TextEditingController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _HistorySection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetFilter != widget.assetFilter || 
        oldWidget.selectedPair != widget.selectedPair ||
        oldWidget.dateRange != widget.dateRange ||
        oldWidget.selectedStatus != widget.selectedStatus ||
        oldWidget.selectedTimezone != widget.selectedTimezone) {
      _page = 0;
    }
  }

  List<HistoryRow> _sampleRows() {
    final dummySignal = Signal(
        id: 'dummy',
        symbol: 'XAU/USD',
        type: 'buy',
        status: 'closed',
        entryPrice: 0,
        stopLoss: 0,
        takeProfits: [],
        createdAt: Timestamp.now(),
        matchStatus: 'MATCHED'
    );
    return List.generate(8, (index) {
      return HistoryRow(
        originalSignal: dummySignal,
        date: '28/10/2025',
        time: '10:1$index',
        asset: 'GOLD',
        order: index.isEven ? 'BUY' : 'SELL',
        status: index.isEven ? 'TP1' : 'SL',
        pips: index.isEven ? '+180' : '-170',
        entry: '4011',
        closedPrice: index.isEven ? '4029' : '3994', // Added sample closedPrice
        sl: '3998',
        tp1: '4000',
        tp2: '3995',
        tp3: '4005',
      );
    });
  }

  bool _isGold(Signal s) => s.symbol.toUpperCase().contains('XAU');
  bool _isCrypto(Signal s) {
    final sym = s.symbol.toUpperCase();
    return sym.contains('BTC') || sym.contains('ETH') || sym.contains('BNB') || sym.contains('USDT') || sym.contains('CRYPTO');
  }
  bool _isForex(Signal s) {
    final sym = s.symbol.toUpperCase();
    return sym.contains('/') && !sym.contains('XAU') && !_isCrypto(s);
  }

  List<Signal> _filteredSignals(List<Signal> signals) {
    Iterable<Signal> filtered = signals;
    switch (widget.assetFilter) {
      case AssetFilter.gold:
        filtered = filtered.where(_isGold);
        break;
      case AssetFilter.crypto:
        filtered = filtered.where(_isCrypto);
        break;
      case AssetFilter.forex:
        filtered = filtered.where(_isForex);
        break;
      case AssetFilter.all:
        break;
    }

    if (widget.selectedPair != 'All Commodities' && 
        widget.selectedPair != 'All Currency Pairs' &&
        widget.selectedPair != 'All Crypto Pairs') {
      filtered = filtered.where((s) => s.symbol == widget.selectedPair);
    }

    // Status Filter Logic
    if (widget.selectedStatus != 'ALL') {
      final matchTarget = widget.selectedStatus;
      
      filtered = filtered.where((s) {
         if (matchTarget == 'CANCELLED') {
             final res = (s.result ?? '').toLowerCase();
             return s.status.toLowerCase() == 'cancelled' || res.contains('cancelled');
         }

         if (matchTarget == 'TP3') return s.hitTps.contains(3);
         if (matchTarget == 'TP2') return s.hitTps.contains(2) && !s.hitTps.contains(3);
         if (matchTarget == 'TP1') return s.hitTps.contains(1) && !s.hitTps.contains(2);
         
         final res = (s.result ?? '').toUpperCase();
         if (matchTarget == 'SL') return res.contains('SL HIT');
         if (matchTarget == 'EXIT') return (res.contains('EXIT') || res.contains('MANUAL_EXIT') || res.contains('EXITED BY ADMIN')) && s.hitTps.isEmpty;
         
         return false;
      });
    } else {
      // Default: Show all except CANCELLED
      filtered = filtered.where((s) {
         final res = (s.result ?? '').toLowerCase();
         return s.status.toLowerCase() != 'cancelled' && !res.contains('cancelled');
      });
    }

    if (widget.dateRange != null) {
      final start = widget.dateRange!.start;
      final end = widget.dateRange!.end.add(const Duration(days: 1));
      filtered = filtered.where((s) {
        if (s.createdAt is! Timestamp) return true;
        final dt = (s.createdAt as Timestamp).toDate();
        return dt.isAfter(start) && dt.isBefore(end);
      });
    }
    return filtered.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(color: Colors.white12),
            ),
          ),
        ),
        const SizedBox(height: 16),
        StreamBuilder<List<Signal>>(
          stream: SignalService().getSignals(isLive: false, userTier: 'web', allowUnauthenticated: true),
          builder: (context, snapshot) {
            final rows = <HistoryRow>[];
            final waiting = snapshot.connectionState == ConnectionState.waiting;
            final hasError = snapshot.hasError;
            final signals = snapshot.data ?? [];
            
            if (waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (hasError) {
              return Text('${AppLocalizations.of(context)!.errorLoadingHistory}: ${snapshot.error}', style: AppTextStyles.body.copyWith(color: Colors.white));
            }
            
            final filtered = _filteredSignals(signals);
            rows.addAll(filtered.map((s) => _mapSignalToRow(s, widget.selectedTimezone, context)));
            
            if (rows.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(AppLocalizations.of(context)!.noHistoryAvailable, style: AppTextStyles.body.copyWith(color: Colors.white70)),
              );
            }
            // Limit max pages to 50
            final totalPages = (rows.length / _pageSize).ceil().clamp(1, 50);
            final currentPage = _page.clamp(0, totalPages - 1);
            final visible = rows.skip(currentPage * _pageSize).take(_pageSize).toList();

            // Sync controller if page changed by buttons
            if (_pageController.text != (currentPage + 1).toString()) {
               _pageController.text = (currentPage + 1).toString();
            }

            return Column(
              children: [
                SignalHistoryTable(rows: visible),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: currentPage > 0 ? () => setState(() => _page = currentPage - 1) : null,
                      child: Text(AppLocalizations.of(context)!.previous),
                    ),
                    const SizedBox(width: 24),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${AppLocalizations.of(context)!.page}', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 13)),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 32,
                          height: 24,
                          child: TextField(
                            controller: _pageController,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 13),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              filled: true,
                              fillColor: const Color(0xFF0D0D0D),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(color: Colors.white24),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(color: Colors.white24),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(color: Colors.blue),
                              ),
                            ),
                            onSubmitted: (value) {
                              final int? newPage = int.tryParse(value);
                              if (newPage != null && newPage >= 1 && newPage <= totalPages) {
                                setState(() {
                                  _page = newPage - 1;
                                });
                              } else {
                                // Reset to current valid page if invalid
                                _pageController.text = (currentPage + 1).toString();
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('${AppLocalizations.of(context)!.pageOf} $totalPages', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                    const SizedBox(width: 24),
                    TextButton(
                      onPressed: currentPage < totalPages - 1 ? () => setState(() => _page = currentPage + 1) : null,
                      child: Text(AppLocalizations.of(context)!.next),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

HistoryRow _mapSignalToRow(Signal s, String timeZone, BuildContext context) {
  DateTime created = s.createdAt is Timestamp ? (s.createdAt as Timestamp).toDate() : DateTime.now();
  
  if (timeZone.isNotEmpty) {
      int offset = 0;
      try {
        final sign = timeZone.contains('+') ? 1 : -1;
        final parts = timeZone.replaceAll('GMT', '').split(RegExp(r'[+-]'));
        if (parts.isNotEmpty && parts.last.isNotEmpty) {
          offset = int.parse(parts.last) * sign;
        }
      } catch (e) {
        offset = 0; 
      }
      created = created.toUtc().add(Duration(hours: offset));
  }

  final dateStr = DateFormat('dd/MM/yyyy').format(created);
  final timeStr = DateFormat('HH:mm').format(created);
  final parts = s.symbol.split('/');
  final asset = parts.isNotEmpty ? (parts.first.toUpperCase() == 'XAU' ? 'GOLD' : parts.first.toUpperCase()) : s.symbol;
  final order = s.type.toUpperCase();
  // Use getTranslatedResult for consistent status display
  final status = s.getTranslatedResult(AppLocalizations.of(context)!);
  final pips = s.pips != null ? (s.pips! >= 0 ? '+${s.pips}' : s.pips.toString()) : '-';

  String _fmt(num? v) {
    if (v == null) return '-';
    if (v >= 1000) return v.toStringAsFixed(2);
    if (v >= 100) return v.toStringAsFixed(3);
    if (v >= 10) return v.toStringAsFixed(4);
    return v.toStringAsFixed(5);
  }

  String _tp(int idx) {
    if (s.takeProfits.length > idx) {
      final v = s.takeProfits[idx];
      if (v is num) return _fmt(v);
      if (v is String) return v;
    }
    return '-';
  }

  return HistoryRow(
    originalSignal: s,
    date: dateStr,
    time: timeStr,
    asset: asset,
    order: order,
    status: status,
    pips: pips,
    entry: _fmt(s.entryPrice),
    closedPrice: _fmt(s.closedPrice), // Mapped closedPrice
    sl: _fmt(s.stopLoss),
    tp1: _tp(0),
    tp2: _tp(1),
    tp3: _tp(2),
  );
}

class _UserSubscriptionStatus extends StatefulWidget {
  const _UserSubscriptionStatus();

  @override
  State<_UserSubscriptionStatus> createState() => _UserSubscriptionStatusState();
}

class _UserSubscriptionStatusState extends State<_UserSubscriptionStatus> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _toggleTooltip() {
    if (_overlayEntry != null) {
      _removeTooltip();
    } else {
      _showTooltip();
    }
  }

  void _removeTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showTooltip() {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = MediaQuery.of(context).size.width < Breakpoints.tablet;
    final bubbleWidth = isMobile ? 200.0 : 280.0;
    
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Transparent barrier to close on click outside
            Positioned.fill(
              child: GestureDetector(
                onTap: _removeTooltip,
                behavior: HitTestBehavior.translucent,
                child: Container(color: Colors.transparent),
              ),
            ),
            // The Bubble
            Positioned(
              width: bubbleWidth, // Dynamic width based on screen size
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                followerAnchor: Alignment.bottomRight,
                targetAnchor: Alignment.topLeft,
                offset: const Offset(8, 8), // Updated offset
                child: Material(
                  elevation: 8,
                  color: const Color(0xFF1E1E1E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.white24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.freeSignalsInfo,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 12 : 14, // Smaller on mobile
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          l10n.freeSignalsInfoDesc,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: isMobile ? 10 : 12, // Smaller on mobile
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _removeTooltip();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider?>(context);
    final l10n = AppLocalizations.of(context)!;
    final isMobile = MediaQuery.of(context).size.width < Breakpoints.tablet;
    final boxHeight = isMobile ? 28.0 : 36.0;

    if (userProvider == null) return const SizedBox.shrink();

    final isElite = (userProvider.userTier ?? '').toLowerCase() == 'elite';
    final tokenBalance = userProvider.tokenBalance;
    final activeSubs = userProvider.activeSubscriptions;
    final subsExpiry = userProvider.subscriptionsExpiry;

    if (isElite) {
      return Container(
        height: boxHeight,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(1),
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          l10n.unlimited,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Token Box (Always show for non-Elite)
        Container(
          height: boxHeight,
          clipBehavior: Clip.none, // Allow icon to overflow
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(1),
            border: Border.all(color: Colors.white),
          ),
          child: Stack(
            clipBehavior: Clip.none, // Important for overflow
            children: [
              // Icon Top-Left (Overlapping border)
              Positioned(
                top: -6,
                left: -6,
                child: CompositedTransformTarget(
                  link: _layerLink,
                  child: GestureDetector(
                    onTap: _toggleTooltip,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.black, // Background to make icon clearer over border
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.info_outline, color: Colors.white, size: 14),
                    ),
                  ),
                ),
              ),
              
              // Text Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Text(
                    l10n.freeSignalsCount(tokenBalance),
                    style: const TextStyle(
                      color: Color(0xFF3DCC5C),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}