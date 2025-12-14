// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => '계정이 성공적으로 업그레이드되었습니다';

  @override
  String get lotPerWeek => '랏/주';

  @override
  String get tableValueFull => '전체';

  @override
  String get tableValueFulltime => '풀타임';

  @override
  String get packageTitle => '패키지';

  @override
  String get duration1Month => '1개월';

  @override
  String get duration12Months => '12개월';

  @override
  String get featureReceiveAllSignals => '오늘의 모든 신호 수신';

  @override
  String get featureAnalyzeReason => '진입 사유 분석';

  @override
  String get featureHighPrecisionAI => '고정밀 AI 신호';

  @override
  String get iapStoreNotAvailable => '이 기기에서는 스토어를 사용할 수 없습니다.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return '상품 로드 오류: $message';
  }

  @override
  String get iapNoProductsFound => '상품을 찾을 수 없습니다. 스토어 설정을 확인하세요.';

  @override
  String iapTransactionError(Object message) {
    return '거래 오류: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return '검증 오류: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return '알 수 없는 오류가 발생했습니다: $error';
  }

  @override
  String get iapProcessingTransaction => '거래 처리 중...';

  @override
  String get orderInfo1Month => 'Elite 1개월 패키지 결제';

  @override
  String get orderInfo12Months => 'Elite 12개월 패키지 결제';

  @override
  String get iapNotSupportedOnWeb => '웹 버전에서는 인앱 구매가 지원되지 않습니다.';

  @override
  String get vnpayPaymentTitle => 'VNPAY 결제';

  @override
  String get creatingOrderWait => '주문 생성 중, 잠시만 기다려주세요...';

  @override
  String errorWithMessage(Object message) {
    return '오류: $message';
  }

  @override
  String get cannotConnectToServer => '서버에 연결할 수 없습니다. 다시 시도해 주세요.';

  @override
  String get transactionCancelledOrFailed => '거래가 취소되었거나 실패했습니다.';

  @override
  String get cannotCreatePaymentLink => '결제 링크를 생성할 수 없습니다.\n다시 시도해 주세요.';

  @override
  String get retry => '재시도';

  @override
  String serverErrorRetry(Object message) {
    return '서버 오류: $message. 다시 시도해 주세요.';
  }

  @override
  String get redirectingToPayment => '결제 페이지로 리디렉션 중...';

  @override
  String get invalidPaymentUrl => '서버에서 잘못된 결제 URL을 수신했습니다.';

  @override
  String get processingYourAccount => '계정 처리 중...';

  @override
  String get verificationFailed => '검증 실패!';

  @override
  String get reuploadImage => '이미지 재업로드';

  @override
  String get accountNotLinked => '계정이 Minvest에 연결되지 않음';

  @override
  String get accountNotLinkedDesc =>
      '독점 신호를 받으려면 Exness 계정이 Minvest 파트너 링크를 통해 등록되어야 합니다. 아래 링크를 사용하여 새 계정을 만드세요.';

  @override
  String get registerExnessViaMinvest => 'Minvest를 통해 Exness 등록';

  @override
  String get iHaveRegisteredReupload => '등록했습니다, 재업로드';

  @override
  String couldNotLaunch(Object url) {
    return '$url을(를) 실행할 수 없습니다';
  }

  @override
  String get status => '상태';

  @override
  String get sentOn => '전송일';

  @override
  String get entryPrice => '진입 가격';

  @override
  String get stopLossFull => '손절매';

  @override
  String get takeProfitFull1 => '이익 실현 1';

  @override
  String get takeProfitFull2 => '이익 실현 2';

  @override
  String get takeProfitFull3 => '이익 실현 3';

  @override
  String get noReasonProvided => '이 신호에 대한 사유가 제공되지 않았습니다.';

  @override
  String get upgradeToViewReason => '분석을 보려면 계정을 Elite로 업그레이드하세요.';

  @override
  String get upgradeToViewFullAnalysis => '전체 분석을 보려면 업그레이드';

  @override
  String get welcomeTo => '환영합니다';

  @override
  String get appSlogan => '지능형 신호로 거래를 향상시키세요.';

  @override
  String get signIn => '로그인';

  @override
  String get continueByGoogle => 'Google로 계속';

  @override
  String get continueByFacebook => 'Facebook으로 계속';

  @override
  String get continueByApple => 'Apple로 계속';

  @override
  String get loginSuccess => '로그인 성공!';

  @override
  String get live => '라이브';

  @override
  String get end => '종료';

  @override
  String get symbol => '심볼';

  @override
  String get aiSignal => 'AI 신호';

  @override
  String get ruleSignal => '규칙 신호';

  @override
  String get all => '전체';

  @override
  String get upgradeToSeeMore => '더 보려면 업그레이드';

  @override
  String get seeDetails => '상세 보기';

  @override
  String get notMatched => '일치하지 않음';

  @override
  String get matched => '일치함';

  @override
  String get entry => '진입';

  @override
  String get stopLoss => '손절';

  @override
  String get takeProfit1 => '익절1';

  @override
  String get takeProfit2 => '익절2';

  @override
  String get takeProfit3 => '익절3';

  @override
  String get upgrade => '업그레이드';

  @override
  String get upgradeAccount => '계정 업그레이드';

  @override
  String get compareTiers => '등급 비교';

  @override
  String get feature => '기능';

  @override
  String get tierDemo => '데모';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => '잔액';

  @override
  String get signalTime => '신호 시간';

  @override
  String get signalQty => '신호 수량';

  @override
  String get analysis => '분석';

  @override
  String get openExnessAccount => 'Exness 계정 개설!';

  @override
  String get accountVerificationWithExness => 'Exness로 계정 인증';

  @override
  String get payInAppToUpgrade => '앱에서 결제하여 업그레이드';

  @override
  String get bankTransferToUpgrade => '계좌 이체';

  @override
  String get accountVerification => '계정 인증';

  @override
  String get accountVerificationPrompt =>
      '승인을 받으려면 Exness 계정의 스크린샷을 업로드하세요 (계정은 Minvest의 Exness 링크로 개설되어야 함)';

  @override
  String get selectPhotoFromLibrary => '라이브러리에서 사진 선택';

  @override
  String get send => '보내기';

  @override
  String get accountInfo => '계정 정보';

  @override
  String get accountVerifiedSuccessfully => '계정 인증 성공';

  @override
  String get yourAccountIs => '당신의 계정은';

  @override
  String get returnToHomePage => '홈페이지로 돌아가기';

  @override
  String get upgradeFailed => '업그레이드 실패! 이미지를 다시 업로드하세요';

  @override
  String get package => '패키지';

  @override
  String get startNow => '지금 시작';

  @override
  String get bankTransfer => '계좌 이체';

  @override
  String get transferInformation => '이체 정보';

  @override
  String get scanForFastTransfer => '빠른 이체를 위한 스캔';

  @override
  String get contactUs247 => '24/7 문의하기';

  @override
  String get newAnnouncement => '새 공지사항';

  @override
  String get profile => '프로필';

  @override
  String get upgradeNow => '지금 업그레이드';

  @override
  String get followMinvest => 'MInvest 팔로우';

  @override
  String get tabSignal => '신호';

  @override
  String get tabChart => '차트';

  @override
  String get tabProfile => '프로필';

  @override
  String get reason => '사유';

  @override
  String get error => '오류';

  @override
  String get noSignalsAvailable => '신호가 없습니다.';

  @override
  String get outOfGoldenHours => '골든 아워 외';

  @override
  String get outOfGoldenHoursVipDesc =>
      'VIP 신호는 오전 8:00부터 오후 5:00 (GMT+7)까지 이용 가능합니다.\n24시간 신호를 받으려면 Elite로 업그레이드하세요!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      '데모 신호는 오전 8:00부터 오후 5:00 (GMT+7)까지 이용 가능합니다.\n더 많은 혜택을 받으려면 계정을 업그레이드하세요!';

  @override
  String get yourName => '이름';

  @override
  String get yourEmail => 'your.email@example.com';

  @override
  String get adminPanel => '관리자 패널';

  @override
  String get logout => '로그아웃';

  @override
  String get confirmLogout => '로그아웃 확인';

  @override
  String get confirmLogoutMessage => '정말 로그아웃하시겠습니까?';

  @override
  String get cancel => '취소';

  @override
  String get upgradeCardTitle => '계정 업그레이드';

  @override
  String get upgradeCardSubtitle => '더 많은 리소스에 액세스하려면';

  @override
  String get upgradeCardSubtitleWeb => '프리미엄 신호 및 풀타임 지원 잠금 해제';

  @override
  String get subscriptionDetails => '구독 세부 정보';

  @override
  String get notifications => '알림';

  @override
  String get continueAsGuest => '게스트로 계속';

  @override
  String get deleteAccount => '계정 삭제';

  @override
  String get deleteAccountWarning =>
      '정말 계정을 삭제하시겠습니까? 모든 데이터가 영구적으로 삭제되며 복구할 수 없습니다.';

  @override
  String get delete => '삭제';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get termsOfService => '이용 약관';

  @override
  String get signalStatusMatched => '일치함';

  @override
  String get signalStatusNotMatched => '일치하지 않음';

  @override
  String get signalStatusCancelled => '취소됨';

  @override
  String get signalStatusSlHit => '손절가 도달';

  @override
  String get signalStatusTp1Hit => '익절1 도달';

  @override
  String get signalStatusTp2Hit => '익절2 도달';

  @override
  String get signalStatusTp3Hit => '익절3 도달';

  @override
  String get signalStatusRunning => '실행 중';

  @override
  String get signalStatusClosed => '종료됨';

  @override
  String get contactUs => '문의하기';

  @override
  String get tabChat => '채팅';

  @override
  String get exnessUpgradeNoteForIos =>
      'Minvest를 통해 Exness 계정을 등록한 고객의 경우, 계정을 업그레이드하려면 문의하기를 클릭하세요.';

  @override
  String get chatWelcomeTitle => '👋 Minvest AI에 오신 것을 환영합니다!';

  @override
  String get chatWelcomeBody1 => '메시지를 남겨주시면 팀이 최대한 빨리 답변해 드리겠습니다.';

  @override
  String get chatWelcomeBody2 => '또는 Zalo/WhatsApp으로 직접 문의하세요: ';

  @override
  String get chatWelcomeBody3 => ' 더 빠른 지원을 위해!';

  @override
  String get chatLoginPrompt => '이 기능을 사용하려면 로그인하세요';

  @override
  String get chatStartConversation => '대화 시작';

  @override
  String get chatNoMessages => '아직 메시지가 없습니다.';

  @override
  String get chatTypeMessage => '메시지 입력...';

  @override
  String get chatSupportIsTyping => '지원팀이 입력 중...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName님이 입력 중...';
  }

  @override
  String get chatSeen => '읽음';

  @override
  String get chatDefaultUserName => '사용자';

  @override
  String get chatDefaultSupportName => '지원팀';

  @override
  String get signalEntry => '진입';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      '외국인 트레이더의 경우 WhatsApp(+84969.15.6969)으로 지원 문의를 해주세요';

  @override
  String get signalSl => '손절';

  @override
  String get upgradeToSeeDetails => '세부 정보를 보려면 업그레이드...';

  @override
  String get buy => '매수';

  @override
  String get sell => '매도';

  @override
  String get logoutDialogTitle => '세션 만료됨';

  @override
  String get logoutDialogDefaultReason => '계정이 다른 기기에서 로그인되었습니다.';

  @override
  String get ok => '확인';

  @override
  String get contactToUpgrade => '업그레이드 문의';

  @override
  String get noNotificationsYet => '아직 알림이 없습니다.';

  @override
  String daysAgo(int count) {
    return '$count일 전';
  }

  @override
  String hoursAgo(int count) {
    return '$count시간 전';
  }

  @override
  String minutesAgo(int count) {
    return '$count분 전';
  }

  @override
  String get justNow => '방금';

  @override
  String get getSignalsNow => '지금 신호 받기';

  @override
  String get freeTrial => '무료 체험';

  @override
  String get heroTitle => '트레이더를 안내하고 포트폴리오를 성장시키다';

  @override
  String get heroSubtitle => '최고의 AI 엔진 – 전문 트레이더가 설계';

  @override
  String get globalAiInnovationTitle => '차세대 트레이딩 인텔리전스를 위한 글로벌 AI 혁신';

  @override
  String get globalAiInnovationDesc =>
      '클라우드 기반 AI 신호로 전통적인 트레이딩 혁신 — 실시간 시장 뉴스와 트렌드에 적응하여 더 빠르고 정확하며 감정 없는 성과를 제공합니다.';

  @override
  String get liveTradingSignalsTitle => '라이브 – 24/7 AI 트레이딩 신호';

  @override
  String get liveTradingSignalsDesc =>
      '실시간 클라우드 분석은 적응형 정밀도와 감정 없는 실행으로 확률 높은 추세 추종 전략을 제공합니다.';

  @override
  String get trendFollowing => '추세 추종';

  @override
  String get realtime => '실시간';

  @override
  String get orderExplanationEngineTitle => '주문 설명 엔진';

  @override
  String get orderExplanationEngineDesc =>
      '거래 설정을 쉬운 용어로 설명 — 합류점이 어떻게 형성되는지, 진입이 왜 이루어지는지 보여주고 트레이더가 각 결정에서 배울 수 있도록 돕습니다.';

  @override
  String get transparent => '투명성';

  @override
  String get educational => '교육적';

  @override
  String get logical => '논리적';

  @override
  String get transparentRealPerformanceTitle => '투명성 - 실제 성과';

  @override
  String get transparentRealPerformanceDesc =>
      '신호 정확도, 성공률 및 수익성에 대한 실제 데이터를 확인하세요 — 모든 거래에서 검증되고 추적 가능합니다';

  @override
  String get results => '결과';

  @override
  String get performanceTracking => '성과 추적';

  @override
  String get accurate => '정확함';

  @override
  String get predictiveAccuracy => '예측 정확도';

  @override
  String get improvementInProfitability => '수익성 개선';

  @override
  String get improvedRiskManagement => '향상된 위험 관리';

  @override
  String get signalsPerformanceTitle => '신호 성과';

  @override
  String get riskToRewardRatio => '위험 보상 비율';

  @override
  String get howRiskComparesToReward => '위험과 보상의 비교';

  @override
  String get profitLossOverview => '손익 개요';

  @override
  String get netGainVsLoss => '순이익 vs 손실';

  @override
  String get winRate => '승률';

  @override
  String get percentageOfWinningTrades => '수익 거래 비율';

  @override
  String get accuracyRate => '정확도';

  @override
  String get howPreciseOurSignalsAre => '우리 신호의 정확성';

  @override
  String get realtimeMarketAnalysis => '실시간 시장 분석';

  @override
  String get realtimeMarketAnalysisDesc =>
      '우리의 AI는 시장을 지속적으로 모니터링하여 기술적 수렴 구간과 신뢰할 수 있는 돌파 지점을 식별하므로 적절한 순간에 진입할 수 있습니다.';

  @override
  String get saveTimeOnAnalysis => '분석 시간 절약';

  @override
  String get saveTimeOnAnalysisDesc =>
      '더 이상 차트를 읽는 데 시간을 낭비하지 마세요. 하루 몇 분 만에 맞춤형 투자 전략을 받아보세요.';

  @override
  String get minimizeEmotionalTrading => '감정적 거래 최소화';

  @override
  String get minimizeEmotionalTradingDesc =>
      '스마트 알림, 위험 감지 및 데이터 기반 신호(감정이 아님)를 통해 규율을 유지하고 모든 결정을 통제할 수 있습니다.';

  @override
  String get seizeEveryOpportunity => '모든 기회를 잡으세요';

  @override
  String get seizeEveryOpportunityDesc =>
      '받은 편지함으로 직접 전달되는 시기적절한 전략 업데이트를 통해 완벽한 시기에 시장 트렌드를 탈 수 있습니다.';

  @override
  String get minvestAiCoreValueTitle => 'Minvest AI - 핵심 가치';

  @override
  String get minvestAiCoreValueDesc =>
      'AI는 실시간 시장 데이터를 지속적으로 분석하고 통찰력을 필터링하여 빠르고 정확한 투자 기회를 식별합니다';

  @override
  String get frequentlyAskedQuestions => '자주 묻는 질문';

  @override
  String get maximizeResultsTitle =>
      'Minvest AI의 고급 시장 분석과 정밀 필터링된 신호로 결과를 극대화하세요';

  @override
  String get elevateTradingWithAiStrategies =>
      '일관성과 명확성을 위해 제작된 AI 강화 전략으로 트레이딩을 한 단계 높이세요';

  @override
  String get winMoreWithAiSignalsTitle => '모든 시장에서 AI 기반 신호로\n더 많이 승리하세요';

  @override
  String get winMoreWithAiSignalsDesc =>
      '우리의 다중 시장 AI는 외환, 암호화폐 및 금속을 실시간으로 스캔하여,\n명확한 진입, 손절매 및 이익 실현 수준을 갖춘\n전문가가 검증한 트레이딩 신호를 제공합니다';

  @override
  String get buyLimit => '매수 지정가';

  @override
  String get sellLimit => '매도 지정가';

  @override
  String get smarterToolsTitle => '더 스마트한 도구 - 더 나은 투자';

  @override
  String get smarterToolsDesc =>
      '위험을 최소화하고, 기회를 포착하고, 자산을 늘리는 데 도움이 되는 기능을 발견하세요';

  @override
  String get performanceOverviewTitle => '성과 개요';

  @override
  String get performanceOverviewDesc =>
      '우리의 다중 시장 AI는 외환, 암호화폐 및 금속을 실시간으로 스캔하여, 명확한 진입, 손절매 및 이익 실현 수준을 갖춘 전문가가 검증한 트레이딩 신호를 제공합니다';

  @override
  String get totalProfit => '총 이익';

  @override
  String get completionSignal => '완료 신호';

  @override
  String get onDemandFinancialExpertTitle => '당신의 온디맨드 금융 전문가';

  @override
  String get onDemandFinancialExpertDesc =>
      'AI 플랫폼이 트레이딩 신호를 제안 - 자가 학습, 24/7 시장 분석, 감정에 영향을 받지 않음. Minvest는 정확하고 안정적이며 적용하기 쉬운 신호를 찾는 여정에서\n10,000명 이상의 금융 분석가를 지원했습니다';

  @override
  String get aiPoweredSignalPlatform => 'AI 기반 트레이딩 신호 플랫폼';

  @override
  String get selfLearningSystems => '자가 학습 시스템, 더 날카로운 통찰력, 더 강력한 거래';

  @override
  String get emotionlessExecution => '더 스마트하고 규율 있는 트레이딩을 위한\n감정 없는 실행';

  @override
  String get analysingMarket247 => '24/7 시장 분석';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Minvest AI의 고급 시장 분석과\n정밀 필터링된 신호로 결과를 극대화하세요';

  @override
  String get minvestAiRegistrationDesc =>
      'Minvest AI 등록이 시작되었습니다 — 신규 회원을 검토하고 승인함에 따라 자리가 곧 마감될 수 있습니다';

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
  String get signalsWillAppearHere => '신호가 제공되면 여기에 표시됩니다';

  @override
  String get pricing => 'Pricing';

  @override
  String get choosePlanSubtitle => '당신에게 맞는 요금제를 선택하세요';

  @override
  String get financialNewsHub => '금융 뉴스 허브';

  @override
  String get financialNewsHubDesc => '중요 업데이트. 시장 반응. 소음 없음 – 투자자가 알아야 할 내용만.';

  @override
  String get newsTabAllArticles => '모든 기사';

  @override
  String get newsTabInvestor => '투자자';

  @override
  String get newsTabKnowledge => '지식';

  @override
  String get newsTabTechnicalAnalysis => '기술적 분석';

  @override
  String noArticlesForCategory(Object category) {
    return '$category 카테고리에 대한 기사가 없습니다';
  }

  @override
  String get mostPopular => '가장 인기 있는';

  @override
  String get noPosts => '게시물 없음';

  @override
  String get relatedArticles => '관련 기사';

  @override
  String get contactInfoSentSuccess => '연락처 정보가 성공적으로 전송되었습니다.';

  @override
  String contactInfoSentFailed(Object error) {
    return '정보 전송 실패: $error';
  }

  @override
  String get contactPageSubtitle =>
      '질문이 있거나 AI 솔루션이 필요하십니까? 양식을 작성하여 알려주시면 연락드리겠습니다!';

  @override
  String get phone => '전화';

  @override
  String get firstName => '이름';

  @override
  String get enterFirstName => '이름 입력';

  @override
  String get lastName => '성';

  @override
  String get enterLastName => '성 입력';

  @override
  String get whatAreYourConcerns => '귀하의 우려 사항은 무엇입니까?';

  @override
  String get writeConcernsHere => '여기에 우려 사항을 작성하십시오...';

  @override
  String pleaseEnter(Object field) {
    return '$field을(를) 입력하십시오';
  }

  @override
  String get faqQuestion1 => '신호가 100% 성공률을 보장합니까?';

  @override
  String get faqAnswer1 =>
      '어떤 신호도 100% 보장할 수는 없지만, Minvest AI는 상세한 분석과 위험 관리를 통해 60-80%의 안정적인 성공률을 유지하기 위해 노력하고 있으므로 더 큰 확신을 가지고 최종 결정을 내릴 수 있습니다.';

  @override
  String get faqQuestion2 => '바로 입금하고 싶지 않은 경우에도 신호 제안을 받을 수 있습니까?';

  @override
  String get faqAnswer2 =>
      '네. Minvest 링크를 통해 Exness 계정을 만들기만 하면 무료 데모 신호 그룹(커뮤니티 VIP)에 액세스할 수 있습니다.';

  @override
  String get faqQuestion3 => '가입했지만 신호를 받지 못한 경우 어떻게 해야 합니까?';

  @override
  String get faqAnswer3 =>
      '처리는 일반적으로 자동입니다. 여전히 신호 제안을 볼 수 없다면 Whatsapp을 통해 문의하여 즉각적인 지원을 받으십시오.';

  @override
  String get faqQuestion4 => 'Exness 계정에 가입하지 않아도 참여할 수 있습니까?';

  @override
  String get faqAnswer4 => '지원을 위해 WhatsApp 또는 라이브 채팅을 통해 문의하십시오.';

  @override
  String get priceLevels => '가격 수준';

  @override
  String get capitalManagement => '자본 관리';

  @override
  String freeSignalsLeft(Object count) {
    return '무료 신호 $count개 남음';
  }

  @override
  String get unlimitedSignals => '무제한 신호';

  @override
  String get goBack => '뒤로 가기';

  @override
  String get goldPlan => '골드 플랜';

  @override
  String get perMonth => '/월';

  @override
  String get continuouslyUpdating => '24/7 시장 데이터 지속 업데이트';

  @override
  String get providingBestSignals => '실시간 최고의 신호 제공';

  @override
  String get includesEntrySlTp => '진입, 손절, 익절 포함';

  @override
  String get detailedAnalysis => '각 신호에 대한 상세 분석 및 평가';

  @override
  String get realTimeNotifications => '이메일을 통한 실시간 알림';

  @override
  String get signalPerformanceStats => '신호 성과 통계';

  @override
  String get enterpriseCodeDetails =>
      '사업자 코드: 0107136243, 하노이 재정부에서 2015년 11월 24일 발행; 2025년 08월 05일 하노이 재정부에 의해 6차 개정 등록.';

  @override
  String get addressDetails =>
      '주소: 베트남 하노이시 옌호아구 쩐두이흥 거리 동남 도시 지역 HH 블록 C2 빌딩 18층 C2810.';

  @override
  String get pagesTitle => '페이지';

  @override
  String get legalRegulatoryTitle => '법률 및 규정';

  @override
  String get termsOfRegistration => '등록 약관';

  @override
  String get operatingPrinciples => '운영 원칙';

  @override
  String get termsConditions => '이용 약관';

  @override
  String get contactTitle => '문의';

  @override
  String get navFeatures => '기능';

  @override
  String get navNews => '뉴스';

  @override
  String get tp1Hit => 'TP1 도달';

  @override
  String get tp2Hit => 'TP2 도달';

  @override
  String get tp3Hit => 'TP3 도달';

  @override
  String get slHit => 'SL 도달';

  @override
  String get cancelled => '취소됨';

  @override
  String get exitedByAdmin => '관리자에 의해 종료됨';

  @override
  String get signalClosed => '종료됨';

  @override
  String get errorLoadingPackages => '패키지 로드 오류';
}
