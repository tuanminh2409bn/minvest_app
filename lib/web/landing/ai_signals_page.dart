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
import 'package:minvest_forex_app/web/chat/web_chat_bubble.dart';
import 'package:minvest_forex_app/core/utils/signal_access_helper.dart';
import 'package:minvest_forex_app/web/theme/breakpoints.dart';
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
  DateTimeRange? _dateRange;

  final List<String> _allCommodities = [
    'XAU/USD',
    'EUR/USD', 'GBP/USD', 'USD/JPY', 'USD/CHF', 
    'AUD/USD', 'USD/CAD', 'NZD/USD',
    'ETH/USDT', 'BTC/USDT'
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
        textScaler: isMobile ? const TextScaler.linear(0.6) : const TextScaler.linear(1.0),
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        floatingActionButton: const WebChatBubble(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  const LandingNavBar(),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _TitleSection(),
                        const SizedBox(height: 24),
                        _TabBar(
                          selected: selectedTab,
                          onSelect: (tab) {
                            setState(() => selectedTab = tab);
                          },
                        ),
                        const SizedBox(height: 24),
                        if (selectedTab == AISignalsTab.aiSignals || selectedTab == AISignalsTab.history) ...[
                          _FiltersRow(
                            assetFilter: _assetFilter,
                            selectedPair: _selectedCommodity,
                            selectedTimezone: _selectedTimezone,
                            dateRange: _dateRange,
                            availablePairs: _currentCommodities,
                            availableTimezones: _timezones,
                            onAssetChanged: _onAssetFilterChanged,
                            onPairChanged: (value) => setState(() => _selectedCommodity = value),
                            onTimezoneChanged: (value) => setState(() => _selectedTimezone = value),
                            onDateRangeChanged: (value) => setState(() => _dateRange = value),
                          ),
                          const SizedBox(height: 32),
                        ],
                        if (selectedTab == AISignalsTab.aiSignals) ...[
                          _SignalGridLive(
                            assetFilter: _assetFilter,
                            selectedPair: _selectedCommodity,
                            selectedTimezone: _selectedTimezone,
                            dateRange: _dateRange,
                          ),
                        ] else if (selectedTab == AISignalsTab.performance) ...[
                          _PerformanceSection(
                            assetFilter: _assetFilter,
                            selectedPair: _selectedCommodity,
                            selectedTimezone: _selectedTimezone,
                            dateRange: _dateRange,
                          ),
                        ] else if (selectedTab == AISignalsTab.history) ...[
                          _HistorySection(
                            assetFilter: _assetFilter,
                            selectedPair: _selectedCommodity,
                            selectedTimezone: _selectedTimezone,
                            dateRange: _dateRange,
                          ),
                        ] else ...const [
                          PricingTab(),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                  const FooterSection(),
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
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.aiSignal,
      style: AppTextStyles.h1.copyWith(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
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
              const SizedBox(width: 8),
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
          const SizedBox(height: 8),
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
              const SizedBox(width: 8),
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
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.sm,
      children: [
        _TabChip(
          label: AppLocalizations.of(context)!.aiSignal,
          isActive: selected == AISignalsTab.aiSignals,
          onTap: () => onSelect(AISignalsTab.aiSignals),
        ),
        _TabChip(
          label: AppLocalizations.of(context)!.performance,
          isActive: selected == AISignalsTab.performance,
          onTap: () => onSelect(AISignalsTab.performance),
        ),
        _TabChip(
          label: AppLocalizations.of(context)!.history,
          isActive: selected == AISignalsTab.history,
          onTap: () => onSelect(AISignalsTab.history),
        ),
        _TabChip(
          label: AppLocalizations.of(context)!.pricing,
          isActive: selected == AISignalsTab.pricing,
          onTap: () => onSelect(AISignalsTab.pricing),
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
        padding: const EdgeInsets.all(1.1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isMobile ? 1 : 8),
          gradient: isActive ? AppGradients.cta : null,
          border: isActive ? null : Border.all(color: Colors.white12),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          alignment: isMobile ? Alignment.center : null,
          decoration: BoxDecoration(
            color: isActive ? Colors.black : const Color(0xFF0C0C0C),
            borderRadius: BorderRadius.circular(isMobile ? 0 : 7),
          ),
          child: Text(
            label,
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
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
  final DateTimeRange? dateRange;
  final List<String> availablePairs;
  final List<String> availableTimezones;
  final ValueChanged<AssetFilter> onAssetChanged;
  final ValueChanged<String> onPairChanged;
  final ValueChanged<String> onTimezoneChanged;
  final ValueChanged<DateTimeRange?> onDateRangeChanged;

  const _FiltersRow({
    required this.assetFilter,
    required this.selectedPair,
    required this.selectedTimezone,
    required this.dateRange,
    required this.availablePairs,
    required this.availableTimezones,
    required this.onAssetChanged,
    required this.onPairChanged,
    required this.onTimezoneChanged,
    required this.onDateRangeChanged,
  });

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
                flex: 3,
                child: _DateRangePicker(
                  dateRange: dateRange,
                  onChanged: onDateRangeChanged,
                  isMobile: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: _TimezoneDropdown(
                  value: selectedTimezone,
                  items: availableTimezones,
                  onChanged: onTimezoneChanged,
                  isMobile: true,
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Wrap(
      spacing: 16,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _AssetDropdown(
          value: assetFilter,
          onChanged: onAssetChanged,
        ),
        _PairDropdown(
          label: AppLocalizations.of(context)!.currencyPairs,
          value: selectedPair,
          items: availablePairs,
          onChanged: onPairChanged,
        ),
        _DateRangePicker(
          dateRange: dateRange,
          onChanged: onDateRangeChanged,
        ),
        _TimezoneDropdown(
          value: selectedTimezone,
          items: availableTimezones,
          onChanged: onTimezoneChanged,
        ),
      ],
    );
  }
}

class _PairDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final bool isMobile;

  const _PairDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMobile) ...[
          Text(
            label,
            style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          width: isMobile ? double.infinity : 260,
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0D0D),
            borderRadius: BorderRadius.circular(isMobile ? 1 : 8),
            border: Border.all(color: Colors.white12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(value) ? value : items.first,
              dropdownColor: const Color(0xFF0D0D0D),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 18),
              style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14),
              isExpanded: true,
              items: items.map((pair) {
                String display = pair;
                if (pair == 'All Commodities') {
                  display = AppLocalizations.of(context)!.allCommodities;
                } else if (pair == 'All Currency Pairs') {
                  display = AppLocalizations.of(context)!.allCurrencyPairs;
                } else if (pair == 'All Crypto Pairs') {
                  display = AppLocalizations.of(context)!.allCryptoPairs;
                }

                return DropdownMenuItem<String>(
                  value: pair,
                  child: Text(display, overflow: TextOverflow.ellipsis),
                );
              }).toList(),
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _TimezoneDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final bool isMobile;

  const _TimezoneDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMobile) ...[
          Text(
            AppLocalizations.of(context)!.timeGmt7, // Reusing key or create 'Timezone'
            style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          width: isMobile ? double.infinity : 110,
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0D0D),
            borderRadius: BorderRadius.circular(isMobile ? 1 : 8),
            border: Border.all(color: Colors.white12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(value) ? value : items.first,
              dropdownColor: const Color(0xFF0D0D0D),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 18),
              style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14),
              isExpanded: true,
              menuMaxHeight: 300,
              items: items.map((tz) {
                return DropdownMenuItem<String>(
                  value: tz,
                  child: Text(tz),
                );
              }).toList(),
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _AssetDropdown extends StatelessWidget {
  final AssetFilter value;
  final ValueChanged<AssetFilter> onChanged;
  final bool isMobile;

  const _AssetDropdown({
    required this.value,
    required this.onChanged,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMobile) ...[
          Text(
            AppLocalizations.of(context)!.asset,
            style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          width: isMobile ? double.infinity : 200,
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0D0D),
            borderRadius: BorderRadius.circular(isMobile ? 1 : 8),
            border: Border.all(color: Colors.white12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<AssetFilter>(
              value: value,
              dropdownColor: const Color(0xFF0D0D0D),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 18),
              style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14),
              items: [
                DropdownMenuItem(value: AssetFilter.all, child: Text(AppLocalizations.of(context)!.allAssets)),
                const DropdownMenuItem(value: AssetFilter.gold, child: Text('Gold')),
                const DropdownMenuItem(value: AssetFilter.crypto, child: Text('Crypto')),
                const DropdownMenuItem(value: AssetFilter.forex, child: Text('Forex')),
              ],
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
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

  const _DateRangePicker({
    required this.dateRange,
    required this.onChanged,
    this.isMobile = false,
  });

  @override
  State<_DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<_DateRangePicker> {
  final GlobalKey _key = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

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
        InkWell(
          onTap: _toggleDropdown,
          child: Container(
            width: widget.isMobile ? double.infinity : 260,
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF0D0D0D),
              borderRadius: BorderRadius.circular(widget.isMobile ? 1 : 8),
              border: Border.all(color: _isOpen ? const Color(0xFF00BFFF) : Colors.white12),
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
                    color: _isOpen ? const Color(0xFF00BFFF) : Colors.white70,
                    size: 16
                ),
              ],
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
              primary: Color(0xFF00BFFF),
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
  final DateTimeRange? dateRange;
  const _SignalGridLive({
    required this.assetFilter,
    required this.selectedPair,
    required this.selectedTimezone,
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
          height: 200,
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
    final now = Timestamp.now();
    final sampleGoldSignals = [
      Signal(id: 's1', symbol: 'XAU/USD', type: 'buy', status: 'running', entryPrice: 0, stopLoss: 0, takeProfits: const [], createdAt: now, matchStatus: 'NOT MATCHED', isMatched: false),
      Signal(id: 's2', symbol: 'XAU/USD', type: 'sell', status: 'running', entryPrice: 0, stopLoss: 0, takeProfits: const [], createdAt: now, matchStatus: 'NOT MATCHED', isMatched: false),
      Signal(id: 's3', symbol: 'XAU/USD', type: 'buy', status: 'running', entryPrice: 0, stopLoss: 0, takeProfits: const [], createdAt: now, matchStatus: 'NOT MATCHED', isMatched: false),
    ];
    final sampleCryptoSignals = [
      Signal(id: 'c1', symbol: 'BTC/USDT', type: 'buy', status: 'running', entryPrice: 0, stopLoss: 0, takeProfits: const [], createdAt: now, matchStatus: 'NOT MATCHED', isMatched: false),
      Signal(id: 'c2', symbol: 'ETH/USDT', type: 'sell', status: 'running', entryPrice: 0, stopLoss: 0, takeProfits: const [], createdAt: now, matchStatus: 'NOT MATCHED', isMatched: false),
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
            height: 170,
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
    final actionColor = isBuy ? const Color(0xFF3DCC5C) : const Color(0xFFE54747);
    final typeText = isBuy ? AppLocalizations.of(context)!.buy : AppLocalizations.of(context)!.sell;
    
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            title: Text(AppLocalizations.of(context)!.signInRequired, style: const TextStyle(color: Colors.white)),
            content: Text(
              AppLocalizations.of(context)!.signInToExploreSignal,
              style: const TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: Colors.white54)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/signin');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E97FF),
                  foregroundColor: Colors.white,
                ),
                child: Text(AppLocalizations.of(context)!.signIn),
              ),
            ],
          ),
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
            Text('${AppLocalizations.of(context)!.created}:', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              DateFormat('dd/MM/yyyy HH:mm').format(date),
              style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isBuy ? Icons.north_east : Icons.south_east,
                    size: 16,
                    color: actionColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    typeText,
                    style: AppTextStyles.body.copyWith(
                      color: actionColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
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
    );
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
          height: 170,
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
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: Text(AppLocalizations.of(context)!.signInRequired, style: const TextStyle(color: Colors.white)),
          content: Text(
            AppLocalizations.of(context)!.signInToExploreSignal,
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: Colors.white54)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/signin');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E97FF),
                foregroundColor: Colors.white,
              ),
              child: Text(AppLocalizations.of(context)!.signIn),
            ),
          ],
        ),
      );
      return;
    }
    final userProvider = Provider.of<UserProvider?>(context, listen: false);
    final tier = userProvider?.userTier?.toLowerCase() ?? 'free';
    final activeSubs = userProvider?.activeSubscriptions ?? [];

    if (tier == 'elite' || _isSignalUnlocked(signal, activeSubs)) {
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
    final actionColor = isBuy ? const Color(0xFF3DCC5C) : const Color(0xFFE54747);
    final typeText = isBuy ? AppLocalizations.of(context)!.buy : AppLocalizations.of(context)!.sell;
    
    // Check permission to view Entry
    final userProvider = Provider.of<UserProvider?>(context);
    final canViewEntry = userProvider != null && 
        SignalAccessHelper.canViewEntry(signal, userProvider.userTier, userProvider.activeSubscriptions);

    return GestureDetector(
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
            Text('${AppLocalizations.of(context)!.created}:', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              DateFormat('dd/MM/yyyy HH:mm').format(date),
              style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isBuy ? Icons.north_east : Icons.south_east,
                    size: 16,
                    color: actionColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    typeText,
                    style: AppTextStyles.body.copyWith(
                      color: actionColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            if (canViewEntry) ...[
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
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 4),
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
    );
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

  bool _isGold(Signal s) => s.symbol.toUpperCase().contains('XAU');
  bool _isCrypto(Signal s) {
    final sym = s.symbol.toUpperCase();
    return sym.contains('BTC') || sym.contains('ETH') || sym.contains('BNB') || sym.contains('USDT') || sym.contains('CRYPTO');
  }
  bool _isForex(Signal s) {
    final sym = s.symbol.toUpperCase();
    return sym.contains('/') && !sym.contains('XAU') && !_isCrypto(s);
  }

  List<Signal> _applyFilters(List<Signal> signals) {
    // 1. Parent Filters (Asset, Pair, DateRange)
    Iterable<Signal> filtered = signals;
    
    // Filter by Asset Type
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

    // Filter by Specific Pair
    if (widget.selectedPair != 'All Commodities' && 
        widget.selectedPair != 'All Currency Pairs' &&
        widget.selectedPair != 'All Crypto Pairs') {
      filtered = filtered.where((s) => s.symbol == widget.selectedPair);
    }

    // Filter by Parent Date Range
    if (widget.dateRange != null) {
      final start = widget.dateRange!.start;
      final end = widget.dateRange!.end.add(const Duration(days: 1));
      filtered = filtered.where((s) {
        if (s.createdAt is! Timestamp) return false;
        final dt = (s.createdAt as Timestamp).toDate();
        return dt.isAfter(start) && dt.isBefore(end);
      });
    }

    // 2. Local Time Filter (All Time, 7D, 30D, etc.) - Only applies if Parent Date Range is null
    if (widget.dateRange == null && _selectedFilterIndex > 0) {
      final now = DateTime.now();
      final Duration lookback;
      switch (_selectedFilterIndex) {
        case 1: lookback = const Duration(days: 7); break;
        case 2: lookback = const Duration(days: 14); break;
        case 3: lookback = const Duration(days: 30); break;
        case 4: lookback = const Duration(days: 90); break;
        default: lookback = Duration.zero;
      }
      final start = now.subtract(lookback);
      filtered = filtered.where((s) {
        if (s.createdAt is! Timestamp) return false;
        final dt = (s.createdAt as Timestamp).toDate();
        return dt.isAfter(start);
      });
    }

    return filtered.toList();
  }

  Map<String, dynamic> _calculateStats(List<Signal> signals) {
    if (signals.isEmpty) {
      return {
        'totalPips': 0.0,
        'count': 0,
        'winRate': 0.0,
        'chartData': <_ChartPoint>[],
        'distribution': <_DistributionBarData>[],
      };
    }

    double totalPips = 0;
    int wins = 0;
    
    // For Distribution Chart
    int goldCount = 0; int goldWins = 0;
    int cryptoCount = 0; int cryptoWins = 0;
    int forexCount = 0; int forexWins = 0;

    // For Profit Chart (Cumulative)
    // Sort by date ascending
    signals.sort((a, b) => (a.createdAt as Timestamp).compareTo(b.createdAt as Timestamp));
    
    List<_ChartPoint> chartPoints = [];
    double runningPips = 0;

    for (var s in signals) {
      final pips = (s.pips ?? 0).toDouble();
      totalPips += pips;
      
      if (pips > 0) wins++;

      // Distribution stats
      if (_isGold(s)) {
        goldCount++;
        if (pips > 0) goldWins++;
      } else if (_isCrypto(s)) {
        cryptoCount++;
        if (pips > 0) cryptoWins++;
      } else {
        forexCount++;
        if (pips > 0) forexWins++;
      }

      runningPips += pips;
      final date = (s.createdAt as Timestamp).toDate();
      // Simple daily aggregation for chart points could be done here, 
      // but for now let's just add all points and let the chart handle or subsample.
      // To avoid too many points, we can group by day.
      if (chartPoints.isEmpty || 
          !DateUtils.isSameDay(chartPoints.last.date, date)) {
        chartPoints.add(_ChartPoint(date: date, value: runningPips));
      } else {
        // Update the last point for the same day with the new cumulative value
        chartPoints.last = _ChartPoint(date: date, value: runningPips);
      }
    }

    double winRate = signals.isNotEmpty ? (wins / signals.length) * 100 : 0;

    // Prepare Distribution Data
    List<_DistributionBarData> distribution = [];
    if (goldCount > 0) distribution.add(_DistributionBarData(label: 'Gold', value: goldCount.toDouble(), winRate: goldWins / goldCount));
    if (cryptoCount > 0) distribution.add(_DistributionBarData(label: 'Crypto', value: cryptoCount.toDouble(), winRate: cryptoWins / cryptoCount));
    if (forexCount > 0) distribution.add(_DistributionBarData(label: 'Forex', value: forexCount.toDouble(), winRate: forexWins / forexCount));

    return {
      'totalPips': totalPips,
      'count': signals.length,
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

    return StreamBuilder<List<Signal>>(
      // Only fetch completed signals (not live)
      stream: SignalService().getSignals(isLive: false, userTier: 'web', allowUnauthenticated: true),
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
             child: Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)))
           );
        }

        final allSignals = snapshot.data ?? [];
        final filteredSignals = _applyFilters(allSignals);
        final stats = _calculateStats(filteredSignals);

        final totalPips = stats['totalPips'] as double;
        final count = stats['count'] as int;
        final winRate = stats['winRate'] as double;
        final chartData = stats['chartData'] as List<_ChartPoint>;
        final distribution = stats['distribution'] as List<_DistributionBarData>;

        // Format Pips
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
                    // Only show time filter if no custom date range is selected
                    if (widget.dateRange == null)
                      _buildTimeFilterDropdown(timeFilters),
                  ],
                ),
                const SizedBox(height: 24),
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column: Profit Metrics + Profit Chart
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
                            _ProfitChart(data: chartData),
                          ],
                        ),
                      ),
                      SizedBox(width: gap),
                      // Right Column: Win/Member Metrics + Distribution Chart
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
                                    title: l10n.activeMember, // Keeping this static or fetch from another source
                                    value: '+10,500', // Placeholder as requested to focus on signals
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
                      _ProfitChart(data: chartData),
                      const SizedBox(height: 24),
                      _DistributionChart(data: distribution),
                    ],
                  ),
              ],
            );
          },
        );
      }
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
        child: DropdownButton<int>(
          value: _selectedFilterIndex,
          dropdownColor: const Color(0xFF0D0D0D),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 16),
          style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 13),
          items: List.generate(filters.length, (index) {
            return DropdownMenuItem<int>(
              value: index,
              child: Text(filters[index]),
            );
          }),
          onChanged: (v) {
            if (v != null) setState(() => _selectedFilterIndex = v);
          },
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
  final List<_ChartPoint> data;
  const _ProfitChart({required this.data});

  @override
  State<_ProfitChart> createState() => _ProfitChartState();
}

