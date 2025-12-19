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
      '독점 신호를 받으려면 Exness 계정이 Minvest 파트너 링크를 통해 등록되어야 합니다. 아래 링크를 사용하여 새  계정을 만드세요.';

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
  String get startNow => '지금 시그널 받기';

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
      'VIP 신호는 오전 8:00부터 오후 5:00 (GMT+7)까지 이용 가능합니다.\n24시간 신호를 받으려면 Elite로 업그레 이드하세요!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      '데모 신호는 오전 8:00부터 오후 5:00 (GMT+7)까지 이용 가능합니다.\n더 많은 혜택을 받으려면 계정을 업그 레이드하세요!';

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
      '거래 설정을 쉬운 용어로 설명 — 합류점이 어떻게 형성되는지, 진입이 왜 이루어지는지 보여주고 트레이더 가 각 결정에서 배울 수 있도록 돕습니다。';

  @override
  String get transparent => '투명성';

  @override
  String get educational => '教育的';

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
      '받은 편지함으로 직접 전달되는 시기적절한 전략 업데이트를 통해 완벽한 시기에 시장 트렌드를 탈 수 있습 니다.';

  @override
  String get minvestAiCoreValueTitle => 'Minvest AI - 핵심 가치';

  @override
  String get minvestAiCoreValueDesc =>
      'AI는 실시간 시장 데이터를 지속적으로 분석하고 통찰력을 필터링하여 빠르고 정확한 투자 기회를 식별합니다';

  @override
  String get frequentlyAskedQuestions => '자주 묻는 질문 (FAQ)';

  @override
  String get faqSubtitle =>
      '가입 방법부터 혜택, AI 작동 방식에 이르기까지 모든 질문에 대한 답변이 바로 아래에 있습니다. 여전히 궁금한 점이 있으면 언제든지 Whatsapp으로 메시지를 보내주세요';

  @override
  String get maximizeResultsTitle =>
      'Minvest AI로 결과 극대화\n고급 시장 분석 및 정밀 필터링된 신호';

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
      'Minvest AI 등록이 시작되었습니다 — 신규 회원을 검토하고 승인함에 따라 자리가 조기 마감될 수 있습니다.';

  @override
  String get currencyPairs => '통화 쌍';

  @override
  String get allCurrencyPairs => '모든 통화 쌍';

  @override
  String get dateRange => '날짜 범위';

  @override
  String get selectDateRange => '날짜 범위 선택';

  @override
  String get allAssets => '모든 자산';

  @override
  String get asset => '자산';

  @override
  String get tokenExpired => '토큰 만료됨';

  @override
  String get tokenLimitReachedDesc =>
      '오늘 무료 토큰 10개를 모두 사용했습니다. 더 많은 신호를 보려면 패키지를 업그레이드하세요.';

  @override
  String get later => '나중에';

  @override
  String get created => '생성됨';

  @override
  String get detail => '상세';

  @override
  String get performanceOverview => '성과 개요';

  @override
  String get totalProfitPips => '총 이익 (Pips)';

  @override
  String get winRatePercent => '승률 (%)';

  @override
  String get comingSoon => '곧 출시 예정';

  @override
  String get errorLoadingHistory => '기록 로드 오류';

  @override
  String get noHistoryAvailable => '신호 기록 없음';

  @override
  String get previous => '이전';

  @override
  String get page => '페이지';

  @override
  String get next => '다음';

  @override
  String get date => '날짜';

  @override
  String get timeGmt7 => '시간 (GMT)';

  @override
  String get orders => '주문';

  @override
  String get pips => '핍';

  @override
  String get smallScreenRotationHint =>
      '작은 화면: 전체 표를 보려면 가로로 회전하거나 수평으로 스크롤하세요.';

  @override
  String get history => '기록';

  @override
  String get signalsWillAppearHere => '신호가 제공되면 여기에 표시됩니다';

  @override
  String get pricing => '가격';

  @override
  String get choosePlanSubtitle => '당신에게 맞는 요금제를 선택하세요';

  @override
  String get financialNewsHub => '금융 뉴스 허브';

  @override
  String get financialNewsHubDesc => '중요 업데이트. 시장 반응. 소음 없음 – 투자자가 알아야 할 내용만。';

  @override
  String get newsTabAllArticles => '所有文章';

  @override
  String get newsTabInvestor => '投资者';

  @override
  String get newsTabKnowledge => '知识';

  @override
  String get newsTabTechnicalAnalysis => '技术分析';

  @override
  String noArticlesForCategory(Object category) {
    return '类别 $category 暂无文章';
  }

  @override
  String get mostPopular => '最受欢迎';

  @override
  String get noPosts => '暂无帖子';

  @override
  String get relatedArticles => '相关文章';

  @override
  String get contactInfoSentSuccess => '联系信息发送成功。';

  @override
  String contactInfoSentFailed(Object error) {
    return '发送信息失败：$error';
  }

  @override
  String get contactPageSubtitle => '有疑问或需要 AI 解决方案？请填写表格告诉我们，我们会尽快与您联系！';

  @override
  String get phone => '电话';

  @override
  String get firstName => '名';

  @override
  String get enterFirstName => '输入名';

  @override
  String get lastName => '姓';

  @override
  String get enterLastName => '输入姓';

  @override
  String get whatAreYourConcerns => '您有什么顾虑？';

  @override
  String get writeConcernsHere => '在此处写下您的顾虑...';

  @override
  String pleaseEnter(Object field) {
    return '请输入 $field';
  }

  @override
  String get faqQuestion1 => '信号能保证100%成功率吗？';

  @override
  String get faqAnswer1 =>
      '虽然不能保证100%的信号成功率，但Minvest AI努力保持60-80%的稳定成功率，并辅以详细的分析和风险管理，让您更有信心地做出最终决定。';

  @override
  String get faqQuestion2 => '如果我不想立即入金，还能收到信号建议吗？';

  @override
  String get faqAnswer2 =>
      '계좌 개설 시 시스템에서 10개의 무료 토큰(상세 신호 보기 10회 분량)을 선물로 드립니다. 그 후 매일 1개의 토큰을 추가로 받아 사용하실 수 있습니다. VIP 계정으로 업그레이드하면 많은 고급 기능을 잠금 해제하고 무제한 주문을 추적할 수 있습니다.';

  @override
  String get faqQuestion3 => '如果我已注册但未收到任何信号，我该怎么办？';

  @override
  String get faqAnswer3 => '处理通常是自动的。如果您仍未看到任何信号建议，请通过Whatsapp联系我们寻求即时帮助。';

  @override
  String get faqQuestion4 => 'VIP 계정으로 업그레이드하면 매일 몇 개의 신호를 받게 되나요?';

  @override
  String get faqAnswer4 =>
      'VIP 계정으로 업그레이드하면 매일 무제한 거래 신호를 받게 됩니다. 신호의 수는 고정되어 있지 않으며 전적으로 시장 분석에 따라 달라집니다. 고품질, 고확률 진입점이 나타날 때마다 분석 팀이 즉시 신호를 보내드립니다.';

  @override
  String get priceLevels => '价格水平';

  @override
  String get capitalManagement => '资金管理';

  @override
  String freeSignalsLeft(Object count) {
    return '剩余 $count 个免费信号';
  }

  @override
  String get unlimitedSignals => '无限信号';

  @override
  String get goBack => '返回';

  @override
  String get goldPlan => '黄金计划';

  @override
  String get perMonth => '/月';

  @override
  String get continuouslyUpdating => '24/7 持续更新市场数据';

  @override
  String get providingBestSignals => '实时提供最佳信号';

  @override
  String get includesEntrySlTp => '包含入场、止损、止盈';

  @override
  String get detailedAnalysis => '详细分析和评估每个信号';

  @override
  String get realTimeNotifications => '通过电子邮件实时通知';

  @override
  String get signalPerformanceStats => '信号表现统计';

  @override
  String get companyName => 'EZTRADE 技术投资有限公司';

  @override
  String get enterpriseCodeDetails => '企业代码: 0110057263';

  @override
  String get addressDetails => '地址: 越南河内市海柏征坊杜汉街8号';

  @override
  String get pagesTitle => '页面';

  @override
  String get legalRegulatoryTitle => '法律与法规';

  @override
  String get termsOfRegistration => '注册条款';

  @override
  String get operatingPrinciples => '运营原则';

  @override
  String get termsConditions => '条款与条件';

  @override
  String get contactTitle => '联系方式';

  @override
  String get navFeatures => '功能';

  @override
  String get navNews => '新闻';

  @override
  String get tp1Hit => '达到止盈1';

  @override
  String get tp2Hit => '达到止盈2';

  @override
  String get tp3Hit => '达到止盈3';

  @override
  String get slHit => '达到止损';

  @override
  String get cancelled => '已取消';

  @override
  String get exitedByAdmin => '管理员退出';

  @override
  String get signalClosed => '已关闭';

  @override
  String get errorLoadingPackages => '加载套餐错误';

  @override
  String get monthly => '每月';

  @override
  String get annually => '每年';

  @override
  String get whatsIncluded => '包含内容：';

  @override
  String get chooseThisPlan => '选择此计划';

  @override
  String get bestPricesForPremiumAccess => '高级访问的最佳价格';

  @override
  String get choosePlanFitsNeeds => '选择适合您业务需求的计划并开始使用 AI 自动化';

  @override
  String get save50Percent => '节省 50%';

  @override
  String get tryDemo => '试用演示';

  @override
  String get pleaseEnterEmailPassword => '请输入电子邮件和密码';

  @override
  String loginFailed(String error) {
    return '登录失败：$error';
  }

  @override
  String get welcomeBack => '欢迎回来';

  @override
  String get signInToContinue => '登录您的帐户以继续';

  @override
  String get or => '或';

  @override
  String get email => '电子邮件';

  @override
  String get emailHint => 'example123@gmail.com';

  @override
  String get password => '密码';

  @override
  String get enterPassword => '输入密码';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get createNewAccount => '在此处创建新帐户！';

  @override
  String get signUp => '注册';

  @override
  String get signUpAccount => '注册帐户';

  @override
  String get enterPersonalData => '输入您的个人数据以创建您的帐户';

  @override
  String get nameLabel => '姓名 *';

  @override
  String get enterNameHint => '输入姓名';

  @override
  String get emailLabel => '电子邮件 *';

  @override
  String get passwordLabel => '密码 *';

  @override
  String get phoneLabel => '电话';

  @override
  String get continueButton => '继续';

  @override
  String get fillAllFields => '请填写所有必填字段。';

  @override
  String get accountCreatedSuccess => '帐户创建成功。';

  @override
  String signUpFailed(String error) {
    return '注册失败：$error';
  }

  @override
  String get nationality => '国籍：';

  @override
  String get overview => '概览';

  @override
  String get setting => '设置';

  @override
  String get paymentHistory => '支付历史';

  @override
  String get signalsPlan => '信号计划';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => '您的代币';

  @override
  String get emailNotificationPreferences => '电子邮件通知偏好';

  @override
  String get chooseSignalNotificationTypes => '选择您希望通过电子邮件接收的信号通知类型';

  @override
  String get allSignalNotifications => '所有信号通知';

  @override
  String get cryptoSignals => '加密信号';

  @override
  String get forexSignals => '外汇信号';

  @override
  String get goldSignals => '黄金信号';

  @override
  String get updatePasswordSecure => '更新您的密码以确保您的帐户安全';

  @override
  String get searchLabel => '搜索：';

  @override
  String get filterBy => '筛选：';

  @override
  String get allTime => '所有时间';

  @override
  String get startDate => '开始日期：';

  @override
  String get endDate => '结束日期：';

  @override
  String get deactivate => '停用';

  @override
  String get unlimited => '无限';

  @override
  String get tenLeft => '剩余 10';

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
  String get performance => '성과';
}
