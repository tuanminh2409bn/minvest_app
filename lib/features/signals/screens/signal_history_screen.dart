// lib/features/signals/screens/signal_history_screen.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/features/signals/models/signal_model.dart';
import 'package:minvest_forex_app/features/signals/services/signal_service.dart';
import 'package:minvest_forex_app/features/signals/screens/signal_trading_history_screen.dart';
import 'package:minvest_forex_app/features/auth/screens/settings_screen.dart';
import 'package:minvest_forex_app/features/notifications/screens/notification_screen.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';
import 'package:minvest_forex_app/features/signals/widgets/custom_filter_dropdown.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

enum AssetCategory { all, gold, crypto, forex }

class SignalHistoryScreen extends StatefulWidget {
  const SignalHistoryScreen({super.key});

  @override
  State<SignalHistoryScreen> createState() => _SignalHistoryScreenState();
}

class _SignalHistoryScreenState extends State<SignalHistoryScreen> with AutomaticKeepAliveClientMixin {
  final SignalService _signalService = SignalService();
  
  AssetCategory _assetCategory = AssetCategory.all;
  String _selectedPair = 'All';
  String _selectedGMT = 'GMT+7';
  String _selectedStatus = 'ALL';
  DateTime? _selectedDate;

  late Stream<List<Signal>> _historyStream;

  final List<String> _statusOptions = ['ALL', 'TP1', 'TP2', 'TP3', 'SL', 'CANCELLED', 'EXIT'];
  final List<String> _timezones = [
    'GMT-12', 'GMT-11', 'GMT-10', 'GMT-9', 'GMT-8', 'GMT-7', 'GMT-6', 'GMT-5', 'GMT-4', 'GMT-3', 'GMT-2', 'GMT-1',
    'GMT+0', 'GMT+1', 'GMT+2', 'GMT+3', 'GMT+4', 'GMT+5', 'GMT+6', 'GMT+7', 'GMT+8', 'GMT+9', 'GMT+10', 'GMT+11', 'GMT+12'
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initStream();
  }

