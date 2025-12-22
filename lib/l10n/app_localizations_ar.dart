// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'تم ترقية الحساب بنجاح';

  @override
  String get lotPerWeek => 'لوت/أسبوع';

  @override
  String get tableValueFull => 'كامل';

  @override
  String get tableValueFulltime => 'دوام كامل';

  @override
  String get packageTitle => 'الباقة';

  @override
  String get duration1Month => 'شهر واحد';

  @override
  String get duration12Months => '12 شهرًا';

  @override
  String get featureReceiveAllSignals => 'استلام جميع إشارات اليوم';

  @override
  String get featureAnalyzeReason => 'تحليل سبب الدخول في الصفقة';

  @override
  String get featureHighPrecisionAI => 'إشارات ذكاء اصطناعي عالية الدقة';

  @override
  String get iapStoreNotAvailable => 'المتجر غير متوفر على هذا الجهاز.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'خطأ في تحميل المنتجات: $message';
  }

  @override
  String get iapNoProductsFound =>
      'لم يتم العثور على منتجات. يرجى التحقق من إعدادات المتجر.';

  @override
  String iapTransactionError(Object message) {
    return 'خطأ في المعاملة: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'خطأ في التحقق: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'حدث خطأ غير معروف: $error';
  }

  @override
  String get iapProcessingTransaction => 'جاري معالجة المعاملة...';

  @override
  String get orderInfo1Month => 'الدفع لباقة Elite لمدة شهر واحد';

  @override
  String get orderInfo12Months => 'الدفع لباقة Elite لمدة 12 شهرًا';

  @override
  String get iapNotSupportedOnWeb =>
      'عمليات الشراء داخل التطبيق غير مدعومة على إصدار الويب.';

  @override
  String get vnpayPaymentTitle => 'دفع VNPAY';

  @override
  String get creatingOrderWait => 'جاري إنشاء الطلب، يرجى الانتظار...';

  @override
  String errorWithMessage(Object message) {
    return 'خطأ: $message';
  }

  @override
  String get cannotConnectToServer =>
      'لا يمكن الاتصال بالخادم. يرجى المحاولة مرة أخرى.';

  @override
  String get transactionCancelledOrFailed => 'تم إلغاء المعاملة أو فشلها.';

  @override
  String get cannotCreatePaymentLink =>
      'تعذر إنشاء رابط الدفع.\nحاول مرة أخرى.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String serverErrorRetry(Object message) {
    return 'خطأ في الخادم: $message. يرجى المحاولة مرة أخرى.';
  }

  @override
  String get redirectingToPayment => 'جاري التوجيه إلى صفحة الدفع...';

  @override
  String get invalidPaymentUrl => 'تم استلام رابط دفع غير صالح من الخادم.';

  @override
  String get processingYourAccount => 'جاري معالجة حسابك...';

  @override
  String get verificationFailed => 'فشل التحقق!';

  @override
  String get reuploadImage => 'إعادة تحميل الصورة';

  @override
  String get accountNotLinked => 'الحساب غير مرتبط بـ Minvest';

  @override
  String get accountNotLinkedDesc =>
      'للحصول على إشارات حصرية، يجب تسجيل حساب Exness الخاص بك من خلال رابط شريك Minvest. يرجى إنشاء حساب جديد باستخدام الرابط أدناه.';

  @override
  String get registerExnessViaMinvest => 'تسجيل Exness عبر Minvest';

  @override
  String get iHaveRegisteredReupload => 'لقد قمت بالتسجيل، إعادة التحميل';

  @override
  String couldNotLaunch(Object url) {
    return 'تعذر تشغيل $url';
  }

  @override
  String get status => 'الحالة';

  @override
  String get sentOn => 'أرسلت في';

  @override
  String get entryPrice => 'سعر الدخول';

  @override
  String get stopLossFull => 'إيقاف الخسارة';

  @override
  String get takeProfitFull1 => 'جني الأرباح 1';

  @override
  String get takeProfitFull2 => 'جني الأرباح 2';

  @override
  String get takeProfitFull3 => 'جني الأرباح 3';

  @override
  String get noReasonProvided => 'لم يتم تقديم سبب لهذه الإشارة.';

  @override
  String get upgradeToViewReason => 'قم بترقية حسابك إلى Elite لعرض التحليل.';

  @override
  String get upgradeToViewFullAnalysis => 'قم بالترقية لعرض التحليل الكامل';

  @override
  String get welcomeTo => 'مرحبًا بك في';

  @override
  String get appSlogan => 'عزز تداولك بإشارات ذكية.';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get continueByGoogle => 'المتابعة عبر Google';

  @override
  String get continueByFacebook => 'المتابعة عبر Facebook';

  @override
  String get continueByApple => 'المتابعة عبر Apple';

  @override
  String get loginSuccess => 'تم تسجيل الدخول بنجاح!';

  @override
  String get live => 'مباشر';

  @override
  String get end => 'نهاية';

  @override
  String get symbol => 'الرمز';

  @override
  String get aiSignal => 'إشارات AI';

  @override
  String get ruleSignal => 'إشارات القواعد';

  @override
  String get all => 'الكل';

  @override
  String get upgradeToSeeMore => 'قم بالترقية لرؤية المزيد';

  @override
  String get seeDetails => 'شاهد التفاصيل';

  @override
  String get notMatched => 'غير مطابق';

  @override
  String get matched => 'مطابق';

  @override
  String get entry => 'دخول';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'ترقية';

  @override
  String get upgradeAccount => 'ترقية الحساب';

  @override
  String get compareTiers => 'مقارنة المستويات';

  @override
  String get feature => 'الميزة';

  @override
  String get tierDemo => 'تجريبي';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'الرصيد';

  @override
  String get signalTime => 'وقت الإشارة';

  @override
  String get signalQty => 'كمية الإشارات';

  @override
  String get analysis => 'تحليل';

  @override
  String get openExnessAccount => 'افتح حساب Exness!';

  @override
  String get accountVerificationWithExness => 'التحقق من الحساب مع Exness';

  @override
  String get payInAppToUpgrade => 'ادفع في التطبيق للترقية';

  @override
  String get bankTransferToUpgrade => 'تحويل بنكي للترقية';

  @override
  String get accountVerification => 'التحقق من الحساب';

  @override
  String get accountVerificationPrompt =>
      'يرجى تحميل لقطة شاشة لحساب Exness الخاص بك ليتم اعتماده (يجب فتح حسابك تحت رابط Exness الخاص بـ Minvest)';

  @override
  String get selectPhotoFromLibrary => 'اختر صورة من المكتبة';

  @override
  String get send => 'إرسال';

  @override
  String get accountInfo => 'معلومات الحساب';

  @override
  String get accountVerifiedSuccessfully => 'تم التحقق من الحساب بنجاح';

  @override
  String get yourAccountIs => 'حسابك هو';

  @override
  String get returnToHomePage => 'العودة إلى الصفحة الرئيسية';

  @override
  String get upgradeFailed => 'فشلت الترقية! يرجى إعادة تحميل الصورة';

  @override
  String get package => 'الباقة';

  @override
  String get startNow => 'احصل على الإشارات الآن';

  @override
  String get bankTransfer => 'تحويل بنكي';

  @override
  String get transferInformation => 'معلومات التحويل';

  @override
  String get scanForFastTransfer => 'امسح للتحويل السريع';

  @override
  String get contactUs247 => 'اتصل بنا 24/7';

  @override
  String get newAnnouncement => 'إعلان جديد';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get upgradeNow => 'قم بالترقية الآن';

  @override
  String get followMinvest => 'تابع MInvest';

  @override
  String get tabSignal => 'إشارة';

  @override
  String get tabChart => 'رسم بياني';

  @override
  String get tabProfile => 'الملف الشخصي';

  @override
  String get reason => 'السبب';

  @override
  String get error => 'خطأ';

  @override
  String get noSignalsAvailable => 'لا توجد إشارات متاحة.';

  @override
  String get outOfGoldenHours => 'خارج الساعات الذهبية';

  @override
  String get outOfGoldenHoursVipDesc =>
      'إشارات VIP متاحة من الساعة 8:00 صباحًا حتى 5:00 مساءً (GMT+7).\nقم بالترقية إلى Elite للحصول على إشارات 24/24!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'إشارات التجريبي متاحة من الساعة 8:00 صباحًا حتى 5:00 مساءً (GMT+7).\nقم بترقية حسابك للحصول على المزيد من المزايا!';

  @override
  String get yourName => 'اسمك';

  @override
  String get yourEmail => 'your.email@example.com';

  @override
  String get adminPanel => 'لوحة الإدارة';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get confirmLogout => 'تأكيد تسجيل الخروج';

  @override
  String get confirmLogoutMessage => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get upgradeCardTitle => 'قم بترقية حسابك';

  @override
  String get upgradeCardSubtitle => 'للوصول إلى المزيد من الموارد';

  @override
  String get upgradeCardSubtitleWeb =>
      'لفتح الإشارات المميزة والدعم بدوام كامل';

  @override
  String get subscriptionDetails => 'تفاصيل الاشتراك';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get continueAsGuest => 'المتابعة كضيف';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get deleteAccountWarning =>
      'هل أنت متأكد أنك تريد حذف حسابك؟ سيتم محو جميع بياناتك بشكل دائم ولا يمكن استعادتها.';

  @override
  String get delete => 'حذف';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get termsOfService => 'شروط الخدمة';

  @override
  String get signalStatusMatched => 'مطابق';

  @override
  String get signalStatusNotMatched => 'غير مطابق';

  @override
  String get signalStatusCancelled => 'ملغى';

  @override
  String get signalStatusSlHit => 'تحقق SL';

  @override
  String get signalStatusTp1Hit => 'تحقق TP1';

  @override
  String get signalStatusTp2Hit => 'تحقق TP2';

  @override
  String get signalStatusTp3Hit => 'تحقق TP3';

  @override
  String get signalStatusRunning => 'قيد التشغيل';

  @override
  String get signalStatusClosed => 'مغلق';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get tabChat => 'دردشة';

  @override
  String get exnessUpgradeNoteForIos =>
      'للعملاء الذين قاموا بتسجيل حساب Exness من خلال Minvest، يرجى النقر فوق اتصل بنا لترقية حسابك.';

  @override
  String get chatWelcomeTitle => '👋 مرحبًا بك في Minvest AI!';

  @override
  String get chatWelcomeBody1 =>
      'يرجى ترك رسالة، وسيقوم فريقنا بالرد في أقرب وقت ممكن.';

  @override
  String get chatWelcomeBody2 => 'أو اتصل بنا مباشرة عبر Zalo/WhatsApp: ';

  @override
  String get chatWelcomeBody3 => ' للحصول على دعم أسرع!';

  @override
  String get chatLoginPrompt => 'يرجى تسجيل الدخول لاستخدام هذه الميزة';

  @override
  String get chatStartConversation => 'ابدأ محادثتك';

  @override
  String get chatNoMessages => 'لا توجد رسائل بعد.';

  @override
  String get chatTypeMessage => 'اكتب رسالة...';

  @override
  String get chatSupportIsTyping => 'الدعم يكتب...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName يكتب...';
  }

  @override
  String get chatSeen => 'شوهد';

  @override
  String get chatDefaultUserName => 'مستخدم';

  @override
  String get chatDefaultSupportName => 'دعم';

  @override
  String get signalEntry => 'دخول';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      'للتجار الأجانب، يرجى الاتصال بنا عبر WhatsApp (+84969.15.6969) للحصول على الدعم';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails => 'قم بالترقية لرؤية تفاصيل الإشارة...';

  @override
  String get buy => 'شراء';

  @override
  String get sell => 'بيع';

  @override
  String get logoutDialogTitle => 'انتهت الجلسة';

  @override
  String get logoutDialogDefaultReason =>
      'تم تسجيل الدخول إلى حسابك على جهاز آخر.';

  @override
  String get ok => 'حسنا';

  @override
  String get contactToUpgrade => 'اتصل للترقية';

  @override
  String get noNotificationsYet => 'لا توجد إشعارات بعد.';

  @override
  String daysAgo(int count) {
    return 'منذ $count أيام';
  }

  @override
  String hoursAgo(int count) {
    return 'منذ $count ساعات';
  }

  @override
  String minutesAgo(int count) {
    return 'منذ $count دقائق';
  }

  @override
  String get justNow => 'الآن';

  @override
  String get getSignalsNow => 'احصل على الإشارات الآن';

  @override
  String get freeTrial => 'تجربة مجانية';

  @override
  String get heroTitle => 'توجيه المتداولين وتنمية المحافظ';

  @override
  String get heroSubtitle =>
      'محرك الذكاء الاصطناعي النهائي - صممه خبراء التداول';

  @override
  String get globalAiInnovationTitle =>
      'ابتكار الذكاء الاصطناعي العالمي للجيل القادم من ذكاء التداول';

  @override
  String get globalAiInnovationDesc =>
      'تحويل التداول التقليدي بإشارات الذكاء الاصطناعي المدعومة بالسحابة - المتكيفة مع أخبار السوق والاتجاهات في الوقت الفعلي\nلأداء أسرع وأكثر دقة وخالٍ من المشاعر.';

  @override
  String get liveTradingSignalsTitle =>
      'مباشر – إشارات تداول بالذكاء الاصطناعي 24/7';

  @override
  String get liveTradingSignalsDesc =>
      'تحليلات سحابية في الوقت الفعلي تقدم استراتيجيات تتبع الاتجاه ذات احتمالية عالية بدقة متكيفة وتنفيذ خالٍ من المشاعر.';

  @override
  String get trendFollowing => 'تتبع الاتجاه';

  @override
  String get realtime => 'الوقت الحقيقي';

  @override
  String get orderExplanationEngineTitle => 'محرك شرح الأوامر';

  @override
  String get orderExplanationEngineDesc =>
      'يشرح إعدادات التداول بعبارات بسيطة - يوضح كيف تتشكل التقاطعات، ولماذا يتم الدخول، ويساعد المتداولين على التعلم من كل قرار.';

  @override
  String get transparent => 'شفاف';

  @override
  String get educational => 'تعليمي';

  @override
  String get logical => 'منطقي';

  @override
  String get transparentRealPerformanceTitle => 'شفاف - أداء حقيقي';

  @override
  String get transparentRealPerformanceDesc =>
      'شاهد بيانات حقيقية حول دقة الإشارة، ومعدل النجاح، والربحية - تم التحقق منها وقابلة للتتبع في كل صفقة';

  @override
  String get results => 'النتائج';

  @override
  String get performanceTracking => 'تتبع الأداء';

  @override
  String get accurate => 'دقيق';

  @override
  String get predictiveAccuracy => 'الدقة التنبؤية';

  @override
  String get improvementInProfitability => 'تحسن في الربحية';

  @override
  String get improvedRiskManagement => 'إدارة مخاطر محسنة';

  @override
  String get signalsPerformanceTitle => 'أداء الإشارات';

  @override
  String get riskToRewardRatio => 'نسبة المخاطرة إلى العائد';

  @override
  String get howRiskComparesToReward => 'كيف تقارن المخاطرة بالعائد';

  @override
  String get profitLossOverview => 'نظرة عامة على الربح/الخسارة';

  @override
  String get netGainVsLoss => 'صافي الربح مقابل الخسارة';

  @override
  String get winRate => 'معدل الفوز';

  @override
  String get percentageOfWinningTrades => 'نسبة الصفقات الرابحة';

  @override
  String get accuracyRate => 'معدل الدقة';

  @override
  String get howPreciseOurSignalsAre => 'ما مدى دقة إشاراتنا';

  @override
  String get realtimeMarketAnalysis => 'تحليل السوق في الوقت الحقيقي';

  @override
  String get realtimeMarketAnalysisDesc =>
      'يراقب الذكاء الاصطناعي لدينا السوق باستمرار، ويحدد مناطق التقارب الفني ونقاط الاختراق الموثوقة حتى تتمكن من الدخول في الصفقات في اللحظة المناسبة.';

  @override
  String get saveTimeOnAnalysis => 'وفر الوقت في التحليل';

  @override
  String get saveTimeOnAnalysisDesc =>
      'لا مزيد من الساعات التي تقضيها في قراءة الرسوم البيانية. احصل على استراتيجيات استثمار مخصصة في دقائق معدودة يوميًا.';

  @override
  String get minimizeEmotionalTrading => 'قلل من التداول العاطفي';

  @override
  String get minimizeEmotionalTradingDesc =>
      'مع التنبيهات الذكية، وكشف المخاطر، والإشارات المدعومة بالبيانات (وليس العواطف)، تظل منضبطًا ومسيطرًا على كل قرار.';

  @override
  String get seizeEveryOpportunity => 'اغتنم كل فرصة';

  @override
  String get seizeEveryOpportunityDesc =>
      'تضمن تحديثات الاستراتيجية في الوقت المناسب والتي يتم تسليمها مباشرة إلى بريدك الوارد أن تركب اتجاهات السوق في الوقت المثالي.';

  @override
  String get minvestAiCoreValueTitle => 'Minvest AI - القيمة الجوهرية';

  @override
  String get minvestAiCoreValueDesc =>
      'يقوم الذكاء الاصطناعي بتحليل بيانات السوق في الوقت الفعلي باستمرار، وتصفية الرؤى لتحديد فرص الاستثمار السريعة والدقيقة';

  @override
  String get frequentlyAskedQuestions => 'الأسئلة الشائعة (FAQ)';

  @override
  String get faqSubtitle =>
      'تتم الإجابة على جميع أسئلتك - من كيفية الانضمام، إلى المزايا، إلى كيفية عمل الذكاء الاصطناعي لدينا - أدناه. إذا كان لا يزال لديك أي شكوك، فلا تتردد في مراسلتنا على Whatsapp';

  @override
  String get maximizeResultsTitle =>
      'عظم نتائجك مع Minvest AI\nتحليل سوق متقدم وإشارات مصفاة بدقة';

  @override
  String get elevateTradingWithAiStrategies =>
      'ارتقِ بتداولك باستراتيجيات معززة بالذكاء الاصطناعي مصممة للاتساق والوضوح';

  @override
  String get winMoreWithAiSignalsTitle =>
      'اربح المزيد مع إشارات مدعومة بالذكاء الاصطناعي\nفي كل سوق';

  @override
  String get winMoreWithAiSignalsDesc =>
      'يقوم الذكاء الاصطناعي متعدد الأسواق لدينا بمسح الفوركس والعملات المشفرة والمعادن في الوقت الفعلي،\nويقدم إشارات تداول تم التحقق منها من قبل الخبراء —\nمع مستويات دخول وإيقاف خسارة وجني أرباح واضحة';

  @override
  String get buyLimit => 'حد الشراء';

  @override
  String get sellLimit => 'حد البيع';

  @override
  String get smarterToolsTitle => 'أدوات أذكى - استثمارات أفضل';

  @override
  String get smarterToolsDesc =>
      'اكتشف الميزات التي تساعدك على تقليل المخاطر، واغتنام الفرص، وتنمية ثروتك';

  @override
  String get performanceOverviewTitle => 'نظرة عامة على الأداء';

  @override
  String get performanceOverviewDesc =>
      'يقوم الذكاء الاصطناعي متعدد الأسواق لدينا بمسح الفوركس والعملات المشفرة والمعادن في الوقت الفعلي، ويقدم إشارات تداول تم التحقق منها من قبل الخبراء - مع مستويات دخول وإيقاف خسارة وجني أرباح واضحة';

  @override
  String get totalProfit => 'إجمالي الربح';

  @override
  String get completionSignal => 'إشارة الإكمال';

  @override
  String get onDemandFinancialExpertTitle => 'خبيرك المالي عند الطلب';

  @override
  String get onDemandFinancialExpertDesc =>
      'تقترح منصة الذكاء الاصطناعي إشارات تداول - تعلم ذاتي، وتحلل السوق 24/7، ولا تتأثر بالعواطف. دعمت Minvest أكثر من 10,000 محلل مالي في رحلتهم للعثور على إشارات دقيقة ومستقرة وسهلة التطبيق';

  @override
  String get aiPoweredSignalPlatform =>
      'منصة إشارات تداول مدعومة بالذكاء الاصطناعي';

  @override
  String get selfLearningSystems =>
      'أنظمة تعلم ذاتي، رؤى أكثر حدة، تداولات أقوى';

  @override
  String get emotionlessExecution =>
      'تنفيذ خالٍ من المشاعر لتداول أذكى وأكثر انضباطًا';

  @override
  String get analysingMarket247 => 'تحليل السوق 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'عظم نتائجك مع Minvest AI\nتحليل سوق متقدم وإشارات مصفاة بدقة';

  @override
  String get minvestAiRegistrationDesc =>
      'التسجيل في Minvest AI مفتوح الآن - قد تغلق الأماكن قريبًا حيث نقوم بمراجعة وقبول الأعضاء الجدد';

  @override
  String get currencyPairs => 'سلعة';

  @override
  String get allCurrencyPairs => 'جميع أزواج العملات';

  @override
  String get allCommodities => 'جميع السلع';

  @override
  String get allCryptoPairs => 'جميع أزواج العملات المشفرة';

  @override
  String get dateRange => 'نطاق التاريخ';

  @override
  String get selectDateRange => 'حدد نطاق التاريخ';

  @override
  String get allAssets => 'جميع الأصول';

  @override
  String get asset => 'أصل';

  @override
  String get tokenExpired => 'انتهت صلاحية الرمز';

  @override
  String get tokenLimitReachedDesc =>
      'لقد استهلكت الرموز المجانية الـ 10 الخاصة بك اليوم. قم بترقية باقتك لعرض المزيد من الإشارات.';

  @override
  String get later => 'لاحقًا';

  @override
  String get created => 'تم الإنشاء';

  @override
  String get detail => 'تفاصيل';

  @override
  String get performanceOverview => 'نظرة عامة على الأداء';

  @override
  String get totalProfitPips => 'إجمالي الربح (نقطة)';

  @override
  String get winRatePercent => 'معدل الفوز (%)';

  @override
  String get comingSoon => 'قريبًا';

  @override
  String get errorLoadingHistory => 'خطأ في تحميل السجل';

  @override
  String get noHistoryAvailable => 'لا يوجد سجل إشارات متاح';

  @override
  String get previous => 'السابق';

  @override
  String get page => 'صفحة';

  @override
  String get next => 'التالي';

  @override
  String get date => 'التاريخ';

  @override
  String get timeGmt7 => 'الوقت (GMT)';

  @override
  String get orders => 'الطلبات';

  @override
  String get pips => 'النقاط';

  @override
  String get smallScreenRotationHint =>
      'شاشة صغيرة: قم بالتدوير أفقيًا أو قم بالتمرير أفقيًا لعرض الجدول بالكامل.';

  @override
  String get history => 'السجل';

  @override
  String get signalsWillAppearHere => 'ستظهر الإشارات هنا عندما تكون متاحة';

  @override
  String get pricing => 'التسعير';

  @override
  String get choosePlanSubtitle => 'اختر خطة تناسبك';

  @override
  String get financialNewsHub => 'مركز الأخبار المالية';

  @override
  String get financialNewsHubDesc =>
      'تحديثات مهمة. ردود فعل السوق. لا ضوضاء - فقط ما يحتاج المستثمرون إلى معرفته.';

  @override
  String get newsTabAllArticles => 'جميع المقالات';

  @override
  String get newsTabInvestor => 'مستثمر';

  @override
  String get newsTabKnowledge => 'معرفة';

  @override
  String get newsTabTechnicalAnalysis => 'تحليل فني';

  @override
  String noArticlesForCategory(Object category) {
    return 'لا توجد مقالات للفئة $category';
  }

  @override
  String get mostPopular => 'الأكثر شيوعًا';

  @override
  String get noPosts => 'لا توجد منشورات';

  @override
  String get relatedArticles => 'مقالات ذات صلة';

  @override
  String get contactInfoSentSuccess => 'تم إرسال معلومات الاتصال بنجاح.';

  @override
  String contactInfoSentFailed(Object error) {
    return 'فشل إرسال المعلومات: $error';
  }

  @override
  String get contactPageSubtitle =>
      'لديك أسئلة أو تحتاج إلى حلول ذكاء اصطناعي؟ أخبرنا بملء النموذج، وسنتواصل معك!';

  @override
  String get phone => 'الهاتف';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get enterFirstName => 'أدخل الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get enterLastName => 'أدخل اسم العائلة';

  @override
  String get whatAreYourConcerns => 'ما هي مخاوفك؟';

  @override
  String get writeConcernsHere => 'اكتب المخاوف هنا...';

  @override
  String pleaseEnter(Object field) {
    return 'يرجى إدخال $field';
  }

  @override
  String get faqQuestion1 => 'هل تضمن الإشارات معدل نجاح 100%؟';

  @override
  String get faqAnswer1 =>
      'بينما لا يمكن ضمان أي إشارة بنسبة 100%، تسعى Minvest AI للحفاظ على معدل نجاح ثابت بنسبة 60-80%، مدعومًا بتحليل مفصل وإدارة المخاطر حتى تتمكن من اتخاذ القرار النهائي بثقة أكبر.';

  @override
  String get faqQuestion2 =>
      'إذا كنت لا أرغب في الإيداع على الفور، فهل يمكنني الاستمرار في تلقي اقتراحات الإشارات؟';

  @override
  String get faqAnswer2 =>
      'عند فتح حساب، سيهديك النظام 10 رموز مجانية، تعادل 10 مشاهدات تفصيلية للإشارة. بعد ذلك، ستتلقى رمزًا إضافيًا واحدًا كل يوم لاستخدامه. إذا قمت بالترقية إلى حساب VIP، فستفتح العديد من الميزات المتقدمة وتتتبع عددًا غير محدود من الطلبات.';

  @override
  String get faqQuestion3 =>
      'إذا قمت بالتسجيل ولكن لم أتلق أي إشارات، فما الخطوات التي يجب أن أتخذها؟';

  @override
  String get faqAnswer3 =>
      'تتم المعالجة عادةً تلقائيًا. إذا كنت لا تزال لا ترى أي اقتراحات إشارة، فيرجى الاتصال بنا عبر Whatsapp للحصول على مساعدة فورية.';

  @override
  String get faqQuestion4 =>
      'كم عدد الإشارات التي سأتلقاها يوميًا عند الترقية إلى حساب VIP؟';

  @override
  String get faqAnswer4 =>
      'عند الترقية إلى حساب VIP، ستتلقى إشارات تداول غير محدودة كل يوم. عدد الإشارات ليس ثابتًا ولكنه يعتمد كليًا على تحليل السوق. كلما ظهرت نقطة دخول عالية الجودة وعالية الاحتمالية، سيرسل فريق التحليل الإشارة إليك على الفور.';

  @override
  String get priceLevels => 'مستويات الأسعار';

  @override
  String get capitalManagement => 'إدارة رأس المال';

  @override
  String freeSignalsLeft(Object count) {
    return '$count إشارات مجانية متبقية';
  }

  @override
  String get unlimitedSignals => 'إشارات غير محدودة';

  @override
  String get goBack => 'العودة';

  @override
  String get goldPlan => 'الخطة الذهبية';

  @override
  String get perMonth => '/ شهر';

  @override
  String get continuouslyUpdating => 'تحديث بيانات السوق باستمرار 24/7';

  @override
  String get providingBestSignals => 'توفير أفضل الإشارات في الوقت الفعلي';

  @override
  String get includesEntrySlTp => 'يشمل الدخول، SL، TP';

  @override
  String get detailedAnalysis => 'تحليل وتقييم مفصل لكل إشارة';

  @override
  String get realTimeNotifications =>
      'إشعارات في الوقت الفعلي عبر البريد الإلكتروني';

  @override
  String get signalPerformanceStats => 'إحصائيات أداء الإشارة';

  @override
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails => 'رقم تسجيل الأعمال: 0110057263';

  @override
  String get addressDetails =>
      'العنوان: رقم 8 شارع دو هانه، حي هاي با ترونج، مدينة هانوي، فيتنام';

  @override
  String get pagesTitle => 'الصفحات';

  @override
  String get legalRegulatoryTitle => 'قانوني وتنظيمي';

  @override
  String get termsOfRegistration => 'شروط التسجيل';

  @override
  String get operatingPrinciples => 'مبادئ التشغيل';

  @override
  String get termsConditions => 'الشروط والأحكام';

  @override
  String get contactTitle => 'اتصل';

  @override
  String get navFeatures => 'الميزات';

  @override
  String get navNews => 'الأخبار';

  @override
  String get tp1Hit => 'تحقق TP1';

  @override
  String get tp2Hit => 'تحقق TP2';

  @override
  String get tp3Hit => 'تحقق TP3';

  @override
  String get slHit => 'تحقق SL';

  @override
  String get cancelled => 'ملغى';

  @override
  String get exitedByAdmin => 'خرج بواسطة المسؤول';

  @override
  String get signalClosed => 'مغلق';

  @override
  String get errorLoadingPackages => 'خطأ في تحميل الباقات';

  @override
  String get monthly => 'شهريًا';

  @override
  String get annually => 'سنويًا';

  @override
  String get whatsIncluded => 'ما الذي يتضمنه:';

  @override
  String get chooseThisPlan => 'اختر هذه الخطة';

  @override
  String get bestPricesForPremiumAccess => 'أفضل الأسعار للوصول المتميز';

  @override
  String get choosePlanFitsNeeds =>
      'اختر خطة تناسب احتياجات عملك وابدأ الأتمتة باستخدام الذكاء الاصطناعي';

  @override
  String get save50Percent => 'وفر 50%';

  @override
  String get tryDemo => 'جرب العرض التوضيحي';

  @override
  String get pleaseEnterEmailPassword =>
      'يرجى إدخال البريد الإلكتروني وكلمة المرور';

  @override
  String loginFailed(String error) {
    return 'فشل تسجيل الدخول: $error';
  }

  @override
  String get welcomeBack => 'مرحبًا بعودتك';

  @override
  String get signInToContinue => 'سجل الدخول إلى حسابك للمتابعة';

  @override
  String get or => 'أو';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get emailHint => 'example123@gmail.com';

  @override
  String get password => 'كلمة المرور';

  @override
  String get enterPassword => 'أدخل كلمة المرور';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get createNewAccount => 'أنشئ حسابًا جديدًا هنا!';

  @override
  String get signUp => 'تسجيل';

  @override
  String get signUpAccount => 'تسجيل حساب';

  @override
  String get enterPersonalData => 'أدخل بياناتك الشخصية لإنشاء حسابك';

  @override
  String get nameLabel => 'الاسم *';

  @override
  String get enterNameHint => 'أدخل الاسم';

  @override
  String get emailLabel => 'البريد الإلكتروني *';

  @override
  String get passwordLabel => 'كلمة المرور *';

  @override
  String get phoneLabel => 'الهاتف';

  @override
  String get continueButton => 'متابعة';

  @override
  String get fillAllFields => 'يرجى ملء جميع الحقول المطلوبة.';

  @override
  String get accountCreatedSuccess => 'تم إنشاء الحساب بنجاح.';

  @override
  String signUpFailed(String error) {
    return 'فشل التسجيل: $error';
  }

  @override
  String get nationality => 'الجنسية:';

  @override
  String get overview => 'نظرة عامة';

  @override
  String get setting => 'الإعداد';

  @override
  String get paymentHistory => 'سجل الدفع';

  @override
  String get signalsPlan => 'خطة الإشارات';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => 'رموزك';

  @override
  String get emailNotificationPreferences =>
      'تفضيلات إشعارات البريد الإلكتروني';

  @override
  String get chooseSignalNotificationTypes =>
      'اختر أنواع إشعارات الإشارة التي تريد تلقيها عبر البريد الإلكتروني';

  @override
  String get allSignalNotifications => 'جميع إشعارات الإشارة';

  @override
  String get cryptoSignals => 'إشارات العملات المشفرة';

  @override
  String get forexSignals => 'إشارات الفوركس';

  @override
  String get goldSignals => 'إشارات الذهب';

  @override
  String get updatePasswordSecure =>
      'قم بتحديث كلمة المرور الخاصة بك للحفاظ على أمان حسابك';

  @override
  String get searchLabel => 'بحث:';

  @override
  String get filterBy => 'تصفية حسب:';

  @override
  String get allTime => 'كل الوقت';

  @override
  String get startDate => 'تاريخ البدء:';

  @override
  String get endDate => 'تاريخ الانتهاء:';

  @override
  String get deactivate => 'تعطيل';

  @override
  String get unlimited => 'غير محدود';

  @override
  String get tenLeft => '10 متبقية';

  @override
  String get termsOfRegistrationContent =>
      'Please read all the terms and agreements below carefully before proceeding with the next steps in our system.\nBy registering an account on the mInvest AI system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\n1. Introduction and Scope of Application\n\nThis policy regulates the collection, use, sharing, and protection of users’ personal information when accessing and using the products and services of the mInvest AI system – a technology and artificial intelligence platform owned and operated by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED (hereinafter referred to as “we” or “us”).\nBy registering an account or using mInvest AI’s products, you agree that such action constitutes a legally binding commitment between you and us, equivalent to an electronic contract.\n\n2. Account Registration\n\nTo access and use certain services on mInvest AI, you must register a valid account.\nWhen registering, you are required to provide complete and accurate personal information, including your full name, email address, phone number, or any other information as requested.\nAfter registration, you must confirm your email to activate the account. All notifications about your account, promotions, or system updates will be sent to this email address.\nIf the information you provide is inaccurate or incomplete, you will be solely responsible for any incidents or damages arising from it.\n\n3. Terms of Use\n\nWhen participating in the mInvest AI system, you are obligated to comply with all of the following:\nThe operating principles of the platform;\nPayment terms;\nPersonal data privacy policy;\nRelevant laws and regulations in effect.\nIn the event of a violation, EZTRADE reserves the right to temporarily suspend or permanently delete your account, and may transfer the case to competent authorities if necessary.\n\n4. Personal Data Privacy Policy\n\n4.1. Purpose and Scope of ... [truncated]';

  @override
  String get operatingPrinciplesContent =>
      'Please read all terms and agreements below carefully before proceeding with the next steps in our system. \nBy registering an account on the mInvest AI system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\nOPERATING RULES\n\n1. Legal Information\n\nSystem Owner:\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness/Tax Code: 0110057263\nPhone: 0862 600 626\n\n2. Scope of Application\n\nThese Operating Principles apply to all users, learners, partners, and collaborators who participate in or use the products and services within the mInvest AI system, including websites, applications, training platforms, and other online channels managed by EZTRADE.\nBy registering an account or using the services of mInvest AI, users are deemed to have read, understood, and agreed to all the terms set forth in these regulations.\n\n3. Definitions\n\n“mInvest AI” refers to the technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED.\n“Customer” / “User” / “Learner” refers to any individual or organization that registers, accesses, or uses the services and products on the mInvest AI system.\n“We” / “Administration” refers to the management team representing EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED, responsible for operating and managing the system.\n“Products” / “Services” include learning packages, analytical newsletters, AI trading signals, analytical tools, or any digital content provided by mInvest AI.\n\n4. Usage Rules and Information Security\n\nUsers must provide accurate and complete information when registering an account.\nmInvest AI is committed to protecting personal information and will not disclose it to third parties unless required by competent authorities.\nUsers are responsible for maintaining the confidentiality of their account and pa... [truncated]';

  @override
  String get termsAndConditionsContent =>
      'By registering an account to participate in the mInvest AI system, you confirm that you have read, understood, and agreed to all the contents of these Account Opening Terms and Conditions.\nThe latest updates (if any) will be published here, and mInvest AI will not send separate notifications to each customer. Therefore, please visit this page regularly to stay informed about the most recent policies.\n\n1. General Agreement\n\nmInvest AI is a technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED. By opening an account on this system, you agree to participate in and use the services and products provided by EZTRADE.\nAccount registration and activation are considered an electronic contract between you and mInvest AI, which has the same legal validity as a civil contract under the laws of Vietnam.\n\n2. Personal Account Information and Privacy\n\n2.1. Purpose and Scope of Information Collection\n\nTo access and use certain mInvest AI services, you must provide basic personal information, including:\nFull name;\nEmail address;\nContact phone number;\nOther information (if any) necessary for verification, support, or access authorization.\nAll information provided must be accurate, truthful, and lawful. mInvest AI shall not be responsible for any losses or disputes arising from false, missing, or fraudulent information provided by the user.\nAdditionally, the system may automatically collect certain technical data, such as:\nIP address, browser type, and language used;\nAccess time and pages viewed within the system.\nThis information helps mInvest AI improve performance, enhance security, and optimize user experience.\n\n2.2. Scope of Information Use\n\nYour personal information is collected and used for legitimate purposes, including:\nManaging accounts, verifying users, and maintaining services;\nSending notifications related to services, accounts, promotions, or policy changes;\nProv... [truncated]';

  @override
  String get performance => 'الأداء';

  @override
  String get minvestSupport => 'دعم Minvest';

  @override
  String get leaveMessagePart1 =>
      'يرجى ترك رسالة، وسيقوم فريقنا بالرد في أقرب وقت ممكن. يمكنك أيضًا الاتصال بـ ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 للحصول على دعم سريع.';
}
