// lib/core/services/affiliate_tracker_web.dart
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'affiliate_tracker.dart';

class WebAffiliateTracker implements AffiliateTracker {
  @override
  void initialize() {
    try {
      // 1. Kiểm tra từ Uri.base (cách của Flutter)
      final uri = Uri.base;
      String? ref = uri.queryParameters['ref'];

      // 2. Nếu không thấy, kiểm tra trực tiếp từ window.location.href (đảm bảo bắt được cả khi có dấu # hoặc redirect)
      if (ref == null || ref.isEmpty) {
        final fullUrl = html.window.location.href;
        if (fullUrl.contains('ref=')) {
          final uriTemp = Uri.parse(fullUrl.replaceFirst('#/', ''));
          ref = uriTemp.queryParameters['ref'];
        }
      }

      if (ref != null && ref.isNotEmpty) {
        print('🌐 [Affiliate] Bắt được mã từ URL: $ref');
        _saveRef(ref);
      } else {
        final stored = getStoredRef();
        if (stored != null) {
          print('🌐 [Affiliate] Đang sử dụng mã đã lưu trong máy: $stored');
        } else {
          print('🌐 [Affiliate] Không tìm thấy mã giới thiệu nào.');
        }
      }
    } catch (e) {
      print('🌐 [Affiliate] Lỗi initialize: $e');
    }
  }

  void _saveRef(String refCode) {
    try {
      final nowTs = DateTime.now().millisecondsSinceEpoch.toString();
      // 1. Lưu vào LocalStorage
      html.window.localStorage['sg_ref'] = refCode;
      html.window.localStorage['sg_ref_ts'] = nowTs;
      
      // 2. Lưu vào Cookie (hạn 90 ngày) để bền vững hơn qua các subdomain
      final expiry = DateTime.now().add(const Duration(days: 90));
      final cookieString = "sg_ref=$refCode; expires=${expiry.toUtc().toIso8601String()}; path=/; SameSite=Lax";
      html.document.cookie = cookieString;
      
      print('🌐 [Affiliate] Đã lưu mã thành công: $refCode');
    } catch (e) {
      print('🌐 [Affiliate] Lỗi khi lưu mã: $e');
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

  @override
  void saveRef(String refCode) {
    _saveRef(refCode);
  }
}

AffiliateTracker getAffiliateTracker() => WebAffiliateTracker();
