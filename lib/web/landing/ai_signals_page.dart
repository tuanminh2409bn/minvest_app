import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minvest_forex_app/features/signals/models/signal_model.dart';
import 'package:minvest_forex_app/features/signals/screens/signal_detail_screen_web.dart' as web_detail;
import 'package:minvest_forex_app/features/signals/services/signal_service.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/spacing.dart';
import '../theme/gradients.dart';
import 'widgets/navbar.dart';
import 'sections/footer_section.dart';
import 'sections/pricing_tab.dart';

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
  DateTimeRange? _dateRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  const LandingNavBar(),
                  const SizedBox(height: 32),
                  const _TitleSection(),
                  const SizedBox(height: 24),
                  _TabBar(
                    selected: selectedTab,
                    onSelect: (tab) {
                      setState(() => selectedTab = tab);
                    },
                  ),
                const SizedBox(height: 24),
                if (selectedTab == AISignalsTab.aiSignals) ...[
                _FiltersRow(
                  assetFilter: _assetFilter,
                  dateRange: _dateRange,
                  onAssetChanged: (value) => setState(() => _assetFilter = value),
                  onDateRangeChanged: (value) => setState(() => _dateRange = value),
                ),
                const SizedBox(height: 32),
                _SignalGridLive(
                  assetFilter: _assetFilter,
                  dateRange: _dateRange,
                ),
              ] else if (selectedTab == AISignalsTab.performance) ...const [
                _PerformanceSection(),
              ] else if (selectedTab == AISignalsTab.history) ...const [
                _HistorySection(),
                  ] else ...const [
                    PricingTab(),
                  ],
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
      'AI Signals',
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
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.sm,
      children: [
        _TabChip(
          label: 'AI Signals',
          isActive: selected == AISignalsTab.aiSignals,
          onTap: () => onSelect(AISignalsTab.aiSignals),
        ),
        _TabChip(
          label: 'Performance',
          isActive: selected == AISignalsTab.performance,
          onTap: () => onSelect(AISignalsTab.performance),
        ),
        _TabChip(
          label: 'History',
          isActive: selected == AISignalsTab.history,
          onTap: () => onSelect(AISignalsTab.history),
        ),
        _TabChip(
          label: 'Pricing',
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
  const _TabChip({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(1.1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: isActive ? AppGradients.cta : null,
          border: isActive ? null : Border.all(color: Colors.white12),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.black : const Color(0xFF0C0C0C),
            borderRadius: BorderRadius.circular(7),
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
  final DateTimeRange? dateRange;
  final ValueChanged<AssetFilter> onAssetChanged;
  final ValueChanged<DateTimeRange?> onDateRangeChanged;
  const _FiltersRow({
    required this.assetFilter,
    required this.dateRange,
    required this.onAssetChanged,
    required this.onDateRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _AssetDropdown(
          value: assetFilter,
          onChanged: onAssetChanged,
        ),
        const _FilterDropdown(label: 'Currency pairs', value: 'All Currency pairs'),
        _DateRangePicker(
          dateRange: dateRange,
          onChanged: onDateRangeChanged,
        ),
        const _TimezoneDropdown(),
      ],
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final String label;
  final String value;
  final double? width;
  const _FilterDropdown({required this.label, required this.value, this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Container(
          width: width ?? 260,
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0D0D),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 18),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimezoneDropdown extends StatelessWidget {
  const _TimezoneDropdown();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date Range',
          style: AppTextStyles.caption.copyWith(color: Colors.transparent, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Container(
          width: 90,
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0D0D),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            children: [
              Text(
                'GMT',
                style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14),
              ),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 18),
            ],
          ),
        ),
      ],
    );
  }
}

class _AssetDropdown extends StatelessWidget {
  final AssetFilter value;
  final ValueChanged<AssetFilter> onChanged;
  const _AssetDropdown({required this.value, required this.onChanged});

  String _label(AssetFilter v) {
    switch (v) {
      case AssetFilter.gold:
        return 'Gold';
      case AssetFilter.crypto:
        return 'Crypto';
      case AssetFilter.forex:
        return 'Forex';
      default:
        return 'All Assets';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Asset',
          style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Container(
          width: 200,
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0D0D),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<AssetFilter>(
              value: value,
              dropdownColor: const Color(0xFF0D0D0D),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 18),
              style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14),
              items: const [
                DropdownMenuItem(value: AssetFilter.all, child: Text('All Assets')),
                DropdownMenuItem(value: AssetFilter.gold, child: Text('Gold')),
                DropdownMenuItem(value: AssetFilter.crypto, child: Text('Crypto')),
                DropdownMenuItem(value: AssetFilter.forex, child: Text('Forex')),
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

class _DateRangePicker extends StatelessWidget {
  final DateTimeRange? dateRange;
  final ValueChanged<DateTimeRange?> onChanged;
  const _DateRangePicker({required this.dateRange, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    String label;
    if (dateRange == null) {
      label = 'Select Date Range';
    } else {
      label =
          '${DateFormat('dd/MM/yyyy').format(dateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(dateRange!.end)}';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date Range',
          style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2022),
              lastDate: DateTime(2100),
              initialDateRange: dateRange,
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.dark(
                      primary: Color(0xFF00BFFF),
                      surface: Color(0xFF0D0D0D),
                      onSurface: Colors.white,
                    ),
                  ),
                  child: child ?? const SizedBox.shrink(),
                );
              },
            );
            onChanged(picked);
          },
          child: Container(
            width: 260,
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF0D0D0D),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14),
                  ),
                ),
                const Icon(Icons.calendar_today, color: Colors.white70, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
class _SignalGridLive extends StatefulWidget {
  final AssetFilter assetFilter;
  final DateTimeRange? dateRange;
  const _SignalGridLive({
    required this.assetFilter,
    required this.dateRange,
  });

  @override
  State<_SignalGridLive> createState() => _SignalGridLiveState();
}

class _SignalGridLiveState extends State<_SignalGridLive> {
  final SignalService _signalService = SignalService();
  static const int _pageSize = 5;
  int _goldPage = 0;
  int _cryptoPage = 0;
  int _forexPage = 0;

  @override
  void didUpdateWidget(covariant _SignalGridLive oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetFilter != widget.assetFilter || oldWidget.dateRange != widget.dateRange) {
      _goldPage = 0;
      _cryptoPage = 0;
      _forexPage = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool stacked = constraints.maxWidth < 900;
      final double columnWidth = stacked ? constraints.maxWidth : (constraints.maxWidth - 32) / 3;
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        final now = Timestamp.now();
        final sampleSignals = [
          Signal(
            id: 'sample1',
            symbol: 'XAU/USD',
            type: 'buy',
            status: 'running',
            entryPrice: 0,
            stopLoss: 0,
            takeProfits: const [],
            createdAt: now,
            matchStatus: 'NOT MATCHED',
            isMatched: false,
          ),
          Signal(
            id: 'sample2',
            symbol: 'XAU/USD',
            type: 'sell',
            status: 'running',
            entryPrice: 0,
            stopLoss: 0,
            takeProfits: const [],
            createdAt: now,
            matchStatus: 'NOT MATCHED',
            isMatched: false,
          ),
          Signal(
            id: 'sample3',
            symbol: 'XAU/USD',
            type: 'buy',
            status: 'running',
            entryPrice: 0,
            stopLoss: 0,
            takeProfits: const [],
            createdAt: now,
            matchStatus: 'NOT MATCHED',
            isMatched: false,
          ),
        ];
        final goldPaged = _paginate(sampleSignals, _goldPage);
        final hasPrevGold = _goldPage > 0;
        final hasNextGold = sampleSignals.length > (_goldPage + 1) * _pageSize;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: columnWidth,
              child: const _EmptyColumn(title: 'CRYPTO', icon: Icons.workspace_premium_outlined),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: columnWidth,
              child: const _EmptyColumn(title: 'FOREX', icon: Icons.verified),
            ),
          ],
        );
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
          final filtered = _filteredSignals(snapshot.data ?? []);
          final goldAll = filtered.where(_isGold).toList();
          final cryptoAll = filtered.where(_isCrypto).toList();
          final forexAll = filtered.where(_isForex).toList();

          final goldPage = _normalizePage(_goldPage, goldAll.length);
          final cryptoPage = _normalizePage(_cryptoPage, cryptoAll.length);
          final forexPage = _normalizePage(_forexPage, forexAll.length);

          final goldPaged = _paginate(goldAll, goldPage);
          final cryptoPaged = _paginate(cryptoAll, cryptoPage);
          final forexPaged = _paginate(forexAll, forexPage);

          final hasPrevGold = goldPage > 0;
          final hasPrevCrypto = cryptoPage > 0;
          final hasPrevForex = forexPage > 0;
          final hasNextGold = goldAll.length > (goldPage + 1) * _pageSize;
          final hasNextCrypto = cryptoAll.length > (cryptoPage + 1) * _pageSize;
          final hasNextForex = forexAll.length > (forexPage + 1) * _pageSize;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                ),
              ),
              const SizedBox(width: 16),
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
                      ),
              ),
              const SizedBox(width: 16),
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
                      ),
              ),
            ],
          );
        },
      );
    });
  }

  List<Signal> _paginate(List<Signal> list, int page) {
    final start = page * _pageSize;
    return list.skip(start).take(_pageSize).toList();
  }

  int _normalizePage(int page, int totalItems) {
    if (totalItems <= 0) return 0;
    final totalPages = (totalItems / _pageSize).ceil();
    return page.clamp(0, totalPages - 1).toInt();
  }

  bool _isGold(Signal s) => s.symbol.toUpperCase().contains('XAU');
  bool _isCrypto(Signal s) => s.symbol.toUpperCase().contains('BTC') || s.symbol.toUpperCase().contains('CRYPTO');
  bool _isForex(Signal s) {
    final sym = s.symbol.toUpperCase();
    return sym.contains('/') && !sym.contains('XAU') && !sym.contains('BTC');
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

    if (widget.dateRange != null) {
      final start = widget.dateRange!.start;
      final end = widget.dateRange!.end.add(const Duration(days: 1)); // inclusive
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
  final ValueChanged<int> onPageChanged;
  const _SignalColumnLive({
    required this.title,
    required this.icon,
    required this.signals,
    required this.page,
    required this.hasPrev,
    required this.hasNext,
    required this.onPageChanged,
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
                    'No signals available',
                    style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Signals will appear here when available',
                    style: AppTextStyles.body.copyWith(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          )
        else
          ...signals.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _SignalWebCard(signal: s),
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
                'Page ${page + 1}',
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
                  'No signals available',
                  style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  'Signals will appear here when available',
                  style: AppTextStyles.body.copyWith(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SignalWebCard extends StatelessWidget {
  final Signal signal;
  const _SignalWebCard({required this.signal});

  Future<bool> _consumeFreeToken(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    final userProvider = Provider.of<UserProvider?>(context, listen: false);
    final tier = userProvider?.userTier?.toLowerCase() ?? 'free';
    if (tier == 'elite') return true;

    final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    try {
      final result = await FirebaseFirestore.instance.runTransaction<bool>((tx) async {
        final snap = await tx.get(docRef);
        if (!snap.exists) {
          tx.set(docRef, {
            'uid': user.uid,
            'email': user.email ?? 'guest_${user.uid}@minvest.com',
            'subscriptionTier': 'free',
            'freeTokensDate': todayKey,
            'freeTokensUsed': 1,
          }, SetOptions(merge: true));
          return true;
        } else {
          final data = snap.data() as Map<String, dynamic>? ?? {};
          String storedDate = (data['freeTokensDate'] ?? '') as String;
          int used = (data['freeTokensUsed'] ?? 0) as int;
          if (storedDate != todayKey) {
            storedDate = todayKey;
            used = 0;
          }
          if (used >= 10) {
            return false;
          }
          tx.update(docRef, {
            'freeTokensDate': storedDate,
            'freeTokensUsed': used + 1,
          });
          return true;
        }
      });
      return result;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể trừ token: $e')),
      );
      return false;
    }
  }

  void _showTokenLimitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF0F0F0F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Token đã hết', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text(
          'Bạn đã dùng hết 10 tokens miễn phí hôm nay. Nâng cấp gói để xem thêm tín hiệu.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Để sau', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/pricing');
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E97FF)),
            child: const Text('Nâng cấp'),
          ),
        ],
      ),
    );
  }

  Future<void> _openDetail(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.of(context).pushNamed('/signin');
      return;
    }
    final userProvider = Provider.of<UserProvider?>(context, listen: false);
    final tier = userProvider?.userTier?.toLowerCase() ?? 'free';

    if (tier == 'elite') {
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
    final isBuy = signal.type.toLowerCase() == 'buy';
    final actionColor = isBuy ? const Color(0xFF3DCC5C) : const Color(0xFFE54747);
    final createdAt = signal.createdAt;
    String createdText = '';
    if (createdAt is Timestamp) {
      final dt = createdAt.toDate().toLocal().add(const Duration(hours: 0)); // assume local is GMT+7; adjust if needed
      createdText = DateFormat('dd/MM/yyyy HH:mm').format(dt);
    }
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
                    signal.status,
                    style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text('Created:', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              createdText,
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
                    isBuy ? 'Buy' : 'Sell',
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
                  'Detail',
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
  };

  List<String> _flags() {
    final parts = symbol.toUpperCase().split('/');
    if (parts.length == 2) {
      final p1 = _currencyFlags[parts[0]];
      final p2 = _currencyFlags[parts[1]];
      return [
        if (p1 != null) p1,
        if (p2 != null) p2,
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final flags = _flags();
    if (flags.isEmpty) {
      return const Icon(Icons.flag_circle_outlined, color: Colors.white, size: 18);
    }
    return SizedBox(
      width: 42,
      height: 28,
      child: Stack(
        children: List.generate(flags.length, (index) {
          return Positioned(
            left: index * 14.0,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.grey.shade800,
              backgroundImage: AssetImage(flags[index]),
            ),
          );
        }),
      ),
    );
  }
}

class _PerformanceSection extends StatelessWidget {
  const _PerformanceSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          'Performance Overview',
          style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: const [
            _MetricCard(title: 'Total Profit (Pips)', value: '9,250.8'),
            _MetricCard(title: 'Completion signal', value: '507'),
            _MetricCard(title: 'Win Rate (%)', value: '62.7'),
          ],
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = (constraints.maxWidth - 16) / 2;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: const [
                _ProfitChart(),
                _DistributionChart(),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  const _MetricCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
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
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.h1.copyWith(color: const Color(0xFF1DA1F2), fontSize: 30),
          ),
        ],
      ),
    );
  }
}

