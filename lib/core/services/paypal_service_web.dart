import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class PaypalServiceWeb {
  static final PaypalServiceWeb _instance = PaypalServiceWeb._internal();
  factory PaypalServiceWeb() => _instance;
  PaypalServiceWeb._internal();

  final FirebaseFunctions _functions = FirebaseFunctions.instanceFor(region: 'asia-southeast1');

  Future<String?> createOrder(String packageId) async {
    try {
      final callable = _functions.httpsCallable('createPaypalOrder');
      final result = await callable.call({'packageId': packageId});
      final data = result.data as Map<dynamic, dynamic>;
      
      final approveLink = data['approveLink'] as String?;
      final orderID = data['orderID'] as String?;

      if (approveLink != null) {
        if (await canLaunchUrl(Uri.parse(approveLink))) {
          // Mở link thanh toán trong tab mới hoặc popup
          await launchUrl(Uri.parse(approveLink), mode: LaunchMode.platformDefault);
          return orderID;
        } else {
          throw Exception('Could not launch PayPal URL');
        }
      }
      return null;
    } catch (e) {
      debugPrint('Error creating PayPal order: $e');
      rethrow;
    }
  }

  Future<bool> captureOrder(String orderID) async {
    try {
      final callable = _functions.httpsCallable('capturePaypalOrder');
      final result = await callable.call({'orderID': orderID});
      final data = result.data as Map<dynamic, dynamic>;
      
      if (data['status'] == 'success') {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error capturing PayPal order: $e');
      return false;
    }
  }
}
