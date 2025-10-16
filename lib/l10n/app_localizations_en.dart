// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'ACCOUNT UPGRADED SUCCESSFULLY';

  @override
  String get lotPerWeek => 'Lot/week';

  @override
  String get tableValueFull => 'full';

  @override
  String get tableValueFulltime => 'fulltime';

  @override
  String get packageTitle => 'PACKAGE';

  @override
  String get duration1Month => '1 month';

  @override
  String get duration12Months => '12 months';

  @override
  String get featureReceiveAllSignals => 'Receive all signals of the day';

  @override
  String get featureAnalyzeReason =>
      'Analyze the reason for entering the order';

  @override
  String get featureHighPrecisionAI => 'High-precision AI signal';

  @override
  String get iapStoreNotAvailable =>
      'The store is not available on this device.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'Error loading products: $message';
  }

  @override
  String get iapNoProductsFound =>
      'No products found. Please check your store configuration.';

  @override
  String iapTransactionError(Object message) {
    return 'Transaction error: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'Verification error: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'An unknown error occurred: $error';
  }

  @override
  String get iapProcessingTransaction => 'Processing transaction...';

  @override
  String get orderInfo1Month => 'Payment for Elite 1 month package';

  @override
  String get orderInfo12Months => 'Payment for Elite 12 months package';

  @override
  String get iapNotSupportedOnWeb =>
      'In-app purchases are not supported on the web version.';

  @override
  String get vnpayPaymentTitle => 'VNPAY PAYMENT';

  @override
  String get creatingOrderWait => 'Creating order, please wait...';

  @override
  String errorWithMessage(Object message) {
    return 'Error: $message';
  }

  @override
  String get cannotConnectToServer =>
      'Cannot connect to the server. Please try again.';

  @override
  String get transactionCancelledOrFailed =>
      'Transaction has been cancelled or failed.';

  @override
  String get cannotCreatePaymentLink =>
      'Could not create payment link.\nPlease try again.';

  @override
  String get retry => 'Retry';

  @override
  String serverErrorRetry(Object message) {
    return 'Server error: $message. Please try again.';
  }

  @override
  String get redirectingToPayment => 'Redirecting to payment page...';

  @override
  String get invalidPaymentUrl => 'Invalid payment URL received from server.';

  @override
  String get processingYourAccount => 'Processing your account...';

  @override
  String get verificationFailed => 'Verification Failed!';

  @override
  String get reuploadImage => 'Re-upload Image';

  @override
  String get accountNotLinked => 'Account Not Linked to Minvest';

  @override
  String get accountNotLinkedDesc =>
      'To get exclusive signals, your Exness account must be registered through the Minvest partner link. Please create a new account using the link below.';

  @override
  String get registerExnessViaMinvest => 'Register Exness via Minvest';

  @override
  String get iHaveRegisteredReupload => 'I have registered, re-upload';

  @override
  String couldNotLaunch(Object url) {
    return 'Could not launch $url';
  }

  @override
  String get status => 'Status';

  @override
  String get sentOn => 'Sent on';

  @override
  String get entryPrice => 'Entry price';

  @override
  String get stopLossFull => 'Stop loss';

  @override
  String get takeProfitFull1 => 'Take profit 1';

  @override
  String get takeProfitFull2 => 'Take profit 2';

  @override
  String get takeProfitFull3 => 'Take profit 3';

  @override
  String get noReasonProvided => 'No reason provided for this signal.';

  @override
  String get upgradeToViewReason =>
      'Upgrade your account to Elite to view the analysis.';

  @override
  String get upgradeToViewFullAnalysis => 'Upgrade to View Full Analysis';

  @override
  String get welcomeTo => 'Welcome to';

  @override
  String get appSlogan => 'Enhance your trading with intelligent signals.';

  @override
  String get signIn => 'Sign in';

  @override
  String get continueByGoogle => 'Continue by Google';

  @override
  String get continueByFacebook => 'Continue by Facebook';

  @override
  String get continueByApple => 'Continue by Apple';

  @override
  String get loginSuccess => 'Login successful!';

  @override
  String get live => 'LIVE';

  @override
  String get end => 'END';

  @override
  String get symbol => 'SYMBOL';

  @override
  String get aiSignal => 'AI SIGNAL';

  @override
  String get ruleSignal => 'RULE SIGNAL';

  @override
  String get all => 'ALL';

  @override
  String get upgradeToSeeMore => 'Upgrade to see more';

  @override
  String get seeDetails => 'see details';

  @override
  String get notMatched => 'NOT MATCHED';

  @override
  String get matched => 'MATCHED';

  @override
  String get entry => 'Entry';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get upgradeAccount => 'UPGRADE ACCOUNT';

  @override
  String get compareTiers => 'COMPARE TIERS';

  @override
  String get feature => 'Feature';

  @override
  String get tierDemo => 'Demo';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'Balance';

  @override
  String get signalTime => 'Signal time';

  @override
  String get signalQty => 'Signal Qty';

  @override
  String get analysis => 'Analysis';

  @override
  String get openExnessAccount => 'Open exness account!';

  @override
  String get accountVerificationWithExness =>
      'Account verification with Exness';

  @override
  String get payInAppToUpgrade => 'Pay in app to upgrade';

  @override
  String get bankTransferToUpgrade => 'Bank Transfer to Upgrade';

  @override
  String get accountVerification => 'ACCOUNT VERIFICATION';

  @override
  String get accountVerificationPrompt =>
      'Please upload a screenshot of your Exness account to be authorized (your account must be opened under Minvest\'s Exness link)';

  @override
  String get selectPhotoFromLibrary => 'Select photo from library';

  @override
  String get send => 'Send';

  @override
  String get accountInfo => 'Account Information';

  @override
  String get accountVerifiedSuccessfully => 'ACCOUNT VERIFIED SUCCESSFULLY';

  @override
  String get yourAccountIs => 'Your account is';

  @override
  String get returnToHomePage => 'Return to home page';

  @override
  String get upgradeFailed => 'Upgrade failed! Please reupload the image';

  @override
  String get package => 'PACKAGE';

  @override
  String get startNow => 'START NOW';

  @override
  String get bankTransfer => 'BANK TRANSFER';

  @override
  String get transferInformation => 'TRANSFER INFORMATION';

  @override
  String get scanForFastTransfer => 'Scan for fast transfer';

  @override
  String get contactUs247 => 'Contact Us 24/7';

  @override
  String get newAnnouncement => 'NEW ANNOUNCEMENT';

  @override
  String get profile => 'Profile';

  @override
  String get upgradeNow => 'Upgrade Now';

  @override
  String get followMinvest => 'Follow MInvest';

  @override
  String get tabSignal => 'Signal';

  @override
  String get tabChart => 'Chart';

  @override
  String get tabProfile => 'Profile';

  @override
  String get reason => 'REASON';

  @override
  String get error => 'Error';

  @override
  String get noSignalsAvailable => 'No signals available.';

  @override
  String get outOfGoldenHours => 'Out of Golden Hours';

  @override
  String get outOfGoldenHoursVipDesc =>
      'VIP signals are available from 8:00 AM to 5:00 PM (GMT+7).\nUpgrade to Elite to get signals 24/24!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'Demo signals are available from 8:00 AM to 5:00 PM (GMT+7).\nUpgrade your account for more benefits!';

  @override
  String get yourName => 'Your Name';

  @override
  String get yourEmail => 'your.email@example.com';

  @override
  String get adminPanel => 'Admin Panel';

  @override
  String get logout => 'Logout';

  @override
  String get confirmLogout => 'Confirm Logout';

  @override
  String get confirmLogoutMessage => 'Are you sure you want to log out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get upgradeCardTitle => 'UPGRADE YOUR ACCOUNT';

  @override
  String get upgradeCardSubtitle => 'To access more resources';

  @override
  String get upgradeCardSubtitleWeb =>
      'To unlock premium signals and full-time support';

  @override
  String get subscriptionDetails => 'Subscription Details';

  @override
  String get notifications => 'Notifications';

  @override
  String get continueAsGuest => 'Continue as Guest';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountWarning =>
      'Are you sure you want to delete your account? All of your data will be permanently erased and cannot be recovered.';

  @override
  String get delete => 'Delete';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get signalStatusMatched => 'MATCHED';

  @override
  String get signalStatusNotMatched => 'NOT MATCHED';

  @override
  String get signalStatusCancelled => 'CANCELLED';

  @override
  String get signalStatusSlHit => 'SL HIT';

  @override
  String get signalStatusTp1Hit => 'TP1 HIT';

  @override
  String get signalStatusTp2Hit => 'TP2 HIT';

  @override
  String get signalStatusTp3Hit => 'TP3 HIT';

  @override
  String get signalStatusRunning => 'RUNNING';

  @override
  String get signalStatusClosed => 'CLOSED';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get tabChat => 'Chat';

  @override
  String get exnessUpgradeNoteForIos =>
      'For customers who have registered an Exness account through Minvest, please click contact us to have your account upgraded.';

  @override
  String get chatWelcomeTitle => '👋 Welcome to Minvest AI!';

  @override
  String get chatWelcomeBody1 =>
      'Please leave a message, our team will respond as soon as possible.';

  @override
  String get chatWelcomeBody2 => 'Or contact us directly via Zalo/WhatsApp: ';

  @override
  String get chatWelcomeBody3 => ' for faster support!';

  @override
  String get chatLoginPrompt => 'Please log in to use this feature';

  @override
  String get chatStartConversation => 'Start your conversation';

  @override
  String get chatNoMessages => 'No messages yet.';

  @override
  String get chatTypeMessage => 'Type a message...';

  @override
  String get chatSupportIsTyping => 'Support is typing...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName is typing...';
  }

  @override
  String get chatSeen => 'Seen';

  @override
  String get chatDefaultUserName => 'User';

  @override
  String get chatDefaultSupportName => 'Support';

  @override
  String get signalEntry => 'Entry';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      'For foreign traders, please contact us via WhatsApp (+84969.15.6969) for support';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails => 'Upgrade to see signal details...';

  @override
  String get buy => 'BUY';

  @override
  String get sell => 'SELL';

  @override
  String get logoutDialogTitle => 'Session Expired';

  @override
  String get logoutDialogDefaultReason =>
      'Your account has been logged in on another device.';

  @override
  String get ok => 'OK';

  @override
  String get errorLoadingPackages => 'Error Loading Packages';

  @override
  String get tp1Hit => 'TP1 Hit';

  @override
  String get tp2Hit => 'TP2 Hit';

  @override
  String get tp3Hit => 'TP3 Hit';

  @override
  String get slHit => 'SL Hit';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get exitedByAdmin => 'Exited by Admin';

  @override
  String get signalClosed => 'Closed';

  @override
  String get contactToUpgrade => 'Contact to upgrade';

  @override
  String get noNotificationsYet => 'No notifications yet.';

  @override
  String daysAgo(int count) {
    return '$count days ago';
  }

  @override
  String hoursAgo(int count) {
    return '$count hours ago';
  }

  @override
  String minutesAgo(int count) {
    return '$count minutes ago';
  }

  @override
  String get justNow => 'Just now';
}
