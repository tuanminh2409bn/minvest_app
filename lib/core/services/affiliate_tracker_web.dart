// lib/core/services/affiliate_tracker_web.dart
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'affiliate_tracker.dart';

class WebAffiliateTracker implements AffiliateTracker {
  @override
  void initialize() {
    try {
      final uri = Uri.base;
      final ref = uri.queryParameters['ref'];

      if (ref != null && ref.isNotEmpty) {
        _saveRef(ref);
      }
    } catch (e) {
      if (kDebugMode) print('Affiliate tracking error: $e');
    }
  }

  void _saveRef(String refCode) {
    try {
      // 1. Lưu vào LocalStorage
      html.window.localStorage['sg_ref'] = refCode;
      html.window.localStorage['sg_ref_ts'] = DateTime.now().millisecondsSinceEpoch.toString();
      
      // 2. Lưu vào Cookie (hạn 90 ngày)
      final expiry = DateTime.now().add(const Duration(days: 90));
      final cookieString = "sg_ref=$refCode; expires=${expiry.toUtc().toIso8601String()}; path=/; SameSite=Lax";
      html.document.cookie = cookieString;
      
      if (kDebugMode) print('✅ Affiliate Ref Captured (Web): $refCode');
    } catch (e) {
      if (kDebugMode) print('❌ Error saving affiliate ref: $e');
    }
  }

  @override
  String? getStoredRef() {
    final storedRef = html.window.localStorage['sg_ref'];
    final storedTs = html.window.localStorage['sg_ref_ts'];
    
    if (storedRef != null && storedTs != null) {
      final ts = int.tryParse(storedTs) ?? 0;
      final now = DateTime.now().millisecondsSinceEpoch;
      
      // Kiểm tra hạn 90 ngày
      if (now - ts <= 7776000000) {
        return storedRef;
      } else {
        clearRef();
      }
    }
    return null;
  }

  @override
  String? getStoredRefTimestamp() {
    return html.window.localStorage['sg_ref_ts'];
  }

  @override
  void clearRef() {
    html.window.localStorage.remove('sg_ref');
    html.window.localStorage.remove('sg_ref_ts');
    html.document.cookie = "sg_ref=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/";
  }
}

AffiliateTracker getAffiliateTracker() => WebAffiliateTracker();
