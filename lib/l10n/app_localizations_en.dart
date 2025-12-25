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
  String get aiSignal => 'AI Signals';

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
  String get startNow => 'Get Signals Now';

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
  String get chatWelcomeTitle => '👋 Welcome to Signal GPT!';

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
      'Transforming traditional trading with cloud-powered AI signals — adaptive to real-time market news and trends\nfor faster, more precise, and emotion-free performance.';

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
  String get minvestAiCoreValueTitle => 'Signal GPT- Core value';

  @override
  String get minvestAiCoreValueDesc =>
      'AI analyzes real-time market data continuously, filtering insights to identify fast, accurate investment opportunities';

  @override
  String get frequentlyAskedQuestions => 'Frequently Asked Questions (FAQ)';

  @override
  String get faqSubtitle =>
      'All your questions — from how to join, to the benefits, to how our AI works — are answered just below. If you still have any doubts, feel free to message us on Whatsapp';

  @override
  String get maximizeResultsTitle =>
      'Maximize your results with Signal GPT\nadvanced market analysis and precision-filtered signals';

  @override
  String get elevateTradingWithAiStrategies =>
      'Elevate your trading with AI-enhanced strategies crafted for consistency and clarity';

  @override
  String get winMoreWithAiSignalsTitle =>
      'Win More with AI-Powered Signals\nin Every Market';

  @override
  String get winMoreWithAiSignalsDesc =>
      'Our multi-market AI scans Forex, Crypto, and Metals in real-time,\ndelivering expert-validated trading signals —\nwith clear entry, stop-loss, and take-profit levels';

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
      'Maximize your results with Signal GPT\nadvanced market analysis and precision-filtered signals';

  @override
  String get minvestAiRegistrationDesc =>
      'Signal GPT registration is now open — spots may close soon as we review and approve new members';

  @override
  String get currencyPairs => 'Commodity';

  @override
  String get allCurrencyPairs => 'All Currency Pairs';

  @override
  String get allCommodities => 'All Commodities';

  @override
  String get allCryptoPairs => 'All Crypto Pairs';

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
  String get timeGmt7 => 'Time (GMT)';

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
      'While no signal can be guaranteed 100%, Signal GPT strives to maintain a stable 60–80% success rate, supported by detailed analysis and risk management so you can make the final decision with greater confidence.';

  @override
  String get faqQuestion2 =>
      'If I don’t want to deposit right away, can I still receive signal suggestions?';

  @override
  String get faqAnswer2 =>
      'When opening an account, the system will gift you 10 free tokens, equivalent to 10 detailed signal views. After that, you will receive 1 additional token every day to use. If you upgrade to a VIP account, you will unlock many advanced features and track an unlimited number of orders.';

  @override
  String get faqQuestion3 =>
      'If I’ve signed up but haven’t received any signals, what steps should I take?';

  @override
  String get faqAnswer3 =>
      'Processing is typically automatic. If you still don’t see any signal suggestions, please contact us via Whatsapp for instant assistance.';

  @override
  String get faqQuestion4 =>
      'How many signals will I receive per day when upgrading to a VIP account?';

  @override
  String get faqAnswer4 =>
      'When upgrading to a VIP account, you will receive unlimited trading signals every day. The number of signals is not fixed but depends entirely on market analysis. Whenever a high-quality, high-probability entry point appears, the analysis team will send the signal to you immediately.';

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
  String get perMonth => '/ month';

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
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails =>
      'Business Registration Number: 0110057263';

  @override
  String get addressDetails =>
      'Address: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam';

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

  @override
  String get monthly => 'Monthly';

  @override
  String get annually => 'Annually';

  @override
  String get whatsIncluded => 'What\'s included:';

  @override
  String get chooseThisPlan => 'Choose this plan';

  @override
  String get bestPricesForPremiumAccess => 'Best Prices for Premium Access';

  @override
  String get choosePlanFitsNeeds =>
      'Choose a plan that fits your business needs and start automating with AI';

  @override
  String get save50Percent => 'SAVE 50%';

  @override
  String get tryDemo => 'Try demo';

  @override
  String get pleaseEnterEmailPassword => 'Please enter email and password';

  @override
  String loginFailed(String error) {
    return 'Login failed: $error';
  }

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInToContinue => 'Sign in to your account to continue';

  @override
  String get or => 'or';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'example123@gmail.com';

  @override
  String get password => 'Password';

  @override
  String get enterPassword => 'Enter Password';

  @override
  String get forgotPassword => 'Forgot your password?';

  @override
  String get createNewAccount => 'Create new account here!';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signUpAccount => 'Sign Up Account';

  @override
  String get enterPersonalData =>
      'Enter your personal data to create your account';

  @override
  String get nameLabel => 'Name *';

  @override
  String get enterNameHint => 'Enter Name';

  @override
  String get emailLabel => 'Email *';

  @override
  String get passwordLabel => 'Password *';

  @override
  String get phoneLabel => 'Phone';

  @override
  String get continueButton => 'Continue';

  @override
  String get fillAllFields => 'Please fill all required fields.';

  @override
  String get accountCreatedSuccess => 'Account created successfully.';

  @override
  String signUpFailed(String error) {
    return 'Sign up failed: $error';
  }

  @override
  String get nationality => 'Nationality:';

  @override
  String get overview => 'Overview';

  @override
  String get setting => 'Setting';

  @override
  String get paymentHistory => 'Payment History';

  @override
  String get signalsPlan => 'Signals Plan';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => 'Your Tokens';

  @override
  String get emailNotificationPreferences => 'Browser Notification Preferences';

  @override
  String get chooseSignalNotificationTypes =>
      'Choose which types of signal notifications you want to receive via browser push';

  @override
  String get allSignalNotifications => 'All Signal Notifications';

  @override
  String get cryptoSignals => 'Crypto Signals';

  @override
  String get forexSignals => 'Forex Signals';

  @override
  String get goldSignals => 'Gold Signals';

  @override
  String get updatePasswordSecure =>
      'Update your password to keep your account secure';

  @override
  String get searchLabel => 'Search:';

  @override
  String get filterBy => 'Filter by:';

  @override
  String get allTime => 'All Time';

  @override
  String get startDate => 'Start Date:';

  @override
  String get endDate => 'End Date:';

  @override
  String get deactivate => 'Deactivate';

  @override
  String get unlimited => 'Unlimited';

  @override
  String get tenLeft => '10 left';

  @override
  String get termsOfRegistrationContent =>
      'Please read all the terms and agreements below carefully before proceeding with the next steps in our system.\nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\n1. Introduction and Scope of Application\n\nThis policy regulates the collection, use, sharing, and protection of users’ personal information when accessing and using the products and services of the Signal GPT system – a technology and artificial intelligence platform owned and operated by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED (hereinafter referred to as “we” or “us”).\nBy registering an account or using Signal GPT’s products, you agree that such action constitutes a legally binding commitment between you and us, equivalent to an electronic contract.\n\n2. Account Registration\n\nTo access and use certain services on Signal GPT, you must register a valid account.\nWhen registering, you are required to provide complete and accurate personal information, including your full name, email address, phone number, or any other information as requested.\nAfter registration, you must confirm your email to activate the account. All notifications about your account, promotions, or system updates will be sent to this email address.\nIf the information you provide is inaccurate or incomplete, you will be solely responsible for any incidents or damages arising from it.\n\n3. Terms of Use\n\nWhen participating in the Signal GPT system, you are obligated to comply with all of the following:\nThe operating principles of the platform;\nPayment terms;\nPersonal data privacy policy;\nRelevant laws and regulations in effect.\nIn the event of a violation, EZTRADE reserves the right to temporarily suspend or permanently delete your account, and may transfer the case to competent authorities if necessary.\n\n4. Personal Data Privacy Policy\n\n4.1. Purpose and Scope of Collection\n\nTo provide its services, Signal GPT collects necessary information including: full name, email, phone number, means of contact, and technical data such as IP address, browser type, access time, language, and accessed pages.\nThis information is used for the following purposes:\nTo verify accounts and manage users;\nTo provide services and customer support;\nTo send notifications, offers, or important updates;\nTo improve system quality and user experience.\nAll declared information must be accurate and lawful. We are not responsible for any disputes or damages resulting from false declarations.\n\n4.2. Scope of Information Use\n\nSignal GPT only uses your personal information for internal purposes and in compliance with Vietnamese laws.\nWe may contact you via email, phone, SMS, or other communication channels for technical support, order confirmation, or promotional updates.\n\n4.3. Data Retention Period\n\nYour personal information will be stored until one of the following occurs:\nYou request account deletion; or\nThe Signal GPT system ceases operation in accordance with regulations.\nDuring this period, your data will be securely protected on EZTRADE’s servers.\n\n4.4. Rights and Obligations of Data Subjects\n\nUser Rights:\nTo be informed of, consent to, or refuse the processing of their personal data;\nTo access, edit, delete, or request restriction of data processing;\nTo object, file complaints, initiate legal proceedings, or request compensation for damages as provided by law.\nUser Obligations:\nTo provide truthful and accurate information;\nTo protect their own personal data and respect the privacy of others;\nTo comply with applicable laws and Signal GPT’s privacy policy.\n\n4.5. Information of the Personal Data Processor\n\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness Registration Number: 0110057263\nPhone: 0862 600 626\n\n4.6. Means and Tools for Editing Information\n\nYou can access the “Account Settings” section to update or edit your personal information.\nIn case you need assistance, you may contact us through the official communication channels of Signal GPT as published on our website.\n\n4.7. Data Protection Measures\n\nSignal GPT applies advanced technical and administrative measures such as:\nData encryption, firewalls, and internal access control;\nLimiting access rights;\nEmployee training on data security.\nAny unauthorized access, disclosure, destruction, or alteration of data will be handled in accordance with the law.\n\n4.8. Entities Authorized to Access Your Information\n\nThe Signal GPT system administration team;\nYou, the customer (when logging into your own account);\nVietnamese legal authorities upon receipt of a valid written request.\n\n4.9. Complaints and Dispute Resolution\n\nAny complaints or feedback related to the protection of personal data or the use of services on the Signal GPT system may be submitted through the official support channels published on our website.\nWe will receive, review, and respond as soon as possible to ensure the lawful rights and interests of customers in accordance with legal regulations.\n\n5. Effectiveness and Updates\n\nThis policy takes effect from November 14, 2025.\nWe may change, update, or supplement this content to comply with legal requirements and operational realities.\nAll changes will be publicly announced on the mInvest.ai website prior to implementation.';

  @override
  String get operatingPrinciplesContent =>
      'Please read all terms and agreements below carefully before proceeding with the next steps in our system. \nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\nOPERATING RULES\n\n1. Legal Information\n\nSystem Owner:\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness/Tax Code: 0110057263\nPhone: 0862 600 626\n\n2. Scope of Application\n\nThese Operating Principles apply to all users, learners, partners, and collaborators who participate in or use the products and services within the Signal GPT system, including websites, applications, training platforms, and other online channels managed by EZTRADE.\nBy registering an account or using the services of Signal GPT, users are deemed to have read, understood, and agreed to all the terms set forth in these regulations.\n\n3. Definitions\n\n“Signal GPT” refers to the technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED.\n“Customer” / “User” / “Learner” refers to any individual or organization that registers, accesses, or uses the services and products on the Signal GPT system.\n“We” / “Administration” refers to the management team representing EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED, responsible for operating and managing the system.\n“Products” / “Services” include learning packages, analytical newsletters, AI trading signals, analytical tools, or any digital content provided by Signal GPT.\n\n4. Usage Rules and Information Security\n\nUsers must provide accurate and complete information when registering an account.\nSignal GPT is committed to protecting personal information and will not disclose it to third parties unless required by competent authorities.\nUsers are responsible for maintaining the confidentiality of their account and password. Any damages arising from personal security negligence shall not be the responsibility of EZTRADE.\nSignal GPT reserves the right to suspend or terminate accounts found to be in violation of the terms, including but not limited to: account sharing, content distribution, or infringement of intellectual property rights.\n\n5. Refund Policy and Service Usage\n\nAll payments, once confirmed, are non-refundable under any circumstances, except in cases of system errors originating from Signal GPT.\nUsers may discontinue service use at any time; however, any paid fees will not be retained or converted.\nSignal GPT reserves the right to adjust service prices, promotional policies, or special offers without prior notice. Users are responsible for regularly reviewing and staying updated.\n\n6. Conduct and Content Usage Regulations\n\nThe following actions are strictly prohibited:\nCopying, downloading, distributing, or sharing content, videos, or materials belonging to the Signal GPT system;\nUsing software or tools to interfere with or illegally collect data;\nImpersonating Signal GPT, EZTRADE, or any of its representatives for the purpose of fraud, deception, or brand defamation;\nSharing accounts with multiple users;\nPosting, speaking, or engaging in actions containing offensive, defamatory, or harmful content toward the system.\nAny violation of the above may result in permanent account suspension and could be subject to legal action under Vietnamese law.\n\n7. Commitment and Limitation of Liability\n\nSignal GPT provides products based on knowledge, data, and AI algorithms developed by the EZTRADE team.\nThe effectiveness of use depends on each individual’s capability, experience, and actions. Signal GPT makes no guarantee of profit or specific investment results.\nEZTRADE shall be exempt from all liability for indirect risks or damages arising during service use, except in cases where direct system errors are proven.\n\n8. Rights of the Signal GPT Administration\n\nSignal GPT reserves the right to modify, update, or supplement the operating terms at any time without prior notice.\nWe have the right to suspend or terminate the provision of services in cases of legal violations, policy breaches, or for technical or system maintenance reasons.\nWe may cooperate with competent authorities in handling complaints, investigating violations, and providing necessary information as required by law.\n\n9. Acknowledgment of Consent\n\nBy registering and using the Signal GPT system, you hereby confirm that:\nYou have read carefully, fully understood, and agreed to all the contents of these Operating Principles;\nYou consent to allow EZTRADE to use your contact information (phone, email, SMS, Zalo, etc.) to send notifications, product updates, promotions, or new program announcements.';

  @override
  String get termsAndConditionsContent =>
      'By registering an account to participate in the Signal GPT system, you confirm that you have read, understood, and agreed to all the contents of these Account Opening Terms and Conditions.\nThe latest updates (if any) will be published here, and Signal GPT will not send separate notifications to each customer. Therefore, please visit this page regularly to stay informed about the most recent policies.\n\n1. General Agreement\n\nSignal GPT is a technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED. By opening an account on this system, you agree to participate in and use the services and products provided by EZTRADE.\nAccount registration and activation are considered an electronic contract between you and Signal GPT, which has the same legal validity as a civil contract under the laws of Vietnam.\n\n2. Personal Account Information and Privacy\n\n2.1. Purpose and Scope of Information Collection\n\nTo access and use certain Signal GPT services, you must provide basic personal information, including:\nFull name;\nEmail address;\nContact phone number;\nOther information (if any) necessary for verification, support, or access authorization.\nAll information provided must be accurate, truthful, and lawful. Signal GPT shall not be responsible for any losses or disputes arising from false, missing, or fraudulent information provided by the user.\nAdditionally, the system may automatically collect certain technical data, such as:\nIP address, browser type, and language used;\nAccess time and pages viewed within the system.\nThis information helps Signal GPT improve performance, enhance security, and optimize user experience.\n\n2.2. Scope of Information Use\n\nYour personal information is collected and used for legitimate purposes, including:\nManaging accounts, verifying users, and maintaining services;\nSending notifications related to services, accounts, promotions, or policy changes;\nProviding technical support, customer service, and dispute resolution (if any);\nData analysis to improve product quality and user experience.\nWe are committed to protecting your personal information and will not share it with third parties unless required by law or competent authorities.\n\n2.3. Data Retention Period\n\nYour information will be stored until one of the following occurs:\nYou request account deletion; or\nThe Signal GPT system ceases operation in accordance with applicable laws.\nIn all cases, your data will be securely stored and strictly protected on EZTRADE’s servers.\n\n2.4. Entity Responsible for Collecting and Managing Personal Information\n\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness Registration Number: 0110057263\n\n2.5. Methods and Tools for Editing Information\n\nYou can access the “Account Settings” section within the system to edit or update your personal information. If you encounter difficulties while doing so, please contact us through the official support channels of Signal GPT as published on the website.\n\n2.6. Information Provision and Verification\n\nTo ensure account security and protect your rights, you must:\nProvide accurate full name, email, and phone number during registration;\nVerify your information via the confirmation email sent by the system;\nReceive activation, password reset, or other important notifications from Signal GPT.\nIf the provided information is inaccurate or incomplete, you shall be solely responsible for any related risks (e.g., account activation failure, loss of access, or missed notifications).\n\n2.7. User Confidentiality Obligations and Responsibilities\n\nYou are responsible for safeguarding your login credentials and password.\nIf your password is lost, disclosed, or accessed without authorization, Signal GPT shall not be liable for any resulting damages.\nYou agree to allow EZTRADE to store, manage, and process your personal information in accordance with the laws of Vietnam.\n\n2.8. Access Rights to Your Information\n\nYour personal information may only be accessed by:\nThe Signal GPT system administration team (for management and technical purposes);\nThe account owner (via the personal information management section);\nVietnamese authorities, upon receipt of a valid and lawful request as prescribed by law.\n\n2.9. Complaint and Resolution Mechanism\n\nFor any complaints or feedback related to account registration, usage, or information security, you may submit a request through the official Contact page of Signal GPT.\nWe will receive, process, and respond as soon as possible to ensure the customer’s lawful rights and interests in accordance with applicable legal regulations.\n\n3. Effectiveness and Updates\n\nThese Account Opening Terms and Conditions take effect from November 14, 2025. Signal GPT reserves the right to update, modify, or supplement the contents at any time without prior notice. All changes will be publicly announced on the mInvest.ai website prior to implementation.';

  @override
  String get performance => 'Performance';

  @override
  String get minvestSupport => 'Minvest Support';

  @override
  String get leaveMessagePart1 =>
      'Please leave a message, our team will respond as soon as possible. You can also contact ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 for fast support.';

  @override
  String get currentPlan => 'Current Plan';

  @override
  String get standard => 'STANDARD';

  @override
  String get availableTokens => 'Available Tokens';

  @override
  String get subscriptions => 'Subscriptions';

  @override
  String get usesTokenPerView => 'Uses 1 Token per view';

  @override
  String get unlimitedAccess => 'Unlimited Access';

  @override
  String get activeElite => 'Active (Elite)';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get transactionHistory => 'Transaction History';

  @override
  String get noTransactionsFound => 'No transactions found.';

  @override
  String get colDate => 'Date';

  @override
  String get colProduct => 'Product';

  @override
  String get colAmount => 'Amount';

  @override
  String get colMethod => 'Method';

  @override
  String get colStatus => 'Status';

  @override
  String get statusSuccess => 'Success';

  @override
  String get featureForVipOnly =>
      'This feature is only for VIP customers, please upgrade to receive notifications.';

  @override
  String get changePassword => 'Change Password';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get passwordUpdateSuccess => 'Password updated successfully';

  @override
  String passwordUpdateFailed(String error) {
    return 'Failed to update password: $error';
  }

  @override
  String get reauthFailed => 'Incorrect current password';

  @override
  String get signInRequired => 'Sign in Required';

  @override
  String get signInToExploreSignal => 'Sign in to explore this trading signal!';
}