  void _initStream() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _historyStream = _signalService.getSignals(
      isLive: false,
      userTier: userProvider.userTier ?? 'free',
      limit: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final userProvider = context.watch<UserProvider>();
    final l10n = AppLocalizations.of(context)!;

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
          'Signal History',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(child: _buildAssetDropdown()),
                  const SizedBox(width: 12),
                  Expanded(child: _buildGMTDropdown()),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(child: _buildDatePicker()),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatusDropdown()),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: StreamBuilder<List<Signal>>(
                stream: _historyStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFF276EFB)));
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading history', style: TextStyle(color: Colors.redAccent)));
                  }
                  
                  final filteredSignals = _applyFilters(snapshot.data ?? []);

                  if (filteredSignals.isEmpty) {
                    return const Center(child: Text('No history found', style: TextStyle(color: Colors.white54)));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: filteredSignals.length,
                    itemExtent: 70,
                    itemBuilder: (context, index) {
                      return _buildHistoryItem(filteredSignals[index], index, l10n);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Signal> _applyFilters(List<Signal> signals) {
    return signals.where((s) {
      if (_assetCategory == AssetCategory.gold && !s.symbol.contains('XAU')) return false;
      if (_assetCategory == AssetCategory.crypto && !(s.symbol.contains('BTC') || s.symbol.contains('ETH'))) return false;
      if (_assetCategory == AssetCategory.forex && (s.symbol.contains('XAU') || s.symbol.contains('BTC') || s.symbol.contains('ETH'))) return false;

      if (_selectedDate != null) {
        final date = s.createdAt.toDate();
        if (date.day != _selectedDate!.day || date.month != _selectedDate!.month || date.year != _selectedDate!.year) return false;
      }

      if (_selectedStatus != 'ALL') {
        if (_selectedStatus == 'TP1') return s.hitTps.contains(1) && !s.hitTps.contains(2);
        if (_selectedStatus == 'TP2') return s.hitTps.contains(2) && !s.hitTps.contains(3);
        if (_selectedStatus == 'TP3') return s.hitTps.contains(3);
        if (_selectedStatus == 'SL') return (s.result ?? '').toUpperCase().contains('SL');
        if (_selectedStatus == 'CANCELLED') return s.status == 'cancelled' || (s.result ?? '').toLowerCase().contains('cancel');
        if (_selectedStatus == 'EXIT') return (s.result ?? '').toLowerCase().contains('exit');
      }

      return true;
    }).toList();
  }

  Widget _buildAssetDropdown() {
    return CustomFilterDropdown<AssetCategory>(
      value: _assetCategory,
      items: [
        CustomDropdownItem(value: AssetCategory.all, label: 'All Assets'),
        CustomDropdownItem(value: AssetCategory.gold, label: 'Gold'),
        CustomDropdownItem(value: AssetCategory.crypto, label: 'Crypto'),
        CustomDropdownItem(value: AssetCategory.forex, label: 'Forex'),
      ],
      onChanged: (v) => setState(() => _assetCategory = v as AssetCategory),
    );
  }

  Widget _buildGMTDropdown() {
    return CustomFilterDropdown<String>(
      value: _selectedGMT,
      items: _timezones.map((tz) => CustomDropdownItem(value: tz, label: tz)).toList(),
      onChanged: (v) => setState(() => _selectedGMT = v as String),
    );
  }

  Widget _buildStatusDropdown() {
    return CustomFilterDropdown<String>(
      value: _selectedStatus,
      items: _statusOptions.map((st) => CustomDropdownItem(value: st, label: st)).toList(),
      onChanged: (v) => setState(() => _selectedStatus = v as String),
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: _showCustomDatePicker,
      child: _buildFilterBox('Date', _selectedDate != null ? DateFormat('dd MMM').format(_selectedDate!) : 'Select Date'),
    );
  }

  void _showCustomDatePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 483,
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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xFF276EFB),
                  onPrimary: Colors.white,
                  surface: Colors.transparent,
                  onSurface: Colors.white,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Expanded(
                    child: CalendarDatePicker(
                      initialDate: _selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime.now(),
                      onDateChanged: (date) {
                        setState(() => _selectedDate = date);
                        Navigator.pop(context);
                      },
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

  Widget _buildFilterBox(String label, String value, {bool isSelected = false}) {
    return Container(
      height: 41,
      padding: const EdgeInsets.all(1), // Độ dày viền
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
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: TextStyle(
                color: isSelected ? const Color(0xFF276EFB) : const Color(0xFF686868),
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                fontFamily: 'Be Vietnam Pro',
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: isSelected ? const Color(0xFF276EFB) : const Color(0xFF686868), size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(Signal signal, int index, AppLocalizations l10n) {
    final bool isEven = index % 2 == 0;
    DateTime date = signal.createdAt.toDate();
    int offset = int.tryParse(_selectedGMT.replaceAll('GMT', '').replaceAll('+', '')) ?? 0;
    date = date.toUtc().add(Duration(hours: offset));
    final String formattedDate = DateFormat('dd MMM hh:mm a').format(date);
    
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignalTradingHistoryScreen(signal: signal)));
      },
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(color: isEven ? const Color(0xFF161616) : const Color(0xFF080808)),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    signal.symbol.replaceAll('/', ''),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    formattedDate,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Color(0xFF636363), fontSize: 12),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                signal.getTranslatedResult(l10n),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: signal.getStatusColor(), fontSize: 14),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                signal.closedPips != null ? (signal.closedPips! >= 0 ? '+${signal.closedPips!.toStringAsFixed(0)}' : '${signal.closedPips!.toStringAsFixed(0)}') : '-',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: (signal.closedPips ?? 0) >= 0 ? const Color(0xFF00BB32) : const Color(0xFFE3001E), fontSize: 14),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                signal.closedPrice?.toStringAsFixed(2) ?? '-',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xFF636363), fontSize: 14),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                signal.type.toUpperCase(),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: signal.type.toLowerCase() == 'buy' ? const Color(0xFF00BB32) : const Color(0xFFE3001E), fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