class _ProfitChartState extends State<_ProfitChart> {
  // 0: Daily, 1: Weekly, 2: Monthly
  int _selectedPeriodIndex = 0;

  List<_ChartPoint> _processData() {
    // Basic aggregation based on period could go here
    // For now, we use the passed data which is daily cumulative
    // If the dataset is large, we should subsample here based on _selectedPeriodIndex
    return widget.data;
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
                    onTap: () => setState(() => _selectedPeriodIndex = index),
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
              : CustomPaint(
                  painter: _LineChartPainter(data: processedData),
                  child: Container(),
                ),
          ),
        ],
      ),
    );
  }
}

class _DistributionChart extends StatelessWidget {
  final List<_DistributionBarData> data;
  const _DistributionChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = MediaQuery.of(context).size.width < Breakpoints.tablet;
    final widthFactor = isMobile ? 0.45 : 0.30;
    
    if (data.isEmpty) {
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

    final maxValue = data.map((b) => b.value).reduce((a, b) => a > b ? a : b);
    
    // Create grid steps (5 lines: 0%, 25%, 50%, 75%, 100%)
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
                    children: [
                      // Background Grid
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
                                child: Container(
                                  height: 1,
                                  color: Colors.white.withOpacity(0.05),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      // Bars
                      Padding(
                        padding: const EdgeInsets.only(left: 43), // Offset for labels
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: data.map((bar) {
                            final heightFactor = maxValue > 0 ? bar.value / maxValue : 0.0;
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: FractionallySizedBox(
                                          heightFactor: heightFactor,
                                          widthFactor: widthFactor,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: ((1 - bar.winRate) * 100).toInt(),
                                                  child: Container(
                                                    color: const Color(0xFFE54747), // Loss Color
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: (bar.winRate * 100).toInt(),
                                                  child: Container(
                                                    color: const Color(0xFF1DA1F2), // Win Color
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      bar.label,
                                      style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),
                                    ),
                                  ],
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
                // Legend
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

class _LineChartPainter extends CustomPainter {
  final List<_ChartPoint> data;
  _LineChartPainter({required this.data});

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
      // Add padding
      final range = maxVal - minVal;
      maxVal += range * 0.1;
      minVal -= range * 0.1;
    }
    if (maxVal == minVal) maxVal += 100;

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
        final firstDate = DateFormat('MM/dd').format(data.first.date);
        final lastDate = DateFormat('MM/dd').format(data.last.date);
        
        // Draw First
        final tpFirst = TextPainter(text: TextSpan(text: firstDate, style: textStyle), textDirection: ui.TextDirection.ltr)..layout();
        tpFirst.paint(canvas, Offset(chartRect.left, size.height - tpFirst.height));

        // Draw Last
        final tpLast = TextPainter(text: TextSpan(text: lastDate, style: textStyle), textDirection: ui.TextDirection.ltr)..layout();
        tpLast.paint(canvas, Offset(chartRect.right - tpLast.width, size.height - tpLast.height));
    }

    // Draw Line Path
    if (data.isNotEmpty) {
      final path = Path();
      for (int i = 0; i < data.length; i++) {
        final x = chartRect.left + (chartRect.width * (i / (data.length - 1)));
        // Normalize value to height
        final normalizedValue = (data[i].value - minVal) / (maxVal - minVal);
        final y = chartRect.bottom - (normalizedValue * chartRect.height);
        
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      final fillPath = Path.from(path)
        ..lineTo(chartRect.right, chartRect.bottom)
        ..lineTo(chartRect.left, chartRect.bottom)
        ..close();

      canvas.drawPath(fillPath, paintFill);
      canvas.drawPath(path, paintLine);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _DistributionBarData {
  final String label;
  final double value;
  final double winRate;
  const _DistributionBarData({required this.label, required this.value, required this.winRate});
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
  final DateTimeRange? dateRange;

  const _HistorySection({
    required this.assetFilter,
    required this.selectedPair,
    required this.selectedTimezone,
    required this.dateRange,
  });

  @override
  State<_HistorySection> createState() => _HistorySectionState();
}

class _HistorySectionState extends State<_HistorySection> {
  static const int _pageSize = 10;
  int _page = 0;

  @override
  void didUpdateWidget(covariant _HistorySection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetFilter != widget.assetFilter || 
        oldWidget.selectedPair != widget.selectedPair ||
        oldWidget.dateRange != widget.dateRange ||
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
            rows.addAll(filtered.map((s) => _mapSignalToRow(s, widget.selectedTimezone)));
            
            if (rows.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(AppLocalizations.of(context)!.noHistoryAvailable, style: AppTextStyles.body.copyWith(color: Colors.white70)),
              );
            }
            final totalPages = (rows.length / _pageSize).ceil().clamp(1, 9999);
            final currentPage = _page.clamp(0, totalPages - 1);
            final visible = rows.skip(currentPage * _pageSize).take(_pageSize).toList();

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
                    Text('${AppLocalizations.of(context)!.page} ${currentPage + 1} of $totalPages', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 13)),
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

HistoryRow _mapSignalToRow(Signal s, String timeZone) {
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
  final status = (s.result ?? s.status).toString();
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