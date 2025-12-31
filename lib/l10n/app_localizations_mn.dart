// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Mongolian (`mn`).
class AppLocalizationsMn extends AppLocalizations {
  AppLocalizationsMn([String locale = 'mn']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'БҮРТГЭЛ АМЖИЛТТАЙ ШИНЭЧЛЭГДЛЭЭ';

  @override
  String get lotPerWeek => 'Лот/долоо хоног';

  @override
  String get tableValueFull => 'бүрэн';

  @override
  String get tableValueFulltime => 'бүтэн цагийн';

  @override
  String get packageTitle => 'БАГЦ';

  @override
  String get duration1Month => '1 сар';

  @override
  String get duration12Months => '12 сар';

  @override
  String get featureReceiveAllSignals => 'Өдрийн бүх дохиог хүлээн авах';

  @override
  String get featureAnalyzeReason => 'Захиалга өгөх шалтгааныг шинжлэх';

  @override
  String get featureHighPrecisionAI => 'Өндөр нарийвчлалтай AI дохио';

  @override
  String get iapStoreNotAvailable =>
      'Дэлгүүр энэ төхөөрөмж дээр боломжгүй байна.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'Бүтээгдэхүүнийг ачаалахад алдаа гарлаа: $message';
  }

  @override
  String get iapNoProductsFound =>
      'Бүтээгдэхүүн олдсонгүй. Дэлгүүрийн тохиргоогоо шалгана уу.';

  @override
  String iapTransactionError(Object message) {
    return 'Гүйлгээний алдаа: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'Баталгаажуулалтын алдаа: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'Тодорхойгүй алдаа гарлаа: $error';
  }

  @override
  String get iapProcessingTransaction => 'Гүйлгээг боловсруулж байна...';

  @override
  String get orderInfo1Month => 'Elite 1 сарын багцын төлбөр';

  @override
  String get orderInfo12Months => 'Elite 12 сарын багцын төлбөр';

  @override
  String get iapNotSupportedOnWeb =>
      'Апп доторх худалдан авалтыг веб хувилбар дээр дэмждэггүй.';

  @override
  String get vnpayPaymentTitle => 'VNPAY ТӨЛБӨР';

  @override
  String get creatingOrderWait => 'Захиалга үүсгэж байна, хүлээнэ үү...';

  @override
  String errorWithMessage(Object message) {
    return 'Алдаа: $message';
  }

  @override
  String get cannotConnectToServer =>
      'Сервертэй холбогдох боломжгүй байна. Дахин оролдоно уу.';

  @override
  String get transactionCancelledOrFailed =>
      'Гүйлгээ цуцлагдсан эсвэл амжилтгүй боллоо.';

  @override
  String get cannotCreatePaymentLink =>
      'Төлбөрийн холбоос үүсгэх боломжгүй.\nДахин оролдоно уу.';

  @override
  String get retry => 'Дахин оролдох';

  @override
  String serverErrorRetry(Object message) {
    return 'Серверийн алдаа: $message. Дахин оролдоно уу.';
  }

  @override
  String get redirectingToPayment => 'Төлбөрийн хуудас руу шилжүүлж байна...';

  @override
  String get invalidPaymentUrl => 'Серверээс буруу төлбөрийн URL хүлээн авлаа.';

  @override
  String get processingYourAccount => 'Таны бүртгэлийг боловсруулж байна...';

  @override
  String get verificationFailed => 'Баталгаажуулалт амжилтгүй боллоо!';

  @override
  String get reuploadImage => 'Зургийг дахин байршуулах';

  @override
  String get accountNotLinked => 'Бүртгэл Minvest-тэй холбогдоогүй байна';

  @override
  String get accountNotLinkedDesc =>
      'Онцгой дохиог авахын тулд таны Exness бүртгэл Minvest түншийн холбоосоор бүртгэгдсэн байх ёстой. Доорх холбоосыг ашиглан шинэ бүртгэл үүсгэнэ үү.';

  @override
  String get registerExnessViaMinvest =>
      'Minvest-ээр дамжуулан Exness бүртгүүлэх';

  @override
  String get iHaveRegisteredReupload => 'Би бүртгүүлсэн, дахин байршуулах';

  @override
  String couldNotLaunch(Object url) {
    return '$url-г эхлүүлэх боломжгүй';
  }

  @override
  String get status => 'Төлөв';

  @override
  String get sentOn => 'Илгээсэн огноо';

  @override
  String get entryPrice => 'Орох үнэ';

  @override
  String get stopLossFull => 'Алдагдлыг зогсоох (Stop loss)';

  @override
  String get takeProfitFull1 => 'Ашиг авах 1 (Take profit)';

  @override
  String get takeProfitFull2 => 'Ашиг авах 2 (Take profit)';

  @override
  String get takeProfitFull3 => 'Ашиг авах 3 (Take profit)';

  @override
  String get noReasonProvided => 'Энэ дохионд шалтгаан өгөгдөөгүй байна.';

  @override
  String get upgradeToViewReason =>
      'Шинжилгээг харахын тулд бүртгэлээ Elite болгон сайжруулна уу.';

  @override
  String get upgradeToViewFullAnalysis =>
      'Бүрэн шинжилгээг харахын тулд сайжруулах';

  @override
  String get welcomeTo => 'Тавтай морилно уу';

  @override
  String get appSlogan => 'Ухаалаг дохиогоор арилжаагаа сайжруулаарай.';

  @override
  String get signIn => 'Нэвтрэх';

  @override
  String get continueByGoogle => 'Google-ээр үргэлжлүүлэх';

  @override
  String get continueByFacebook => 'Facebook-ээр үргэлжлүүлэх';