class _ProfitChart extends StatelessWidget {
  const _ProfitChart();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 560,
      height: 340,
      decoration: BoxDecoration(
        color: const Color(0xFF0B0D14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white12),
      ),
      padding: const EdgeInsets.all(16),
      child: CustomPaint(
        painter: _LineChartPainter(),
        child: Container(),
      ),
    );
  }
}

class _DistributionChart extends StatelessWidget {
  const _DistributionChart();

  @override
  Widget build(BuildContext context) {
    const bars = [
      _BarData(label: 'Crypto', value: 6000),
      _BarData(label: 'Gold', value: 3000),
      _BarData(label: 'Forex', value: 1200),
    ];
    final maxValue = bars.map((b) => b.value).reduce((a, b) => a > b ? a : b);
    return Container(
      width: 560,
      height: 340,
      decoration: BoxDecoration(
        color: const Color(0xFF0B0D14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white12),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: bars.map((bar) {
                final heightFactor = bar.value / maxValue;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: FractionallySizedBox(
                              heightFactor: heightFactor,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2E97FF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          bar.label,
                          style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12),
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
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintGrid = Paint()
      ..color = Colors.white12
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
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    const gridCount = 6;
    for (int i = 0; i <= gridCount; i++) {
      final dy = size.height / gridCount * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paintGrid);
    }

    final points = [
      Offset(0, size.height * 0.9),
      Offset(size.width * 0.1, size.height * 0.85),
      Offset(size.width * 0.2, size.height * 0.78),
      Offset(size.width * 0.32, size.height * 0.8),
      Offset(size.width * 0.42, size.height * 0.7),
      Offset(size.width * 0.5, size.height * 0.74),
      Offset(size.width * 0.6, size.height * 0.6),
      Offset(size.width * 0.7, size.height * 0.52),
      Offset(size.width * 0.82, size.height * 0.4),
      Offset(size.width * 0.92, size.height * 0.45),
    ];

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var p in points.skip(1)) {
      path.lineTo(p.dx, p.dy);
    }

    final fillPath = Path.from(path)
      ..lineTo(points.last.dx, size.height)
      ..lineTo(points.first.dx, size.height)
      ..close();

    canvas.drawPath(fillPath, paintFill);
    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BarData {
  final String label;
  final double value;
  const _BarData({required this.label, required this.value});
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
          'Coming soon',
          style: AppTextStyles.h3.copyWith(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }
}

class _HistorySection extends StatefulWidget {
  const _HistorySection();

  @override
  State<_HistorySection> createState() => _HistorySectionState();
}

class _HistorySectionState extends State<_HistorySection> {
  static const int _pageSize = 10;
  int _page = 0;

  List<HistoryRow> _sampleRows() {
    return List.generate(8, (index) {
      return HistoryRow(
        date: '28/10/2025',
        time: '10:1$index',
        asset: 'GOLD',
        order: index.isEven ? 'BUY' : 'SELL',
        status: index.isEven ? 'TP1' : 'SL',
        pips: index.isEven ? '+180' : '-170',
        entry: '4011',
        sl: '3998',
        tp1: '4000',
        tp2: '3995',
      );
    });
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
            if (FirebaseAuth.instance.currentUser == null) {
              rows.addAll(_sampleRows());
            } else {
              if (waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (hasError) {
                return Text('Lỗi tải lịch sử: ${snapshot.error}', style: AppTextStyles.body.copyWith(color: Colors.white));
              }
              rows.addAll(signals.map(_mapSignalToRow));
            }
            if (rows.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text('Chưa có lịch sử tín hiệu', style: AppTextStyles.body.copyWith(color: Colors.white70)),
              );
            }
            final totalPages = (rows.length / _pageSize).ceil().clamp(1, 9999);
            final currentPage = _page.clamp(0, totalPages - 1);
            final visible = rows.skip(currentPage * _pageSize).take(_pageSize).toList();

            return Column(
              children: [
                _HistoryTable(rows: visible),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: currentPage > 0 ? () => setState(() => _page = currentPage - 1) : null,
                      child: const Text('Previous'),
                    ),
                    const SizedBox(width: 24),
                    Text('Page ${currentPage + 1} of $totalPages', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 13)),
                    const SizedBox(width: 24),
                    TextButton(
                      onPressed: currentPage < totalPages - 1 ? () => setState(() => _page = currentPage + 1) : null,
                      child: const Text('Next'),
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

class _HistoryTable extends StatelessWidget {
  final List<HistoryRow> rows;
  const _HistoryTable({required this.rows});

  @override
  Widget build(BuildContext context) {
    final headers = [
      'Date',
      'Time (GMT +7)',
      'Asset',
      'Orders',
      'Status',
      'Pips',
      'Entry',
      'SL',
      'TP1',
      'TP2',
    ];
    final columnWidths = <int, TableColumnWidth>{
      0: const FlexColumnWidth(1.2),
      1: const FlexColumnWidth(1.1),
      2: const FlexColumnWidth(1.1),
      3: const FlexColumnWidth(1.0),
      4: const FlexColumnWidth(1.0),
      5: const FlexColumnWidth(1.0),
      6: const FlexColumnWidth(1.0),
      7: const FlexColumnWidth(1.0),
      8: const FlexColumnWidth(1.0),
      9: const FlexColumnWidth(1.0),
    };

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white12),
      ),
      child: Table(
        columnWidths: columnWidths,
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
          horizontalInside: BorderSide(color: Colors.white12),
          bottom: BorderSide(color: Colors.white12),
        ),
        children: [
          TableRow(
            decoration: const BoxDecoration(color: Color(0xFF0E0E0E)),
            children: headers.map((h) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Text(
                  h,
                  style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w700),
                ),
              );
            }).toList(),
          ),
          ...rows.map((row) {
            return TableRow(
              decoration: const BoxDecoration(),
              children: [
                _cellText(row.date),
                _cellText(row.time),
                _cellText(row.asset),
                _orderTag(row.order),
                _statusText(row.status),
                _pipsText(row.pips),
                _cellText(row.entry),
                _cellText(row.sl),
                _cellText(row.tp1),
                _cellText(row.tp2),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _cellText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }

  Widget _orderTag(String order) {
    final isBuy = order.toLowerCase() == 'buy';
    final color = isBuy ? const Color(0xFF17BF63) : const Color(0xFFE54747);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          order.toUpperCase(),
          style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _statusText(String status) {
    final lower = status.toLowerCase();
    Color color = Colors.white;
    if (lower == 'tp1') color = const Color(0xFF17BF63);
    if (lower == 'sl') color = const Color(0xFFE54747);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          status,
          style: AppTextStyles.body.copyWith(color: color, fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _pipsText(String pips) {
    Color color = Colors.white;
    if (pips.startsWith('+')) color = const Color(0xFF17BF63);
    if (pips.startsWith('-')) color = const Color(0xFFE54747);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          pips,
          style: AppTextStyles.body.copyWith(color: color, fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  final List<Widget> children;
  final bool isHeader;
  const _HistoryRow({required this.children, required this.isHeader});

  @override
  Widget build(BuildContext context) {
    return Row(children: children);
  }
}

class HistoryRow {
  final String date;
  final String time;
  final String asset;
  final String order;
  final String status;
  final String pips;
  final String entry;
  final String sl;
  final String tp1;
  final String tp2;
  const HistoryRow({
    required this.date,
    required this.time,
    required this.asset,
    required this.order,
    required this.status,
    required this.pips,
    required this.entry,
    required this.sl,
    required this.tp1,
    required this.tp2,
  });
}

HistoryRow _mapSignalToRow(Signal s) {
  final created = s.createdAt is Timestamp ? (s.createdAt as Timestamp).toDate() : DateTime.now();
  final dateStr = DateFormat('dd/MM/yyyy').format(created);
  final timeStr = DateFormat('HH:mm').format(created);
  final parts = s.symbol.split('/');
  final asset = parts.isNotEmpty ? (parts.first.toUpperCase() == 'XAU' ? 'GOLD' : parts.first.toUpperCase()) : s.symbol;
  final order = s.type.toUpperCase();
  final status = (s.result ?? s.status).toString();
  final pips = s.pips != null ? (s.pips! >= 0 ? '+${s.pips}' : s.pips.toString()) : '-';

  String _fmt(num? v) => v == null ? '-' : v.toStringAsFixed(2);
  String _tp(int idx) {
    if (s.takeProfits.length > idx) {
      final v = s.takeProfits[idx];
      if (v is num) return v.toStringAsFixed(2);
      if (v is String) return v;
    }
    return '-';
  }

  return HistoryRow(
    date: dateStr,
    time: timeStr,
    asset: asset,
    order: order,
    status: status,
    pips: pips,
    entry: _fmt(s.entryPrice),
    sl: _fmt(s.stopLoss),
    tp1: _tp(0),
    tp2: _tp(1),
  );
}
