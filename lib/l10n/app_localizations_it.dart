// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'ACCOUNT AGGIORNATO CON SUCCESSO';

  @override
  String get lotPerWeek => 'Lotto/settimana';

  @override
  String get tableValueFull => 'pieno';

  @override
  String get tableValueFulltime => 'tempo pieno';

  @override
  String get packageTitle => 'PACCHETTO';

  @override
  String get duration1Month => '1 mese';

  @override
  String get duration12Months => '12 mesi';

  @override
  String get featureReceiveAllSignals => 'Ricevi tutti i segnali del giorno';

  @override
  String get featureAnalyzeReason =>
      'Analizza il motivo dell\'ingresso nell\'ordine';

  @override
  String get featureHighPrecisionAI => 'Segnale AI ad alta precisione';

  @override
  String get iapStoreNotAvailable =>
      'Il negozio non è disponibile su questo dispositivo.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'Errore nel caricamento dei prodotti: $message';
  }

  @override
  String get iapNoProductsFound =>
      'Nessun prodotto trovato. Controlla la configurazione del tuo negozio.';

  @override
  String iapTransactionError(Object message) {
    return 'Errore di transazione: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'Errore di verifica: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'Si è verificato un errore sconosciuto: $error';
  }

  @override
  String get iapProcessingTransaction => 'Elaborazione transazione...';

  @override
  String get orderInfo1Month => 'Pagamento per il pacchetto Elite 1 mese';

  @override
  String get orderInfo12Months => 'Pagamento per il pacchetto Elite 12 mesi';

  @override
  String get iapNotSupportedOnWeb =>
      'Gli acquisti in-app non sono supportati nella versione web.';

  @override
  String get vnpayPaymentTitle => 'PAGAMENTO VNPAY';

  @override
  String get creatingOrderWait => 'Creazione ordine, attendere prego...';

  @override
  String errorWithMessage(Object message) {
    return 'Errore: $message';
  }

  @override
  String get cannotConnectToServer =>
      'Impossibile connettersi al server. Riprova.';

  @override
  String get transactionCancelledOrFailed =>
      'La transazione è stata annullata o non riuscita.';

  @override
  String get cannotCreatePaymentLink =>
      'Impossibile creare il link di pagamento.\nRiprova.';

  @override
  String get retry => 'Riprova';

  @override
  String serverErrorRetry(Object message) {
    return 'Errore del server: $message. Riprova.';
  }

  @override
  String get redirectingToPayment =>
      'Reindirizzamento alla pagina di pagamento...';

  @override
  String get invalidPaymentUrl =>
      'URL di pagamento non valido ricevuto dal server.';

  @override
  String get processingYourAccount => 'Elaborazione del tuo account...';

  @override
  String get verificationFailed => 'Verifica fallita!';

  @override
  String get reuploadImage => 'Ricarica immagine';

  @override
  String get accountNotLinked => 'Account non collegato a Minvest';

  @override
  String get accountNotLinkedDesc =>
      'Per ottenere segnali esclusivi, il tuo account Exness deve essere registrato tramite il link partner Minvest. Crea un nuovo account utilizzando il link sottostante.';

  @override
  String get registerExnessViaMinvest => 'Registrati a Exness tramite Minvest';

  @override
  String get iHaveRegisteredReupload => 'Mi sono registrato, ricarica';

  @override
  String couldNotLaunch(Object url) {
    return 'Impossibile avviare $url';
  }

  @override
  String get status => 'Stato';

  @override
  String get sentOn => 'Inviato il';

  @override
  String get entryPrice => 'Prezzo di ingresso';

  @override
  String get stopLossFull => 'Stop loss';

  @override
  String get takeProfitFull1 => 'Take profit 1';

  @override
  String get takeProfitFull2 => 'Take profit 2';

  @override
  String get takeProfitFull3 => 'Take profit 3';

  @override
  String get noReasonProvided => 'Nessun motivo fornito per questo segnale.';

  @override
  String get upgradeToViewReason =>
      'Aggiorna il tuo account a Elite per visualizzare l\'analisi.';

  @override
  String get upgradeToViewFullAnalysis =>
      'Aggiorna per visualizzare l\'analisi completa';

  @override
  String get welcomeTo => 'Benvenuto in';

  @override
  String get appSlogan => 'Migliora il tuo trading con segnali intelligenti.';

  @override
  String get signIn => 'Accedi';

  @override
  String get continueByGoogle => 'Continua con Google';

  @override
  String get continueByFacebook => 'Continua con Facebook';

  @override
  String get continueByApple => 'Continua con Apple';

  @override
  String get loginSuccess => 'Accesso riuscito!';

  @override
  String get live => 'DAL VIVO';

  @override
  String get end => 'FINE';

  @override
  String get symbol => 'SIMBOLO';

  @override
  String get aiSignal => 'Segnali AI';

  @override
  String get ruleSignal => 'SEGNALE REGOLA';

  @override
  String get all => 'TUTTI';

  @override
  String get upgradeToSeeMore => 'Aggiorna per vedere di più';

  @override
  String get seeDetails => 'vedi dettagli';

  @override
  String get notMatched => 'NON CORRISPONDENTE';

  @override
  String get matched => 'CORRISPONDENTE';

  @override
  String get entry => 'Ingresso';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'Aggiorna';

  @override
  String get upgradeAccount => 'AGGIORNA ACCOUNT';

  @override
  String get compareTiers => 'CONFRONTA LIVELLI';

  @override
  String get feature => 'Funzionalità';

  @override
  String get tierDemo => 'Demo';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'Saldo';

  @override
  String get signalTime => 'Ora segnale';

  @override
  String get signalQty => 'Qtà segnale';

  @override
  String get analysis => 'Analisi';

  @override
  String get openExnessAccount => 'Apri account Exness!';

  @override
  String get accountVerificationWithExness => 'Verifica account con Exness';

  @override
  String get payInAppToUpgrade => 'Paga nell\'app per aggiornare';

  @override
  String get bankTransferToUpgrade => 'Bonifico bancario per aggiornare';

  @override
  String get accountVerification => 'VERIFICA ACCOUNT';

  @override
  String get accountVerificationPrompt =>
      'Carica uno screenshot del tuo account Exness per essere autorizzato (il tuo account deve essere aperto sotto il link Exness di Minvest)';

  @override
  String get selectPhotoFromLibrary => 'Seleziona foto dalla libreria';

  @override
  String get send => 'Invia';

  @override
  String get accountInfo => 'Informazioni account';

  @override
  String get accountVerifiedSuccessfully => 'ACCOUNT VERIFICATO CON SUCCESSO';

  @override
  String get yourAccountIs => 'Il tuo account è';

  @override
  String get returnToHomePage => 'Torna alla home page';

  @override
  String get upgradeFailed => 'Aggiornamento fallito! Ricarica l\'immagine';

  @override
  String get package => 'PACCHETTO';

  @override
  String get startNow => 'Ottieni segnali ora';

  @override
  String get bankTransfer => 'BONIFICO BANCARIO';

  @override
  String get transferInformation => 'INFORMAZIONI SUL TRASFERIMENTO';

  @override
  String get scanForFastTransfer => 'Scansiona per trasferimento rapido';

  @override
  String get contactUs247 => 'Contattaci 24/7';

  @override
  String get newAnnouncement => 'NUOVO ANNUNCIO';

  @override
  String get profile => 'Profilo';

  @override
  String get upgradeNow => 'Aggiorna ora';

  @override
  String get followMinvest => 'Segui MInvest';

  @override
  String get tabSignal => 'Segnale';

  @override
  String get tabChart => 'Grafico';

  @override
  String get tabProfile => 'Profilo';

  @override
  String get reason => 'MOTIVO';

  @override
  String get error => 'Errore';

  @override
  String get noSignalsAvailable => 'Nessun segnale disponibile.';

  @override
  String get outOfGoldenHours => 'Fuori dalle Golden Hours';

  @override
  String get outOfGoldenHoursVipDesc =>
      'I segnali VIP sono disponibili dalle 8:00 alle 17:00 (GMT+7).\nAggiorna a Elite per ottenere segnali 24/24!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'I segnali Demo sono disponibili dalle 8:00 alle 17:00 (GMT+7).\nAggiorna il tuo account per ulteriori vantaggi!';

  @override
  String get yourName => 'Il tuo nome';

  @override
  String get yourEmail => 'tua.email@esempio.com';

  @override
  String get adminPanel => 'Pannello di amministrazione';

  @override
  String get logout => 'Disconnetti';

  @override
  String get confirmLogout => 'Conferma disconnessione';

  @override
  String get confirmLogoutMessage => 'Sei sicuro di voler uscire?';

  @override
  String get cancel => 'Annulla';

  @override
  String get upgradeCardTitle => 'AGGIORNA IL TUO ACCOUNT';

  @override
  String get upgradeCardSubtitle => 'Per accedere a più risorse';

  @override
  String get upgradeCardSubtitleWeb =>
      'Per sbloccare segnali premium e supporto a tempo pieno';

  @override
  String get subscriptionDetails => 'Dettagli abbonamento';

  @override
  String get notifications => 'Notifiche';

  @override
  String get continueAsGuest => 'Continua come ospite';

  @override
  String get deleteAccount => 'Elimina account';

  @override
  String get deleteAccountWarning =>
      'Sei sicuro di voler eliminare il tuo account? Tutti i tuoi dati verranno cancellati in modo permanente e non potranno essere recuperati.';

  @override
  String get delete => 'Elimina';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get termsOfService => 'Termini di servizio';

  @override
  String get signalStatusMatched => 'CORRISPONDENTE';

  @override
  String get signalStatusNotMatched => 'NON CORRISPONDENTE';

  @override
  String get signalStatusCancelled => 'ANNULLATO';

  @override
  String get signalStatusSlHit => 'SL COLPITO';

  @override
  String get signalStatusTp1Hit => 'TP1 COLPITO';

  @override
  String get signalStatusTp2Hit => 'TP2 COLPITO';

  @override
  String get signalStatusTp3Hit => 'TP3 COLPITO';

  @override
  String get signalStatusRunning => 'IN CORSO';

  @override
  String get signalStatusClosed => 'CHIUSO';

  @override
  String get contactUs => 'Contattaci';

  @override
  String get tabChat => 'Chat';

  @override
  String get exnessUpgradeNoteForIos =>
      'Per i clienti che hanno registrato un account Exness tramite Minvest, fare clic su contattaci per aggiornare il proprio account.';

  @override
  String get chatWelcomeTitle => '👋 Benvenuto in Signal GPT!';

  @override
  String get chatWelcomeBody1 =>
      'Lascia un messaggio, il nostro team risponderà il prima possibile.';

  @override
  String get chatWelcomeBody2 =>
      'Oppure contattaci direttamente via Zalo/WhatsApp: ';

  @override
  String get chatWelcomeBody3 => ' per un supporto più rapido!';

  @override
  String get chatLoginPrompt => 'Accedi per utilizzare questa funzione';

  @override
  String get chatStartConversation => 'Inizia la tua conversazione';

  @override
  String get chatNoMessages => 'Nessun messaggio ancora.';

  @override
  String get chatTypeMessage => 'Scrivi un messaggio...';

  @override
  String get chatSupportIsTyping => 'Il supporto sta scrivendo...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName sta scrivendo...';
  }

  @override
  String get chatSeen => 'Visto';

  @override
  String get chatDefaultUserName => 'Utente';

  @override
  String get chatDefaultSupportName => 'Supporto';

  @override
  String get signalEntry => 'Ingresso';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      'Per i trader stranieri, contattaci tramite WhatsApp (+84969.15.6969) per supporto';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails =>
      'Aggiorna per vedere i dettagli del segnale...';

  @override
  String get buy => 'COMPRA';

  @override
  String get sell => 'VENDI';

  @override
  String get logoutDialogTitle => 'Sessione scaduta';

  @override
  String get logoutDialogDefaultReason =>
      'Il tuo account ha effettuato l\'accesso su un altro dispositivo.';

  @override
  String get ok => 'OK';

  @override
  String get contactToUpgrade => 'Contatta per aggiornare';

  @override
  String get noNotificationsYet => 'Nessuna notifica ancora.';

  @override
  String daysAgo(int count) {
    return '$count giorni fa';
  }

  @override
  String hoursAgo(int count) {
    return '$count ore fa';
  }

  @override
  String minutesAgo(int count) {
    return '$count minuti fa';
  }

  @override
  String get justNow => 'Proprio ora';

  @override
  String get getSignalsNow => 'Ottieni segnali ora';

  @override
  String get freeTrial => 'Prova gratuita';

  @override
  String get heroTitle => 'Guidare i trader e far crescere i portafogli';

  @override
  String get heroSubtitle =>
      'Il motore AI definitivo – Progettato da trader esperti';

  @override
  String get globalAiInnovationTitle =>
      'Innovazione AI globale per la prossima generazione di trading intelligence';

  @override
  String get globalAiInnovationDesc =>
      'Trasformare il trading tradizionale con segnali AI basati su cloud — adattivi alle notizie di mercato e alle tendenze in tempo reale\nper prestazioni più veloci, precise e prive di emozioni.';

  @override
  String get liveTradingSignalsTitle => 'DAL VIVO – Segnali di trading AI 24/7';

  @override
  String get liveTradingSignalsDesc =>
      'Analisi cloud in tempo reale che offrono strategie ad alta probabilità e trend-following con precisione adattiva ed esecuzione priva di emozioni.';

  @override
  String get trendFollowing => 'Trend-Following';

  @override
  String get realtime => 'Tempo reale';

  @override
  String get orderExplanationEngineTitle =>
      'Motore di spiegazione degli ordini';

  @override
  String get orderExplanationEngineDesc =>
      'Spiega le configurazioni di trading in termini semplici — mostrando come si formano le confluenze, perché vengono effettuati gli ingressi e aiutando i trader a imparare da ogni decisione.';

  @override
  String get transparent => 'Trasparente';

  @override
  String get educational => 'Educativo';

  @override
  String get logical => 'Logico';

  @override
  String get transparentRealPerformanceTitle =>
      'Trasparente - Prestazioni reali';

  @override
  String get transparentRealPerformanceDesc =>
      'Vedi dati reali sulla precisione del segnale, tasso di successo e redditività — verificati e tracciabili in ogni operazione';

  @override
  String get results => 'Risultati';

  @override
  String get performanceTracking => 'Tracciamento delle prestazioni';

  @override
  String get accurate => 'Accurato';

  @override
  String get predictiveAccuracy => 'Precisione predittiva';

  @override
  String get improvementInProfitability => 'Miglioramento della redditività';

  @override
  String get improvedRiskManagement => 'Gestione del rischio migliorata';

  @override
  String get signalsPerformanceTitle => 'Prestazioni dei segnali';

  @override
  String get riskToRewardRatio => 'Rapporto rischio-rendimento';

  @override
  String get howRiskComparesToReward =>
      'Come il rischio si confronta con la ricompensa';

  @override
  String get profitLossOverview => 'Panoramica profitti/perdite';

  @override
  String get netGainVsLoss => 'Guadagno netto vs perdita';

  @override
  String get winRate => 'Tasso di vincita';

  @override
  String get percentageOfWinningTrades => 'Percentuale di operazioni vincenti';

  @override
  String get accuracyRate => 'Tasso di precisione';

  @override
  String get howPreciseOurSignalsAre => 'Quanto sono precisi i nostri segnali';

  @override
  String get realtimeMarketAnalysis => 'Analisi di mercato in tempo reale';

  @override
  String get realtimeMarketAnalysisDesc =>
      'La nostra AI monitora costantemente il mercato, identificando zone di convergenza tecnica e punti di breakout affidabili in modo da poter entrare nelle operazioni al momento giusto.';

  @override
  String get saveTimeOnAnalysis => 'Risparmia tempo sull\'analisi';

  @override
  String get saveTimeOnAnalysisDesc =>
      'Niente più ore passate a leggere grafici. Ricevi strategie di investimento su misura in pochi minuti al giorno.';

  @override
  String get minimizeEmotionalTrading => 'Riduci al minimo il trading emotivo';

  @override
  String get minimizeEmotionalTradingDesc =>
      'Con avvisi intelligenti, rilevamento dei rischi e segnali basati sui dati non sulle emozioni rimani disciplinato e hai il controllo di ogni decisione.';

  @override
  String get seizeEveryOpportunity => 'Cogli ogni opportunità';

  @override
  String get seizeEveryOpportunityDesc =>
      'Aggiornamenti strategici tempestivi consegnati direttamente nella tua casella di posta assicurano che tu cavalchi le tendenze del mercato al momento perfetto.';

  @override
  String get minvestAiCoreValueTitle => 'Signal GPT - Valore fondamentale';

  @override
  String get minvestAiCoreValueDesc =>
      'L\'AI analizza continuamente i dati di mercato in tempo reale, filtrando le informazioni per identificare opportunità di investimento rapide e accurate';

  @override
  String get frequentlyAskedQuestions => 'Domande frequenti (FAQ)';

  @override
  String get faqSubtitle =>
      'Tutte le tue domande — da come iscriverti, ai vantaggi, a come funziona la nostra AI — trovano risposta qui sotto. Se hai ancora dubbi, sentiti libero di inviarci un messaggio su Whatsapp';

  @override
  String get maximizeResultsTitle =>
      'Massimizza i tuoi risultati con Signal GPT\nanalsi di mercato avanzata e segnali filtrati con precisione';

  @override
  String get elevateTradingWithAiStrategies =>
      'Migliora il tuo trading con strategie potenziate dall\'AI create per coerenza e chiarezza';

  @override
  String get winMoreWithAiSignalsTitle =>
      'Vinci di più con segnali basati sull\'AI\nin ogni mercato';

  @override
  String get winMoreWithAiSignalsDesc =>
      'La nostra AI multi-mercato scansiona Forex, Cripto e Metalli in tempo reale,\nfornendo segnali di trading convalidati da esperti —\ncon chiari livelli di ingresso, stop-loss e take-profit';

  @override
  String get buyLimit => 'Limite di acquisto';

  @override
  String get sellLimit => 'Limite di vendita';

  @override
  String get smarterToolsTitle =>
      'Strumenti più intelligenti - Investimenti migliori';

  @override
  String get smarterToolsDesc =>
      'Scopri le funzionalità che ti aiutano a ridurre al minimo i rischi, cogliere le opportunità e far crescere la tua ricchezza';

  @override
  String get performanceOverviewTitle => 'Panoramica delle prestazioni';

  @override
  String get performanceOverviewDesc =>
      'La nostra AI multi-mercato scansiona Forex, Cripto e Metalli in tempo reale, fornendo segnali di trading convalidati da esperti - con chiari livelli di ingresso, stop-loss e take-profit';

  @override
  String get totalProfit => 'Profitto totale';

  @override
  String get completionSignal => 'Segnale di completamento';

  @override
  String get onDemandFinancialExpertTitle =>
      'Il tuo esperto finanziario on-demand';

  @override
  String get onDemandFinancialExpertDesc =>
      'La piattaforma AI suggerisce segnali di trading - autoapprendimento, analizza il mercato 24/7, non influenzato dalle emozioni. Minvest ha supportato oltre 10.000 analisti finanziari nel loro viaggio per trovare segnali accurati, stabili e facili da applicare';

  @override
  String get aiPoweredSignalPlatform =>
      'Piattaforma di segnali di trading basata su AI';

  @override
  String get selfLearningSystems =>
      'Sistemi di autoapprendimento, intuizioni più nitide, scambi più forti';

  @override
  String get emotionlessExecution =>
      'Esecuzione senza emozioni per un trading più intelligente e disciplinato';

  @override
  String get analysingMarket247 => 'Analisi del mercato 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Massimizza i tuoi risultati con Signal GPT\nanalsi di mercato avanzata e segnali filtrati con precisione';

  @override
  String get minvestAiRegistrationDesc =>
      'La registrazione a Signal GPT è ora aperta — i posti potrebbero chiudere presto mentre esaminiamo e approviamo nuovi membri';

  @override
  String get currencyPairs => 'Merce';

  @override
  String get allCurrencyPairs => 'Tutte le coppie di valute';

  @override
  String get allCommodities => 'Tutte le merci';

  @override
  String get allCryptoPairs => 'Tutte le coppie cripto';

  @override
  String get dateRange => 'Intervallo di date';

  @override
  String get selectDateRange => 'Seleziona intervallo di date';

  @override
  String get allAssets => 'Tutti gli asset';

  @override
  String get asset => 'Asset';

  @override
  String get tokenExpired => 'Token scaduto';

  @override
  String get tokenLimitReachedDesc =>
      'Hai esaurito i tuoi 10 token gratuiti oggi. Aggiorna il tuo pacchetto per visualizzare più segnali.';

  @override
  String get later => 'Più tardi';

  @override
  String get created => 'Creato';

  @override
  String get detail => 'Dettaglio';

  @override
  String get performanceOverview => 'Panoramica delle prestazioni';

  @override
  String get totalProfitPips => 'Profitto totale (Pips)';

  @override
  String get winRatePercent => 'Tasso di vincita (%)';

  @override
  String get comingSoon => 'Prossimamente';

  @override
  String get errorLoadingHistory => 'Errore nel caricamento della cronologia';

  @override
  String get noHistoryAvailable => 'Nessuna cronologia segnali disponibile';

  @override
  String get previous => 'Precedente';

  @override
  String get page => 'Pagina';

  @override
  String get next => 'Successivo';

  @override
  String get date => 'Data';

  @override
  String get timeGmt7 => 'Ora (GMT)';

  @override
  String get orders => 'Ordini';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      'Schermo piccolo: ruota in orizzontale o scorri orizzontalmente per visualizzare la tabella completa.';

  @override
  String get history => 'Cronologia';

  @override
  String get signalsWillAppearHere =>
      'I segnali appariranno qui quando disponibili';

  @override
  String get pricing => 'Prezzi';

  @override
  String get choosePlanSubtitle => 'Scegli un piano adatto a te';

  @override
  String get financialNewsHub => 'Hub di notizie finanziarie';

  @override
  String get financialNewsHubDesc =>
      'Aggiornamenti critici. Reazioni del mercato. Nessun rumore – solo ciò che gli investitori devono sapere.';

  @override
  String get newsTabAllArticles => 'Tutti gli articoli';

  @override
  String get newsTabInvestor => 'Investitore';

  @override
  String get newsTabKnowledge => 'Conoscenza';

  @override
  String get newsTabTechnicalAnalysis => 'Analisi tecnica';

  @override
  String noArticlesForCategory(Object category) {
    return 'Nessun articolo per la categoria $category';
  }

  @override
  String get mostPopular => 'Più popolare';

  @override
  String get noPosts => 'Nessun post';

  @override
  String get relatedArticles => 'Articoli correlati';

  @override
  String get contactInfoSentSuccess =>
      'Informazioni di contatto inviate con successo.';

  @override
  String contactInfoSentFailed(Object error) {
    return 'Impossibile inviare le informazioni: $error';
  }

  @override
  String get contactPageSubtitle =>
      'Hai domande o hai bisogno di soluzioni AI? Facci sapere compilando il modulo e ti contatteremo!';

  @override
  String get phone => 'Telefono';

  @override
  String get firstName => 'Nome';

  @override
  String get enterFirstName => 'Inserisci nome';

  @override
  String get lastName => 'Cognome';

  @override
  String get enterLastName => 'Inserisci cognome';

  @override
  String get whatAreYourConcerns => 'Quali sono le tue preoccupazioni?';

  @override
  String get writeConcernsHere => 'Scrivi le preoccupazioni qui...';

  @override
  String pleaseEnter(Object field) {
    return 'Inserisci $field';
  }

  @override
  String get faqQuestion1 =>
      'I segnali garantiscono un tasso di successo del 100%?';

  @override
  String get faqAnswer1 =>
      'Sebbene nessun segnale possa essere garantito al 100%, Signal GPT si impegna a mantenere un tasso di successo stabile del 60–80%, supportato da analisi dettagliate e gestione del rischio in modo da poter prendere la decisione finale con maggiore sicurezza.';

  @override
  String get faqQuestion2 =>
      'Se non voglio depositare subito, posso comunque ricevere suggerimenti sui segnali?';

  @override
  String get faqAnswer2 =>
      'All\'apertura di un account, il sistema ti regalerà 10 token gratuiti, equivalenti a 10 visualizzazioni dettagliate dei segnali. Dopodiché, riceverai 1 token aggiuntivo ogni giorno da utilizzare. Se aggiorni a un account VIP, sbloccherai molte funzionalità avanzate e traccerai un numero illimitato di ordini.';

  @override
  String get faqQuestion3 =>
      'Se mi sono registrato ma non ho ricevuto alcun segnale, quali passaggi devo intraprendere?';

  @override
  String get faqAnswer3 =>
      'L\'elaborazione è in genere automatica. Se non vedi ancora alcun suggerimento di segnale, contattaci tramite Whatsapp per assistenza immediata.';

  @override
  String get faqQuestion4 =>
      'Quanti segnali riceverò al giorno aggiornando a un account VIP?';

  @override
  String get faqAnswer4 =>
      'Quando aggiorni a un account VIP, riceverai segnali di trading illimitati ogni giorno. Il numero di segnali non è fisso ma dipende interamente dall\'analisi di mercato. Ogni volta che appare un punto di ingresso di alta qualità e alta probabilità, il team di analisi ti invierà immediatamente il segnale.';

  @override
  String get priceLevels => 'Livelli di prezzo';

  @override
  String get capitalManagement => 'Gestione del capitale';

  @override
  String freeSignalsLeft(Object count) {
    return '$count segnali gratuiti rimasti';
  }

  @override
  String get unlimitedSignals => 'Segnali illimitati';

  @override
  String get goBack => 'Indietro';

  @override
  String get goldPlan => 'Piano Gold';

  @override
  String get perMonth => '/ mese';

  @override
  String get continuouslyUpdating =>
      'Aggiornamento continuo dei dati di mercato 24/7';

  @override
  String get providingBestSignals =>
      'Fornire i migliori segnali in tempo reale';

  @override
  String get includesEntrySlTp => 'Include Ingresso, SL, TP';

  @override
  String get detailedAnalysis =>
      'Analisi dettagliata e valutazione di ogni segnale';

  @override
  String get realTimeNotifications => 'Notifiche in tempo reale via email';

  @override
  String get signalPerformanceStats =>
      'Statistiche sulle prestazioni del segnale';

  @override
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails =>
      'Numero di registrazione aziendale: 0110057263';

  @override
  String get addressDetails =>
      'Indirizzo: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam';

  @override
  String get pagesTitle => 'Pagine';

  @override
  String get legalRegulatoryTitle => 'Legale e normativo';

  @override
  String get termsOfRegistration => 'Termini di registrazione';

  @override
  String get operatingPrinciples => 'Principi operativi';

  @override
  String get termsConditions => 'Termini e condizioni';

  @override
  String get contactTitle => 'Contatto';

  @override
  String get navFeatures => 'Funzionalità';

  @override
  String get navNews => 'Notizie';

  @override
  String get tp1Hit => 'TP1 Colpito';

  @override
  String get tp2Hit => 'TP2 Colpito';

  @override
  String get tp3Hit => 'TP3 Colpito';

  @override
  String get slHit => 'SL Colpito';

  @override
  String get cancelled => 'Annullato';

  @override
  String get exitedByAdmin => 'Uscito da Admin';

  @override
  String get signalClosed => 'Chiuso';

  @override
  String get errorLoadingPackages => 'Errore nel caricamento dei pacchetti';

  @override
  String get monthly => 'Mensile';

  @override
  String get annually => 'Annuale';

  @override
  String get whatsIncluded => 'Cosa è incluso:';

  @override
  String get chooseThisPlan => 'Scegli questo piano';

  @override
  String get bestPricesForPremiumAccess =>
      'Migliori prezzi per l\'accesso Premium';

  @override
  String get choosePlanFitsNeeds =>
      'Scegli un piano adatto alle tue esigenze aziendali e inizia ad automatizzare con l\'AI';

  @override
  String get save50Percent => 'RISPARMIA 50%';

  @override
  String get tryDemo => 'Prova demo';

  @override
  String get pleaseEnterEmailPassword =>
      'Si prega di inserire email e password';

  @override
  String loginFailed(String error) {
    return 'Accesso fallito: $error';
  }

  @override
  String get welcomeBack => 'Bentornato';

  @override
  String get signInToContinue => 'Accedi al tuo account per continuare';

  @override
  String get or => 'o';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'esempio123@gmail.com';

  @override
  String get password => 'Password';

  @override
  String get enterPassword => 'Inserisci password';

  @override
  String get forgotPassword => 'Password dimenticata?';

  @override
  String get createNewAccount => 'Crea nuovo account qui!';

  @override
  String get signUp => 'Iscriviti';

  @override
  String get signUpAccount => 'Iscriviti Account';

  @override
  String get enterPersonalData =>
      'Inserisci i tuoi dati personali per creare il tuo account';

  @override
  String get nameLabel => 'Nome *';

  @override
  String get enterNameHint => 'Inserisci Nome';

  @override
  String get emailLabel => 'Email *';

  @override
  String get passwordLabel => 'Password *';

  @override
  String get phoneLabel => 'Telefono';

  @override
  String get continueButton => 'Continua';

  @override
  String get fillAllFields =>
      'Si prega di compilare tutti i campi obbligatori.';

  @override
  String get accountCreatedSuccess => 'Account creato con successo.';

  @override
  String signUpFailed(String error) {
    return 'Iscrizione fallita: $error';
  }

  @override
  String get nationality => 'Nazionalità:';

  @override
  String get overview => 'Panoramica';

  @override
  String get setting => 'Impostazione';

  @override
  String get paymentHistory => 'Cronologia pagamenti';

  @override
  String get signalsPlan => 'Piano segnali';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => 'I tuoi token';

  @override
  String get emailNotificationPreferences => 'Preferenze di notifica email';

  @override
  String get chooseSignalNotificationTypes =>
      'Scegli quali tipi di notifiche di segnale desideri ricevere via email';

  @override
  String get allSignalNotifications => 'Tutte le notifiche di segnale';

  @override
  String get cryptoSignals => 'Segnali Cripto';

  @override
  String get forexSignals => 'Segnali Forex';

  @override
  String get goldSignals => 'Segnali Oro';

  @override
  String get updatePasswordSecure =>
      'Aggiorna la tua password per proteggere il tuo account';

  @override
  String get searchLabel => 'Cerca:';

  @override
  String get filterBy => 'Filtra per:';

  @override
  String get allTime => 'Tutto il tempo';

  @override
  String get startDate => 'Data di inizio:';

  @override
  String get endDate => 'Data di fine:';

  @override
  String get deactivate => 'Disattiva';

  @override
  String get unlimited => 'Illimitato';

  @override
  String get tenLeft => '10 rimasti';

  @override
  String get termsOfRegistrationContent =>
      'Please read all the terms and agreements below carefully before proceeding with the next steps in our system.\nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\n1. Introduction and Scope of Application\n\nThis policy regulates the collection, use, sharing, and protection of users’ personal information when accessing and using the products and services of the Signal GPT system – a technology and artificial intelligence platform owned and operated by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED (hereinafter referred to as \"we\" or \"us\").\nBy registering an account or using Signal GPT’s products, you agree that such action constitutes a legally binding commitment between you and us, equivalent to an electronic contract.\n\n2. Account Registration\n\nTo access and use certain services on Signal GPT, you must register a valid account.\nWhen registering, you are required to provide complete and accurate personal information, including your full name, email address, phone number, or any other information as requested.\nAfter registration, you must confirm your email to activate the account. All notifications about your account, promotions, or system updates will be sent to this email address.\nIf the information you provide is inaccurate or incomplete, you will be solely responsible for any incidents or damages arising from it.\n\n3. Terms of Use\n\nWhen participating in the Signal GPT system, you are obligated to comply with all of the following:\nThe operating principles of the platform;\nPayment terms;\nPersonal data privacy policy;\nRelevant laws and regulations in effect.\nIn the event of a violation, EZTRADE reserves the right to temporarily suspend or permanently delete your account, and may transfer the case to competent authorities if necessary.\n\n4. Personal Data Privacy Policy\n\n4.1. Purpose and Scope of ... [truncated]';

  @override
  String get operatingPrinciplesContent =>
      'Please read all terms and agreements below carefully before proceeding with the next steps in our system. \nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\nOPERATING RULES\n\n1. Legal Information\n\nSystem Owner:\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness/Tax Code: 0110057263\nPhone: 0862 600 626\n\n2. Scope of Application\n\nThese Operating Principles apply to all users, learners, partners, and collaborators who participate in or use the products and services within the Signal GPT system, including websites, applications, training platforms, and other online channels managed by EZTRADE.\nBy registering an account or using the services of Signal GPT, users are deemed to have read, understood, and agreed to all the terms set forth in these regulations.\n\n3. Definitions\n\n\"Signal GPT\" refers to the technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED.\n\"Customer\" / \"User\" / \"Learner\" refers to any individual or organization that registers, accesses, or uses the services and products on the Signal GPT system.\n\"We\" / \"Administration\" refers to the management team representing EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED, responsible for operating and managing the system.\n\"Products\" / \"Services\" include learning packages, analytical newsletters, AI trading signals, analytical tools, or any digital content provided by Signal GPT.\n\n4. Usage Rules and Information Security\n\nUsers must provide accurate and complete information when registering an account.\nSignal GPT is committed to protecting personal information and will not disclose it to third parties unless required by competent authorities.\nUsers are responsible for maintaining the confidentiality of their account and pa... [truncated]';

  @override
  String get termsAndConditionsContent =>
      'By registering an account to participate in the Signal GPT system, you confirm that you have read, understood, and agreed to all the contents of these Account Opening Terms and Conditions.\nThe latest updates (if any) will be published here, and Signal GPT will not send separate notifications to each customer. Therefore, please visit this page regularly to stay informed about the most recent policies.\n\n1. General Agreement\n\nSignal GPT is a technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED. By opening an account on this system, you agree to participate in and use the services and products provided by EZTRADE.\nAccount registration and activation are considered an electronic contract between you and Signal GPT, which has the same legal validity as a civil contract under the laws of Vietnam.\n\n2. Personal Account Information and Privacy\n\n2.1. Purpose and Scope of Information Collection\n\nTo access and use certain Signal GPT services, you must provide basic personal information, including:\nFull name;\nEmail address;\nContact phone number;\nOther information (if any) necessary for verification, support, or access authorization.\nAll information provided must be accurate, truthful, and lawful. Signal GPT shall not be responsible for any losses or disputes arising from false, missing, or fraudulent information provided by the user.\nAdditionally, the system may automatically collect certain technical data, such as:\nIP address, browser type, and language used;\nAccess time and pages viewed within the system.\nThis information helps Signal GPT improve performance, enhance security, and optimize user experience.\n\n2.2. Scope of Information Use\n\nYour personal information is collected and used for legitimate purposes, including:\nManaging accounts, verifying users, and maintaining services;\nSending notifications related to services, accounts, promotions, or policy changes;\nProv... [truncated]';

  @override
  String get performance => 'Prestazioni';

  @override
  String get minvestSupport => 'SignalGpt Support';

  @override
  String get leaveMessagePart1 =>
      'Lascia un messaggio, il nostro team risponderà il prima possibile. Puoi anche contattare ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 per un supporto rapido.';

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
  String get signInRequired => 'Accesso richiesto';

  @override
  String get signInToExploreSignal =>
      'Accedi per esplorare questo segnale di trading!';
}
