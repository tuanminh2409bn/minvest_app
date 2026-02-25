// lib/services/session_service.dart

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:minvest_forex_app/services/device_info_service.dart';

class SessionService {
  FirebaseMessaging get _firebaseMessaging => FirebaseMessaging.instance;
  FirebaseFunctions get _functions =>
      FirebaseFunctions.instanceFor(region: 'asia-southeast1');
  Future<void> updateUserSession() async {
    String? fcmToken;
    bool isSimulator = false;
    try {
      if (kIsWeb) {
        const String vapidKey =
            "BF1kL9v7A-1bOSz642aCWoZEKvFpjKvkMQuTPd_GXBLxNakYt6apNf9Aa25hGk1QJP0VFrCVRx4B9mO8h5gBUA8";
        try {
          fcmToken = await _firebaseMessaging.getToken(vapidKey: vapidKey);
        } catch (e) {
          print('SessionService (Web): Không lấy được FCM token (có thể do người dùng từ chối). Lỗi: $e');
        }

      } else {
        if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
          final apnsToken = await _firebaseMessaging.getAPNSToken();
          if (apnsToken == null) {
            isSimulator = true;
            print('SessionService (iOS): Không thể lấy APNS token, có thể là máy ảo.');
          }
        }

        if (!isSimulator) {
          fcmToken = await _firebaseMessaging.getToken();
        }
      }

      final deviceId = await DeviceInfoService.getDeviceId();
      print(
          'SessionService: Chuẩn bị cập nhật session với DeviceID: $deviceId và FCM Token: ${fcmToken ?? "N/A"}');
      final callable = _functions.httpsCallable('manageUserSession');
      await callable.call({
        'deviceId': deviceId, 
        'fcmToken': fcmToken,
        'platform': kIsWeb ? 'web' : 'mobile',
      });
      print('SessionService: Đã gọi manageUserSession thành công.');

    } catch (e) {
      print('SessionService: Lỗi không xác định khi cập nhật session: $e');
    }
  }
}