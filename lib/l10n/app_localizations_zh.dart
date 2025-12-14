// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => '账户升级成功';

  @override
  String get lotPerWeek => '手数/周';

  @override
  String get tableValueFull => '全部';

  @override
  String get tableValueFulltime => '全职';

  @override
  String get packageTitle => '套餐';

  @override
  String get duration1Month => '1 个月';

  @override
  String get duration12Months => '12 个月';

  @override
  String get featureReceiveAllSignals => '接收当天的所有信号';

  @override
  String get featureAnalyzeReason => '分析入场原因';

  @override
  String get featureHighPrecisionAI => '高精度 AI 信号';

  @override
  String get iapStoreNotAvailable => '此设备无法使用商店。';

  @override
  String iapErrorLoadingProducts(Object message) {
    return '加载产品错误：$message';
  }

  @override
  String get iapNoProductsFound => '未找到产品。请检查您的商店配置。';

  @override
  String iapTransactionError(Object message) {
    return '交易错误：$message';
  }

  @override
  String iapVerificationError(Object message) {
    return '验证错误：$message';
  }

  @override
  String iapUnknownError(Object error) {
    return '发生未知错误：$error';
  }

  @override
  String get iapProcessingTransaction => '正在处理交易...';

  @override
  String get orderInfo1Month => '支付 Elite 1 个月套餐';

  @override
  String get orderInfo12Months => '支付 Elite 12 个月套餐';

  @override
  String get iapNotSupportedOnWeb => '网页版不支持应用内购买。';

  @override
  String get vnpayPaymentTitle => 'VNPAY 支付';

  @override
  String get creatingOrderWait => '正在创建订单，请稍候...';

  @override
  String errorWithMessage(Object message) {
    return '错误：$message';
  }

  @override
  String get cannotConnectToServer => '无法连接到服务器。请重试。';

  @override
  String get transactionCancelledOrFailed => '交易已取消或失败。';

  @override
  String get cannotCreatePaymentLink => '无法创建支付链接.\n请重试。';

  @override
  String get retry => '重试';

  @override
  String serverErrorRetry(Object message) {
    return '服务器错误：$message。请重试。';
  }

  @override
  String get redirectingToPayment => '正在跳转到支付页面...';

  @override
  String get invalidPaymentUrl => '从服务器收到无效的支付链接。';

  @override
  String get processingYourAccount => '正在处理您的账户...';

  @override
  String get verificationFailed => '验证失败！';

  @override
  String get reuploadImage => '重新上传图片';

  @override
  String get accountNotLinked => '账户未关联到 Minvest';

  @override
  String get accountNotLinkedDesc =>
      '为了获得独家信号，您的 Exness 账户必须通过 Minvest 合作伙伴链接注册。请使用下面的链接创建一个新账户。';

  @override
  String get registerExnessViaMinvest => '通过 Minvest 注册 Exness';

  @override
  String get iHaveRegisteredReupload => '我已经注册，重新上传';

  @override
  String couldNotLaunch(Object url) {
    return '无法启动 $url';
  }

  @override
  String get status => '状态';

  @override
  String get sentOn => '发送于';

  @override
  String get entryPrice => '入场价格';

  @override
  String get stopLossFull => '止损';

  @override
  String get takeProfitFull1 => '止盈 1';

  @override
  String get takeProfitFull2 => '止盈 2';

  @override
  String get takeProfitFull3 => '止盈 3';

  @override
  String get noReasonProvided => '此信号未提供原因。';

  @override
  String get upgradeToViewReason => '升级您的账户至 Elite 以查看分析。';

  @override
  String get upgradeToViewFullAnalysis => '升级以查看完整分析';

  @override
  String get welcomeTo => '欢迎来到';

  @override
  String get appSlogan => '通过智能信号提升您的交易。';

  @override
  String get signIn => '登录';

  @override
  String get continueByGoogle => '继续使用 Google';

  @override
  String get continueByFacebook => '继续使用 Facebook';

  @override
  String get continueByApple => '继续使用 Apple';

  @override
  String get loginSuccess => '登录成功！';

  @override
  String get live => '实时';

  @override
  String get end => '结束';

  @override
  String get symbol => '交易对';

  @override
  String get aiSignal => 'AI 信号';

  @override
  String get ruleSignal => '规则信号';

  @override
  String get all => '全部';

  @override
  String get upgradeToSeeMore => '升级以查看更多';

  @override
  String get seeDetails => '查看详情';

  @override
  String get notMatched => '未匹配';

  @override
  String get matched => '已匹配';

  @override
  String get entry => '入场';

  @override
  String get stopLoss => '止损';

  @override
  String get takeProfit1 => '止盈1';

  @override
  String get takeProfit2 => '止盈2';

  @override
  String get takeProfit3 => '止盈3';

  @override
  String get upgrade => '升级';

  @override
  String get upgradeAccount => '升级账户';

  @override
  String get compareTiers => '比较等级';

  @override
  String get feature => '功能';

  @override
  String get tierDemo => '演示';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => '精英';

  @override
  String get balance => '余额';

  @override
  String get signalTime => '信号时间';

  @override
  String get signalQty => '信号数量';

  @override
  String get analysis => '分析';

  @override
  String get openExnessAccount => '开设 Exness 账户！';

  @override
  String get accountVerificationWithExness => '使用 Exness 进行账户验证';

  @override
  String get payInAppToUpgrade => '应用内支付升级';

  @override
  String get bankTransferToUpgrade => '银行转账升级';

  @override
  String get accountVerification => '账户验证';

  @override
  String get accountVerificationPrompt =>
      '请上传您的 Exness 账户截图以进行授权（您的账户必须在 Minvest 的 Exness 链接下开设）';

  @override
  String get selectPhotoFromLibrary => '从图库选择照片';

  @override
  String get send => '发送';

  @override
  String get accountInfo => '账户信息';

  @override
  String get accountVerifiedSuccessfully => '账户验证成功';

  @override
  String get yourAccountIs => '您的账户是';

  @override
  String get returnToHomePage => '返回主页';

  @override
  String get upgradeFailed => '升级失败！请重新上传图片';

  @override
  String get package => '套餐';

  @override
  String get startNow => '立即开始';

  @override
  String get bankTransfer => '银行转账';

  @override
  String get transferInformation => '转账信息';

  @override
  String get scanForFastTransfer => '扫描快速转账';

  @override
  String get contactUs247 => '24/7 联系我们';

  @override
  String get newAnnouncement => '新公告';

  @override
  String get profile => '个人资料';

  @override
  String get upgradeNow => '立即升级';

  @override
  String get followMinvest => '关注 MInvest';

  @override
  String get tabSignal => '信号';

  @override
  String get tabChart => '图表';

  @override
  String get tabProfile => '个人资料';

  @override
  String get reason => '原因';

  @override
  String get error => '错误';

  @override
  String get noSignalsAvailable => '暂无信号。';

  @override
  String get outOfGoldenHours => '非黄金时段';

  @override
  String get outOfGoldenHoursVipDesc =>
      'VIP 信号仅在上午 8:00 至下午 5:00 (GMT+7) 提供。\n升级至 Elite 以获取 24/24 信号！';

  @override
  String get outOfGoldenHoursDemoDesc =>
      '演示信号仅在上午 8:00 至下午 5:00 (GMT+7) 提供。\n升级账户以获得更多福利！';

  @override
  String get yourName => '您的姓名';

  @override
  String get yourEmail => 'your.email@example.com';

  @override
  String get adminPanel => '管理面板';

  @override
  String get logout => '退出';

  @override
  String get confirmLogout => '确认退出';

  @override
  String get confirmLogoutMessage => '您确定要退出吗？';

  @override
  String get cancel => '取消';

  @override
  String get upgradeCardTitle => '升级您的账户';

  @override
  String get upgradeCardSubtitle => '访问更多资源';

  @override
  String get upgradeCardSubtitleWeb => '解锁高级信号和全职支持';

  @override
  String get subscriptionDetails => '订阅详情';

  @override
  String get notifications => '通知';

  @override
  String get continueAsGuest => '以访客身份继续';

  @override
  String get deleteAccount => '删除账户';

  @override
  String get deleteAccountWarning => '您确定要删除您的账户吗？您的所有数据将被永久删除且无法恢复。';

  @override
  String get delete => '删除';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get termsOfService => '服务条款';

  @override
  String get signalStatusMatched => '已匹配';

  @override
  String get signalStatusNotMatched => '未匹配';

  @override
  String get signalStatusCancelled => '已取消';

  @override
  String get signalStatusSlHit => '达到止损';

  @override
  String get signalStatusTp1Hit => '达到止盈1';

  @override
  String get signalStatusTp2Hit => '达到止盈2';

  @override
  String get signalStatusTp3Hit => '达到止盈3';

  @override
  String get signalStatusRunning => '运行中';

  @override
  String get signalStatusClosed => '已关闭';

  @override
  String get contactUs => '联系我们';

  @override
  String get tabChat => '聊天';

  @override
  String get exnessUpgradeNoteForIos =>
      '对于通过 Minvest 注册 Exness 账户的客户，请点击联系我们以升级您的账户。';

  @override
  String get chatWelcomeTitle => '👋 欢迎来到 Minvest AI！';

  @override
  String get chatWelcomeBody1 => '请留言，我们的团队将尽快回复。';

  @override
  String get chatWelcomeBody2 => '或直接通过 Zalo/WhatsApp 联系我们：';

  @override
  String get chatWelcomeBody3 => ' 以获得更快的支持！';

  @override
  String get chatLoginPrompt => '请登录以使用此功能';

  @override
  String get chatStartConversation => '开始对话';

  @override
  String get chatNoMessages => '暂无消息。';

  @override
  String get chatTypeMessage => '输入消息...';

  @override
  String get chatSupportIsTyping => '客服正在输入...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName 正在输入...';
  }

  @override
  String get chatSeen => '已读';

  @override
  String get chatDefaultUserName => '用户';

  @override
  String get chatDefaultSupportName => '客服';

  @override
  String get signalEntry => '入场';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      '对于外国交易者，请通过 WhatsApp (+84969.15.6969) 联系我们以获得支持';

  @override
  String get signalSl => '止损';

  @override
  String get upgradeToSeeDetails => '升级以查看信号详情...';

  @override
  String get buy => '买入';

  @override
  String get sell => '卖出';

  @override
  String get logoutDialogTitle => '会话已过期';

  @override
  String get logoutDialogDefaultReason => '您的账户已在其他设备上登录。';

  @override
  String get ok => '确定';

  @override
  String get contactToUpgrade => '联系升级';

  @override
  String get noNotificationsYet => '暂无通知。';

  @override
  String daysAgo(int count) {
    return '$count 天前';
  }

  @override
  String hoursAgo(int count) {
    return '$count 小时前';
  }

  @override
  String minutesAgo(int count) {
    return '$count 分钟前';
  }

  @override
  String get justNow => '刚刚';

  @override
  String get getSignalsNow => '立即获取信号';

  @override
  String get freeTrial => '免费试用';

  @override
  String get heroTitle => '指导交易者 & 增长投资组合';

  @override
  String get heroSubtitle => '终极 AI 引擎 – 由专家交易员设计';

  @override
  String get globalAiInnovationTitle => '下一代交易智能的全球 AI 创新';

  @override
  String get globalAiInnovationDesc =>
      '利用云端 AI 信号彻底改变传统交易 — 适应实时市场新闻和趋势，实现更快、更精确、无情绪的表现。';

  @override
  String get liveTradingSignalsTitle => '实时 – 24/7 AI 交易信号';

  @override
  String get liveTradingSignalsDesc => '实时云分析提供高概率、顺势而为的策略，具有自适应精度和无情绪执行。';

  @override
  String get trendFollowing => '顺势而为';

  @override
  String get realtime => '实时';

  @override
  String get orderExplanationEngineTitle => '订单解释引擎';

  @override
  String get orderExplanationEngineDesc =>
      '用简单的术语解释交易设置 — 展示汇聚点如何形成，为什么入场，并帮助交易者从每个决策中学习。';

  @override
  String get transparent => '透明';

  @override
  String get educational => '教育性';

  @override
  String get logical => '逻辑性';

  @override
  String get transparentRealPerformanceTitle => '透明 - 真实表现';

  @override
  String get transparentRealPerformanceDesc =>
      '查看信号准确性、成功率和盈利能力的真实数据 — 在每笔交易中都经过验证和可追溯';

  @override
  String get results => '结果';

  @override
  String get performanceTracking => '表现追踪';

  @override
  String get accurate => '准确';

  @override
  String get predictiveAccuracy => '预测准确性';

  @override
  String get improvementInProfitability => '盈利能力的提升';

  @override
  String get improvedRiskManagement => '改进的风险管理';

  @override
  String get signalsPerformanceTitle => '信号表现';

  @override
  String get riskToRewardRatio => '风险回报比';

  @override
  String get howRiskComparesToReward => '风险与回报的对比';

  @override
  String get profitLossOverview => '盈亏概览';

  @override
  String get netGainVsLoss => '净收益 vs 亏损';

  @override
  String get winRate => '胜率';

  @override
  String get percentageOfWinningTrades => '盈利交易的百分比';

  @override
  String get accuracyRate => '准确率';

  @override
  String get howPreciseOurSignalsAre => '我们信号的精确度';

  @override
  String get realtimeMarketAnalysis => '实时市场分析';

  @override
  String get realtimeMarketAnalysisDesc =>
      '我们的 AI 持续监控市场，识别技术汇聚区和可靠的突破点，以便您在正确的时刻入场。';

  @override
  String get saveTimeOnAnalysis => '节省分析时间';

  @override
  String get saveTimeOnAnalysisDesc => '不再花费数小时阅读图表。每天只需几分钟即可获得量身定制的投资策略。';

  @override
  String get minimizeEmotionalTrading => '最大限度地减少情绪化交易';

  @override
  String get minimizeEmotionalTradingDesc =>
      '通过智能警报、风险检测和数据驱动的信号（而非情绪），您将保持纪律并掌控每一个决定。';

  @override
  String get seizeEveryOpportunity => '抓住每一个机会';

  @override
  String get seizeEveryOpportunityDesc => '直接发送到您收件箱的及时策略更新确保您在完美的时间驾驭市场趋势。';

  @override
  String get minvestAiCoreValueTitle => 'Minvest AI - 核心价值';

  @override
  String get minvestAiCoreValueDesc => 'AI 持续分析实时市场数据，过滤见解以识别快速、准确的投资机会';

  @override
  String get frequentlyAskedQuestions => '常见问题';

  @override
  String get maximizeResultsTitle => '通过 Minvest AI 先进的市场分析和精确过滤的信号最大化您的结果';

  @override
  String get elevateTradingWithAiStrategies => '通过为一致性和清晰度而精心制作的 AI 增强策略提升您的交易';

  @override
  String get winMoreWithAiSignalsTitle => '在每个市场中通过 AI 驱动的信号赢得更多';

  @override
  String get winMoreWithAiSignalsDesc =>
      '我们的多市场 AI 实时扫描外汇、加密货币和金属，\n提供专家验证的交易信号 —\n具有清晰的入场、止损和止盈水平';

  @override
  String get buyLimit => '买入限价';

  @override
  String get sellLimit => '卖出限价';

  @override
  String get smarterToolsTitle => '更智能的工具 - 更好的投资';

  @override
  String get smarterToolsDesc => '发现帮助您最小化风险、抓住机会并增加财富的功能';

  @override
  String get performanceOverviewTitle => '表现概览';

  @override
  String get performanceOverviewDesc =>
      '我们的多市场 AI 实时扫描外汇、加密货币和金属，提供专家验证的交易信号 - 具有清晰的入场、止损和止盈水平';

  @override
  String get totalProfit => '总利润';

  @override
  String get completionSignal => '完成信号';

  @override
  String get onDemandFinancialExpertTitle => '您的按需金融专家';

  @override
  String get onDemandFinancialExpertDesc =>
      'AI 平台建议交易信号 - 自我学习，24/7 分析市场，不受情绪影响。Minvest 已支持超过 10,000 名金融分析师\n在寻找准确、稳定和易于应用的信号的旅程中';

  @override
  String get aiPoweredSignalPlatform => 'AI 驱动的交易信号平台';

  @override
  String get selfLearningSystems => '自我学习系统，更敏锐的洞察力，更强的交易';

  @override
  String get emotionlessExecution => '无情绪执行，实现更智能、\n更自律的交易';

  @override
  String get analysingMarket247 => '24/7 分析市场';

  @override
  String get maximizeResultsFeaturesTitle =>
      '通过 Minvest AI\n先进的市场分析和精确过滤的信号最大化您的结果';

  @override
  String get minvestAiRegistrationDesc =>
      'Minvest AI 注册现已开放 — 随着我们审核和批准新成员，名额可能会很快关闭';

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
  String get signalsWillAppearHere => '信号将在可用时显示在此处';

  @override
  String get pricing => 'Pricing';

  @override
  String get choosePlanSubtitle => '选择适合您的计划';

  @override
  String get financialNewsHub => '财经新闻中心';

  @override
  String get financialNewsHubDesc => '重要更新。市场反应。没有噪音——只有投资者需要知道的内容。';

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
      '是的。只需通过Minvest链接创建一个Exness账户，即可访问我们的免费模拟信号群（社区VIP）。';

  @override
  String get faqQuestion3 => '如果我已注册但未收到任何信号，我该怎么办？';

  @override
  String get faqAnswer3 => '处理通常是自动的。如果您仍未看到任何信号建议，请通过Whatsapp联系我们寻求即时帮助。';

  @override
  String get faqQuestion4 => '如果我不注册Exness账户，还能加入吗？';

  @override
  String get faqAnswer4 => '请通过WhatsApp或在线聊天联系我们寻求帮助。';

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
  String get enterpriseCodeDetails =>
      '企业代码：0107136243 由河内财政局于2015年11月24日颁发；2025年08月05日经河内财政局注册的第6次修订。';

  @override
  String get addressDetails => '地址：越南河内市燕和坊陈维兴街东南城市区HH地块C2大厦18楼C2810。';

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
}
