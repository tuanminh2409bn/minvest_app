import 'package:flutter/material.dart';
import 'package:minvest_forex_app/web/theme/text_styles.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

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

class SignalHistoryTable extends StatelessWidget {
  final List<HistoryRow> rows;
  const SignalHistoryTable({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    final headers = [
      AppLocalizations.of(context)!.date,
      AppLocalizations.of(context)!.timeGmt7,
      AppLocalizations.of(context)!.asset,
      AppLocalizations.of(context)!.orders,
      AppLocalizations.of(context)!.status,
      AppLocalizations.of(context)!.pips,
      AppLocalizations.of(context)!.entry,
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isNarrow = constraints.maxWidth < 900;
        final table = Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0B0D14), // Dark background for the table container
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white12),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: isNarrow ? 1100 : constraints.maxWidth),
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
                        _orderTag(row.order, context),
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
            ),
          ),
        );

        if (!isNarrow) return table;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                AppLocalizations.of(context)!.smallScreenRotationHint,
                style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12),
              ),
            ),
            table,
          ],
        );
      },
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

  Widget _orderTag(String order, BuildContext context) {
    final isBuy = order.toLowerCase() == 'buy';
    final color = isBuy ? const Color(0xFF17BF63) : const Color(0xFFE54747);
    final text = isBuy ? AppLocalizations.of(context)!.buy : (order.toLowerCase() == 'sell' ? AppLocalizations.of(context)!.sell : order);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text.toUpperCase(),
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
