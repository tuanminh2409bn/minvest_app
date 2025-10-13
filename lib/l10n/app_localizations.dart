import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @accountUpgradedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT UPGRADED SUCCESSFULLY'**
  String get accountUpgradedSuccessfully;

  /// No description provided for @lotPerWeek.
  ///
  /// In en, this message translates to:
  /// **'Lot/week'**
  String get lotPerWeek;

  /// No description provided for @tableValueFull.
  ///
  /// In en, this message translates to:
  /// **'full'**
  String get tableValueFull;

  /// No description provided for @tableValueFulltime.
  ///
  /// In en, this message translates to:
  /// **'fulltime'**
  String get tableValueFulltime;

  /// No description provided for @packageTitle.
  ///
  /// In en, this message translates to:
  /// **'PACKAGE'**
  String get packageTitle;

  /// No description provided for @duration1Month.
  ///
  /// In en, this message translates to:
  /// **'1 month'**
  String get duration1Month;

  /// No description provided for @duration12Months.
  ///
  /// In en, this message translates to:
  /// **'12 months'**
  String get duration12Months;

  /// No description provided for @featureReceiveAllSignals.
  ///
  /// In en, this message translates to:
  /// **'Receive all signals of the day'**
  String get featureReceiveAllSignals;

  /// No description provided for @featureAnalyzeReason.
  ///
  /// In en, this message translates to:
  /// **'Analyze the reason for entering the order'**
  String get featureAnalyzeReason;

  /// No description provided for @featureHighPrecisionAI.
  ///
  /// In en, this message translates to:
  /// **'High-precision AI signal'**
  String get featureHighPrecisionAI;

  /// No description provided for @iapStoreNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'The store is not available on this device.'**
  String get iapStoreNotAvailable;

  /// No description provided for @iapErrorLoadingProducts.
  ///
  /// In en, this message translates to:
  /// **'Error loading products: {message}'**
  String iapErrorLoadingProducts(Object message);

  /// No description provided for @iapNoProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No products found. Please check your store configuration.'**
  String get iapNoProductsFound;

  /// No description provided for @iapTransactionError.
  ///
  /// In en, this message translates to:
  /// **'Transaction error: {message}'**
  String iapTransactionError(Object message);

  /// No description provided for @iapVerificationError.
  ///
  /// In en, this message translates to:
  /// **'Verification error: {message}'**
  String iapVerificationError(Object message);

  /// No description provided for @iapUnknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred: {error}'**
  String iapUnknownError(Object error);

  /// No description provided for @iapProcessingTransaction.
  ///
  /// In en, this message translates to:
  /// **'Processing transaction...'**
  String get iapProcessingTransaction;

  /// No description provided for @orderInfo1Month.
  ///
  /// In en, this message translates to:
  /// **'Payment for Elite 1 month package'**
  String get orderInfo1Month;

  /// No description provided for @orderInfo12Months.
  ///
  /// In en, this message translates to:
  /// **'Payment for Elite 12 months package'**
  String get orderInfo12Months;

  /// No description provided for @iapNotSupportedOnWeb.
  ///
  /// In en, this message translates to:
  /// **'In-app purchases are not supported on the web version.'**
  String get iapNotSupportedOnWeb;

  /// No description provided for @vnpayPaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'VNPAY PAYMENT'**
  String get vnpayPaymentTitle;

  /// No description provided for @creatingOrderWait.
  ///
  /// In en, this message translates to:
  /// **'Creating order, please wait...'**
  String get creatingOrderWait;

  /// No description provided for @errorWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorWithMessage(Object message);

  /// No description provided for @cannotConnectToServer.
  ///
  /// In en, this message translates to:
  /// **'Cannot connect to the server. Please try again.'**
  String get cannotConnectToServer;

  /// No description provided for @transactionCancelledOrFailed.
  ///
  /// In en, this message translates to:
  /// **'Transaction has been cancelled or failed.'**
  String get transactionCancelledOrFailed;

  /// No description provided for @cannotCreatePaymentLink.
  ///
  /// In en, this message translates to:
  /// **'Could not create payment link.\nPlease try again.'**
  String get cannotCreatePaymentLink;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @serverErrorRetry.
  ///
  /// In en, this message translates to:
  /// **'Server error: {message}. Please try again.'**
  String serverErrorRetry(Object message);

  /// No description provided for @redirectingToPayment.
  ///
  /// In en, this message translates to:
  /// **'Redirecting to payment page...'**
  String get redirectingToPayment;

  /// No description provided for @invalidPaymentUrl.
  ///
  /// In en, this message translates to:
  /// **'Invalid payment URL received from server.'**
  String get invalidPaymentUrl;

  /// No description provided for @processingYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Processing your account...'**
  String get processingYourAccount;

  /// No description provided for @verificationFailed.
  ///
  /// In en, this message translates to:
  /// **'Verification Failed!'**
  String get verificationFailed;

  /// No description provided for @reuploadImage.
  ///
  /// In en, this message translates to:
  /// **'Re-upload Image'**
  String get reuploadImage;

  /// No description provided for @accountNotLinked.
  ///
  /// In en, this message translates to:
  /// **'Account Not Linked to Minvest'**
  String get accountNotLinked;

  /// No description provided for @accountNotLinkedDesc.
  ///
  /// In en, this message translates to:
  /// **'To get exclusive signals, your Exness account must be registered through the Minvest partner link. Please create a new account using the link below.'**
  String get accountNotLinkedDesc;

  /// No description provided for @registerExnessViaMinvest.
  ///
  /// In en, this message translates to:
  /// **'Register Exness via Minvest'**
  String get registerExnessViaMinvest;

  /// No description provided for @iHaveRegisteredReupload.
  ///
  /// In en, this message translates to:
  /// **'I have registered, re-upload'**
  String get iHaveRegisteredReupload;

  /// No description provided for @couldNotLaunch.
  ///
  /// In en, this message translates to:
  /// **'Could not launch {url}'**
  String couldNotLaunch(Object url);

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @sentOn.
  ///
  /// In en, this message translates to:
  /// **'Sent on'**
  String get sentOn;

  /// No description provided for @entryPrice.
  ///
  /// In en, this message translates to:
  /// **'Entry price'**
  String get entryPrice;

  /// No description provided for @stopLossFull.
  ///
  /// In en, this message translates to:
  /// **'Stop loss'**
  String get stopLossFull;

  /// No description provided for @takeProfitFull1.
  ///
  /// In en, this message translates to:
  /// **'Take profit 1'**
  String get takeProfitFull1;

  /// No description provided for @takeProfitFull2.
  ///
  /// In en, this message translates to:
  /// **'Take profit 2'**
  String get takeProfitFull2;

  /// No description provided for @takeProfitFull3.
  ///
  /// In en, this message translates to:
  /// **'Take profit 3'**
  String get takeProfitFull3;

  /// No description provided for @noReasonProvided.
  ///
  /// In en, this message translates to:
  /// **'No reason provided for this signal.'**
  String get noReasonProvided;

  /// No description provided for @upgradeToViewReason.
  ///
  /// In en, this message translates to:
  /// **'Upgrade your account to Elite to view the analysis.'**
  String get upgradeToViewReason;

  /// No description provided for @upgradeToViewFullAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to View Full Analysis'**
  String get upgradeToViewFullAnalysis;

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcomeTo;

  /// No description provided for @appSlogan.
  ///
  /// In en, this message translates to:
  /// **'Enhance your trading with intelligent signals.'**
  String get appSlogan;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @continueByGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue by Google'**
  String get continueByGoogle;

  /// No description provided for @continueByFacebook.
  ///
  /// In en, this message translates to:
  /// **'Continue by Facebook'**
  String get continueByFacebook;

  /// No description provided for @continueByApple.
  ///
  /// In en, this message translates to:
  /// **'Continue by Apple'**
  String get continueByApple;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get loginSuccess;

  /// No description provided for @live.
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get live;

  /// No description provided for @end.
  ///
  /// In en, this message translates to:
  /// **'END'**
  String get end;

  /// No description provided for @symbol.
  ///
  /// In en, this message translates to:
  /// **'SYMBOL'**
  String get symbol;

  /// No description provided for @aiSignal.
  ///
  /// In en, this message translates to:
  /// **'AI SIGNAL'**
  String get aiSignal;

  /// No description provided for @ruleSignal.
  ///
  /// In en, this message translates to:
  /// **'RULE SIGNAL'**
  String get ruleSignal;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'ALL'**
  String get all;

  /// No description provided for @upgradeToSeeMore.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to see more'**
  String get upgradeToSeeMore;

  /// No description provided for @seeDetails.
  ///
  /// In en, this message translates to:
  /// **'see details'**
  String get seeDetails;

  /// No description provided for @notMatched.
  ///
  /// In en, this message translates to:
  /// **'NOT MATCHED'**
  String get notMatched;

  /// No description provided for @matched.
  ///
  /// In en, this message translates to:
  /// **'MATCHED'**
  String get matched;

  /// No description provided for @entry.
  ///
  /// In en, this message translates to:
  /// **'Entry'**
  String get entry;

  /// No description provided for @stopLoss.
  ///
  /// In en, this message translates to:
  /// **'SL'**
  String get stopLoss;

  /// No description provided for @takeProfit1.
  ///
  /// In en, this message translates to:
  /// **'TP1'**
  String get takeProfit1;

  /// No description provided for @takeProfit2.
  ///
  /// In en, this message translates to:
  /// **'TP2'**
  String get takeProfit2;

  /// No description provided for @takeProfit3.
  ///
  /// In en, this message translates to:
  /// **'TP3'**
  String get takeProfit3;

  /// No description provided for @upgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get upgrade;

  /// No description provided for @upgradeAccount.
  ///
  /// In en, this message translates to:
  /// **'UPGRADE ACCOUNT'**
  String get upgradeAccount;

  /// No description provided for @compareTiers.
  ///
  /// In en, this message translates to:
  /// **'COMPARE TIERS'**
  String get compareTiers;

  /// No description provided for @feature.
  ///
  /// In en, this message translates to:
  /// **'Feature'**
  String get feature;

  /// No description provided for @tierDemo.
  ///
  /// In en, this message translates to:
  /// **'Demo'**
  String get tierDemo;

  /// No description provided for @tierVIP.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get tierVIP;

  /// No description provided for @tierElite.
  ///
  /// In en, this message translates to:
  /// **'Elite'**
  String get tierElite;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @signalTime.
  ///
  /// In en, this message translates to:
  /// **'Signal time'**
  String get signalTime;

  /// No description provided for @signalQty.
  ///
  /// In en, this message translates to:
  /// **'Signal Qty'**
  String get signalQty;

  /// No description provided for @analysis.
  ///
  /// In en, this message translates to:
  /// **'Analysis'**
  String get analysis;

  /// No description provided for @openExnessAccount.
  ///
  /// In en, this message translates to:
  /// **'Open exness account!'**
  String get openExnessAccount;

  /// No description provided for @accountVerificationWithExness.
  ///
  /// In en, this message translates to:
  /// **'Account verification with Exness'**
  String get accountVerificationWithExness;

  /// No description provided for @payInAppToUpgrade.
  ///
  /// In en, this message translates to:
  /// **'Pay in app to upgrade'**
  String get payInAppToUpgrade;

  /// Button text for upgrading via bank transfer
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer to Upgrade'**
  String get bankTransferToUpgrade;

  /// No description provided for @accountVerification.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT VERIFICATION'**
  String get accountVerification;

  /// No description provided for @accountVerificationPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please upload a screenshot of your Exness account to be authorized (your account must be opened under Minvest\'s Exness link)'**
  String get accountVerificationPrompt;

  /// No description provided for @selectPhotoFromLibrary.
  ///
  /// In en, this message translates to:
  /// **'Select photo from library'**
  String get selectPhotoFromLibrary;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @accountInfo.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInfo;

  /// No description provided for @accountVerifiedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT VERIFIED SUCCESSFULLY'**
  String get accountVerifiedSuccessfully;

  /// No description provided for @yourAccountIs.
  ///
  /// In en, this message translates to:
  /// **'Your account is'**
  String get yourAccountIs;

  /// No description provided for @returnToHomePage.
  ///
  /// In en, this message translates to:
  /// **'Return to home page'**
  String get returnToHomePage;

  /// No description provided for @upgradeFailed.
  ///
  /// In en, this message translates to:
  /// **'Upgrade failed! Please reupload the image'**
  String get upgradeFailed;

  /// No description provided for @package.
  ///
  /// In en, this message translates to:
  /// **'PACKAGE'**
  String get package;

  /// No description provided for @startNow.
  ///
  /// In en, this message translates to:
  /// **'START NOW'**
  String get startNow;

  /// No description provided for @bankTransfer.
  ///
  /// In en, this message translates to:
  /// **'BANK TRANSFER'**
  String get bankTransfer;

  /// No description provided for @transferInformation.
  ///
  /// In en, this message translates to:
  /// **'TRANSFER INFORMATION'**
  String get transferInformation;

  /// No description provided for @scanForFastTransfer.
  ///
  /// In en, this message translates to:
  /// **'Scan for fast transfer'**
  String get scanForFastTransfer;

  /// No description provided for @contactUs247.
  ///
  /// In en, this message translates to:
  /// **'Contact Us 24/7'**
  String get contactUs247;

  /// No description provided for @newAnnouncement.
  ///
  /// In en, this message translates to:
  /// **'NEW ANNOUNCEMENT'**
  String get newAnnouncement;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @upgradeNow.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Now'**
  String get upgradeNow;

  /// No description provided for @followMinvest.
  ///
  /// In en, this message translates to:
  /// **'Follow MInvest'**
  String get followMinvest;

  /// No description provided for @tabSignal.
  ///
  /// In en, this message translates to:
  /// **'Signal'**
  String get tabSignal;

  /// No description provided for @tabChart.
  ///
  /// In en, this message translates to:
  /// **'Chart'**
  String get tabChart;

  /// No description provided for @tabProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tabProfile;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'REASON'**
  String get reason;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @noSignalsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No signals available.'**
  String get noSignalsAvailable;

  /// No description provided for @outOfGoldenHours.
  ///
  /// In en, this message translates to:
  /// **'Out of Golden Hours'**
  String get outOfGoldenHours;

  /// No description provided for @outOfGoldenHoursVipDesc.
  ///
  /// In en, this message translates to:
  /// **'VIP signals are available from 8:00 AM to 5:00 PM (GMT+7).\nUpgrade to Elite to get signals 24/24!'**
  String get outOfGoldenHoursVipDesc;

  /// No description provided for @outOfGoldenHoursDemoDesc.
  ///
  /// In en, this message translates to:
  /// **'Demo signals are available from 8:00 AM to 5:00 PM (GMT+7).\nUpgrade your account for more benefits!'**
  String get outOfGoldenHoursDemoDesc;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get yourName;

  /// No description provided for @yourEmail.
  ///
  /// In en, this message translates to:
  /// **'your.email@example.com'**
  String get yourEmail;

  /// No description provided for @adminPanel.
  ///
  /// In en, this message translates to:
  /// **'Admin Panel'**
  String get adminPanel;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get confirmLogout;

  /// No description provided for @confirmLogoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get confirmLogoutMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @upgradeCardTitle.
  ///
  /// In en, this message translates to:
  /// **'UPGRADE YOUR ACCOUNT'**
  String get upgradeCardTitle;

  /// No description provided for @upgradeCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'To access more resources'**
  String get upgradeCardSubtitle;

  /// No description provided for @upgradeCardSubtitleWeb.
  ///
  /// In en, this message translates to:
  /// **'To unlock premium signals and full-time support'**
  String get upgradeCardSubtitleWeb;

  /// No description provided for @subscriptionDetails.
  ///
  /// In en, this message translates to:
  /// **'Subscription Details'**
  String get subscriptionDetails;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get continueAsGuest;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? All of your data will be permanently erased and cannot be recovered.'**
  String get deleteAccountWarning;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @signalStatusMatched.
  ///
  /// In en, this message translates to:
  /// **'MATCHED'**
  String get signalStatusMatched;

  /// No description provided for @signalStatusNotMatched.
  ///
  /// In en, this message translates to:
  /// **'NOT MATCHED'**
  String get signalStatusNotMatched;

  /// No description provided for @signalStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'CANCELLED'**
  String get signalStatusCancelled;

  /// No description provided for @signalStatusSlHit.
  ///
  /// In en, this message translates to:
  /// **'SL HIT'**
  String get signalStatusSlHit;

  /// No description provided for @signalStatusTp1Hit.
  ///
  /// In en, this message translates to:
  /// **'TP1 HIT'**
  String get signalStatusTp1Hit;

  /// No description provided for @signalStatusTp2Hit.
  ///
  /// In en, this message translates to:
  /// **'TP2 HIT'**
  String get signalStatusTp2Hit;

  /// No description provided for @signalStatusTp3Hit.
  ///
  /// In en, this message translates to:
  /// **'TP3 HIT'**
  String get signalStatusTp3Hit;

  /// No description provided for @signalStatusRunning.
  ///
  /// In en, this message translates to:
  /// **'RUNNING'**
  String get signalStatusRunning;

  /// No description provided for @signalStatusClosed.
  ///
  /// In en, this message translates to:
  /// **'CLOSED'**
  String get signalStatusClosed;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @tabChat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get tabChat;

  /// No description provided for @chatLoginPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please log in to use this feature'**
  String get chatLoginPrompt;

  /// No description provided for @chatStartConversation.
  ///
  /// In en, this message translates to:
  /// **'Start your conversation'**
  String get chatStartConversation;

  /// No description provided for @chatNoMessages.
  ///
  /// In en, this message translates to:
  /// **'No messages yet.'**
  String get chatNoMessages;

  /// No description provided for @chatTypeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get chatTypeMessage;

  /// No description provided for @chatSupportIsTyping.
  ///
  /// In en, this message translates to:
  /// **'Support is typing...'**
  String get chatSupportIsTyping;

  /// No description provided for @chatUserIsTyping.
  ///
  /// In en, this message translates to:
  /// **'{userName} is typing...'**
  String chatUserIsTyping(Object userName);

  /// No description provided for @chatSeen.
  ///
  /// In en, this message translates to:
  /// **'Seen'**
  String get chatSeen;

  /// No description provided for @chatDefaultUserName.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get chatDefaultUserName;

  /// No description provided for @chatDefaultSupportName.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get chatDefaultSupportName;

  /// No description provided for @signalEntry.
  ///
  /// In en, this message translates to:
  /// **'Entry'**
  String get signalEntry;

  /// No description provided for @price1Month.
  ///
  /// In en, this message translates to:
  /// **'\$78'**
  String get price1Month;

  /// No description provided for @price12Months.
  ///
  /// In en, this message translates to:
  /// **'\$460'**
  String get price12Months;

  /// No description provided for @foreignTraderSupport.
  ///
  /// In en, this message translates to:
  /// **'For foreign traders, please contact us via WhatsApp (+84969.15.6969) for support'**
  String get foreignTraderSupport;

  /// No description provided for @signalSl.
  ///
  /// In en, this message translates to:
  /// **'SL'**
  String get signalSl;

  /// No description provided for @upgradeToSeeDetails.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to see signal details...'**
  String get upgradeToSeeDetails;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'BUY'**
  String get buy;

  /// No description provided for @sell.
  ///
  /// In en, this message translates to:
  /// **'SELL'**
  String get sell;

  /// No description provided for @logoutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Session Expired'**
  String get logoutDialogTitle;

  /// No description provided for @logoutDialogDefaultReason.
  ///
  /// In en, this message translates to:
  /// **'Your account has been logged in on another device.'**
  String get logoutDialogDefaultReason;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @errorLoadingPackages.
  ///
  /// In en, this message translates to:
  /// **'Error Loading Packages'**
  String get errorLoadingPackages;

  /// No description provided for @tp1Hit.
  ///
  /// In en, this message translates to:
  /// **'TP1 Hit'**
  String get tp1Hit;

  /// No description provided for @tp2Hit.
  ///
  /// In en, this message translates to:
  /// **'TP2 Hit'**
  String get tp2Hit;

  /// No description provided for @tp3Hit.
  ///
  /// In en, this message translates to:
  /// **'TP3 Hit'**
  String get tp3Hit;

  /// No description provided for @slHit.
  ///
  /// In en, this message translates to:
  /// **'SL Hit'**
  String get slHit;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @exitedByAdmin.
  ///
  /// In en, this message translates to:
  /// **'Exited by Admin'**
  String get exitedByAdmin;

  /// No description provided for @signalClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get signalClosed;

  /// No description provided for @contactToUpgrade.
  ///
  /// In en, this message translates to:
  /// **'Contact to upgrade'**
  String get contactToUpgrade;

  /// No description provided for @noNotificationsYet.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet.'**
  String get noNotificationsYet;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String daysAgo(int count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} hours ago'**
  String hoursAgo(int count);

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} minutes ago'**
  String minutesAgo(int count);

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
