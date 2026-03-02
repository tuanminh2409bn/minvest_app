// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'KONTO OPGRADERET MED SUCCES';

  @override
  String get lotPerWeek => 'Lot/uge';

  @override
  String get tableValueFull => 'fuld';

  @override
  String get tableValueFulltime => 'fuldtid';

  @override
  String get packageTitle => 'PAKKE';

  @override
  String get duration1Month => '1 måned';

  @override
  String get duration12Months => '12 måneder';

  @override
  String get featureReceiveAllSignals => 'Modtag alle dagens signaler';

  @override
  String get featureAnalyzeReason => 'Analyser årsagen til ordreindgang';

  @override
  String get featureHighPrecisionAI => 'Højpræcisions AI-signal';

  @override
  String get iapStoreNotAvailable =>
      'Butikken er ikke tilgængelig på denne enhed.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'Fejl ved indlæsning af produkter: $message';
  }

  @override
  String get iapNoProductsFound =>
      'Ingen produkter fundet. Tjek venligst din butikskonfiguration.';

  @override
  String iapTransactionError(Object message) {
    return 'Transaktionsfejl: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'Bekræftelsesfejl: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'Der opstod en ukendt fejl: $error';
  }

  @override
  String get iapProcessingTransaction => 'Behandler transaktion...';

  @override
  String get orderInfo1Month => 'Betaling for Elite 1 måneds pakke';

  @override
  String get orderInfo12Months => 'Betaling for Elite 12 måneders pakke';

  @override
  String get iapNotSupportedOnWeb =>
      'Køb i appen understøttes ikke på webversionen.';

  @override
  String get vnpayPaymentTitle => 'VNPAY BETALING';

  @override
  String get creatingOrderWait => 'Opretter ordre, vent venligst...';

  @override
  String errorWithMessage(Object message) {
    return 'Fejl: $message';
  }

  @override
  String get cannotConnectToServer =>
      'Kan ikke oprette forbindelse til serveren. Prøv venligst igen.';

  @override
  String get transactionCancelledOrFailed =>
      'Transaktionen er blevet annulleret eller mislykkedes.';

  @override
  String get cannotCreatePaymentLink =>
      'Kunne ikke oprette betalingslink.\nPrøv igen.';

  @override
  String get retry => 'Prøv igen';

  @override
  String serverErrorRetry(Object message) {
    return 'Serverfejl: $message. Prøv venligst igen.';
  }

  @override
  String get redirectingToPayment => 'Omdirigerer til betalingsside...';

  @override
  String get invalidPaymentUrl => 'Ugyldig betalings-URL modtaget fra server.';

  @override
  String get processingYourAccount => 'Behandler din konto...';

  @override
  String get verificationFailed => 'Bekræftelse mislykkedes!';

  @override
  String get reuploadImage => 'Upload billede igen';

  @override
  String get accountNotLinked => 'Konto ikke knyttet til Signal GPT';

  @override
  String get accountNotLinkedDesc =>
      'For at få eksklusive signaler skal din Exness-konto være registreret via Signal GPT-partnerlinket. Opret venligst en ny konto ved hjælp af linket nedenfor.';

  @override
  String get registerExnessViaSignalGPT => 'Registrer Exness via Signal GPT';

  @override
  String get iHaveRegisteredReupload => 'Jeg har registreret mig, upload igen';

  @override
  String couldNotLaunch(Object url) {
    return 'Kunne ikke starte $url';
  }

  @override
  String get status => 'Status';

  @override
  String get sentOn => 'Sendt den';

  @override
  String get entryPrice => 'Indgangspris';

  @override
  String get stopLossFull => 'Stop loss';

  @override
  String get takeProfitFull1 => 'Take profit 1';

  @override
  String get takeProfitFull2 => 'Take profit 2';

  @override
  String get takeProfitFull3 => 'Take profit 3';

  @override
  String get noReasonProvided => 'Ingen årsag angivet for dette signal.';

  @override
  String get upgradeToViewReason =>
      'Opgrader din konto til Elite for at se analysen.';

  @override
  String get upgradeToViewFullAnalysis => 'Opgrader for at se fuld analyse';

  @override
  String get welcomeTo => 'Velkommen til';

  @override
  String get appSlogan => 'Forbedre din handel med intelligente signaler.';

  @override
  String get signIn => 'Log ind';

  @override
  String get continueByGoogle => 'Fortsæt med Google';

  @override
  String get continueByFacebook => 'Fortsæt med Facebook';

  @override
  String get continueByApple => 'Fortsæt med Apple';

  @override
  String get loginSuccess => 'Login succesfuldt!';

  @override
  String get live => 'LIVE';

  @override
  String get end => 'SLUT';

  @override
  String get symbol => 'SYMBOL';

  @override
  String get aiSignal => 'AI Signaler';

  @override
  String get ruleSignal => 'REGEL SIGNAL';

  @override
  String get all => 'ALLE';

  @override
  String get upgradeToSeeMore => 'Opgrader for at se mere';

  @override
  String get seeDetails => 'se detaljer';

  @override
  String get notMatched => 'IKKE MATCHET';

  @override
  String get matched => 'MATCHET';

  @override
  String get entry => 'Indgang';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'Opgrader';

  @override
  String get upgradeAccount => 'OPGRADER KONTO';

  @override
  String get compareTiers => 'SAMMENLIGN NIVEAUER';

  @override
  String get feature => 'Funktion';

  @override
  String get tierDemo => 'Demo';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'Saldo';

  @override
  String get signalTime => 'Signaltid';

  @override
  String get signalQty => 'Signal Antal';

  @override
  String get analysis => 'Analyse';

  @override
  String get openExnessAccount => 'Åbn Exness konto!';

  @override
  String get accountVerificationWithExness => 'Kontobekræftelse med Exness';

  @override
  String get payInAppToUpgrade => 'Betal i app for at opgradere';

  @override
  String get bankTransferToUpgrade => 'Bankoverførsel for at opgradere';

  @override
  String get accountVerification => 'KONTOBEKRÆFTELSE';

  @override
  String get accountVerificationPrompt =>
      'Upload venligst et skærmbillede af din Exness-konto for at blive godkendt (din konto skal være åbnet under Signal GPTs Exness-link)';

  @override
  String get selectPhotoFromLibrary => 'Vælg foto fra bibliotek';

  @override
  String get send => 'Send';

  @override
  String get accountInfo => 'Kontooplysninger';

  @override
  String get accountVerifiedSuccessfully => 'KONTO BEKRÆFTET MED SUCCES';

  @override
  String get yourAccountIs => 'Din konto er';

  @override
  String get returnToHomePage => 'Vend tilbage til startside';

  @override
  String get upgradeFailed =>
      'Opgradering mislykkedes! Upload venligst billedet igen';

  @override
  String get package => 'PAKKE';

  @override
  String get startNow => 'Få Signaler Nu';

  @override
  String get bankTransfer => 'BANKOVERFØRSEL';

  @override
  String get transferInformation => 'OVERFØRSELSINFORMATION';

  @override
  String get scanForFastTransfer => 'Scan for hurtig overførsel';

  @override
  String get contactUs247 => 'Kontakt os 24/7';

  @override
  String get newAnnouncement => 'NY BEKENDTGØRELSE';

  @override
  String get profile => 'Profil';

  @override
  String get upgradeNow => 'Opgrader Nu';

  @override
  String get followSignalGPT => 'Følg Signal GPT';

  @override
  String get tabSignal => 'Signal';

  @override
  String get tabChart => 'Diagram';

  @override
  String get tabProfile => 'Profil';

  @override
  String get reason => 'ÅRSAG';

  @override
  String get error => 'Fejl';

  @override
  String get noSignalsAvailable => 'Ingen signaler tilgængelige.';

  @override
  String get outOfGoldenHours => 'Uden for Gyldne Timer';

  @override
  String get outOfGoldenHoursVipDesc =>
      'VIP-signaler er tilgængelige fra 8:00 til 17:00 (GMT+7).\nOpgrader til Elite for at få signaler 24/24!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'Demo-signaler er tilgængelige fra 8:00 til 17:00 (GMT+7).\nOpgrader din konto for flere fordele!';

  @override
  String get yourName => 'Dit Navn';

  @override
  String get yourEmail => 'din.email@eksempel.dk';

  @override
  String get adminPanel => 'Admin Panel';

  @override
  String get logout => 'Log ud';

  @override
  String get confirmLogout => 'Bekræft Log ud';

  @override
  String get confirmLogoutMessage => 'Er du sikker på, at du vil logge ud?';

  @override
  String get cancel => 'Annuller';

  @override
  String get upgradeCardTitle => 'OPGRADER DIN KONTO';

  @override
  String get upgradeCardSubtitle => 'For at få adgang til flere ressourcer';

  @override
  String get upgradeCardSubtitleWeb =>
      'For at låse op for premium signaler og fuldtidssupport';

  @override
  String get subscriptionDetails => 'Abonnementsdetaljer';

  @override
  String get notifications => 'Notifikationer';

  @override
  String get continueAsGuest => 'Fortsæt som Gæst';

  @override
  String get deleteAccount => 'Slet Konto';

  @override
  String get deleteAccountWarning =>
      'Er du sikker på, at du vil slette din konto? Alle dine data vil blive permanent slettet og kan ikke gendannes.';

  @override
  String get delete => 'Slet';

  @override
  String get privacyPolicy => 'Privatlivspolitik';

  @override
  String get termsOfService => 'Servicevilkår';

  @override
  String get signalStatusMatched => 'MATCHET';

  @override
  String get signalStatusNotMatched => 'IKKE MATCHET';

  @override
  String get signalStatusCancelled => 'ANNULLERET';

  @override
  String get signalStatusSlHit => 'SL RAMT';

  @override
  String get signalStatusTp1Hit => 'TP1 RAMT';

  @override
  String get signalStatusTp2Hit => 'TP2 RAMT';

  @override
  String get signalStatusTp3Hit => 'TP3 RAMT';

  @override
  String get signalStatusRunning => 'KØRER';

  @override
  String get signalStatusClosed => 'LUKKET';

  @override
  String get contactUs => 'Kontakt Os';

  @override
  String get tabChat => 'Chat';

  @override
  String get exnessUpgradeNoteForIos =>
      'For kunder, der har registreret en Exness-konto via Signal GPT, skal du klikke på kontakt os for at få din konto opgraderet.';

  @override
  String get chatWelcomeTitle => '👋 Velkommen til Signal GPT!';

  @override
  String get chatWelcomeBody1 =>
      'Læg venligst en besked, vores team vil svare så hurtigt som muligt.';

  @override
  String get chatWelcomeBody2 => 'Eller kontakt os direkte via Zalo/WhatsApp: ';

  @override
  String get chatWelcomeBody3 => ' for hurtigere support!';

  @override
  String get chatLoginPrompt => 'Log venligst ind for at bruge denne funktion';

  @override
  String get chatStartConversation => 'Start din samtale';

  @override
  String get chatNoMessages => 'Ingen beskeder endnu.';

  @override
  String get chatTypeMessage => 'Skriv en besked...';

  @override
  String get chatSupportIsTyping => 'Support skriver...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName skriver...';
  }

  @override
  String get chatSeen => 'Set';

  @override
  String get chatDefaultUserName => 'Bruger';

  @override
  String get chatDefaultSupportName => 'Support';

  @override
  String get signalEntry => 'Indgang';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get price12MonthsOld => '\$920';

  @override
  String get foreignTraderSupport =>
      'For udenlandske handlende, kontakt os venligst via WhatsApp (+84969.15.6969) for support';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails => 'Opgrader for at se signaldetaljer...';

  @override
  String get buy => 'KØB';

  @override
  String get sell => 'SÆLG';

  @override
  String get logoutDialogTitle => 'Session Udløbet';

  @override
  String get logoutDialogDefaultReason =>
      'Din konto er blevet logget ind på en anden enhed.';

  @override
  String get ok => 'OK';

  @override
  String get contactToUpgrade => 'Kontakt for at opgradere';

  @override
  String get noNotificationsYet => 'Ingen notifikationer endnu.';

  @override
  String get markAllRead => 'Mark all as read';

  @override
  String daysAgo(int count) {
    return '$count dage siden';
  }

  @override
  String hoursAgo(int count) {
    return '$count timer siden';
  }

  @override
  String minutesAgo(int count) {
    return '$count minutter siden';
  }

  @override
  String get justNow => 'Lige nu';

  @override
  String get getSignalsNow => 'Få Signaler Nu';

  @override
  String get freeTrial => 'Gratis Prøveperiode';

  @override
  String get heroTitle => 'Vejleder Handlende & Vokser Porteføljer';

  @override
  String get heroSubtitle =>
      'Den Ultimative AI Motor – Designet af Ekspert Handlende';

  @override
  String get globalAiInnovationTitle =>
      'Global AI Innovation for Næste Generation af Handelsintelligens';

  @override
  String get globalAiInnovationDesc =>
      'Transformerer traditionel handel med cloud-drevne AI-signaler — tilpasset markedsnyheder og trends i realtid\nfor hurtigere, mere præcis og følelsesfri ydeevne.';

  @override
  String get liveTradingSignalsTitle => 'LIVE – 24/7 AI Handelssignaler';

  @override
  String get liveTradingSignalsDesc =>
      'Cloud-analyse i realtid leverer høj-sandsynligheds, trend-følgende strategier med adaptiv præcision og følelsesfri eksekvering.';

  @override
  String get trendFollowing => 'Trend-Følgende';

  @override
  String get realtime => 'Realtid';

  @override
  String get orderExplanationEngineTitle => 'Ordre Forklaringsmotor';

  @override
  String get orderExplanationEngineDesc =>
      'Forklarer handelsopsætninger i enkle vendinger — viser hvordan sammenløb dannes, hvorfor indgange foretages, og hjælper handlende med at lære af hver beslutning.';

  @override
  String get transparent => 'Gennemsigtig';

  @override
  String get educational => 'Lærerig';

  @override
  String get logical => 'Logisk';

  @override
  String get transparentRealPerformanceTitle => 'Gennemsigtig - Reel Ydeevne';

  @override
  String get transparentRealPerformanceDesc =>
      'Se reelle data om signalnøjagtighed, succesrate og rentabilitet — verificeret og sporbar i hver handel';

  @override
  String get results => 'Resultater';

  @override
  String get performanceTracking => 'Ydeevne-Sporing';

  @override
  String get accurate => 'Nøjagtig';

  @override
  String get predictiveAccuracy => 'Forudsigende Nøjagtighed';

  @override
  String get improvementInProfitability => 'Forbedring i Rentabilitet';

  @override
  String get improvedRiskManagement => 'Forbedret Risikostyring';

  @override
  String get signalsPerformanceTitle => 'Signaler Ydeevne';

  @override
  String get riskToRewardRatio => 'Risiko-til-Belønning Forhold';

  @override
  String get howRiskComparesToReward =>
      'Hvordan risiko sammenlignes med belønning';

  @override
  String get profitLossOverview => 'Gevinst/Tab Oversigt';

  @override
  String get netGainVsLoss => 'Netto gevinst vs tab';

  @override
  String get winRate => 'Vinderrate';

  @override
  String get percentageOfWinningTrades => 'Procentdel af vindende handler';

  @override
  String get accuracyRate => 'Nøjagtighedsrate';

  @override
  String get howPreciseOurSignalsAre => 'Hvor præcise vores signaler er';

  @override
  String get realtimeMarketAnalysis => 'Realtids Markedsanalyse';

  @override
  String get realtimeMarketAnalysisDesc =>
      'Vores AI overvåger markedet kontinuerligt, identificerer tekniske konvergenszoner og pålidelige udbrudspunkter, så du kan indgå handler på det rigtige tidspunkt.';

  @override
  String get saveTimeOnAnalysis => 'Spar Tid på Analyse';

  @override
  String get saveTimeOnAnalysisDesc =>
      'Ikke flere timer brugt på at læse diagrammer. Modtag skræddersyede investeringsstrategier på bare få minutter om dagen.';

  @override
  String get minimizeEmotionalTrading => 'Minimer Følelsesmæssig Handel';

  @override
  String get minimizeEmotionalTradingDesc =>
      'Med smarte alarmer, risikodetektion og datadrevne signaler ikke følelser forbliver du disciplineret og har kontrol over hver beslutning.';

  @override
  String get seizeEveryOpportunity => 'Grib Hver Mulighed';

  @override
  String get seizeEveryOpportunityDesc =>
      'Rettidige strategiopdateringer leveret direkte til din indbakke sikrer, at du rider med på markedstrends på det perfekte tidspunkt.';

  @override
  String get minvestAiCoreValueTitle => 'Signal GPT - Kerneværdi';

  @override
  String get minvestAiCoreValueDesc =>
      'AI analyserer markedsdata i realtid kontinuerligt, filtrerer indsigter for at identificere hurtige, præcise investeringsmuligheder';

  @override
  String get frequentlyAskedQuestions => 'Ofte Stillede Spørgsmål (FAQ)';

  @override
  String get faqSubtitle =>
      'Alle dine spørgsmål — fra hvordan man tilmelder sig, til fordelene, til hvordan vores AI fungerer — er besvaret lige nedenfor. Hvis du stadig er i tvivl, er du velkommen til at sende os en besked på Whatsapp';

  @override
  String get maximizeResultsTitle =>
      'Maksimer dine resultater med Signal GPT\navanceret markedsanalyse og præcisionsfiltrerede signaler';

  @override
  String get elevateTradingWithAiStrategies =>
      'Løft din handel med AI-forbedrede strategier skabt til konsistens og klarhed';

  @override
  String get winMoreWithAiSignalsTitle =>
      'Vind Mere med AI-Drevne Signaler\ni Hvert Marked';

  @override
  String get winMoreWithAiSignalsDesc =>
      'Vores multi-markeds AI scanner Forex, Krypto og Metaller i realtid,\nog leverer ekspertvaliderede handelssignaler —\nmed klare indgangs-, stop-loss- og take-profit-niveauer';

  @override
  String get buyLimit => 'Købsgrænse';

  @override
  String get sellLimit => 'Salgsgrænse';

  @override
  String get smarterToolsTitle => 'Smartere Værktøjer - Bedre Investeringer';

  @override
  String get smarterToolsDesc =>
      'Opdag de funktioner, der hjælper dig med at minimere risici, gribe muligheder og øge din formue';

  @override
  String get performanceOverviewTitle => 'Ydeevne Oversigt';

  @override
  String get performanceOverviewDesc =>
      'Vores multi-markeds AI scanner Forex, Krypto og Metaller i realtid og leverer ekspertvaliderede handelssignaler - med klare indgangs-, stop-loss- og take-profit-niveauer';

  @override
  String get totalProfit => 'Samlet Profit';

  @override
  String get completionSignal => 'Færdiggørelsessignal';

  @override
  String get onDemandFinancialExpertTitle =>
      'Din On-Demand Finansielle Ekspert';

  @override
  String get onDemandFinancialExpertDesc =>
      'AI-platform foreslår handelssignaler - selvlærende, analyserer markedet 24/7, upåvirket af følelser. Signal GPT har støttet over 10.000 finansielle analytikere på deres rejse for at finde præcise, stabile og let anvendelige signaler';

  @override
  String get aiPoweredSignalPlatform => 'AI-Drevet Handelssignal Platform';

  @override
  String get selfLearningSystems =>
      'Selvlærende Systemer, Skarpere Indsigter, Stærkere Handler';

  @override
  String get emotionlessExecution =>
      'Følelsesfri Eksekvering For Smartere, Mere Disciplineret Handel';

  @override
  String get analysingMarket247 => 'Analyserer markedet 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Maksimer dine resultater med Signal GPT\navanceret markedsanalyse og præcisionsfiltrerede signaler';

  @override
  String get minvestAiRegistrationDesc =>
      'Signal GPT registrering er nu åben — pladser kan lukke snart, da vi gennemgår og godkender nye medlemmer';

  @override
  String get currencyPairs => 'Råvare';

  @override
  String get allCurrencyPairs => 'Alle Valutapar';

  @override
  String get allCommodities => 'Alle Råvarer';

  @override
  String get allCryptoPairs => 'Alle Krypto Par';

  @override
  String get dateRange => 'Datointerval';

  @override
  String get selectDateRange => 'Vælg Datointerval';

  @override
  String get allAssets => 'Alle Aktiver';

  @override
  String get asset => 'Aktiv';

  @override
  String get tokenExpired => 'Token udløbet';

  @override
  String get tokenLimitReachedDesc =>
      'Du har brugt dine 10 gratis tokens i dag. Opgrader din pakke for at se flere signaler.';

  @override
  String get later => 'Senere';

  @override
  String get created => 'Oprettet';

  @override
  String get detail => 'Detalje';

  @override
  String get performanceOverview => 'Ydeevne Oversigt';

  @override
  String get totalProfitPips => 'Samlet Profit (Pips)';

  @override
  String get winRatePercent => 'Vinderrate (%)';

  @override
  String get comingSoon => 'Kommer snart';

  @override
  String get errorLoadingHistory => 'Fejl ved indlæsning af historik';

  @override
  String get noHistoryAvailable => 'Ingen signalhistorik tilgængelig';

  @override
  String get previous => 'Forrige';

  @override
  String get page => 'Side';

  @override
  String get next => 'Næste';

  @override
  String get date => 'Dato';

  @override
  String get timeGmt7 => 'Tid';

  @override
  String get orders => 'Ordrer';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      'Lille skærm: roter landskab eller scroll vandret for at se hele tabellen.';

  @override
  String get history => 'Historik';

  @override
  String get signalsWillAppearHere =>
      'Signaler vil vises her, når de er tilgængelige';

  @override
  String get pricing => 'Prissætning';

  @override
  String get choosePlanSubtitle => 'Vælg en plan, der fungerer for dig';

  @override
  String get financialNewsHub => 'Finansiel Nyheds Hub';

  @override
  String get financialNewsHubDesc =>
      'Kritiske opdateringer. Markedsreaktioner. Ingen støj – kun hvad investorer har brug for at vide.';

  @override
  String get newsTabAllArticles => 'Alle Artikler';

  @override
  String get newsTabInvestor => 'Investor';

  @override
  String get newsTabKnowledge => 'Viden';

  @override
  String get newsTabTechnicalAnalysis => 'Teknisk Analyse';

  @override
  String noArticlesForCategory(Object category) {
    return 'Ingen artikler for kategori $category';
  }

  @override
  String get mostPopular => 'Mest populær';

  @override
  String get noPosts => 'Ingen indlæg';

  @override
  String get relatedArticles => 'Relaterede artikler';

  @override
  String get contactInfoSentSuccess => 'Kontaktoplysninger sendt med succes.';

  @override
  String contactInfoSentFailed(Object error) {
    return 'Kunne ikke sende oplysninger: $error';
  }

  @override
  String get contactPageSubtitle =>
      'Har du spørgsmål eller brug for AI-løsninger? Lad os vide det ved at udfylde formularen, og vi kontakter dig!';

  @override
  String get phone => 'Telefon';

  @override
  String get firstName => 'Fornavn';

  @override
  String get enterFirstName => 'Indtast Fornavn';

  @override
  String get lastName => 'Efternavn';

  @override
  String get enterLastName => 'Indtast Efternavn';

  @override
  String get whatAreYourConcerns => 'Hvad er dine bekymringer?';

  @override
  String get writeConcernsHere => 'Skriv bekymringer her...';

  @override
  String pleaseEnter(Object field) {
    return 'Indtast venligst $field';
  }

  @override
  String get faqQuestion1 => 'Sikrer signalerne en 100% succesrate?';

  @override
  String get faqAnswer1 =>
      'Mens intet signal kan garanteres 100%, stræber Signal GPT efter at opretholde en stabil 60–80% succesrate, understøttet af detaljeret analyse og risikostyring, så du kan træffe den endelige beslutning med større tillid.';

  @override
  String get faqQuestion2 =>
      'Hvis jeg ikke ønsker at indbetale med det samme, kan jeg så stadig modtage signalforslag?';

  @override
  String get faqAnswer2 =>
      'Når du åbner en konto, vil systemet give dig 10 gratis tokens, svarende til 10 detaljerede signalvisninger. Derefter vil du modtage 1 ekstra token hver dag at bruge. Hvis du opgraderer til en VIP-konto, låser du op for mange avancerede funktioner og sporer et ubegrænset antal ordrer.';

  @override
  String get faqQuestion3 =>
      'Hvis jeg har tilmeldt mig, men ikke modtaget nogen signaler, hvilke skridt skal jeg så tage?';

  @override
  String get faqAnswer3 =>
      'Behandling er typisk automatisk. Hvis du stadig ikke ser nogen signalforslag, bedes du kontakte os via Whatsapp for øjeblikkelig assistance.';

  @override
  String get faqQuestion4 =>
      'Hvor mange signaler vil jeg modtage om dagen, når jeg opgraderer til en VIP-konto?';

  @override
  String get faqAnswer4 =>
      'Når du opgraderer til en VIP-konto, vil du modtage ubegrænsede handelssignaler hver dag. Antallet af signaler er ikke fast, men afhænger helt af markedsanalyse. Hver gang et indgangspunkt af høj kvalitet og høj sandsynlighed vises, vil analyseteamet sende signalet til dig med det samme.';

  @override
  String get priceLevels => 'Prisniveauer';

  @override
  String get capitalManagement => 'Kapitalstyring';

  @override
  String freeSignalsLeft(Object count) {
    return '$count gratis signaler tilbage';
  }

  @override
  String get unlimitedSignals => 'Ubegrænsede signaler';

  @override
  String get goBack => 'Gå tilbage';

  @override
  String get goldPlan => 'Guld Plan';

  @override
  String get perMonth => '/ måned';

  @override
  String get continuouslyUpdating => 'Opdaterer løbende markedsdata 24/7';

  @override
  String get providingBestSignals => 'Leverer de bedste signaler i realtid';

  @override
  String get includesEntrySlTp => 'Inkluderer Indgang, SL, TP';

  @override
  String get detailedAnalysis =>
      'Detaljeret analyse og evaluering af hvert signal';

  @override
  String get realTimeNotifications => 'Realtidsnotifikationer via e-mail';

  @override
  String get signalPerformanceStats => 'Signal ydeevne statistik';

  @override
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails =>
      'Virksomhedsregistreringsnummer: 0110057263';

  @override
  String get addressDetails =>
      'Adresse: Nr. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam';

  @override
  String get pagesTitle => 'Sider';

  @override
  String get legalRegulatoryTitle => 'Juridisk & Lovgivningsmæssig';

  @override
  String get termsOfRegistration => 'Vilkår for Registrering';

  @override
  String get operatingPrinciples => 'Driftsprincipper';

  @override
  String get termsConditions => 'Vilkår & Betingelser';

  @override
  String get contactTitle => 'Kontakt';

  @override
  String get navFeatures => 'Funktioner';

  @override
  String get navNews => 'Nyheder';

  @override
  String get tp1Hit => 'TP1 Ramt';

  @override
  String get tp2Hit => 'TP2 Ramt';

  @override
  String get tp3Hit => 'TP3 Ramt';

  @override
  String get slHit => 'SL Ramt';

  @override
  String get cancelled => 'Annulleret';

  @override
  String get exitedByAdmin => 'Afsluttet af Admin';

  @override
  String get signalClosed => 'Lukket';

  @override
  String get errorLoadingPackages => 'Fejl ved Indlæsning af Pakker';

  @override
  String get monthly => 'Månedlig';

  @override
  String get annually => 'Årlig';

  @override
  String get whatsIncluded => 'Hvad er inkluderet:';

  @override
  String get chooseThisPlan => 'Vælg denne plan';

  @override
  String get bestPricesForPremiumAccess => 'Bedste Priser for Premium Adgang';

  @override
  String get choosePlanFitsNeeds =>
      'Vælg en plan, der passer til dine forretningsbehov og start automatisering med AI';

  @override
  String get save50Percent => 'SPAR 50%';

  @override
  String get tryDemo => 'Prøv demo';

  @override
  String get pleaseEnterEmailPassword =>
      'Indtast venligst email og adgangskode';

  @override
  String loginFailed(String error) {
    return 'Login mislykkedes: $error';
  }

  @override
  String get welcomeBack => 'Velkommen Tilbage';

  @override
  String get signInToContinue => 'Log ind på din konto for at fortsætte';

  @override
  String get or => 'eller';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'eksempel123@gmail.com';

  @override
  String get password => 'Adgangskode';

  @override
  String get enterPassword => 'Indtast Adgangskode';

  @override
  String get forgotPassword => 'Glemt din adgangskode?';

  @override
  String get createNewAccount => 'Opret ny konto her!';

  @override
  String get signUp => 'Tilmeld';

  @override
  String get signUpAccount => 'Tilmeld Konto';

  @override
  String get enterPersonalData =>
      'Indtast dine personlige data for at oprette din konto';

  @override
  String get nameLabel => 'Navn *';

  @override
  String get enterNameHint => 'Indtast Navn';

  @override
  String get emailLabel => 'Email *';

  @override
  String get passwordLabel => 'Adgangskode *';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get continueButton => 'Fortsæt';

  @override
  String get fillAllFields => 'Udfyld venligst alle påkrævede felter.';

  @override
  String get accountCreatedSuccess => 'Konto oprettet med succes.';

  @override
  String signUpFailed(String error) {
    return 'Tilmelding mislykkedes: $error';
  }

  @override
  String get nationality => 'Nationalitet:';

  @override
  String get overview => 'Oversigt';

  @override
  String get setting => 'Indstilling';

  @override
  String get paymentHistory => 'Betalingshistorik';

  @override
  String get signalsPlan => 'Signal Plan';

  @override
  String get aiSignalGPT => 'AI Signal GPT';

  @override
  String get yourTokens => 'Dine Tokens';

  @override
  String get emailNotificationPreferences => 'Email Notifikationspræferencer';

  @override
  String get chooseSignalNotificationTypes =>
      'Vælg hvilke typer signalnotifikationer du vil modtage via email';

  @override
  String get allSignalNotifications => 'Alle Signalnotifikationer';

  @override
  String get cryptoSignals => 'Krypto Signaler';

  @override
  String get forexSignals => 'Forex Signaler';

  @override
  String get goldSignals => 'Guld Signaler';

  @override
  String get updatePasswordSecure =>
      'Opdater din adgangskode for at holde din konto sikker';

  @override
  String get searchLabel => 'Søg:';

  @override
  String get filterBy => 'Filtrer efter:';

  @override
  String get allTime => 'Al Tid';

  @override
  String get startDate => 'Startdato:';

  @override
  String get endDate => 'Slutdato:';

  @override
  String get deactivate => 'Deaktiver';

  @override
  String get unlimited => 'Ubegrænset';

  @override
  String get tenLeft => '10 tilbage';

  @override
  String get termsOfRegistrationContent =>
      'Please read all the terms and agreements below carefully before proceeding with the next steps in our system.\nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\n1. Introduction and Scope of Application\n\nThis policy regulates the collection, use, sharing, and protection of users’ personal information when accessing and using the products and services of the Signal GPT system – a technology and artificial intelligence platform owned and operated by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED (hereinafter referred to as “we” or “us”).\nBy registering an account or using Signal GPT’s products, you agree that such action constitutes a legally binding commitment between you and us, equivalent to an electronic contract.\n\n2. Account Registration\n\nTo access and use certain services on Signal GPT, you must register a valid account.\nWhen registering, you are required to provide complete and accurate personal information, including your full name, email address, phone number, or any other information as requested.\nAfter registration, you must confirm your email to activate the account. All notifications about your account, promotions, or system updates will be sent to this email address.\nIf the information you provide is inaccurate or incomplete, you will be solely responsible for any incidents or damages arising from it.\n\n3. Terms of Use\n\nWhen participating in the Signal GPT system, you are obligated to comply with all of the following:\nThe operating principles of the platform;\nPayment terms;\nPersonal data privacy policy;\nRelevant laws and regulations in effect.\nIn the event of a violation, EZTRADE reserves the right to temporarily suspend or permanently delete your account, and may transfer the case to competent authorities if necessary.\n\n4. Personal Data Privacy Policy\n\n4.1. Purpose and Scope of ... [truncated]';

  @override
  String get operatingPrinciplesContent =>
      'Please read all terms and agreements below carefully before proceeding with the next steps in our system. \nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\nOPERATING RULES\n\n1. Legal Information\n\nSystem Owner:\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness/Tax Code: 0110057263\nPhone: 0862 600 626\n\n2. Scope of Application\n\nThese Operating Principles apply to all users, learners, partners, and collaborators who participate in or use the products and services within the Signal GPT system, including websites, applications, training platforms, and other online channels managed by EZTRADE.\nBy registering an account or using the services of Signal GPT, users are deemed to have read, understood, and agreed to all the terms set forth in these regulations.\n\n3. Definitions\n\n“Signal GPT” refers to the technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED.\n“Customer” / “User” / “Learner” refers to any individual or organization that registers, accesses, or uses the services and products on the Signal GPT system.\n“We” / “Administration” refers to the management team representing EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED, responsible for operating and managing the system.\n“Products” / “Services” include learning packages, analytical newsletters, AI trading signals, analytical tools, or any digital content provided by Signal GPT.\n\n4. Usage Rules and Information Security\n\nUsers must provide accurate and complete information when registering an account.\nSignal GPT is committed to protecting personal information and will not disclose it to third parties unless required by competent authorities.\nUsers are responsible for maintaining the confidentiality of their account and pa... [truncated]';

  @override
  String get termsAndConditionsContent =>
      'By opening an account to participate in the Signal GPT system, you confirm that you have read, understood, and agreed to all the contents of these Account Opening Terms and Conditions.\nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\n1. General Agreement\n\nSignal GPT is a technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED. By opening an account on this system, you agree to participate in and use the services and products provided by EZTRADE.\nAccount registration and activation are considered an electronic contract between you and Signal GPT, which has the same legal validity as a civil contract under the laws of Vietnam.\n\n2. Personal Account Information and Privacy\n\n2.1. Purpose and Scope of Information Collection\n\nTo access and use certain Signal GPT services, you must provide basic personal information, including:\nFull name;\nEmail address;\nContact phone number;\nOther information (if any) necessary for verification, support, or access authorization.\nAll information provided must be accurate, truthful, and lawful. Signal GPT shall not be responsible for any losses or disputes arising from false, missing, or fraudulent information provided by the user.\nAdditionally, the system may automatically collect certain technical data, such as:\nIP address, browser type, and language used;\nAccess time and pages viewed within the system.\nThis information helps Signal GPT improve performance, enhance security, and optimize user experience.\n\n2.2. Scope of Information Use\n\nYour personal information is collected and used for legitimate purposes, including:\nManaging accounts, verifying users, and maintaining services;\nSending notifications related to services, accounts, promotions, or policy changes;\nProv... [truncated]';

  @override
  String get performance => 'Ydeevne';

  @override
  String get minvestSupport => 'Signal GPT Support';

  @override
  String get leaveMessagePart1 =>
      'Læg venligst en besked, vores team vil svare så hurtigt som muligt. Du kan også kontakte ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 for hurtig support.';

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
  String get signInRequired => 'Log ind påkrævet';

  @override
  String get signInToExploreSignal =>
      'Log ind for at udforske dette handelssignal!';

  @override
  String get activeMember => 'Aktivt medlem';

  @override
  String get last7Days => 'Sidste 7 dage';

  @override
  String get last14Days => 'Sidste 14 dage';

  @override
  String get last30Days => 'Sidste 30 dage';

  @override
  String get last90Days => 'Sidste 90 dage';

  @override
  String get profitStatistics => 'Profitstatistik';

  @override
  String get winrateOfAllSignals => 'Gevinstprocent for alle signaler';

  @override
  String get daily => 'Daglig';

  @override
  String get weekly => 'Ugentlig';

  @override
  String get lossRate => 'Tabsrate';

  @override
  String get signalProgress => 'Signal Progress';

  @override
  String get statusHistory => 'Status History';

  @override
  String get signalCreated => 'Signal Created';

  @override
  String get signalMatched => 'Signal matchet';

  @override
  String get targetReached => 'Mål nået';

  @override
  String get freeSignalsInfo => 'Info om gratis signaler';

  @override
  String get freeSignalsInfoDesc =>
      'Du modtager 1 gratis signal om dagen.\nUbrugte signaler overføres til næste dag.';

  @override
  String freeSignalsCount(int count) {
    return '$count Gratis signaler';
  }

  @override
  String get close => 'Luk';

  @override
  String validUntil(String date) {
    return 'Gyldig indtil $date';
  }

  @override
  String get wins => 'Gevinst';

  @override
  String get losses => 'Tab';

  @override
  String totalOrdersCount(int count) {
    return 'Total: $count ordrer';
  }

  @override
  String get passwordResetEmailSent =>
      'E-mail til nulstilling af adgangskode er sendt! Tjek venligst din indbakke.';

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

  @override
  String get disclaimer => 'Disclaimer';

  @override
  String get disclaimerContent =>
      'The information on signalgpt.ai is for reference and knowledge-sharing purposes only, and does not constitute investment advice. Users are solely responsible for their own trading decisions.';

  @override
  String get openTradingAccount => 'Open A Trading Account';

  @override
  String get supportUs => 'Support Us';

  @override
  String get rateApp => 'Rate App';

  @override
  String get shareApp => 'Share App';

  @override
  String get accountDetails => 'Account Details';

  @override
  String get language => 'Language';

  @override
  String get termsOfUse => 'Terms Of Use';

  @override
  String get accounts => 'Accounts';

  @override
  String get accessExchange => 'Access The Exchange';

  @override
  String get onlineSupport => 'Online Support';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get left => 'left';

  @override
  String get upgradeToPro => 'Upgrade To Pro';

  @override
  String get assetGold => 'Gold';

  @override
  String get assetCrypto => 'Crypto';

  @override
  String get assetForex => 'Forex';

  @override
  String get tokens => 'Tokens';

  @override
  String get noForexAssets => 'No Forex assets available';

  @override
  String openApp(String appName) {
    return 'Open $appName';
  }

  @override
  String get signalStatus => 'Status';

  @override
  String get signalEntryLabel => 'ENTRY';

  @override
  String get signalSlLabel => 'SL';

  @override
  String get signalTp1Label => 'TP1';

  @override
  String get signalTp2Label => 'TP2';

  @override
  String get signalTp3Label => 'TP3';

  @override
  String get analyze => 'Analyze';

  @override
  String get useTokenToView => 'Use Token to view Signal';

  @override
  String get viewNow => 'View Now';

  @override
  String get waitingNewSignals => 'Waiting for new signals...';

  @override
  String get failedUnlockSignal => 'Failed to unlock signal';

  @override
  String get notEnoughTokens => 'Not enough tokens';

  @override
  String get newSignalUploaded => 'New Signal uploaded';

  @override
  String newSymbolSignalUploaded(String symbol) {
    return 'New $symbol signal is now uploaded!';
  }

  @override
  String get upgradeToViewSignalBanner => 'Upgrade to View Signal';

  @override
  String get signalHistory => 'Signal History';

  @override
  String get allStatus => 'ALL';

  @override
  String get selectDate => 'Select Date';

  @override
  String get noHistoryFound => 'No history found';

  @override
  String get filterDate => 'Date';

  @override
  String get marketChart => 'MARKET CHART';

  @override
  String get analysisExplanation => 'Analysis & Explanation';

  @override
  String get noDetailedAnalysis =>
      'No detailed analysis available for this signal.';
}
