// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'CONT ACTUALIZAT CU SUCCES';

  @override
  String get lotPerWeek => 'Lot/săptămână';

  @override
  String get tableValueFull => 'complet';

  @override
  String get tableValueFulltime => 'normă întreagă';

  @override
  String get packageTitle => 'PACHET';

  @override
  String get duration1Month => '1 lună';

  @override
  String get duration12Months => '12 luni';

  @override
  String get featureReceiveAllSignals => 'Primește toate semnalele zilei';

  @override
  String get featureAnalyzeReason => 'Analizează motivul intrării comenzii';

  @override
  String get featureHighPrecisionAI => 'Semnal AI de înaltă precizie';

  @override
  String get iapStoreNotAvailable =>
      'Magazinul nu este disponibil pe acest dispozitiv.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'Eroare la încărcarea produselor: $message';
  }

  @override
  String get iapNoProductsFound =>
      'Nu s-au găsit produse. Vă rugăm să verificați configurația magazinului.';

  @override
  String iapTransactionError(Object message) {
    return 'Eroare tranzacție: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'Eroare de verificare: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'A apărut o eroare necunoscută: $error';
  }

  @override
  String get iapProcessingTransaction => 'Se procesează tranzacția...';

  @override
  String get orderInfo1Month => 'Plată pentru pachetul Elite 1 lună';

  @override
  String get orderInfo12Months => 'Plată pentru pachetul Elite 12 luni';

  @override
  String get iapNotSupportedOnWeb =>
      'Achizițiile în aplicație nu sunt acceptate pe versiunea web.';

  @override
  String get vnpayPaymentTitle => 'PLATA VNPAY';

  @override
  String get creatingOrderWait =>
      'Se creează comanda, vă rugăm să așteptați...';

  @override
  String errorWithMessage(Object message) {
    return 'Eroare: $message';
  }

  @override
  String get cannotConnectToServer =>
      'Nu se poate conecta la server. Vă rugăm să încercați din nou.';

  @override
  String get transactionCancelledOrFailed =>
      'Tranzacția a fost anulată sau eșuată.';

  @override
  String get cannotCreatePaymentLink =>
      'Nu s-a putut crea linkul de plată.\nÎncercați din nou.';

  @override
  String get retry => 'Reîncercați';

  @override
  String serverErrorRetry(Object message) {
    return 'Eroare server: $message. Vă rugăm să încercați din nou.';
  }

  @override
  String get redirectingToPayment => 'Redirecționare către pagina de plată...';

  @override
  String get invalidPaymentUrl => 'URL de plată nevalid primit de la server.';

  @override
  String get processingYourAccount => 'Se procesează contul dvs...';

  @override
  String get verificationFailed => 'Verificarea a eșuat!';

  @override
  String get reuploadImage => 'Reîncărcați imaginea';

  @override
  String get accountNotLinked => 'Contul nu este legat la Minvest';

  @override
  String get accountNotLinkedDesc =>
      'Pentru a obține semnale exclusive, contul dvs. Exness trebuie să fie înregistrat prin linkul de partener Minvest. Vă rugăm să creați un cont nou folosind linkul de mai jos.';

  @override
  String get registerExnessViaMinvest => 'Înregistrați Exness prin Minvest';

  @override
  String get iHaveRegisteredReupload => 'M-am înregistrat, reîncărcați';

  @override
  String couldNotLaunch(Object url) {
    return 'Nu s-a putut lansa $url';
  }

  @override
  String get status => 'Stare';

  @override
  String get sentOn => 'Trimis pe';

  @override
  String get entryPrice => 'Preț intrare';

  @override
  String get stopLossFull => 'Stop loss';

  @override
  String get takeProfitFull1 => 'Take profit 1';

  @override
  String get takeProfitFull2 => 'Take profit 2';

  @override
  String get takeProfitFull3 => 'Take profit 3';

  @override
  String get noReasonProvided => 'Niciun motiv furnizat pentru acest semnal.';

  @override
  String get upgradeToViewReason =>
      'Actualizați contul la Elite pentru a vizualiza analiza.';

  @override
  String get upgradeToViewFullAnalysis =>
      'Actualizați pentru a vizualiza analiza completă';

  @override
  String get welcomeTo => 'Bun venit la';

  @override
  String get appSlogan =>
      'Îmbunătățiți-vă tranzacționarea cu semnale inteligente.';

  @override
  String get signIn => 'Conectați-vă';

  @override
  String get continueByGoogle => 'Continuați cu Google';

  @override
  String get continueByFacebook => 'Continuați cu Facebook';

  @override
  String get continueByApple => 'Continuați cu Apple';

  @override
  String get loginSuccess => 'Autentificare reușită!';

  @override
  String get live => 'LIVE';

  @override
  String get end => 'SFÂRȘIT';

  @override
  String get symbol => 'SIMBOL';

  @override
  String get aiSignal => 'Semnale AI';

  @override
  String get ruleSignal => 'SEMNAL REGULĂ';

  @override
  String get all => 'TOATE';

  @override
  String get upgradeToSeeMore => 'Actualizați pentru a vedea mai multe';

  @override
  String get seeDetails => 'vezi detalii';

  @override
  String get notMatched => 'NEPOTRIVIT';

  @override
  String get matched => 'POTRIVIT';

  @override
  String get entry => 'Intrare';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'Actualizați';

  @override
  String get upgradeAccount => 'ACTUALIZAȚI CONTUL';

  @override
  String get compareTiers => 'COMPARĂ NIVELURILE';

  @override
  String get feature => 'Caracteristică';

  @override
  String get tierDemo => 'Demo';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'Sold';

  @override
  String get signalTime => 'Timp semnal';

  @override
  String get signalQty => 'Cantitate semnal';

  @override
  String get analysis => 'Analiză';

  @override
  String get openExnessAccount => 'Deschideți cont Exness!';

  @override
  String get accountVerificationWithExness => 'Verificarea contului cu Exness';

  @override
  String get payInAppToUpgrade => 'Plătiți în aplicație pentru actualizare';

  @override
  String get bankTransferToUpgrade => 'Transfer bancar pentru actualizare';

  @override
  String get accountVerification => 'VERIFICAREA CONTULUI';

  @override
  String get accountVerificationPrompt =>
      'Vă rugăm să încărcați o captură de ecran a contului dvs. Exness pentru a fi autorizat (contul dvs. trebuie să fie deschis sub linkul Exness al Minvest)';

  @override
  String get selectPhotoFromLibrary => 'Selectați fotografia din bibliotecă';

  @override
  String get send => 'Trimiteți';

  @override
  String get accountInfo => 'Informații cont';

  @override
  String get accountVerifiedSuccessfully => 'CONT VERIFICAT CU SUCCES';

  @override
  String get yourAccountIs => 'Contul dvs. este';

  @override
  String get returnToHomePage => 'Înapoi la pagina principală';

  @override
  String get upgradeFailed =>
      'Actualizarea a eșuat! Vă rugăm să reîncărcați imaginea';

  @override
  String get package => 'PACHET';

  @override
  String get startNow => 'Obțineți semnale acum';

  @override
  String get bankTransfer => 'TRANSFER BANCAR';

  @override
  String get transferInformation => 'INFORMAȚII TRANSFER';

  @override
  String get scanForFastTransfer => 'Scanați pentru transfer rapid';

  @override
  String get contactUs247 => 'Contactați-ne 24/7';

  @override
  String get newAnnouncement => 'ANUNȚ NOU';

  @override
  String get profile => 'Profil';

  @override
  String get upgradeNow => 'Actualizați acum';

  @override
  String get followMinvest => 'Urmăriți MInvest';

  @override
  String get tabSignal => 'Semnal';

  @override
  String get tabChart => 'Grafic';

  @override
  String get tabProfile => 'Profil';

  @override
  String get reason => 'MOTIV';

  @override
  String get error => 'Eroare';

  @override
  String get noSignalsAvailable => 'Nu sunt semnale disponibile.';

  @override
  String get outOfGoldenHours => 'În afara orelor de aur';

  @override
  String get outOfGoldenHoursVipDesc =>
      'Semnalele VIP sunt disponibile de la 8:00 la 17:00 (GMT+7).\nActualizați la Elite pentru a obține semnale 24/24!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'Semnalele Demo sunt disponibile de la 8:00 la 17:00 (GMT+7).\nActualizați contul pentru mai multe beneficii!';

  @override
  String get yourName => 'Numele dvs.';

  @override
  String get yourEmail => 'emailul.dvs@exemplu.com';

  @override
  String get adminPanel => 'Panou administrator';

  @override
  String get logout => 'Deconectare';

  @override
  String get confirmLogout => 'Confirmați deconectarea';

  @override
  String get confirmLogoutMessage => 'Sigur doriți să vă deconectați?';

  @override
  String get cancel => 'Anulați';

  @override
  String get upgradeCardTitle => 'ACTUALIZAȚI-VĂ CONTUL';

  @override
  String get upgradeCardSubtitle => 'Pentru a accesa mai multe resurse';

  @override
  String get upgradeCardSubtitleWeb =>
      'Pentru a debloca semnale premium și suport full-time';

  @override
  String get subscriptionDetails => 'Detalii abonament';

  @override
  String get notifications => 'Notificări';

  @override
  String get continueAsGuest => 'Continuați ca oaspete';

  @override
  String get deleteAccount => 'Ștergeți contul';

  @override
  String get deleteAccountWarning =>
      'Sigur doriți să ștergeți contul? Toate datele dvs. vor fi șterse definitiv și nu pot fi recuperate.';

  @override
  String get delete => 'Ștergeți';

  @override
  String get privacyPolicy => 'Politica de confidențialitate';

  @override
  String get termsOfService => 'Termeni de serviciu';

  @override
  String get signalStatusMatched => 'POTRIVIT';

  @override
  String get signalStatusNotMatched => 'NEPOTRIVIT';

  @override
  String get signalStatusCancelled => 'ANULAT';

  @override
  String get signalStatusSlHit => 'SL ATINS';

  @override
  String get signalStatusTp1Hit => 'TP1 ATINS';

  @override
  String get signalStatusTp2Hit => 'TP2 ATINS';

  @override
  String get signalStatusTp3Hit => 'TP3 ATINS';

  @override
  String get signalStatusRunning => 'ÎN DESFĂȘURARE';

  @override
  String get signalStatusClosed => 'ÎNCHIS';

  @override
  String get contactUs => 'Contactați-ne';

  @override
  String get tabChat => 'Chat';

  @override
  String get exnessUpgradeNoteForIos =>
      'Pentru clienții care au înregistrat un cont Exness prin Minvest, vă rugăm să faceți clic pe contactați-ne pentru a vă actualiza contul.';

  @override
  String get chatWelcomeTitle => '👋 Bun venit la Signal GPT!';

  @override
  String get chatWelcomeBody1 =>
      'Vă rugăm să lăsați un mesaj, echipa noastră va răspunde cât mai curând posibil.';

  @override
  String get chatWelcomeBody2 =>
      'Sau contactați-ne direct prin Zalo/WhatsApp: ';

  @override
  String get chatWelcomeBody3 => ' pentru asistență mai rapidă!';

  @override
  String get chatLoginPrompt =>
      'Vă rugăm să vă conectați pentru a utiliza această funcție';

  @override
  String get chatStartConversation => 'Începeți conversația';

  @override
  String get chatNoMessages => 'Niciun mesaj încă.';

  @override
  String get chatTypeMessage => 'Scrieți un mesaj...';

  @override
  String get chatSupportIsTyping => 'Suportul scrie...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName scrie...';
  }

  @override
  String get chatSeen => 'Văzut';

  @override
  String get chatDefaultUserName => 'Utilizator';

  @override
  String get chatDefaultSupportName => 'Suport';

  @override
  String get signalEntry => 'Intrare';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      'Pentru comercianții străini, vă rugăm să ne contactați prin WhatsApp (+84969.15.6969) pentru asistență';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails =>
      'Actualizați pentru a vedea detaliile semnalului...';

  @override
  String get buy => 'CUMPĂRĂ';

  @override
  String get sell => 'VINDE';

  @override
  String get logoutDialogTitle => 'Sesiune expirată';

  @override
  String get logoutDialogDefaultReason =>
      'Contul dvs. a fost conectat pe un alt dispozitiv.';

  @override
  String get ok => 'OK';

  @override
  String get contactToUpgrade => 'Contactați pentru actualizare';

  @override
  String get noNotificationsYet => 'Nicio notificare încă.';

  @override
  String daysAgo(int count) {
    return 'acum $count zile';
  }

  @override
  String hoursAgo(int count) {
    return 'acum $count ore';
  }

  @override
  String minutesAgo(int count) {
    return 'acum $count minute';
  }

  @override
  String get justNow => 'Chiar acum';

  @override
  String get getSignalsNow => 'Obțineți semnale acum';

  @override
  String get freeTrial => 'Probă gratuită';

  @override
  String get heroTitle => 'Ghidarea comercianților și creșterea portofoliilor';

  @override
  String get heroSubtitle =>
      'Motorul AI suprem – Proiectat de comercianți experți';

  @override
  String get globalAiInnovationTitle =>
      'Inovație globală AI pentru următoarea generație de inteligență comercială';

  @override
  String get globalAiInnovationDesc =>
      'Transformarea tranzacționării tradiționale cu semnale AI bazate pe cloud — adaptabile la știrile și tendințele pieței în timp real\npentru o performanță mai rapidă, mai precisă și fără emoții.';

  @override
  String get liveTradingSignalsTitle =>
      'LIVE – 24/7 Semnale de tranzacționare AI';

  @override
  String get liveTradingSignalsDesc =>
      'Analize cloud în timp real care oferă strategii cu probabilitate ridicată, de urmărire a tendințelor, cu precizie adaptivă și execuție fără emoții.';

  @override
  String get trendFollowing => 'Urmărirea tendințelor';

  @override
  String get realtime => 'În timp real';

  @override
  String get orderExplanationEngineTitle => 'Motor de explicare a comenzilor';

  @override
  String get orderExplanationEngineDesc =>
      'Explică setările de tranzacționare în termeni simpli — arătând cum se formează confluențele, de ce se fac intrările și ajutând comercianții să învețe din fiecare decizie.';

  @override
  String get transparent => 'Transparent';

  @override
  String get educational => 'Educațional';

  @override
  String get logical => 'Logic';

  @override
  String get transparentRealPerformanceTitle =>
      'Transparent - Performanță reală';

  @override
  String get transparentRealPerformanceDesc =>
      'Vedeți date reale despre precizia semnalului, rata de succes și profitabilitate — verificate și trasabile în fiecare tranzacție';

  @override
  String get results => 'Rezultate';

  @override
  String get performanceTracking => 'Urmărirea performanței';

  @override
  String get accurate => 'Precis';

  @override
  String get predictiveAccuracy => 'Precizie predictivă';

  @override
  String get improvementInProfitability => 'Îmbunătățirea profitabilității';

  @override
  String get improvedRiskManagement => 'Managementul riscului îmbunătățit';

  @override
  String get signalsPerformanceTitle => 'Performanța semnalelor';

  @override
  String get riskToRewardRatio => 'Raport risc-recompensă';

  @override
  String get howRiskComparesToReward => 'Cum se compară riscul cu recompensa';

  @override
  String get profitLossOverview => 'Prezentare generală profit/pierdere';

  @override
  String get netGainVsLoss => 'Câștig net vs pierdere';

  @override
  String get winRate => 'Rata de câștig';

  @override
  String get percentageOfWinningTrades =>
      'Procentul tranzacțiilor câștigătoare';

  @override
  String get accuracyRate => 'Rata de precizie';

  @override
  String get howPreciseOurSignalsAre => 'Cât de precise sunt semnalele noastre';

  @override
  String get realtimeMarketAnalysis => 'Analiză de piață în timp real';

  @override
  String get realtimeMarketAnalysisDesc =>
      'AI-ul nostru monitorizează piața continuu, identificând zonele de convergență tehnică și punctele de erupție fiabile, astfel încât să puteți intra în tranzacții la momentul potrivit.';

  @override
  String get saveTimeOnAnalysis => 'Economisiți timp la analiză';

  @override
  String get saveTimeOnAnalysisDesc =>
      'Nu mai petreceți ore întregi citind grafice. Primiți strategii de investiții personalizate în doar câteva minute pe zi.';

  @override
  String get minimizeEmotionalTrading =>
      'Minimizați tranzacționarea emoțională';

  @override
  String get minimizeEmotionalTradingDesc =>
      'Cu alerte inteligente, detectarea riscurilor și semnale bazate pe date, nu pe emoții, rămâneți disciplinat și în controlul fiecărei decizii.';

  @override
  String get seizeEveryOpportunity => 'Profitați de fiecare oportunitate';

  @override
  String get seizeEveryOpportunityDesc =>
      'Actualizările strategice oportune livrate direct în căsuța de e-mail vă asigură că profitați de tendințele pieței la momentul perfect.';

  @override
  String get minvestAiCoreValueTitle => 'Signal GPT - Valoare de bază';

  @override
  String get minvestAiCoreValueDesc =>
      'AI analizează continuu datele pieței în timp real, filtrând informațiile pentru a identifica oportunități de investiții rapide și precise';

  @override
  String get frequentlyAskedQuestions => 'Întrebări frecvente (FAQ)';

  @override
  String get faqSubtitle =>
      'Toate întrebările dvs. — de la cum să vă înscrieți, la beneficii, la cum funcționează AI-ul nostru — sunt răspunse chiar mai jos. Dacă mai aveți îndoieli, nu ezitați să ne trimiteți un mesaj pe Whatsapp';

  @override
  String get maximizeResultsTitle =>
      'Maximizați-vă rezultatele cu Signal GPT\nanaliză avansată de piață și semnale filtrate cu precizie';

  @override
  String get elevateTradingWithAiStrategies =>
      'Ridicați nivelul tranzacționării cu strategii îmbunătățite de AI, create pentru consistență și claritate';

  @override
  String get winMoreWithAiSignalsTitle =>
      'Câștigați mai mult cu semnale bazate pe AI\npe fiecare piață';

  @override
  String get winMoreWithAiSignalsDesc =>
      'AI-ul nostru multi-piață scanează Forex, Cripto și Metale în timp real,\noferind semnale de tranzacționare validate de experți —\ncu niveluri clare de intrare, stop-loss și take-profit';

  @override
  String get buyLimit => 'Limită cumpărare';

  @override
  String get sellLimit => 'Limită vânzare';

  @override
  String get smarterToolsTitle =>
      'Instrumente mai inteligente - Investiții mai bune';

  @override
  String get smarterToolsDesc =>
      'Descoperiți caracteristicile care vă ajută să minimizați riscurile, să profitați de oportunități și să vă creșteți averea';

  @override
  String get performanceOverviewTitle => 'Prezentare generală a performanței';

  @override
  String get performanceOverviewDesc =>
      'AI-ul nostru multi-piață scanează Forex, Cripto și Metale în timp real, oferind semnale de tranzacționare validate de experți - cu niveluri clare de intrare, stop-loss și take-profit';

  @override
  String get totalProfit => 'Profit total';

  @override
  String get completionSignal => 'Semnal de finalizare';

  @override
  String get onDemandFinancialExpertTitle =>
      'Expertul dvs. financiar la cerere';

  @override
  String get onDemandFinancialExpertDesc =>
      'Platforma AI sugerează semnale de tranzacționare - auto-învățare, analizează piața 24/7, neafectată de emoții. Minvest a sprijinit peste 10.000 de analiști financiari în călătoria lor pentru a găsi semnale precise, stabile și ușor de aplicat';

  @override
  String get aiPoweredSignalPlatform =>
      'Platformă de semnale de tranzacționare bazată pe AI';

  @override
  String get selfLearningSystems =>
      'Sisteme de auto-învățare, perspective mai clare, tranzacții mai puternice';

  @override
  String get emotionlessExecution =>
      'Execuție fără emoții pentru o tranzacționare mai inteligentă și mai disciplinată';

  @override
  String get analysingMarket247 => 'Analizează piața 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Maximizați-vă rezultatele cu Signal GPT\nanaliză avansată de piață și semnale filtrate cu precizie';

  @override
  String get minvestAiRegistrationDesc =>
      'Înregistrarea Signal GPT este deschisă acum — locurile se pot închide în curând pe măsură ce revizuim și aprobăm noi membri';

  @override
  String get currencyPairs => 'Marfă';

  @override
  String get allCurrencyPairs => 'Toate perechile valutare';

  @override
  String get allCommodities => 'Toate mărfurile';

  @override
  String get allCryptoPairs => 'Toate perechile cripto';

  @override
  String get dateRange => 'Interval de date';

  @override
  String get selectDateRange => 'Selectați intervalul de date';

  @override
  String get allAssets => 'Toate activele';

  @override
  String get asset => 'Activ';

  @override
  String get tokenExpired => 'Token expirat';

  @override
  String get tokenLimitReachedDesc =>
      'Ați epuizat cele 10 jetoane gratuite de astăzi. Actualizați pachetul pentru a vizualiza mai multe semnale.';

  @override
  String get later => 'Mai târziu';

  @override
  String get created => 'Creat';

  @override
  String get detail => 'Detaliu';

  @override
  String get performanceOverview => 'Prezentare generală a performanței';

  @override
  String get totalProfitPips => 'Profit total (Pips)';

  @override
  String get winRatePercent => 'Rata de câștig (%)';

  @override
  String get comingSoon => 'În curând';

  @override
  String get errorLoadingHistory => 'Eroare la încărcarea istoricului';

  @override
  String get noHistoryAvailable => 'Niciun istoric de semnal disponibil';

  @override
  String get previous => 'Anterior';

  @override
  String get page => 'Pagina';

  @override
  String get next => 'Următorul';

  @override
  String get date => 'Data';

  @override
  String get timeGmt7 => 'Ora';

  @override
  String get orders => 'Comenzi';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      'Ecran mic: rotiți peisaj sau derulați orizontal pentru a vizualiza tabelul complet.';

  @override
  String get history => 'Istoric';

  @override
  String get signalsWillAppearHere =>
      'Semnalele vor apărea aici când sunt disponibile';

  @override
  String get pricing => 'Prețuri';

  @override
  String get choosePlanSubtitle =>
      'Alegeți un plan care funcționează pentru dvs.';

  @override
  String get financialNewsHub => 'Centrul de știri financiare';

  @override
  String get financialNewsHubDesc =>
      'Actualizări critice. Reacțiile pieței. Fără zgomot – doar ceea ce investitorii trebuie să știe.';

  @override
  String get newsTabAllArticles => 'Toate articolele';

  @override
  String get newsTabInvestor => 'Investitor';

  @override
  String get newsTabKnowledge => 'Cunoștințe';

  @override
  String get newsTabTechnicalAnalysis => 'Analiză tehnică';

  @override
  String noArticlesForCategory(Object category) {
    return 'Niciun articol pentru categoria $category';
  }

  @override
  String get mostPopular => 'Cel mai popular';

  @override
  String get noPosts => 'Nicio postare';

  @override
  String get relatedArticles => 'Articole similare';

  @override
  String get contactInfoSentSuccess =>
      'Informațiile de contact au fost trimise cu succes.';

  @override
  String contactInfoSentFailed(Object error) {
    return 'Trimiterea informațiilor a eșuat: $error';
  }

  @override
  String get contactPageSubtitle =>
      'Aveți întrebări sau aveți nevoie de soluții AI? Spuneți-ne completând formularul și vă vom contacta!';

  @override
  String get phone => 'Telefon';

  @override
  String get firstName => 'Prenume';

  @override
  String get enterFirstName => 'Introduceți prenumele';

  @override
  String get lastName => 'Nume de familie';

  @override
  String get enterLastName => 'Introduceți numele de familie';

  @override
  String get whatAreYourConcerns => 'Care sunt preocupările dvs.?';

  @override
  String get writeConcernsHere => 'Scrieți preocupările aici...';

  @override
  String pleaseEnter(Object field) {
    return 'Vă rugăm să introduceți $field';
  }

  @override
  String get faqQuestion1 => 'Semnalele asigură o rată de succes de 100%?';

  @override
  String get faqAnswer1 =>
      'Deși niciun semnal nu poate fi garantat 100%, Signal GPT se străduiește să mențină o rată de succes stabilă de 60–80%, susținută de analize detaliate și managementul riscului, astfel încât să puteți lua decizia finală cu mai multă încredere.';

  @override
  String get faqQuestion2 =>
      'Dacă nu doresc să depun imediat, mai pot primi sugestii de semnale?';

  @override
  String get faqAnswer2 =>
      'La deschiderea unui cont, sistemul vă va face cadou 10 jetoane gratuite, echivalentul a 10 vizualizări detaliate ale semnalelor. După aceea, veți primi 1 jeton suplimentar în fiecare zi pentru a-l utiliza. Dacă faceți upgrade la un cont VIP, veți debloca multe funcții avansate și veți urmări un număr nelimitat de comenzi.';

  @override
  String get faqQuestion3 =>
      'Dacă m-am înscris, dar nu am primit niciun semnal, ce pași ar trebui să urmez?';

  @override
  String get faqAnswer3 =>
      'Procesarea este de obicei automată. Dacă tot nu vedeți nicio sugestie de semnal, vă rugăm să ne contactați prin Whatsapp pentru asistență instantanee.';

  @override
  String get faqQuestion4 =>
      'Câte semnale voi primi pe zi când fac upgrade la un cont VIP?';

  @override
  String get faqAnswer4 =>
      'Când faceți upgrade la un cont VIP, veți primi semnale de tranzacționare nelimitate în fiecare zi. Numărul de semnale nu este fix, ci depinde în totalitate de analiza pieței. Ori de câte ori apare un punct de intrare de înaltă calitate și probabilitate ridicată, echipa de analiză vă va trimite semnalul imediat.';

  @override
  String get priceLevels => 'Niveluri de preț';

  @override
  String get capitalManagement => 'Managementul capitalului';

  @override
  String freeSignalsLeft(Object count) {
    return '$count semnale gratuite rămase';
  }

  @override
  String get unlimitedSignals => 'Semnale nelimitate';

  @override
  String get goBack => 'Înapoi';

  @override
  String get goldPlan => 'Plan Gold';

  @override
  String get perMonth => '/ lună';

  @override
  String get continuouslyUpdating =>
      'Actualizarea continuă a datelor pieței 24/7';

  @override
  String get providingBestSignals =>
      'Furnizarea celor mai bune semnale în timp real';

  @override
  String get includesEntrySlTp => 'Include Intrare, SL, TP';

  @override
  String get detailedAnalysis =>
      'Analiză detaliată și evaluare a fiecărui semnal';

  @override
  String get realTimeNotifications => 'Notificări în timp real prin e-mail';

  @override
  String get signalPerformanceStats => 'Statistici de performanță a semnalului';

  @override
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails =>
      'Număr de înregistrare a afacerii: 0110057263';

  @override
  String get addressDetails =>
      'Adresa: Nr. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam';

  @override
  String get pagesTitle => 'Pagini';

  @override
  String get legalRegulatoryTitle => 'Legal și reglementare';

  @override
  String get termsOfRegistration => 'Termeni de înregistrare';

  @override
  String get operatingPrinciples => 'Principii de operare';

  @override
  String get termsConditions => 'Termeni și condiții';

  @override
  String get contactTitle => 'Contact';

  @override
  String get navFeatures => 'Caracteristici';

  @override
  String get navNews => 'Știri';

  @override
  String get tp1Hit => 'TP1 Atins';

  @override
  String get tp2Hit => 'TP2 Atins';

  @override
  String get tp3Hit => 'TP3 Atins';

  @override
  String get slHit => 'SL Atins';

  @override
  String get cancelled => 'Anulat';

  @override
  String get exitedByAdmin => 'Ieșit de Admin';

  @override
  String get signalClosed => 'Închis';

  @override
  String get errorLoadingPackages => 'Eroare la încărcarea pachetelor';

  @override
  String get monthly => 'Lunar';

  @override
  String get annually => 'Anual';

  @override
  String get whatsIncluded => 'Ce este inclus:';

  @override
  String get chooseThisPlan => 'Alegeți acest plan';

  @override
  String get bestPricesForPremiumAccess =>
      'Cele mai bune prețuri pentru acces Premium';

  @override
  String get choosePlanFitsNeeds =>
      'Alegeți un plan care se potrivește nevoilor afacerii dvs. și începeți automatizarea cu AI';

  @override
  String get save50Percent => 'ECONOMISIȚI 50%';

  @override
  String get tryDemo => 'Încercați demo';

  @override
  String get pleaseEnterEmailPassword =>
      'Vă rugăm să introduceți e-mailul și parola';

  @override
  String loginFailed(String error) {
    return 'Autentificare eșuată: $error';
  }

  @override
  String get welcomeBack => 'Bine ați revenit';

  @override
  String get signInToContinue =>
      'Conectați-vă la contul dvs. pentru a continua';

  @override
  String get or => 'sau';

  @override
  String get email => 'E-mail';

  @override
  String get emailHint => 'exemplu123@gmail.com';

  @override
  String get password => 'Parolă';

  @override
  String get enterPassword => 'Introduceți parola';

  @override
  String get forgotPassword => 'Ați uitat parola?';

  @override
  String get createNewAccount => 'Creați cont nou aici!';

  @override
  String get signUp => 'Înscrieți-vă';

  @override
  String get signUpAccount => 'Înscrieți cont';

  @override
  String get enterPersonalData =>
      'Introduceți datele personale pentru a vă crea contul';

  @override
  String get nameLabel => 'Nume *';

  @override
  String get enterNameHint => 'Introduceți numele';

  @override
  String get emailLabel => 'E-mail *';

  @override
  String get passwordLabel => 'Parolă *';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get continueButton => 'Continuați';

  @override
  String get fillAllFields =>
      'Vă rugăm să completați toate câmpurile obligatorii.';

  @override
  String get accountCreatedSuccess => 'Cont creat cu succes.';

  @override
  String signUpFailed(String error) {
    return 'Înscriere eșuată: $error';
  }

  @override
  String get nationality => 'Naționalitate:';

  @override
  String get overview => 'Prezentare generală';

  @override
  String get setting => 'Setare';

  @override
  String get paymentHistory => 'Istoric plăți';

  @override
  String get signalsPlan => 'Plan semnale';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => 'Jetoanele dvs.';

  @override
  String get emailNotificationPreferences => 'Preferințe notificare e-mail';

  @override
  String get chooseSignalNotificationTypes =>
      'Alegeți ce tipuri de notificări de semnal doriți să primiți prin e-mail';

  @override
  String get allSignalNotifications => 'Toate notificările de semnal';

  @override
  String get cryptoSignals => 'Semnale cripto';

  @override
  String get forexSignals => 'Semnale Forex';

  @override
  String get goldSignals => 'Semnale aur';

  @override
  String get updatePasswordSecure =>
      'Actualizați parola pentru a vă păstra contul în siguranță';

  @override
  String get searchLabel => 'Căutare:';

  @override
  String get filterBy => 'Filtrare după:';

  @override
  String get allTime => 'Tot timpul';

  @override
  String get startDate => 'Data de început:';

  @override
  String get endDate => 'Data de sfârșit:';

  @override
  String get deactivate => 'Dezactivați';

  @override
  String get unlimited => 'Nelimitat';

  @override
  String get tenLeft => '10 rămase';

  @override
  String get termsOfRegistrationContent =>
      'Please read all the terms and agreements below carefully before proceeding with the next steps in our system.\nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\n1. Introduction and Scope of Application\n\nThis policy regulates the collection, use, sharing, and protection of users’ personal information when accessing and using the products and services of the Signal GPT system – a technology and artificial intelligence platform owned and operated by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED (hereinafter referred to as “we” or “us”).\nBy registering an account or using Signal GPT’s products, you agree that such action constitutes a legally binding commitment between you and us, equivalent to an electronic contract.\n\n2. Account Registration\n\nTo access and use certain services on Signal GPT, you must register a valid account.\nWhen registering, you are required to provide complete and accurate personal information, including your full name, email address, phone number, or any other information as requested.\nAfter registration, you must confirm your email to activate the account. All notifications about your account, promotions, or system updates will be sent to this email address.\nIf the information you provide is inaccurate or incomplete, you will be solely responsible for any incidents or damages arising from it.\n\n3. Terms of Use\n\nWhen participating in the Signal GPT system, you are obligated to comply with all of the following:\nThe operating principles of the platform;\nPayment terms;\nPersonal data privacy policy;\nRelevant laws and regulations in effect.\nIn the event of a violation, EZTRADE reserves the right to temporarily suspend or permanently delete your account, and may transfer the case to competent authorities if necessary.\n\n4. Personal Data Privacy Policy\n\n4.1. Purpose and Scope of ... [truncated]';

  @override
  String get operatingPrinciplesContent =>
      'Please read all terms and agreements below carefully before proceeding with the next steps in our system. \nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\nOPERATING RULES\n\n1. Legal Information\n\nSystem Owner:\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness/Tax Code: 0110057263\nPhone: 0862 600 626\n\n2. Scope of Application\n\nThese Operating Principles apply to all users, learners, partners, and collaborators who participate in or use the products and services within the Signal GPT system, including websites, applications, training platforms, and other online channels managed by EZTRADE.\nBy registering an account or using the services of Signal GPT, users are deemed to have read, understood, and agreed to all the terms set forth in these regulations.\n\n3. Definitions\n\n“Signal GPT” refers to the technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED.\n“Customer” / “User” / “Learner” refers to any individual or organization that registers, accesses, or uses the services and products on the Signal GPT system.\n“We” / “Administration” refers to the management team representing EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED, responsible for operating and managing the system.\n“Products” / “Services” include learning packages, analytical newsletters, AI trading signals, analytical tools, or any digital content provided by Signal GPT.\n\n4. Usage Rules and Information Security\n\nUsers must provide accurate and complete information when registering an account.\nSignal GPT is committed to protecting personal information and will not disclose it to third parties unless required by competent authorities.\nUsers are responsible for maintaining the confidentiality of their account and pa... [truncated]';

  @override
  String get termsAndConditionsContent =>
      'By registering an account to participate in the Signal GPT system, you confirm that you have read, understood, and agreed to all the contents of these Account Opening Terms and Conditions.\nThe latest updates (if any) will be published here, and Signal GPT will not send separate notifications to each customer. Therefore, please visit this page regularly to stay informed about the most recent policies.\n\n1. General Agreement\n\nSignal GPT is a technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED. By opening an account on this system, you agree to participate in and use the services and products provided by EZTRADE.\nAccount registration and activation are considered an electronic contract between you and Signal GPT, which has the same legal validity as a civil contract under the laws of Vietnam.\n\n2. Personal Account Information and Privacy\n\n2.1. Purpose and Scope of Information Collection\n\nTo access and use certain Signal GPT services, you must provide basic personal information, including:\nFull name;\nEmail address;\nContact phone number;\nOther information (if any) necessary for verification, support, or access authorization.\nAll information provided must be accurate, truthful, and lawful. Signal GPT shall not be responsible for any losses or disputes arising from false, missing, or fraudulent information provided by the user.\nAdditionally, the system may automatically collect certain technical data, such as:\nIP address, browser type, and language used;\nAccess time and pages viewed within the system.\nThis information helps Signal GPT improve performance, enhance security, and optimize user experience.\n\n2.2. Scope of Information Use\n\nYour personal information is collected and used for legitimate purposes, including:\nManaging accounts, verifying users, and maintaining services;\nSending notifications related to services, accounts, promotions, or policy changes;\nProv... [truncated]';

  @override
  String get performance => 'Performanță';

  @override
  String get minvestSupport => 'SignalGpt Support';

  @override
  String get leaveMessagePart1 =>
      'Vă rugăm să lăsați un mesaj, echipa noastră va răspunde cât mai curând posibil. De asemenea, puteți contacta ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 pentru asistență rapidă.';

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
  String get signInRequired => 'Autentificare necesară';

  @override
  String get signInToExploreSignal =>
      'Conectați-vă pentru a explora acest semnal de tranzacționare!';

  @override
  String get activeMember => 'Membru activ';

  @override
  String get last7Days => 'Ultimele 7 zile';

  @override
  String get last14Days => 'Ultimele 14 zile';

  @override
  String get last30Days => 'Ultimele 30 de zile';

  @override
  String get last90Days => 'Ultimele 90 de zile';

  @override
  String get profitStatistics => 'Statistici profit';

  @override
  String get winrateOfAllSignals => 'Rata de câștig a tuturor semnalelor';

  @override
  String get daily => 'Zilnic';

  @override
  String get weekly => 'Săptămânal';

  @override
  String get lossRate => 'Rata pierderilor';

  @override
  String get signalProgress => 'Signal Progress';

  @override
  String get statusHistory => 'Status History';

  @override
  String get signalCreated => 'Signal Created';

  @override
  String get signalMatched => 'Semnal potrivit';

  @override
  String get targetReached => 'Țintă atinsă';

  @override
  String get freeSignalsInfo => 'Info Semnale Gratuite';

  @override
  String get freeSignalsInfoDesc =>
      'Veți primi 1 semnal gratuit pe zi.\nSemnalele neutilizate se reportează pentru ziua următoare.';

  @override
  String freeSignalsCount(int count) {
    return '$count Semnale Gratuite';
  }

  @override
  String get close => 'Închide';

  @override
  String validUntil(String date) {
    return 'Valabil până la $date';
  }

  @override
  String get wins => 'Câștiguri';

  @override
  String get losses => 'Pierderi';

  @override
  String totalOrdersCount(int count) {
    return 'Total: $count comenzi';
  }

  @override
  String get passwordResetEmailSent =>
      'E-mailul de resetare a parolei a fost trimis! Vă rugăm să vă verificați căsuța poștală.';

  @override
  String get pageOf => '/';

  @override
  String get keyFindings => 'Key Findings';
}
