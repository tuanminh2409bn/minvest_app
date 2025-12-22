// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'อัปเกรดบัญชีสำเร็จ';

  @override
  String get lotPerWeek => 'ล็อต/สัปดาห์';

  @override
  String get tableValueFull => 'เต็มรูปแบบ';

  @override
  String get tableValueFulltime => 'เต็มเวลา';

  @override
  String get packageTitle => 'แพ็คเกจ';

  @override
  String get duration1Month => '1 เดือน';

  @override
  String get duration12Months => '12 เดือน';

  @override
  String get featureReceiveAllSignals => 'รับสัญญาณทั้งหมดของวัน';

  @override
  String get featureAnalyzeReason => 'วิเคราะห์เหตุผลในการเข้าออเดอร์';

  @override
  String get featureHighPrecisionAI => 'สัญญาณ AI ความแม่นยำสูง';

  @override
  String get iapStoreNotAvailable => 'ร้านค้าไม่พร้อมใช้งานบนอุปกรณ์นี้';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'เกิดข้อผิดพลาดในการโหลดผลิตภัณฑ์: $message';
  }

  @override
  String get iapNoProductsFound =>
      'ไม่พบผลิตภัณฑ์ โปรดตรวจสอบการกำหนดค่าร้านค้าของคุณ';

  @override
  String iapTransactionError(Object message) {
    return 'ข้อผิดพลาดในการทำธุรกรรม: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'ข้อผิดพลาดในการตรวจสอบ: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'เกิดข้อผิดพลาดที่ไม่ทราบสาเหตุ: $error';
  }

  @override
  String get iapProcessingTransaction => 'กำลังประมวลผลธุรกรรม...';

  @override
  String get orderInfo1Month => 'ชำระค่าแพ็คเกจ Elite 1 เดือน';

  @override
  String get orderInfo12Months => 'ชำระค่าแพ็คเกจ Elite 12 เดือน';

  @override
  String get iapNotSupportedOnWeb => 'การซื้อในแอปไม่รองรับบนเวอร์ชันเว็บ';

  @override
  String get vnpayPaymentTitle => 'การชำระเงิน VNPAY';

  @override
  String get creatingOrderWait => 'กำลังสร้างคำสั่งซื้อ โปรดรอสักครู่...';

  @override
  String errorWithMessage(Object message) {
    return 'ข้อผิดพลาด: $message';
  }

  @override
  String get cannotConnectToServer =>
      'ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ โปรดลองอีกครั้ง';

  @override
  String get transactionCancelledOrFailed => 'ธุรกรรมถูกยกเลิกหรือล้มเหลว';

  @override
  String get cannotCreatePaymentLink =>
      'ไม่สามารถสร้างลิงก์การชำระเงินได้\nลองอีกครั้ง';

  @override
  String get retry => 'ลองใหม่';

  @override
  String serverErrorRetry(Object message) {
    return 'ข้อผิดพลาดของเซิร์ฟเวอร์: $message โปรดลองอีกครั้ง';
  }

  @override
  String get redirectingToPayment =>
      'กำลังเปลี่ยนเส้นทางไปที่หน้าการชำระเงิน...';

  @override
  String get invalidPaymentUrl =>
      'ได้รับ URL การชำระเงินที่ไม่ถูกต้องจากเซิร์ฟเวอร์';

  @override
  String get processingYourAccount => 'กำลังประมวลผลบัญชีของคุณ...';

  @override
  String get verificationFailed => 'การตรวจสอบล้มเหลว!';

  @override
  String get reuploadImage => 'อัปโหลดรูปภาพใหม่';

  @override
  String get accountNotLinked => 'บัญชีไม่ได้เชื่อมโยงกับ Minvest';

  @override
  String get accountNotLinkedDesc =>
      'เพื่อรับสัญญาณพิเศษ บัญชี Exness ของคุณต้องลงทะเบียนผ่านลิงก์พันธมิตรของ Minvest โปรดสร้างบัญชีใหม่โดยใช้ลิงก์ด้านล่าง';

  @override
  String get registerExnessViaMinvest => 'ลงทะเบียน Exness ผ่าน Minvest';

  @override
  String get iHaveRegisteredReupload => 'ฉันได้ลงทะเบียนแล้ว อัปโหลดใหม่';

  @override
  String couldNotLaunch(Object url) {
    return 'ไม่สามารถเปิด $url';
  }

  @override
  String get status => 'สถานะ';

  @override
  String get sentOn => 'ส่งเมื่อ';

  @override
  String get entryPrice => 'ราคาเข้า';

  @override
  String get stopLossFull => 'จุดตัดขาดทุน';

  @override
  String get takeProfitFull1 => 'จุดทำกำไร 1';

  @override
  String get takeProfitFull2 => 'จุดทำกำไร 2';

  @override
  String get takeProfitFull3 => 'จุดทำกำไร 3';

  @override
  String get noReasonProvided => 'ไม่มีเหตุผลสำหรับสัญญาณนี้';

  @override
  String get upgradeToViewReason =>
      'อัปเกรดบัญชีของคุณเป็น Elite เพื่อดูการวิเคราะห์';

  @override
  String get upgradeToViewFullAnalysis => 'อัปเกรดเพื่อดูการวิเคราะห์ฉบับเต็ม';

  @override
  String get welcomeTo => 'ยินดีต้อนรับสู่';

  @override
  String get appSlogan => 'ยกระดับการเทรดของคุณด้วยสัญญาณอัจฉริยะ';

  @override
  String get signIn => 'ลงชื่อเข้าใช้';

  @override
  String get continueByGoogle => 'ดำเนินการต่อด้วย Google';

  @override
  String get continueByFacebook => 'ดำเนินการต่อด้วย Facebook';

  @override
  String get continueByApple => 'ดำเนินการต่อด้วย Apple';

  @override
  String get loginSuccess => 'เข้าสู่ระบบสำเร็จ!';

  @override
  String get live => 'สด';

  @override
  String get end => 'สิ้นสุด';

  @override
  String get symbol => 'สัญลักษณ์';

  @override
  String get aiSignal => 'สัญญาณ AI';

  @override
  String get ruleSignal => 'สัญญาณตามกฎ';

  @override
  String get all => 'ทั้งหมด';

  @override
  String get upgradeToSeeMore => 'อัปเกรดเพื่อดูเพิ่มเติม';

  @override
  String get seeDetails => 'ดูรายละเอียด';

  @override
  String get notMatched => 'ไม่ตรงกัน';

  @override
  String get matched => 'ตรงกัน';

  @override
  String get entry => 'เข้า';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'อัปเกรด';

  @override
  String get upgradeAccount => 'อัปเกรดบัญชี';

  @override
  String get compareTiers => 'เปรียบเทียบระดับ';

  @override
  String get feature => 'ฟีเจอร์';

  @override
  String get tierDemo => 'Demo';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'ยอดคงเหลือ';

  @override
  String get signalTime => 'เวลาสัญญาณ';

  @override
  String get signalQty => 'จำนวนสัญญาณ';

  @override
  String get analysis => 'การวิเคราะห์';

  @override
  String get openExnessAccount => 'เปิดบัญชี Exness!';

  @override
  String get accountVerificationWithExness => 'การตรวจสอบบัญชีกับ Exness';

  @override
  String get payInAppToUpgrade => 'ชำระเงินในแอปเพื่ออัปเกรด';

  @override
  String get bankTransferToUpgrade => 'โอนเงินผ่านธนาคารเพื่ออัปเกรด';

  @override
  String get accountVerification => 'การตรวจสอบบัญชี';

  @override
  String get accountVerificationPrompt =>
      'โปรดอัปโหลดภาพหน้าจอของบัญชี Exness ของคุณเพื่อรับการอนุมัติ (บัญชีของคุณต้องเปิดภายใต้ลิงก์ Exness ของ Minvest)';

  @override
  String get selectPhotoFromLibrary => 'เลือกรูปภาพจากคลังภาพ';

  @override
  String get send => 'ส่ง';

  @override
  String get accountInfo => 'ข้อมูลบัญชี';

  @override
  String get accountVerifiedSuccessfully => 'ตรวจสอบบัญชีสำเร็จ';

  @override
  String get yourAccountIs => 'บัญชีของคุณคือ';

  @override
  String get returnToHomePage => 'กลับสู่หน้าหลัก';

  @override
  String get upgradeFailed => 'อัปเกรดล้มเหลว! โปรดอัปโหลดรูปภาพใหม่';

  @override
  String get package => 'แพ็คเกจ';

  @override
  String get startNow => 'รับสัญญาณทันที';

  @override
  String get bankTransfer => 'โอนเงินผ่านธนาคาร';

  @override
  String get transferInformation => 'ข้อมูลการโอนเงิน';

  @override
  String get scanForFastTransfer => 'สแกนเพื่อโอนเงินด่วน';

  @override
  String get contactUs247 => 'ติดต่อเรา 24/7';

  @override
  String get newAnnouncement => 'ประกาศใหม่';

  @override
  String get profile => 'โปรไฟล์';

  @override
  String get upgradeNow => 'อัปเกรดทันที';

  @override
  String get followMinvest => 'ติดตาม MInvest';

  @override
  String get tabSignal => 'สัญญาณ';

  @override
  String get tabChart => 'กราฟ';

  @override
  String get tabProfile => 'โปรไฟล์';

  @override
  String get reason => 'เหตุผล';

  @override
  String get error => 'ข้อผิดพลาด';

  @override
  String get noSignalsAvailable => 'ไม่มีสัญญาณที่พร้อมใช้งาน';

  @override
  String get outOfGoldenHours => 'อยู่นอกช่วงเวลาทอง';

  @override
  String get outOfGoldenHoursVipDesc =>
      'สัญญาณ VIP ให้บริการตั้งแต่ 8:00 น. ถึง 17:00 น. (GMT+7)\nอัปเกรดเป็น Elite เพื่อรับสัญญาณตลอด 24 ชม.!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'สัญญาณ Demo ให้บริการตั้งแต่ 8:00 น. ถึง 17:00 น. (GMT+7)\nอัปเกรดบัญชีของคุณเพื่อรับสิทธิประโยชน์เพิ่มเติม!';

  @override
  String get yourName => 'ชื่อของคุณ';

  @override
  String get yourEmail => 'your.email@example.com';

  @override
  String get adminPanel => 'แผงผู้ดูแลระบบ';

  @override
  String get logout => 'ออกจากระบบ';

  @override
  String get confirmLogout => 'ยืนยันการออกจากระบบ';

  @override
  String get confirmLogoutMessage => 'คุณแน่ใจหรือไม่ว่าต้องการออกจากระบบ?';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get upgradeCardTitle => 'อัปเกรดบัญชีของคุณ';

  @override
  String get upgradeCardSubtitle => 'เพื่อเข้าถึงทรัพยากรเพิ่มเติม';

  @override
  String get upgradeCardSubtitleWeb =>
      'เพื่อปลดล็อกสัญญาณพรีเมียมและการสนับสนุนเต็มเวลา';

  @override
  String get subscriptionDetails => 'รายละเอียดการสมัครสมาชิก';

  @override
  String get notifications => 'การแจ้งเตือน';

  @override
  String get continueAsGuest => 'ดำเนินการต่อในฐานะแขก';

  @override
  String get deleteAccount => 'ลบบัญชี';

  @override
  String get deleteAccountWarning =>
      'คุณแน่ใจหรือไม่ว่าต้องการลบบัญชีของคุณ? ข้อมูลทั้งหมดของคุณจะถูกลบอย่างถาวรและไม่สามารถกู้คืนได้';

  @override
  String get delete => 'ลบ';

  @override
  String get privacyPolicy => 'นโยบายความเป็นส่วนตัว';

  @override
  String get termsOfService => 'เงื่อนไขการให้บริการ';

  @override
  String get signalStatusMatched => 'ตรงกัน';

  @override
  String get signalStatusNotMatched => 'ไม่ตรงกัน';

  @override
  String get signalStatusCancelled => 'ยกเลิก';

  @override
  String get signalStatusSlHit => 'ชน SL';

  @override
  String get signalStatusTp1Hit => 'ชน TP1';

  @override
  String get signalStatusTp2Hit => 'ชน TP2';

  @override
  String get signalStatusTp3Hit => 'ชน TP3';

  @override
  String get signalStatusRunning => 'กำลังดำเนินการ';

  @override
  String get signalStatusClosed => 'ปิดแล้ว';

  @override
  String get contactUs => 'ติดต่อเรา';

  @override
  String get tabChat => 'แชท';

  @override
  String get exnessUpgradeNoteForIos =>
      'สำหรับลูกค้าที่ลงทะเบียนบัญชี Exness ผ่าน Minvest โปรดคลิกติดต่อเราเพื่อทำการอัปเกรดบัญชี';

  @override
  String get chatWelcomeTitle => '👋 ยินดีต้อนรับสู่ Minvest AI!';

  @override
  String get chatWelcomeBody1 =>
      'โปรดฝากข้อความไว้ ทีมงานของเราจะตอบกลับโดยเร็วที่สุด';

  @override
  String get chatWelcomeBody2 => 'หรือติดต่อเราโดยตรงผ่าน Zalo/WhatsApp: ';

  @override
  String get chatWelcomeBody3 => ' เพื่อการสนับสนุนที่รวดเร็วยิ่งขึ้น!';

  @override
  String get chatLoginPrompt => 'โปรดเข้าสู่ระบบเพื่อใช้ฟีเจอร์นี้';

  @override
  String get chatStartConversation => 'เริ่มการสนทนาของคุณ';

  @override
  String get chatNoMessages => 'ยังไม่มีข้อความ';

  @override
  String get chatTypeMessage => 'พิมพ์ข้อความ...';

  @override
  String get chatSupportIsTyping => 'ฝ่ายสนับสนุนกำลังพิมพ์...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName กำลังพิมพ์...';
  }

  @override
  String get chatSeen => 'อ่านแล้ว';

  @override
  String get chatDefaultUserName => 'ผู้ใช้';

  @override
  String get chatDefaultSupportName => 'ฝ่ายสนับสนุน';

  @override
  String get signalEntry => 'จุดเข้า';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      'สำหรับเทรดเดอร์ต่างชาติ โปรดติดต่อเราผ่าน WhatsApp (+84969.15.6969) เพื่อขอความช่วยเหลือ';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails => 'อัปเกรดเพื่อดูรายละเอียดสัญญาณ...';

  @override
  String get buy => 'ซื้อ';

  @override
  String get sell => 'ขาย';

  @override
  String get logoutDialogTitle => 'เซสชันหมดอายุ';

  @override
  String get logoutDialogDefaultReason =>
      'บัญชีของคุณมีการเข้าสู่ระบบบนอุปกรณ์อื่น';

  @override
  String get ok => 'ตกลง';

  @override
  String get contactToUpgrade => 'ติดต่อเพื่ออัปเกรด';

  @override
  String get noNotificationsYet => 'ยังไม่มีการแจ้งเตือน';

  @override
  String daysAgo(int count) {
    return '$count วันที่แล้ว';
  }

  @override
  String hoursAgo(int count) {
    return '$count ชั่วโมงที่แล้ว';
  }

  @override
  String minutesAgo(int count) {
    return '$count นาทีที่แล้ว';
  }

  @override
  String get justNow => 'เมื่อสักครู่';

  @override
  String get getSignalsNow => 'รับสัญญาณทันที';

  @override
  String get freeTrial => 'ทดลองใช้ฟรี';

  @override
  String get heroTitle => 'นำทางเทรดเดอร์ & เติบโตพอร์ตการลงทุน';

  @override
  String get heroSubtitle =>
      'เครื่องมือ AI ขั้นสูงสุด – ออกแบบโดยเทรดเดอร์ผู้เชี่ยวชาญ';

  @override
  String get globalAiInnovationTitle =>
      'นวัตกรรม AI ระดับโลกสำหรับระบบอัจฉริยะการเทรดยุคใหม่';

  @override
  String get globalAiInnovationDesc =>
      'พลิกโฉมการเทรดแบบดั้งเดิมด้วยสัญญาณ AI บนคลาวด์ — ปรับตัวตามข่าวสารและแนวโน้มตลาดแบบเรียลไทม์\nเพื่อประสิทธิภาพที่รวดเร็ว แม่นยำยิ่งขึ้น และปราศจากอารมณ์';

  @override
  String get liveTradingSignalsTitle => 'สด – สัญญาณการเทรด AI ตลอด 24/7';

  @override
  String get liveTradingSignalsDesc =>
      'การวิเคราะห์บนคลาวด์แบบเรียลไทม์ที่มอบกลยุทธ์ตามแนวโน้มที่มีโอกาสสูง ด้วยความแม่นยำที่ปรับเปลี่ยนได้และการดำเนินการที่ปราศจากอารมณ์';

  @override
  String get trendFollowing => 'ตามแนวโน้ม';

  @override
  String get realtime => 'เรียลไทม์';

  @override
  String get orderExplanationEngineTitle => 'เครื่องมืออธิบายคำสั่งซื้อ';

  @override
  String get orderExplanationEngineDesc =>
      'อธิบายการตั้งค่าการเทรดด้วยคำศัพท์ง่ายๆ — แสดงให้เห็นว่าจุดบรรจบก่อตัวอย่างไร ทำไมถึงเข้าออเดอร์ และช่วยให้เทรดเดอร์เรียนรู้จากการตัดสินใจแต่ละครั้ง';

  @override
  String get transparent => 'โปร่งใส';

  @override
  String get educational => 'เพื่อการศึกษา';

  @override
  String get logical => 'มีเหตุผล';

  @override
  String get transparentRealPerformanceTitle => 'โปร่งใส - ผลงานจริง';

  @override
  String get transparentRealPerformanceDesc =>
      'ดูข้อมูลจริงเกี่ยวกับความแม่นยำของสัญญาณ อัตราความสำเร็จ และความสามารถในการทำกำไร — ตรวจสอบและติดตามได้ในทุกการเทรด';

  @override
  String get results => 'ผลลัพธ์';

  @override
  String get performanceTracking => 'การติดตามผลงาน';

  @override
  String get accurate => 'แม่นยำ';

  @override
  String get predictiveAccuracy => 'ความแม่นยำในการคาดการณ์';

  @override
  String get improvementInProfitability => 'การปรับปรุงความสามารถในการทำกำไร';

  @override
  String get improvedRiskManagement => 'การจัดการความเสี่ยงที่ดียิ่งขึ้น';

  @override
  String get signalsPerformanceTitle => 'ผลงานของสัญญาณ';

  @override
  String get riskToRewardRatio => 'อัตราส่วนความเสี่ยงต่อผลตอบแทน';

  @override
  String get howRiskComparesToReward =>
      'เปรียบเทียบความเสี่ยงกับผลตอบแทนอย่างไร';

  @override
  String get profitLossOverview => 'ภาพรวมกำไร/ขาดทุน';

  @override
  String get netGainVsLoss => 'กำไรสุทธิเทียบกับขาดทุน';

  @override
  String get winRate => 'อัตราการชนะ';

  @override
  String get percentageOfWinningTrades => 'เปอร์เซ็นต์ของการเทรดที่ชนะ';

  @override
  String get accuracyRate => 'อัตราความแม่นยำ';

  @override
  String get howPreciseOurSignalsAre => 'สัญญาณของเราแม่นยำแค่ไหน';

  @override
  String get realtimeMarketAnalysis => 'การวิเคราะห์ตลาดแบบเรียลไทม์';

  @override
  String get realtimeMarketAnalysisDesc =>
      'AI ของเราตรวจสอบตลาดอย่างต่อเนื่อง ระบุโซนบรรจบทางเทคนิคและจุดเบรกเอาต์ที่เชื่อถือได้ เพื่อให้คุณสามารถเข้าเทรดได้ในจังหวะที่เหมาะสม';

  @override
  String get saveTimeOnAnalysis => 'ประหยัดเวลาในการวิเคราะห์';

  @override
  String get saveTimeOnAnalysisDesc =>
      'ไม่ต้องเสียเวลาหลายชั่วโมงในการอ่านกราฟ รับกลยุทธ์การลงทุนที่ปรับแต่งมาโดยเฉพาะในเวลาเพียงไม่กี่นาทีต่อวัน';

  @override
  String get minimizeEmotionalTrading => 'ลดการเทรดด้วยอารมณ์';

  @override
  String get minimizeEmotionalTradingDesc =>
      'ด้วยการแจ้งเตือนอัจฉริยะ การตรวจจับความเสี่ยง และสัญญาณที่ขับเคลื่อนด้วยข้อมูลไม่ใช่อารมณ์ คุณจะมีวินัยและควบคุมทุกการตัดสินใจได้';

  @override
  String get seizeEveryOpportunity => 'คว้าทุกโอกาส';

  @override
  String get seizeEveryOpportunityDesc =>
      'การอัปเดตกลยุทธ์ที่ทันท่วงทีส่งตรงถึงกล่องจดหมายของคุณ เพื่อให้มั่นใจว่าคุณเกาะติดแนวโน้มตลาดในเวลาที่สมบูรณ์แบบ';

  @override
  String get minvestAiCoreValueTitle => 'Minvest AI - ค่านิยมหลัก';

  @override
  String get minvestAiCoreValueDesc =>
      'AI วิเคราะห์ข้อมูลตลาดแบบเรียลไทม์อย่างต่อเนื่อง กรองข้อมูลเชิงลึกเพื่อระบุโอกาสการลงทุนที่รวดเร็วและแม่นยำ';

  @override
  String get frequentlyAskedQuestions => 'คำถามที่พบบ่อย (FAQ)';

  @override
  String get faqSubtitle =>
      'ทุกคำถามของคุณ — ตั้งแต่วิธีเข้าร่วม ประโยชน์ ไปจนถึงวิธีทำงานของ AI — มีคำตอบอยู่ด้านล่าง หากคุณยังมีข้อสงสัยใดๆ สามารถส่งข้อความหาเราได้ทาง Whatsapp';

  @override
  String get maximizeResultsTitle =>
      'เพิ่มผลลัพธ์ของคุณให้สูงสุดด้วย Minvest AI\nการวิเคราะห์ตลาดขั้นสูงและสัญญาณที่ผ่านการกรองอย่างแม่นยำ';

  @override
  String get elevateTradingWithAiStrategies =>
      'ยกระดับการเทรดของคุณด้วยกลยุทธ์ที่เสริมด้วย AI ที่สร้างขึ้นเพื่อความสม่ำเสมอและความชัดเจน';

  @override
  String get winMoreWithAiSignalsTitle =>
      'ชนะมากขึ้นด้วยสัญญาณพลัง AI\nในทุกตลาด';

  @override
  String get winMoreWithAiSignalsDesc =>
      'AI หลายตลาดของเราสแกน Forex, Crypto และโลหะมีค่าแบบเรียลไทม์\nส่งมอบสัญญาณการเทรดที่ตรวจสอบโดยผู้เชี่ยวชาญ —\nพร้อมระดับจุดเข้า จุดตัดขาดทุน และจุดทำกำไรที่ชัดเจน';

  @override
  String get buyLimit => 'Buy limit';

  @override
  String get sellLimit => 'Sell limit';

  @override
  String get smarterToolsTitle => 'เครื่องมือที่ฉลาดกว่า - การลงทุนที่ดีกว่า';

  @override
  String get smarterToolsDesc =>
      'ค้นพบฟีเจอร์ที่ช่วยลดความเสี่ยง คว้าโอกาส และสร้างความมั่งคั่งของคุณ';

  @override
  String get performanceOverviewTitle => 'ภาพรวมผลงาน';

  @override
  String get performanceOverviewDesc =>
      'AI หลายตลาดของเราสแกน Forex, Crypto และโลหะมีค่าแบบเรียลไทม์ ส่งมอบสัญญาณการเทรดที่ตรวจสอบโดยผู้เชี่ยวชาญ - พร้อมระดับจุดเข้า จุดตัดขาดทุน และจุดทำกำไรที่ชัดเจน';

  @override
  String get totalProfit => 'กำไรทั้งหมด';

  @override
  String get completionSignal => 'สัญญาณที่เสร็จสมบูรณ์';

  @override
  String get onDemandFinancialExpertTitle =>
      'ผู้เชี่ยวชาญทางการเงินส่วนตัวของคุณ';

  @override
  String get onDemandFinancialExpertDesc =>
      'แพลตฟอร์ม AI แนะนำสัญญาณการเทรด - เรียนรู้ด้วยตนเอง วิเคราะห์ตลาดตลอด 24/7 ไม่ได้รับผลกระทบจากอารมณ์ Minvest ได้สนับสนุนนักวิเคราะห์ทางการเงินกว่า 10,000 คน\nในการเดินทางเพื่อค้นหาสัญญาณที่แม่นยำ เสถียร และใช้งานง่าย';

  @override
  String get aiPoweredSignalPlatform => 'แพลตฟอร์มสัญญาณการเทรดพลัง AI';

  @override
  String get selfLearningSystems =>
      'ระบบเรียนรู้ด้วยตนเอง ข้อมูลเชิงลึกที่เฉียบคม การเทรดที่แข็งแกร่งขึ้น';

  @override
  String get emotionlessExecution =>
      'การดำเนินการที่ไร้อารมณ์ เพื่อการเทรดที่ฉลาดยิ่งขึ้น\nและมีวินัยมากขึ้น';

  @override
  String get analysingMarket247 => 'วิเคราะห์ตลาดตลอด 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'เพิ่มผลลัพธ์ของคุณให้สูงสุดด้วย Minvest AI\nการวิเคราะห์ตลาดขั้นสูงและสัญญาณที่ผ่านการกรองอย่างแม่นยำ';

  @override
  String get minvestAiRegistrationDesc =>
      'การลงทะเบียน Minvest AI เปิดให้ลงทะเบียนแล้ว — ที่นั่งอาจเต็มเร็วๆ นี้เนื่องจากเราตรวจสอบและอนุมัติสมาชิกใหม่';

  @override
  String get currencyPairs => 'สินค้าโภคภัณฑ์';

  @override
  String get allCurrencyPairs => 'คู่สกุลเงินทั้งหมด';

  @override
  String get allCommodities => 'สินค้าโภคภัณฑ์ทั้งหมด';

  @override
  String get allCryptoPairs => 'คู่สกุลเงินดิจิทัลทั้งหมด';

  @override
  String get dateRange => 'ช่วงวันที่';

  @override
  String get selectDateRange => 'เลือกช่วงวันที่';

  @override
  String get allAssets => 'สินทรัพย์ทั้งหมด';

  @override
  String get asset => 'สินทรัพย์';

  @override
  String get tokenExpired => 'โทเค็นหมดอายุ';

  @override
  String get tokenLimitReachedDesc =>
      'คุณใช้โทเค็นฟรี 10 เหรียญสำหรับวันนี้หมดแล้ว อัปเกรดแพ็คเกจของคุณเพื่อดูสัญญาณเพิ่มเติม';

  @override
  String get later => 'ภายหลัง';

  @override
  String get created => 'สร้างเมื่อ';

  @override
  String get detail => 'รายละเอียด';

  @override
  String get performanceOverview => 'ภาพรวมผลงาน';

  @override
  String get totalProfitPips => 'กำไรทั้งหมด (Pips)';

  @override
  String get winRatePercent => 'อัตราการชนะ (%)';

  @override
  String get comingSoon => 'เร็วๆ นี้';

  @override
  String get errorLoadingHistory => 'ข้อผิดพลาดในการโหลดประวัติ';

  @override
  String get noHistoryAvailable => 'ไม่มีประวัติสัญญาณ';

  @override
  String get previous => 'ก่อนหน้า';

  @override
  String get page => 'หน้า';

  @override
  String get next => 'ถัดไป';

  @override
  String get date => 'วันที่';

  @override
  String get timeGmt7 => 'เวลา (GMT)';

  @override
  String get orders => 'คำสั่ง';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      'หน้าจอขนาดเล็ก: หมุนแนวนอนหรือเลื่อนในแนวนอนเพื่อดูตารางเต็ม';

  @override
  String get history => 'ประวัติ';

  @override
  String get signalsWillAppearHere => 'สัญญาณจะปรากฏที่นี่เมื่อพร้อมใช้งาน';

  @override
  String get pricing => 'ราคา';

  @override
  String get choosePlanSubtitle => 'เลือกแผนที่เหมาะกับคุณ';

  @override
  String get financialNewsHub => 'ศูนย์ข่าวการเงิน';

  @override
  String get financialNewsHubDesc =>
      'อัปเดตสำคัญ ปฏิกิริยาของตลาด ไม่มีสิ่งรบกวน – มีเพียงสิ่งที่นักลงทุนจำเป็นต้องรู้';

  @override
  String get newsTabAllArticles => 'บทความทั้งหมด';

  @override
  String get newsTabInvestor => 'นักลงทุน';

  @override
  String get newsTabKnowledge => 'ความรู้';

  @override
  String get newsTabTechnicalAnalysis => 'การวิเคราะห์ทางเทคนิค';

  @override
  String noArticlesForCategory(Object category) {
    return 'ไม่มีบทความสำหรับหมวดหมู่ $category';
  }

  @override
  String get mostPopular => 'ยอดนิยมที่สุด';

  @override
  String get noPosts => 'ไม่มีโพสต์';

  @override
  String get relatedArticles => 'บทความที่เกี่ยวข้อง';

  @override
  String get contactInfoSentSuccess => 'ส่งข้อมูลการติดต่อสำเร็จ';

  @override
  String contactInfoSentFailed(Object error) {
    return 'ส่งข้อมูลไม่สำเร็จ: $error';
  }

  @override
  String get contactPageSubtitle =>
      'มีคำถามหรือต้องการโซลูชัน AI? แจ้งให้เราทราบโดยกรอกแบบฟอร์ม แล้วเราจะติดต่อกลับ!';

  @override
  String get phone => 'โทรศัพท์';

  @override
  String get firstName => 'ชื่อจริง';

  @override
  String get enterFirstName => 'กรอกชื่อจริง';

  @override
  String get lastName => 'นามสกุล';

  @override
  String get enterLastName => 'กรอกนามสกุล';

  @override
  String get whatAreYourConcerns => 'ข้อกังวลของคุณคืออะไร?';

  @override
  String get writeConcernsHere => 'เขียนข้อกังวลที่นี่...';

  @override
  String pleaseEnter(Object field) {
    return 'โปรดระบุ $field';
  }

  @override
  String get faqQuestion1 => 'สัญญาณรับประกันความสำเร็จ 100% หรือไม่?';

  @override
  String get faqAnswer1 =>
      'แม้ว่าจะไม่มีสัญญาณใดที่รับประกันได้ 100% แต่ Minvest AI มุ่งมั่นที่จะรักษาอัตราความสำเร็จให้คงที่ที่ 60–80% โดยได้รับการสนับสนุนจากการวิเคราะห์โดยละเอียดและการจัดการความเสี่ยง เพื่อให้คุณสามารถตัดสินใจขั้นสุดท้ายได้อย่างมั่นใจยิ่งขึ้น';

  @override
  String get faqQuestion2 =>
      'หากฉันไม่ต้องการฝากเงินทันที ฉันยังสามารถรับคำแนะนำสัญญาณได้หรือไม่?';

  @override
  String get faqAnswer2 =>
      'เมื่อเปิดบัญชี ระบบจะมอบโทเค็นฟรี 10 เหรียญให้คุณ เทียบเท่ากับการดูสัญญาณโดยละเอียด 10 ครั้ง หลังจากนั้น คุณจะได้รับโทเค็นเพิ่มเติม 1 เหรียญทุกวันเพื่อใช้งาน หากคุณอัปเกรดเป็นบัญชี VIP คุณจะปลดล็อกฟีเจอร์ขั้นสูงมากมายและติดตามคำสั่งซื้อได้ไม่จำกัดจำนวน';

  @override
  String get faqQuestion3 =>
      'หากฉันลงทะเบียนแล้วแต่ไม่ได้รับสัญญาณใดๆ ฉันควรทำอย่างไร?';

  @override
  String get faqAnswer3 =>
      'โดยปกติการดำเนินการจะเป็นไปโดยอัตโนมัติ หากคุณยังไม่เห็นคำแนะนำสัญญาณใดๆ โปรดติดต่อเราผ่าน Whatsapp เพื่อขอความช่วยเหลือทันที';

  @override
  String get faqQuestion4 =>
      'ฉันจะได้รับสัญญาณกี่สัญญาณต่อวันเมื่ออัปเกรดเป็นบัญชี VIP?';

  @override
  String get faqAnswer4 =>
      'เมื่ออัปเกรดเป็นบัญชี VIP คุณจะได้รับสัญญาณการเทรดไม่จำกัดจำนวนทุกวัน จำนวนสัญญาณไม่คงที่แต่ขึ้นอยู่กับการวิเคราะห์ตลาดทั้งหมด เมื่อใดก็ตามที่จุดเข้าที่มีคุณภาพและความน่าจะเป็นสูงปรากฏขึ้น ทีมวิเคราะห์จะส่งสัญญาณให้คุณทันที';

  @override
  String get priceLevels => 'ระดับราคา';

  @override
  String get capitalManagement => 'การจัดการเงินทุน';

  @override
  String freeSignalsLeft(Object count) {
    return 'เหลือสัญญาณฟรี $count ครั้ง';
  }

  @override
  String get unlimitedSignals => 'สัญญาณไม่จำกัด';

  @override
  String get goBack => 'ย้อนกลับ';

  @override
  String get goldPlan => 'แผน Gold';

  @override
  String get perMonth => '/ เดือน';

  @override
  String get continuouslyUpdating => 'อัปเดตข้อมูลตลาดอย่างต่อเนื่อง 24/7';

  @override
  String get providingBestSignals => 'ให้บริการสัญญาณที่ดีที่สุดแบบเรียลไทม์';

  @override
  String get includesEntrySlTp => 'รวม Entry, SL, TP';

  @override
  String get detailedAnalysis =>
      'การวิเคราะห์และประเมินผลโดยละเอียดของแต่ละสัญญาณ';

  @override
  String get realTimeNotifications => 'การแจ้งเตือนแบบเรียลไทม์ทางอีเมล';

  @override
  String get signalPerformanceStats => 'สถิติผลงานสัญญาณ';

  @override
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails => 'เลขทะเบียนธุรกิจ: 0110057263';

  @override
  String get addressDetails =>
      'ที่อยู่: เลขที่ 8 ถนนโดฮั่น แขวงไฮบาจุง เขตไฮบาจุง กรุงฮานอย เวียดนาม';

  @override
  String get pagesTitle => 'หน้า';

  @override
  String get legalRegulatoryTitle => 'กฎหมายและระเบียบข้อบังคับ';

  @override
  String get termsOfRegistration => 'ข้อกำหนดการลงทะเบียน';

  @override
  String get operatingPrinciples => 'หลักการดำเนินงาน';

  @override
  String get termsConditions => 'ข้อกำหนดและเงื่อนไข';

  @override
  String get contactTitle => 'ติดต่อ';

  @override
  String get navFeatures => 'ฟีเจอร์';

  @override
  String get navNews => 'ข่าวสาร';

  @override
  String get tp1Hit => 'ชน TP1';

  @override
  String get tp2Hit => 'ชน TP2';

  @override
  String get tp3Hit => 'ชน TP3';

  @override
  String get slHit => 'ชน SL';

  @override
  String get cancelled => 'ยกเลิก';

  @override
  String get exitedByAdmin => 'ปิดโดยแอดมิน';

  @override
  String get signalClosed => 'ปิดแล้ว';

  @override
  String get errorLoadingPackages => 'ข้อผิดพลาดในการโหลดแพ็คเกจ';

  @override
  String get monthly => 'รายเดือน';

  @override
  String get annually => 'รายปี';

  @override
  String get whatsIncluded => 'สิ่งที่รวมอยู่:';

  @override
  String get chooseThisPlan => 'เลือกแผนนี้';

  @override
  String get bestPricesForPremiumAccess =>
      'ราคาที่ดีที่สุดสำหรับการเข้าถึงพรีเมียม';

  @override
  String get choosePlanFitsNeeds =>
      'เลือกแผนที่เหมาะสมกับความต้องการทางธุรกิจของคุณและเริ่มทำกำไรอัตโนมัติด้วย AI';

  @override
  String get save50Percent => 'ประหยัด 50%';

  @override
  String get tryDemo => 'ลอง Demo';

  @override
  String get pleaseEnterEmailPassword => 'โปรดกรอกอีเมลและรหัสผ่าน';

  @override
  String loginFailed(String error) {
    return 'เข้าสู่ระบบล้มเหลว: $error';
  }

  @override
  String get welcomeBack => 'ยินดีต้อนรับกลับ';

  @override
  String get signInToContinue => 'ลงชื่อเข้าใช้บัญชีของคุณเพื่อดำเนินการต่อ';

  @override
  String get or => 'หรือ';

  @override
  String get email => 'อีเมล';

  @override
  String get emailHint => 'example123@gmail.com';

  @override
  String get password => 'รหัสผ่าน';

  @override
  String get enterPassword => 'กรอกรหัสผ่าน';

  @override
  String get forgotPassword => 'ลืมรหัสผ่าน?';

  @override
  String get createNewAccount => 'สร้างบัญชีใหม่ที่นี่!';

  @override
  String get signUp => 'ลงชื่อเข้าใช้';

  @override
  String get signUpAccount => 'สมัครบัญชี';

  @override
  String get enterPersonalData => 'กรอกข้อมูลส่วนตัวของคุณเพื่อสร้างบัญชี';

  @override
  String get nameLabel => 'ชื่อ *';

  @override
  String get enterNameHint => 'กรอกชื่อ';

  @override
  String get emailLabel => 'อีเมล *';

  @override
  String get passwordLabel => 'รหัสผ่าน *';

  @override
  String get phoneLabel => 'โทรศัพท์';

  @override
  String get continueButton => 'ดำเนินการต่อ';

  @override
  String get fillAllFields => 'โปรดกรอกข้อมูลในช่องที่จำเป็นทั้งหมด';

  @override
  String get accountCreatedSuccess => 'สร้างบัญชีสำเร็จ';

  @override
  String signUpFailed(String error) {
    return 'สมัครสมาชิกไม่สำเร็จ: $error';
  }

  @override
  String get nationality => 'สัญชาติ:';

  @override
  String get overview => 'ภาพรวม';

  @override
  String get setting => 'การตั้งค่า';

  @override
  String get paymentHistory => 'ประวัติการชำระเงิน';

  @override
  String get signalsPlan => 'แผนสัญญาณ';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => 'โทเค็นของคุณ';

  @override
  String get emailNotificationPreferences => 'การตั้งค่าการแจ้งเตือนทางอีเมล';

  @override
  String get chooseSignalNotificationTypes =>
      'เลือกประเภทการแจ้งเตือนสัญญาณที่คุณต้องการรับทางอีเมล';

  @override
  String get allSignalNotifications => 'การแจ้งเตือนสัญญาณทั้งหมด';

  @override
  String get cryptoSignals => 'สัญญาณ Crypto';

  @override
  String get forexSignals => 'สัญญาณ Forex';

  @override
  String get goldSignals => 'สัญญาณ Gold';

  @override
  String get updatePasswordSecure =>
      'อัปเดตรหัสผ่านของคุณเพื่อรักษาความปลอดภัยของบัญชี';

  @override
  String get searchLabel => 'ค้นหา:';

  @override
  String get filterBy => 'กรองตาม:';

  @override
  String get allTime => 'ตลอดเวลา';

  @override
  String get startDate => 'วันที่เริ่มต้น:';

  @override
  String get endDate => 'วันที่สิ้นสุด:';

  @override
  String get deactivate => 'ปิดใช้งาน';

  @override
  String get unlimited => 'ไม่จำกัด';

  @override
  String get tenLeft => 'เหลือ 10';

  @override
  String get termsOfRegistrationContent =>
      'Please read all the terms and agreements below carefully before proceeding with the next steps in our system.\nBy registering an account on the mInvest AI system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\n1. Introduction and Scope of Application\n\nThis policy regulates the collection, use, sharing, and protection of users’ personal information when accessing and using the products and services of the mInvest AI system – a technology and artificial intelligence platform owned and operated by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED (hereinafter referred to as “we” or “us”).\nBy registering an account or using mInvest AI’s products, you agree that such action constitutes a legally binding commitment between you and us, equivalent to an electronic contract.\n\n2. Account Registration\n\nTo access and use certain services on mInvest AI, you must register a valid account.\nWhen registering, you are required to provide complete and accurate personal information, including your full name, email address, phone number, or any other information as requested.\nAfter registration, you must confirm your email to activate the account. All notifications about your account, promotions, or system updates will be sent to this email address.\nIf the information you provide is inaccurate or incomplete, you will be solely responsible for any incidents or damages arising from it.\n\n3. Terms of Use\n\nWhen participating in the mInvest AI system, you are obligated to comply with all of the following:\nThe operating principles of the platform;\nPayment terms;\nPersonal data privacy policy;\nRelevant laws and regulations in effect.\nIn the event of a violation, EZTRADE reserves the right to temporarily suspend or permanently delete your account, and may transfer the case to competent authorities if necessary.\n\n4. Personal Data Privacy Policy\n\n4.1. Purpose and Scope of Collection\n\nTo provide its services, mInvest AI collects necessary information including: full name, email, phone number, means of contact, and technical data such as IP address, browser type, access time, language, and accessed pages.\nThis information is used for the following purposes:\nTo verify accounts and manage users;\nTo provide services and customer support;\nTo send notifications, offers, or important updates;\nTo improve system quality and user experience.\nAll declared information must be accurate and lawful. We are not responsible for any disputes or damages resulting from false declarations.\n\n4.2. Scope of Information Use\n\nmInvest AI only uses your personal information for internal purposes and in compliance with Vietnamese laws.\nWe may contact you via email, phone, SMS, or other communication channels for technical support, order confirmation, or promotional updates.\n\n4.3. Data Retention Period\n\nYour personal information will be stored until one of the following occurs:\nYou request account deletion; or\nThe mInvest AI system ceases operation in accordance with regulations.\nDuring this period, your data will be securely protected on EZTRADE’s servers.\n\n4.4. Rights and Obligations of Data Subjects\n\nUser Rights:\nTo be informed of, consent to, or refuse the processing of their personal data;\nTo access, edit, delete, or request restriction of data processing;\nTo object, file complaints, initiate legal proceedings, or request compensation for damages as provided by law.\nUser Obligations:\nTo provide truthful and accurate information;\nTo protect their own personal data and respect the privacy of others;\nTo comply with applicable laws and mInvest AI’s privacy policy.\n\n4.5. Information of the Personal Data Processor\n\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness Registration Number: 0110057263\nPhone: 0862 600 626\n\n4.6. Means and Tools for Editing Information\n\nYou can access the “Account Settings” section to update or edit your personal information.\nIn case you need assistance, you may contact us through the official communication channels of mInvest AI as published on our website.\n\n4.7. Data Protection Measures\n\nmInvest AI applies advanced technical and administrative measures such as:\nData encryption, firewalls, and internal access control;\nLimiting access rights;\nEmployee training on data security.\nAny unauthorized access, disclosure, destruction, or alteration of data will be handled in accordance with the law.\n\n4.8. Entities Authorized to Access Your Information\n\nThe mInvest AI system administration team;\nYou, the customer (when logging into your own account);\nVietnamese legal authorities upon receipt of a valid written request.\n\n4.9. Complaints and Dispute Resolution\n\nAny complaints or feedback related to the protection of personal data or the use of services on the mInvest AI system may be submitted through the official support channels published on our website.\nWe will receive, review, and respond as soon as possible to ensure the lawful rights and interests of customers in accordance with legal regulations.\n\n5. Effectiveness and Updates\n\nThis policy takes effect from November 14, 2025.\nWe may change, update, or supplement this content to comply with legal requirements and operational realities.\nAll changes will be publicly announced on the mInvest.ai website prior to implementation.';

  @override
  String get operatingPrinciplesContent =>
      'Please read all terms and agreements below carefully before proceeding with the next steps in our system. \nBy registering an account on the mInvest AI system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\nOPERATING RULES\n\n1. Legal Information\n\nSystem Owner:\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness/Tax Code: 0110057263\nPhone: 0862 600 626\n\n2. Scope of Application\n\nThese Operating Principles apply to all users, learners, partners, and collaborators who participate in or use the products and services within the mInvest AI system, including websites, applications, training platforms, and other online channels managed by EZTRADE.\nBy registering an account or using the services of mInvest AI, users are deemed to have read, understood, and agreed to all the terms set forth in these regulations.\n\n3. Definitions\n\n“mInvest AI” refers to the technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED.\n“Customer” / “User” / “Learner” refers to any individual or organization that registers, accesses, or uses the services and products on the mInvest AI system.\n“We” / “Administration” refers to the management team representing EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED, responsible for operating and managing the system.\n“Products” / “Services” include learning packages, analytical newsletters, AI trading signals, analytical tools, or any digital content provided by mInvest AI.\n\n4. Usage Rules and Information Security\n\nUsers must provide accurate and complete information when registering an account.\nmInvest AI is committed to protecting personal information and will not disclose it to third parties unless required by competent authorities.\nUsers are responsible for maintaining the confidentiality of their account and password. Any damages arising from personal security negligence shall not be the responsibility of EZTRADE.\nmInvest AI reserves the right to suspend or terminate accounts found to be in violation of the terms, including but not limited to: account sharing, content distribution, or infringement of intellectual property rights.\n\n5. Refund Policy and Service Usage\n\nAll payments, once confirmed, are non-refundable under any circumstances, except in cases of system errors originating from mInvest AI.\nUsers may discontinue service use at any time; however, any paid fees will not be retained or converted.\nmInvest AI reserves the right to adjust service prices, promotional policies, or special offers without prior notice. Users are responsible for regularly reviewing and staying updated.\n\n6. Conduct and Content Usage Regulations\n\nThe following actions are strictly prohibited:\nCopying, downloading, distributing, or sharing content, videos, or materials belonging to the mInvest AI system;\nUsing software or tools to interfere with or illegally collect data;\nImpersonating mInvest AI, EZTRADE, or any of its representatives for the purpose of fraud, deception, or brand defamation;\nSharing accounts with multiple users;\nPosting, speaking, or engaging in actions containing offensive, defamatory, or harmful content toward the system.\nAny violation of the above may result in permanent account suspension and could be subject to legal action under Vietnamese law.\n\n7. Commitment and Limitation of Liability\n\nmInvest AI provides products based on knowledge, data, and AI algorithms developed by the EZTRADE team.\nThe effectiveness of use depends on each individual’s capability, experience, and actions. mInvest AI makes no guarantee of profit or specific investment results.\nEZTRADE shall be exempt from all liability for indirect risks or damages arising during service use, except in cases where direct system errors are proven.\n\n8. Rights of the mInvest AI Administration\n\nmInvest AI reserves the right to modify, update, or supplement the operating terms at any time without prior notice.\nWe have the right to suspend or terminate the provision of services in cases of legal violations, policy breaches, or for technical or system maintenance reasons.\nWe may cooperate with competent authorities in handling complaints, investigating violations, and providing necessary information as required by law.\n\n9. Acknowledgment of Consent\n\nBy registering and using the mInvest AI system, you hereby confirm that:\nYou have read carefully, fully understood, and agreed to all the contents of these Operating Principles;\nYou consent to allow EZTRADE to use your contact information (phone, email, SMS, Zalo, etc.) to send notifications, product updates, promotions, or new program announcements.';

  @override
  String get termsAndConditionsContent =>
      'By registering an account to participate in the mInvest AI system, you confirm that you have read, understood, and agreed to all the contents of these Account Opening Terms and Conditions.\nThe latest updates (if any) will be published here, and mInvest AI will not send separate notifications to each customer. Therefore, please visit this page regularly to stay informed about the most recent policies.\n\n1. General Agreement\n\nmInvest AI is a technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED. By opening an account on this system, you agree to participate in and use the services and products provided by EZTRADE.\nAccount registration and activation are considered an electronic contract between you and mInvest AI, which has the same legal validity as a civil contract under the laws of Vietnam.\n\n2. Personal Account Information and Privacy\n\n2.1. Purpose and Scope of Information Collection\n\nTo access and use certain mInvest AI services, you must provide basic personal information, including:\nFull name;\nEmail address;\nContact phone number;\nOther information (if any) necessary for verification, support, or access authorization.\nAll information provided must be accurate, truthful, and lawful. mInvest AI shall not be responsible for any losses or disputes arising from false, missing, or fraudulent information provided by the user.\nAdditionally, the system may automatically collect certain technical data, such as:\nIP address, browser type, and language used;\nAccess time and pages viewed within the system.\nThis information helps mInvest AI improve performance, enhance security, and optimize user experience.\n\n2.2. Scope of Information Use\n\nYour personal information is collected and used for legitimate purposes, including:\nManaging accounts, verifying users, and maintaining services;\nSending notifications related to services, accounts, promotions, or policy changes;\nProviding technical support, customer service, and dispute resolution (if any);\nData analysis to improve product quality and user experience.\nWe are committed to protecting your personal information and will not share it with third parties unless required by law or competent authorities.\n\n2.3. Data Retention Period\n\nYour information will be stored until one of the following occurs:\nYou request account deletion; or\nThe mInvest AI system ceases operation in accordance with applicable laws.\nIn all cases, your data will be securely stored and strictly protected on EZTRADE’s servers.\n\n2.4. Entity Responsible for Collecting and Managing Personal Information\n\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness Registration Number: 0110057263\n\n2.5. Methods and Tools for Editing Information\n\nYou can access the “Account Settings” section within the system to edit or update your personal information. If you encounter difficulties while doing so, please contact us through the official support channels of mInvest AI as published on the website.\n\n2.6. Information Provision and Verification\n\nTo ensure account security and protect your rights, you must:\nProvide accurate full name, email, and phone number during registration;\nVerify your information via the confirmation email sent by the system;\nReceive activation, password reset, or other important notifications from mInvest AI.\nIf the provided information is inaccurate or incomplete, you shall be solely responsible for any related risks (e.g., account activation failure, loss of access, or missed notifications).\n\n2.7. User Confidentiality Obligations and Responsibilities\n\nYou are responsible for safeguarding your login credentials and password.\nIf your password is lost, disclosed, or accessed without authorization, mInvest AI shall not be liable for any resulting damages.\nYou agree to allow EZTRADE to store, manage, and process your personal information in accordance with the laws of Vietnam.\n\n2.8. Access Rights to Your Information\n\nYour personal information may only be accessed by:\nThe mInvest AI system administration team (for management and technical purposes);\nThe account owner (via the personal information management section);\nVietnamese authorities, upon receipt of a valid and lawful request as prescribed by law.\n\n2.9. Complaint and Resolution Mechanism\n\nFor any complaints or feedback related to account registration, usage, or information security, you may submit a request through the official Contact page of mInvest AI.\nWe will receive, process, and respond as soon as possible to ensure the customer’s lawful rights and interests in accordance with applicable legal regulations.\n\n3. Effectiveness and Updates\n\nThese Account Opening Terms and Conditions take effect from November 14, 2025. mInvest AI reserves the right to update, modify, or supplement the contents at any time without prior notice. All changes will be publicly announced on the mInvest.ai website prior to implementation.';

  @override
  String get performance => 'ผลงาน';

  @override
  String get minvestSupport => 'การสนับสนุน Minvest';

  @override
  String get leaveMessagePart1 =>
      'โปรดฝากข้อความไว้ ทีมงานของเราจะตอบกลับโดยเร็วที่สุด คุณยังสามารถติดต่อ ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 เพื่อการสนับสนุนที่รวดเร็ว';

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
}
