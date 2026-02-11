// lib/features/signals/screens/signal_history_screen.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/features/signals/models/signal_model.dart';
import 'package:minvest_forex_app/features/signals/services/signal_service.dart';
import 'package:minvest_forex_app/features/signals/screens/signal_trading_history_screen.dart';
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
  final List<String> _timezones = [for (int i = -12; i <= 14; i++) 'GMT${i >= 0 ? '+' : ''}$i'];

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
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Signal History',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),

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
                    padding: EdgeInsets.zero,
                    itemCount: filteredSignals.length,
                    itemExtent: 55,
                    itemBuilder: (context, index) {
                      return _buildHistoryItem(filteredSignals[index], index, l10n);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 90),
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
    return _buildDropdownWrapper(
      value: _assetCategory,
      items: [
        const DropdownMenuItem(value: AssetCategory.all, child: Text('All Assets')),
        const DropdownMenuItem(value: AssetCategory.gold, child: Text('Gold')),
        const DropdownMenuItem(value: AssetCategory.crypto, child: Text('Crypto')),
        const DropdownMenuItem(value: AssetCategory.forex, child: Text('Forex')),
      ],
      onChanged: (v) => setState(() => _assetCategory = v as AssetCategory),
    );
  }

  Widget _buildGMTDropdown() {
    return _buildDropdownWrapper(
      value: _selectedGMT,
      items: _timezones.map((tz) => DropdownMenuItem(value: tz, child: Text(tz))).toList(),
      onChanged: (v) => setState(() => _selectedGMT = v as String),
    );
  }

  Widget _buildStatusDropdown() {
    return _buildDropdownWrapper(
      value: _selectedStatus,
      items: _statusOptions.map((st) => DropdownMenuItem(value: st, child: Text(st))).toList(),
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
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 483,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.00, 0.78),
                end: const Alignment(1.00, 0.20),
                colors: [Colors.white.withValues(alpha: 0.83), Colors.white.withValues(alpha: 0.44)],
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Colors.white.withValues(alpha: 0.50)),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              shadows: const [
                BoxShadow(color: Color(0x3F8D8D8D), blurRadius: 22.97, offset: Offset(0, -6)),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xFF276EFB),
                  onPrimary: Colors.white,
                  surface: Colors.transparent,
                  onSurface: Colors.black,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(2))),
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

  Widget _buildDropdownWrapper({required dynamic value, required List<DropdownMenuItem> items, required Function onChanged}) {
    return Container(
      height: 41,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: _filterDecoration(),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1A1A1A),
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF686868), size: 18),
          style: const TextStyle(color: Color(0xFF686868), fontSize: 14),
          items: items,
          onChanged: (v) => onChanged(v),
        ),
      ),
    );
  }

  Decoration _filterDecoration() { // Sửa từ BoxDecoration thành Decoration
    return ShapeDecoration(
      gradient: LinearGradient(
        begin: const Alignment(0.00, 1.00),
        end: const Alignment(1.00, 0.12),
        colors: [Colors.white.withValues(alpha: 0.15), Colors.white.withValues(alpha: 0.05)],
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Colors.white.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  Widget _buildFilterBox(String label, String value) {
    return Container(
      height: 41,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: _filterDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, style: const TextStyle(color: Color(0xFF686868), fontSize: 14)),
          const Icon(Icons.keyboard_arrow_down, color: Color(0xFF686868), size: 18),
        ],
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
        height: 55,
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
                  Text(signal.symbol.replaceAll('/', ''), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)),
                  Text(formattedDate, style: const TextStyle(color: Color(0xFF636363), fontSize: 12)),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(signal.getTranslatedResult(l10n), textAlign: TextAlign.center, style: TextStyle(color: signal.getStatusColor(), fontSize: 14)),
            ),
            Expanded(
              flex: 1,
              child: Text(
                signal.closedPips != null ? (signal.closedPips! >= 0 ? '+${signal.closedPips!.toStringAsFixed(0)}' : '${signal.closedPips!.toStringAsFixed(0)}') : '-',
                textAlign: TextAlign.center,
                style: TextStyle(color: (signal.closedPips ?? 0) >= 0 ? const Color(0xFF00BB32) : const Color(0xFFE3001E), fontSize: 14),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(signal.closedPrice?.toStringAsFixed(2) ?? '-', textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF636363), fontSize: 14)),
            ),
            Expanded(
              flex: 1,
              child: Text(
                signal.type.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(color: signal.type.toLowerCase() == 'buy' ? const Color(0xFF00BB32) : const Color(0xFFE3001E), fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
