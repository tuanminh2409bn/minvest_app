// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'АККАУНТ УСПЕШНО ОБНОВЛЕН';

  @override
  String get lotPerWeek => 'Лот/неделя';

  @override
  String get tableValueFull => 'полный';

  @override
  String get tableValueFulltime => 'полная занятость';

  @override
  String get packageTitle => 'ПАКЕТ';

  @override
  String get duration1Month => '1 месяц';

  @override
  String get duration12Months => '12 месяцев';

  @override
  String get featureReceiveAllSignals => 'Получать все сигналы дня';

  @override
  String get featureAnalyzeReason => 'Анализировать причину входа в ордер';

  @override
  String get featureHighPrecisionAI => 'Высокоточный AI сигнал';

  @override
  String get iapStoreNotAvailable => 'Магазин недоступен на этом устройстве.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'Ошибка загрузки продуктов: $message';
  }

  @override
  String get iapNoProductsFound =>
      'Продукты не найдены. Пожалуйста, проверьте конфигурацию вашего магазина.';

  @override
  String iapTransactionError(Object message) {
    return 'Ошибка транзакции: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'Ошибка верификации: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'Произошла неизвестная ошибка: $error';
  }

  @override
  String get iapProcessingTransaction => 'Обработка транзакции...';

  @override
  String get orderInfo1Month => 'Оплата пакета Elite на 1 месяц';

  @override
  String get orderInfo12Months => 'Оплата пакета Elite на 12 месяцев';

  @override
  String get iapNotSupportedOnWeb =>
      'Покупки в приложении не поддерживаются в веб-версии.';

  @override
  String get vnpayPaymentTitle => 'ОПЛАТА VNPAY';

  @override
  String get creatingOrderWait => 'Создание заказа, пожалуйста, подождите...';

  @override
  String errorWithMessage(Object message) {
    return 'Ошибка: $message';
  }

  @override
  String get cannotConnectToServer =>
      'Не удается подключиться к серверу. Пожалуйста, попробуйте снова.';

  @override
  String get transactionCancelledOrFailed =>
      'Транзакция была отменена или не удалась.';

  @override
  String get cannotCreatePaymentLink =>
      'Не удалось создать ссылку для оплаты.\nПопробуйте снова.';

  @override
  String get retry => 'Повторить';

  @override
  String serverErrorRetry(Object message) {
    return 'Ошибка сервера: $message. Пожалуйста, попробуйте снова.';
  }

  @override
  String get redirectingToPayment => 'Перенаправление на страницу оплаты...';

  @override
  String get invalidPaymentUrl => 'Получен неверный URL оплаты от сервера.';

  @override
  String get processingYourAccount => 'Обработка вашего аккаунта...';

  @override
  String get verificationFailed => 'Верификация не удалась!';

  @override
  String get reuploadImage => 'Загрузить изображение повторно';

  @override
  String get accountNotLinked => 'Аккаунт не привязан к Signal GPT';

  @override
  String get accountNotLinkedDesc =>
      'Чтобы получать эксклюзивные сигналы, ваш аккаунт Exness должен быть зарегистрирован по партнерской ссылке Signal GPT. Пожалуйста, создайте новый аккаунт, используя ссылку ниже.';

  @override
  String get registerExnessViaSignalGPT =>
      'Зарегистрировать Exness через Signal GPT';

  @override
  String get iHaveRegisteredReupload =>
      'Я зарегистрировался, загрузить повторно';

  @override
  String couldNotLaunch(Object url) {
    return 'Не удалось запустить $url';
  }

  @override
  String get status => 'Статус';

  @override
  String get sentOn => 'Отправлено';

  @override
  String get entryPrice => 'Цена входа';

  @override
  String get stopLossFull => 'Стоп-лосс';

  @override
  String get takeProfitFull1 => 'Тейк-профит 1';

  @override
  String get takeProfitFull2 => 'Тейк-профит 2';

  @override
  String get takeProfitFull3 => 'Тейк-профит 3';

  @override
  String get noReasonProvided => 'Причина для этого сигнала не указана.';

  @override
  String get upgradeToViewReason =>
      'Обновите свой аккаунт до Elite, чтобы просмотреть анализ.';

  @override
  String get upgradeToViewFullAnalysis =>
      'Обновите, чтобы просмотреть полный анализ';

  @override
  String get welcomeTo => 'Добро пожаловать в';

  @override
  String get appSlogan =>
      'Улучшите свою торговлю с помощью интеллектуальных сигналов.';

  @override
  String get signIn => 'Войти';

  @override
  String get continueByGoogle => 'Продолжить с Google';

  @override
  String get continueByFacebook => 'Продолжить с Facebook';

  @override
  String get continueByApple => 'Продолжить с Apple';

  @override
  String get loginSuccess => 'Вход выполнен успешно!';

  @override
  String get live => 'ПРЯМОЙ ЭФИР';

  @override
  String get end => 'КОНЕЦ';

  @override
  String get symbol => 'СИМВОЛ';

  @override
  String get aiSignal => 'AI Сигналы';

  @override
  String get ruleSignal => 'СИГНАЛ ПРАВИЛА';

  @override
  String get all => 'ВСЕ';

  @override
  String get upgradeToSeeMore => 'Обновите, чтобы увидеть больше';

  @override
  String get seeDetails => 'смотреть детали';

  @override
  String get notMatched => 'НЕ СОВПАДАЕТ';

  @override
  String get matched => 'СОВПАДАЕТ';

  @override
  String get entry => 'Вход';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'Обновить';

  @override
  String get upgradeAccount => 'ОБНОВИТЬ АККАУНТ';

  @override
  String get compareTiers => 'СРАВНИТЬ УРОВНИ';

  @override
  String get feature => 'Функция';

  @override
  String get tierDemo => 'Демо';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'Баланс';

  @override
  String get signalTime => 'Время сигнала';

  @override
  String get signalQty => 'К-во сигналов';

  @override
  String get analysis => 'Анализ';

  @override
  String get openExnessAccount => 'Открыть аккаунт Exness!';

  @override
  String get accountVerificationWithExness => 'Верификация аккаунта с Exness';

  @override
  String get payInAppToUpgrade => 'Оплатить в приложении для обновления';

  @override
  String get bankTransferToUpgrade => 'Банковский перевод для обновления';

  @override
  String get accountVerification => 'ВЕРИФИКАЦИЯ АККАУНТА';

  @override
  String get accountVerificationPrompt =>
      'Пожалуйста, загрузите скриншот вашего аккаунта Exness для авторизации (ваш аккаунт должен быть открыт по ссылке Exness от Signal GPT)';

  @override
  String get selectPhotoFromLibrary => 'Выбрать фото из библиотеки';

  @override
  String get send => 'Отправить';

  @override
  String get accountInfo => 'Информация об аккаунте';

  @override
  String get accountVerifiedSuccessfully => 'АККАУНТ УСПЕШНО ВЕРИФИЦИРОВАН';

  @override
  String get yourAccountIs => 'Ваш аккаунт';

  @override
  String get returnToHomePage => 'Вернуться на главную';

  @override
  String get upgradeFailed =>
      'Обновление не удалось! Пожалуйста, загрузите изображение повторно';

  @override
  String get package => 'ПАКЕТ';

  @override
  String get startNow => 'Получить сигналы сейчас';

  @override
  String get bankTransfer => 'БАНКОВСКИЙ ПЕРЕВОД';

  @override
  String get transferInformation => 'ИНФОРМАЦИЯ О ПЕРЕВОДЕ';

  @override
  String get scanForFastTransfer => 'Сканируйте для быстрого перевода';

  @override
  String get contactUs247 => 'Свяжитесь с нами 24/7';

  @override
  String get newAnnouncement => 'НОВОЕ ОБЪЯВЛЕНИЕ';

  @override
  String get profile => 'Профиль';

  @override
  String get upgradeNow => 'Обновить сейчас';

  @override
  String get followSignalGPT => 'Следите за Signal GPT';

  @override
  String get tabSignal => 'Сигнал';

  @override
  String get tabChart => 'График';

  @override
  String get tabProfile => 'Профиль';

  @override
  String get reason => 'ПРИЧИНА';

  @override
  String get error => 'Ошибка';

  @override
  String get noSignalsAvailable => 'Нет доступных сигналов.';

  @override
  String get outOfGoldenHours => 'Вне золотых часов';

  @override
  String get outOfGoldenHoursVipDesc =>
      'VIP сигналы доступны с 8:00 до 17:00 (GMT+7).\nОбновите до Elite, чтобы получать сигналы 24/24!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'Демо сигналы доступны с 8:00 до 17:00 (GMT+7).\nОбновите свой аккаунт для получения дополнительных преимуществ!';

  @override
  String get yourName => 'Ваше Имя';

  @override
  String get yourEmail => 'vash.email@example.com';

  @override
  String get adminPanel => 'Панель администратора';

  @override
  String get logout => 'Выйти';

  @override
  String get confirmLogout => 'Подтвердить выход';

  @override
  String get confirmLogoutMessage => 'Вы уверены, что хотите выйти?';

  @override
  String get cancel => 'Отмена';

  @override
  String get upgradeCardTitle => 'ОБНОВИТЕ СВОЙ АККАУНТ';

  @override
  String get upgradeCardSubtitle => 'Для доступа к дополнительным ресурсам';

  @override
  String get upgradeCardSubtitleWeb =>
      'Чтобы разблокировать премиум-сигналы и полную поддержку';

  @override
  String get subscriptionDetails => 'Детали подписки';

  @override
  String get notifications => 'Уведомления';

  @override
  String get continueAsGuest => 'Продолжить как гость';

  @override
  String get deleteAccount => 'Удалить аккаунт';

  @override
  String get deleteAccountWarning =>
      'Вы уверены, что хотите удалить свой аккаунт? Все ваши данные будут удалены безвозвратно и не подлежат восстановлению.';

  @override
  String get delete => 'Удалить';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get termsOfService => 'Условия обслуживания';

  @override
  String get signalStatusMatched => 'СОВПАДАЕТ';

  @override
  String get signalStatusNotMatched => 'НЕ СОВПАДАЕТ';

  @override
  String get signalStatusCancelled => 'ОТМЕНЕНО';

  @override
  String get signalStatusSlHit => 'SL ДОСТИГНУТ';

  @override
  String get signalStatusTp1Hit => 'TP1 ДОСТИГНУТ';

  @override
  String get signalStatusTp2Hit => 'TP2 ДОСТИГНУТ';

  @override
  String get signalStatusTp3Hit => 'TP3 ДОСТИГНУТ';

  @override
  String get signalStatusRunning => 'В ПРОЦЕССЕ';

  @override
  String get signalStatusClosed => 'ЗАКРЫТО';

  @override
  String get contactUs => 'Свяжитесь с нами';

  @override
  String get tabChat => 'Чат';

  @override
  String get exnessUpgradeNoteForIos =>
      'Для клиентов, зарегистрировавших аккаунт Exness через Signal GPT, пожалуйста, нажмите \'Связаться с нами\', чтобы обновить ваш аккаунт.';

  @override
  String get chatWelcomeTitle => '👋 Добро пожаловать в Signal GPT!';

  @override
  String get chatWelcomeBody1 =>
      'Пожалуйста, оставьте сообщение, наша команда ответит как можно скорее.';

  @override
  String get chatWelcomeBody2 =>
      'Или свяжитесь с нами напрямую через Zalo/WhatsApp: ';

  @override
  String get chatWelcomeBody3 => ' для более быстрой поддержки!';

  @override
  String get chatLoginPrompt =>
      'Пожалуйста, войдите, чтобы использовать эту функцию';

  @override
  String get chatStartConversation => 'Начните разговор';

  @override
  String get chatNoMessages => 'Сообщений пока нет.';

  @override
  String get chatTypeMessage => 'Введите сообщение...';

  @override
  String get chatSupportIsTyping => 'Поддержка печатает...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName печатает...';
  }

  @override
  String get chatSeen => 'Просмотрено';

  @override
  String get chatDefaultUserName => 'Пользователь';

  @override
  String get chatDefaultSupportName => 'Поддержка';

  @override
  String get signalEntry => 'Вход';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      'Для иностранных трейдеров, пожалуйста, свяжитесь с нами через WhatsApp (+84969.15.6969) для поддержки';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails => 'Обновите, чтобы увидеть детали сигнала...';

  @override
  String get buy => 'КУПИТЬ';

  @override
  String get sell => 'ПРОДАТЬ';

  @override
  String get logoutDialogTitle => 'Сессия истекла';

  @override
  String get logoutDialogDefaultReason =>
      'Ваш аккаунт был авторизован на другом устройстве.';

  @override
  String get ok => 'ОК';

  @override
  String get contactToUpgrade => 'Связаться для обновления';

  @override
  String get noNotificationsYet => 'Уведомлений пока нет.';

  @override
  String daysAgo(int count) {
    return '$count дней назад';
  }

  @override
  String hoursAgo(int count) {
    return '$count часов назад';
  }

  @override
  String minutesAgo(int count) {
    return '$count минут назад';
  }

  @override
  String get justNow => 'Только что';

  @override
  String get getSignalsNow => 'Получить сигналы сейчас';

  @override
  String get freeTrial => 'Бесплатная пробная версия';

  @override
  String get heroTitle => 'Направление трейдеров и рост портфелей';

  @override
  String get heroSubtitle =>
      'Идеальный AI движок – Разработан экспертами-трейдерами';

  @override
  String get globalAiInnovationTitle =>
      'Глобальные инновации AI для следующего поколения торгового интеллекта';

  @override
  String get globalAiInnovationDesc =>
      'Трансформация традиционной торговли с помощью облачных AI сигналов — адаптация к новостям рынка и трендам в реальном времени\nдля более быстрой, точной и безэмоциональной работы.';

  @override
  String get liveTradingSignalsTitle => 'LIVE – 24/7 AI Торговые сигналы';

  @override
  String get liveTradingSignalsDesc =>
      'Облачная аналитика в реальном времени, предоставляющая стратегии следования за трендом с высокой вероятностью, с адаптивной точностью и безэмоциональным исполнением.';

  @override
  String get trendFollowing => 'Следование за трендом';

  @override
  String get realtime => 'В реальном времени';

  @override
  String get orderExplanationEngineTitle => 'Движок объяснения ордеров';

  @override
  String get orderExplanationEngineDesc =>
      'Объясняет торговые настройки простыми словами — показывая, как формируются слияния, почему совершаются входы, и помогая трейдерам учиться на каждом решении.';

  @override
  String get transparent => 'Прозрачный';

  @override
  String get educational => 'Образовательный';

  @override
  String get logical => 'Логичный';

  @override
  String get transparentRealPerformanceTitle =>
      'Прозрачный - Реальная производительность';

  @override
  String get transparentRealPerformanceDesc =>
      'Смотрите реальные данные о точности сигналов, уровне успеха и прибыльности — проверенные и отслеживаемые в каждой сделке';

  @override
  String get results => 'Результаты';

  @override
  String get performanceTracking => 'Отслеживание производительности';

  @override
  String get accurate => 'Точный';

  @override
  String get predictiveAccuracy => 'Прогностическая точность';

  @override
  String get improvementInProfitability => 'Улучшение прибыльности';

  @override
  String get improvedRiskManagement => 'Улучшенное управление рисками';

  @override
  String get signalsPerformanceTitle => 'Производительность сигналов';

  @override
  String get riskToRewardRatio => 'Соотношение риска к прибыли';

  @override
  String get howRiskComparesToReward => 'Как риск соотносится с прибылью';

  @override
  String get profitLossOverview => 'Обзор прибыли/убытка';

  @override
  String get netGainVsLoss => 'Чистая прибыль против убытка';

  @override
  String get winRate => 'Винрейт';

  @override
  String get percentageOfWinningTrades => 'Процент выигрышных сделок';

  @override
  String get accuracyRate => 'Уровень точности';

  @override
  String get howPreciseOurSignalsAre => 'Насколько точны наши сигналы';

  @override
  String get realtimeMarketAnalysis => 'Анализ рынка в реальном времени';

  @override
  String get realtimeMarketAnalysisDesc =>
      'Наш AI непрерывно мониторит рынок, определяя зоны технической конвергенции и надежные точки прорыва, чтобы вы могли входить в сделки в нужный момент.';

  @override
  String get saveTimeOnAnalysis => 'Экономьте время на анализе';

  @override
  String get saveTimeOnAnalysisDesc =>
      'Больше не нужно часами читать графики. Получайте индивидуальные инвестиционные стратегии всего за несколько минут в день.';

  @override
  String get minimizeEmotionalTrading => 'Минимизируйте эмоциональную торговлю';

  @override
  String get minimizeEmotionalTradingDesc =>
      'С умными оповещениями, обнаружением рисков и сигналами, основанными на данных, а не эмоциях, вы остаетесь дисциплинированным и контролируете каждое решение.';

  @override
  String get seizeEveryOpportunity => 'Используйте каждую возможность';

  @override
  String get seizeEveryOpportunityDesc =>
      'Своевременные обновления стратегии, доставляемые прямо в ваш почтовый ящик, гарантируют, что вы будете использовать рыночные тренды в идеальное время.';

  @override
  String get minvestAiCoreValueTitle => 'Signal GPT - Основная ценность';

  @override
  String get minvestAiCoreValueDesc =>
      'AI непрерывно анализирует рыночные данные в реальном времени, фильтруя инсайты для выявления быстрых и точных инвестиционных возможностей';

  @override
  String get frequentlyAskedQuestions => 'Часто задаваемые вопросы (FAQ)';

  @override
  String get faqSubtitle =>
      'Все ваши вопросы — от того, как присоединиться, до преимуществ и работы нашего AI — даны ниже. Если у вас все еще есть сомнения, не стесняйтесь писать нам в Whatsapp';

  @override
  String get maximizeResultsTitle =>
      'Максимизируйте свои результаты с Signal GPT\nпродвинутый анализ рынка и точно отфильтрованные сигналы';

  @override
  String get elevateTradingWithAiStrategies =>
      'Поднимите свою торговлю с помощью стратегий, улучшенных AI, созданных для последовательности и ясности';

  @override
  String get winMoreWithAiSignalsTitle =>
      'Выигрывайте больше с сигналами на базе AI\nна каждом рынке';

  @override
  String get winMoreWithAiSignalsDesc =>
      'Наш мультирыночный AI сканирует Forex, Крипто и Металлы в реальном времени,\nпредоставляя проверенные экспертами торговые сигналы —\nс четкими уровнями входа, стоп-лосса и тейк-профита';

  @override
  String get buyLimit => 'Лимит покупки';

  @override
  String get sellLimit => 'Лимит продажи';

  @override
  String get smarterToolsTitle => 'Умные инструменты - Лучшие инвестиции';

  @override
  String get smarterToolsDesc =>
      'Откройте для себя функции, которые помогут вам минимизировать риски, использовать возможности и приумножать свое богатство';

  @override
  String get performanceOverviewTitle => 'Обзор производительности';

  @override
  String get performanceOverviewDesc =>
      'Наш мультирыночный AI сканирует Forex, Крипто и Металлы в реальном времени, предоставляя проверенные экспертами торговые сигналы - с четкими уровнями входа, стоп-лосса и тейк-профита';

  @override
  String get totalProfit => 'Общая прибыль';

  @override
  String get completionSignal => 'Сигнал завершения';

  @override
  String get onDemandFinancialExpertTitle =>
      'Ваш финансовый эксперт по требованию';

  @override
  String get onDemandFinancialExpertDesc =>
      'Платформа AI предлагает торговые сигналы - самообучающаяся, анализирует рынок 24/7, не подвержена эмоциям. Signal GPT поддержал более 10 000 финансовых аналитиков в их поиске точных, стабильных и простых в применении сигналов';

  @override
  String get aiPoweredSignalPlatform =>
      'Платформа торговых сигналов на базе AI';

  @override
  String get selfLearningSystems =>
      'Самообучающиеся системы, более четкие инсайты, более сильные сделки';

  @override
  String get emotionlessExecution =>
      'Безэмоциональное исполнение для более умной и дисциплинированной торговли';

  @override
  String get analysingMarket247 => 'Анализ рынка 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Максимизируйте свои результаты с Signal GPT\nпродвинутый анализ рынка и точно отфильтрованные сигналы';

  @override
  String get minvestAiRegistrationDesc =>
      'Регистрация в Signal GPT открыта — места могут скоро закрыться, так как мы рассматриваем и утверждаем новых участников';

  @override
  String get currencyPairs => 'Товар';

  @override
  String get allCurrencyPairs => 'Все валютные пары';

  @override
  String get allCommodities => 'Все товары';

  @override
  String get allCryptoPairs => 'Все крипто пары';

  @override
  String get dateRange => 'Диапазон дат';

  @override
  String get selectDateRange => 'Выберите диапазон дат';

  @override
  String get allAssets => 'Все активы';

  @override
  String get asset => 'Актив';

  @override
  String get tokenExpired => 'Токен истек';

  @override
  String get tokenLimitReachedDesc =>
      'Вы использовали свои 10 бесплатных токенов сегодня. Обновите пакет, чтобы просматривать больше сигналов.';

  @override
  String get later => 'Позже';

  @override
  String get created => 'Создано';

  @override
  String get detail => 'Деталь';

  @override
  String get performanceOverview => 'Обзор производительности';

  @override
  String get totalProfitPips => 'Общая прибыль (Пипсы)';

  @override
  String get winRatePercent => 'Винрейт (%)';

  @override
  String get comingSoon => 'Скоро';

  @override
  String get errorLoadingHistory => 'Ошибка загрузки истории';

  @override
  String get noHistoryAvailable => 'История сигналов недоступна';

  @override
  String get previous => 'Назад';

  @override
  String get page => 'Страница';

  @override
  String get next => 'Далее';

  @override
  String get date => 'Дата';

  @override
  String get timeGmt7 => 'Время';

  @override
  String get orders => 'Ордера';

  @override
  String get pips => 'Пипсы';

  @override
  String get smallScreenRotationHint =>
      'Маленький экран: поверните горизонтально или прокрутите, чтобы увидеть полную таблицу.';

  @override
  String get history => 'История';

  @override
  String get signalsWillAppearHere =>
      'Сигналы появятся здесь, когда будут доступны';

  @override
  String get pricing => 'Цены';

  @override
  String get choosePlanSubtitle => 'Выберите план, который вам подходит';

  @override
  String get financialNewsHub => 'Центр финансовых новостей';

  @override
  String get financialNewsHubDesc =>
      'Критические обновления. Реакции рынка. Никакого шума – только то, что нужно знать инвесторам.';

  @override
  String get newsTabAllArticles => 'Все статьи';

  @override
  String get newsTabInvestor => 'Инвестор';

  @override
  String get newsTabKnowledge => 'Знания';

  @override
  String get newsTabTechnicalAnalysis => 'Технический анализ';

  @override
  String noArticlesForCategory(Object category) {
    return 'Нет статей для категории $category';
  }

  @override
  String get mostPopular => 'Самое популярное';

  @override
  String get noPosts => 'Нет постов';

  @override
  String get relatedArticles => 'Похожие статьи';

  @override
  String get contactInfoSentSuccess =>
      'Контактная информация успешно отправлена.';

  @override
  String contactInfoSentFailed(Object error) {
    return 'Не удалось отправить информацию: $error';
  }

  @override
  String get contactPageSubtitle =>
      'Есть вопросы или нужны AI решения? Дайте нам знать, заполнив форму, и мы свяжемся с вами!';

  @override
  String get phone => 'Телефон';

  @override
  String get firstName => 'Имя';

  @override
  String get enterFirstName => 'Введите имя';

  @override
  String get lastName => 'Фамилия';

  @override
  String get enterLastName => 'Введите фамилию';

  @override
  String get whatAreYourConcerns => 'Что вас беспокоит?';

  @override
  String get writeConcernsHere => 'Напишите здесь...';

  @override
  String pleaseEnter(Object field) {
    return 'Пожалуйста, введите $field';
  }

  @override
  String get faqQuestion1 => 'Гарантируют ли сигналы 100% успех?';

  @override
  String get faqAnswer1 =>
      'Хотя ни один сигнал не может быть гарантирован на 100%, Signal GPT стремится поддерживать стабильный уровень успеха 60–80%, подкрепленный детальным анализом и управлением рисками, чтобы вы могли принимать окончательное решение с большей уверенностью.';

  @override
  String get faqQuestion2 =>
      'Если я не хочу сразу вносить депозит, могу ли я все еще получать предложения сигналов?';

  @override
  String get faqAnswer2 =>
      'При открытии счета система подарит вам 10 бесплатных токенов, что эквивалентно 10 подробным просмотрам сигналов. После этого вы будете получать 1 дополнительный токен каждый день для использования. Если вы обновите до VIP-аккаунта, вы разблокируете множество продвинутых функций и будете отслеживать неограниченное количество ордеров.';

  @override
  String get faqQuestion3 =>
      'Если я зарегистрировался, но не получил никаких сигналов, какие шаги мне предпринять?';

  @override
  String get faqAnswer3 =>
      'Обработка обычно происходит автоматически. Если вы все еще не видите предложений сигналов, пожалуйста, свяжитесь с нами через Whatsapp для мгновенной помощи.';

  @override
  String get faqQuestion4 =>
      'Сколько сигналов я буду получать в день при обновлении до VIP-аккаунта?';

  @override
  String get faqAnswer4 =>
      'При обновлении до VIP-аккаунта вы будете получать неограниченное количество торговых сигналов каждый день. Количество сигналов не фиксировано, но полностью зависит от анализа рынка. Всякий раз, когда появляется высококачественная точка входа с высокой вероятностью, команда аналитиков немедленно отправит вам сигнал.';

  @override
  String get priceLevels => 'Уровни цен';

  @override
  String get capitalManagement => 'Управление капиталом';

  @override
  String freeSignalsLeft(Object count) {
    return 'Осталось $count бесплатных сигналов';
  }

  @override
  String get unlimitedSignals => 'Неограниченные сигналы';

  @override
  String get goBack => 'Вернуться';

  @override
  String get goldPlan => 'Золотой план';

  @override
  String get perMonth => '/ месяц';

  @override
  String get continuouslyUpdating =>
      'Постоянное обновление рыночных данных 24/7';

  @override
  String get providingBestSignals =>
      'Предоставление лучших сигналов в реальном времени';

  @override
  String get includesEntrySlTp => 'Включает Вход, SL, TP';

  @override
  String get detailedAnalysis => 'Детальный анализ и оценка каждого сигнала';

  @override
  String get realTimeNotifications =>
      'Уведомления в реальном времени по электронной почте';

  @override
  String get signalPerformanceStats => 'Статистика производительности сигналов';

  @override
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails => 'Номер регистрации бизнеса: 0110057263';

  @override
  String get addressDetails =>
      'Адрес: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam';

  @override
  String get pagesTitle => 'Страницы';

  @override
  String get legalRegulatoryTitle => 'Правовые и нормативные';

  @override
  String get termsOfRegistration => 'Условия регистрации';

  @override
  String get operatingPrinciples => 'Принципы работы';

  @override
  String get termsConditions => 'Условия и положения';

  @override
  String get contactTitle => 'Контакт';

  @override
  String get navFeatures => 'Особенности';

  @override
  String get navNews => 'Новости';

  @override
  String get tp1Hit => 'TP1 Достигнут';

  @override
  String get tp2Hit => 'TP2 Достигнут';

  @override
  String get tp3Hit => 'TP3 Достигнут';

  @override
  String get slHit => 'SL Достигнут';

  @override
  String get cancelled => 'Отменено';

  @override
  String get exitedByAdmin => 'Выход осуществлен админом';

  @override
  String get signalClosed => 'Закрыто';

  @override
  String get errorLoadingPackages => 'Ошибка загрузки пакетов';

  @override
  String get monthly => 'Ежемесячно';

  @override
  String get annually => 'Ежегодно';

  @override
  String get whatsIncluded => 'Что включено:';

  @override
  String get chooseThisPlan => 'Выбрать этот план';

  @override
  String get bestPricesForPremiumAccess => 'Лучшие цены для премиум-доступа';

  @override
  String get choosePlanFitsNeeds =>
      'Выберите план, который соответствует потребностям вашего бизнеса, и начните автоматизацию с AI';

  @override
  String get save50Percent => 'СЭКОНОМЬТЕ 50%';

  @override
  String get tryDemo => 'Попробовать демо';

  @override
  String get pleaseEnterEmailPassword => 'Пожалуйста, введите email и пароль';

  @override
  String loginFailed(String error) {
    return 'Вход не удался: $error';
  }

  @override
  String get welcomeBack => 'С возвращением';

  @override
  String get signInToContinue => 'Войдите в свой аккаунт, чтобы продолжить';

  @override
  String get or => 'или';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'example123@gmail.com';

  @override
  String get password => 'Пароль';

  @override
  String get enterPassword => 'Введите пароль';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get createNewAccount => 'Создать новый аккаунт здесь!';

  @override
  String get signUp => 'Зарегистрироваться';

  @override
  String get signUpAccount => 'Зарегистрировать аккаунт';

  @override
  String get enterPersonalData =>
      'Введите свои личные данные для создания аккаунта';

  @override
  String get nameLabel => 'Имя *';

  @override
  String get enterNameHint => 'Введите имя';

  @override
  String get emailLabel => 'Email *';

  @override
  String get passwordLabel => 'Пароль *';

  @override
  String get phoneLabel => 'Телефон';

  @override
  String get continueButton => 'Продолжить';

  @override
  String get fillAllFields => 'Пожалуйста, заполните все обязательные поля.';

  @override
  String get accountCreatedSuccess => 'Аккаунт успешно создан.';

  @override
  String signUpFailed(String error) {
    return 'Регистрация не удалась: $error';
  }

  @override
  String get nationality => 'Национальность:';

  @override
  String get overview => 'Обзор';

  @override
  String get setting => 'Настройка';

  @override
  String get paymentHistory => 'История платежей';

  @override
  String get signalsPlan => 'План сигналов';

  @override
  String get aiSignalGPT => 'AI Signal GPT';

  @override
  String get yourTokens => 'Ваши токены';

  @override
  String get emailNotificationPreferences =>
      'Настройки уведомлений по электронной почте';

  @override
  String get chooseSignalNotificationTypes =>
      'Выберите, какие типы уведомлений о сигналах вы хотите получать по электронной почте';

  @override
  String get allSignalNotifications => 'Все уведомления о сигналах';

  @override
  String get cryptoSignals => 'Крипто сигналы';

  @override
  String get forexSignals => 'Forex сигналы';

  @override
  String get goldSignals => 'Золотые сигналы';

  @override
  String get updatePasswordSecure =>
      'Обновите свой пароль, чтобы обезопасить аккаунт';

  @override
  String get searchLabel => 'Поиск:';

  @override
  String get filterBy => 'Фильтровать по:';

  @override
  String get allTime => 'Все время';

  @override
  String get startDate => 'Дата начала:';

  @override
  String get endDate => 'Дата окончания:';

  @override
  String get deactivate => 'Деактивировать';

  @override
  String get unlimited => 'Неограниченно';

  @override
  String get tenLeft => '10 осталось';

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
  String get performance => 'Производительность';

  @override
  String get minvestSupport => 'Signal GPT Support';

  @override
  String get leaveMessagePart1 =>
      'Пожалуйста, оставьте сообщение, наша команда ответит как можно скорее. Вы также можете связаться ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 для быстрой поддержки.';

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
  String get signInRequired => 'Требуется вход';

  @override
  String get signInToExploreSignal =>
      'Войдите, чтобы изучить этот торговый сигнал!';

  @override
  String get activeMember => 'Активный участник';

  @override
  String get last7Days => 'Последние 7 дней';

  @override
  String get last14Days => 'Последние 14 дней';

  @override
  String get last30Days => 'Последние 30 дней';

  @override
  String get last90Days => 'Последние 90 дней';

  @override
  String get profitStatistics => 'Статистика прибыли';

  @override
  String get winrateOfAllSignals => 'Винрейт всех сигналов';

  @override
  String get daily => 'Ежедневно';

  @override
  String get weekly => 'Еженедельно';

  @override
  String get lossRate => 'Уровень убытков';

  @override
  String get signalProgress => 'Signal Progress';

  @override
  String get statusHistory => 'Status History';

  @override
  String get signalCreated => 'Signal Created';

  @override
  String get signalMatched => 'Сигнал совпал';

  @override
  String get targetReached => 'Цель достигнута';

  @override
  String get freeSignalsInfo => 'Инфо о бесплатных сигналах';

  @override
  String get freeSignalsInfoDesc =>
      'Вы будете получать 1 бесплатный сигнал в день.\nНеиспользованные сигналы переносятся на следующий день.';

  @override
  String freeSignalsCount(int count) {
    return '$count Бесплатных сигналов';
  }

  @override
  String get close => 'Закрыть';

  @override
  String validUntil(String date) {
    return 'Действительно до $date';
  }

  @override
  String get wins => 'Победы';

  @override
  String get losses => 'Поражения';

  @override
  String totalOrdersCount(int count) {
    return 'Всего: $count ордеров';
  }

  @override
  String get passwordResetEmailSent =>
      'Письмо для сброса пароля отправлено! Пожалуйста, проверьте свой почтовый ящик.';

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
