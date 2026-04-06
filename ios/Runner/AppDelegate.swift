// ios/Runner/AppDelegate.swift

import UIKit
import Flutter
import Firebase
import FBSDKCoreKit
import StoreKit

@main
@objc class AppDelegate: FlutterAppDelegate, SKPaymentTransactionObserver {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)

    SKPaymentQueue.default().add(self)

    // ⚠️ Tắt tính năng thu thập dữ liệu tự động của Facebook SDK
    // TRƯỚC KHI khởi động SDK. Điều này đảm bảo không có IDFA hoặc
    // dữ liệu theo dõi nào được thu thập trước khi user cấp quyền ATT.
    Settings.shared.isAutoLogAppEventsEnabled = false
    Settings.shared.isAdvertiserIDCollectionEnabled = false

    // 🚫 KHÔNG gọi ApplicationDelegate.shared.application() ở đây!
    // Facebook SDK sẽ trigger network call đến ep2.facebook.com ngay lập tức,
    // khiến iOS hiện dialog "Quyền mạng cục bộ" trước khi ATT được xử lý.
    // Facebook SDK được khởi động SAU trong Dart (sau khi ATT hoàn tất).

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  nonisolated func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
  }

  override func applicationWillTerminate(_ application: UIApplication) {
      SKPaymentQueue.default().remove(self)
      super.applicationWillTerminate(application)
  }

  override func application(_ application: UIApplication,
                           didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Messaging.messaging().apnsToken = deviceToken
    super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }

  override func application(_ application: UIApplication,
                           didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Failed to register for remote notifications: \(error.localizedDescription)")
    super.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
  }
}