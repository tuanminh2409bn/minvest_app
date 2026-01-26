// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class AppLocalizationsKm extends AppLocalizations {
  AppLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'គណនីត្រូវបានដំឡើងដោយជោគជ័យ';

  @override
  String get lotPerWeek => 'Lot/សប្តាហ៍';

  @override
  String get tableValueFull => 'ពេញ';

  @override
  String get tableValueFulltime => 'ពេញម៉ោង';

  @override
  String get packageTitle => 'កញ្ចប់';

  @override
  String get duration1Month => '1 ខែ';

  @override
  String get duration12Months => '12 ខែ';

  @override
  String get featureReceiveAllSignals => 'ទទួលបានសញ្ញាទាំងអស់ប្រចាំថ្ងៃ';

  @override
  String get featureAnalyzeReason => 'វិភាគមូលហេតុនៃការចូលបញ្ជាទិញ';

  @override
  String get featureHighPrecisionAI => 'សញ្ញា AI ដែលមានភាពជាក់លាក់ខ្ពស់';

  @override
  String get iapStoreNotAvailable => 'ហាងមិនមាននៅលើឧបករណ៍នេះទេ។';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'កំហុសក្នុងការផ្ទុកផលិតផល៖ $message';
  }

  @override
  String get iapNoProductsFound =>
      'រកមិនឃើញផលិតផលទេ។ សូមពិនិត្យមើលការកំណត់ហាងរបស់អ្នក។';

  @override
  String iapTransactionError(Object message) {
    return 'កំហុសប្រតិបត្តិការ៖ $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'កំហុសក្នុងការផ្ទៀងផ្ទាត់៖ $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'មានកំហុសមិនស្គាល់មួយបានកើតឡើង៖ $error';
  }

  @override
  String get iapProcessingTransaction => 'កំពុងដំណើរការប្រតិបត្តិការ...';

  @override
  String get orderInfo1Month => 'ការទូទាត់សម្រាប់កញ្ចប់ Elite 1 ខែ';

  @override
  String get orderInfo12Months => 'ការទូទាត់សម្រាប់កញ្ចប់ Elite 12 ខែ';

  @override
  String get iapNotSupportedOnWeb =>
      'ការទិញក្នុងកម្មវិធីមិនត្រូវបានគាំទ្រនៅលើកំណែគេហទំព័រទេ។';

  @override
  String get vnpayPaymentTitle => 'ការទូទាត់ VNPAY';

  @override
  String get creatingOrderWait => 'កំពុងបង្កើតការបញ្ជាទិញ សូមរង់ចាំ...';

  @override
  String errorWithMessage(Object message) {
    return 'កំហុស៖ $message';
  }

  @override
  String get cannotConnectToServer =>
      'មិនអាចភ្ជាប់ទៅម៉ាស៊ីនមេបានទេ។ សូម​ព្យាយាម​ម្តង​ទៀត។';

  @override
  String get transactionCancelledOrFailed =>
      'ប្រតិបត្តិការត្រូវបានលុបចោល ឬបរាជ័យ។';

  @override
  String get cannotCreatePaymentLink =>
      'មិនអាចបង្កើតតំណទូទាត់បានទេ។\nព្យាយាម​ម្តង​ទៀត។';

  @override
  String get retry => 'ព្យាយាម​ម្តង​ទៀត';

  @override
  String serverErrorRetry(Object message) {
    return 'កំហុសម៉ាស៊ីនមេ៖ $message។ សូម​ព្យាយាម​ម្តង​ទៀត។';
  }

  @override
  String get redirectingToPayment => 'កំពុងបញ្ជូនបន្តទៅទំព័រទូទាត់...';

  @override
  String get invalidPaymentUrl => 'បានទទួល URL ទូទាត់មិនត្រឹមត្រូវពីម៉ាស៊ីនមេ។';

  @override
  String get processingYourAccount => 'កំពុងដំណើរការគណនីរបស់អ្នក...';

  @override
  String get verificationFailed => 'ការផ្ទៀងផ្ទាត់បានបរាជ័យ!';

  @override
  String get reuploadImage => 'បង្ហោះរូបភាពឡើងវិញ';

  @override
  String get accountNotLinked => 'គណនីមិនត្រូវបានភ្ជាប់ទៅ Minvest ទេ';

  @override
  String get accountNotLinkedDesc =>
      'ដើម្បីទទួលបានសញ្ញាពិសេស គណនី Exness របស់អ្នកត្រូវតែចុះឈ្មោះតាមរយៈតំណដៃគូ Minvest ។ សូមបង្កើតគណនីថ្មីដោយប្រើតំណខាងក្រោម។';

  @override
  String get registerExnessViaMinvest => 'ចុះឈ្មោះ Exness តាមរយៈ Minvest';

  @override
  String get iHaveRegisteredReupload => 'ខ្ញុំបានចុះឈ្មោះហើយ បង្ហោះឡើងវិញ';

  @override
  String couldNotLaunch(Object url) {
    return 'មិនអាចបើក $url បានទេ';
  }

  @override
  String get status => 'ស្ថានភាព';

  @override
  String get sentOn => 'បានផ្ញើនៅ';

  @override
  String get entryPrice => 'តម្លៃចូល';

  @override
  String get stopLossFull => 'Stop loss';

  @override
  String get takeProfitFull1 => 'Take profit 1';

  @override
  String get takeProfitFull2 => 'Take profit 2';

  @override
  String get takeProfitFull3 => 'Take profit 3';

  @override
  String get noReasonProvided =>
      'មិនមានមូលហេតុត្រូវបានផ្តល់ឱ្យសម្រាប់សញ្ញានេះទេ។';

  @override
  String get upgradeToViewReason =>
      'ដំឡើងគណនីរបស់អ្នកទៅ Elite ដើម្បីមើលការវិភាគ។';

  @override
  String get upgradeToViewFullAnalysis => 'ដំឡើងកំណែដើម្បីមើលការវិភាគពេញលេញ';

  @override
  String get welcomeTo => 'សូមស្វាគមន៍មកកាន់';

  @override
  String get appSlogan => 'បង្កើនការជួញដូររបស់អ្នកជាមួយនឹងសញ្ញាឆ្លាតវៃ។';

  @override
  String get signIn => 'ចូល';

  @override
  String get continueByGoogle => 'បន្តជាមួយ Google';

  @override
  String get continueByFacebook => 'បន្តជាមួយ Facebook';

  @override
  String get continueByApple => 'បន្តជាមួយ Apple';

  @override
  String get loginSuccess => 'ចូលបានជោគជ័យ!';

  @override
  String get live => 'បន្តផ្ទាល់';

  @override
  String get end => 'បញ្ចប់';

  @override
  String get symbol => 'និមិត្តសញ្ញា';

  @override
  String get aiSignal => 'សញ្ញា AI';

  @override
  String get ruleSignal => 'សញ្ញា RULE';

  @override
  String get all => 'ទាំងអស់';

  @override
  String get upgradeToSeeMore => 'ដំឡើងកំណែដើម្បីមើលបន្ថែម';

  @override
  String get seeDetails => 'មើលព័ត៌មានលម្អិត';

  @override
  String get notMatched => 'មិនត្រូវគ្នា';

  @override
  String get matched => 'ត្រូវគ្នា';

  @override
  String get entry => 'ចូល';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'ដំឡើងកំណែ';

  @override
  String get upgradeAccount => 'ដំឡើងគណនី';

  @override
  String get compareTiers => 'ប្រៀបធៀបកម្រិត';

  @override
  String get feature => 'លក្ខណៈពិសេស';

  @override
  String get tierDemo => 'Demo';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'សមតុល្យ';

  @override
  String get signalTime => 'ពេលវេលាសញ្ញា';

  @override
  String get signalQty => 'ចំនួនសញ្ញា';

  @override
  String get analysis => 'ការវិភាគ';

  @override
  String get openExnessAccount => 'បើកគណនី Exness!';

  @override
  String get accountVerificationWithExness => 'ការផ្ទៀងផ្ទាត់គណនីជាមួយ Exness';

  @override
  String get payInAppToUpgrade => 'បង់ក្នុងកម្មវិធីដើម្បីដំឡើងកំណែ';

  @override
  String get bankTransferToUpgrade => 'ផ្ទេរប្រាក់តាមធនាគារដើម្បីដំឡើងកំណែ';

  @override
  String get accountVerification => 'ការផ្ទៀងផ្ទាត់គណនី';

  @override
  String get accountVerificationPrompt =>
      'សូមបង្ហោះរូបថតអេក្រង់នៃគណនី Exness របស់អ្នកដើម្បីទទួលបានការអនុញ្ញាត (គណនីរបស់អ្នកត្រូវតែបើកនៅក្រោមតំណ Exness របស់ Minvest)';

  @override
  String get selectPhotoFromLibrary => 'ជ្រើសរើសរូបថតពីបណ្ណាល័យ';

  @override
  String get send => 'ផ្ញើ';

  @override
  String get accountInfo => 'ព័ត៌មានគណនី';

  @override
  String get accountVerifiedSuccessfully => 'គណនីត្រូវបានផ្ទៀងផ្ទាត់ដោយជោគជ័យ';

  @override
  String get yourAccountIs => 'គណនីរបស់អ្នកគឺ';

  @override
  String get returnToHomePage => 'ត្រឡប់ទៅទំព័រដើម';

  @override
  String get upgradeFailed => 'ការដំឡើងកំណែបានបរាជ័យ! សូមបង្ហោះរូបភាពឡើងវិញ';

  @override
  String get package => 'កញ្ចប់';

  @override
  String get startNow => 'ទទួលបានសញ្ញាឥឡូវនេះ';

  @override
  String get bankTransfer => 'ការផ្ទេរប្រាក់តាមធនាគារ';

  @override
  String get transferInformation => 'ព័ត៌មានផ្ទេរប្រាក់';

  @override
  String get scanForFastTransfer => 'ស្កេនដើម្បីផ្ទេររហ័ស';

  @override
  String get contactUs247 => 'ទាក់ទងមកយើង 24/7';

  @override
  String get newAnnouncement => 'សេចក្តីជូនដំណឹងថ្មី';

  @override
  String get profile => 'ប្រវត្តិរូប';

  @override
  String get upgradeNow => 'ដំឡើងកំណែឥឡូវនេះ';

  @override
  String get followMinvest => 'តាមដាន MInvest';

  @override
  String get tabSignal => 'សញ្ញា';

  @override
  String get tabChart => 'តារាង';

  @override
  String get tabProfile => 'ប្រវត្តិរូប';

  @override
  String get reason => 'មូលហេតុ';

  @override
  String get error => 'កំហុស';

  @override
  String get noSignalsAvailable => 'មិនមានសញ្ញាទេ។';

  @override
  String get outOfGoldenHours => 'ក្រៅម៉ោងមាស';

  @override
  String get outOfGoldenHoursVipDesc =>
      'សញ្ញា VIP មានចាប់ពីម៉ោង 8:00 ព្រឹក ដល់ 5:00 ល្ងាច (GMT+7)។\nដំឡើងទៅ Elite ដើម្បីទទួលបានសញ្ញា 24/24!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'សញ្ញា Demo មានចាប់ពីម៉ោង 8:00 ព្រឹក ដល់ 5:00 ល្ងាច (GMT+7)។\nដំឡើងគណនីរបស់អ្នកដើម្បីទទួលបានអត្ថប្រយោជន៍បន្ថែម!';

  @override
  String get yourName => 'ឈ្មោះរបស់អ្នក';

  @override
  String get yourEmail => 'your.email@example.com';

  @override
  String get adminPanel => 'ផ្ទាំងគ្រប់គ្រង';

  @override
  String get logout => 'ចាកចេញ';

  @override
  String get confirmLogout => 'បញ្ជាក់ការចាកចេញ';

  @override
  String get confirmLogoutMessage => 'តើអ្នកពិតជាចង់ចាកចេញមែនទេ?';

  @override
  String get cancel => 'បោះបង់';

  @override
  String get upgradeCardTitle => 'ដំឡើងគណនីរបស់អ្នក';

  @override
  String get upgradeCardSubtitle => 'ដើម្បីចូលប្រើធនធានបន្ថែម';

  @override
  String get upgradeCardSubtitleWeb =>
      'ដើម្បីដោះសោសញ្ញាពិសេស និងការគាំទ្រពេញម៉ោង';

  @override
  String get subscriptionDetails => 'ព័ត៌មានលម្អិតការជាវ';

  @override
  String get notifications => 'ការជូនដំណឹង';

  @override
  String get continueAsGuest => 'បន្តជាភ្ញៀវ';

  @override
  String get deleteAccount => 'លុបគណនី';

  @override
  String get deleteAccountWarning =>
      'តើអ្នកពិតជាចង់លុបគណនីរបស់អ្នកមែនទេ? ទិន្នន័យទាំងអស់របស់អ្នកនឹងត្រូវបានលុបជាអចិន្ត្រៃយ៍ ហើយមិនអាចយកមកវិញបានទេ។';

  @override
  String get delete => 'លុប';

  @override
  String get privacyPolicy => 'គោលការណ៍ឯកជនភាព';

  @override
  String get termsOfService => 'លក្ខខណ្ឌនៃសេវាកម្ម';

  @override
  String get signalStatusMatched => 'ត្រូវគ្នា';

  @override
  String get signalStatusNotMatched => 'មិនត្រូវគ្នា';

  @override
  String get signalStatusCancelled => 'បានលុបចោល';

  @override
  String get signalStatusSlHit => 'SL HIT';

  @override
  String get signalStatusTp1Hit => 'TP1 HIT';

  @override
  String get signalStatusTp2Hit => 'TP2 HIT';

  @override
  String get signalStatusTp3Hit => 'TP3 HIT';

  @override
  String get signalStatusRunning => 'កំពុងដំណើរការ';

  @override
  String get signalStatusClosed => 'បានបិទ';

  @override
  String get contactUs => 'ទាក់ទងមកយើង';

  @override
  String get tabChat => 'ជជែក';

  @override
  String get exnessUpgradeNoteForIos =>
      'សម្រាប់អតិថិជនដែលបានចុះឈ្មោះគណនី Exness តាមរយៈ Minvest សូមចុចទាក់ទងមកយើងខ្ញុំ ដើម្បីដំឡើងគណនីរបស់អ្នក។';

  @override
  String get chatWelcomeTitle => '👋 សូមស្វាគមន៍មកកាន់ Signal GPT!';

  @override
  String get chatWelcomeBody1 =>
      'សូមទុកសារ ក្រុមការងាររបស់យើងនឹងឆ្លើយតបក្នុងពេលឆាប់ៗនេះ។';

  @override
  String get chatWelcomeBody2 => 'ឬទាក់ទងមកយើងដោយផ្ទាល់តាមរយៈ Zalo/WhatsApp៖ ';

  @override
  String get chatWelcomeBody3 => ' សម្រាប់ការគាំទ្រកាន់តែលឿន!';

  @override
  String get chatLoginPrompt => 'សូមចូលដើម្បីប្រើប្រាស់មុខងារនេះ';

  @override
  String get chatStartConversation => 'ចាប់ផ្តើមការសន្ទនារបស់អ្នក';

  @override
  String get chatNoMessages => 'មិនទាន់មានសារនៅឡើយទេ។';

  @override
  String get chatTypeMessage => 'វាយសារ...';

  @override
  String get chatSupportIsTyping => 'អ្នកគាំទ្រកំពុងវាយ...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName កំពុងវាយ...';
  }

  @override
  String get chatSeen => 'បានឃើញ';

  @override
  String get chatDefaultUserName => 'អ្នកប្រើប្រាស់';

  @override
  String get chatDefaultSupportName => 'អ្នកគាំទ្រ';

  @override
  String get signalEntry => 'Entry';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      'សម្រាប់ពាណិជ្ជករបរទេស សូមទាក់ទងមកយើងខ្ញុំតាមរយៈ WhatsApp (+84969.15.6969) សម្រាប់ការគាំទ្រ';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails => 'ដំឡើងកំណែដើម្បីមើលព័ត៌មានលម្អិតសញ្ញា...';

  @override
  String get buy => 'ទិញ';

  @override
  String get sell => 'លក់';

  @override
  String get logoutDialogTitle => 'សម័យបានផុតកំណត់';

  @override
  String get logoutDialogDefaultReason =>
      'គណនីរបស់អ្នកត្រូវបានចូលនៅលើឧបករណ៍ផ្សេង។';

  @override
  String get ok => 'យល់ព្រម';

  @override
  String get contactToUpgrade => 'ទាក់ទងដើម្បីដំឡើងកំណែ';

  @override
  String get noNotificationsYet => 'មិនទាន់មានការជូនដំណឹងនៅឡើយទេ។';

  @override
  String daysAgo(int count) {
    return '$count ថ្ងៃមុន';
  }

  @override
  String hoursAgo(int count) {
    return '$count ម៉ោងមុន';
  }

  @override
  String minutesAgo(int count) {
    return '$count នាទីមុន';
  }

  @override
  String get justNow => 'អម្បាញ់មិញ';

  @override
  String get getSignalsNow => 'ទទួលបានសញ្ញាឥឡូវនេះ';

  @override
  String get freeTrial => 'ការសាកល្បងឥតគិតថ្លៃ';

  @override
  String get heroTitle => 'ការណែនាំពាណិជ្ជករ និងការបង្កើនផលប័ត្រ';

  @override
  String get heroSubtitle => 'ម៉ាស៊ីន AI ចុងក្រោយ - រចនាដោយពាណិជ្ជករជំនាញ';

  @override
  String get globalAiInnovationTitle =>
      'នវានុវត្តន៍ AI សកលសម្រាប់ជំនាន់បន្ទាប់នៃបញ្ញាជួញដូរ';

  @override
  String get globalAiInnovationDesc =>
      'ការផ្លាស់ប្តូរការជួញដូរបែបប្រពៃណីជាមួយនឹងសញ្ញា AI ដែលដំណើរការដោយពពក — សម្របខ្លួនទៅនឹងព័ត៌មានទីផ្សារ និងនិន្នាការតាមពេលវេលាជាក់ស្តែង\nសម្រាប់ដំណើរការលឿនជាងមុន ច្បាស់លាស់ជាងមុន និងគ្មានអារម្មណ៍។';

  @override
  String get liveTradingSignalsTitle => 'បន្តផ្ទាល់ – សញ្ញាជួញដូរ AI 24/7';

  @override
  String get liveTradingSignalsDesc =>
      'ការវិភាគពពកតាមពេលវេលាជាក់ស្តែង ផ្តល់ជូននូវយុទ្ធសាស្រ្តតាមដាននិន្នាការដែលមានប្រូបាប៊ីលីតេខ្ពស់ជាមួយនឹងភាពជាក់លាក់ និងការអនុវត្តដោយគ្មានអារម្មណ៍។';

  @override
  String get trendFollowing => 'ការតាមដាននិន្នាការ';

  @override
  String get realtime => 'ពេលវេលាជាក់ស្តែង';

  @override
  String get orderExplanationEngineTitle => 'ម៉ាស៊ីនពន្យល់ការបញ្ជាទិញ';

  @override
  String get orderExplanationEngineDesc =>
      'ពន្យល់ការកំណត់ពាណិជ្ជកម្មតាមពាក្យសាមញ្ញ — បង្ហាញពីរបៀបដែលការបញ្ចូលគ្នាកើតឡើង មូលហេតុដែលការចូលត្រូវបានធ្វើឡើង និងជួយពាណិជ្ជកររៀនពីការសម្រេចចិត្តនីមួយៗ។';

  @override
  String get transparent => 'តម្លាភាព';

  @override
  String get educational => 'ការអប់រំ';

  @override
  String get logical => 'សមហេតុផល';

  @override
  String get transparentRealPerformanceTitle =>
      'តម្លាភាព - ការអនុវត្តជាក់ស្តែង';

  @override
  String get transparentRealPerformanceDesc =>
      'មើលទិន្នន័យជាក់ស្តែងអំពីភាពត្រឹមត្រូវនៃសញ្ញា អត្រាជោគជ័យ និងប្រាក់ចំណេញ — បានផ្ទៀងផ្ទាត់ និងអាចតាមដានបានរាល់ការជួញដូរ';

  @override
  String get results => 'លទ្ធផល';

  @override
  String get performanceTracking => 'ការតាមដានការអនុវត្ត';

  @override
  String get accurate => 'ត្រឹមត្រូវ';

  @override
  String get predictiveAccuracy => 'ភាពត្រឹមត្រូវនៃការព្យាករណ៍';

  @override
  String get improvementInProfitability => 'ការកែលម្អប្រាក់ចំណេញ';

  @override
  String get improvedRiskManagement => 'ការគ្រប់គ្រងហានិភ័យដែលបានកែលម្អ';

  @override
  String get signalsPerformanceTitle => 'ការអនុវត្តសញ្ញា';

  @override
  String get riskToRewardRatio => 'សមាមាត្រហានិភ័យទៅនឹងរង្វាន់';

  @override
  String get howRiskComparesToReward => 'របៀបដែលហានិភ័យប្រៀបធៀបទៅនឹងរង្វាន់';

  @override
  String get profitLossOverview => 'ទិដ្ឋភាពទូទៅនៃប្រាក់ចំណេញ/ខាត';

  @override
  String get netGainVsLoss => 'ចំណេញសុទ្ធធៀបនឹងការខាតបង់';

  @override
  String get winRate => 'អត្រាឈ្នះ';

  @override
  String get percentageOfWinningTrades => 'ភាគរយនៃការជួញដូរដែលឈ្នះ';

  @override
  String get accuracyRate => 'អត្រាភាពត្រឹមត្រូវ';

  @override
  String get howPreciseOurSignalsAre =>
      'តើសញ្ញារបស់យើងមានភាពច្បាស់លាស់កម្រិតណា';

  @override
  String get realtimeMarketAnalysis => 'ការវិភាគទីផ្សារតាមពេលវេលាជាក់ស្តែង';

  @override
  String get realtimeMarketAnalysisDesc =>
      'AI របស់យើងតាមដានទីផ្សារជាបន្តបន្ទាប់ ដោយកំណត់អត្តសញ្ញាណតំបន់បង្រួបបង្រួមបច្ចេកទេស និងចំណុចបំបែកដែលអាចទុកចិត្តបាន ដើម្បីឱ្យអ្នកអាចចូលរួមការជួញដូរនៅពេលត្រឹមត្រូវ។';

  @override
  String get saveTimeOnAnalysis => 'សន្សំសំចៃពេលវេលាលើការវិភាគ';

  @override
  String get saveTimeOnAnalysisDesc =>
      'មិនបាច់ចំណាយពេលច្រើនម៉ោងក្នុងការអានតារាងទេ។ ទទួលបានយុទ្ធសាស្រ្តវិនិយោគតាមតម្រូវការក្នុងរយៈពេលត្រឹមតែប៉ុន្មាននាទីក្នុងមួយថ្ងៃ។';

  @override
  String get minimizeEmotionalTrading => 'កាត់បន្ថយការជួញដូរដោយអារម្មណ៍';

  @override
  String get minimizeEmotionalTradingDesc =>
      'ជាមួយនឹងការជូនដំណឹងឆ្លាតវៃ ការរកឃើញហានិភ័យ និងសញ្ញាផ្អែកលើទិន្នន័យ មិនមែនអារម្មណ៍ អ្នកនៅតែមានវិន័យ និងគ្រប់គ្រងរាល់ការសម្រេចចិត្ត។';

  @override
  String get seizeEveryOpportunity => 'ចាប់យកគ្រប់ឱកាស';

  @override
  String get seizeEveryOpportunityDesc =>
      'ការអាប់ដេតយុទ្ធសាស្រ្តទាន់ពេលវេលាដែលត្រូវបានផ្ញើដោយផ្ទាល់ទៅប្រអប់សំបុត្ររបស់អ្នកធានាថាអ្នកជិះនិន្នាការទីផ្សារនៅពេលដ៏ល្អឥតខ្ចោះ។';

  @override
  String get minvestAiCoreValueTitle => 'Signal GPT - តម្លៃស្នូល';

  @override
  String get minvestAiCoreValueDesc =>
      'AI វិភាគទិន្នន័យទីផ្សារតាមពេលវេលាជាក់ស្តែងជាបន្តបន្ទាប់ ដោយត្រងការយល់ដឹងដើម្បីកំណត់អត្តសញ្ញាណឱកាសវិនិយោគលឿន និងត្រឹមត្រូវ';

  @override
  String get frequentlyAskedQuestions => 'សំណួរដែលសួរញឹកញាប់ (FAQ)';

  @override
  String get faqSubtitle =>
      'សំណួររបស់អ្នកទាំងអស់ — ពីរបៀបចូលរួម អត្ថប្រយោជន៍ ដល់របៀបដែល AI របស់យើងដំណើរការ — ត្រូវបានឆ្លើយនៅខាងក្រោម។ ប្រសិនបើអ្នកនៅតែមានចម្ងល់ សូមផ្ញើសារមកយើងតាម Whatsapp';

  @override
  String get maximizeResultsTitle =>
      'បង្កើនលទ្ធផលរបស់អ្នកជាមួយ Signal GPT\nការវិភាគទីផ្សារកម្រិតខ្ពស់ និងសញ្ញាដែលបានត្រងយ៉ាងជាក់លាក់';

  @override
  String get elevateTradingWithAiStrategies =>
      'លើកកម្ពស់ការជួញដូររបស់អ្នកជាមួយនឹងយុទ្ធសាស្រ្តដែលបានកែលម្អដោយ AI ដែលបង្កើតឡើងសម្រាប់ភាពស្ថិតស្ថេរ និងភាពច្បាស់លាស់';

  @override
  String get winMoreWithAiSignalsTitle =>
      'ឈ្នះកាន់តែច្រើនជាមួយសញ្ញាដែលដំណើរការដោយ AI\nនៅគ្រប់ទីផ្សារ';

  @override
  String get winMoreWithAiSignalsDesc =>
      'AI ពហុទីផ្សាររបស់យើងស្កេន Forex, Crypto និងលោហៈតាមពេលវេលាជាក់ស្តែង\nផ្តល់សញ្ញាជួញដូរដែលបានផ្ទៀងផ្ទាត់ដោយអ្នកជំនាញ —\nជាមួយនឹងកម្រិតចូល, stop-loss និង take-profit ច្បាស់លាស់';

  @override
  String get buyLimit => 'Buy limit';

  @override
  String get sellLimit => 'Sell limit';

  @override
  String get smarterToolsTitle =>
      'ឧបករណ៍ឆ្លាតវៃជាងមុន - ការវិនិយោគល្អប្រសើរជាងមុន';

  @override
  String get smarterToolsDesc =>
      'ស្វែងយល់ពីលក្ខណៈពិសេសដែលជួយអ្នកកាត់បន្ថយហានិភ័យ ចាប់យកឱកាស និងបង្កើនទ្រព្យសម្បត្តិរបស់អ្នក';

  @override
  String get performanceOverviewTitle => 'ទិដ្ឋភាពទូទៅនៃការអនុវត្ត';

  @override
  String get performanceOverviewDesc =>
      'AI ពហុទីផ្សាររបស់យើងស្កេន Forex, Crypto និងលោហៈតាមពេលវេលាជាក់ស្តែង ផ្តល់សញ្ញាជួញដូរដែលបានផ្ទៀងផ្ទាត់ដោយអ្នកជំនាញ - ជាមួយនឹងកម្រិតចូល, stop-loss និង take-profit ច្បាស់លាស់';

  @override
  String get totalProfit => 'ប្រាក់ចំណេញសរុប';

  @override
  String get completionSignal => 'សញ្ញាបញ្ចប់';

  @override
  String get onDemandFinancialExpertTitle =>
      'អ្នកជំនាញហិរញ្ញវត្ថុតាមតម្រូវការរបស់អ្នក';

  @override
  String get onDemandFinancialExpertDesc =>
      'វេទិកា AI ណែនាំសញ្ញាជួញដូរ - ស្វ័យសិក្សា វិភាគទីផ្សារ 24/7 មិនរងផលប៉ះពាល់ដោយអារម្មណ៍។ Minvest បានគាំទ្រអ្នកវិភាគហិរញ្ញវត្ថុជាង 10,000 នាក់ក្នុងដំណើរស្វែងរកសញ្ញាត្រឹមត្រូវ ស្ថិរភាព និងងាយស្រួលអនុវត្ត';

  @override
  String get aiPoweredSignalPlatform => 'វេទិកាសញ្ញាជួញដូរដែលដំណើរការដោយ AI';

  @override
  String get selfLearningSystems =>
      'ប្រព័ន្ធស្វ័យសិក្សា ការយល់ដឹងកាន់តែច្បាស់ ការជួញដូរកាន់តែរឹងមាំ';

  @override
  String get emotionlessExecution =>
      'ការអនុវត្តដោយគ្មានអារម្មណ៍សម្រាប់ការជួញដូរដ៏ឆ្លាតវៃ និងមានវិន័យជាងមុន';

  @override
  String get analysingMarket247 => 'វិភាគទីផ្សារ 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'បង្កើនលទ្ធផលរបស់អ្នកជាមួយ Signal GPT\nការវិភាគទីផ្សារកម្រិតខ្ពស់ និងសញ្ញាដែលបានត្រងយ៉ាងជាក់លាក់';

  @override
  String get minvestAiRegistrationDesc =>
      'ការចុះឈ្មោះ Signal GPT ឥឡូវនេះបានបើកហើយ — កន្លែងអាចនឹងបិទក្នុងពេលឆាប់ៗនេះ នៅពេលយើងពិនិត្យ និងអនុម័តសមាជិកថ្មី';

  @override
  String get currencyPairs => 'ទំនិញ';

  @override
  String get allCurrencyPairs => 'គូរូបិយប័ណ្ណទាំងអស់';

  @override
  String get allCommodities => 'ទំនិញទាំងអស់';

  @override
  String get allCryptoPairs => 'គូ Crypto ទាំងអស់';

  @override
  String get dateRange => 'ជួរកាលបរិច្ឆេទ';

  @override
  String get selectDateRange => 'ជ្រើសរើសជួរកាលបរិច្ឆេទ';

  @override
  String get allAssets => 'ទ្រព្យសម្បត្តិទាំងអស់';

  @override
  String get asset => 'ទ្រព្យសម្បត្តិ';

  @override
  String get tokenExpired => 'Token បានផុតកំណត់';

  @override
  String get tokenLimitReachedDesc =>
      'អ្នកបានប្រើប្រាស់ Token ឥតគិតថ្លៃចំនួន 10 របស់អ្នកនៅថ្ងៃនេះហើយ។ ដំឡើងកញ្ចប់របស់អ្នកដើម្បីមើលសញ្ញាបន្ថែម។';

  @override
  String get later => 'ពេលក្រោយ';

  @override
  String get created => 'បានបង្កើត';

  @override
  String get detail => 'លម្អិត';

  @override
  String get performanceOverview => 'ទិដ្ឋភាពទូទៅនៃការអនុវត្ត';

  @override
  String get totalProfitPips => 'ប្រាក់ចំណេញសរុប (Pips)';

  @override
  String get winRatePercent => 'អត្រាឈ្នះ (%)';

  @override
  String get comingSoon => 'នឹងមកដល់ឆាប់ៗនេះ';

  @override
  String get errorLoadingHistory => 'កំហុសក្នុងការផ្ទុកប្រវត្តិ';

  @override
  String get noHistoryAvailable => 'មិនមានប្រវត្តិសញ្ញាទេ';

  @override
  String get previous => 'មុន';

  @override
  String get page => 'ទំព័រ';

  @override
  String get next => 'បន្ទាប់';

  @override
  String get date => 'កាលបរិច្ឆេទ';

  @override
  String get timeGmt7 => 'ម៉ោង';

  @override
  String get orders => 'ការបញ្ជាទិញ';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      'អេក្រង់តូច៖ បង្វិលផ្ដេក ឬរមូរផ្ដេកដើម្បីមើលតារាងពេញ។';

  @override
  String get history => 'ប្រវត្តិ';

  @override
  String get signalsWillAppearHere => 'សញ្ញានឹងបង្ហាញនៅទីនេះនៅពេលមាន';

  @override
  String get pricing => 'តម្លៃ';

  @override
  String get choosePlanSubtitle => 'ជ្រើសរើសផែនការដែលសមនឹងអ្នក';

  @override
  String get financialNewsHub => 'មជ្ឈមណ្ឌលព័ត៌មានហិរញ្ញវត្ថុ';

  @override
  String get financialNewsHubDesc =>
      'បច្ចុប្បន្នភាពសំខាន់ៗ។ ប្រតិកម្មទីផ្សារ។ គ្មានសំលេងរំខាន – គ្រាន់តែជាអ្វីដែលវិនិយោគិនត្រូវដឹង។';

  @override
  String get newsTabAllArticles => 'អត្ថបទទាំងអស់';

  @override
  String get newsTabInvestor => 'វិនិយោគិន';

  @override
  String get newsTabKnowledge => 'ចំណេះដឹង';

  @override
  String get newsTabTechnicalAnalysis => 'ការវិភាគបច្ចេកទេស';

  @override
  String noArticlesForCategory(Object category) {
    return 'មិនមានអត្ថបទសម្រាប់ប្រភេទ $category ទេ';
  }

  @override
  String get mostPopular => 'ពេញនិយមបំផុត';

  @override
  String get noPosts => 'គ្មានការបង្ហោះ';

  @override
  String get relatedArticles => 'អត្ថបទពាក់ព័ន្ធ';

  @override
  String get contactInfoSentSuccess =>
      'ព័ត៌មានទំនាក់ទំនងត្រូវបានផ្ញើដោយជោគជ័យ។';

  @override
  String contactInfoSentFailed(Object error) {
    return 'បរាជ័យក្នុងការផ្ញើព័ត៌មាន៖ $error';
  }

  @override
  String get contactPageSubtitle =>
      'មានសំណួរ ឬត្រូវការដំណោះស្រាយ AI? ប្រាប់យើងដោយបំពេញទម្រង់បែបបទ ហើយយើងនឹងទាក់ទងទៅ!';

  @override
  String get phone => 'ទូរស័ព្ទ';

  @override
  String get firstName => 'នាមខ្លួន';

  @override
  String get enterFirstName => 'បញ្ចូលនាមខ្លួន';

  @override
  String get lastName => 'នាមត្រកូល';

  @override
  String get enterLastName => 'បញ្ចូលនាមត្រកូល';

  @override
  String get whatAreYourConcerns => 'តើកង្វល់របស់អ្នកគឺជាអ្វី?';

  @override
  String get writeConcernsHere => 'សរសេរកង្វល់នៅទីនេះ...';

  @override
  String pleaseEnter(Object field) {
    return 'សូមបញ្ចូល $field';
  }

  @override
  String get faqQuestion1 => 'តើសញ្ញាធានាអត្រាជោគជ័យ 100% ដែរឬទេ?';

  @override
  String get faqAnswer1 =>
      'ខណៈពេលដែលគ្មានសញ្ញាណាមួយអាចត្រូវបានធានា 100%, Signal GPT ខិតខំរក្សាអត្រាជោគជ័យដែលមានស្ថេរភាព 60–80% ដោយមានការគាំទ្រពីការវិភាគលម្អិត និងការគ្រប់គ្រងហានិភ័យ ដើម្បីឱ្យអ្នកអាចធ្វើការសម្រេចចិត្តចុងក្រោយដោយទំនុកចិត្តកាន់តែខ្លាំង។';

  @override
  String get faqQuestion2 =>
      'ប្រសិនបើខ្ញុំមិនចង់ដាក់ប្រាក់ភ្លាមៗទេ តើខ្ញុំនៅតែអាចទទួលបានការណែនាំអំពីសញ្ញាបានទេ?';

  @override
  String get faqAnswer2 =>
      'នៅពេលបើកគណនី ប្រព័ន្ធនឹងផ្តល់ជូនអ្នកនូវ Token ឥតគិតថ្លៃចំនួន 10 ដែលស្មើនឹងការមើលសញ្ញាលម្អិតចំនួន 10 ។ បន្ទាប់ពីនោះ អ្នកនឹងទទួលបាន 1 Token បន្ថែមជារៀងរាល់ថ្ងៃដើម្បីប្រើប្រាស់។ ប្រសិនបើអ្នកដំឡើងទៅគណនី VIP អ្នកនឹងដោះសោមុខងារកម្រិតខ្ពស់ជាច្រើន និងតាមដានការបញ្ជាទិញគ្មានដែនកំណត់។';

  @override
  String get faqQuestion3 =>
      'ប្រសិនបើខ្ញុំបានចុះឈ្មោះ ប៉ុន្តែមិនបានទទួលសញ្ញាណាមួយទេ តើខ្ញុំគួរធ្វើដូចម្តេច?';

  @override
  String get faqAnswer3 =>
      'ការដំណើរការជាធម្មតាគឺដោយស្វ័យប្រវត្តិ។ ប្រសិនបើអ្នកនៅតែមិនឃើញការណែនាំអំពីសញ្ញា សូមទាក់ទងមកយើងខ្ញុំតាមរយៈ Whatsapp សម្រាប់ការជំនួយភ្លាមៗ។';

  @override
  String get faqQuestion4 =>
      'តើខ្ញុំនឹងទទួលបានសញ្ញាប៉ុន្មានក្នុងមួយថ្ងៃនៅពេលដំឡើងទៅគណនី VIP?';

  @override
  String get faqAnswer4 =>
      'នៅពេលដំឡើងទៅគណនី VIP អ្នកនឹងទទួលបានសញ្ញាជួញដូរគ្មានដែនកំណត់ជារៀងរាល់ថ្ងៃ។ ចំនួនសញ្ញាមិនត្រូវបានកំណត់ទេ ប៉ុន្តែអាស្រ័យទាំងស្រុងលើការវិភាគទីផ្សារ។ នៅពេលណាដែលមានចំណុចចូលដែលមានគុណភាពខ្ពស់ និងប្រូបាប៊ីលីតេខ្ពស់លេចឡើង ក្រុមអ្នកវិភាគនឹងផ្ញើសញ្ញាទៅអ្នកភ្លាមៗ។';

  @override
  String get priceLevels => 'កម្រិតតម្លៃ';

  @override
  String get capitalManagement => 'ការគ្រប់គ្រងដើមទុន';

  @override
  String freeSignalsLeft(Object count) {
    return 'នៅសល់ $count សញ្ញាឥតគិតថ្លៃ';
  }

  @override
  String get unlimitedSignals => 'សញ្ញាគ្មានដែនកំណត់';

  @override
  String get goBack => 'ត្រឡប់ក្រោយ';

  @override
  String get goldPlan => 'ផែនការ Gold';

  @override
  String get perMonth => '/ ខែ';

  @override
  String get continuouslyUpdating =>
      'ធ្វើបច្ចុប្បន្នភាពទិន្នន័យទីផ្សារជាបន្តបន្ទាប់ 24/7';

  @override
  String get providingBestSignals => 'ផ្តល់សញ្ញាល្អបំផុតតាមពេលវេលាជាក់ស្តែង';

  @override
  String get includesEntrySlTp => 'រួមបញ្ចូល Entry, SL, TP';

  @override
  String get detailedAnalysis => 'ការវិភាគលម្អិត និងការវាយតម្លៃនៃសញ្ញានីមួយៗ';

  @override
  String get realTimeNotifications => 'ការជូនដំណឹងតាមពេលវេលាជាក់ស្តែងតាមអ៊ីមែល';

  @override
  String get signalPerformanceStats => 'ស្ថិតិការអនុវត្តសញ្ញា';

  @override
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails => 'លេខចុះបញ្ជីអាជីវកម្ម៖ 0110057263';

  @override
  String get addressDetails =>
      'អាសយដ្ឋាន៖ លេខ 8 ផ្លូវ Do Hanh សង្កាត់ Hai Ba Trung ទីក្រុងហាណូយ ប្រទេសវៀតណាម';

  @override
  String get pagesTitle => 'ទំព័រ';

  @override
  String get legalRegulatoryTitle => 'ច្បាប់ និងបទប្បញ្ញត្តិ';

  @override
  String get termsOfRegistration => 'លក្ខខណ្ឌនៃការចុះឈ្មោះ';

  @override
  String get operatingPrinciples => 'គោលការណ៍ប្រតិបត្តិការ';

  @override
  String get termsConditions => 'លក្ខខណ្ឌ និងការកំណត់';

  @override
  String get contactTitle => 'ទំនាក់ទំនង';

  @override
  String get navFeatures => 'លក្ខណៈពិសេស';

  @override
  String get navNews => 'ព័ត៌មាន';

  @override
  String get tp1Hit => 'TP1 Hit';

  @override
  String get tp2Hit => 'TP2 Hit';

  @override
  String get tp3Hit => 'TP3 Hit';

  @override
  String get slHit => 'SL Hit';

  @override
  String get cancelled => 'បានលុបចោល';

  @override
  String get exitedByAdmin => 'បានចេញដោយ Admin';

  @override
  String get signalClosed => 'បានបិទ';

  @override
  String get errorLoadingPackages => 'កំហុសក្នុងការផ្ទុកកញ្ចប់';

  @override
  String get monthly => 'ប្រចាំខែ';

  @override
  String get annually => 'ប្រចាំឆ្នាំ';

  @override
  String get whatsIncluded => 'អ្វីដែលរួមបញ្ចូល៖';

  @override
  String get chooseThisPlan => 'ជ្រើសរើសផែនការនេះ';

  @override
  String get bestPricesForPremiumAccess =>
      'តម្លៃល្អបំផុតសម្រាប់ការចូលប្រើកម្រិតខ្ពស់';

  @override
  String get choosePlanFitsNeeds =>
      'ជ្រើសរើសផែនការដែលសមនឹងតម្រូវការអាជីវកម្មរបស់អ្នក ហើយចាប់ផ្តើមស្វ័យប្រវត្តិកម្មជាមួយ AI';

  @override
  String get save50Percent => 'សន្សំ 50%';

  @override
  String get tryDemo => 'សាកល្បង Demo';

  @override
  String get pleaseEnterEmailPassword => 'សូមបញ្ចូលអ៊ីមែល និងពាក្យសម្ងាត់';

  @override
  String loginFailed(String error) {
    return 'ការចូលបានបរាជ័យ៖ $error';
  }

  @override
  String get welcomeBack => 'ស្វាគមន៍ការត្រឡប់មកវិញ';

  @override
  String get signInToContinue => 'ចូលគណនីរបស់អ្នកដើម្បីបន្ត';

  @override
  String get or => 'ឬ';

  @override
  String get email => 'អ៊ីមែល';

  @override
  String get emailHint => 'example123@gmail.com';

  @override
  String get password => 'ពាក្យសម្ងាត់';

  @override
  String get enterPassword => 'បញ្ចូលពាក្យសម្ងាត់';

  @override
  String get forgotPassword => 'ភ្លេចពាក្យសម្ងាត់របស់អ្នក?';

  @override
  String get createNewAccount => 'បង្កើតគណនីថ្មីនៅទីនេះ!';

  @override
  String get signUp => 'ចុះឈ្មោះ';

  @override
  String get signUpAccount => 'ចុះឈ្មោះគណនី';

  @override
  String get enterPersonalData =>
      'បញ្ចូលទិន្នន័យផ្ទាល់ខ្លួនរបស់អ្នកដើម្បីបង្កើតគណនីរបស់អ្នក';

  @override
  String get nameLabel => 'ឈ្មោះ *';

  @override
  String get enterNameHint => 'បញ្ចូលឈ្មោះ';

  @override
  String get emailLabel => 'អ៊ីមែល *';

  @override
  String get passwordLabel => 'ពាក្យសម្ងាត់ *';

  @override
  String get phoneLabel => 'ទូរស័ព្ទ';

  @override
  String get continueButton => 'បន្ត';

  @override
  String get fillAllFields => 'សូមបំពេញវាលដែលត្រូវការទាំងអស់។';

  @override
  String get accountCreatedSuccess => 'គណនីត្រូវបានបង្កើតដោយជោគជ័យ។';

  @override
  String signUpFailed(String error) {
    return 'ការចុះឈ្មោះបានបរាជ័យ៖ $error';
  }

  @override
  String get nationality => 'សញ្ជាតិ៖';

  @override
  String get overview => 'ទិដ្ឋភាពទូទៅ';

  @override
  String get setting => 'ការកំណត់';

  @override
  String get paymentHistory => 'ប្រវត្តិការទូទាត់';

  @override
  String get signalsPlan => 'ផែនការសញ្ញា';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => 'Tokens របស់អ្នក';

  @override
  String get emailNotificationPreferences => 'ចំណូលចិត្តការជូនដំណឹងតាមអ៊ីមែល';

  @override
  String get chooseSignalNotificationTypes =>
      'ជ្រើសរើសប្រភេទនៃការជូនដំណឹងសញ្ញាដែលអ្នកចង់ទទួលបានតាមអ៊ីមែល';

  @override
  String get allSignalNotifications => 'ការជូនដំណឹងសញ្ញាទាំងអស់';

  @override
  String get cryptoSignals => 'សញ្ញា Crypto';

  @override
  String get forexSignals => 'សញ្ញា Forex';

  @override
  String get goldSignals => 'សញ្ញា Gold';

  @override
  String get updatePasswordSecure =>
      'ធ្វើបច្ចុប្បន្នភាពពាក្យសម្ងាត់របស់អ្នកដើម្បីរក្សាគណនីរបស់អ្នកឱ្យមានសុវត្ថិភាព';

  @override
  String get searchLabel => 'ស្វែងរក៖';

  @override
  String get filterBy => 'ត្រងដោយ៖';

  @override
  String get allTime => 'គ្រប់ពេល';

  @override
  String get startDate => 'កាលបរិច្ឆេទចាប់ផ្តើម៖';

  @override
  String get endDate => 'កាលបរិច្ឆេទបញ្ចប់៖';

  @override
  String get deactivate => 'បិទដំណើរការ';

  @override
  String get unlimited => 'គ្មានដែនកំណត់';

  @override
  String get tenLeft => 'នៅសល់ 10';

  @override
  String get termsOfRegistrationContent =>
      'Please read all the terms and agreements below carefully before proceeding with the next steps in our system.\nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\n1. Introduction and Scope of Application\n\nThis policy regulates the collection, use, sharing, and protection of users’ personal information when accessing and using the products and services of the Signal GPT system – a technology and artificial intelligence platform owned and operated by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED (hereinafter referred to as “we” or “us”).\nBy registering an account or using Signal GPT’s products, you agree that such action constitutes a legally binding commitment between you and us, equivalent to an electronic contract.\n\n2. Account Registration\n\nTo access and use certain services on Signal GPT, you must register a valid account.\nWhen registering, you are required to provide complete and accurate personal information, including your full name, email address, phone number, or any other information as requested.\nAfter registration, you must confirm your email to activate the account. All notifications about your account, promotions, or system updates will be sent to this email address.\nIf the information you provide is inaccurate or incomplete, you will be solely responsible for any incidents or damages arising from it.\n\n3. Terms of Use\n\nWhen participating in the Signal GPT system, you are obligated to comply with all of the following:\nThe operating principles of the platform;\nPayment terms;\nPersonal data privacy policy;\nRelevant laws and regulations in effect.\nIn the event of a violation, EZTRADE reserves the right to temporarily suspend or permanently delete your account, and may transfer the case to competent authorities if necessary.\n\n4. Personal Data Privacy Policy\n\n4.1. Purpose and Scope of ... [truncated]';

  @override
  String get operatingPrinciplesContent =>
      'Please read all terms and agreements below carefully before proceeding with the next steps in our system. \nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\nOPERATING RULES\n\n1. Legal Information\n\nSystem Owner:\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness/Tax Code: 0110057263\nPhone: 0862 600 626\n\n2. Scope of Application\n\nThese Operating Principles apply to all users, learners, partners, and collaborators who participate in or use the products and services within the Signal GPT system, including websites, applications, training platforms, and other online channels managed by EZTRADE.\nBy registering an account or using the services of Signal GPT, users are deemed to have read, understood, and agreed to all the terms set forth in these regulations.\n\n3. Definitions\n\n“Signal GPT” refers to the technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED.\n“Customer” / “User” / “Learner” refers to any individual or organization that registers, accesses, or uses the services and products on the Signal GPT system.\n“We” / “Administration” refers to the management team representing EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED, responsible for operating and managing the system.\n“Products” / “Services” include learning packages, analytical newsletters, AI trading signals, analytical tools, or any digital content provided by Signal GPT.\n\n4. Usage Rules and Information Security\n\nUsers must provide accurate and complete information when registering an account.\nSignal GPT is committed to protecting personal information and will not disclose it to third parties unless required by competent authorities.\nUsers are responsible for maintaining the confidentiality of their account and pa... [truncated]';

  @override
  String get termsAndConditionsContent =>
      'By opening an account to participate in the Signal GPT system, you confirm that you have read, understood, and agreed to all the contents of these Account Opening Terms and Conditions.\nThe latest updates (if any) will be published here, and Signal GPT will not send separate notifications to each customer. Therefore, please visit this page regularly to stay informed about the most recent policies.\n\n1. General Agreement\n\nSignal GPT is a technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED. By opening an account on this system, you agree to participate in and use the services and products provided by EZTRADE.\nAccount registration and activation are considered an electronic contract between you and Signal GPT, which has the same legal validity as a civil contract under the laws of Vietnam.\n\n2. Personal Account Information and Privacy\n\n2.1. Purpose and Scope of Information Collection\n\nTo access and use certain Signal GPT services, you must provide basic personal information, including:\nFull name;\nEmail address;\nContact phone number;\nOther information (if any) necessary for verification, support, or access authorization.\nAll information provided must be accurate, truthful, and lawful. Signal GPT shall not be responsible for any losses or disputes arising from false, missing, or fraudulent information provided by the user.\nAdditionally, the system may automatically collect certain technical data, such as:\nIP address, browser type, and language used;\nAccess time and pages viewed within the system.\nThis information helps Signal GPT improve performance, enhance security, and optimize user experience.\n\n2.2. Scope of Information Use\n\nYour personal information is collected and used for legitimate purposes, including:\nManaging accounts, verifying users, and maintaining services;\nSending notifications related to services, accounts, promotions, or policy changes;\nProv... [truncated]';

  @override
  String get performance => 'ការអនុវត្ត';

  @override
  String get minvestSupport => 'SignalGpt Support';

  @override
  String get leaveMessagePart1 =>
      ' សូមទុកសារ ក្រុមការងាររបស់យើងនឹងឆ្លើយតបក្នុងពេលឆាប់ៗនេះ។ អ្នកក៏អាចទាក់ទង ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 សម្រាប់ការគាំទ្ររហ័ស។';

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
  String get signInRequired => 'តម្រូវឱ្យចូល';

  @override
  String get signInToExploreSignal => 'ចូលដើម្បីរុករកសញ្ញាជួញដូរនេះ!';

  @override
  String get activeMember => 'សមាជិកសកម្ម';

  @override
  String get last7Days => '៧ ថ្ងៃចុងក្រោយ';

  @override
  String get last14Days => '១៤ ថ្ងៃចុងក្រោយ';

  @override
  String get last30Days => '៣០ ថ្ងៃចុងក្រោយ';

  @override
  String get last90Days => '៩០ ថ្ងៃចុងក្រោយ';

  @override
  String get profitStatistics => 'ស្ថិតិប្រាក់ចំណេញ';

  @override
  String get winrateOfAllSignals => 'អត្រាឈ្នះនៃសញ្ញាទាំងអស់';

  @override
  String get daily => 'ប្រចាំថ្ងៃ';

  @override
  String get weekly => 'ប្រចាំសប្តាហ៍';

  @override
  String get lossRate => 'អត្រាខាតបង់';

  @override
  String get signalProgress => 'Signal Progress';

  @override
  String get statusHistory => 'Status History';

  @override
  String get signalCreated => 'Signal Created';

  @override
  String get signalMatched => 'សញ្ញាត្រូវគ្នា';

  @override
  String get targetReached => 'បានដល់គោលដៅ';

  @override
  String get freeSignalsInfo => 'ព័ត៌មានសញ្ញាឥតគិតថ្លៃ';

  @override
  String get freeSignalsInfoDesc =>
      'អ្នកនឹងទទួលបានសញ្ញាឥតគិតថ្លៃ ១ ក្នុងមួយថ្ងៃ។\nសញ្ញាដែលមិនបានប្រើនឹងត្រូវបូកសរុបទៅថ្ងៃបន្ទាប់។';

  @override
  String freeSignalsCount(int count) {
    return '$count សញ្ញាឥតគិតថ្លៃ';
  }

  @override
  String get close => 'បិទ';

  @override
  String validUntil(String date) {
    return 'សុពលភាពរហូតដល់ $date';
  }

  @override
  String get wins => 'ឈ្នះ';

  @override
  String get losses => 'ចាញ់';

  @override
  String totalOrdersCount(int count) {
    return 'សរុប: $count ការបញ្ជាទិញ';
  }

  @override
  String get passwordResetEmailSent =>
      'អ៊ីមែលសម្រាប់កំណត់ពាក្យសម្ងាត់ឡើងវិញត្រូវបានផ្ញើហើយ! សូមពិនិត្យមើលប្រអប់សំបុត្ររបស់អ្នក។';

  @override
  String get pageOf => '/';

  @override
  String get keyFindings => 'Key Findings';

  @override
  String get filterStatusLabel => 'Status';

  @override
  String get filterStatusAll => 'All Status';

  @override
  String get filterStatusTp1 => 'TP1 HIT';

  @override
  String get filterStatusTp2 => 'TP2 HIT';

  @override
  String get filterStatusTp3 => 'TP3 HIT';

  @override
  String get filterStatusSl => 'SL HIT';

  @override
  String get filterStatusCancelled => 'CANCELLED';

  @override
  String get filterStatusExitByAdmin => 'EXIT BY ADMIN';

  @override
  String get popupMasterMarket => 'Do you want to master the market?';

  @override
  String get popupLoginExplore => 'Log in to explore this trading bulletin!';
}
