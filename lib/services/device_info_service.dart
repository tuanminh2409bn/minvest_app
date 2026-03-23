import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


class DeviceInfoService {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String> getDeviceId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? deviceId = prefs.getString('deviceId');
      
      if (deviceId != null) {
        return deviceId;
      }

      // Nếu chưa có, tạo ID mới
      if (kIsWeb) {
        deviceId = const Uuid().v4();
      } else {
        if (defaultTargetPlatform == TargetPlatform.android) {
          final androidInfo = await _deviceInfoPlugin.androidInfo;
          // Kết hợp androidId với UUID để đảm bảo tính duy nhất
          deviceId = 'android_${androidInfo.id}_${const Uuid().v4().substring(0, 8)}';
        } else if (defaultTargetPlatform == TargetPlatform.iOS) {
          final iosInfo = await _deviceInfoPlugin.iosInfo;
          final vendorId = iosInfo.identifierForVendor ?? const Uuid().v4();
          deviceId = 'ios_${vendorId}_${const Uuid().v4().substring(0, 8)}';
        } else {
          deviceId = 'other_${const Uuid().v4()}';
        }
      }

      await prefs.setString('deviceId', deviceId);
      return deviceId;
    } catch (e) {
      print('Lỗi khi lấy Device ID: $e');
      return 'unknown_device_${DateTime.now().millisecondsSinceEpoch}';
    }
  }
}