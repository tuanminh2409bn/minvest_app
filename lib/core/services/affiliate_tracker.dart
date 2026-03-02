// lib/core/services/affiliate_tracker.dart
import 'affiliate_tracker_stub.dart'
    if (dart.library.html) 'affiliate_tracker_web.dart';

abstract class AffiliateTracker {
  /// Factory constructor sẽ tự động chọn đúng implementation tùy theo nền tảng
  factory AffiliateTracker() => getAffiliateTracker();
  
  void initialize();
  String? getStoredRef();
  String? getStoredRefTimestamp();
  void clearRef();
}
