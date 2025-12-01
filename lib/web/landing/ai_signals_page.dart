import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/spacing.dart';
import '../theme/gradients.dart';
import 'widgets/navbar.dart';
import 'sections/footer_section.dart';
import 'sections/pricing_tab.dart';

enum AISignalsTab { aiSignals, performance, history, pricing }

class AISignalsPage extends StatefulWidget {
  const AISignalsPage({super.key});

  @override
  State<AISignalsPage> createState() => _AISignalsPageState();
}

class _AISignalsPageState extends State<AISignalsPage> {
  AISignalsTab selectedTab = AISignalsTab.aiSignals;

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
                  if (selectedTab == AISignalsTab.aiSignals) ...const [
                    _FiltersRow(),
                    SizedBox(height: 32),
                    _SignalGrid(),
                  ] else if (selectedTab == AISignalsTab.performance) ...const [
                    _PerformanceSection(),
                  ] else if (selectedTab == AISignalsTab.history) ...const [
                    _FiltersRow(),
                    SizedBox(height: 24),
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
  const _FiltersRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: const [
        _FilterDropdown(label: 'Asset', value: 'All Assets'),
        _FilterDropdown(label: 'Currency pairs', value: 'All Currency pairs'),
        _FilterDropdown(label: 'Date Range', value: 'Select Date Range', width: 260),
        _TimezoneDropdown(),
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

class _SignalGrid extends StatelessWidget {
  const _SignalGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double columnWidth = (constraints.maxWidth - 32) / 3;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: columnWidth,
              child: const _SignalColumn(
                title: 'GOLD',
                icon: Icons.emoji_events_outlined,
                cards: [
                  SignalCardData(
                    pair: 'XAUUSD',
                    status: 'Limit',
                    createdAt: '(GMT +7) 21/10/2025, 17:12:44',
                    action: SignalAction.sell,
                  ),
                  SignalCardData(
                    pair: 'XAUUSD',
                    status: 'Running',
                    createdAt: '(GMT +7) 21/10/2025, 17:12:44',
                    action: SignalAction.sell,
                  ),
                  SignalCardData(
                    pair: 'XAUUSD',
                    status: 'S/L',
                    createdAt: '(GMT +7) 21/10/2025, 17:12:44',
                    action: SignalAction.sell,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: columnWidth,
              child: const _SignalColumn(
                title: 'FOREX',
                icon: Icons.verified,
                cards: [
                  SignalCardData(
                    pair: 'EURUSD',
                    status: 'S/L',
                    createdAt: '(GMT +7) 21/10/2025, 17:12:44',
                    action: SignalAction.sell,
                    iconData: Icons.currency_exchange,
                  ),
                  SignalCardData(
                    pair: 'USDJPY',
                    status: '',
                    createdAt: '(GMT +7) 21/10/2025, 17:12:44',
                    action: SignalAction.buy,
                    iconData: Icons.currency_bitcoin,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: columnWidth,
              child: const _EmptyColumn(title: 'CRYPTO', icon: Icons.workspace_premium_outlined),
            ),
          ],
        );
      },
    );
  }
}

class _SignalColumn extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<SignalCardData> cards;
  const _SignalColumn({required this.title, required this.icon, required this.cards});

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
        ...cards.map((c) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SignalCard(data: c),
            )),
      ],
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
          height: 200,
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

enum SignalAction { buy, sell }

class SignalCardData {
  final String pair;
  final String status;
  final String createdAt;
  final SignalAction action;
  final IconData? iconData;
  const SignalCardData({
    required this.pair,
    required this.status,
    required this.createdAt,
    required this.action,
    this.iconData,
  });
}

class SignalCard extends StatelessWidget {
  final SignalCardData data;
  const SignalCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isSell = data.action == SignalAction.sell;
    final actionColor = isSell ? const Color(0xFFE54747) : const Color(0xFF3DCC5C);
    final icon = data.iconData ?? Icons.circle;
    return Container(
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
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                data.pair,
                style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              if (data.status.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D1D1D),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Text(
                    data.status,
                    style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text('Created:', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            data.createdAt,
            style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              isSell ? 'Sell' : 'Buy',
              style: AppTextStyles.body.copyWith(
                color: actionColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Details',
                style: AppTextStyles.body.copyWith(color: Colors.white70, fontSize: 13),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 14),
            ],
          ),
        ],
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

class _HistorySection extends StatelessWidget {
  const _HistorySection();

  @override
  Widget build(BuildContext context) {
    const rows = [
      HistoryRow(
        date: '28/10/2025',
        time: '10:14',
        asset: 'GOLD',
        order: 'BUY',
        status: 'Cancel',
        pips: '0',
        entry: '4011',
        sl: '4026',
        tp1: '4000',
        tp2: '3995',
      ),
      HistoryRow(
        date: '28/10/2025',
        time: '19:10',
        asset: 'GOLD',
        order: 'BUY',
        status: 'TP1',
        pips: '+180',
        entry: '4011',
        sl: '3998',
        tp1: '4000',
        tp2: '3995',
      ),
      HistoryRow(
        date: '28/10/2025',
        time: '19:10',
        asset: 'GOLD',
        order: 'BUY',
        status: 'SL',
        pips: '-170',
        entry: '4011',
        sl: '3998',
        tp1: '4000',
        tp2: '3995',
      ),
      HistoryRow(
        date: '28/10/2025',
        time: '19:10',
        asset: 'GOLD',
        order: 'SELL',
        status: 'TP1',
        pips: '+180',
        entry: '4011',
        sl: '3998',
        tp1: '4000',
        tp2: '3995',
      ),
      HistoryRow(
        date: '28/10/2025',
        time: '19:10',
        asset: 'GOLD',
        order: 'BUY',
        status: 'TP1',
        pips: '+180',
        entry: '4011',
        sl: '3998',
        tp1: '4000',
        tp2: '3995',
      ),
      HistoryRow(
        date: '28/10/2025',
        time: '19:10',
        asset: 'GOLD',
        order: 'BUY',
        status: 'TP1',
        pips: '+180',
        entry: '4011',
        sl: '3998',
        tp1: '4000',
        tp2: '3995',
      ),
      HistoryRow(
        date: '28/10/2025',
        time: '19:10',
        asset: 'GOLD',
        order: 'BUY',
        status: 'TP1',
        pips: '+180',
        entry: '4011',
        sl: '3998',
        tp1: '4000',
        tp2: '3995',
      ),
      HistoryRow(
        date: '28/10/2025',
        time: '19:10',
        asset: 'GOLD',
        order: 'BUY',
        status: 'TP1',
        pips: '+180',
        entry: '4011',
        sl: '3998',
        tp1: '4000',
        tp2: '3995',
      ),
      HistoryRow(
        date: '28/10/2025',
        time: '19:10',
        asset: 'GOLD',
        order: 'SELL',
        status: 'SL',
        pips: '-170',
        entry: '4011',
        sl: '3998',
        tp1: '4000',
        tp2: '3995',
      ),
    ];

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
        _HistoryTable(rows: rows),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Previous', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 13)),
            const SizedBox(width: 24),
            Text('Page 3 of 53', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 13)),
            const SizedBox(width: 24),
            Text('Next', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 13)),
          ],
        ),
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
