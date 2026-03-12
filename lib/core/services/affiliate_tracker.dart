// lib/core/services/affiliate_tracker.dart
import 'dart:async';
import 'affiliate_tracker_stub.dart'
    if (dart.library.html) 'affiliate_tracker_web.dart';

abstract class AffiliateTracker {
  /// Factory constructor sẽ tự động chọn đúng implementation tùy theo nền tảng
  factory AffiliateTracker() => getAffiliateTracker();
  
  FutureOr<void> initialize();
  FutureOr<String?> getStoredRef();
  FutureOr<String?> getStoredRefTimestamp();
  FutureOr<void> clearRef();
  FutureOr<void> saveRef(String refCode);
}
