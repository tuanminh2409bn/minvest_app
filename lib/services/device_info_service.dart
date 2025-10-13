import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


class DeviceInfoService {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String> getDeviceId() async {
    try {
      if (kIsWeb) {
        // Xử lý cho nền tảng Web
        final prefs = await SharedPreferences.getInstance();
        String? deviceId = prefs.getString('deviceId');
        if (deviceId == null) {
          deviceId = const Uuid().v4(); // Tạo một ID duy nhất
          await prefs.setString('deviceId', deviceId);
        }
        return deviceId;
      } else {
        // Xử lý cho nền tảng Mobile
        if (Platform.isAndroid) {
          final androidInfo = await _deviceInfoPlugin.androidInfo;
          return androidInfo.id; // Sử dụng androidId đã được xác minh
        } else if (Platform.isIOS) {
          final iosInfo = await _deviceInfoPlugin.iosInfo;
          return iosInfo.identifierForVendor ?? 'ios_device_unknown';
        }
      }
    } catch (e) {
      print('Lỗi khi lấy Device ID: $e');
    }
    // Trả về một giá trị dự phòng nếu có lỗi
    return 'unknown_device_${DateTime.now().millisecondsSinceEpoch}';
  }
}