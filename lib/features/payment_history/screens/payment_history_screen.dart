import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/payment_history_provider.dart';
import '../models/transaction_model.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentHistoryProvider>().fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.paymentHistory,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
            fontFamily: 'Be Vietnam Pro',
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<PaymentHistoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF276EFB)));
          }

          if (provider.error != null) {
            return Center(
              child: Text(
                'Error: ${provider.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (provider.transactions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 64, color: Colors.white.withValues(alpha: 0.2)),
                  const SizedBox(height: 16),
                  Text(
                    l10n.noTransactionsFound,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 16,
                      fontFamily: 'Be Vietnam Pro',
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            itemCount: provider.transactions.length,
            itemBuilder: (context, index) {
              final transaction = provider.transactions[index];
              return _buildTransactionItem(transaction, l10n);
            },
          );
        },
      ),
    );
  }

  Widget _buildTransactionItem(TransactionModel transaction, AppLocalizations l10n) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    final String formattedDate = formatter.format(transaction.timestamp);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-1.0, -2.0),
          end: const Alignment(1.0, 2.0),
          colors: [
            Colors.white.withValues(alpha: 0.6),
            Colors.white.withValues(alpha: 0.1),
            Colors.white.withValues(alpha: 0.1),
            Colors.white.withValues(alpha: 0.8),
          ],
          stops: const [0.0, 0.07, 0.88, 1.0],
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.all(1), // Border width
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                transaction.platform == 'ios' ? Icons.apple : Icons.android,
                color: Colors.white.withValues(alpha: 0.7),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getProductName(transaction.productId, l10n),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Be Vietnam Pro',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                      fontFamily: 'Be Vietnam Pro',
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatAmount(transaction),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Be Vietnam Pro',
                  ),
                ),
                const SizedBox(height: 4),
                _buildStatusBadge(transaction.status, l10n),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getProductName(String productId, AppLocalizations l10n) {
    if (productId.contains('month') || productId.contains('.01')) {
      return 'ELITE 1 Month';
    } else if (productId.contains('year') || productId.contains('12')) {
      return 'ELITE 12 Months';
    }
    return productId;
  }

  String _formatAmount(TransactionModel transaction) {
    if (transaction.amount == 0) {
      if (transaction.productId.contains('month') || transaction.productId.contains('.01')) {
        return '\$15.00';
      } else {
        return '\$99.00';
      }
    }
    return '${transaction.currency == 'USD' ? '\$' : ''}${transaction.amount.toStringAsFixed(2)}';
  }

  Widget _buildStatusBadge(String status, AppLocalizations l10n) {
    Color color;
    String text;

    switch (status.toLowerCase()) {
      case 'purchased':
      case 'success':
        color = const Color(0xFF276EFB);
        text = l10n.statusSuccess;
        break;
      case 'pending':
        color = Colors.orange;
        text = 'Pending';
        break;
      case 'error':
      case 'failed':
        color = Colors.red;
        text = 'Failed';
        break;
      default:
        color = Colors.grey;
        text = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: 'Be Vietnam Pro',
        ),
      ),
    );
  }
}
