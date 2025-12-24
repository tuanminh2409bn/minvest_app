import 'dart:html' as html;

void showWebNotification(String title, String body) {
  print("🔔 [WebNotification] Status: ${html.Notification.permission}");
  
  if (html.Notification.permission == 'granted') {
    _display(title, body);
  } else if (html.Notification.permission != 'denied') {
    html.Notification.requestPermission().then((permission) {
      if (permission == 'granted') {
        _display(title, body);
      }
    });
  }
}

void _display(String title, String body) {
  // Ưu tiên dùng ServiceWorker để hiển thị vì nó ổn định hơn trên Chrome Web
  if (html.window.navigator.serviceWorker != null) {
    html.window.navigator.serviceWorker!.ready.then((registration) {
      try {
        registration.showNotification(title, {
          'body': body,
          'icon': '/icons/Icon-192.png',
          'badge': '/icons/Icon-192.png',
          'tag': 'minvest-signal',
          'renotify': true,
          'requireInteraction': true,
        });
        print("🔔 [WebNotification] SW Notification triggered.");
      } catch (e) {
        _fallback(title, body);
      }
    });
  } else {
    _fallback(title, body);
  }
}

void _fallback(String title, String body) {
  try {
    final n = html.Notification(title, 
      body: body, 
      icon: '/icons/Icon-192.png',
    );
    n.onClick.listen((_) {
      // html.window.focus(); // Not supported in standard dart:html Window
      n.close();
    });
  } catch (e) {
    print("🔔 [WebNotification] Fallback error: $e");
  }
}
