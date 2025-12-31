import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minvest_forex_app/web/theme/text_styles.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/features/signals/models/signal_model.dart';

class HistoryRow {
  final Signal originalSignal;
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
  final String tp3;
  final String closedPrice;

  const HistoryRow({
    required this.originalSignal,
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
    required this.tp3,
    required this.closedPrice,
  });
}

class SignalHistoryTable extends StatelessWidget {
  final List<HistoryRow> rows;
  const SignalHistoryTable({super.key, required this.rows});

  void _showSignalProgress(BuildContext context, Signal signal) {
    showDialog(
      context: context,
      builder: (context) => _SignalProgressPopup(signal: signal),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsiveness
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    // Define columns based on screen size
    final Map<int, TableColumnWidth> columnWidths;
    final List<String> headers;

    if (isMobile) {
      headers = [
        AppLocalizations.of(context)!.date,
        AppLocalizations.of(context)!.timeGmt7,
        AppLocalizations.of(context)!.asset,
        AppLocalizations.of(context)!.orders,
        AppLocalizations.of(context)!.pips,
      ];
      columnWidths = {
        0: const FlexColumnWidth(1.2), // Date
        1: const FlexColumnWidth(1.0), // Time
        2: const FlexColumnWidth(1.2), // Asset
        3: const FlexColumnWidth(1.2), // Order
        4: const FlexColumnWidth(1.0), // Pips
      };
    } else {
      headers = [
        AppLocalizations.of(context)!.date,
        AppLocalizations.of(context)!.timeGmt7,
        AppLocalizations.of(context)!.asset,
        AppLocalizations.of(context)!.orders,
        AppLocalizations.of(context)!.status,
        AppLocalizations.of(context)!.pips,
        AppLocalizations.of(context)!.entry,
        'Closed Price',
        'SL',
        'TP1',
        'TP2',
        'TP3',
      ];
      columnWidths = {
        0: const FlexColumnWidth(1.1), // Date
        1: const FlexColumnWidth(0.9), // Time
        2: const FlexColumnWidth(1.0), // Asset
        3: const FlexColumnWidth(1.0), // Order
        4: const FlexColumnWidth(1.0), // Status
        5: const FlexColumnWidth(0.9), // Pips
        6: const FlexColumnWidth(1.1), // Entry
        7: const FlexColumnWidth(1.1), // Closed
        8: const FlexColumnWidth(1.0), // SL
        9: const FlexColumnWidth(1.0), // TP1
        10: const FlexColumnWidth(1.0), // TP2
        11: const FlexColumnWidth(1.0), // TP3
      };
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
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
          // Header Row
          TableRow(
            decoration: const BoxDecoration(color: Color(0xFF0D0D0D)),
            children: headers.map((h) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                child: Text(
                  h,
                  style: AppTextStyles.caption.copyWith(
                      color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
          ),
          // Data Rows
          ...rows.map((row) {
            final cells = isMobile
                ? [
                    _cellText(row.date),
                    _cellText(row.time),
                    _cellText(row.asset),
                    _orderTag(row.order, context),
                    _pipsText(row.pips),
                  ]
                : [
                    _cellText(row.date),
                    _cellText(row.time),
                    _cellText(row.asset),
                    _orderTag(row.order, context),
                    _statusText(row.status),
                    _pipsText(row.pips),
                    _cellText(row.entry),
                    _closedPriceText(row),
                    _cellText(row.sl),
                    _cellText(row.tp1),
                    _cellText(row.tp2),
                    _cellText(row.tp3),
                  ];

            return TableRow(
              decoration: const BoxDecoration(),
              children: cells.map((cell) {
                return InkWell(
                  onTap: () => _showSignalProgress(context, row.originalSignal),
                  child: cell,
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _closedPriceText(HistoryRow row) {
    Color color = Colors.white;
    final status = row.status.toLowerCase();

    if (status.contains('tp')) {
      color = const Color(0xFF1DA1F2); // Blue for TP
    } else if (status.contains('sl')) {
      color = const Color(0xFFE54747); // Red for SL
    } else {
      if (row.pips.startsWith('+')) {
        color = const Color(0xFF17BF63); // Green for positive exit
      } else if (row.pips.startsWith('-')) {
        color = const Color(0xFFE54747); // Red for negative exit
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Text(
        row.closedPrice,
        style: AppTextStyles.body.copyWith(
            color: color, fontSize: 13, fontWeight: FontWeight.w700),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _cellText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Text(
        text,
        style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 13),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _orderTag(String order, BuildContext context) {
    final isBuy = order.toLowerCase() == 'buy';
    final color = isBuy ? const Color(0xFF17BF63) : const Color(0xFFE54747);
    final text = isBuy
        ? AppLocalizations.of(context)!.buy
        : (order.toLowerCase() == 'sell'
            ? AppLocalizations.of(context)!.sell
            : order);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text.toUpperCase(),
            style: AppTextStyles.body.copyWith(
                color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _statusText(String status) {
    final lower = status.toLowerCase();
    Color color = Colors.white;
    if (lower.contains('tp')) color = const Color(0xFF17BF63);
    if (lower.contains('sl')) color = const Color(0xFFE54747);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Text(
        status,
        style: AppTextStyles.body.copyWith(
            color: color, fontSize: 13, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _pipsText(String pips) {
    Color color = Colors.white;
    if (pips.startsWith('+')) color = const Color(0xFF17BF63);
    if (pips.startsWith('-')) color = const Color(0xFFE54747);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Text(
        pips,
        style: AppTextStyles.body.copyWith(
            color: color, fontSize: 13, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// --- POPUP WIDGETS ---

class _SignalProgressPopup extends StatelessWidget {
  final Signal signal;
  const _SignalProgressPopup({required this.signal});

  String _getAssetGroup(String symbol) {
    final s = symbol.toUpperCase();
    if (s.contains('XAU')) return 'GOLD';
    if (s.contains('BTC')) return 'BITCOIN';
    if (s.contains('ETH')) return 'ETHEREUM';
    return symbol; // Default to symbol name
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isBuy = signal.type.toLowerCase() == 'buy';
    final accentColor = isBuy ? const Color(0xFF3DCC5C) : const Color(0xFFE54747);
    
    // Header Info
    final assetGroup = _getAssetGroup(signal.symbol);
    final statusText = signal.getTranslatedResult(l10n).toUpperCase();
    final typeText = isBuy ? l10n.buy : l10n.sell;
    
    // Process steps
    final steps = _buildSteps();
    final activeStepIndex = _calculateActiveStep(steps);
    
    // Status Logs
    final logs = _buildLogs(l10n);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: 500,
        constraints: const BoxConstraints(maxHeight: 600),
        decoration: BoxDecoration(
          color: const Color(0xFF0F0F0F),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white12),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.15),
              blurRadius: 40,
              spreadRadius: -10,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Updated
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white12)),
                  ),
                  child: Row(
                    children: [
                      // Asset Group
                      Flexible(
                        child: Text(
                          assetGroup,
                          style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Status Text (Instead of Price)
                      Flexible(
                        child: Text(
                          statusText,
                          style: AppTextStyles.body.copyWith(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Icon Up/Down Diagonal
                      Icon(
                        isBuy ? Icons.north_east : Icons.south_east, 
                        color: accentColor,
                        size: 20,
                      ),
                      const SizedBox(width: 4),

                      // Buy/Sell Text
                      Text(
                        typeText.toUpperCase(),
                        style: AppTextStyles.body.copyWith(color: accentColor, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      
                      // Add spacer to push content left, leaving room for X button
                      const Spacer(),
                      const SizedBox(width: 32), // Reserve space for the close button
                    ],
                  ),
                ),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Progress Stepper
                        Text(
                          l10n.signalProgress,
                          style: AppTextStyles.caption.copyWith(color: Colors.white54, fontSize: 12),
                        ),
                        const SizedBox(height: 24),
                        _VisualStepper(
                          steps: steps,
                          activeIndex: activeStepIndex,
                          accentColor: accentColor,
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Status History
                        Text(
                          l10n.statusHistory,
                          style: AppTextStyles.caption.copyWith(color: Colors.white54, fontSize: 12),
                        ),
                        const SizedBox(height: 16),
                        ...logs.map((log) => _HistoryLogItem(log: log)),
                        
                        if (logs.isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              l10n.noHistoryAvailable,
                              style: AppTextStyles.body.copyWith(color: Colors.white30, fontSize: 13),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Absolute Close Button
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white70),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<_StepData> _buildSteps() {
    final List<_StepData> steps = [];
    
    // 1. SL
    final slHit = signal.result?.toLowerCase().contains('sl') ?? false;
    steps.add(_StepData(label: 'SL', price: signal.stopLoss, isHit: slHit, isFailure: true));
    
    // 2. Entry
    steps.add(_StepData(label: 'Entry', price: signal.entryPrice, isHit: true, isNeutral: true));
    
    // 3. TPs
    for (int i = 0; i < signal.takeProfits.length; i++) {
      if (i >= 3) break; // Max TP3
      final tp = signal.takeProfits[i];
      double? price;
      if (tp is num) price = tp.toDouble();
      
      final idx = i + 1; // 1-based index
      final isHit = signal.hitTps.contains(idx);
      steps.add(_StepData(label: 'TP$idx', price: price, isHit: isHit));
    }
    
    return steps;
  }
  
  int _calculateActiveStep(List<_StepData> steps) {
    if (signal.result?.toLowerCase().contains('sl') ?? false) {
      return 0; // Stop at SL
    }
    
    int maxTp = 0;
    if (signal.hitTps.isNotEmpty) {
      maxTp = signal.hitTps.reduce((curr, next) => curr > next ? curr : next);
    }
    
    if (maxTp > 0) {
      return 1 + maxTp; // Entry is index 1, so TP1 is 2.
    }
    
    return 1; 
  }

  List<_LogData> _buildLogs(AppLocalizations l10n) {
    final List<_LogData> logs = [];
    
    // Created
    logs.add(_LogData(
      date: signal.createdAt.toDate(),
      status: l10n.signalCreated,
      description: '${l10n.entry}: ${signal.entryPrice}',
      color: Colors.white54,
    ));

    // Match Status (Running)
    if (signal.isMatched) {
        logs.add(_LogData(
        date: signal.createdAt.toDate().add(const Duration(minutes: 5)),
        status: l10n.signalMatched,
        description: l10n.matched,
        color: Colors.blueAccent,
      ));
    }

    // TPs Hit
    final sortedTps = List<int>.from(signal.hitTps)..sort();
    for (var tpIdx in sortedTps) {
       logs.add(_LogData(
        date: signal.createdAt.toDate().add(Duration(hours: tpIdx)), 
        status: 'TP$tpIdx ${l10n.live}', // Placeholder or generic
        description: l10n.targetReached,
        color: const Color(0xFF3DCC5C),
      ));
    }

    // SL Hit / Result
    if (signal.result != null && signal.result!.isNotEmpty) {
        final r = signal.result!.toLowerCase();
        if (r.contains('sl')) {
           logs.add(_LogData(
            date: signal.createdAt.toDate().add(const Duration(hours: 4)),
            status: l10n.slHit,
            description: '${l10n.signalClosed} @ ${signal.stopLoss}',
            color: const Color(0xFFE54747),
          ));
        } else if (r.contains('cancelled')) {
             logs.add(_LogData(
            date: signal.createdAt.toDate().add(const Duration(hours: 1)),
            status: l10n.cancelled,
            description: l10n.signalClosed,
            color: Colors.orange,
          ));
        }
    }
    
    return logs.reversed.toList();
  }
}

class _StepData {
  final String label;
  final double? price;
  final bool isHit;
  final bool isFailure; // For SL
  final bool isNeutral; // For Entry

  _StepData({
    required this.label, 
    this.price, 
    this.isHit = false, 
    this.isFailure = false,
    this.isNeutral = false,
  });
}

class _LogData {
  final DateTime date;
  final String status;
  final String description;
  final Color color;
  _LogData({required this.date, required this.status, required this.description, required this.color});
}

class _VisualStepper extends StatelessWidget {
  final List<_StepData> steps;
  final int activeIndex;
  final Color accentColor;

  const _VisualStepper({
    required this.steps,
    required this.activeIndex,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Line
          Positioned(
            left: 20,
            right: 20,
            top: 24,
            child: Container(
              height: 2,
              color: Colors.white10,
            ),
          ),
          // Active Line (Progress)
          Positioned(
            left: 20,
            right: 20, // This needs to be calculated dynamically in a real stepper, simplifying for now
            top: 24,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (steps.isEmpty) return const SizedBox.shrink();
                final stepWidth = constraints.maxWidth / (steps.length - 1);
                // Clamp width to the active node
                final width = stepWidth * activeIndex;
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: width,
                    height: 2,
                    color: _getLineColor(),
                  ),
                );
              },
            ),
          ),
          // Nodes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              final isActive = index <= activeIndex;
              final isCurrent = index == activeIndex;
              
              Color nodeColor = Colors.white12;
              Color textColor = Colors.white38;
              
              if (isActive) {
                if (step.isFailure && isCurrent) {
                  nodeColor = const Color(0xFFE54747);
                  textColor = const Color(0xFFE54747);
                } else if (step.isNeutral) {
                  nodeColor = Colors.white;
                  textColor = Colors.white;
                } else {
                  nodeColor = accentColor;
                  textColor = accentColor;
                }
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: nodeColor,
                          width: isCurrent ? 3 : 2,
                        ),
                        boxShadow: isCurrent ? [
                          BoxShadow(color: nodeColor.withOpacity(0.5), blurRadius: 8, spreadRadius: 1)
                        ] : null,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      step.label,
                      style: AppTextStyles.caption.copyWith(
                        color: textColor, 
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                      ),
                    ),
                    if (step.price != null)
                      Text(
                        step.price.toString(),
                        style: AppTextStyles.caption.copyWith(color: Colors.white24, fontSize: 10),
                      ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getLineColor() {
     // If stopped at SL, line is red
     if (steps.isNotEmpty && steps[0].isHit && activeIndex == 0) return const Color(0xFFE54747);
     return accentColor;
  }
}

class _HistoryLogItem extends StatelessWidget {
  final _LogData log;
  const _HistoryLogItem({required this.log});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: log.color,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 1,
                height: 24, // Short line
                color: Colors.white10,
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      log.status,
                      style: AppTextStyles.body.copyWith(
                        color: log.color, 
                        fontWeight: FontWeight.w600,
                        fontSize: 14
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM HH:mm').format(log.date),
                      style: AppTextStyles.caption.copyWith(color: Colors.white30, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  log.description,
                  style: AppTextStyles.caption.copyWith(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
