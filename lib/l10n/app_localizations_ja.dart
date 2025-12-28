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
      '限定シグナルを取得するには、ExnessアカウントをMinvestパートナーリンク経由で登録する必要があります。以下の リンクを使用して新しいアカウントを作成してください。';

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
  String get startNow => '今すぐシグナルを入手';

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
      'デモシグナルは午前8:00から午後5:00（GMT+7）まで利用可能です。\nより多くの特典を得るにはアカウントをア ップグレードしてください！';

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
  String get chatWelcomeTitle => '👋 Signal GPTへようこそ！';

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
      'クラウド型AIシグナルで従来のトレーディングを変革 — リアルタイムの市場ニュースとトレンドに適応し、より速 く、正確で、感情に左右されないパフォーマンスを実現します。';

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
      '取引設定を簡単な言葉で説明 — コンフルエンスがどのように形成されるか、なぜエントリーが行われるかを示 し、トレーダーが各決定から学ぶのを助けます。';

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
      'チャートを読むのに何時間も費やす必要はありません。1日わずか数分で、カスタマイズされた投資戦略を受け取れ ます。';

  @override
  String get minimizeEmotionalTrading => '感情的な取引を最小限に抑える';

  @override
  String get minimizeEmotionalTradingDesc =>
      'スマートアラート、リスク検出、データ駆動型シグナル（感情ではない）により、規律を保ち、すべての決定をコントロールできます。';

  @override
  String get seizeEveryOpportunity => 'あらゆる機会を掴む';

  @override
  String get seizeEveryOpportunityDesc =>
      '受信トレイに直接配信されるタイムリーな戦略更新により、完璧なタイミングで市場トレンドに乗ることができ ます。';

  @override
  String get minvestAiCoreValueTitle => 'Signal GPT - コアバリュー';

  @override
  String get minvestAiCoreValueDesc =>
      'AIはリアルタイムの市場データを継続的に分析し、インサイトをフィルタリングして、迅速かつ正確な投資機会を特定します';

  @override
  String get frequentlyAskedQuestions => 'よくある質問 (FAQ)';

  @override
  String get faqSubtitle =>
      '参加方法からメリット、AIの仕組みまで、あなたのすべての質問に対する答えがすぐ下にあります。まだ疑問がある場合は、Whatsappでお気軽にメッセージをお送りください';

  @override
  String get maximizeResultsTitle =>
      'Signal GPT で結果を最大化\n高度な市場分析と精密にフィルタリングされたシグナル';

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
      '当社のマルチマーケットAIは、FX、暗号資産、金属をリアルタイムでスキャンし、明確なエントリー、ストップロ ス、テイクプロフィットレベルを備えた専門家検証済みのトレーディングシグナルを提供します';

  @override
  String get totalProfit => '総利益';

  @override
  String get completionSignal => '完了シグナル';

  @override
  String get onDemandFinancialExpertTitle => 'オンデマンドの金融エキスパート';

  @override
  String get onDemandFinancialExpertDesc =>
      'AIプラットフォームがトレーディングシグナルを提案 - 自己学習し、24時間365日市場を分析し、感情に左右 されません。Minvestは、正確で安定した、適用しやすいシグナルを見つける旅において、\n10,000人以上の金融アナリストをサポートしてきました';

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
      'Signal GPTの高度な市場分析と\n精密にフィルタリングされたシグナルで結果を最大化';

  @override
  String get minvestAiRegistrationDesc =>
      'Signal GPT の登録が開始されました — 新規メンバーの審査と承認が完了次第、募集が締め切られる場合があり ます。';

  @override
  String get currencyPairs => '商品';

  @override
  String get allCurrencyPairs => '全ての通貨ペア';

  @override
  String get allCommodities => 'すべての商品';

  @override
  String get allCryptoPairs => 'すべての仮想通貨';

  @override
  String get dateRange => '日付範囲';

  @override
  String get selectDateRange => '日付範囲を選択';

  @override
  String get allAssets => '全ての資産';

  @override
  String get asset => '資産';

  @override
  String get tokenExpired => 'トークンの有効期限切れ';

  @override
  String get tokenLimitReachedDesc =>
      '本日の無料トークン10個を使い切りました。より多くのシグナルを表示するにはプランをアップグレードしてくださ い。';

  @override
  String get later => '後で';

  @override
  String get created => '作成日時';

  @override
  String get detail => '詳細';

  @override
  String get performanceOverview => 'パフォーマンス概要';

  @override
  String get totalProfitPips => '総利益 (Pips)';

  @override
  String get winRatePercent => '勝率 (%)';

  @override
  String get comingSoon => '近日公開';

  @override
  String get errorLoadingHistory => '履歴の読み込みエラー';

  @override
  String get noHistoryAvailable => 'シグナル履歴はありません';

  @override
  String get previous => '前へ';

  @override
  String get page => 'ページ';

  @override
  String get next => '次へ';

  @override
  String get date => '日付';

  @override
  String get timeGmt7 => '時間 (GMT)';

  @override
  String get orders => '注文';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      '小さな画面：横向きに回転するか、水平方向にスクロールして完全な表を表示してください。';

  @override
  String get history => '履歴';

  @override
  String get signalsWillAppearHere => '利用可能なシグナルがここに表示されます';

  @override
  String get pricing => '料金';

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
      'いかなるシグナルも100%保証することはできませんが、Signal GPTは詳細な分析とリスク管理に裏打ちされた60〜80%の安定した 成功率を維持するよう努めており、お客様がより自信を持って最終決定を下せるようにサポートします。';

  @override
  String get faqQuestion2 => 'すぐにデポジットしたくない場合でも、シグナル提案を受け取ることはできますか？';

  @override
  String get faqAnswer2 =>
      'アカウント開設時、システムは10個の無料トークン（詳細なシグナル閲覧10回分に相当）をプレゼントします。その後、毎日1個の追加トークンを受け取ることができます。VIPアカウントにアップグレードすると、多くの高度な機能が解除され、無制限の注文を追跡できるようになります。';

  @override
  String get faqQuestion3 => 'サインアップしましたが、シグナルが届かない場合、どのような手順を踏めばよいですか？';

  @override
  String get faqAnswer3 =>
      '処理は通常自動的に行われます。シグナル提案がまだ表示されない場合は、Whatsappでお問い合わせください。';

  @override
  String get faqQuestion4 => 'VIPアカウントにアップグレードすると、1日にいくつのシグナルを受け取れますか？';

  @override
  String get faqAnswer4 =>
      'VIPアカウントにアップグレードすると、毎日無制限の取引シグナルを受け取ることができます。シグナルの数は固定されておらず、完全に市場分析に依存します。高品質で高確率のエントリーポイントが現れるたびに、分析チームがすぐにシグナルを送信します。';

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
  String get companyName => 'EZTRADEテクノロジー投資有限会社';

  @override
  String get enterpriseCodeDetails => '企業コード: 0110057263';

  @override
  String get addressDetails => '住所：ベトナム、ハノイ市、ハイバチュン区、ドハン通り8番地';

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

  @override
  String get monthly => '毎月';

  @override
  String get annually => '毎年';

  @override
  String get whatsIncluded => '含まれるもの：';

  @override
  String get chooseThisPlan => 'このプランを選択';

  @override
  String get bestPricesForPremiumAccess => 'プレミアムアクセスのベストプライス';

  @override
  String get choosePlanFitsNeeds => 'ビジネスニーズに合ったプランを選択し、AIで自動化を開始しましょう';

  @override
  String get save50Percent => '50%オフ';

  @override
  String get tryDemo => 'デモを試す';

  @override
  String get pleaseEnterEmailPassword => 'メールアドレスとパスワードを入力してください';

  @override
  String loginFailed(String error) {
    return 'ログインに失敗しました: $error';
  }

  @override
  String get welcomeBack => 'お帰りなさい';

  @override
  String get signInToContinue => '続行するにはアカウントにサインインしてください';

  @override
  String get or => 'または';

  @override
  String get email => 'メール';

  @override
  String get emailHint => 'example123@gmail.com';

  @override
  String get password => 'パスワード';

  @override
  String get enterPassword => 'パスワードを入力';

  @override
  String get forgotPassword => 'パスワードをお忘れですか？';

  @override
  String get createNewAccount => 'ここで新しいアカウントを作成！';

  @override
  String get signUp => 'サインアップ';

  @override
  String get signUpAccount => 'アカウント登録';

  @override
  String get enterPersonalData => '個人データを入力してアカウントを作成してください';

  @override
  String get nameLabel => '名前 *';

  @override
  String get enterNameHint => '名前を入力';

  @override
  String get emailLabel => 'メール *';

  @override
  String get passwordLabel => 'パスワード *';

  @override
  String get phoneLabel => '電話番号';

  @override
  String get continueButton => '続行';

  @override
  String get fillAllFields => '必須項目をすべて入力してください。';

  @override
  String get accountCreatedSuccess => 'アカウントが正常に作成されました。';

  @override
  String signUpFailed(String error) {
    return 'サインアップに失敗しました: $error';
  }

  @override
  String get nationality => '国籍：';

  @override
  String get overview => '概要';

  @override
  String get setting => '設定';

  @override
  String get paymentHistory => '支払い履歴';

  @override
  String get signalsPlan => 'シグナルプラン';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => 'あなたのトークン';

  @override
  String get emailNotificationPreferences => 'メール通知設定';

  @override
  String get chooseSignalNotificationTypes => 'メールで受け取りたいシグナル通知のタイプを選択してください';

  @override
  String get allSignalNotifications => 'すべてのシグナル通知';

  @override
  String get cryptoSignals => '仮想通貨シグナル';

  @override
  String get forexSignals => '外国為替シグナル';

  @override
  String get goldSignals => 'ゴールドシグナル';

  @override
  String get updatePasswordSecure => 'アカウントを安全に保つためにパスワードを更新してください';

  @override
  String get searchLabel => '検索：';

  @override
  String get filterBy => 'フィルター：';

  @override
  String get allTime => '全期間';

  @override
  String get startDate => '開始日：';

  @override
  String get endDate => '終了日：';

  @override
  String get deactivate => '無効化';

  @override
  String get unlimited => '無制限';

  @override
  String get tenLeft => '残り10';

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
  String get performance => '実績';

  @override
  String get minvestSupport => 'SignalGpt Support';

  @override
  String get leaveMessagePart1 =>
      'メッセージを残してください。チームができるだけ早く返信します。また、連絡することもできます ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 で迅速なサポートを受けられます。';

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
  String get signInRequired => 'ログインが必要です';

  @override
  String get signInToExploreSignal => 'この取引シグナルを確認するにはログインしてください！';
}