  @override
  String get continueByApple => 'Apple-аар үргэлжлүүлэх';

  @override
  String get loginSuccess => 'Амжилттай нэвтэрлээ!';

  @override
  String get live => 'ШУУД';

  @override
  String get end => 'ТӨГСГӨЛ';

  @override
  String get symbol => 'ТЭМДЭГ';

  @override
  String get aiSignal => 'AI Дохио';

  @override
  String get ruleSignal => 'ДҮРМИЙН ДОХИО';

  @override
  String get all => 'БҮГД';

  @override
  String get upgradeToSeeMore => 'Илүү ихийг харахын тулд сайжруулах';

  @override
  String get seeDetails => 'дэлгэрэнгүй харах';

  @override
  String get notMatched => 'ТААРАХГҮЙ БАЙНА';

  @override
  String get matched => 'ТААРСАН';

  @override
  String get entry => 'Орох';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'Сайжруулах';

  @override
  String get upgradeAccount => 'БҮРТГЭЛ САЙЖРУУЛАХ';

  @override
  String get compareTiers => 'ТҮВШИН ХАРЬЦУУЛАХ';

  @override
  String get feature => 'Онцлог';

  @override
  String get tierDemo => 'Демо';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'Үлдэгдэл';

  @override
  String get signalTime => 'Дохионы цаг';

  @override
  String get signalQty => 'Дохионы тоо';

  @override
  String get analysis => 'Шинжилгээ';

  @override
  String get openExnessAccount => 'Exness данс нээх!';

  @override
  String get accountVerificationWithExness =>
      'Exness-тэй дансны баталгаажуулалт';

  @override
  String get payInAppToUpgrade => 'Сайжруулахын тулд апп дотор төлбөр төлөх';

  @override
  String get bankTransferToUpgrade => 'Сайжруулахын тулд банкны шилжүүлэг хийх';

  @override
  String get accountVerification => 'ДАНСНЫ БАТАЛГААЖУУЛАЛТ';

  @override
  String get accountVerificationPrompt =>
      'Зөвшөөрөл авахын тулд Exness дансны дэлгэцийн агшинг байршуулна уу (таны данс Minvest-ийн Exness холбоосоор нээгдсэн байх ёстой)';

  @override
  String get selectPhotoFromLibrary => 'Номын сангаас зураг сонгох';

  @override
  String get send => 'Илгээх';

  @override
  String get accountInfo => 'Дансны мэдээлэл';

  @override
  String get accountVerifiedSuccessfully => 'ДАНС АМЖИЛТТАЙ БАТАЛГААЖЛАА';

  @override
  String get yourAccountIs => 'Таны данс';

  @override
  String get returnToHomePage => 'Нүүр хуудас руу буцах';

  @override
  String get upgradeFailed =>
      'Сайжруулалт амжилтгүй боллоо! Зургийг дахин байршуулна уу';

  @override
  String get package => 'БАГЦ';

  @override
  String get startNow => 'Дохиог одоо авах';

  @override
  String get bankTransfer => 'БАНКНЫ ШИЛЖҮҮЛЭГ';

  @override
  String get transferInformation => 'ШИЛЖҮҮЛГИЙН МЭДЭЭЛЭЛ';

  @override
  String get scanForFastTransfer => 'Хурдан шилжүүлэг хийхийн тулд сканнердах';

  @override
  String get contactUs247 => 'Бидэнтэй 24/7 холбогдох';

  @override
  String get newAnnouncement => 'ШИНЭ МЭДЭГДЭЛ';

  @override
  String get profile => 'Профайл';

  @override
  String get upgradeNow => 'Одоо сайжруулах';

  @override
  String get followMinvest => 'MInvest-ийг дагах';

  @override
  String get tabSignal => 'Дохио';

  @override
  String get tabChart => 'График';

  @override
  String get tabProfile => 'Профайл';

  @override
  String get reason => 'ШАЛТГААН';

  @override
  String get error => 'Алдаа';

  @override
  String get noSignalsAvailable => 'Дохио байхгүй байна.';

  @override
  String get outOfGoldenHours => 'Алтан цагаас гадуур';

  @override
  String get outOfGoldenHoursVipDesc =>
      'VIP дохиог 8:00 - 17:00 (GMT+7) хооронд авах боломжтой.\n24/24 дохио авахын тулд Elite болгон сайжруулаарай!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'Демо дохиог 8:00 - 17:00 (GMT+7) хооронд авах боломжтой.\nИлүү их ашиг тус хүртэхийн тулд бүртгэлээ сайжруулаарай!';

  @override
  String get yourName => 'Таны Нэр';

  @override
  String get yourEmail => 'tany.email@example.com';

  @override
  String get adminPanel => 'Админ самбар';

  @override
  String get logout => 'Гарах';

  @override
  String get confirmLogout => 'Гарахыг баталгаажуулах';

  @override
  String get confirmLogoutMessage => 'Та гарахдаа итгэлтэй байна уу?';

  @override
  String get cancel => 'Цуцлах';

  @override
  String get upgradeCardTitle => 'БҮРТГЭЛЭЭ САЙЖРУУЛАХ';

  @override
  String get upgradeCardSubtitle => 'Илүү их нөөцөд хандахын тулд';

  @override
  String get upgradeCardSubtitleWeb =>
      'Дээд зэрэглэлийн дохио болон бүтэн цагийн дэмжлэгийг нээхийн тулд';

  @override
  String get subscriptionDetails => 'Захиалгын дэлгэрэнгүй';

  @override
  String get notifications => 'Мэдэгдэл';

  @override
  String get continueAsGuest => 'Зочноор үргэлжлүүлэх';

