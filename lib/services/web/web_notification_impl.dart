import 'dart:html' as html;

void showWebNotification({
  required String title,
  required String body,
  Map<String, dynamic>? payload,
}) {
  if (html.Notification.permission == "granted") {
    html.Notification(
      title,
      body: body,
      icon: 'icons/Icon-192.png',
    );
  } else if (html.Notification.permission != "denied") {
    html.Notification.requestPermission().then((permission) {
      if (permission == "granted") {
        html.Notification(
          title,
          body: body,
          icon: 'icons/Icon-192.png',
        );
      }
    });
  }
}