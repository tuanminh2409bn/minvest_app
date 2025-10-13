// lib/features/admin/services/admin_service.dart

import 'package:cloud_functions/cloud_functions.dart';

class AdminService {
  final FirebaseFunctions _functions =
  FirebaseFunctions.instanceFor(region: "asia-southeast1");

  /// Cập nhật vai trò (subscriptionTier) cho danh sách người dùng.
  ///
  /// Gọi đến Cloud Function `updateUserSubscriptionTier` để thay đổi vai trò
  /// của người dùng thành [tier] với [reason] được cung cấp.
  Future<String> updateUserSubscriptionTier({
    required List<String> userIds,
    required String tier,
    required String reason,
  }) async {
    try {
      // 1. Đổi tên hàm callable để khớp với Cloud Function mới
      final callable = _functions.httpsCallable('updateUserSubscriptionTier');
      final result = await callable.call(<String, dynamic>{
        'userIds': userIds,
        'tier': tier,
        'reason': reason,
      });
      return result.data['message'] ?? 'Thao tác thành công!';
    } on FirebaseFunctionsException catch (e) {
      return e.message ?? 'Có lỗi xảy ra.';
    } catch (e) {
      return 'Đã có lỗi không xác định xảy ra.';
    }
  }
}