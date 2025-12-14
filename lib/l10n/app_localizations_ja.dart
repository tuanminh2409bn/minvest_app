// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'アカウントのアップグレードに成功しました';

  @override
  String get lotPerWeek => 'ロット/週';

  @override
  String get tableValueFull => 'フル';

  @override
  String get tableValueFulltime => 'フルタイム';

  @override
  String get packageTitle => 'パッケージ';

  @override
  String get duration1Month => '1ヶ月';

  @override
  String get duration12Months => '12ヶ月';

  @override
  String get featureReceiveAllSignals => 'その日のすべてのシグナルを受信';

  @override
  String get featureAnalyzeReason => 'エントリー理由を分析';

  @override
  String get featureHighPrecisionAI => '高精度AIシグナル';

  @override
  String get iapStoreNotAvailable => 'このデバイスではストアを利用できません。';

  @override
  String iapErrorLoadingProducts(Object message) {
    return '製品の読み込みエラー: $message';
  }

  @override
  String get iapNoProductsFound => '製品が見つかりません。ストアの設定を確認してください。';

  @override
  String iapTransactionError(Object message) {
    return '取引エラー: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return '検証エラー: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return '不明なエラーが発生しました: $error';
  }

  @override
  String get iapProcessingTransaction => '取引を処理中...';

  @override
  String get orderInfo1Month => 'Elite 1ヶ月パッケージの支払い';

  @override
  String get orderInfo12Months => 'Elite 12ヶ月パッケージの支払い';

  @override
  String get iapNotSupportedOnWeb => 'Web版ではアプリ内購入はサポートされていません。';

  @override
  String get vnpayPaymentTitle => 'VNPAY支払い';

  @override
  String get creatingOrderWait => '注文を作成しています、お待ちください...';

  @override
  String errorWithMessage(Object message) {
    return 'エラー: $message';
  }

  @override
  String get cannotConnectToServer => 'サーバーに接続できません。もう一度お試しください。';

  @override
  String get transactionCancelledOrFailed => '取引がキャンセルされたか失敗しました。';

  @override
  String get cannotCreatePaymentLink => '支払いリンクを作成できませんでした。\nもう一度お試しください。';

  @override
  String get retry => '再試行';

  @override
  String serverErrorRetry(Object message) {
    return 'サーバーエラー: $message。もう一度お試しください。';
  }

  @override
  String get redirectingToPayment => '支払いページにリダイレクトしています...';

  @override
  String get invalidPaymentUrl => 'サーバーから無効な支払いURLを受信しました。';

  @override
  String get processingYourAccount => 'アカウントを処理中...';

  @override
  String get verificationFailed => '検証に失敗しました！';

  @override
  String get reuploadImage => '画像を再アップロード';

  @override
  String get accountNotLinked => 'アカウントがMinvestにリンクされていません';

  @override
  String get accountNotLinkedDesc =>
      '限定シグナルを取得するには、ExnessアカウントをMinvestパートナーリンク経由で登録する必要があります。以下のリンクを使用して新しいアカウントを作成してください。';

  @override
  String get registerExnessViaMinvest => 'Minvest経由でExnessに登録';

  @override
  String get iHaveRegisteredReupload => '登録済み、再アップロード';

  @override
  String couldNotLaunch(Object url) {
    return '$url を開けませんでした';
  }

  @override
  String get status => 'ステータス';

  @override
  String get sentOn => '送信日時';

  @override
  String get entryPrice => 'エントリー価格';

  @override
  String get stopLossFull => 'ストップロス';

  @override
  String get takeProfitFull1 => 'テイクプロフィット 1';

  @override
  String get takeProfitFull2 => 'テイクプロフィット 2';

  @override
  String get takeProfitFull3 => 'テイクプロフィット 3';

  @override
  String get noReasonProvided => 'このシグナルには理由が提供されていません。';

  @override
  String get upgradeToViewReason => '分析を表示するには、アカウントをEliteにアップグレードしてください。';

  @override
  String get upgradeToViewFullAnalysis => 'アップグレードして完全な分析を表示';

  @override
  String get welcomeTo => 'ようこそ';

  @override
  String get appSlogan => 'インテリジェントなシグナルで取引を強化しましょう。';

  @override
  String get signIn => 'サインイン';

  @override
  String get continueByGoogle => 'Googleで続行';

  @override
  String get continueByFacebook => 'Facebookで続行';

  @override
  String get continueByApple => 'Appleで続行';

  @override
  String get loginSuccess => 'ログイン成功！';

  @override
  String get live => 'ライブ';

  @override
  String get end => '終了';

  @override
  String get symbol => 'シンボル';

  @override
  String get aiSignal => 'AIシグナル';

  @override
  String get ruleSignal => 'ルールシグナル';

  @override
  String get all => 'すべて';

  @override
  String get upgradeToSeeMore => 'アップグレードして詳細を表示';

  @override
  String get seeDetails => '詳細を見る';

  @override
  String get notMatched => '不一致';

  @override
  String get matched => '一致';

  @override
  String get entry => 'エントリー';

  @override
  String get stopLoss => '損切り';

  @override
  String get takeProfit1 => '利確1';

  @override
  String get takeProfit2 => '利確2';

  @override
  String get takeProfit3 => '利確3';

  @override
  String get upgrade => 'アップグレード';

  @override
  String get upgradeAccount => 'アカウントをアップグレード';

  @override
  String get compareTiers => 'ティアを比較';

  @override
  String get feature => '機能';

  @override
  String get tierDemo => 'デモ';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => '残高';

  @override
  String get signalTime => 'シグナル時間';

  @override
  String get signalQty => 'シグナル数';

  @override
  String get analysis => '分析';

  @override
  String get openExnessAccount => 'Exnessアカウントを開設！';

  @override
  String get accountVerificationWithExness => 'Exnessでのアカウント確認';

  @override
  String get payInAppToUpgrade => 'アプリ内で支払う';

  @override
  String get bankTransferToUpgrade => '銀行振込';

  @override
  String get accountVerification => 'アカウント確認';

  @override
  String get accountVerificationPrompt =>
      '承認されるには、Exnessアカウントのスクリーンショットをアップロードしてください（アカウントはMinvestのExnessリンクの下で開設されている必要があります）';

  @override
  String get selectPhotoFromLibrary => 'ライブラリから写真を選択';

  @override
  String get send => '送信';

  @override
  String get accountInfo => 'アカウント情報';

  @override
  String get accountVerifiedSuccessfully => 'アカウント確認成功';

  @override
  String get yourAccountIs => 'あなたのアカウントは';

  @override
  String get returnToHomePage => 'ホームページに戻る';

  @override
  String get upgradeFailed => 'アップグレードに失敗しました！画像を再アップロードしてください';

  @override
  String get package => 'パッケージ';

  @override
  String get startNow => '今すぐ開始';

  @override
  String get bankTransfer => '銀行振込';

  @override
  String get transferInformation => '振込情報';

  @override
  String get scanForFastTransfer => 'スキャンして高速振込';

  @override
  String get contactUs247 => '24時間年中無休のお問い合わせ';

  @override
  String get newAnnouncement => '新しいお知らせ';

  @override
  String get profile => 'プロフィール';

  @override
  String get upgradeNow => '今すぐアップグレード';

  @override
  String get followMinvest => 'MInvestをフォロー';

  @override
  String get tabSignal => 'シグナル';

  @override
  String get tabChart => 'チャート';

  @override
  String get tabProfile => 'プロフィール';

  @override
  String get reason => '理由';

  @override
  String get error => 'エラー';

  @override
  String get noSignalsAvailable => 'シグナルはありません。';

  @override
  String get outOfGoldenHours => 'ゴールデンアワー外';

  @override
  String get outOfGoldenHoursVipDesc =>
      'VIPシグナルは午前8:00から午後5:00（GMT+7）まで利用可能です。\n24時間シグナルを取得するにはEliteにアップグレードしてください！';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'デモシグナルは午前8:00から午後5:00（GMT+7）まで利用可能です。\nより多くの特典を得るにはアカウントをアップグレードしてください！';

  @override
  String get yourName => 'お名前';

  @override
  String get yourEmail => 'your.email@example.com';

  @override
  String get adminPanel => '管理パネル';

  @override
  String get logout => 'ログアウト';

  @override
  String get confirmLogout => 'ログアウトの確認';

  @override
  String get confirmLogoutMessage => 'ログアウトしてもよろしいですか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get upgradeCardTitle => 'アカウントをアップグレード';

  @override
  String get upgradeCardSubtitle => 'より多くのリソースにアクセスするために';

  @override
  String get upgradeCardSubtitleWeb => 'プレミアムシグナルとフルタイムサポートを解除';

  @override
  String get subscriptionDetails => 'サブスクリプションの詳細';

  @override
  String get notifications => '通知';

  @override
  String get continueAsGuest => 'ゲストとして続行';

  @override
  String get deleteAccount => 'アカウントを削除';

  @override
  String get deleteAccountWarning => '本当にアカウントを削除しますか？すべてのデータは完全に消去され、復元できません。';

  @override
  String get delete => '削除';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get termsOfService => '利用規約';

  @override
  String get signalStatusMatched => '一致';

  @override
  String get signalStatusNotMatched => '不一致';

  @override
  String get signalStatusCancelled => 'キャンセル済み';

  @override
  String get signalStatusSlHit => '損切りヒット';

  @override
  String get signalStatusTp1Hit => '利確1ヒット';

  @override
  String get signalStatusTp2Hit => '利確2ヒット';

  @override
  String get signalStatusTp3Hit => '利確3ヒット';

  @override
  String get signalStatusRunning => '実行中';

  @override
  String get signalStatusClosed => '終了';

  @override
  String get contactUs => 'お問い合わせ';

  @override
  String get tabChat => 'チャット';

  @override
  String get exnessUpgradeNoteForIos =>
      'Minvestを通じてExnessアカウントを登録されたお客様は、アカウントをアップグレードするためにお問い合わせをクリックしてください。';

  @override
  String get chatWelcomeTitle => '👋 Minvest AIへようこそ！';

  @override
  String get chatWelcomeBody1 => 'メッセージを残してください。チームができるだけ早く返信します。';

  @override
  String get chatWelcomeBody2 => 'または、Zalo/WhatsAppで直接お問い合わせください：';

  @override
  String get chatWelcomeBody3 => ' より迅速なサポートのために！';

  @override
  String get chatLoginPrompt => 'この機能を使用するにはログインしてください';

  @override
  String get chatStartConversation => '会話を開始';

  @override
  String get chatNoMessages => 'メッセージはまだありません。';

  @override
  String get chatTypeMessage => 'メッセージを入力...';

  @override
  String get chatSupportIsTyping => 'サポートが入力中...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName が入力中...';
  }

  @override
  String get chatSeen => '既読';

  @override
  String get chatDefaultUserName => 'ユーザー';

  @override
  String get chatDefaultSupportName => 'サポート';

  @override
  String get signalEntry => 'エントリー';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      '外国人トレーダーの方は、サポートのためにWhatsApp（+84969.15.6969）でお問い合わせください';

  @override
  String get signalSl => '損切り';

  @override
  String get upgradeToSeeDetails => '詳細を表示するにはアップグレード...';

  @override
  String get buy => '買い';

  @override
  String get sell => '売り';

  @override
  String get logoutDialogTitle => 'セッションの有効期限切れ';

  @override
  String get logoutDialogDefaultReason => 'あなたのアカウントは別のデバイスでログインされました。';

  @override
  String get ok => 'OK';

  @override
  String get contactToUpgrade => 'アップグレードのために連絡';

  @override
  String get noNotificationsYet => '通知はまだありません。';

  @override
  String daysAgo(int count) {
    return '$count 日前';
  }

  @override
  String hoursAgo(int count) {
    return '$count 時間前';
  }

  @override
  String minutesAgo(int count) {
    return '$count 分前';
  }

  @override
  String get justNow => 'たった今';

  @override
  String get getSignalsNow => '今すぐシグナルを取得';

  @override
  String get freeTrial => '無料トライアル';

  @override
  String get heroTitle => 'トレーダーを導き、ポートフォリオを成長させる';

  @override
  String get heroSubtitle => '究極のAIエンジン – 専門トレーダーによる設計';

  @override
  String get globalAiInnovationTitle => '次世代トレーディングインテリジェンスのためのグローバルAIイノベーション';

  @override
  String get globalAiInnovationDesc =>
      'クラウド型AIシグナルで従来のトレーディングを変革 — リアルタイムの市場ニュースとトレンドに適応し、より速く、正確で、感情に左右されないパフォーマンスを実現します。';

  @override
  String get liveTradingSignalsTitle => 'ライブ – 24時間365日のAIトレーディングシグナル';

  @override
  String get liveTradingSignalsDesc =>
      'リアルタイムのクラウド分析が、適応的な精度と感情のない実行で、高確率のトレンドフォロー戦略を提供します。';

  @override
  String get trendFollowing => 'トレンドフォロー';

  @override
  String get realtime => 'リアルタイム';

  @override
  String get orderExplanationEngineTitle => '注文説明エンジン';

  @override
  String get orderExplanationEngineDesc =>
      '取引設定を簡単な言葉で説明 — コンフルエンスがどのように形成されるか、なぜエントリーが行われるかを示し、トレーダーが各決定から学ぶのを助けます。';

  @override
  String get transparent => '透明性';

  @override
  String get educational => '教育的';

  @override
  String get logical => '論理的';

  @override
  String get transparentRealPerformanceTitle => '透明性 - 実際のパフォーマンス';

  @override
  String get transparentRealPerformanceDesc =>
      'シグナルの精度、成功率、収益性に関する実際のデータを確認 — すべての取引で検証可能で追跡可能です';

  @override
  String get results => '結果';

  @override
  String get performanceTracking => 'パフォーマンス追跡';

  @override
  String get accurate => '正確';

  @override
  String get predictiveAccuracy => '予測精度';

  @override
  String get improvementInProfitability => '収益性の向上';

  @override
  String get improvedRiskManagement => 'リスク管理の改善';

  @override
  String get signalsPerformanceTitle => 'シグナルパフォーマンス';

  @override
  String get riskToRewardRatio => 'リスク対報酬比率';

  @override
  String get howRiskComparesToReward => 'リスクと報酬の比較';

  @override
  String get profitLossOverview => '損益概要';

  @override
  String get netGainVsLoss => '純利益 vs 損失';

  @override
  String get winRate => '勝率';

  @override
  String get percentageOfWinningTrades => '勝ちトレードの割合';

  @override
  String get accuracyRate => '正解率';

  @override
  String get howPreciseOurSignalsAre => 'シグナルの正確さ';

  @override
  String get realtimeMarketAnalysis => 'リアルタイム市場分析';

  @override
  String get realtimeMarketAnalysisDesc =>
      '当社のAIは市場を継続的に監視し、技術的な収束ゾーンと信頼できるブレイクアウトポイントを特定するため、適切なタイミングでエントリーできます。';

  @override
  String get saveTimeOnAnalysis => '分析時間を節約';

  @override
  String get saveTimeOnAnalysisDesc =>
      'チャートを読むのに何時間も費やす必要はありません。1日わずか数分で、カスタマイズされた投資戦略を受け取れます。';

  @override
  String get minimizeEmotionalTrading => '感情的な取引を最小限に抑える';

  @override
  String get minimizeEmotionalTradingDesc =>
      'スマートアラート、リスク検出、データ駆動型シグナル（感情ではない）により、規律を保ち、すべての決定をコントロールできます。';

  @override
  String get seizeEveryOpportunity => 'あらゆる機会を掴む';

  @override
  String get seizeEveryOpportunityDesc =>
      '受信トレイに直接配信されるタイムリーな戦略更新により、完璧なタイミングで市場トレンドに乗ることができます。';

  @override
  String get minvestAiCoreValueTitle => 'Minvest AI - コアバリュー';

  @override
  String get minvestAiCoreValueDesc =>
      'AIはリアルタイムの市場データを継続的に分析し、インサイトをフィルタリングして、迅速かつ正確な投資機会を特定します';

  @override
  String get frequentlyAskedQuestions => 'よくある質問';

  @override
  String get maximizeResultsTitle =>
      'Minvest AIの高度な市場分析と精密にフィルタリングされたシグナルで結果を最大化';

  @override
  String get elevateTradingWithAiStrategies =>
      '一貫性と明確さのために作られたAI強化戦略でトレーディングを向上させる';

  @override
  String get winMoreWithAiSignalsTitle => 'あらゆる市場でAI搭載シグナルを使って\nもっと勝つ';

  @override
  String get winMoreWithAiSignalsDesc =>
      '当社のマルチマーケットAIは、FX、暗号資産、金属をリアルタイムでスキャンし、\n明確なエントリー、ストップロス、テイクプロフィットレベルを備えた\n専門家検証済みのトレーディングシグナルを提供します';

  @override
  String get buyLimit => '買い指値';

  @override
  String get sellLimit => '売り指値';

  @override
  String get smarterToolsTitle => 'よりスマートなツール - より良い投資';

  @override
  String get smarterToolsDesc => 'リスクを最小限に抑え、機会を掴み、資産を増やすのに役立つ機能を発見してください';

  @override
  String get performanceOverviewTitle => 'パフォーマンス概要';

  @override
  String get performanceOverviewDesc =>
      '当社のマルチマーケットAIは、FX、暗号資産、金属をリアルタイムでスキャンし、明確なエントリー、ストップロス、テイクプロフィットレベルを備えた専門家検証済みのトレーディングシグナルを提供します';

  @override
  String get totalProfit => '総利益';

  @override
  String get completionSignal => '完了シグナル';

  @override
  String get onDemandFinancialExpertTitle => 'オンデマンドの金融エキスパート';

  @override
  String get onDemandFinancialExpertDesc =>
      'AIプラットフォームがトレーディングシグナルを提案 - 自己学習し、24時間365日市場を分析し、感情に左右されません。Minvestは、正確で安定した、適用しやすいシグナルを見つける旅において、\n10,000人以上の金融アナリストをサポートしてきました';

  @override
  String get aiPoweredSignalPlatform => 'AI搭載トレーディングシグナルプラットフォーム';

  @override
  String get selfLearningSystems => '自己学習システム、より鋭い洞察、より強い取引';

  @override
  String get emotionlessExecution => 'よりスマートで規律あるトレーディングのための\n感情のない実行';

  @override
  String get analysingMarket247 => '24時間365日市場を分析';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Minvest AIの高度な市場分析と\n精密にフィルタリングされたシグナルで結果を最大化';

  @override
  String get minvestAiRegistrationDesc =>
      'Minvest AIの登録が開始されました — 新しいメンバーを審査および承認しているため、枠がすぐに埋まる可能性があります';

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
  String get signalsWillAppearHere => '利用可能なシグナルがここに表示されます';

  @override
  String get pricing => 'Pricing';

  @override
  String get choosePlanSubtitle => 'あなたに合ったプランを選択してください';

  @override
  String get financialNewsHub => '金融ニュースハブ';

  @override
  String get financialNewsHubDesc => '重要な更新。市場の反応。ノイズなし – 投資家が知るべきことだけ。';

  @override
  String get newsTabAllArticles => 'すべての記事';

  @override
  String get newsTabInvestor => '投資家';

  @override
  String get newsTabKnowledge => '知識';

  @override
  String get newsTabTechnicalAnalysis => 'テクニカル分析';

  @override
  String noArticlesForCategory(Object category) {
    return 'カテゴリ $category の記事はありません';
  }

  @override
  String get mostPopular => '最も人気';

  @override
  String get noPosts => '投稿なし';

  @override
  String get relatedArticles => '関連記事';

  @override
  String get contactInfoSentSuccess => 'お問い合わせ情報を正常に送信しました。';

  @override
  String contactInfoSentFailed(Object error) {
    return '情報の送信に失敗しました: $error';
  }

  @override
  String get contactPageSubtitle =>
      'ご質問やAIソリューションが必要ですか？フォームにご記入いただければ、追ってご連絡いたします！';

  @override
  String get phone => '電話';

  @override
  String get firstName => '名';

  @override
  String get enterFirstName => '名を入力';

  @override
  String get lastName => '姓';

  @override
  String get enterLastName => '姓を入力';

  @override
  String get whatAreYourConcerns => 'ご懸念事項は何ですか？';

  @override
  String get writeConcernsHere => 'ご懸念事項をこちらに記入してください...';

  @override
  String pleaseEnter(Object field) {
    return '$field を入力してください';
  }

  @override
  String get faqQuestion1 => 'シグナルは100%の成功率を保証しますか？';

  @override
  String get faqAnswer1 =>
      'いかなるシグナルも100%保証することはできませんが、Minvest AIは詳細な分析とリスク管理に裏打ちされた60〜80%の安定した成功率を維持するよう努めており、お客様がより自信を持って最終決定を下せるようにサポートします。';

  @override
  String get faqQuestion2 => 'すぐにデポジットしたくない場合でも、シグナル提案を受け取ることはできますか？';

  @override
  String get faqAnswer2 =>
      'はい。MinvestリンクからExnessアカウントを作成するだけで、無料のデモシグナルグループ（コミュニティVIP）にアクセスできます。';

  @override
  String get faqQuestion3 => 'サインアップしましたが、シグナルが届かない場合、どのような手順を踏めばよいですか？';

  @override
  String get faqAnswer3 =>
      '処理は通常自動的に行われます。シグナル提案がまだ表示されない場合は、Whatsappでお問い合わせください。';

  @override
  String get faqQuestion4 => 'Exnessアカウントにサインアップしない場合でも参加できますか？';

  @override
  String get faqAnswer4 => 'WhatsAppまたはライブチャットでお問い合わせください。';

  @override
  String get priceLevels => '価格レベル';

  @override
  String get capitalManagement => '資金管理';

  @override
  String freeSignalsLeft(Object count) {
    return '無料シグナル残り $count 回';
  }

  @override
  String get unlimitedSignals => '無制限シグナル';

  @override
  String get goBack => '戻る';

  @override
  String get goldPlan => 'ゴールドプラン';

  @override
  String get perMonth => '/月';

  @override
  String get continuouslyUpdating => '24時間365日市場データを継続的に更新';

  @override
  String get providingBestSignals => 'リアルタイムで最高のシグナルを提供';

  @override
  String get includesEntrySlTp => 'エントリー、SL、TPを含む';

  @override
  String get detailedAnalysis => '各シグナルの詳細な分析と評価';

  @override
  String get realTimeNotifications => 'メールによるリアルタイム通知';

  @override
  String get signalPerformanceStats => 'シグナルパフォーマンス統計';

  @override
  String get enterpriseCodeDetails =>
      '企業コード: 0107136243 ハノイ財務局が2015年11月24日に発行。2025年08月05日、ハノイ財務局により第6次改訂が登録。';

  @override
  String get addressDetails =>
      '住所: ベトナム、ハノイ市イェンホア区チャン・ズイ・フン通りドンナム都市区HH区画C2ビル18階C2810。';

  @override
  String get pagesTitle => 'ページ';

  @override
  String get legalRegulatoryTitle => '法的・規制';

  @override
  String get termsOfRegistration => '登録規約';

  @override
  String get operatingPrinciples => '運用原則';

  @override
  String get termsConditions => '利用規約';

  @override
  String get contactTitle => 'お問い合わせ';

  @override
  String get navFeatures => '機能';

  @override
  String get navNews => 'ニュース';

  @override
  String get tp1Hit => 'TP1 ヒット';

  @override
  String get tp2Hit => 'TP2 ヒット';

  @override
  String get tp3Hit => 'TP3 ヒット';

  @override
  String get slHit => 'SL ヒット';

  @override
  String get cancelled => 'キャンセル済み';

  @override
  String get exitedByAdmin => '管理者により終了';

  @override
  String get signalClosed => '終了';

  @override
  String get errorLoadingPackages => 'パッケージの読み込みエラー';
}
