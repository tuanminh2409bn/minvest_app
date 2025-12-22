// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'TILI PÄIVITETTY ONNISTUNEESTI';

  @override
  String get lotPerWeek => 'Erä/viikko';

  @override
  String get tableValueFull => 'täysi';

  @override
  String get tableValueFulltime => 'kokoaikainen';

  @override
  String get packageTitle => 'PAKETTI';

  @override
  String get duration1Month => '1 kuukausi';

  @override
  String get duration12Months => '12 kuukautta';

  @override
  String get featureReceiveAllSignals => 'Vastaanota kaikki päivän signaalit';

  @override
  String get featureAnalyzeReason => 'Analysoi tilaukseen syöttämisen syy';

  @override
  String get featureHighPrecisionAI => 'Korkean tarkkuuden AI-signaali';

  @override
  String get iapStoreNotAvailable =>
      'Kauppa ei ole saatavilla tällä laitteella.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'Virhe tuotteiden lataamisessa: $message';
  }

  @override
  String get iapNoProductsFound =>
      'Tuotteita ei löytynyt. Tarkista kauppasi asetukset.';

  @override
  String iapTransactionError(Object message) {
    return 'Transaktiovirhe: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'Vahvistusvirhe: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'Tuntematon virhe tapahtui: $error';
  }

  @override
  String get iapProcessingTransaction => 'Käsitellään transaktiota...';

  @override
  String get orderInfo1Month => 'Maksu Elite 1 kuukauden paketista';

  @override
  String get orderInfo12Months => 'Maksu Elite 12 kuukauden paketista';

  @override
  String get iapNotSupportedOnWeb =>
      'Sovelluksen sisäisiä ostoja ei tueta verkkoversiossa.';

  @override
  String get vnpayPaymentTitle => 'VNPAY-MAKSU';

  @override
  String get creatingOrderWait => 'Luodaan tilausta, odota...';

  @override
  String errorWithMessage(Object message) {
    return 'Virhe: $message';
  }

  @override
  String get cannotConnectToServer =>
      'Yhteyttä palvelimeen ei voida muodostaa. Yritä uudelleen.';

  @override
  String get transactionCancelledOrFailed =>
      'Transaktio on peruutettu tai epäonnistunut.';

  @override
  String get cannotCreatePaymentLink =>
      'Maksulinkkiä ei voitu luoda.\nYritä uudelleen.';

  @override
  String get retry => 'Yritä uudelleen';

  @override
  String serverErrorRetry(Object message) {
    return 'Palvelinvirhe: $message. Yritä uudelleen.';
  }

  @override
  String get redirectingToPayment => 'Ohjataan maksusivulle...';

  @override
  String get invalidPaymentUrl =>
      'Palvelimelta vastaanotettiin virheellinen maksu-URL.';

  @override
  String get processingYourAccount => 'Käsitellään tiliäsi...';

  @override
  String get verificationFailed => 'Vahvistus epäonnistui!';

  @override
  String get reuploadImage => 'Lataa kuva uudelleen';

  @override
  String get accountNotLinked => 'Tiliä ei ole linkitetty Minvestiin';

  @override
  String get accountNotLinkedDesc =>
      'Saadaksesi eksklusiivisia signaaleja, Exness-tilisi on oltava rekisteröity Minvest-kumppanilinkin kautta. Luo uusi tili alla olevan linkin kautta.';

  @override
  String get registerExnessViaMinvest => 'Rekisteröi Exness Minvestin kautta';

  @override
  String get iHaveRegisteredReupload => 'Olen rekisteröitynyt, lataa uudelleen';

  @override
  String couldNotLaunch(Object url) {
    return 'Ei voitu käynnistää $url';
  }

  @override
  String get status => 'Tila';

  @override
  String get sentOn => 'Lähetetty';

  @override
  String get entryPrice => 'Sisääntulohinta';

  @override
  String get stopLossFull => 'Stop loss';

  @override
  String get takeProfitFull1 => 'Take profit 1';

  @override
  String get takeProfitFull2 => 'Take profit 2';

  @override
  String get takeProfitFull3 => 'Take profit 3';

  @override
  String get noReasonProvided => 'Tälle signaalille ei ole annettu syytä.';

  @override
  String get upgradeToViewReason =>
      'Päivitä tilisi Elite-tasolle nähdäksesi analyysin.';

  @override
  String get upgradeToViewFullAnalysis => 'Päivitä nähdäksesi täyden analyysin';

  @override
  String get welcomeTo => 'Tervetuloa';

  @override
  String get appSlogan => 'Tehosta kaupankäyntiäsi älykkäillä signaaleilla.';

  @override
  String get signIn => 'Kirjaudu sisään';

  @override
  String get continueByGoogle => 'Jatka Googlella';

  @override
  String get continueByFacebook => 'Jatka Facebookilla';

  @override
  String get continueByApple => 'Jatka Applella';

  @override
  String get loginSuccess => 'Kirjautuminen onnistui!';

  @override
  String get live => 'LIVE';

  @override
  String get end => 'LOPPU';

  @override
  String get symbol => 'SYMBOLI';

  @override
  String get aiSignal => 'AI-signaalit';

  @override
  String get ruleSignal => 'SÄÄNTÖSIGNAALI';

  @override
  String get all => 'KAIKKI';

  @override
  String get upgradeToSeeMore => 'Päivitä nähdäksesi enemmän';

  @override
  String get seeDetails => 'katso tiedot';

  @override
  String get notMatched => 'EI VASTAA';

  @override
  String get matched => 'VASTAA';

  @override
  String get entry => 'Sisääntulo';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'Päivitä';

  @override
  String get upgradeAccount => 'PÄIVITÄ TILI';

  @override
  String get compareTiers => 'VERTAILE TASOJA';

  @override
  String get feature => 'Ominaisuus';

  @override
  String get tierDemo => 'Demo';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'Saldo';

  @override
  String get signalTime => 'Signaaliaika';

  @override
  String get signalQty => 'Signaalimäärä';

  @override
  String get analysis => 'Analyysi';

  @override
  String get openExnessAccount => 'Avaa Exness-tili!';

  @override
  String get accountVerificationWithExness => 'Tilin vahvistus Exnessillä';

  @override
  String get payInAppToUpgrade => 'Maksa sovelluksessa päivittääksesi';

  @override
  String get bankTransferToUpgrade => 'Pankkisiirto päivittämiseksi';

  @override
  String get accountVerification => 'TILIN VAHVISTUS';

  @override
  String get accountVerificationPrompt =>
      'Lataa kuvakaappaus Exness-tilistäsi valtuutusta varten (tilisi on oltava avattu Minvestin Exness-linkin kautta)';

  @override
  String get selectPhotoFromLibrary => 'Valitse kuva kirjastosta';

  @override
  String get send => 'Lähetä';

  @override
  String get accountInfo => 'Tilitiedot';

  @override
  String get accountVerifiedSuccessfully => 'TILI VAHVISTETTU ONNISTUNEESTI';

  @override
  String get yourAccountIs => 'Tilisi on';

  @override
  String get returnToHomePage => 'Palaa etusivulle';

  @override
  String get upgradeFailed => 'Päivitys epäonnistui! Lataa kuva uudelleen';

  @override
  String get package => 'PAKETTI';

  @override
  String get startNow => 'Hanki signaalit nyt';

  @override
  String get bankTransfer => 'PANKKISIIRTO';

  @override
  String get transferInformation => 'SIIRTOTIEDOT';

  @override
  String get scanForFastTransfer => 'Skannaa nopeaa siirtoa varten';

  @override
  String get contactUs247 => 'Ota yhteyttä 24/7';

  @override
  String get newAnnouncement => 'UUSI ILMOITUS';

  @override
  String get profile => 'Profiili';

  @override
  String get upgradeNow => 'Päivitä nyt';

  @override
  String get followMinvest => 'Seuraa MInvestiä';

  @override
  String get tabSignal => 'Signaali';

  @override
  String get tabChart => 'Kaavio';

  @override
  String get tabProfile => 'Profiili';

  @override
  String get reason => 'SYY';

  @override
  String get error => 'Virhe';

  @override
  String get noSignalsAvailable => 'Ei signaaleja saatavilla.';

  @override
  String get outOfGoldenHours => 'Kultaisten tuntien ulkopuolella';

  @override
  String get outOfGoldenHoursVipDesc =>
      'VIP-signaalit ovat saatavilla klo 8:00 - 17:00 (GMT+7).\nPäivitä Elite-tasolle saadaksesi signaalit 24/24!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'Demo-signaalit ovat saatavilla klo 8:00 - 17:00 (GMT+7).\nPäivitä tilisi saadaksesi enemmän etuja!';

  @override
  String get yourName => 'Nimesi';

  @override
  String get yourEmail => 'sinun.email@esimerkki.fi';

  @override
  String get adminPanel => 'Hallintapaneeli';

  @override
  String get logout => 'Kirjaudu ulos';

  @override
  String get confirmLogout => 'Vahvista uloskirjautuminen';

  @override
  String get confirmLogoutMessage => 'Haluatko varmasti kirjautua ulos?';

  @override
  String get cancel => 'Peruuta';

  @override
  String get upgradeCardTitle => 'PÄIVITÄ TILISI';

  @override
  String get upgradeCardSubtitle =>
      'Päästäksesi käsiksi useampiin resursseihin';

  @override
  String get upgradeCardSubtitleWeb =>
      'Avataksesi premium-signaalit ja kokopäiväisen tuen';

  @override
  String get subscriptionDetails => 'Tilauksen tiedot';

  @override
  String get notifications => 'Ilmoitukset';

  @override
  String get continueAsGuest => 'Jatka vieraana';

  @override
  String get deleteAccount => 'Poista tili';

  @override
  String get deleteAccountWarning =>
      'Haluatko varmasti poistaa tilisi? Kaikki tietosi poistetaan pysyvästi eikä niitä voi palauttaa.';

  @override
  String get delete => 'Poista';

  @override
  String get privacyPolicy => 'Tietosuojakäytäntö';

  @override
  String get termsOfService => 'Käyttöehdot';

  @override
  String get signalStatusMatched => 'VASTAA';

  @override
  String get signalStatusNotMatched => 'EI VASTAA';

  @override
  String get signalStatusCancelled => 'PERUUTETTU';

  @override
  String get signalStatusSlHit => 'SL OSUMA';

  @override
  String get signalStatusTp1Hit => 'TP1 OSUMA';

  @override
  String get signalStatusTp2Hit => 'TP2 OSUMA';

  @override
  String get signalStatusTp3Hit => 'TP3 OSUMA';

  @override
  String get signalStatusRunning => 'KÄYNNISSÄ';

  @override
  String get signalStatusClosed => 'SULJETTU';

  @override
  String get contactUs => 'Ota yhteyttä';

  @override
  String get tabChat => 'Chat';

  @override
  String get exnessUpgradeNoteForIos =>
      'Asiakkaille, jotka ovat rekisteröineet Exness-tilin Minvestin kautta, napsauta ota yhteyttä päivittääksesi tilisi.';

  @override
  String get chatWelcomeTitle => '👋 Tervetuloa Minvest AI:hin!';

  @override
  String get chatWelcomeBody1 =>
      'Jätä viesti, tiimimme vastaa mahdollisimman pian.';

  @override
  String get chatWelcomeBody2 => 'Tai ota yhteyttä suoraan Zalo/WhatsApp: ';

  @override
  String get chatWelcomeBody3 => ' nopeampaa tukea varten!';

  @override
  String get chatLoginPrompt =>
      'Kirjaudu sisään käyttääksesi tätä ominaisuutta';

  @override
  String get chatStartConversation => 'Aloita keskustelu';

  @override
  String get chatNoMessages => 'Ei viestejä vielä.';

  @override
  String get chatTypeMessage => 'Kirjoita viesti...';

  @override
  String get chatSupportIsTyping => 'Tuki kirjoittaa...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName kirjoittaa...';
  }

  @override
  String get chatSeen => 'Nähty';

  @override
  String get chatDefaultUserName => 'Käyttäjä';

  @override
  String get chatDefaultSupportName => 'Tuki';

  @override
  String get signalEntry => 'Sisääntulo';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      'Ulkomaisille kauppiaille, ota yhteyttä WhatsAppilla (+84969.15.6969) tukea varten';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails => 'Päivitä nähdäksesi signaalin tiedot...';

  @override
  String get buy => 'OSTA';

  @override
  String get sell => 'MYY';

  @override
  String get logoutDialogTitle => 'Istunto vanhentunut';

  @override
  String get logoutDialogDefaultReason =>
      'Tilisi on kirjautunut sisään toisella laitteella.';

  @override
  String get ok => 'OK';

  @override
  String get contactToUpgrade => 'Ota yhteyttä päivittääksesi';

  @override
  String get noNotificationsYet => 'Ei ilmoituksia vielä.';

  @override
  String daysAgo(int count) {
    return '$count päivää sitten';
  }

  @override
  String hoursAgo(int count) {
    return '$count tuntia sitten';
  }

  @override
  String minutesAgo(int count) {
    return '$count minuuttia sitten';
  }

  @override
  String get justNow => 'Juuri nyt';

  @override
  String get getSignalsNow => 'Hanki signaalit nyt';

  @override
  String get freeTrial => 'Ilmainen kokeilu';

  @override
  String get heroTitle =>
      'Kauppiaiden ohjaaminen & Portfolioiden kasvattaminen';

  @override
  String get heroSubtitle =>
      'Lopullinen AI-moottori – Asiantuntijakauppiaiden suunnittelema';

  @override
  String get globalAiInnovationTitle =>
      'Globaali AI-innovaatio seuraavan sukupolven kaupankäyntiälylle';

  @override
  String get globalAiInnovationDesc =>
      'Perinteisen kaupankäynnin muuttaminen pilvipohjaisilla AI-signaaleilla — mukautuen reaaliaikaisiin markkinauutisiin ja trendeihin\nnopeampaa, tarkempaa ja tunteetonta suorituskykyä varten.';

  @override
  String get liveTradingSignalsTitle => 'LIVE – 24/7 AI-kaupankäyntisignaalit';

  @override
  String get liveTradingSignalsDesc =>
      'Reaaliaikainen pilvianalytiikka tarjoaa korkean todennäköisyyden, trendejä seuraavia strategioita mukautuvalla tarkkuudella ja tunteettomalla toteutuksella.';

  @override
  String get trendFollowing => 'Trendejä seuraava';

  @override
  String get realtime => 'Reaaliaikainen';

  @override
  String get orderExplanationEngineTitle => 'Tilausten selitysmoottori';

  @override
  String get orderExplanationEngineDesc =>
      'Selittää kaupankäyntiasetukset yksinkertaisin termein — näyttäen miten yhtymäkohdat muodostuvat, miksi sisääntulot tehdään, ja auttaen kauppiaita oppimaan jokaisesta päätöksestä.';

  @override
  String get transparent => 'Läpinäkyvä';

  @override
  String get educational => 'Opettavainen';

  @override
  String get logical => 'Looginen';

  @override
  String get transparentRealPerformanceTitle =>
      'Läpinäkyvä - Todellinen suorituskyky';

  @override
  String get transparentRealPerformanceDesc =>
      'Katso todellista dataa signaalin tarkkuudesta, onnistumisasteesta ja kannattavuudesta — vahvistettu ja jäljitettävissä jokaisessa kaupassa';

  @override
  String get results => 'Tulokset';

  @override
  String get performanceTracking => 'Suorituskyvyn seuranta';

  @override
  String get accurate => 'Tarkka';

  @override
  String get predictiveAccuracy => 'Ennustava tarkkuus';

  @override
  String get improvementInProfitability => 'Kannattavuuden parantaminen';

  @override
  String get improvedRiskManagement => 'Parannettu riskienhallinta';

  @override
  String get signalsPerformanceTitle => 'Signaalien suorituskyky';

  @override
  String get riskToRewardRatio => 'Riski-palkkio-suhde';

  @override
  String get howRiskComparesToReward => 'Miten riski vertautuu palkkioon';

  @override
  String get profitLossOverview => 'Voitto/Tappio Yleiskatsaus';

  @override
  String get netGainVsLoss => 'Nettovoitto vs tappio';

  @override
  String get winRate => 'Voittoprosentti';

  @override
  String get percentageOfWinningTrades => 'Voittavien kauppojen prosenttiosuus';

  @override
  String get accuracyRate => 'Tarkkuusaste';

  @override
  String get howPreciseOurSignalsAre => 'Kuinka tarkkoja signaalimme ovat';

  @override
  String get realtimeMarketAnalysis => 'Reaaliaikainen markkina-analyysi';

  @override
  String get realtimeMarketAnalysisDesc =>
      'Tekoälymme seuraa markkinoita jatkuvasti, tunnistaen tekniset konvergenssialueet ja luotettavat läpimurtopisteet, jotta voit tehdä kauppoja oikealla hetkellä.';

  @override
  String get saveTimeOnAnalysis => 'Säästä aikaa analyysissä';

  @override
  String get saveTimeOnAnalysisDesc =>
      'Ei enää tuntikausien kaavioiden lukemista. Vastaanota räätälöityjä sijoitusstrategioita vain muutamassa minuutissa päivässä.';

  @override
  String get minimizeEmotionalTrading => 'Minimoi tunteellinen kaupankäynti';

  @override
  String get minimizeEmotionalTradingDesc =>
      'Älykkäiden hälytysten, riskintunnistuksen ja dataan perustuvien signaalien (ei tunteiden) avulla pysyt kurinalaisena ja hallitset jokaista päätöstä.';

  @override
  String get seizeEveryOpportunity => 'Tartu jokaiseen tilaisuuteen';

  @override
  String get seizeEveryOpportunityDesc =>
      'Suoraan sähköpostiisi toimitetut oikea-aikaiset strategiapäivitykset varmistavat, että hyödynnät markkinatrendit täydelliseen aikaan.';

  @override
  String get minvestAiCoreValueTitle => 'Minvest AI - Ydinarvo';

  @override
  String get minvestAiCoreValueDesc =>
      'AI analysoi reaaliaikaista markkinadataa jatkuvasti, suodattaen oivalluksia nopeiden ja tarkkojen sijoitusmahdollisuuksien tunnistamiseksi';

  @override
  String get frequentlyAskedQuestions => 'Usein kysytyt kysymykset (UKK)';

  @override
  String get faqSubtitle =>
      'Kaikki kysymyksesi — liittymisestä, eduista, tekoälymme toimintaan — vastataan alla. Jos sinulla on vielä epäilyksiä, voit lähettää meille viestin Whatsappissa';

  @override
  String get maximizeResultsTitle =>
      'Maksimoi tuloksesi Minvest AI:lla\nedistynyt markkina-analyysi ja tarkkuussuodatetut signaalit';

  @override
  String get elevateTradingWithAiStrategies =>
      'Nosta kaupankäyntisi tasoa AI-tehostetuilla strategioilla, jotka on suunniteltu johdonmukaisuutta ja selkeyttä varten';

  @override
  String get winMoreWithAiSignalsTitle =>
      'Voita enemmän AI-pohjaisilla signaaleilla\njokaisella markkinalla';

  @override
  String get winMoreWithAiSignalsDesc =>
      'Monimarkkina-AI:mme skannaa Forexia, kryptoa ja metalleja reaaliajassa,\ntoimittaen asiantuntijoiden validoimia kaupankäyntisignaaleja —\nselkeillä sisääntulo-, stop-loss- ja take-profit-tasoilla';

  @override
  String get buyLimit => 'Ostoraja';

  @override
  String get sellLimit => 'Myyntiraja';

  @override
  String get smarterToolsTitle => 'Älykkäämmät työkalut - Paremmat sijoitukset';

  @override
  String get smarterToolsDesc =>
      'Löydä ominaisuudet, jotka auttavat sinua minimoimaan riskejä, tarttumaan tilaisuuksiin ja kasvattamaan varallisuuttasi';

  @override
  String get performanceOverviewTitle => 'Suorituskyvyn yleiskatsaus';

  @override
  String get performanceOverviewDesc =>
      'Monimarkkina-AI:mme skannaa Forexia, kryptoa ja metalleja reaaliajassa, toimittaen asiantuntijoiden validoimia kaupankäyntisignaaleja - selkeillä sisääntulo-, stop-loss- ja take-profit-tasoilla';

  @override
  String get totalProfit => 'Kokonaisvoitto';

  @override
  String get completionSignal => 'Valmistumissignaali';

  @override
  String get onDemandFinancialExpertTitle =>
      'Sinun talousasiantuntijasi pyynnöstä';

  @override
  String get onDemandFinancialExpertDesc =>
      'AI-alusta ehdottaa kaupankäyntisignaaleja - itseoppiva, analysoi markkinoita 24/7, tunteet eivät vaikuta. Minvest on tukenut yli 10 000 talousanalyytikkoa heidän matkallaan löytää tarkkoja, vakaita ja helposti sovellettavia signaaleja';

  @override
  String get aiPoweredSignalPlatform =>
      'AI-pohjainen kaupankäyntisignaalialusta';

  @override
  String get selfLearningSystems =>
      'Itseoppivat järjestelmät, terävämmät oivallukset, vahvemmat kaupat';

  @override
  String get emotionlessExecution =>
      'Tunteeton toteutus älykkäämpään ja kurinalaisempaan kaupankäyntiin';

  @override
  String get analysingMarket247 => 'Analysoi markkinoita 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Maksimoi tuloksesi Minvest AI:lla\nedistynyt markkina-analyysi ja tarkkuussuodatetut signaalit';

  @override
  String get minvestAiRegistrationDesc =>
      'Minvest AI -rekisteröinti on nyt auki — paikat saattavat sulkeutua pian, kun tarkistamme ja hyväksymme uusia jäseniä';

  @override
  String get currencyPairs => 'Hyödyke';

  @override
  String get allCurrencyPairs => 'Kaikki valuuttaparit';

  @override
  String get allCommodities => 'Kaikki hyödykkeet';

  @override
  String get allCryptoPairs => 'Kaikki kryptoparit';

  @override
  String get dateRange => 'Päivämääräväli';

  @override
  String get selectDateRange => 'Valitse päivämääräväli';

  @override
  String get allAssets => 'Kaikki omaisuuserät';

  @override
  String get asset => 'Omaisuuserä';

  @override
  String get tokenExpired => 'Token vanhentunut';

  @override
  String get tokenLimitReachedDesc =>
      'Olet käyttänyt 10 ilmaista tokeniasi tänään. Päivitä pakettisi nähdäksesi lisää signaaleja.';

  @override
  String get later => 'Myöhemmin';

  @override
  String get created => 'Luotu';

  @override
  String get detail => 'Yksityiskohta';

  @override
  String get performanceOverview => 'Suorituskyvyn yleiskatsaus';

  @override
  String get totalProfitPips => 'Kokonaisvoitto (Pips)';

  @override
  String get winRatePercent => 'Voittoprosentti (%)';

  @override
  String get comingSoon => 'Tulossa pian';

  @override
  String get errorLoadingHistory => 'Virhe historian lataamisessa';

  @override
  String get noHistoryAvailable => 'Ei signaalihistoriaa saatavilla';

  @override
  String get previous => 'Edellinen';

  @override
  String get page => 'Sivu';

  @override
  String get next => 'Seuraava';

  @override
  String get date => 'Päivämäärä';

  @override
  String get timeGmt7 => 'Aika (GMT)';

  @override
  String get orders => 'Tilaukset';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      'Pieni näyttö: käännä vaakaan tai vieritä vaakasuunnassa nähdäksesi koko taulukon.';

  @override
  String get history => 'Historia';

  @override
  String get signalsWillAppearHere =>
      'Signaalit näkyvät täällä, kun ne ovat saatavilla';

  @override
  String get pricing => 'Hinnoittelu';

  @override
  String get choosePlanSubtitle => 'Valitse suunnitelma, joka sopii sinulle';

  @override
  String get financialNewsHub => 'Talousuutiskeskus';

  @override
  String get financialNewsHubDesc =>
      'Kriittiset päivitykset. Markkinareaktiot. Ei melua – vain mitä sijoittajien on tiedettävä.';

  @override
  String get newsTabAllArticles => 'Kaikki artikkelit';

  @override
  String get newsTabInvestor => 'Sijoittaja';

  @override
  String get newsTabKnowledge => 'Tieto';

  @override
  String get newsTabTechnicalAnalysis => 'Tekninen analyysi';

  @override
  String noArticlesForCategory(Object category) {
    return 'Ei artikkeleita kategorialle $category';
  }

  @override
  String get mostPopular => 'Suosituin';

  @override
  String get noPosts => 'Ei julkaisuja';

  @override
  String get relatedArticles => 'Liittyvät artikkelit';

  @override
  String get contactInfoSentSuccess => 'Yhteystiedot lähetetty onnistuneesti.';

  @override
  String contactInfoSentFailed(Object error) {
    return 'Tietojen lähetys epäonnistui: $error';
  }

  @override
  String get contactPageSubtitle =>
      'Onko kysyttävää tai tarvitsetko AI-ratkaisuja? Kerro meille täyttämällä lomake, niin otamme yhteyttä!';

  @override
  String get phone => 'Puhelin';

  @override
  String get firstName => 'Etunimi';

  @override
  String get enterFirstName => 'Syötä etunimi';

  @override
  String get lastName => 'Sukunimi';

  @override
  String get enterLastName => 'Syötä sukunimi';

  @override
  String get whatAreYourConcerns => 'Mitkä ovat huolesi?';

  @override
  String get writeConcernsHere => 'Kirjoita huolet tähän...';

  @override
  String pleaseEnter(Object field) {
    return 'Syötä $field';
  }

  @override
  String get faqQuestion1 => 'Takaavatko signaalit 100% onnistumisasteen?';

  @override
  String get faqAnswer1 =>
      'Vaikka yhtään signaalia ei voida taata 100%, Minvest AI pyrkii ylläpitämään vakaata 60–80% onnistumisastetta, jota tukee yksityiskohtainen analyysi ja riskienhallinta, jotta voit tehdä lopullisen päätöksen suuremmalla luottamuksella.';

  @override
  String get faqQuestion2 =>
      'Jos en halua tallettaa heti, voinko silti saada signaaliehdotuksia?';

  @override
  String get faqAnswer2 =>
      'Tilin avaamisen yhteydessä järjestelmä lahjoittaa sinulle 10 ilmaista tokenia, mikä vastaa 10 yksityiskohtaista signaalinäkymää. Sen jälkeen saat joka päivä 1 ylimääräisen tokenin käytettäväksi. Jos päivität VIP-tiliin, avaat monia edistyneitä ominaisuuksia ja seuraat rajoittamatonta määrää tilauksia.';

  @override
  String get faqQuestion3 =>
      'Jos olen rekisteröitynyt mutta en ole saanut signaaleja, mitä minun pitäisi tehdä?';

  @override
  String get faqAnswer3 =>
      'Käsittely on tyypillisesti automaattista. Jos et vieläkään näe signaaliehdotuksia, ota meihin yhteyttä Whatsappilla saadaksesi välitöntä apua.';

  @override
  String get faqQuestion4 =>
      'Kuinka monta signaalia saan päivässä, kun päivitän VIP-tiliin?';

  @override
  String get faqAnswer4 =>
      'Kun päivität VIP-tiliin, saat rajoittamattomia kaupankäyntisignaaleja joka päivä. Signaalien määrä ei ole kiinteä, vaan riippuu täysin markkina-analyysistä. Aina kun korkealaatuinen ja korkean todennäköisyyden sisääntulopiste ilmestyy, analyysitiimi lähettää signaalin sinulle välittömästi.';

  @override
  String get priceLevels => 'Hintatasot';

  @override
  String get capitalManagement => 'Pääoman hallinta';

  @override
  String freeSignalsLeft(Object count) {
    return '$count ilmaista signaalia jäljellä';
  }

  @override
  String get unlimitedSignals => 'Rajoittamattomat signaalit';

  @override
  String get goBack => 'Mene takaisin';

  @override
  String get goldPlan => 'Kulta Suunnitelma';

  @override
  String get perMonth => '/ kuukausi';

  @override
  String get continuouslyUpdating => 'Päivittää markkinadataa jatkuvasti 24/7';

  @override
  String get providingBestSignals => 'Tarjoaa parhaat signaalit reaaliajassa';

  @override
  String get includesEntrySlTp => 'Sisältää Sisääntulo, SL, TP';

  @override
  String get detailedAnalysis =>
      'Yksityiskohtainen analyysi ja arviointi jokaisesta signaalista';

  @override
  String get realTimeNotifications =>
      'Reaaliaikaiset ilmoitukset sähköpostitse';

  @override
  String get signalPerformanceStats => 'Signaalin suorituskykytilastot';

  @override
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails => 'Yritysrekisterinumero: 0110057263';

  @override
  String get addressDetails =>
      'Osoite: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam';

  @override
  String get pagesTitle => 'Sivut';

  @override
  String get legalRegulatoryTitle => 'Laki & Sääntely';

  @override
  String get termsOfRegistration => 'Rekisteröintiehdot';

  @override
  String get operatingPrinciples => 'Toimintaperiaatteet';

  @override
  String get termsConditions => 'Ehdot & Edellytykset';

  @override
  String get contactTitle => 'Yhteystiedot';

  @override
  String get navFeatures => 'Ominaisuudet';

  @override
  String get navNews => 'Uutiset';

  @override
  String get tp1Hit => 'TP1 Osuma';

  @override
  String get tp2Hit => 'TP2 Osuma';

  @override
  String get tp3Hit => 'TP3 Osuma';

  @override
  String get slHit => 'SL Osuma';

  @override
  String get cancelled => 'Peruutettu';

  @override
  String get exitedByAdmin => 'Ylläpitäjän poistama';

  @override
  String get signalClosed => 'Suljettu';

  @override
  String get errorLoadingPackages => 'Virhe pakettien lataamisessa';

  @override
  String get monthly => 'Kuukausittain';

  @override
  String get annually => 'Vuosittain';

  @override
  String get whatsIncluded => 'Mitä sisältyy:';

  @override
  String get chooseThisPlan => 'Valitse tämä suunnitelma';

  @override
  String get bestPricesForPremiumAccess =>
      'Parhaat hinnat Premium-käyttöoikeudelle';

  @override
  String get choosePlanFitsNeeds =>
      'Valitse liiketoimintatarpeisiisi sopiva suunnitelma ja aloita automatisointi AI:lla';

  @override
  String get save50Percent => 'SÄÄSTÄ 50%';

  @override
  String get tryDemo => 'Kokeile demoa';

  @override
  String get pleaseEnterEmailPassword => 'Anna sähköposti ja salasana';

  @override
  String loginFailed(String error) {
    return 'Kirjautuminen epäonnistui: $error';
  }

  @override
  String get welcomeBack => 'Tervetuloa takaisin';

  @override
  String get signInToContinue => 'Kirjaudu tilillesi jatkaaksesi';

  @override
  String get or => 'tai';

  @override
  String get email => 'Sähköposti';

  @override
  String get emailHint => 'esimerkki123@gmail.com';

  @override
  String get password => 'Salasana';

  @override
  String get enterPassword => 'Anna salasana';

  @override
  String get forgotPassword => 'Unohditko salasanasi?';

  @override
  String get createNewAccount => 'Luo uusi tili täällä!';

  @override
  String get signUp => 'Rekisteröidy';

  @override
  String get signUpAccount => 'Rekisteröi tili';

  @override
  String get enterPersonalData => 'Syötä henkilötietosi luodaksesi tilisi';

  @override
  String get nameLabel => 'Nimi *';

  @override
  String get enterNameHint => 'Anna nimi';

  @override
  String get emailLabel => 'Sähköposti *';

  @override
  String get passwordLabel => 'Salasana *';

  @override
  String get phoneLabel => 'Puhelin';

  @override
  String get continueButton => 'Jatka';

  @override
  String get fillAllFields => 'Täytä kaikki pakolliset kentät.';

  @override
  String get accountCreatedSuccess => 'Tili luotu onnistuneesti.';

  @override
  String signUpFailed(String error) {
    return 'Rekisteröityminen epäonnistui: $error';
  }

  @override
  String get nationality => 'Kansalaisuus:';

  @override
  String get overview => 'Yleiskatsaus';

  @override
  String get setting => 'Asetus';

  @override
  String get paymentHistory => 'Maksuhistoria';

  @override
  String get signalsPlan => 'Signaalisuunnitelma';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => 'Sinun Tokenit';

  @override
  String get emailNotificationPreferences => 'Sähköposti-ilmoitusasetukset';

  @override
  String get chooseSignalNotificationTypes =>
      'Valitse, minkä tyyppisiä signaali-ilmoituksia haluat vastaanottaa sähköpostitse';

  @override
  String get allSignalNotifications => 'Kaikki signaali-ilmoitukset';

  @override
  String get cryptoSignals => 'Krypto-signaalit';

  @override
  String get forexSignals => 'Forex-signaalit';

  @override
  String get goldSignals => 'Kulta-signaalit';

  @override
  String get updatePasswordSecure =>
      'Päivitä salasanasi pitääksesi tilisi turvassa';

  @override
  String get searchLabel => 'Haku:';

  @override
  String get filterBy => 'Suodata:';

  @override
  String get allTime => 'Koko aika';

  @override
  String get startDate => 'Aloituspäivä:';

  @override
  String get endDate => 'Lopetuspäivä:';

  @override
  String get deactivate => 'Deaktivoi';

  @override
  String get unlimited => 'Rajoittamaton';

  @override
  String get tenLeft => '10 jäljellä';

  @override
  String get termsOfRegistrationContent =>
      'Please read all the terms and agreements below carefully before proceeding with the next steps in our system.\nBy registering an account on the mInvest AI system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\n1. Introduction and Scope of Application\n\nThis policy regulates the collection, use, sharing, and protection of users’ personal information when accessing and using the products and services of the mInvest AI system – a technology and artificial intelligence platform owned and operated by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED (hereinafter referred to as “we” or “us”).\nBy registering an account or using mInvest AI’s products, you agree that such action constitutes a legally binding commitment between you and us, equivalent to an electronic contract.\n\n2. Account Registration\n\nTo access and use certain services on mInvest AI, you must register a valid account.\nWhen registering, you are required to provide complete and accurate personal information, including your full name, email address, phone number, or any other information as requested.\nAfter registration, you must confirm your email to activate the account. All notifications about your account, promotions, or system updates will be sent to this email address.\nIf the information you provide is inaccurate or incomplete, you will be solely responsible for any incidents or damages arising from it.\n\n3. Terms of Use\n\nWhen participating in the mInvest AI system, you are obligated to comply with all of the following:\nThe operating principles of the platform;\nPayment terms;\nPersonal data privacy policy;\nRelevant laws and regulations in effect.\nIn the event of a violation, EZTRADE reserves the right to temporarily suspend or permanently delete your account, and may transfer the case to competent authorities if necessary.\n\n4. Personal Data Privacy Policy\n\n4.1. Purpose and Scope of ... [truncated]';

  @override
  String get operatingPrinciplesContent =>
      'Please read all terms and agreements below carefully before proceeding with the next steps in our system. \nBy registering an account on the mInvest AI system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\nOPERATING RULES\n\n1. Legal Information\n\nSystem Owner:\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness/Tax Code: 0110057263\nPhone: 0862 600 626\n\n2. Scope of Application\n\nThese Operating Principles apply to all users, learners, partners, and collaborators who participate in or use the products and services within the mInvest AI system, including websites, applications, training platforms, and other online channels managed by EZTRADE.\nBy registering an account or using the services of mInvest AI, users are deemed to have read, understood, and agreed to all the terms set forth in these regulations.\n\n3. Definitions\n\n“mInvest AI” refers to the technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED.\n“Customer” / “User” / “Learner” refers to any individual or organization that registers, accesses, or uses the services and products on the mInvest AI system.\n“We” / “Administration” refers to the management team representing EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED, responsible for operating and managing the system.\n“Products” / “Services” include learning packages, analytical newsletters, AI trading signals, analytical tools, or any digital content provided by mInvest AI.\n\n4. Usage Rules and Information Security\n\nUsers must provide accurate and complete information when registering an account.\nmInvest AI is committed to protecting personal information and will not disclose it to third parties unless required by competent authorities.\nUsers are responsible for maintaining the confidentiality of their account and pa... [truncated]';

  @override
  String get termsAndConditionsContent =>
      'By opening an account to participate in the mInvest AI system, you confirm that you have read, understood, and agreed to all the contents of these Account Opening Terms and Conditions.\nThe latest updates (if any) will be published here, and mInvest AI will not send separate notifications to each customer. Therefore, please visit this page regularly to stay informed about the most recent policies.\n\n1. General Agreement\n\nmInvest AI is a technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED. By opening an account on this system, you agree to participate in and use the services and products provided by EZTRADE.\nAccount registration and activation are considered an electronic contract between you and mInvest AI, which has the same legal validity as a civil contract under the laws of Vietnam.\n\n2. Personal Account Information and Privacy\n\n2.1. Purpose and Scope of Information Collection\n\nTo access and use certain mInvest AI services, you must provide basic personal information, including:\nFull name;\nEmail address;\nContact phone number;\nOther information (if any) necessary for verification, support, or access authorization.\nAll information provided must be accurate, truthful, and lawful. mInvest AI shall not be responsible for any losses or disputes arising from false, missing, or fraudulent information provided by the user.\nAdditionally, the system may automatically collect certain technical data, such as:\nIP address, browser type, and language used;\nAccess time and pages viewed within the system.\nThis information helps mInvest AI improve performance, enhance security, and optimize user experience.\n\n2.2. Scope of Information Use\n\nYour personal information is collected and used for legitimate purposes, including:\nManaging accounts, verifying users, and maintaining services;\nSending notifications related to services, accounts, promotions, or policy changes;\nProv... [truncated]';

  @override
  String get performance => 'Suorituskyky';

  @override
  String get minvestSupport => 'Minvest Tuki';

  @override
  String get leaveMessagePart1 =>
      'Jätä viesti, tiimimme vastaa mahdollisimman pian. Voit myös ottaa yhteyttä ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 nopeaa tukea varten.';
}