  @override
  String get deleteAccount => 'Бүртгэл устгах';

  @override
  String get deleteAccountWarning =>
      'Та бүртгэлээ устгахдаа итгэлтэй байна уу? Таны бүх өгөгдөл бүрмөсөн устах бөгөөд сэргээх боломжгүй.';

  @override
  String get delete => 'Устгах';

  @override
  String get privacyPolicy => 'Нууцлалын бодлого';

  @override
  String get termsOfService => 'Үйлчилгээний нөхцөл';

  @override
  String get signalStatusMatched => 'ТААРСАН';

  @override
  String get signalStatusNotMatched => 'ТААРАХГҮЙ БАЙНА';

  @override
  String get signalStatusCancelled => 'ЦУЦЛАГДСАН';

  @override
  String get signalStatusSlHit => 'SL ОНОСОН';

  @override
  String get signalStatusTp1Hit => 'TP1 ОНОСОН';

  @override
  String get signalStatusTp2Hit => 'TP2 ОНОСОН';

  @override
  String get signalStatusTp3Hit => 'TP3 ОНОСОН';

  @override
  String get signalStatusRunning => 'АЖИЛЛАЖ БАЙНА';

  @override
  String get signalStatusClosed => 'ХААГДСАН';

  @override
  String get contactUs => 'Бидэнтэй холбогдох';

  @override
  String get tabChat => 'Чат';

  @override
  String get exnessUpgradeNoteForIos =>
      'Minvest-ээр дамжуулан Exness данс бүртгүүлсэн үйлчлүүлэгчид бидэнтэй холбогдох товчийг дарж дансаа сайжруулна уу.';

  @override
  String get chatWelcomeTitle => '👋 Signal GPT-д тавтай морил!';

  @override
  String get chatWelcomeBody1 =>
      'Зурвас үлдээнэ үү, манай баг аль болох хурдан хариулах болно.';

  @override
  String get chatWelcomeBody2 =>
      'Эсвэл бидэнтэй шууд Zalo/WhatsApp-аар холбогдоорой: ';

  @override
  String get chatWelcomeBody3 => ' илүү хурдан дэмжлэг авахын тулд!';

  @override
  String get chatLoginPrompt => 'Энэ функцийг ашиглахын тулд нэвтэрнэ үү';

  @override
  String get chatStartConversation => 'Харилцан яриагаа эхлүүлэх';

  @override
  String get chatNoMessages => 'Зурвас алга.';

  @override
  String get chatTypeMessage => 'Зурвас бичих...';

