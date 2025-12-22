import 'package:minvest_forex_app/features/signals/models/signal_model.dart';

class SignalAccessHelper {
  static bool canViewEntry(Signal signal, String? userTier, List<String> activeSubscriptions) {
    final tier = (userTier ?? 'free').toLowerCase();
    
    // Elite users see everything
    if (tier == 'elite') return true;

    final symbol = signal.symbol.toUpperCase();

    // Check Gold Package
    final isGoldSignal = symbol.contains('XAU');
    if (isGoldSignal && activeSubscriptions.contains('gold')) return true;

    // Check Crypto Package
    final isCryptoSignal = symbol.contains('BTC') || 
                           symbol.contains('ETH') || 
                           symbol.contains('BNB') || 
                           symbol.contains('CRYPTO');
    if (isCryptoSignal && activeSubscriptions.contains('crypto')) return true;

    // Check Forex Package
    // Forex is typically currency pairs (contains '/') but NOT Gold and NOT Crypto
    final isForexSignal = symbol.contains('/') && !isGoldSignal && !isCryptoSignal;
    if (isForexSignal && activeSubscriptions.contains('forex')) return true;

    return false;
  }
}
