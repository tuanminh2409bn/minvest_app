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
      'Could not create payment link.\nTry again.';

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
  String get aiSignal => 'AI Signal';

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

  @override
  String get getSignalsNow => 'Get Signals Now';

  @override
  String get freeTrial => 'Free Trial';

  @override
  String get heroTitle => 'Guiding Traders & Growing Portfolios';

  @override
  String get heroSubtitle =>
      'The Ultimate AI Engine – Designed by Expert Traders';

  @override
  String get globalAiInnovationTitle =>
      'Global AI Innovation for the Next Generation of Trading Intelligence';

  @override
  String get globalAiInnovationDesc =>
      'Transforming traditional trading with cloud-powered AI signals — adaptive to real-time market news and trends for faster, more precise, and emotion-free performance.';

  @override
  String get liveTradingSignalsTitle => 'LIVE – 24/7 AI Trading Signals';

  @override
  String get liveTradingSignalsDesc =>
      'Real-time cloud analytics delivering high-probability, trend-following strategies with adaptive precision and emotion-free execution.';

  @override
  String get trendFollowing => 'Trend-Following';

  @override
  String get realtime => 'Real-time';

  @override
  String get orderExplanationEngineTitle => 'Order Explanation Engine';

  @override
  String get orderExplanationEngineDesc =>
      'Explains trade setups in simple terms — showing how confluences form, why entries are made, and helping traders learn from each decision.';

  @override
  String get transparent => 'Transparent';

  @override
  String get educational => 'Educational';

  @override
  String get logical => 'Logical';

  @override
  String get transparentRealPerformanceTitle =>
      'Transparent - Real Performance';

  @override
  String get transparentRealPerformanceDesc =>
      'See real data on signal accuracy, success rate, and profitability — verified and traceable in every trade';

  @override
  String get results => 'Results';

  @override
  String get performanceTracking => 'Performance-Tracking';

  @override
  String get accurate => 'Accurate';

  @override
  String get predictiveAccuracy => 'Predictive Accuracy';

  @override
  String get improvementInProfitability => 'Improvement in Profitability';

  @override
  String get improvedRiskManagement => 'Improved Risk Management';

  @override
  String get signalsPerformanceTitle => 'Signals Performance';

  @override
  String get riskToRewardRatio => 'Risk-to-Reward Ratio';

  @override
  String get howRiskComparesToReward => 'How risk compares to reward';

  @override
  String get profitLossOverview => 'Profit/Loss Overview';

  @override
  String get netGainVsLoss => 'Net gain vs loss';

  @override
  String get winRate => 'Win Rate';

  @override
  String get percentageOfWinningTrades => 'Percentage of winning trades';

  @override
  String get accuracyRate => 'Accuracy Rate';

  @override
  String get howPreciseOurSignalsAre => 'How precise our signals are';

  @override
  String get realtimeMarketAnalysis => 'Real-Time Market Analysis';

  @override
  String get realtimeMarketAnalysisDesc =>
      'Our AI monitors the market continuously, identifying technical convergence zones and reliable breakout points so you can enter trades at the right moment.';

  @override
  String get saveTimeOnAnalysis => 'Save Time on Analysis';

  @override
  String get saveTimeOnAnalysisDesc =>
      'No more hours spent reading charts. Receive tailored investment strategies in just minutes a day.';

  @override
  String get minimizeEmotionalTrading => 'Minimize Emotional Trading';

  @override
  String get minimizeEmotionalTradingDesc =>
      'With smart alerts, risk detection, and data-driven signals not emotions you stay disciplined and in control of every decision.';

  @override
  String get seizeEveryOpportunity => 'Seize Every Opportunity';

  @override
  String get seizeEveryOpportunityDesc =>
      'Timely strategy updates delivered straight to your inbox ensure you ride market trends at the perfect time.';

  @override
  String get minvestAiCoreValueTitle => 'Minvest AI- Core value';

  @override
  String get minvestAiCoreValueDesc =>
      'AI analyzes real-time market data continuously, filtering insights to identify fast, accurate investment opportunities';

  @override
  String get frequentlyAskedQuestions => 'Frequently Asked Questions';

  @override
  String get maximizeResultsTitle =>
      'Maximize your results with Minvest AI advanced market analysis and precision-filtered signals';

  @override
  String get elevateTradingWithAiStrategies =>
      'Elevate your trading with AI-enhanced strategies crafted for consistency and clarity';

  @override
  String get winMoreWithAiSignalsTitle =>
      'Win More with AI-Powered Signals\nin Every Market';

  @override
  String get winMoreWithAiSignalsDesc =>
      'Our multi-market AI scans Forex, Crypto, and Metals in real-time,\n\' \'delivering expert-validated trading signals —\n\' \'with clear entry, stop-loss, and take-profit levels';

  @override
  String get buyLimit => 'Buy limit';

  @override
  String get sellLimit => 'Sell limit';

  @override
  String get smarterToolsTitle => 'Smarter Tools - Better Investments';

  @override
  String get smarterToolsDesc =>
      'Discover the features that help you minimize risks, seize opportunities, and grow your wealth';

  @override
  String get performanceOverviewTitle => 'Performance Overview';

  @override
  String get performanceOverviewDesc =>
      'Our multi-market AI scans Forex, Crypto, and Metals in real-time, delivering expert-validated trading signals - with clear entry, stop-loss, and take-profit levels';

  @override
  String get totalProfit => 'Total Profit';

  @override
  String get completionSignal => 'Completion signal';

  @override
  String get onDemandFinancialExpertTitle => 'Your On-Demand Financial Expert';

  @override
  String get onDemandFinancialExpertDesc =>
      'AI platform suggests trading signals - self-learning, analyses the market 24/7, unaffected by emotions. Minvest has supported over 10,000 financial analysts\nin their journey to find accurate, stable, and easy-to-apply signals';

  @override
  String get aiPoweredSignalPlatform => 'AI-Powered Trading Signal Platform';

  @override
  String get selfLearningSystems =>
      'Self-Learning Systems, Sharper Insights, Stronger Trades';

  @override
  String get emotionlessExecution =>
      'Emotionless Execution For Smarter,\nMore Disciplined Trading';

  @override
  String get analysingMarket247 => 'Analysing the market 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Maximize your results with Minvest AI\nadvanced market analysis and precision-filtered signals';

  @override
  String get minvestAiRegistrationDesc =>
      'Minvest AI registration is now open — spots may close soon as we review and approve new members';

  @override
  String get currencyPairs => 'Currency pairs';

  @override
  String get allCurrencyPairs => 'All Currency pairs';

  @override
  String get dateRange => 'Date Range';

  @override
  String get selectDateRange => 'Select Date Range';

  @override
  String get allAssets => 'All Assets';

  @override
  String get asset => 'Asset';

  @override
  String get tokenExpired => 'Token expired';

  @override
  String get tokenLimitReachedDesc =>
      'You have used up your 10 free tokens today. Upgrade your package to view more signals.';

  @override
  String get later => 'Later';

  @override
  String get created => 'Created';

  @override
  String get detail => 'Detail';

  @override
  String get performanceOverview => 'Performance Overview';

  @override
  String get totalProfitPips => 'Total Profit (Pips)';

  @override
  String get winRatePercent => 'Win Rate (%)';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get errorLoadingHistory => 'Error loading history';

  @override
  String get noHistoryAvailable => 'No signal history available';

  @override
  String get previous => 'Previous';

  @override
  String get page => 'Page';

  @override
  String get next => 'Next';

  @override
  String get date => 'Date';

  @override
  String get timeGmt7 => 'Time (GMT +7)';

  @override
  String get orders => 'Orders';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      'Small screen: rotate landscape or scroll horizontally to view the full table.';

  @override
  String get history => 'History';

  @override
  String get signalsWillAppearHere => 'Signals will appear here when available';

  @override
  String get pricing => 'Pricing';

  @override
  String get choosePlanSubtitle => 'Choose a plan that works for you';

  @override
  String get financialNewsHub => 'Financial News Hub';

  @override
  String get financialNewsHubDesc =>
      'Critical updates. Market reactions. No noise – just what investors need to know.';

  @override
  String get newsTabAllArticles => 'All Articles';

  @override
  String get newsTabInvestor => 'Investor';

  @override
  String get newsTabKnowledge => 'Knowledge';

  @override
  String get newsTabTechnicalAnalysis => 'Technical Analysis';

  @override
  String noArticlesForCategory(Object category) {
    return 'No articles for category $category';
  }

  @override
  String get mostPopular => 'Most popular';

  @override
  String get noPosts => 'No posts';

  @override
  String get relatedArticles => 'Related articles';

  @override
  String get contactInfoSentSuccess => 'Contact information sent successfully.';

  @override
  String contactInfoSentFailed(Object error) {
    return 'Failed to send information: $error';
  }

  @override
  String get contactPageSubtitle =>
      'Have questions or need AI solutions? Let us know by filling out the form, and we\'ll be in touch!';

  @override
  String get phone => 'Phone';

  @override
  String get firstName => 'First Name';

  @override
  String get enterFirstName => 'Enter First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get enterLastName => 'Enter Last Name';

  @override
  String get whatAreYourConcerns => 'What Are Your Concerns?';

  @override
  String get writeConcernsHere => 'Write Concerns Here...';

  @override
  String pleaseEnter(Object field) {
    return 'Please enter $field';
  }

  @override
  String get faqQuestion1 => 'Do the signals ensure a 100% success rate?';

  @override
  String get faqAnswer1 =>
      'While no signal can be guaranteed 100%, Minvest AI strives to maintain a stable 60–80% success rate, supported by detailed analysis and risk management so you can make the final decision with greater confidence.';

  @override
  String get faqQuestion2 =>
      'If I don’t want to deposit right away, can I still receive signal suggestions?';

  @override
  String get faqAnswer2 =>
      'Yes. Simply create an Exness account through the Minvest link, and you’ll get access to our free demo signal group (Community VIP).';

  @override
  String get faqQuestion3 =>
      'If I’ve signed up but haven’t received any signals, what steps should I take?';

  @override
  String get faqAnswer3 =>
      'Processing is typically automatic. If you still don’t see any signal suggestions, please contact us via Whatsapp for instant assistance.';

  @override
  String get faqQuestion4 =>
      'Can I still join if I don’t sign up for an Exness account?';

  @override
  String get faqAnswer4 =>
      'Please contact us via WhatsApp or Live Chat for assistance.';

  @override
  String get priceLevels => 'Price Levels';

  @override
  String get capitalManagement => 'Capital Management';

  @override
  String freeSignalsLeft(Object count) {
    return '$count free signals left';
  }

  @override
  String get unlimitedSignals => 'Unlimited signals';

  @override
  String get goBack => 'Go back';

  @override
  String get goldPlan => 'Gold Plan';

  @override
  String get perMonth => '/month';

  @override
  String get continuouslyUpdating => 'Continuously updating market data 24/7';

  @override
  String get providingBestSignals => 'Providing the best signals in real time';

  @override
  String get includesEntrySlTp => 'Includes Entry, SL, TP';

  @override
  String get detailedAnalysis =>
      'Detailed analysis and evaluation of each signal';

  @override
  String get realTimeNotifications => 'Real-time notifications via email';

  @override
  String get signalPerformanceStats => 'Signal performance statistics';

  @override
  String get enterpriseCodeDetails =>
      'Enterprise code: 0107136243 is issued by the Hanoi Department of Finance on 24/11/2015; 6th amendment registered by the Hanoi Department of Finance on 05/08/2025.';

  @override
  String get addressDetails =>
      'Address: C2810, 18th Floor, C2 Building, HH Lot, Dong Nam Urban Area, Tran Duy Hung St., Yen Hoa Ward, Hanoi, Vietnam.';

  @override
  String get pagesTitle => 'Pages';

  @override
  String get legalRegulatoryTitle => 'Legal & Regulatory';

  @override
  String get termsOfRegistration => 'Terms Of Registration';

  @override
  String get operatingPrinciples => 'Operating Principles';

  @override
  String get termsConditions => 'Terms & Conditions';

  @override
  String get contactTitle => 'Contact';

  @override
  String get navFeatures => 'Features';

  @override
  String get navNews => 'News';

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
  String get errorLoadingPackages => 'Error Loading Packages';
}