  @override
  String get chatSupportIsTyping => 'Дэмжлэг бичиж байна...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName бичиж байна...';
  }

  @override
  String get chatSeen => 'Харсан';

  @override
  String get chatDefaultUserName => 'Хэрэглэгч';

  @override
  String get chatDefaultSupportName => 'Дэмжлэг';

  @override
  String get signalEntry => 'Entry';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      'Гадаад худалдаачид WhatsApp (+84969.15.6969)-аар холбогдож дэмжлэг авна уу';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails =>
      'Дохионы дэлгэрэнгүйг харахын тулд сайжруулна уу...';

  @override
  String get buy => 'АВАХ';

  @override
  String get sell => 'ЗАРАХ';

  @override
  String get logoutDialogTitle => 'Сесс дууссан';

  @override
  String get logoutDialogDefaultReason =>
      'Таны бүртгэл өөр төхөөрөмж дээр нэвтэрсэн байна.';

  @override
  String get ok => 'ОК';

  @override
  String get contactToUpgrade => 'Сайжруулахын тулд холбогдох';

  @override
  String get noNotificationsYet => 'Одоогоор мэдэгдэл алга.';

  @override
  String daysAgo(int count) {
    return '$count өдрийн өмнө';
  }

  @override
  String hoursAgo(int count) {
    return '$count цагийн өмнө';
  }

  @override
  String minutesAgo(int count) {
    return '$count минутын өмнө';
  }

  @override
  String get justNow => 'Дөнгөж сая';

  @override
  String get getSignalsNow => 'Дохиог одоо авах';

  @override
  String get freeTrial => 'Үнэгүй туршилт';

  @override
  String get heroTitle => 'Худалдаачдыг чиглүүлж, багцыг өсгөх';

  @override
  String get heroSubtitle =>
      'Төгс AI хөдөлгүүр – Мэргэжлийн худалдаачдын бүтээсэн';

  @override
  String get globalAiInnovationTitle =>
      'Худалдааны оюун ухааны дараагийн үеийн дэлхийн AI инноваци';

  @override
  String get globalAiInnovationDesc =>
      'Үүлэн технологид суурилсан AI дохиогоор уламжлалт худалдааг өөрчилж байна — бодит цагийн зах зээлийн мэдээ, чиг хандлагад дасан зохицож\nилүү хурдан, нарийвчлалтай, сэтгэл хөдлөлгүй гүйцэтгэлтэй.';

  @override
  String get liveTradingSignalsTitle => 'ШУУД – 24/7 AI Худалдааны Дохио';

  @override
  String get liveTradingSignalsDesc =>
      'Бодит цагийн үүлэн анализ нь өндөр магадлалтай, чиг хандлагыг дагасан стратегиудыг дасан зохицох нарийвчлалтай, сэтгэл хөдлөлгүй гүйцэтгэлтэйгээр хүргэдэг.';

  @override
  String get trendFollowing => 'Чиг хандлагыг дагасан';

  @override
  String get realtime => 'Бодит цагийн';

  @override
  String get orderExplanationEngineTitle => 'Захиалгын тайлбар хөдөлгүүр';

  @override
  String get orderExplanationEngineDesc =>
      'Худалдааны тохиргоог энгийн үгээр тайлбарладаг — нэгдэл хэрхэн үүсдэг, яагаад оролт хийгдсэнийг харуулж, худалдаачдад шийдвэр бүрээс суралцахад тусалдаг.';

  @override
  String get transparent => 'Ил тод';

  @override
  String get educational => 'Боловсролын';

  @override
  String get logical => 'Логиктой';

  @override
  String get transparentRealPerformanceTitle => 'Ил тод - Бодит гүйцэтгэл';

  @override
  String get transparentRealPerformanceDesc =>
      'Дохионы нарийвчлал, амжилтын хувь, ашигт ажиллагааны бодит өгөгдлийг харах — худалдаа бүрт баталгаажсан, мөрдөх боломжтой';

  @override
  String get results => 'Үр дүн';

  @override
  String get performanceTracking => 'Гүйцэтгэлийг хянах';

  @override
  String get accurate => 'Нарийвчлалтай';

  @override
  String get predictiveAccuracy => 'Урьдчилан таамаглах нарийвчлал';

  @override
  String get improvementInProfitability => 'Ашигт ажиллагааны сайжруулалт';

  @override
  String get improvedRiskManagement => 'Сайжруулсан эрсдэлийн удирдлага';

  @override
  String get signalsPerformanceTitle => 'Дохионы гүйцэтгэл';

  @override
  String get riskToRewardRatio => 'Эрсдэл ба шагналын харьцаа';

  @override
  String get howRiskComparesToReward =>
      'Эрсдэл шагналтай хэрхэн харьцуулагдах вэ';

  @override
  String get profitLossOverview => 'Ашиг/Алдагдлын тойм';

  @override
  String get netGainVsLoss => 'Цэвэр ашиг vs алдагдал';

  @override
  String get winRate => 'Ялалтын хувь';

  @override
  String get percentageOfWinningTrades => 'Ялсан арилжааны хувь';

  @override
  String get accuracyRate => 'Нарийвчлалын хувь';

  @override
  String get howPreciseOurSignalsAre => 'Манай дохио хэр нарийвчлалтай вэ';

  @override
  String get realtimeMarketAnalysis => 'Бодит цагийн зах зээлийн шинжилгээ';

  @override
  String get realtimeMarketAnalysisDesc =>
      'Манай AI зах зээлийг тасралтгүй хянаж, техникийн нэгдлийн бүсүүд болон найдвартай тасрах цэгүүдийг тодорхойлдог тул та зөв цагт арилжаанд оролцох боломжтой.';

  @override
  String get saveTimeOnAnalysis => 'Шинжилгээнд цаг хэмнэх';

  @override
  String get saveTimeOnAnalysisDesc =>
      'График уншихад олон цаг зарцуулах шаардлагагүй. Өдөрт хэдхэн минутын дотор тохирсон хөрөнгө оруулалтын стратегиудыг хүлээн аваарай.';

  @override
  String get minimizeEmotionalTrading => 'Сэтгэл хөдлөлийн худалдааг багасгах';

  @override
  String get minimizeEmotionalTradingDesc =>
      'Ухаалаг сэрэмжлүүлэг, эрсдэлийг илрүүлэх, сэтгэл хөдлөл бус өгөгдөлд суурилсан дохионуудын тусламжтайгаар та сахилга баттай байж, шийдвэр бүрийг хянах болно.';

  @override
  String get seizeEveryOpportunity => 'Боломж бүрийг ашиглах';

  @override
  String get seizeEveryOpportunityDesc =>
      'Таны ирсэн имэйл хайрцагт шууд хүргэгддэг цаг үеээ олсон стратегийн шинэчлэлтүүд нь зах зээлийн чиг хандлагыг төгс цагт нь ашиглах боломжийг олгоно.';

  @override
  String get minvestAiCoreValueTitle => 'Signal GPT - Үнэ цэнэ';

  @override
  String get minvestAiCoreValueDesc =>
      'AI нь бодит цагийн зах зээлийн мэдээллийг тасралтгүй шинжилж, хөрөнгө оруулалтын хурдан, үнэн зөв боломжуудыг тодорхойлохын тулд ойлголтуудыг шүүдэг';

  @override
  String get frequentlyAskedQuestions => 'Түгээмэл асуултууд (FAQ)';

  @override
  String get faqSubtitle =>
      'Таны бүх асуулт — хэрхэн нэгдэх, ашиг тус, манай AI хэрхэн ажилладаг талаар — доор хариулагдсан болно. Хэрэв танд эргэлзээ байгаа бол Whatsapp-аар бидэнтэй холбогдоорой';

  @override
  String get maximizeResultsTitle =>
      'Signal GPT-ийн тусламжтайгаар үр дүнгээ дээд зэргээр нэмэгдүүлээрэй\nдэвшилтэт зах зээлийн шинжилгээ, нарийвчлалтай шүүгдсэн дохионууд';

  @override
  String get elevateTradingWithAiStrategies =>
      'Тогтвортой байдал, тодорхой байдлыг бий болгох үүднээс AI-аар сайжруулсан стратеги ашиглан худалдаагаа дээшлүүлээрэй';

  @override
  String get winMoreWithAiSignalsTitle =>
      'AI-д суурилсан дохиогоор илүү их хожоорой\nзах зээл бүрт';

  @override
  String get winMoreWithAiSignalsDesc =>
      'Манай олон зах зээлийн AI нь Forex, Crypto, Металлуудыг бодит цагт сканнердаж,\nшинжээчдийн баталгаажуулсан худалдааны дохиог хүргэдэг —\nтодорхой оролт, алдагдлыг зогсоох, ашиг авах түвшнүүдтэй';

  @override
  String get buyLimit => 'Худалдан авах хязгаар';

  @override
  String get sellLimit => 'Зарах хязгаар';

  @override
  String get smarterToolsTitle =>
      'Илүү ухаалаг хэрэгслүүд - Илүү сайн хөрөнгө оруулалт';

  @override
  String get smarterToolsDesc =>
      'Эрсдэлийг багасгах, боломжуудыг ашиглах, баялгаа өсгөхөд туслах онцлогуудыг олж мэдээрэй';

  @override
  String get performanceOverviewTitle => 'Гүйцэтгэлийн тойм';

  @override
  String get performanceOverviewDesc =>
      'Манай олон зах зээлийн AI нь Forex, Crypto, Металлуудыг бодит цагт сканнердаж, шинжээчдийн баталгаажуулсан худалдааны дохиог хүргэдэг - тодорхой оролт, алдагдлыг зогсоох, ашиг авах түвшнүүдтэй';

  @override
  String get totalProfit => 'Нийт ашиг';

  @override
  String get completionSignal => 'Дуусгах дохио';

  @override
  String get onDemandFinancialExpertTitle =>
      'Таны хүсэлтийн дагуух санхүүгийн шинжээч';

  @override
  String get onDemandFinancialExpertDesc =>
      'AI платформ худалдааны дохио санал болгодог - өөрөө суралцдаг, зах зээлийг 24/7 шинжилдэг, сэтгэл хөдлөлд автдаггүй. Minvest нь 10,000 гаруй санхүүгийн шинжээчдэд нарийн, тогтвортой, хэрэглэхэд хялбар дохио олоход нь дэмжлэг үзүүлсэн';

  @override
  String get aiPoweredSignalPlatform =>
      'AI-д суурилсан Худалдааны Дохионы Платформ';

  @override
  String get selfLearningSystems =>
      'Өөрөө суралцах системүүд, Илүү хурц ойлголтууд, Илүү хүчтэй худалдаа';

  @override
  String get emotionlessExecution =>
      'Илүү ухаалаг, илүү сахилга баттай худалдаа хийх сэтгэл хөдлөлгүй гүйцэтгэл';

  @override
  String get analysingMarket247 => 'Зах зээлийг 24/7 шинжилж байна';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Signal GPT-ийн тусламжтайгаар үр дүнгээ дээд зэргээр нэмэгдүүлээрэй\nдэвшилтэт зах зээлийн шинжилгээ, нарийвчлалтай шүүгдсэн дохионууд';

  @override
  String get minvestAiRegistrationDesc =>
      'Signal GPT бүртгэл одоо нээлттэй — бид шинэ гишүүдийг хянаж, баталж байгаа тул орон тоо удахгүй хаагдаж магадгүй';

  @override
  String get currencyPairs => 'Түүхий эд';

  @override
  String get allCurrencyPairs => 'Бүх валютын хосууд';

  @override
  String get allCommodities => 'Бүх түүхий эд';

  @override
  String get allCryptoPairs => 'Бүх крипто хосууд';

  @override
  String get dateRange => 'Огнооны муж';

  @override
  String get selectDateRange => 'Огнооны муж сонгох';

  @override
  String get allAssets => 'Бүх хөрөнгө';

  @override
  String get asset => 'Хөрөнгө';

  @override
  String get tokenExpired => 'Токен дууссан';

  @override
  String get tokenLimitReachedDesc =>
      'Та өнөөдөр 10 үнэгүй токеноо ашигласан байна. Илүү олон дохио харахын тулд багцаа сайжруулна уу.';

  @override
  String get later => 'Дараа';

  @override
  String get created => 'Үүсгэсэн';

  @override
  String get detail => 'Дэлгэрэнгүй';

  @override
  String get performanceOverview => 'Гүйцэтгэлийн тойм';

  @override
  String get totalProfitPips => 'Нийт ашиг (Pips)';

  @override
  String get winRatePercent => 'Ялалтын хувь (%)';

  @override
  String get comingSoon => 'Тун удахгүй';

  @override
  String get errorLoadingHistory => 'Түүхийг ачаалахад алдаа гарлаа';

  @override
  String get noHistoryAvailable => 'Дохионы түүх байхгүй байна';

  @override
  String get previous => 'Өмнөх';

  @override
  String get page => 'Хуудас';

  @override
  String get next => 'Дараах';

  @override
  String get date => 'Огноо';

  @override
  String get timeGmt7 => 'Цаг (GMT)';

  @override
  String get orders => 'Захиалгууд';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      'Жижиг дэлгэц: бүтэн хүснэгтийг харахын тулд хэвтээ эргүүлэх эсвэл гүйлгэнэ үү.';

  @override
  String get history => 'Түүх';

  @override
  String get signalsWillAppearHere =>
      'Дохионууд бэлэн болсон үед энд харагдах болно';

  @override
  String get pricing => 'Үнэ';

  @override
  String get choosePlanSubtitle => 'Танд тохирох төлөвлөгөөг сонгоно уу';

  @override
  String get financialNewsHub => 'Санхүүгийн мэдээний төв';

  @override
  String get financialNewsHubDesc =>
      'Чухал шинэчлэлтүүд. Зах зээлийн хариу үйлдэл. Дуу чимээ байхгүй – зөвхөн хөрөнгө оруулагчдын мэдэх ёстой зүйлс.';

  @override
  String get newsTabAllArticles => 'Бүх нийтлэл';

  @override
  String get newsTabInvestor => 'Хөрөнгө оруулагч';

  @override
  String get newsTabKnowledge => 'Мэдлэг';

  @override
  String get newsTabTechnicalAnalysis => 'Техникийн шинжилгээ';

  @override
  String noArticlesForCategory(Object category) {
    return '$category ангилалд нийтлэл алга';
  }

  @override
  String get mostPopular => 'Хамгийн алдартай';

  @override
  String get noPosts => 'Нийтлэл алга';

  @override
  String get relatedArticles => 'Холбоотой нийтлэлүүд';

  @override
  String get contactInfoSentSuccess =>
      'Холбоо барих мэдээлэл амжилттай илгээгдлээ.';

  @override
  String contactInfoSentFailed(Object error) {
    return 'Мэдээлэл илгээхэд алдаа гарлаа: $error';
  }

  @override
  String get contactPageSubtitle =>
      'Асуулт байна уу эсвэл AI шийдэл хэрэгтэй байна уу? Маягтыг бөглөж бидэнд мэдэгдээрэй, бид холбогдох болно!';

  @override
  String get phone => 'Утас';

  @override
  String get firstName => 'Нэр';

  @override
  String get enterFirstName => 'Нэр оруулах';

  @override
  String get lastName => 'Овог';

  @override
  String get enterLastName => 'Овог оруулах';

  @override
  String get whatAreYourConcerns => 'Таны санаа зовж буй асуудал юу вэ?';

  @override
  String get writeConcernsHere => 'Асуудлаа энд бичнэ үү...';

  @override
  String pleaseEnter(Object field) {
    return '$field-г оруулна уу';
  }

  @override
  String get faqQuestion1 =>
      'Дохионууд 100% амжилтын хувийг баталгаажуулдаг уу?';

  @override
  String get faqAnswer1 =>
      'Ямар ч дохиог 100% баталгаажуулах боломжгүй ч Signal GPT нь нарийвчилсан дүн шинжилгээ, эрсдэлийн удирдлагаар дэмжигдсэн 60-80% тогтвортой амжилтын хувийг хадгалахыг хичээдэг тул та эцсийн шийдвэрийг илүү итгэлтэй гаргах боломжтой.';

  @override
  String get faqQuestion2 =>
      'Хэрэв би шууд мөнгө байршуулахыг хүсэхгүй бол дохионы санал авч болох уу?';

  @override
  String get faqAnswer2 =>
      'Данс нээх үед систем танд 10 үнэгүй токен бэлэглэх бөгөөд энэ нь 10 дэлгэрэнгүй дохио харахтай тэнцэнэ. Үүний дараа та өдөр бүр ашиглах 1 нэмэлт токен хүлээн авах болно. Хэрэв та VIP данс руу шилжүүлбэл олон дэвшилтэт функцуудыг нээж, хязгааргүй тооны захиалгыг хянах болно.';

  @override
  String get faqQuestion3 =>
      'Хэрэв би бүртгүүлсэн ч ямар ч дохио хүлээж аваагүй бол ямар арга хэмжээ авах ёстой вэ?';

  @override
  String get faqAnswer3 =>
      'Боловсруулалт ихэвчлэн автоматаар хийгддэг. Хэрэв та ямар нэгэн дохионы санал харахгүй хэвээр байвал Whatsapp-аар бидэнтэй холбогдож яаралтай тусламж авна уу.';

  @override
  String get faqQuestion4 =>
      'VIP данс руу шилжих үед би өдөрт хэдэн дохио хүлээж авах вэ?';

  @override
  String get faqAnswer4 =>
      'VIP данс руу шилжих үед та өдөр бүр хязгааргүй худалдааны дохио хүлээн авах болно. Дохионы тоо тогтмол биш боловч зах зээлийн шинжилгээнээс бүрэн хамаарна. Өндөр чанартай, өндөр магадлалтай нэвтрэх цэг гарч ирэх бүрт шинжилгээний баг дохиог танд шууд илгээх болно.';

  @override
  String get priceLevels => 'Үнийн түвшин';

  @override
  String get capitalManagement => 'Хөрөнгийн менежмент';

  @override
  String freeSignalsLeft(Object count) {
    return '$count үнэгүй дохио үлдсэн';
  }

  @override
  String get unlimitedSignals => 'Хязгааргүй дохио';

  @override
  String get goBack => 'Буцах';

  @override
  String get goldPlan => 'Алтан төлөвлөгөө';

  @override
  String get perMonth => '/ сар';

  @override
  String get continuouslyUpdating =>
      'Зах зээлийн мэдээллийг 24/7 тасралтгүй шинэчилж байна';

  @override
  String get providingBestSignals => 'Шилдэг дохиог бодит цагт өгч байна';

  @override
  String get includesEntrySlTp => 'Entry, SL, TP багтсан';

  @override
  String get detailedAnalysis =>
      'Дохио бүрийн нарийвчилсан дүн шинжилгээ, үнэлгээ';

  @override
  String get realTimeNotifications => 'Имэйлээр бодит цагийн мэдэгдэл';

  @override
  String get signalPerformanceStats => 'Дохионы гүйцэтгэлийн статистик';

  @override
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails => 'Бизнес бүртгэлийн дугаар: 0110057263';

  @override
  String get addressDetails =>
      'Хаяг: Вьетнам, Ханой хот, Хай Ба Трунг дүүрэг, До Хан гудамж, №8';

  @override
  String get pagesTitle => 'Хуудас';

  @override
  String get legalRegulatoryTitle => 'Хууль эрх зүй & Зохицуулалт';

  @override
  String get termsOfRegistration => 'Бүртгэлийн нөхцөл';

  @override
  String get operatingPrinciples => 'Үйл ажиллагааны зарчим';

  @override
  String get termsConditions => 'Нөхцөл ба болзол';

  @override
  String get contactTitle => 'Холбоо барих';

  @override
  String get navFeatures => 'Онцлог';

  @override
  String get navNews => 'Мэдээ';

  @override
  String get tp1Hit => 'TP1 Оносон';

  @override
  String get tp2Hit => 'TP2 Оносон';

  @override
  String get tp3Hit => 'TP3 Оносон';

  @override
  String get slHit => 'SL Оносон';

  @override
  String get cancelled => 'Цуцлагдсан';

  @override
  String get exitedByAdmin => 'Админ гарсан';

  @override
  String get signalClosed => 'Хаагдсан';

  @override
  String get errorLoadingPackages => 'Багцуудыг ачаалахад алдаа гарлаа';

  @override
  String get monthly => 'Сар бүр';

  @override
  String get annually => 'Жил бүр';

  @override
  String get whatsIncluded => 'Багтсан зүйлс:';

  @override
  String get chooseThisPlan => 'Энэ төлөвлөгөөг сонгох';

  @override
  String get bestPricesForPremiumAccess =>
      'Дээд зэрэглэлийн хандалтын шилдэг үнэ';

  @override
  String get choosePlanFitsNeeds =>
      'Бизнесийн хэрэгцээнд тохирсон төлөвлөгөөг сонгож, AI-аар автоматжуулж эхлээрэй';

  @override
  String get save50Percent => '50% ХЭМНЭХ';

  @override
  String get tryDemo => 'Демо турших';

  @override
  String get pleaseEnterEmailPassword => 'Имэйл болон нууц үгээ оруулна уу';

  @override
  String loginFailed(String error) {
    return 'Нэвтрэх амжилтгүй боллоо: $error';
  }

  @override
  String get welcomeBack => 'Эргэн тавтай морил';

  @override
  String get signInToContinue => 'Үргэлжлүүлэхийн тулд дансандаа нэвтэрнэ үү';

  @override
  String get or => 'эсвэл';

  @override
  String get email => 'Имэйл';

  @override
  String get emailHint => 'example123@gmail.com';

  @override
  String get password => 'Нууц үг';

  @override
  String get enterPassword => 'Нууц үг оруулах';

  @override
  String get forgotPassword => 'Нууц үгээ мартсан уу?';

  @override
  String get createNewAccount => 'Энд шинэ данс үүсгэх!';

  @override
  String get signUp => 'Бүртгүүлэх';

  @override
  String get signUpAccount => 'Данс бүртгүүлэх';

  @override
  String get enterPersonalData =>
      'Данс үүсгэхийн тулд хувийн мэдээллээ оруулна уу';

  @override
  String get nameLabel => 'Нэр *';

  @override
  String get enterNameHint => 'Нэр оруулах';

  @override
  String get emailLabel => 'Имэйл *';

  @override
  String get passwordLabel => 'Нууц үг *';

  @override
  String get phoneLabel => 'Утас';

  @override
  String get continueButton => 'Үргэлжлүүлэх';

  @override
  String get fillAllFields => 'Шаардлагатай бүх талбарыг бөглөнө үү.';

  @override
  String get accountCreatedSuccess => 'Данс амжилттай үүслээ.';

  @override
  String signUpFailed(String error) {
    return 'Бүртгэл амжилтгүй боллоо: $error';
  }

  @override
  String get nationality => 'Харьяалал:';

  @override
  String get overview => 'Тойм';

  @override
  String get setting => 'Тохиргоо';

  @override
  String get paymentHistory => 'Төлбөрийн түүх';

  @override
  String get signalsPlan => 'Дохионы төлөвлөгөө';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => 'Таны Токенууд';

  @override
  String get emailNotificationPreferences => 'Имэйл мэдэгдлийн тохиргоо';

  @override
  String get chooseSignalNotificationTypes =>
      'Имэйлээр ямар төрлийн дохионы мэдэгдэл хүлээн авахыг хүсч байгаагаа сонгоно уу';

  @override
  String get allSignalNotifications => 'Бүх дохионы мэдэгдэл';

  @override
  String get cryptoSignals => 'Крипто дохио';

  @override
  String get forexSignals => 'Forex дохио';

  @override
  String get goldSignals => 'Алтны дохио';

  @override
  String get updatePasswordSecure =>
      'Бүртгэлээ аюулгүй байлгахын тулд нууц үгээ шинэчилнэ үү';

  @override
  String get searchLabel => 'Хайх:';

  @override
  String get filterBy => 'Шүүх:';

  @override
  String get allTime => 'Бүх цаг үе';

  @override
  String get startDate => 'Эхлэх огноо:';

  @override
  String get endDate => 'Дуусах огноо:';

  @override
  String get deactivate => 'Идэвхгүй болгох';

  @override
  String get unlimited => 'Хязгааргүй';

  @override
  String get tenLeft => '10 үлдсэн';

  @override
  String get termsOfRegistrationContent =>
      'Please read all the terms and agreements below carefully before proceeding with the next steps in our system.\nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\n1. Introduction and Scope of Application\n\nThis policy regulates the collection, use, sharing, and protection of users’ personal information when accessing and using the products and services of the Signal GPT system – a technology and artificial intelligence platform owned and operated by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED (hereinafter referred to as “we” or “us”).\nBy registering an account or using Signal GPT’s products, you agree that such action constitutes a legally binding commitment between you and us, equivalent to an electronic contract.\n\n2. Account Registration\n\nTo access and use certain services on Signal GPT, you must register a valid account.\nWhen registering, you are required to provide complete and accurate personal information, including your full name, email address, phone number, or any other information as requested.\nAfter registration, you must confirm your email to activate the account. All notifications about your account, promotions, or system updates will be sent to this email address.\nIf the information you provide is inaccurate or incomplete, you will be solely responsible for any incidents or damages arising from it.\n\n3. Terms of Use\n\nWhen participating in the Signal GPT system, you are obligated to comply with all of the following:\nThe operating principles of the platform;\nPayment terms;\nPersonal data privacy policy;\nRelevant laws and regulations in effect.\nIn the event of a violation, EZTRADE reserves the right to temporarily suspend or permanently delete your account, and may transfer the case to competent authorities if necessary.\n\n4. Personal Data Privacy Policy\n\n4.1. Purpose and Scope of ... [truncated]';

  @override
  String get operatingPrinciplesContent =>
      'Please read all terms and agreements below carefully before proceeding with the next steps in our system. \nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\nOPERATING RULES\n\n1. Legal Information\n\nSystem Owner:\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness/Tax Code: 0110057263\nPhone: 0862 600 626\n\n2. Scope of Application\n\nThese Operating Principles apply to all users, learners, partners, and collaborators who participate in or use the products and services within the Signal GPT system, including websites, applications, training platforms, and other online channels managed by EZTRADE.\nBy registering an account or using the services of Signal GPT, users are deemed to have read, understood, and agreed to all the terms set forth in these regulations.\n\n3. Definitions\n\n“Signal GPT” refers to the technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED.\n“Customer” / “User” / “Learner” refers to any individual or organization that registers, accesses, or uses the services and products on the Signal GPT system.\n“We” / “Administration” refers to the management team representing EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED, responsible for operating and managing the system.\n“Products” / “Services” include learning packages, analytical newsletters, AI trading signals, analytical tools, or any digital content provided by Signal GPT.\n\n4. Usage Rules and Information Security\n\nUsers must provide accurate and complete information when registering an account.\nSignal GPT is committed to protecting personal information and will not disclose it to third parties unless required by competent authorities.\nUsers are responsible for maintaining the confidentiality of their account and pa... [truncated]';

  @override
  String get termsAndConditionsContent =>
      'By registering an account to participate in the Signal GPT system, you confirm that you have read, understood, and agreed to all the contents of these Account Opening Terms and Conditions.\nThe latest updates (if any) will be published here, and Signal GPT will not send separate notifications to each customer. Therefore, please visit this page regularly to stay informed about the most recent policies.\n\n1. General Agreement\n\nSignal GPT is a technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED. By opening an account on this system, you agree to participate in and use the services and products provided by EZTRADE.\nAccount registration and activation are considered an electronic contract between you and Signal GPT, which has the same legal validity as a civil contract under the laws of Vietnam.\n\n2. Personal Account Information and Privacy\n\n2.1. Purpose and Scope of Information Collection\n\nTo access and use certain Signal GPT services, you must provide basic personal information, including:\nFull name;\nEmail address;\nContact phone number;\nOther information (if any) necessary for verification, support, or access authorization.\nAll information provided must be accurate, truthful, and lawful. Signal GPT shall not be responsible for any losses or disputes arising from false, missing, or fraudulent information provided by the user.\nAdditionally, the system may automatically collect certain technical data, such as:\nIP address, browser type, and language used;\nAccess time and pages viewed within the system.\nThis information helps Signal GPT improve performance, enhance security, and optimize user experience.\n\n2.2. Scope of Information Use\n\nYour personal information is collected and used for legitimate purposes, including:\nManaging accounts, verifying users, and maintaining services;\nSending notifications related to services, accounts, promotions, or policy changes;\nProv... [truncated]';

  @override
  String get performance => 'Гүйцэтгэл';

  @override
  String get minvestSupport => 'SignalGpt Support';

  @override
  String get leaveMessagePart1 =>
      'Зурвас үлдээнэ үү, манай баг аль болох хурдан хариулах болно. Та мөн ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 =>
      ' +84 969 156 969-аар холбогдож хурдан дэмжлэг авах боломжтой.';

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
  String get signInRequired => 'Нэвтрэх шаардлагатай';

  @override
  String get signInToExploreSignal =>
      'Энэхүү арилжааны дохиог үзэхийн туلد нэвтэрнэ үү!';

  @override
  String get activeMember => 'Идэвхтэй гишүүн';

  @override
  String get last7Days => 'Сүүлийн 7 хоног';

  @override
  String get last14Days => 'Сүүлийн 14 хоног';

  @override
  String get last30Days => 'Сүүлийн 30 хоног';

  @override
  String get last90Days => 'Сүүлийн 90 хоног';

  @override
  String get profitStatistics => 'Ашгийн статистик';

  @override
  String get winrateOfAllSignals => 'Бүх дохионы хожлын хувь';

  @override
  String get daily => 'Өдөр бүр';

  @override
  String get weekly => 'Долоо хоног бүр';

  @override
  String get lossRate => 'Алдагдлын хувь';

  @override
  String get signalProgress => 'Signal Progress';

  @override
  String get statusHistory => 'Status History';

  @override
  String get signalCreated => 'Signal Created';

  @override
  String get signalMatched => 'Сигнал таарлаа';

  @override
  String get targetReached => 'Зорилтот хүрсэн';

  @override
  String get freeSignalsInfo => 'Үнэгүй Сигналын Мэдээлэл';

  @override
  String get freeSignalsInfoDesc =>
      'Та өдөрт 1 үнэгүй сигнал авах болно.\nАшиглагдаагүй сигналууд дараагийн өдөрт шилжинэ.';

  @override
  String freeSignalsCount(int count) {
    return '$count Үнэгүй Сигнал';
  }

  @override
  String get close => 'Хаах';

  @override
  String validUntil(String date) {
    return '$date хүртэл хүчинтэй';
  }
}
