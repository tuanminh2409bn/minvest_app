// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'खाता सफलतापूर्वक अपग्रेड किया गया';

  @override
  String get lotPerWeek => 'लॉट/सप्ताह';

  @override
  String get tableValueFull => 'पूर्ण';

  @override
  String get tableValueFulltime => 'पूर्णकालिक';

  @override
  String get packageTitle => 'पैकेज';

  @override
  String get duration1Month => '1 महीना';

  @override
  String get duration12Months => '12 महीने';

  @override
  String get featureReceiveAllSignals => 'दिन के सभी संकेत प्राप्त करें';

  @override
  String get featureAnalyzeReason => 'ऑर्डर दर्ज करने के कारण का विश्लेषण करें';

  @override
  String get featureHighPrecisionAI => 'उच्च परिशुद्धता AI संकेत';

  @override
  String get iapStoreNotAvailable => 'स्टोर इस डिवाइस पर उपलब्ध नहीं है।';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'उत्पाद लोड करने में त्रुटि: $message';
  }

  @override
  String get iapNoProductsFound =>
      'कोई उत्पाद नहीं मिला। कृपया अपने स्टोर कॉन्फ़िगरेशन की जाँच करें।';

  @override
  String iapTransactionError(Object message) {
    return 'लेनदेन त्रुटि: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'सत्यापन त्रुटि: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'एक अज्ञात त्रुटि हुई: $error';
  }

  @override
  String get iapProcessingTransaction => 'लेनदेन संसाधित हो रहा है...';

  @override
  String get orderInfo1Month => 'एलिट 1 महीने के पैकेज के लिए भुगतान';

  @override
  String get orderInfo12Months => 'एलिट 12 महीने के पैकेज के लिए भुगतान';

  @override
  String get iapNotSupportedOnWeb =>
      'वेब संस्करण पर इन-ऐप खरीदारी समर्थित नहीं है।';

  @override
  String get vnpayPaymentTitle => 'VNPAY भुगतान';

  @override
  String get creatingOrderWait =>
      'ऑर्डर बनाया जा रहा है, कृपया प्रतीक्षा करें...';

  @override
  String errorWithMessage(Object message) {
    return 'त्रुटि: $message';
  }

  @override
  String get cannotConnectToServer =>
      'सर्वर से कनेक्ट नहीं हो सका। कृपया पुनः प्रयास करें।';

  @override
  String get transactionCancelledOrFailed => 'लेनदेन रद्द या विफल हो गया है।';

  @override
  String get cannotCreatePaymentLink =>
      'भुगतान लिंक नहीं बनाया जा सका।\nपुनः प्रयास करें।';

  @override
  String get retry => 'पुनः प्रयास करें';

  @override
  String serverErrorRetry(Object message) {
    return 'सर्वर त्रुटि: $message। कृपया पुनः प्रयास करें।';
  }

  @override
  String get redirectingToPayment =>
      'भुगतान पृष्ठ पर पुनर्निर्देशित किया जा रहा है...';

  @override
  String get invalidPaymentUrl => 'सर्वर से अमान्य भुगतान URL प्राप्त हुआ।';

  @override
  String get processingYourAccount => 'आपके खाते को संसाधित किया जा रहा है...';

  @override
  String get verificationFailed => 'सत्यापन विफल!';

  @override
  String get reuploadImage => 'छवि पुनः अपलोड करें';

  @override
  String get accountNotLinked => 'खाता Minvest से लिंक नहीं है';

  @override
  String get accountNotLinkedDesc =>
      'विशिष्ट संकेत प्राप्त करने के लिए, आपका Exness खाता Minvest भागीदार लिंक के माध्यम से पंजीकृत होना चाहिए। कृपया नीचे दिए गए लिंक का उपयोग करके एक नया खाता बनाएँ।';

  @override
  String get registerExnessViaMinvest =>
      'Minvest के माध्यम से Exness पंजीकृत करें';

  @override
  String get iHaveRegisteredReupload =>
      'मैंने पंजीकरण कर लिया है, पुनः अपलोड करें';

  @override
  String couldNotLaunch(Object url) {
    return '$url लॉन्च नहीं किया जा सका';
  }

  @override
  String get status => 'स्थिति';

  @override
  String get sentOn => 'भेजा गया';

  @override
  String get entryPrice => 'प्रवेश मूल्य';

  @override
  String get stopLossFull => 'स्टॉप लॉस';

  @override
  String get takeProfitFull1 => 'टेक प्रॉफिट 1';

  @override
  String get takeProfitFull2 => 'टेक प्रॉफिट 2';

  @override
  String get takeProfitFull3 => 'टेक प्रॉफिट 3';

  @override
  String get noReasonProvided =>
      'इस संकेत के लिए कोई कारण प्रदान नहीं किया गया।';

  @override
  String get upgradeToViewReason =>
      'विश्लेषण देखने के लिए अपने खाते को एलिट में अपग्रेड करें।';

  @override
  String get upgradeToViewFullAnalysis =>
      'पूर्ण विश्लेषण देखने के लिए अपग्रेड करें';

  @override
  String get welcomeTo => 'स्वागत है';

  @override
  String get appSlogan => 'बुद्धिमान संकेतों के साथ अपने व्यापार को बढ़ाएं।';

  @override
  String get signIn => 'साइन इन करें';

  @override
  String get continueByGoogle => 'Google के साथ जारी रखें';

  @override
  String get continueByFacebook => 'Facebook के साथ जारी रखें';

  @override
  String get continueByApple => 'Apple के साथ जारी रखें';

  @override
  String get loginSuccess => 'लॉगिन सफल!';

  @override
  String get live => 'लाइव';

  @override
  String get end => 'समाप्त';

  @override
  String get symbol => 'प्रतीक';

  @override
  String get aiSignal => 'AI संकेत';

  @override
  String get ruleSignal => 'नियम संकेत';

  @override
  String get all => 'सभी';

  @override
  String get upgradeToSeeMore => 'अधिक देखने के लिए अपग्रेड करें';

  @override
  String get seeDetails => 'विवरण देखें';

  @override
  String get notMatched => 'मेल नहीं खाया';

  @override
  String get matched => 'मेल खाया';

  @override
  String get entry => 'प्रवेश';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'अपग्रेड';

  @override
  String get upgradeAccount => 'खाता अपग्रेड करें';

  @override
  String get compareTiers => 'स्तरों की तुलना करें';

  @override
  String get feature => 'विशेषता';

  @override
  String get tierDemo => 'डेमो';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'एलिट';

  @override
  String get balance => 'शेष राशि';

  @override
  String get signalTime => 'संकेत समय';

  @override
  String get signalQty => 'संकेत मात्रा';

  @override
  String get analysis => 'विश्लेषण';

  @override
  String get openExnessAccount => 'Exness खाता खोलें!';

  @override
  String get accountVerificationWithExness => 'Exness के साथ खाता सत्यापन';

  @override
  String get payInAppToUpgrade => 'अपग्रेड करने के लिए ऐप में भुगतान करें';

  @override
  String get bankTransferToUpgrade => 'अपग्रेड करने के लिए बैंक हस्तांतरण';

  @override
  String get accountVerification => 'खाता सत्यापन';

  @override
  String get accountVerificationPrompt =>
      'अधिकृत होने के लिए कृपया अपने Exness खाते का स्क्रीनशॉट अपलोड करें (आपका खाता Minvest के Exness लिंक के तहत खोला जाना चाहिए)';

  @override
  String get selectPhotoFromLibrary => 'लाइब्रेरी से फोटो चुनें';

  @override
  String get send => 'भेजें';

  @override
  String get accountInfo => 'खाता जानकारी';

  @override
  String get accountVerifiedSuccessfully =>
      'खाता सफलतापूर्वक सत्यापित किया गया';

  @override
  String get yourAccountIs => 'आपका खाता है';

  @override
  String get returnToHomePage => 'होम पेज पर वापस जाएं';

  @override
  String get upgradeFailed => 'अपग्रेड विफल! कृपया छवि पुनः अपलोड करें';

  @override
  String get package => 'पैकेज';

  @override
  String get startNow => 'अभी संकेत प्राप्त करें';

  @override
  String get bankTransfer => 'बैंक हस्तांतरण';

  @override
  String get transferInformation => 'हस्तांतरण जानकारी';

  @override
  String get scanForFastTransfer => 'तेज़ हस्तांतरण के लिए स्कैन करें';

  @override
  String get contactUs247 => 'हमसे 24/7 संपर्क करें';

  @override
  String get newAnnouncement => 'नई घोषणा';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get upgradeNow => 'अभी अपग्रेड करें';

  @override
  String get followMinvest => 'MInvest का पालन करें';

  @override
  String get tabSignal => 'संकेत';

  @override
  String get tabChart => 'चार्ट';

  @override
  String get tabProfile => 'प्रोफ़ाइल';

  @override
  String get reason => 'कारण';

  @override
  String get error => 'त्रुटि';

  @override
  String get noSignalsAvailable => 'कोई संकेत उपलब्ध नहीं है।';

  @override
  String get outOfGoldenHours => 'गोल्डन आवर्स से बाहर';

  @override
  String get outOfGoldenHoursVipDesc =>
      'VIP संकेत सुबह 8:00 बजे से शाम 5:00 बजे (GMT+7) तक उपलब्ध हैं।\n24/24 संकेत प्राप्त करने के लिए एलिट में अपग्रेड करें!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'डेमो संकेत सुबह 8:00 बजे से शाम 5:00 बजे (GMT+7) तक उपलब्ध हैं।\nअधिक लाभ के लिए अपने खाते को अपग्रेड करें!';

  @override
  String get yourName => 'आपका नाम';

  @override
  String get yourEmail => 'your.email@example.com';

  @override
  String get adminPanel => 'एडमिन पैनल';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get confirmLogout => 'लॉग आउट की पुष्टि करें';

  @override
  String get confirmLogoutMessage => 'क्या आप वाकई लॉग आउट करना चाहते हैं?';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get upgradeCardTitle => 'अपने खाते को अपग्रेड करें';

  @override
  String get upgradeCardSubtitle => 'अधिक संसाधनों तक पहुँचने के लिए';

  @override
  String get upgradeCardSubtitleWeb =>
      'प्रीमियम संकेतों और पूर्णकालिक समर्थन को अनलॉक करने के लिए';

  @override
  String get subscriptionDetails => 'सदस्यता विवरण';

  @override
  String get notifications => 'सूचनाएं';

  @override
  String get continueAsGuest => 'अतिथि के रूप में जारी रखें';

  @override
  String get deleteAccount => 'खाता हटाएं';

  @override
  String get deleteAccountWarning =>
      'क्या आप वाकई अपना खाता हटाना चाहते हैं? आपका सारा डेटा स्थायी रूप से मिटा दिया जाएगा और इसे पुनर्प्राप्त नहीं किया जा सकता है।';

  @override
  String get delete => 'हटाएं';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get termsOfService => 'सेवा की शर्तें';

  @override
  String get signalStatusMatched => 'मेल खाया';

  @override
  String get signalStatusNotMatched => 'मेल नहीं खाया';

  @override
  String get signalStatusCancelled => 'रद्द किया गया';

  @override
  String get signalStatusSlHit => 'SL हिट';

  @override
  String get signalStatusTp1Hit => 'TP1 हिट';

  @override
  String get signalStatusTp2Hit => 'TP2 हिट';

  @override
  String get signalStatusTp3Hit => 'TP3 हिट';

  @override
  String get signalStatusRunning => 'चल रहा है';

  @override
  String get signalStatusClosed => 'बंद';

  @override
  String get contactUs => 'हमसे संपर्क करें';

  @override
  String get tabChat => 'चैट';

  @override
  String get exnessUpgradeNoteForIos =>
      'जिन ग्राहकों ने Minvest के माध्यम से Exness खाता पंजीकृत किया है, कृपया अपने खाते को अपग्रेड करने के लिए हमसे संपर्क करें पर क्लिक करें।';

  @override
  String get chatWelcomeTitle => '👋 Minvest AI में आपका स्वागत है!';

  @override
  String get chatWelcomeBody1 =>
      'कृपया एक संदेश छोड़ें, हमारी टीम जल्द से जल्द जवाब देगी।';

  @override
  String get chatWelcomeBody2 =>
      'या सीधे Zalo/WhatsApp के माध्यम से हमसे संपर्क करें: ';

  @override
  String get chatWelcomeBody3 => ' तेज़ समर्थन के लिए!';

  @override
  String get chatLoginPrompt =>
      'इस सुविधा का उपयोग करने के लिए कृपया लॉग इन करें';

  @override
  String get chatStartConversation => 'अपनी बातचीत शुरू करें';

  @override
  String get chatNoMessages => 'अभी तक कोई संदेश नहीं।';

  @override
  String get chatTypeMessage => 'एक संदेश टाइप करें...';

  @override
  String get chatSupportIsTyping => 'समर्थन टाइप कर रहा है...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName टाइप कर रहा है...';
  }

  @override
  String get chatSeen => 'देखा गया';

  @override
  String get chatDefaultUserName => 'उपयोगकर्ता';

  @override
  String get chatDefaultSupportName => 'समर्थन';

  @override
  String get signalEntry => 'प्रवेश';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      'विदेशी व्यापारियों के लिए, कृपया समर्थन के लिए व्हाट्सएप (+84969.15.6969) के माध्यम से हमसे संपर्क करें';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails => 'संकेत विवरण देखने के लिए अपग्रेड करें...';

  @override
  String get buy => 'खरीदें';

  @override
  String get sell => 'बेचें';

  @override
  String get logoutDialogTitle => 'सत्र समाप्त हो गया';

  @override
  String get logoutDialogDefaultReason =>
      'आपका खाता किसी अन्य डिवाइस पर लॉग इन किया गया है।';

  @override
  String get ok => 'ठीक है';

  @override
  String get contactToUpgrade => 'अपग्रेड करने के लिए संपर्क करें';

  @override
  String get noNotificationsYet => 'अभी तक कोई सूचना नहीं।';

  @override
  String daysAgo(int count) {
    return '$count दिन पहले';
  }

  @override
  String hoursAgo(int count) {
    return '$count घंटे पहले';
  }

  @override
  String minutesAgo(int count) {
    return '$count मिनट पहले';
  }

  @override
  String get justNow => 'अभी';

  @override
  String get getSignalsNow => 'अभी संकेत प्राप्त करें';

  @override
  String get freeTrial => 'निःशुल्क परीक्षण';

  @override
  String get heroTitle => 'व्यापारियों का मार्गदर्शन और पोर्टफोलियो बढ़ाना';

  @override
  String get heroSubtitle =>
      'अंतिम AI इंजन - विशेषज्ञ व्यापारियों द्वारा डिज़ाइन किया गया';

  @override
  String get globalAiInnovationTitle =>
      'ट्रेडिंग इंटेलिजेंस की अगली पीढ़ी के लिए वैश्विक AI नवाचार';

  @override
  String get globalAiInnovationDesc =>
      'क्लाउड-पावर्ड AI संकेतों के साथ पारंपरिक ट्रेडिंग को बदलना - तेज़, अधिक सटीक और भावना-मुक्त प्रदर्शन के लिए वास्तविक समय के बाजार समाचार और रुझानों के अनुकूल।';

  @override
  String get liveTradingSignalsTitle => 'लाइव - 24/7 AI ट्रेडिंग संकेत';

  @override
  String get liveTradingSignalsDesc =>
      'अनुकूली परिशुद्धता और भावना-मुक्त निष्पादन के साथ उच्च-संभावना, प्रवृत्ति-अनुसरण रणनीतियों को वितरित करने वाले वास्तविक समय के क्लाउड विश्लेषण।';

  @override
  String get trendFollowing => 'प्रवृत्ति-अनुसरण';

  @override
  String get realtime => 'वास्तविक समय';

  @override
  String get orderExplanationEngineTitle => 'ऑर्डर स्पष्टीकरण इंजन';

  @override
  String get orderExplanationEngineDesc =>
      'सरल शब्दों में व्यापार सेटअप की व्याख्या करता है - यह दर्शाता है कि संगम कैसे बनते हैं, प्रविष्टियां क्यों की जाती हैं, और व्यापारियों को प्रत्येक निर्णय से सीखने में मदद करता है।';

  @override
  String get transparent => 'पारदर्शी';

  @override
  String get educational => 'शैक्षिक';

  @override
  String get logical => 'तार्किक';

  @override
  String get transparentRealPerformanceTitle => 'पारदर्शी - वास्तविक प्रदर्शन';

  @override
  String get transparentRealPerformanceDesc =>
      'संकेत सटीकता, सफलता दर और लाभप्रदता पर वास्तविक डेटा देखें - प्रत्येक व्यापार में सत्यापित और पता लगाने योग्य';

  @override
  String get results => 'परिणाम';

  @override
  String get performanceTracking => 'प्रदर्शन-ट्रैकिंग';

  @override
  String get accurate => 'सटीक';

  @override
  String get predictiveAccuracy => 'भविष्यवाणी सटीकता';

  @override
  String get improvementInProfitability => 'लाभप्रदता में सुधार';

  @override
  String get improvedRiskManagement => 'बेहतर जोखिम प्रबंधन';

  @override
  String get signalsPerformanceTitle => 'संकेत प्रदर्शन';

  @override
  String get riskToRewardRatio => 'जोखिम-से-इनाम अनुपात';

  @override
  String get howRiskComparesToReward => 'जोखिम इनाम की तुलना कैसे करता है';

  @override
  String get profitLossOverview => 'लाभ/हानि अवलोकन';

  @override
  String get netGainVsLoss => 'शुद्ध लाभ बनाम हानि';

  @override
  String get winRate => 'जीत दर';

  @override
  String get percentageOfWinningTrades => 'जीतने वाले ट्रेडों का प्रतिशत';

  @override
  String get accuracyRate => 'सटीकता दर';

  @override
  String get howPreciseOurSignalsAre => 'हमारे संकेत कितने सटीक हैं';

  @override
  String get realtimeMarketAnalysis => 'वास्तविक समय बाजार विश्लेषण';

  @override
  String get realtimeMarketAnalysisDesc =>
      'हमारा AI लगातार बाजार की निगरानी करता है, तकनीकी अभिसरण क्षेत्रों और विश्वसनीय ब्रेकआउट बिंदुओं की पहचान करता है ताकि आप सही समय पर ट्रेडों में प्रवेश कर सकें।';

  @override
  String get saveTimeOnAnalysis => 'विश्लेषण पर समय बचाएं';

  @override
  String get saveTimeOnAnalysisDesc =>
      'चार्ट पढ़ने में और घंटे नहीं बिताने होंगे। बस दिन में कुछ ही मिनटों में अनुरूप निवेश रणनीतियाँ प्राप्त करें।';

  @override
  String get minimizeEmotionalTrading => 'भावनात्मक ट्रेडिंग को कम करें';

  @override
  String get minimizeEmotionalTradingDesc =>
      'स्मार्ट अलर्ट, जोखिम का पता लगाने और डेटा-संचालित संकेतों (भावनाओं नहीं) के साथ, आप अनुशासित रहते हैं और हर निर्णय के नियंत्रण में रहते हैं।';

  @override
  String get seizeEveryOpportunity => 'हर अवसर का लाभ उठाएं';

  @override
  String get seizeEveryOpportunityDesc =>
      'सीधे आपके इनबॉक्स में दी जाने वाली समय पर रणनीति अपडेट सुनिश्चित करती है कि आप सही समय पर बाजार के रुझानों की सवारी करें।';

  @override
  String get minvestAiCoreValueTitle => 'Minvest AI - मुख्य मूल्य';

  @override
  String get minvestAiCoreValueDesc =>
      'AI लगातार वास्तविक समय के बाजार डेटा का विश्लेषण करता है, तेज, सटीक निवेश के अवसरों की पहचान करने के लिए अंतर्दृष्टि को फ़िल्टर करता है';

  @override
  String get frequentlyAskedQuestions => 'अक्सर पूछे जाने वाले प्रश्न (FAQ)';

  @override
  String get faqSubtitle =>
      'आपके सभी प्रश्न - शामिल होने के तरीके से लेकर, लाभों तक, हमारा AI कैसे काम करता है - नीचे उत्तर दिए गए हैं। यदि आपको अभी भी कोई संदेह है, तो बेझिझक हमें व्हाट्सएप पर संदेश भेजें';

  @override
  String get maximizeResultsTitle =>
      'Minvest AI उन्नत बाजार विश्लेषण और सटीक-फ़िल्टर किए गए संकेतों के साथ अपने परिणामों को अधिकतम करें';

  @override
  String get elevateTradingWithAiStrategies =>
      'स्थिरता और स्पष्टता के लिए तैयार की गई AI-संवर्धित रणनीतियों के साथ अपने व्यापार को बढ़ाएं';

  @override
  String get winMoreWithAiSignalsTitle =>
      'हर बाजार में AI-संचालित संकेतों के साथ अधिक जीतें';

  @override
  String get winMoreWithAiSignalsDesc =>
      'हमारा मल्टी-मार्केट AI वास्तविक समय में विदेशी मुद्रा, क्रिप्टो और धातुओं को स्कैन करता है,\nविशेषज्ञ-मान्य ट्रेडिंग संकेत प्रदान करता है —\nस्पष्ट प्रविष्टि, स्टॉप-लॉस और टेक-प्रॉफिट स्तरों के साथ';

  @override
  String get buyLimit => 'खरीद सीमा';

  @override
  String get sellLimit => 'बिक्री सीमा';

  @override
  String get smarterToolsTitle => 'होशियार उपकरण - बेहतर निवेश';

  @override
  String get smarterToolsDesc =>
      'उन विशेषताओं की खोज करें जो आपको जोखिमों को कम करने, अवसरों को भुनाने और अपनी संपत्ति बढ़ाने में मदद करती हैं';

  @override
  String get performanceOverviewTitle => 'प्रदर्शन अवलोकन';

  @override
  String get performanceOverviewDesc =>
      'हमारा मल्टी-मार्केट AI वास्तविक समय में विदेशी मुद्रा, क्रिप्टो और धातुओं को स्कैन करता है, विशेषज्ञ-मान्य ट्रेडिंग संकेत प्रदान करता है - स्पष्ट प्रविष्टि, स्टॉप-लॉस और टेक-प्रॉफिट स्तरों के साथ';

  @override
  String get totalProfit => 'कुल लाभ';

  @override
  String get completionSignal => 'पूर्णता संकेत';

  @override
  String get onDemandFinancialExpertTitle => 'आपका ऑन-डिमांड वित्तीय विशेषज्ञ';

  @override
  String get onDemandFinancialExpertDesc =>
      'AI प्लेटफ़ॉर्म ट्रेडिंग संकेतों का सुझाव देता है - स्व-सीखने वाला, 24/7 बाजार का विश्लेषण करता है, भावनाओं से अप्रभावित। Minvest ने सटीक, स्थिर और आसानी से लागू होने वाले संकेतों को खोजने की अपनी यात्रा में 10,000 से अधिक वित्तीय विश्लेषकों का समर्थन किया है';

  @override
  String get aiPoweredSignalPlatform => 'AI-संचालित ट्रेडिंग सिग्नल प्लेटफॉर्म';

  @override
  String get selfLearningSystems =>
      'स्व-सीखने की प्रणाली, तेज अंतर्दृष्टि, मजबूत व्यापार';

  @override
  String get emotionlessExecution =>
      'होशियार, अधिक अनुशासित ट्रेडिंग के लिए भावना-रहित निष्पादन';

  @override
  String get analysingMarket247 => '24/7 बाजार का विश्लेषण';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Minvest AI उन्नत बाजार विश्लेषण और सटीक-फ़िल्टर किए गए संकेतों के साथ अपने परिणामों को अधिकतम करें';

  @override
  String get minvestAiRegistrationDesc =>
      'Minvest AI पंजीकरण अब खुला है - जैसे ही हम नए सदस्यों की समीक्षा और अनुमोदन करते हैं, स्पॉट जल्द ही बंद हो सकते हैं';

  @override
  String get currencyPairs => 'कमोडिटी';

  @override
  String get allCurrencyPairs => 'सभी मुद्रा जोड़े';

  @override
  String get allCommodities => 'सभी कमोडिटीज';

  @override
  String get allCryptoPairs => 'सभी क्रिप्टो जोड़े';

  @override
  String get dateRange => 'तिथि सीमा';

  @override
  String get selectDateRange => 'तिथि सीमा चुनें';

  @override
  String get allAssets => 'सभी संपत्ति';

  @override
  String get asset => 'संपत्ति';

  @override
  String get tokenExpired => 'टोकन समाप्त';

  @override
  String get tokenLimitReachedDesc =>
      'आपने आज अपने 10 मुफ्त टोकन का उपयोग कर लिया है। अधिक संकेत देखने के लिए अपने पैकेज को अपग्रेड करें।';

  @override
  String get later => 'बाद में';

  @override
  String get created => 'बनाया गया';

  @override
  String get detail => 'विवरण';

  @override
  String get performanceOverview => 'प्रदर्शन अवलोकन';

  @override
  String get totalProfitPips => 'कुल लाभ (पिप्स)';

  @override
  String get winRatePercent => 'जीत दर (%)';

  @override
  String get comingSoon => 'जल्द आ रहा है';

  @override
  String get errorLoadingHistory => 'इतिहास लोड करने में त्रुटि';

  @override
  String get noHistoryAvailable => 'कोई संकेत इतिहास उपलब्ध नहीं है';

  @override
  String get previous => 'पिछला';

  @override
  String get page => 'पृष्ठ';

  @override
  String get next => 'अगला';

  @override
  String get date => 'दिनांक';

  @override
  String get timeGmt7 => 'समय (GMT)';

  @override
  String get orders => 'आदेश';

  @override
  String get pips => 'पिप्स';

  @override
  String get smallScreenRotationHint =>
      'छोटी स्क्रीन: पूरी तालिका देखने के लिए लैंडस्केप घुमाएं या क्षैतिज रूप से स्क्रॉल करें।';

  @override
  String get history => 'इतिहास';

  @override
  String get signalsWillAppearHere => 'उपलब्ध होने पर संकेत यहां दिखाई देंगे';

  @override
  String get pricing => 'मूल्य निर्धारण';

  @override
  String get choosePlanSubtitle => 'एक ऐसी योजना चुनें जो आपके लिए काम करे';

  @override
  String get financialNewsHub => 'वित्तीय समाचार हब';

  @override
  String get financialNewsHubDesc =>
      'महत्वपूर्ण अपडेट। बाजार की प्रतिक्रियाएं। कोई शोर नहीं - बस निवेशकों को क्या जानने की जरूरत है।';

  @override
  String get newsTabAllArticles => 'सभी लेख';

  @override
  String get newsTabInvestor => 'निवेशक';

  @override
  String get newsTabKnowledge => 'ज्ञान';

  @override
  String get newsTabTechnicalAnalysis => 'तकनीकी विश्लेषण';

  @override
  String noArticlesForCategory(Object category) {
    return '$category श्रेणी के लिए कोई लेख नहीं';
  }

  @override
  String get mostPopular => 'सबसे लोकप्रिय';

  @override
  String get noPosts => 'कोई पोस्ट नहीं';

  @override
  String get relatedArticles => 'संबंधित लेख';

  @override
  String get contactInfoSentSuccess => 'संपर्क जानकारी सफलतापूर्वक भेजी गई।';

  @override
  String contactInfoSentFailed(Object error) {
    return 'जानकारी भेजने में विफल: $error';
  }

  @override
  String get contactPageSubtitle =>
      'प्रश्न हैं या AI समाधान की आवश्यकता है? हमें फॉर्म भरकर बताएं, और हम संपर्क में रहेंगे!';

  @override
  String get phone => 'फ़ोन';

  @override
  String get firstName => 'पहला नाम';

  @override
  String get enterFirstName => 'पहला नाम दर्ज करें';

  @override
  String get lastName => 'अंतिम नाम';

  @override
  String get enterLastName => 'अंतिम नाम दर्ज करें';

  @override
  String get whatAreYourConcerns => 'आपकी चिंताएं क्या हैं?';

  @override
  String get writeConcernsHere => 'चिंताएं यहां लिखें...';

  @override
  String pleaseEnter(Object field) {
    return 'कृपया $field दर्ज करें';
  }

  @override
  String get faqQuestion1 => 'क्या संकेत 100% सफलता दर सुनिश्चित करते हैं?';

  @override
  String get faqAnswer1 =>
      'जबकि किसी भी संकेत की 100% गारंटी नहीं दी जा सकती है, Minvest AI विस्तृत विश्लेषण और जोखिम प्रबंधन द्वारा समर्थित 60-80% सफलता दर बनाए रखने का प्रयास करता है ताकि आप अधिक आत्मविश्वास के साथ अंतिम निर्णय ले सकें।';

  @override
  String get faqQuestion2 =>
      'यदि मैं अभी जमा नहीं करना चाहता, तो क्या मैं अभी भी संकेत सुझाव प्राप्त कर सकता हूं?';

  @override
  String get faqAnswer2 =>
      'खाता खोलते समय, सिस्टम आपको 10 मुफ्त टोकन उपहार में देगा, जो 10 विस्तृत संकेत दृश्यों के बराबर है। उसके बाद, आपको उपयोग करने के लिए हर दिन 1 अतिरिक्त टोकन प्राप्त होगा। यदि आप एक VIP खाते में अपग्रेड करते हैं, तो आप कई उन्नत सुविधाओं को अनलॉक करेंगे और असीमित संख्या में ऑर्डर ट्रैक करेंगे।';

  @override
  String get faqQuestion3 =>
      'यदि मैंने साइन अप किया है लेकिन कोई संकेत प्राप्त नहीं किया है, तो मुझे क्या कदम उठाने चाहिए?';

  @override
  String get faqAnswer3 =>
      'प्रसंस्करण आमतौर पर स्वचालित होता है। यदि आपको अभी भी कोई संकेत सुझाव नहीं दिखता है, तो कृपया त्वरित सहायता के लिए व्हाट्सएप के माध्यम से हमसे संपर्क करें।';

  @override
  String get faqQuestion4 =>
      'VIP खाते में अपग्रेड करते समय मुझे प्रति दिन कितने संकेत प्राप्त होंगे?';

  @override
  String get faqAnswer4 =>
      'VIP खाते में अपग्रेड करते समय, आपको हर दिन असीमित ट्रेडिंग संकेत प्राप्त होंगे। संकेतों की संख्या निश्चित नहीं है, लेकिन पूरी तरह से बाजार विश्लेषण पर निर्भर करती है। जब भी कोई उच्च-गुणवत्ता, उच्च-संभावना वाला प्रवेश बिंदु दिखाई देता है, विश्लेषण टीम आपको तुरंत संकेत भेजेगी।';

  @override
  String get priceLevels => 'मूल्य स्तर';

  @override
  String get capitalManagement => 'पूंजी प्रबंधन';

  @override
  String freeSignalsLeft(Object count) {
    return '$count मुफ्त संकेत शेष';
  }

  @override
  String get unlimitedSignals => 'असीमित संकेत';

  @override
  String get goBack => 'वापस जाओ';

  @override
  String get goldPlan => 'गोल्ड प्लान';

  @override
  String get perMonth => '/ महीना';

  @override
  String get continuouslyUpdating => 'बाजार डेटा को 24/7 लगातार अपडेट करना';

  @override
  String get providingBestSignals =>
      'वास्तविक समय में सर्वोत्तम संकेत प्रदान करना';

  @override
  String get includesEntrySlTp => 'प्रविष्टि, SL, TP शामिल है';

  @override
  String get detailedAnalysis =>
      'प्रत्येक संकेत का विस्तृत विश्लेषण और मूल्यांकन';

  @override
  String get realTimeNotifications =>
      'ईमेल के माध्यम से वास्तविक समय की सूचनाएं';

  @override
  String get signalPerformanceStats => 'संकेत प्रदर्शन आँकड़े';

  @override
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails => 'व्यवसाय पंजीकरण संख्या: 0110057263';

  @override
  String get addressDetails =>
      'पता: नंबर 8 दो हन्ह स्ट्रीट, हाई बा ट्रुंग वार्ड, हनोई सिटी, वियतनाम';

  @override
  String get pagesTitle => 'पृष्ठ';

  @override
  String get legalRegulatoryTitle => 'कानूनी और विनियामक';

  @override
  String get termsOfRegistration => 'पंजीकरण की शर्तें';

  @override
  String get operatingPrinciples => 'संचालन सिद्धांत';

  @override
  String get termsConditions => 'नियम और शर्तें';

  @override
  String get contactTitle => 'संपर्क';

  @override
  String get navFeatures => 'विशेषताएं';

  @override
  String get navNews => 'समाचार';

  @override
  String get tp1Hit => 'TP1 हिट';

  @override
  String get tp2Hit => 'TP2 हिट';

  @override
  String get tp3Hit => 'TP3 हिट';

  @override
  String get slHit => 'SL हिट';

  @override
  String get cancelled => 'रद्द किया गया';

  @override
  String get exitedByAdmin => 'व्यवस्थापक द्वारा बाहर निकला गया';

  @override
  String get signalClosed => 'बंद';

  @override
  String get errorLoadingPackages => 'पैकेज लोड करने में त्रुटि';

  @override
  String get monthly => 'मासिक';

  @override
  String get annually => 'सालाना';

  @override
  String get whatsIncluded => 'क्या शामिल है:';

  @override
  String get chooseThisPlan => 'यह योजना चुनें';

  @override
  String get bestPricesForPremiumAccess =>
      'प्रीमियम एक्सेस के लिए सर्वोत्तम मूल्य';

  @override
  String get choosePlanFitsNeeds =>
      'एक ऐसी योजना चुनें जो आपके लिए काम करे और AI के साथ स्वचालित करना शुरू करें';

  @override
  String get save50Percent => '50% बचाएं';

  @override
  String get tryDemo => 'डेमो आज़माएं';

  @override
  String get pleaseEnterEmailPassword => 'कृपया ईमेल और पासवर्ड दर्ज करें';

  @override
  String loginFailed(String error) {
    return 'लॉगिन विफल: $error';
  }

  @override
  String get welcomeBack => 'वापसी पर स्वागत है';

  @override
  String get signInToContinue => 'जारी रखने के लिए अपने खाते में साइन इन करें';

  @override
  String get or => 'या';

  @override
  String get email => 'ईमेल';

  @override
  String get emailHint => 'example123@gmail.com';

  @override
  String get password => 'पासवर्ड';

  @override
  String get enterPassword => 'पासवर्ड दर्ज करें';

  @override
  String get forgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get createNewAccount => 'यहाँ नया खाता बनाएँ!';

  @override
  String get signUp => 'साइन अप';

  @override
  String get signUpAccount => 'खाता साइन अप करें';

  @override
  String get enterPersonalData =>
      'अपना खाता बनाने के लिए अपना व्यक्तिगत डेटा दर्ज करें';

  @override
  String get nameLabel => 'नाम *';

  @override
  String get enterNameHint => 'नाम दर्ज करें';

  @override
  String get emailLabel => 'ईमेल *';

  @override
  String get passwordLabel => 'पासवर्ड *';

  @override
  String get phoneLabel => 'फ़ोन';

  @override
  String get continueButton => 'जारी रखें';

  @override
  String get fillAllFields => 'कृपया सभी आवश्यक फ़ील्ड भरें।';

  @override
  String get accountCreatedSuccess => 'खाता सफलतापूर्वक बनाया गया।';

  @override
  String signUpFailed(String error) {
    return 'साइन अप विफल: $error';
  }

  @override
  String get nationality => 'राष्ट्रीयता:';

  @override
  String get overview => 'अवलोकन';

  @override
  String get setting => 'सेटिंग';

  @override
  String get paymentHistory => 'भुगतान इतिहास';

  @override
  String get signalsPlan => 'संकेत योजना';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => 'आपके टोकन';

  @override
  String get emailNotificationPreferences => 'ईमेल अधिसूचना प्राथमिकताएं';

  @override
  String get chooseSignalNotificationTypes =>
      'चुनें कि आप ईमेल के माध्यम से किस प्रकार की संकेत सूचनाएं प्राप्त करना चाहते हैं';

  @override
  String get allSignalNotifications => 'सभी संकेत सूचनाएं';

  @override
  String get cryptoSignals => 'क्रिप्टो संकेत';

  @override
  String get forexSignals => 'विदेशी मुद्रा संकेत';

  @override
  String get goldSignals => 'गोल्ड संकेत';

  @override
  String get updatePasswordSecure =>
      'अपने खाते को सुरक्षित रखने के लिए अपना पासवर्ड अपडेट करें';

  @override
  String get searchLabel => 'खोज:';

  @override
  String get filterBy => 'फ़िल्टर करें:';

  @override
  String get allTime => 'अब तक का सबसे';

  @override
  String get startDate => 'आरंभ करने की तिथि:';

  @override
  String get endDate => 'अंतिम तिथि:';

  @override
  String get deactivate => 'निष्क्रिय करें';

  @override
  String get unlimited => 'असीमित';

  @override
  String get tenLeft => '10 शेष';

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
  String get performance => 'प्रदर्शन';

  @override
  String get minvestSupport => 'Minvest समर्थन';

  @override
  String get leaveMessagePart1 =>
      'कृपया एक संदेश छोड़ें, हमारी टीम जल्द से जल्द जवाब देगी। आप संपर्क भी कर सकते हैं ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 तेज़ समर्थन के लिए।';

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
  String get signInRequired => 'लॉग इन आवश्यक';

  @override
  String get signInToExploreSignal =>
      'इस ट्रेडिंग सिग्नल को देखने के लिए लॉग इन करें!';
}
