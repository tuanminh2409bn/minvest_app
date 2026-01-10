import 'dart:html' as html;

void showWebNotification({
  required String title,
  required String body,
  Map<String, dynamic>? payload,
}) {
  try {
    if (html.Notification.permission == "granted") {
      html.Notification(
        title,
        body: body,
        icon: '/icons/Icon-192.png',
        tag: payload?['signalId'] ?? 'minvest-notification', // Thêm tag để tránh trùng lặp
      );
    } else if (html.Notification.permission != "denied") {
      html.Notification.requestPermission().then((permission) {
        if (permission == "granted") {
          html.Notification(
            title,
            body: body,
            icon: '/icons/Icon-192.png',
            tag: payload?['signalId'] ?? 'minvest-notification',
          );
        }
      });
    }
  } catch (e) {
    print('Web Notification Error: $e');
    // Fallback nếu có lỗi (ví dụ lỗi icon), thử hiển thị không icon
    try {
      if (html.Notification.permission == "granted") {
        html.Notification(title, body: body);
      }
    } catch (_) {}
  }
}