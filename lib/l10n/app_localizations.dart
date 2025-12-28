import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_km.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_mn.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_th.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

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
    Locale('ar'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fi'),
    Locale('fr'),
    Locale('hi'),
    Locale('hu'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('km'),
    Locale('ko'),
    Locale('mn'),
    Locale('ms'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('th'),
    Locale('vi'),
    Locale('zh')
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
  /// **'Could not create payment link.\nTry again.'**
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
  /// **'AI Signals'**
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
  /// **'Get Signals Now'**
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

  /// No description provided for @exnessUpgradeNoteForIos.
  ///
  /// In en, this message translates to:
  /// **'For customers who have registered an Exness account through Minvest, please click contact us to have your account upgraded.'**
  String get exnessUpgradeNoteForIos;

  /// No description provided for @chatWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'👋 Welcome to Signal GPT!'**
  String get chatWelcomeTitle;

  /// No description provided for @chatWelcomeBody1.
  ///
  /// In en, this message translates to:
  /// **'Please leave a message, our team will respond as soon as possible.'**
  String get chatWelcomeBody1;

  /// No description provided for @chatWelcomeBody2.
  ///
  /// In en, this message translates to:
  /// **'Or contact us directly via Zalo/WhatsApp: '**
  String get chatWelcomeBody2;

  /// No description provided for @chatWelcomeBody3.
  ///
  /// In en, this message translates to:
  /// **' for faster support!'**
  String get chatWelcomeBody3;

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

  /// No description provided for @getSignalsNow.
  ///
  /// In en, this message translates to:
  /// **'Get Signals Now'**
  String get getSignalsNow;

  /// No description provided for @freeTrial.
  ///
  /// In en, this message translates to:
  /// **'Free Trial'**
  String get freeTrial;

  /// No description provided for @heroTitle.
  ///
  /// In en, this message translates to:
  /// **'Guiding Traders & Growing Portfolios'**
  String get heroTitle;

  /// No description provided for @heroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The Ultimate AI Engine – Designed by Expert Traders'**
  String get heroSubtitle;

  /// No description provided for @globalAiInnovationTitle.
  ///
  /// In en, this message translates to:
  /// **'Global AI Innovation for the Next Generation of Trading Intelligence'**
  String get globalAiInnovationTitle;

  /// No description provided for @globalAiInnovationDesc.
  ///
  /// In en, this message translates to:
  /// **'Transforming traditional trading with cloud-powered AI signals — adaptive to real-time market news and trends\nfor faster, more precise, and emotion-free performance.'**
  String get globalAiInnovationDesc;

  /// No description provided for @liveTradingSignalsTitle.
  ///
  /// In en, this message translates to:
  /// **'LIVE – 24/7 AI Trading Signals'**
  String get liveTradingSignalsTitle;

  /// No description provided for @liveTradingSignalsDesc.
  ///
  /// In en, this message translates to:
  /// **'Real-time cloud analytics delivering high-probability, trend-following strategies with adaptive precision and emotion-free execution.'**
  String get liveTradingSignalsDesc;

  /// No description provided for @trendFollowing.
  ///
  /// In en, this message translates to:
  /// **'Trend-Following'**
  String get trendFollowing;

  /// No description provided for @realtime.
  ///
  /// In en, this message translates to:
  /// **'Real-time'**
  String get realtime;

  /// No description provided for @orderExplanationEngineTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Explanation Engine'**
  String get orderExplanationEngineTitle;

  /// No description provided for @orderExplanationEngineDesc.
  ///
  /// In en, this message translates to:
  /// **'Explains trade setups in simple terms — showing how confluences form, why entries are made, and helping traders learn from each decision.'**
  String get orderExplanationEngineDesc;

  /// No description provided for @transparent.
  ///
  /// In en, this message translates to:
  /// **'Transparent'**
  String get transparent;

  /// No description provided for @educational.
  ///
  /// In en, this message translates to:
  /// **'Educational'**
  String get educational;

  /// No description provided for @logical.
  ///
  /// In en, this message translates to:
  /// **'Logical'**
  String get logical;

  /// No description provided for @transparentRealPerformanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Transparent - Real Performance'**
  String get transparentRealPerformanceTitle;

  /// No description provided for @transparentRealPerformanceDesc.
  ///
  /// In en, this message translates to:
  /// **'See real data on signal accuracy, success rate, and profitability — verified and traceable in every trade'**
  String get transparentRealPerformanceDesc;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @performanceTracking.
  ///
  /// In en, this message translates to:
  /// **'Performance-Tracking'**
  String get performanceTracking;

  /// No description provided for @accurate.
  ///
  /// In en, this message translates to:
  /// **'Accurate'**
  String get accurate;

  /// No description provided for @predictiveAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Predictive Accuracy'**
  String get predictiveAccuracy;

  /// No description provided for @improvementInProfitability.
  ///
  /// In en, this message translates to:
  /// **'Improvement in Profitability'**
  String get improvementInProfitability;

  /// No description provided for @improvedRiskManagement.
  ///
  /// In en, this message translates to:
  /// **'Improved Risk Management'**
  String get improvedRiskManagement;

  /// No description provided for @signalsPerformanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Signals Performance'**
  String get signalsPerformanceTitle;

  /// No description provided for @riskToRewardRatio.
  ///
  /// In en, this message translates to:
  /// **'Risk-to-Reward Ratio'**
  String get riskToRewardRatio;

  /// No description provided for @howRiskComparesToReward.
  ///
  /// In en, this message translates to:
  /// **'How risk compares to reward'**
  String get howRiskComparesToReward;

  /// No description provided for @profitLossOverview.
  ///
  /// In en, this message translates to:
  /// **'Profit/Loss Overview'**
  String get profitLossOverview;

  /// No description provided for @netGainVsLoss.
  ///
  /// In en, this message translates to:
  /// **'Net gain vs loss'**
  String get netGainVsLoss;

  /// No description provided for @winRate.
  ///
  /// In en, this message translates to:
  /// **'Win Rate'**
  String get winRate;

  /// No description provided for @percentageOfWinningTrades.
  ///
  /// In en, this message translates to:
  /// **'Percentage of winning trades'**
  String get percentageOfWinningTrades;

  /// No description provided for @accuracyRate.
  ///
  /// In en, this message translates to:
  /// **'Accuracy Rate'**
  String get accuracyRate;

  /// No description provided for @howPreciseOurSignalsAre.
  ///
  /// In en, this message translates to:
  /// **'How precise our signals are'**
  String get howPreciseOurSignalsAre;

  /// No description provided for @realtimeMarketAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Real-Time Market Analysis'**
  String get realtimeMarketAnalysis;

  /// No description provided for @realtimeMarketAnalysisDesc.
  ///
  /// In en, this message translates to:
  /// **'Our AI monitors the market continuously, identifying technical convergence zones and reliable breakout points so you can enter trades at the right moment.'**
  String get realtimeMarketAnalysisDesc;

  /// No description provided for @saveTimeOnAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Save Time on Analysis'**
  String get saveTimeOnAnalysis;

  /// No description provided for @saveTimeOnAnalysisDesc.
  ///
  /// In en, this message translates to:
  /// **'No more hours spent reading charts. Receive tailored investment strategies in just minutes a day.'**
  String get saveTimeOnAnalysisDesc;

  /// No description provided for @minimizeEmotionalTrading.
  ///
  /// In en, this message translates to:
  /// **'Minimize Emotional Trading'**
  String get minimizeEmotionalTrading;

  /// No description provided for @minimizeEmotionalTradingDesc.
  ///
  /// In en, this message translates to:
  /// **'With smart alerts, risk detection, and data-driven signals not emotions you stay disciplined and in control of every decision.'**
  String get minimizeEmotionalTradingDesc;

  /// No description provided for @seizeEveryOpportunity.
  ///
  /// In en, this message translates to:
  /// **'Seize Every Opportunity'**
  String get seizeEveryOpportunity;

  /// No description provided for @seizeEveryOpportunityDesc.
  ///
  /// In en, this message translates to:
  /// **'Timely strategy updates delivered straight to your inbox ensure you ride market trends at the perfect time.'**
  String get seizeEveryOpportunityDesc;

  /// No description provided for @minvestAiCoreValueTitle.
  ///
  /// In en, this message translates to:
  /// **'Signal GPT- Core value'**
  String get minvestAiCoreValueTitle;

  /// No description provided for @minvestAiCoreValueDesc.
  ///
  /// In en, this message translates to:
  /// **'AI analyzes real-time market data continuously, filtering insights to identify fast, accurate investment opportunities'**
  String get minvestAiCoreValueDesc;

  /// No description provided for @frequentlyAskedQuestions.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions (FAQ)'**
  String get frequentlyAskedQuestions;

  /// No description provided for @faqSubtitle.
  ///
  /// In en, this message translates to:
  /// **'All your questions — from how to join, to the benefits, to how our AI works — are answered just below. If you still have any doubts, feel free to message us on Whatsapp'**
  String get faqSubtitle;

  /// No description provided for @maximizeResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Maximize your results with Signal GPT\nadvanced market analysis and precision-filtered signals'**
  String get maximizeResultsTitle;

  /// No description provided for @elevateTradingWithAiStrategies.
  ///
  /// In en, this message translates to:
  /// **'Elevate your trading with AI-enhanced strategies crafted for consistency and clarity'**
  String get elevateTradingWithAiStrategies;

  /// No description provided for @winMoreWithAiSignalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Win More with AI-Powered Signals\nin Every Market'**
  String get winMoreWithAiSignalsTitle;

  /// No description provided for @winMoreWithAiSignalsDesc.
  ///
  /// In en, this message translates to:
  /// **'Our multi-market AI scans Forex, Crypto, and Metals in real-time,\ndelivering expert-validated trading signals —\nwith clear entry, stop-loss, and take-profit levels'**
  String get winMoreWithAiSignalsDesc;

  /// No description provided for @buyLimit.
  ///
  /// In en, this message translates to:
  /// **'Buy limit'**
  String get buyLimit;

  /// No description provided for @sellLimit.
  ///
  /// In en, this message translates to:
  /// **'Sell limit'**
  String get sellLimit;

  /// No description provided for @smarterToolsTitle.
  ///
  /// In en, this message translates to:
  /// **'Smarter Tools - Better Investments'**
  String get smarterToolsTitle;

  /// No description provided for @smarterToolsDesc.
  ///
  /// In en, this message translates to:
  /// **'Discover the features that help you minimize risks, seize opportunities, and grow your wealth'**
  String get smarterToolsDesc;

  /// No description provided for @performanceOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Performance Overview'**
  String get performanceOverviewTitle;

  /// No description provided for @performanceOverviewDesc.
  ///
  /// In en, this message translates to:
  /// **'Our multi-market AI scans Forex, Crypto, and Metals in real-time, delivering expert-validated trading signals - with clear entry, stop-loss, and take-profit levels'**
  String get performanceOverviewDesc;

  /// No description provided for @totalProfit.
  ///
  /// In en, this message translates to:
  /// **'Total Profit'**
  String get totalProfit;

  /// No description provided for @completionSignal.
  ///
  /// In en, this message translates to:
  /// **'Completion signal'**
  String get completionSignal;

  /// No description provided for @onDemandFinancialExpertTitle.
  ///
  /// In en, this message translates to:
  /// **'Your On-Demand Financial Expert'**
  String get onDemandFinancialExpertTitle;

  /// No description provided for @onDemandFinancialExpertDesc.
  ///
  /// In en, this message translates to:
  /// **'AI platform suggests trading signals - self-learning, analyses the market 24/7, unaffected by emotions. Minvest has supported over 10,000 financial analysts\nin their journey to find accurate, stable, and easy-to-apply signals'**
  String get onDemandFinancialExpertDesc;

  /// No description provided for @aiPoweredSignalPlatform.
  ///
  /// In en, this message translates to:
  /// **'AI-Powered Trading Signal Platform'**
  String get aiPoweredSignalPlatform;

  /// No description provided for @selfLearningSystems.
  ///
  /// In en, this message translates to:
  /// **'Self-Learning Systems, Sharper Insights, Stronger Trades'**
  String get selfLearningSystems;

  /// No description provided for @emotionlessExecution.
  ///
  /// In en, this message translates to:
  /// **'Emotionless Execution For Smarter,\nMore Disciplined Trading'**
  String get emotionlessExecution;

  /// No description provided for @analysingMarket247.
  ///
  /// In en, this message translates to:
  /// **'Analysing the market 24/7'**
  String get analysingMarket247;

  /// No description provided for @maximizeResultsFeaturesTitle.
  ///
  /// In en, this message translates to:
  /// **'Maximize your results with Signal GPT\nadvanced market analysis and precision-filtered signals'**
  String get maximizeResultsFeaturesTitle;

  /// No description provided for @minvestAiRegistrationDesc.
  ///
  /// In en, this message translates to:
  /// **'Signal GPT registration is now open — spots may close soon as we review and approve new members'**
  String get minvestAiRegistrationDesc;

  /// No description provided for @currencyPairs.
  ///
  /// In en, this message translates to:
  /// **'Commodity'**
  String get currencyPairs;

  /// No description provided for @allCurrencyPairs.
  ///
  /// In en, this message translates to:
  /// **'All Currency Pairs'**
  String get allCurrencyPairs;

  /// No description provided for @allCommodities.
  ///
  /// In en, this message translates to:
  /// **'All Commodities'**
  String get allCommodities;

  /// No description provided for @allCryptoPairs.
  ///
  /// In en, this message translates to:
  /// **'All Crypto Pairs'**
  String get allCryptoPairs;

  /// No description provided for @dateRange.
  ///
  /// In en, this message translates to:
  /// **'Date Range'**
  String get dateRange;

  /// No description provided for @selectDateRange.
  ///
  /// In en, this message translates to:
  /// **'Select Date Range'**
  String get selectDateRange;

  /// No description provided for @allAssets.
  ///
  /// In en, this message translates to:
  /// **'All Assets'**
  String get allAssets;

  /// No description provided for @asset.
  ///
  /// In en, this message translates to:
  /// **'Asset'**
  String get asset;

  /// No description provided for @tokenExpired.
  ///
  /// In en, this message translates to:
  /// **'Token expired'**
  String get tokenExpired;

  /// No description provided for @tokenLimitReachedDesc.
  ///
  /// In en, this message translates to:
  /// **'You have used up your 10 free tokens today. Upgrade your package to view more signals.'**
  String get tokenLimitReachedDesc;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @detail.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get detail;

  /// No description provided for @performanceOverview.
  ///
  /// In en, this message translates to:
  /// **'Performance Overview'**
  String get performanceOverview;

  /// No description provided for @totalProfitPips.
  ///
  /// In en, this message translates to:
  /// **'Total Profit (Pips)'**
  String get totalProfitPips;

  /// No description provided for @winRatePercent.
  ///
  /// In en, this message translates to:
  /// **'Win Rate (%)'**
  String get winRatePercent;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @errorLoadingHistory.
  ///
  /// In en, this message translates to:
  /// **'Error loading history'**
  String get errorLoadingHistory;

  /// No description provided for @noHistoryAvailable.
  ///
  /// In en, this message translates to:
  /// **'No signal history available'**
  String get noHistoryAvailable;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @page.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get page;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @timeGmt7.
  ///
  /// In en, this message translates to:
  /// **'Time (GMT)'**
  String get timeGmt7;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @pips.
  ///
  /// In en, this message translates to:
  /// **'Pips'**
  String get pips;

  /// No description provided for @smallScreenRotationHint.
  ///
  /// In en, this message translates to:
  /// **'Small screen: rotate landscape or scroll horizontally to view the full table.'**
  String get smallScreenRotationHint;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @signalsWillAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Signals will appear here when available'**
  String get signalsWillAppearHere;

  /// No description provided for @pricing.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get pricing;

  /// No description provided for @choosePlanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a plan that works for you'**
  String get choosePlanSubtitle;

  /// No description provided for @financialNewsHub.
  ///
  /// In en, this message translates to:
  /// **'Financial News Hub'**
  String get financialNewsHub;

  /// No description provided for @financialNewsHubDesc.
  ///
  /// In en, this message translates to:
  /// **'Critical updates. Market reactions. No noise – just what investors need to know.'**
  String get financialNewsHubDesc;

  /// No description provided for @newsTabAllArticles.
  ///
  /// In en, this message translates to:
  /// **'All Articles'**
  String get newsTabAllArticles;

  /// No description provided for @newsTabInvestor.
  ///
  /// In en, this message translates to:
  /// **'Investor'**
  String get newsTabInvestor;

  /// No description provided for @newsTabKnowledge.
  ///
  /// In en, this message translates to:
  /// **'Knowledge'**
  String get newsTabKnowledge;

  /// No description provided for @newsTabTechnicalAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Technical Analysis'**
  String get newsTabTechnicalAnalysis;

  /// No description provided for @noArticlesForCategory.
  ///
  /// In en, this message translates to:
  /// **'No articles for category {category}'**
  String noArticlesForCategory(Object category);

  /// No description provided for @mostPopular.
  ///
  /// In en, this message translates to:
  /// **'Most popular'**
  String get mostPopular;

  /// No description provided for @noPosts.
  ///
  /// In en, this message translates to:
  /// **'No posts'**
  String get noPosts;

  /// No description provided for @relatedArticles.
  ///
  /// In en, this message translates to:
  /// **'Related articles'**
  String get relatedArticles;

  /// No description provided for @contactInfoSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Contact information sent successfully.'**
  String get contactInfoSentSuccess;

  /// No description provided for @contactInfoSentFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send information: {error}'**
  String contactInfoSentFailed(Object error);

  /// No description provided for @contactPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Have questions or need AI solutions? Let us know by filling out the form, and we\'ll be in touch!'**
  String get contactPageSubtitle;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @enterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter First Name'**
  String get enterFirstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @enterLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter Last Name'**
  String get enterLastName;

  /// No description provided for @whatAreYourConcerns.
  ///
  /// In en, this message translates to:
  /// **'What Are Your Concerns?'**
  String get whatAreYourConcerns;

  /// No description provided for @writeConcernsHere.
  ///
  /// In en, this message translates to:
  /// **'Write Concerns Here...'**
  String get writeConcernsHere;

  /// No description provided for @pleaseEnter.
  ///
  /// In en, this message translates to:
  /// **'Please enter {field}'**
  String pleaseEnter(Object field);

  /// No description provided for @faqQuestion1.
  ///
  /// In en, this message translates to:
  /// **'Do the signals ensure a 100% success rate?'**
  String get faqQuestion1;

  /// No description provided for @faqAnswer1.
  ///
  /// In en, this message translates to:
  /// **'While no signal can be guaranteed 100%, Signal GPT strives to maintain a stable 60–80% success rate, supported by detailed analysis and risk management so you can make the final decision with greater confidence.'**
  String get faqAnswer1;

  /// No description provided for @faqQuestion2.
  ///
  /// In en, this message translates to:
  /// **'If I don’t want to deposit right away, can I still receive signal suggestions?'**
  String get faqQuestion2;

  /// No description provided for @faqAnswer2.
  ///
  /// In en, this message translates to:
  /// **'When opening an account, the system will gift you 10 free tokens, equivalent to 10 detailed signal views. After that, you will receive 1 additional token every day to use. If you upgrade to a VIP account, you will unlock many advanced features and track an unlimited number of orders.'**
  String get faqAnswer2;

  /// No description provided for @faqQuestion3.
  ///
  /// In en, this message translates to:
  /// **'If I’ve signed up but haven’t received any signals, what steps should I take?'**
  String get faqQuestion3;

  /// No description provided for @faqAnswer3.
  ///
  /// In en, this message translates to:
  /// **'Processing is typically automatic. If you still don’t see any signal suggestions, please contact us via Whatsapp for instant assistance.'**
  String get faqAnswer3;

  /// No description provided for @faqQuestion4.
  ///
  /// In en, this message translates to:
  /// **'How many signals will I receive per day when upgrading to a VIP account?'**
  String get faqQuestion4;

  /// No description provided for @faqAnswer4.
  ///
  /// In en, this message translates to:
  /// **'When upgrading to a VIP account, you will receive unlimited trading signals every day. The number of signals is not fixed but depends entirely on market analysis. Whenever a high-quality, high-probability entry point appears, the analysis team will send the signal to you immediately.'**
  String get faqAnswer4;

  /// No description provided for @priceLevels.
  ///
  /// In en, this message translates to:
  /// **'Price Levels'**
  String get priceLevels;

  /// No description provided for @capitalManagement.
  ///
  /// In en, this message translates to:
  /// **'Capital Management'**
  String get capitalManagement;

  /// No description provided for @freeSignalsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} free signals left'**
  String freeSignalsLeft(Object count);

  /// No description provided for @unlimitedSignals.
  ///
  /// In en, this message translates to:
  /// **'Unlimited signals'**
  String get unlimitedSignals;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBack;

  /// No description provided for @goldPlan.
  ///
  /// In en, this message translates to:
  /// **'Gold Plan'**
  String get goldPlan;

  /// No description provided for @perMonth.
  ///
  /// In en, this message translates to:
  /// **'/ month'**
  String get perMonth;

  /// No description provided for @continuouslyUpdating.
  ///
  /// In en, this message translates to:
  /// **'Continuously updating market data 24/7'**
  String get continuouslyUpdating;

  /// No description provided for @providingBestSignals.
  ///
  /// In en, this message translates to:
  /// **'Providing the best signals in real time'**
  String get providingBestSignals;

  /// No description provided for @includesEntrySlTp.
  ///
  /// In en, this message translates to:
  /// **'Includes Entry, SL, TP'**
  String get includesEntrySlTp;

  /// No description provided for @detailedAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Detailed analysis and evaluation of each signal'**
  String get detailedAnalysis;

  /// No description provided for @realTimeNotifications.
  ///
  /// In en, this message translates to:
  /// **'Real-time notifications via email'**
  String get realTimeNotifications;

  /// No description provided for @signalPerformanceStats.
  ///
  /// In en, this message translates to:
  /// **'Signal performance statistics'**
  String get signalPerformanceStats;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED'**
  String get companyName;

  /// No description provided for @enterpriseCodeDetails.
  ///
  /// In en, this message translates to:
  /// **'Business Registration Number: 0110057263'**
  String get enterpriseCodeDetails;

  /// No description provided for @addressDetails.
  ///
  /// In en, this message translates to:
  /// **'Address: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam'**
  String get addressDetails;

  /// No description provided for @pagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Pages'**
  String get pagesTitle;

  /// No description provided for @legalRegulatoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Legal & Regulatory'**
  String get legalRegulatoryTitle;

  /// No description provided for @termsOfRegistration.
  ///
  /// In en, this message translates to:
  /// **'Terms Of Registration'**
  String get termsOfRegistration;

  /// No description provided for @operatingPrinciples.
  ///
  /// In en, this message translates to:
  /// **'Operating Principles'**
  String get operatingPrinciples;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @contactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contactTitle;

  /// No description provided for @navFeatures.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get navFeatures;

  /// No description provided for @navNews.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get navNews;

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

  /// No description provided for @errorLoadingPackages.
  ///
  /// In en, this message translates to:
  /// **'Error Loading Packages'**
  String get errorLoadingPackages;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @annually.
  ///
  /// In en, this message translates to:
  /// **'Annually'**
  String get annually;

  /// No description provided for @whatsIncluded.
  ///
  /// In en, this message translates to:
  /// **'What\'s included:'**
  String get whatsIncluded;

  /// No description provided for @chooseThisPlan.
  ///
  /// In en, this message translates to:
  /// **'Choose this plan'**
  String get chooseThisPlan;

  /// No description provided for @bestPricesForPremiumAccess.
  ///
  /// In en, this message translates to:
  /// **'Best Prices for Premium Access'**
  String get bestPricesForPremiumAccess;

  /// No description provided for @choosePlanFitsNeeds.
  ///
  /// In en, this message translates to:
  /// **'Choose a plan that fits your business needs and start automating with AI'**
  String get choosePlanFitsNeeds;

  /// No description provided for @save50Percent.
  ///
  /// In en, this message translates to:
  /// **'SAVE 50%'**
  String get save50Percent;

  /// No description provided for @tryDemo.
  ///
  /// In en, this message translates to:
  /// **'Try demo'**
  String get tryDemo;

  /// No description provided for @pleaseEnterEmailPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter email and password'**
  String get pleaseEnterEmailPassword;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed: {error}'**
  String loginFailed(String error);

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your account to continue'**
  String get signInToContinue;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'example123@gmail.com'**
  String get emailHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enterPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPassword;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create new account here!'**
  String get createNewAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signUpAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Account'**
  String get signUpAccount;

  /// No description provided for @enterPersonalData.
  ///
  /// In en, this message translates to:
  /// **'Enter your personal data to create your account'**
  String get enterPersonalData;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name *'**
  String get nameLabel;

  /// No description provided for @enterNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Name'**
  String get enterNameHint;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email *'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password *'**
  String get passwordLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneLabel;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields.'**
  String get fillAllFields;

  /// No description provided for @accountCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully.'**
  String get accountCreatedSuccess;

  /// No description provided for @signUpFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign up failed: {error}'**
  String signUpFailed(String error);

  /// No description provided for @nationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality:'**
  String get nationality;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @paymentHistory.
  ///
  /// In en, this message translates to:
  /// **'Payment History'**
  String get paymentHistory;

  /// No description provided for @signalsPlan.
  ///
  /// In en, this message translates to:
  /// **'Signals Plan'**
  String get signalsPlan;

  /// No description provided for @aiMinvest.
  ///
  /// In en, this message translates to:
  /// **'AI Minvest'**
  String get aiMinvest;

  /// No description provided for @yourTokens.
  ///
  /// In en, this message translates to:
  /// **'Your Tokens'**
  String get yourTokens;

  /// No description provided for @emailNotificationPreferences.
  ///
  /// In en, this message translates to:
  /// **'Browser Notification Preferences'**
  String get emailNotificationPreferences;

  /// No description provided for @chooseSignalNotificationTypes.
  ///
  /// In en, this message translates to:
  /// **'Choose which types of signal notifications you want to receive via browser push'**
  String get chooseSignalNotificationTypes;

  /// No description provided for @allSignalNotifications.
  ///
  /// In en, this message translates to:
  /// **'All Signal Notifications'**
  String get allSignalNotifications;

  /// No description provided for @cryptoSignals.
  ///
  /// In en, this message translates to:
  /// **'Crypto Signals'**
  String get cryptoSignals;

  /// No description provided for @forexSignals.
  ///
  /// In en, this message translates to:
  /// **'Forex Signals'**
  String get forexSignals;

  /// No description provided for @goldSignals.
  ///
  /// In en, this message translates to:
  /// **'Gold Signals'**
  String get goldSignals;

  /// No description provided for @updatePasswordSecure.
  ///
  /// In en, this message translates to:
  /// **'Update your password to keep your account secure'**
  String get updatePasswordSecure;

  /// No description provided for @searchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search:'**
  String get searchLabel;

  /// No description provided for @filterBy.
  ///
  /// In en, this message translates to:
  /// **'Filter by:'**
  String get filterBy;

  /// No description provided for @allTime.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get allTime;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date:'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date:'**
  String get endDate;

  /// No description provided for @deactivate.
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get deactivate;

  /// No description provided for @unlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get unlimited;

  /// No description provided for @tenLeft.
  ///
  /// In en, this message translates to:
  /// **'10 left'**
  String get tenLeft;

  /// No description provided for @termsOfRegistrationContent.
  ///
  /// In en, this message translates to:
  /// **'Please read all the terms and agreements below carefully before proceeding with the next steps in our system.\nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\n1. Introduction and Scope of Application\n\nThis policy regulates the collection, use, sharing, and protection of users’ personal information when accessing and using the products and services of the Signal GPT system – a technology and artificial intelligence platform owned and operated by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED (hereinafter referred to as “we” or “us”).\nBy registering an account or using Signal GPT’s products, you agree that such action constitutes a legally binding commitment between you and us, equivalent to an electronic contract.\n\n2. Account Registration\n\nTo access and use certain services on Signal GPT, you must register a valid account.\nWhen registering, you are required to provide complete and accurate personal information, including your full name, email address, phone number, or any other information as requested.\nAfter registration, you must confirm your email to activate the account. All notifications about your account, promotions, or system updates will be sent to this email address.\nIf the information you provide is inaccurate or incomplete, you will be solely responsible for any incidents or damages arising from it.\n\n3. Terms of Use\n\nWhen participating in the Signal GPT system, you are obligated to comply with all of the following:\nThe operating principles of the platform;\nPayment terms;\nPersonal data privacy policy;\nRelevant laws and regulations in effect.\nIn the event of a violation, EZTRADE reserves the right to temporarily suspend or permanently delete your account, and may transfer the case to competent authorities if necessary.\n\n4. Personal Data Privacy Policy\n\n4.1. Purpose and Scope of Collection\n\nTo provide its services, Signal GPT collects necessary information including: full name, email, phone number, means of contact, and technical data such as IP address, browser type, access time, language, and accessed pages.\nThis information is used for the following purposes:\nTo verify accounts and manage users;\nTo provide services and customer support;\nTo send notifications, offers, or important updates;\nTo improve system quality and user experience.\nAll declared information must be accurate and lawful. We are not responsible for any disputes or damages resulting from false declarations.\n\n4.2. Scope of Information Use\n\nSignal GPT only uses your personal information for internal purposes and in compliance with Vietnamese laws.\nWe may contact you via email, phone, SMS, or other communication channels for technical support, order confirmation, or promotional updates.\n\n4.3. Data Retention Period\n\nYour personal information will be stored until one of the following occurs:\nYou request account deletion; or\nThe Signal GPT system ceases operation in accordance with regulations.\nDuring this period, your data will be securely protected on EZTRADE’s servers.\n\n4.4. Rights and Obligations of Data Subjects\n\nUser Rights:\nTo be informed of, consent to, or refuse the processing of their personal data;\nTo access, edit, delete, or request restriction of data processing;\nTo object, file complaints, initiate legal proceedings, or request compensation for damages as provided by law.\nUser Obligations:\nTo provide truthful and accurate information;\nTo protect their own personal data and respect the privacy of others;\nTo comply with applicable laws and Signal GPT’s privacy policy.\n\n4.5. Information of the Personal Data Processor\n\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness Registration Number: 0110057263\nPhone: 0862 600 626\n\n4.6. Means and Tools for Editing Information\n\nYou can access the “Account Settings” section to update or edit your personal information.\nIn case you need assistance, you may contact us through the official communication channels of Signal GPT as published on our website.\n\n4.7. Data Protection Measures\n\nSignal GPT applies advanced technical and administrative measures such as:\nData encryption, firewalls, and internal access control;\nLimiting access rights;\nEmployee training on data security.\nAny unauthorized access, disclosure, destruction, or alteration of data will be handled in accordance with the law.\n\n4.8. Entities Authorized to Access Your Information\n\nThe Signal GPT system administration team;\nYou, the customer (when logging into your own account);\nVietnamese legal authorities upon receipt of a valid written request.\n\n4.9. Complaints and Dispute Resolution\n\nAny complaints or feedback related to the protection of personal data or the use of services on the Signal GPT system may be submitted through the official support channels published on our website.\nWe will receive, review, and respond as soon as possible to ensure the lawful rights and interests of customers in accordance with legal regulations.\n\n5. Effectiveness and Updates\n\nThis policy takes effect from November 14, 2025.\nWe may change, update, or supplement this content to comply with legal requirements and operational realities.\nAll changes will be publicly announced on the mInvest.ai website prior to implementation.'**
  String get termsOfRegistrationContent;

  /// No description provided for @operatingPrinciplesContent.
  ///
  /// In en, this message translates to:
  /// **'Please read all terms and agreements below carefully before proceeding with the next steps in our system. \nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\nOPERATING RULES\n\n1. Legal Information\n\nSystem Owner:\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness/Tax Code: 0110057263\nPhone: 0862 600 626\n\n2. Scope of Application\n\nThese Operating Principles apply to all users, learners, partners, and collaborators who participate in or use the products and services within the Signal GPT system, including websites, applications, training platforms, and other online channels managed by EZTRADE.\nBy registering an account or using the services of Signal GPT, users are deemed to have read, understood, and agreed to all the terms set forth in these regulations.\n\n3. Definitions\n\n“Signal GPT” refers to the technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED.\n“Customer” / “User” / “Learner” refers to any individual or organization that registers, accesses, or uses the services and products on the Signal GPT system.\n“We” / “Administration” refers to the management team representing EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED, responsible for operating and managing the system.\n“Products” / “Services” include learning packages, analytical newsletters, AI trading signals, analytical tools, or any digital content provided by Signal GPT.\n\n4. Usage Rules and Information Security\n\nUsers must provide accurate and complete information when registering an account.\nSignal GPT is committed to protecting personal information and will not disclose it to third parties unless required by competent authorities.\nUsers are responsible for maintaining the confidentiality of their account and password. Any damages arising from personal security negligence shall not be the responsibility of EZTRADE.\nSignal GPT reserves the right to suspend or terminate accounts found to be in violation of the terms, including but not limited to: account sharing, content distribution, or infringement of intellectual property rights.\n\n5. Refund Policy and Service Usage\n\nAll payments, once confirmed, are non-refundable under any circumstances, except in cases of system errors originating from Signal GPT.\nUsers may discontinue service use at any time; however, any paid fees will not be retained or converted.\nSignal GPT reserves the right to adjust service prices, promotional policies, or special offers without prior notice. Users are responsible for regularly reviewing and staying updated.\n\n6. Conduct and Content Usage Regulations\n\nThe following actions are strictly prohibited:\nCopying, downloading, distributing, or sharing content, videos, or materials belonging to the Signal GPT system;\nUsing software or tools to interfere with or illegally collect data;\nImpersonating Signal GPT, EZTRADE, or any of its representatives for the purpose of fraud, deception, or brand defamation;\nSharing accounts with multiple users;\nPosting, speaking, or engaging in actions containing offensive, defamatory, or harmful content toward the system.\nAny violation of the above may result in permanent account suspension and could be subject to legal action under Vietnamese law.\n\n7. Commitment and Limitation of Liability\n\nSignal GPT provides products based on knowledge, data, and AI algorithms developed by the EZTRADE team.\nThe effectiveness of use depends on each individual’s capability, experience, and actions. Signal GPT makes no guarantee of profit or specific investment results.\nEZTRADE shall be exempt from all liability for indirect risks or damages arising during service use, except in cases where direct system errors are proven.\n\n8. Rights of the Signal GPT Administration\n\nSignal GPT reserves the right to modify, update, or supplement the operating terms at any time without prior notice.\nWe have the right to suspend or terminate the provision of services in cases of legal violations, policy breaches, or for technical or system maintenance reasons.\nWe may cooperate with competent authorities in handling complaints, investigating violations, and providing necessary information as required by law.\n\n9. Acknowledgment of Consent\n\nBy registering and using the Signal GPT system, you hereby confirm that:\nYou have read carefully, fully understood, and agreed to all the contents of these Operating Principles;\nYou consent to allow EZTRADE to use your contact information (phone, email, SMS, Zalo, etc.) to send notifications, product updates, promotions, or new program announcements.'**
  String get operatingPrinciplesContent;

  /// No description provided for @termsAndConditionsContent.
  ///
  /// In en, this message translates to:
  /// **'By registering an account to participate in the Signal GPT system, you confirm that you have read, understood, and agreed to all the contents of these Account Opening Terms and Conditions.\nThe latest updates (if any) will be published here, and Signal GPT will not send separate notifications to each customer. Therefore, please visit this page regularly to stay informed about the most recent policies.\n\n1. General Agreement\n\nSignal GPT is a technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED. By opening an account on this system, you agree to participate in and use the services and products provided by EZTRADE.\nAccount registration and activation are considered an electronic contract between you and Signal GPT, which has the same legal validity as a civil contract under the laws of Vietnam.\n\n2. Personal Account Information and Privacy\n\n2.1. Purpose and Scope of Information Collection\n\nTo access and use certain Signal GPT services, you must provide basic personal information, including:\nFull name;\nEmail address;\nContact phone number;\nOther information (if any) necessary for verification, support, or access authorization.\nAll information provided must be accurate, truthful, and lawful. Signal GPT shall not be responsible for any losses or disputes arising from false, missing, or fraudulent information provided by the user.\nAdditionally, the system may automatically collect certain technical data, such as:\nIP address, browser type, and language used;\nAccess time and pages viewed within the system.\nThis information helps Signal GPT improve performance, enhance security, and optimize user experience.\n\n2.2. Scope of Information Use\n\nYour personal information is collected and used for legitimate purposes, including:\nManaging accounts, verifying users, and maintaining services;\nSending notifications related to services, accounts, promotions, or policy changes;\nProviding technical support, customer service, and dispute resolution (if any);\nData analysis to improve product quality and user experience.\nWe are committed to protecting your personal information and will not share it with third parties unless required by law or competent authorities.\n\n2.3. Data Retention Period\n\nYour information will be stored until one of the following occurs:\nYou request account deletion; or\nThe Signal GPT system ceases operation in accordance with applicable laws.\nIn all cases, your data will be securely stored and strictly protected on EZTRADE’s servers.\n\n2.4. Entity Responsible for Collecting and Managing Personal Information\n\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness Registration Number: 0110057263\n\n2.5. Methods and Tools for Editing Information\n\nYou can access the “Account Settings” section within the system to edit or update your personal information. If you encounter difficulties while doing so, please contact us through the official support channels of Signal GPT as published on the website.\n\n2.6. Information Provision and Verification\n\nTo ensure account security and protect your rights, you must:\nProvide accurate full name, email, and phone number during registration;\nVerify your information via the confirmation email sent by the system;\nReceive activation, password reset, or other important notifications from Signal GPT.\nIf the provided information is inaccurate or incomplete, you shall be solely responsible for any related risks (e.g., account activation failure, loss of access, or missed notifications).\n\n2.7. User Confidentiality Obligations and Responsibilities\n\nYou are responsible for safeguarding your login credentials and password.\nIf your password is lost, disclosed, or accessed without authorization, Signal GPT shall not be liable for any resulting damages.\nYou agree to allow EZTRADE to store, manage, and process your personal information in accordance with the laws of Vietnam.\n\n2.8. Access Rights to Your Information\n\nYour personal information may only be accessed by:\nThe Signal GPT system administration team (for management and technical purposes);\nThe account owner (via the personal information management section);\nVietnamese authorities, upon receipt of a valid and lawful request as prescribed by law.\n\n2.9. Complaint and Resolution Mechanism\n\nFor any complaints or feedback related to account registration, usage, or information security, you may submit a request through the official Contact page of Signal GPT.\nWe will receive, process, and respond as soon as possible to ensure the customer’s lawful rights and interests in accordance with applicable legal regulations.\n\n3. Effectiveness and Updates\n\nThese Account Opening Terms and Conditions take effect from November 14, 2025. Signal GPT reserves the right to update, modify, or supplement the contents at any time without prior notice. All changes will be publicly announced on the mInvest.ai website prior to implementation.'**
  String get termsAndConditionsContent;

  /// No description provided for @performance.
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get performance;

  /// No description provided for @minvestSupport.
  ///
  /// In en, this message translates to:
  /// **'SignalGpt Support'**
  String get minvestSupport;

  /// No description provided for @leaveMessagePart1.
  ///
  /// In en, this message translates to:
  /// **'Please leave a message, our team will respond as soon as possible. You can also contact '**
  String get leaveMessagePart1;

  /// No description provided for @chatWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get chatWhatsApp;

  /// No description provided for @leaveMessagePart2.
  ///
  /// In en, this message translates to:
  /// **' +84 969 156 969 for fast support.'**
  String get leaveMessagePart2;

  /// No description provided for @currentPlan.
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get currentPlan;

  /// No description provided for @standard.
  ///
  /// In en, this message translates to:
  /// **'STANDARD'**
  String get standard;

  /// No description provided for @availableTokens.
  ///
  /// In en, this message translates to:
  /// **'Available Tokens'**
  String get availableTokens;

  /// No description provided for @subscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get subscriptions;

  /// No description provided for @usesTokenPerView.
  ///
  /// In en, this message translates to:
  /// **'Uses 1 Token per view'**
  String get usesTokenPerView;

  /// No description provided for @unlimitedAccess.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Access'**
  String get unlimitedAccess;

  /// No description provided for @activeElite.
  ///
  /// In en, this message translates to:
  /// **'Active (Elite)'**
  String get activeElite;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @transactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistory;

  /// No description provided for @noTransactionsFound.
  ///
  /// In en, this message translates to:
  /// **'No transactions found.'**
  String get noTransactionsFound;

  /// No description provided for @colDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get colDate;

  /// No description provided for @colProduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get colProduct;

  /// No description provided for @colAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get colAmount;

  /// No description provided for @colMethod.
  ///
  /// In en, this message translates to:
  /// **'Method'**
  String get colMethod;

  /// No description provided for @colStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get colStatus;

  /// No description provided for @statusSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get statusSuccess;

  /// No description provided for @featureForVipOnly.
  ///
  /// In en, this message translates to:
  /// **'This feature is only for VIP customers, please upgrade to receive notifications.'**
  String get featureForVipOnly;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully'**
  String get passwordUpdateSuccess;

  /// No description provided for @passwordUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update password: {error}'**
  String passwordUpdateFailed(String error);

  /// No description provided for @reauthFailed.
  ///
  /// In en, this message translates to:
  /// **'Incorrect current password'**
  String get reauthFailed;

  /// No description provided for @signInRequired.
  ///
  /// In en, this message translates to:
  /// **'Sign in Required'**
  String get signInRequired;

  /// No description provided for @signInToExploreSignal.
  ///
  /// In en, this message translates to:
  /// **'Sign in to explore this trading signal!'**
  String get signInToExploreSignal;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'cs',
        'da',
        'de',
        'en',
        'es',
        'fi',
        'fr',
        'hi',
        'hu',
        'id',
        'it',
        'ja',
        'km',
        'ko',
        'mn',
        'ms',
        'pt',
        'ro',
        'ru',
        'th',
        'vi',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'cs':
      return AppLocalizationsCs();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fi':
      return AppLocalizationsFi();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'hu':
      return AppLocalizationsHu();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'km':
      return AppLocalizationsKm();
    case 'ko':
      return AppLocalizationsKo();
    case 'mn':
      return AppLocalizationsMn();
    case 'ms':
      return AppLocalizationsMs();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'th':
      return AppLocalizationsTh();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
