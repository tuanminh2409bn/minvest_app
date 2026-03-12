// lib/core/services/affiliate_tracker_stub.dart
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'affiliate_tracker.dart';

class MobileAffiliateTracker implements AffiliateTracker {
  static const String _refKey = 'sg_ref';
  static const String _tsKey = 'sg_ref_ts';

  @override
  FutureOr<void> initialize() {
    // On mobile, initialization might happen via Deep Links (Firebase Dynamic Links)
    // or manual entry. For now, we just ensure the service is ready.
  }

  @override
  Future<void> saveRef(String refCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refKey, refCode);
    await prefs.setString(_tsKey, DateTime.now().millisecondsSinceEpoch.toString());
  }

  @override
  Future<String?> getStoredRef() async {
    final prefs = await SharedPreferences.getInstance();
    final storedRef = prefs.getString(_refKey);
    final storedTs = prefs.getString(_tsKey);

    if (storedRef != null && storedTs != null) {
      final ts = int.tryParse(storedTs) ?? 0;
      final now = DateTime.now().millisecondsSinceEpoch;

      // 90 days limit (same as web)
      if (now - ts <= 7776000000) {
        return storedRef;
      } else {
        await clearRef();
      }
    }
    return null;
  }

  @override
  Future<String?> getStoredRefTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tsKey);
  }

  @override
  Future<void> clearRef() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_refKey);
    await prefs.remove(_tsKey);
  }
}

AffiliateTracker getAffiliateTracker() => MobileAffiliateTracker();
