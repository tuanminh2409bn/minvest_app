// lib/core/services/affiliate_tracker_stub.dart
import 'affiliate_tracker.dart';

class MobileAffiliateTracker implements AffiliateTracker {
  @override
  void initialize() {
    // Không làm gì trên Mobile để tuân thủ quy định của Apple
  }

  @override
  String? getStoredRef() => null;

  @override
  String? getStoredRefTimestamp() => null;

  @override
  void clearRef() {}
}

AffiliateTracker getAffiliateTracker() => MobileAffiliateTracker();
