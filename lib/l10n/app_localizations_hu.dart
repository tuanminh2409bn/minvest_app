// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'FIÓK SIKERESEN FRISSÍTVE';

  @override
  String get lotPerWeek => 'Lot/hét';

  @override
  String get tableValueFull => 'teljes';

  @override
  String get tableValueFulltime => 'teljes munkaidős';

  @override
  String get packageTitle => 'CSOMAG';

  @override
  String get duration1Month => '1 hónap';

  @override
  String get duration12Months => '12 hónap';

  @override
  String get featureReceiveAllSignals => 'A nap összes jelzésének fogadása';

  @override
  String get featureAnalyzeReason => 'A megbízás okának elemzése';

  @override
  String get featureHighPrecisionAI => 'Nagy pontosságú AI jelzés';

  @override
  String get iapStoreNotAvailable => 'Az üzlet nem érhető el ezen az eszközön.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'Hiba a termékek betöltésekor: $message';
  }

  @override
  String get iapNoProductsFound =>
      'Nem találhatók termékek. Kérjük, ellenőrizze az üzlet konfigurációját.';

  @override
  String iapTransactionError(Object message) {
    return 'Tranzakciós hiba: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'Ellenőrzési hiba: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'Ismeretlen hiba történt: $error';
  }

  @override
  String get iapProcessingTransaction => 'Tranzakció feldolgozása...';

  @override
  String get orderInfo1Month => 'Fizetés Elite 1 hónapos csomagért';

  @override
  String get orderInfo12Months => 'Fizetés Elite 12 hónapos csomagért';

  @override
  String get iapNotSupportedOnWeb =>
      'Az alkalmazáson belüli vásárlás nem támogatott a webes verzióban.';

  @override
  String get vnpayPaymentTitle => 'VNPAY FIZETÉS';

  @override
  String get creatingOrderWait => 'Rendelés létrehozása, kérem várjon...';

  @override
  String errorWithMessage(Object message) {
    return 'Hiba: $message';
  }

  @override
  String get cannotConnectToServer =>
      'Nem sikerült csatlakozni a szerverhez. Kérjük, próbálja újra.';

  @override
  String get transactionCancelledOrFailed =>
      'A tranzakció megszakadt vagy sikertelen.';

  @override
  String get cannotCreatePaymentLink =>
      'Nem sikerült létrehozni a fizetési linket.\nPróbálja újra.';

  @override
  String get retry => 'Újrapróbálkozás';

  @override
  String serverErrorRetry(Object message) {
    return 'Szerverhiba: $message. Kérjük, próbálja újra.';
  }

  @override
  String get redirectingToPayment => 'Átirányítás a fizetési oldalra...';

  @override
  String get invalidPaymentUrl =>
      'Érvénytelen fizetési URL érkezett a szervertől.';

  @override
  String get processingYourAccount => 'Fiók feldolgozása...';

  @override
  String get verificationFailed => 'Az ellenőrzés sikertelen!';

  @override
  String get reuploadImage => 'Kép feltöltése újra';

  @override
  String get accountNotLinked => 'A fiók nincs összekapcsolva a Signal GPTtel';

  @override
  String get accountNotLinkedDesc =>
      'Az exkluzív jelzések eléréséhez az Exness-fiókját a Signal GPT partnerlinkjén keresztül kell regisztrálni. Kérjük, hozzon létre új fiókot az alábbi link segítségével.';

  @override
  String get registerExnessViaSignalGPT =>
      'Exness regisztráció Signal GPTen keresztül';

  @override
  String get iHaveRegisteredReupload => 'Már regisztráltam, feltöltés újra';

  @override
  String couldNotLaunch(Object url) {
    return 'Nem sikerült megnyitni: $url';
  }

  @override
  String get status => 'Állapot';

  @override
  String get sentOn => 'Elküldve';

  @override
  String get entryPrice => 'Belépési ár';

  @override
  String get stopLossFull => 'Stop loss';

  @override
  String get takeProfitFull1 => 'Take profit 1';

  @override
  String get takeProfitFull2 => 'Take profit 2';

  @override
  String get takeProfitFull3 => 'Take profit 3';

  @override
  String get noReasonProvided => 'Ehhez a jelzéshez nem adtak meg okot.';

  @override
  String get upgradeToViewReason =>
      'Frissítse fiókját Elite-re az elemzés megtekintéséhez.';

  @override
  String get upgradeToViewFullAnalysis =>
      'Frissítés a teljes elemzés megtekintéséhez';

  @override
  String get welcomeTo => 'Üdvözöljük a';

  @override
  String get appSlogan => 'Fokozza kereskedését intelligens jelzésekkel.';

  @override
  String get signIn => 'Bejelentkezés';

  @override
  String get continueByGoogle => 'Folytatás Google-lal';

  @override
  String get continueByFacebook => 'Folytatás Facebookkal';

  @override
  String get continueByApple => 'Folytatás Apple-lel';

  @override
  String get loginSuccess => 'Sikeres bejelentkezés!';

  @override
  String get live => 'ÉLŐ';

  @override
  String get end => 'VÉGE';

  @override
  String get symbol => 'SZIMBÓLUM';

  @override
  String get aiSignal => 'AI Jelzések';

  @override
  String get ruleSignal => 'SZABÁLY JELZÉS';

  @override
  String get all => 'ÖSSZES';

  @override
  String get upgradeToSeeMore => 'Frissítés a továbbiak megtekintéséhez';

  @override
  String get seeDetails => 'részletek megtekintése';

  @override
  String get notMatched => 'NEM EGYEZIK';

  @override
  String get matched => 'EGYEZIK';

  @override
  String get entry => 'Belépés';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'Frissítés';

  @override
  String get upgradeAccount => 'FIÓK FRISSÍTÉSE';

  @override
  String get compareTiers => 'SZINTEK ÖSSZEHASONLÍTÁSA';

  @override
  String get feature => 'Funkció';

  @override
  String get tierDemo => 'Demo';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'Egyenleg';

  @override
  String get signalTime => 'Jelzés ideje';

  @override
  String get signalQty => 'Jelzés mennyisége';

  @override
  String get analysis => 'Elemzés';

  @override
  String get openExnessAccount => 'Exness-fiók nyitása!';

  @override
  String get accountVerificationWithExness => 'Fiókellenőrzés Exness-szel';

  @override
  String get payInAppToUpgrade => 'Fizetés alkalmazáson belül a frissítéshez';

  @override
  String get bankTransferToUpgrade => 'Banki átutalás a frissítéshez';

  @override
  String get accountVerification => 'FIÓKELLENŐRZÉS';

  @override
  String get accountVerificationPrompt =>
      'Kérjük, töltsön fel egy képernyőképet Exness-fiókjáról az engedélyezéshez (a fiókját a Signal GPT Exness-linkjén keresztül kell megnyitni)';

  @override
  String get selectPhotoFromLibrary => 'Fénykép kiválasztása a könyvtárból';

  @override
  String get send => 'Küldés';

  @override
  String get accountInfo => 'Fiókinformáció';

  @override
  String get accountVerifiedSuccessfully => 'FIÓK SIKERESEN ELLENŐRIZVE';

  @override
  String get yourAccountIs => 'A fiókja';

  @override
  String get returnToHomePage => 'Vissza a kezdőlapra';

  @override
  String get upgradeFailed =>
      'A frissítés sikertelen! Kérjük, töltse fel újra a képet';

  @override
  String get package => 'CSOMAG';

  @override
  String get startNow => 'Jelzések lekérése most';

  @override
  String get bankTransfer => 'BANKI ÁTUTALÁS';

  @override
  String get transferInformation => 'ÁTUTALÁSI INFORMÁCIÓK';

  @override
  String get scanForFastTransfer => 'Szkennelés gyors átutaláshoz';

  @override
  String get contactUs247 => 'Lépjen kapcsolatba velünk 24/7';

  @override
  String get newAnnouncement => 'ÚJ KÖZLEMÉNY';

  @override
  String get profile => 'Profil';

  @override
  String get upgradeNow => 'Frissítés most';

  @override
  String get followSignalGPT => 'Kövesse a Signal GPTet';

  @override
  String get tabSignal => 'Jelzés';

  @override
  String get tabChart => 'Diagram';

  @override
  String get tabProfile => 'Profil';

  @override
  String get reason => 'OK';

  @override
  String get error => 'Hiba';

  @override
  String get noSignalsAvailable => 'Nincsenek elérhető jelzések.';

  @override
  String get outOfGoldenHours => 'Aranyórákon kívül';

  @override
  String get outOfGoldenHoursVipDesc =>
      'A VIP jelzések 8:00 és 17:00 óra között érhetők el (GMT+7).\nFrissítsen Elite-re, hogy 24/24 órában kapjon jelzéseket!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'A Demo jelzések 8:00 és 17:00 óra között érhetők el (GMT+7).\nFrissítse fiókját további előnyökért!';

  @override
  String get yourName => 'Az Ön Neve';

  @override
  String get yourEmail => 'az.on.emailje@pelda.hu';

  @override
  String get adminPanel => 'Adminisztrációs panel';

  @override
  String get logout => 'Kijelentkezés';

  @override
  String get confirmLogout => 'Kijelentkezés megerősítése';

  @override
  String get confirmLogoutMessage => 'Biztosan ki szeretne jelentkezni?';

  @override
  String get cancel => 'Mégse';

  @override
  String get upgradeCardTitle => 'FRISSÍTSE FIÓKJÁT';

  @override
  String get upgradeCardSubtitle => 'További erőforrások eléréséhez';

  @override
  String get upgradeCardSubtitleWeb =>
      'Prémium jelzések és teljes munkaidős támogatás feloldásához';

  @override
  String get subscriptionDetails => 'Előfizetés részletei';

  @override
  String get notifications => 'Értesítések';

  @override
  String get continueAsGuest => 'Folytatás vendégként';

  @override
  String get deleteAccount => 'Fiók törlése';

  @override
  String get deleteAccountWarning =>
      'Biztosan törölni szeretné fiókját? Minden adata véglegesen törlődik, és nem állítható vissza.';

  @override
  String get delete => 'Törlés';

  @override
  String get privacyPolicy => 'Adatvédelmi irányelvek';

  @override
  String get termsOfService => 'Szolgáltatási feltételek';

  @override
  String get signalStatusMatched => 'EGYEZIK';

  @override
  String get signalStatusNotMatched => 'NEM EGYEZIK';

  @override
  String get signalStatusCancelled => 'VISSZAVONVA';

  @override
  String get signalStatusSlHit => 'SL ELÉRVE';

  @override
  String get signalStatusTp1Hit => 'TP1 ELÉRVE';

  @override
  String get signalStatusTp2Hit => 'TP2 ELÉRVE';

  @override
  String get signalStatusTp3Hit => 'TP3 ELÉRVE';

  @override
  String get signalStatusRunning => 'FUT';

  @override
  String get signalStatusClosed => 'LEZÁRT';

  @override
  String get contactUs => 'Kapcsolat';

  @override
  String get tabChat => 'Csevegés';

  @override
  String get exnessUpgradeNoteForIos =>
      'Azon ügyfelek számára, akik Exness-fiókot regisztráltak a Signal GPTen keresztül, kérjük, kattintson a kapcsolatfelvételre a fiók frissítéséhez.';

  @override
  String get chatWelcomeTitle => '👋 Üdvözli a Signal GPT!';

  @override
  String get chatWelcomeBody1 =>
      'Kérjük, hagyjon üzenetet, csapatunk a lehető leghamarabb válaszol.';

  @override
  String get chatWelcomeBody2 =>
      'Vagy lépjen kapcsolatba velünk közvetlenül Zalo/WhatsApp-on: ';

  @override
  String get chatWelcomeBody3 => ' a gyorsabb támogatásért!';

  @override
  String get chatLoginPrompt =>
      'Kérjük, jelentkezzen be a funkció használatához';

  @override
  String get chatStartConversation => 'Kezdje el a beszélgetést';

  @override
  String get chatNoMessages => 'Még nincsenek üzenetek.';

  @override
  String get chatTypeMessage => 'Írjon üzenetet...';

  @override
  String get chatSupportIsTyping => 'Támogatás gépel...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName gépel...';
  }

  @override
  String get chatSeen => 'Látva';

  @override
  String get chatDefaultUserName => 'Felhasználó';

  @override
  String get chatDefaultSupportName => 'Támogatás';

  @override
  String get signalEntry => 'Belépés';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get price12MonthsOld => '\$920';

  @override
  String get foreignTraderSupport =>
      'Külföldi kereskedők számára kérjük, lépjen kapcsolatba velünk WhatsApp-on (+84969.15.6969) támogatásért';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails =>
      'Frissítés a jelzés részleteinek megtekintéséhez...';

  @override
  String get buy => 'VÉTEL';

  @override
  String get sell => 'ELADÁS';

  @override
  String get logoutDialogTitle => 'A munkamenet lejárt';

  @override
  String get logoutDialogDefaultReason =>
      'Fiókja bejelentkezett egy másik eszközön.';

  @override
  String get ok => 'OK';

  @override
  String get contactToUpgrade => 'Kapcsolatfelvétel a frissítéshez';

  @override
  String get noNotificationsYet => 'Még nincsenek értesítések.';

  @override
  String get markAllRead => 'Mark all as read';

  @override
  String daysAgo(int count) {
    return '$count napja';
  }

  @override
  String hoursAgo(int count) {
    return '$count órája';
  }

  @override
  String minutesAgo(int count) {
    return '$count perce';
  }

  @override
  String get justNow => 'Épp most';

  @override
  String get getSignalsNow => 'Jelzések lekérése most';

  @override
  String get freeTrial => 'Ingyenes próbaverzió';

  @override
  String get heroTitle => 'Kereskedők irányítása és portfóliók növelése';

  @override
  String get heroSubtitle =>
      'A végső AI motor – Szakértő kereskedők által tervezve';

  @override
  String get globalAiInnovationTitle =>
      'Globális AI innováció a kereskedési intelligencia következő generációjáért';

  @override
  String get globalAiInnovationDesc =>
      'A hagyományos kereskedés átalakítása felhőalapú AI jelzésekkel — valós idejű piaci hírekhez és trendekhez igazodva\na gyorsabb, pontosabb és érzelemmentes teljesítmény érdekében.';

  @override
  String get liveTradingSignalsTitle => 'ÉLŐ – 24/7 AI Kereskedési Jelzések';

  @override
  String get liveTradingSignalsDesc =>
      'Valós idejű felhőelemzés, amely nagy valószínűségű, trendkövető stratégiákat kínál adaptív pontossággal és érzelemmentes végrehajtással.';

  @override
  String get trendFollowing => 'Trendkövető';

  @override
  String get realtime => 'Valós idejű';

  @override
  String get orderExplanationEngineTitle => 'Megbízásmagyarázó Motor';

  @override
  String get orderExplanationEngineDesc =>
      'Egyszerű kifejezésekkel magyarázza el a kereskedési beállításokat — bemutatva, hogyan alakulnak ki az együttállások, miért történnek a belépések, és segítve a kereskedőket, hogy tanuljanak minden döntésből.';

  @override
  String get transparent => 'Átlátható';

  @override
  String get educational => 'Oktatási';

  @override
  String get logical => 'Logikus';

  @override
  String get transparentRealPerformanceTitle =>
      'Átlátható - Valós teljesítmény';

  @override
  String get transparentRealPerformanceDesc =>
      'Tekintse meg a valós adatokat a jelzések pontosságáról, a sikerességi arányról és a jövedelmezőségről — ellenőrizve és nyomon követhetően minden kereskedésben';

  @override
  String get results => 'Eredmények';

  @override
  String get performanceTracking => 'Teljesítménykövetés';

  @override
  String get accurate => 'Pontos';

  @override
  String get predictiveAccuracy => 'Előrejelzési pontosság';

  @override
  String get improvementInProfitability => 'Jövedelmezőség javulása';

  @override
  String get improvedRiskManagement => 'Javított kockázatkezelés';

  @override
  String get signalsPerformanceTitle => 'Jelzések Teljesítménye';

  @override
  String get riskToRewardRatio => 'Kockázat-nyereség arány';

  @override
  String get howRiskComparesToReward =>
      'Hogyan viszonyul a kockázat a nyereséghez';

  @override
  String get profitLossOverview => 'Nyereség/Veszteség Áttekintés';

  @override
  String get netGainVsLoss => 'Nettó nyereség vs veszteség';

  @override
  String get winRate => 'Nyerési arány';

  @override
  String get percentageOfWinningTrades => 'Nyertes kereskedések százaléka';

  @override
  String get accuracyRate => 'Pontossági arány';

  @override
  String get howPreciseOurSignalsAre => 'Mennyire pontosak a jelzéseink';

  @override
  String get realtimeMarketAnalysis => 'Valós idejű piacelemzés';

  @override
  String get realtimeMarketAnalysisDesc =>
      'AI-nk folyamatosan figyeli a piacot, azonosítva a technikai konvergenciazónákat és a megbízható kitörési pontokat, hogy a megfelelő pillanatban léphessen be a kereskedésekbe.';

  @override
  String get saveTimeOnAnalysis => 'Időmegtakarítás az elemzésen';

  @override
  String get saveTimeOnAnalysisDesc =>
      'Nincs több órákig tartó diagramolvasás. Kapjon személyre szabott befektetési stratégiákat naponta mindössze néhány perc alatt.';

  @override
  String get minimizeEmotionalTrading => 'Érzelmi kereskedés minimalizálása';

  @override
  String get minimizeEmotionalTradingDesc =>
      'Intelligens riasztásokkal, kockázatérzékeléssel és adatközpontú jelzésekkel nem érzelmekkel fegyelmezett maradhat és minden döntést kézben tarthat.';

  @override
  String get seizeEveryOpportunity => 'Minden lehetőség megragadása';

  @override
  String get seizeEveryOpportunityDesc =>
      'Az időben érkező stratégiai frissítések közvetlenül a postaládájába biztosítják, hogy a piaci trendeket a tökéletes időben lovagolja meg.';

  @override
  String get minvestAiCoreValueTitle => 'Signal GPT - Alapérték';

  @override
  String get minvestAiCoreValueDesc =>
      'Az AI folyamatosan elemzi a valós idejű piaci adatokat, szűrve az információkat a gyors, pontos befektetési lehetőségek azonosításához';

  @override
  String get frequentlyAskedQuestions => 'Gyakran Ismételt Kérdések (GYIK)';

  @override
  String get faqSubtitle =>
      'Minden kérdésére — a csatlakozástól az előnyökig, az AI működéséig — az alábbiakban válaszolunk. Ha még mindig kétségei vannak, nyugodtan írjon nekünk Whatsappon';

  @override
  String get maximizeResultsTitle =>
      'Maximalizálja eredményeit a Signal GPT-vel\nfejlett piacelemzés és precíziós szűrésű jelzések';

  @override
  String get elevateTradingWithAiStrategies =>
      'Emelje kereskedését AI-val javított stratégiákkal, amelyeket a következetességre és a világosságra terveztek';

  @override
  String get winMoreWithAiSignalsTitle =>
      'Nyerjen többet AI-alapú jelzésekkel\nminden piacon';

  @override
  String get winMoreWithAiSignalsDesc =>
      'Többpiacos AI-nk valós időben pásztázza a Forexet, a kriptovalutákat és a fémeket,\nszakértők által validált kereskedési jelzéseket nyújtva —\negyértelmű belépési, stop-loss és take-profit szintekkel';

  @override
  String get buyLimit => 'Vételi limit';

  @override
  String get sellLimit => 'Eladási limit';

  @override
  String get smarterToolsTitle => 'Okosabb eszközök - Jobb befektetések';

  @override
  String get smarterToolsDesc =>
      'Fedezze fel azokat a funkciókat, amelyek segítenek minimalizálni a kockázatokat, megragadni a lehetőségeket és növelni vagyonát';

  @override
  String get performanceOverviewTitle => 'Teljesítmény Áttekintés';

  @override
  String get performanceOverviewDesc =>
      'Többpiacos AI-nk valós időben pásztázza a Forexet, a kriptovalutákat és a fémeket, szakértők által validált kereskedési jelzéseket nyújtva - egyértelmű belépési, stop-loss és take-profit szintekkel';

  @override
  String get totalProfit => 'Teljes nyereség';

  @override
  String get completionSignal => 'Befejezési jelzés';

  @override
  String get onDemandFinancialExpertTitle =>
      'Igény szerinti pénzügyi szakértője';

  @override
  String get onDemandFinancialExpertDesc =>
      'AI platform kereskedési jelzéseket javasol - öntanuló, 24/7 elemzi a piacot, érzelemektől mentes. A Signal GPT több mint 10 000 pénzügyi elemzőt támogatott abban, hogy pontos, stabil és könnyen alkalmazható jelzéseket találjanak';

  @override
  String get aiPoweredSignalPlatform => 'AI-alapú Kereskedési Jelzés Platform';

  @override
  String get selfLearningSystems =>
      'Öntanuló rendszerek, élesebb meglátások, erősebb kereskedések';

  @override
  String get emotionlessExecution =>
      'Érzelemmentes végrehajtás az okosabb, fegyelmezettebb kereskedésért';

  @override
  String get analysingMarket247 => 'Piac elemzése 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Maximalizálja eredményeit a Signal GPT-vel\nfejlett piacelemzés és precíziós szűrésű jelzések';

  @override
  String get minvestAiRegistrationDesc =>
      'A Signal GPT regisztráció most nyitva van — a helyek hamarosan betelhetnek, mivel felülvizsgáljuk és jóváhagyjuk az új tagokat';

  @override
  String get currencyPairs => 'Árucikk';

  @override
  String get allCurrencyPairs => 'Összes devizapár';

  @override
  String get allCommodities => 'Összes árucikk';

  @override
  String get allCryptoPairs => 'Összes kriptopár';

  @override
  String get dateRange => 'Dátumtartomány';

  @override
  String get selectDateRange => 'Dátumtartomány kiválasztása';

  @override
  String get allAssets => 'Összes eszköz';

  @override
  String get asset => 'Eszköz';

  @override
  String get tokenExpired => 'Token lejárt';

  @override
  String get tokenLimitReachedDesc =>
      'Ma elhasználta a 10 ingyenes tokenjét. Frissítse csomagját további jelzések megtekintéséhez.';

  @override
  String get later => 'Később';

  @override
  String get created => 'Létrehozva';

  @override
  String get detail => 'Részlet';

  @override
  String get performanceOverview => 'Teljesítmény Áttekintés';

  @override
  String get totalProfitPips => 'Teljes nyereség (Pips)';

  @override
  String get winRatePercent => 'Nyerési arány (%)';

  @override
  String get comingSoon => 'Hamarosan';

  @override
  String get errorLoadingHistory => 'Hiba az előzmények betöltésekor';

  @override
  String get noHistoryAvailable => 'Nincs elérhető jelzéselőzmény';

  @override
  String get previous => 'Előző';

  @override
  String get page => 'Oldal';

  @override
  String get next => 'Következő';

  @override
  String get date => 'Dátum';

  @override
  String get timeGmt7 => 'Idő';

  @override
  String get orders => 'Megbízások';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      'Kis képernyő: forgassa el fekvő tájolásba vagy görgessen vízszintesen a teljes táblázat megtekintéséhez.';

  @override
  String get history => 'Előzmények';

  @override
  String get signalsWillAppearHere =>
      'A jelzések itt jelennek meg, ha elérhetők';

  @override
  String get pricing => 'Árazás';

  @override
  String get choosePlanSubtitle => 'Válasszon egy tervet, amely megfelel Önnek';

  @override
  String get financialNewsHub => 'Pénzügyi Hírek Központ';

  @override
  String get financialNewsHubDesc =>
      'Kritikus frissítések. Piaci reakciók. Nincs zaj – csak amit a befektetőknek tudniuk kell.';

  @override
  String get newsTabAllArticles => 'Összes cikk';

  @override
  String get newsTabInvestor => 'Befektető';

  @override
  String get newsTabKnowledge => 'Tudás';

  @override
  String get newsTabTechnicalAnalysis => 'Technikai elemzés';

  @override
  String noArticlesForCategory(Object category) {
    return 'Nincsenek cikkek a(z) $category kategóriában';
  }

  @override
  String get mostPopular => 'Legnépszerűbb';

  @override
  String get noPosts => 'Nincsenek bejegyzések';

  @override
  String get relatedArticles => 'Kapcsolódó cikkek';

  @override
  String get contactInfoSentSuccess =>
      'Kapcsolattartási információk sikeresen elküldve.';

  @override
  String contactInfoSentFailed(Object error) {
    return 'Információk küldése sikertelen: $error';
  }

  @override
  String get contactPageSubtitle =>
      'Kérdései vannak, vagy AI megoldásokra van szüksége? Tudassa velünk az űrlap kitöltésével, és felvesszük a kapcsolatot!';

  @override
  String get phone => 'Telefon';

  @override
  String get firstName => 'Keresztnév';

  @override
  String get enterFirstName => 'Keresztnév megadása';

  @override
  String get lastName => 'Vezetéknév';

  @override
  String get enterLastName => 'Vezetéknév megadása';

  @override
  String get whatAreYourConcerns => 'Mik az aggályai?';

  @override
  String get writeConcernsHere => 'Írja le aggályait ide...';

  @override
  String pleaseEnter(Object field) {
    return 'Kérjük, adja meg: $field';
  }

  @override
  String get faqQuestion1 =>
      'A jelzések 100%-os sikerességi arányt garantálnak?';

  @override
  String get faqAnswer1 =>
      'Bár egyetlen jelzés sem garantálható 100%-ban, a Signal GPT stabil 60–80%-os sikerességi arány fenntartására törekszik, amelyet részletes elemzés és kockázatkezelés támogat, hogy Ön nagyobb magabiztossággal hozhassa meg a végső döntést.';

  @override
  String get faqQuestion2 =>
      'Ha nem szeretnék azonnal befizetni, kaphatok még jelzésjavaslatokat?';

  @override
  String get faqAnswer2 =>
      'Számlanyitáskor a rendszer 10 ingyenes tokent ajándékoz Önnek, ami 10 részletes jelzésmegtekintésnek felel meg. Ezt követően minden nap kap 1 további tokent felhasználásra. Ha VIP fiókra frissít, számos fejlett funkciót old fel, és korlátlan számú megbízást követhet nyomon.';

  @override
  String get faqQuestion3 =>
      'Ha regisztráltam, de nem kaptam jelzéseket, milyen lépéseket tegyek?';

  @override
  String get faqAnswer3 =>
      'A feldolgozás általában automatikus. Ha továbbra sem lát jelzésjavaslatokat, kérjük, lépjen kapcsolatba velünk Whatsappon azonnali segítségért.';

  @override
  String get faqQuestion4 =>
      'Hány jelzést kapok naponta, ha VIP fiókra frissítek?';

  @override
  String get faqAnswer4 =>
      'Ha VIP fiókra frissít, minden nap korlátlan kereskedési jelzést kap. A jelzések száma nem rögzített, hanem teljes mértékben a piaci elemzéstől függ. Amikor kiváló minőségű, nagy valószínűségű belépési pont jelenik meg, az elemző csapat azonnal elküldi Önnek a jelzést.';

  @override
  String get priceLevels => 'Árszintek';

  @override
  String get capitalManagement => 'Tőke kezelés';

  @override
  String freeSignalsLeft(Object count) {
    return '$count ingyenes jelzés maradt';
  }

  @override
  String get unlimitedSignals => 'Korlátlan jelzések';

  @override
  String get goBack => 'Vissza';

  @override
  String get goldPlan => 'Arany Terv';

  @override
  String get perMonth => '/ hónap';

  @override
  String get continuouslyUpdating => 'Folyamatosan frissülő piaci adatok 24/7';

  @override
  String get providingBestSignals =>
      'A legjobb jelzések biztosítása valós időben';

  @override
  String get includesEntrySlTp => 'Tartalmazza a Belépést, SL, TP';

  @override
  String get detailedAnalysis =>
      'Minden jelzés részletes elemzése és értékelése';

  @override
  String get realTimeNotifications => 'Valós idejű értesítések e-mailben';

  @override
  String get signalPerformanceStats => 'Jelzés teljesítmény statisztikák';

  @override
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails => 'Cégjegyzékszám: 0110057263';

  @override
  String get addressDetails =>
      'Cím: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam';

  @override
  String get pagesTitle => 'Oldalak';

  @override
  String get legalRegulatoryTitle => 'Jogi és Szabályozási';

  @override
  String get termsOfRegistration => 'Regisztrációs feltételek';

  @override
  String get operatingPrinciples => 'Működési elvek';

  @override
  String get termsConditions => 'Felhasználási feltételek';

  @override
  String get contactTitle => 'Kapcsolat';

  @override
  String get navFeatures => 'Funkciók';

  @override
  String get navNews => 'Hírek';

  @override
  String get tp1Hit => 'TP1 Elérve';

  @override
  String get tp2Hit => 'TP2 Elérve';

  @override
  String get tp3Hit => 'TP3 Elérve';

  @override
  String get slHit => 'SL Elérve';

  @override
  String get cancelled => 'Visszavonva';

  @override
  String get exitedByAdmin => 'Admin által kilépve';

  @override
  String get signalClosed => 'Lezárt';

  @override
  String get errorLoadingPackages => 'Hiba a csomagok betöltésekor';

  @override
  String get monthly => 'Havonta';

  @override
  String get annually => 'Évente';

  @override
  String get whatsIncluded => 'Mit tartalmaz:';

  @override
  String get chooseThisPlan => 'Válassza ezt a tervet';

  @override
  String get bestPricesForPremiumAccess =>
      'Legjobb árak a prémium hozzáféréshez';

  @override
  String get choosePlanFitsNeeds =>
      'Válasszon egy tervet, amely megfelel üzleti igényeinek, és kezdje el az automatizálást AI-val';

  @override
  String get save50Percent => 'MEGTAKARÍTÁS 50%';

  @override
  String get tryDemo => 'Demo kipróbálása';

  @override
  String get pleaseEnterEmailPassword =>
      'Kérjük, adja meg az e-mail címét és jelszavát';

  @override
  String loginFailed(String error) {
    return 'Bejelentkezés sikertelen: $error';
  }

  @override
  String get welcomeBack => 'Üdvözöljük újra';

  @override
  String get signInToContinue => 'Jelentkezzen be fiókjába a folytatáshoz';

  @override
  String get or => 'vagy';

  @override
  String get email => 'E-mail';

  @override
  String get emailHint => 'pelda123@gmail.com';

  @override
  String get password => 'Jelszó';

  @override
  String get enterPassword => 'Jelszó megadása';

  @override
  String get forgotPassword => 'Elfelejtette jelszavát?';

  @override
  String get createNewAccount => 'Hozzon létre új fiókot itt!';

  @override
  String get signUp => 'Regisztráció';

  @override
  String get signUpAccount => 'Fiók regisztrálása';

  @override
  String get enterPersonalData =>
      'Adja meg személyes adatait fiókja létrehozásához';

  @override
  String get nameLabel => 'Név *';

  @override
  String get enterNameHint => 'Név megadása';

  @override
  String get emailLabel => 'E-mail *';

  @override
  String get passwordLabel => 'Jelszó *';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get continueButton => 'Folytatás';

  @override
  String get fillAllFields => 'Kérjük, töltsön ki minden kötelező mezőt.';

  @override
  String get accountCreatedSuccess => 'Fiók sikeresen létrehozva.';

  @override
  String signUpFailed(String error) {
    return 'Regisztráció sikertelen: $error';
  }

  @override
  String get nationality => 'Állampolgárság:';

  @override
  String get overview => 'Áttekintés';

  @override
  String get setting => 'Beállítás';

  @override
  String get paymentHistory => 'Fizetési előzmények';

  @override
  String get signalsPlan => 'Jelzés terv';

  @override
  String get aiSignalGPT => 'AI Signal GPT';

  @override
  String get yourTokens => 'Tokenjei';

  @override
  String get emailNotificationPreferences => 'E-mail értesítési beállítások';

  @override
  String get chooseSignalNotificationTypes =>
      'Válassza ki, milyen típusú jelzésértesítéseket szeretne kapni e-mailben';

  @override
  String get allSignalNotifications => 'Összes jelzésértesítés';

  @override
  String get cryptoSignals => 'Kripto jelzések';

  @override
  String get forexSignals => 'Forex jelzések';

  @override
  String get goldSignals => 'Arany jelzések';

  @override
  String get updatePasswordSecure =>
      'Frissítse jelszavát fiókja biztonsága érdekében';

  @override
  String get searchLabel => 'Keresés:';

  @override
  String get filterBy => 'Szűrés:';

  @override
  String get allTime => 'Minden idő';

  @override
  String get startDate => 'Kezdő dátum:';

  @override
  String get endDate => 'Befejező dátum:';

  @override
  String get deactivate => 'Deaktiválás';

  @override
  String get unlimited => 'Korlátlan';

  @override
  String get tenLeft => '10 maradt';

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
  String get performance => 'Teljesítmény';

  @override
  String get minvestSupport => 'Signal GPT Support';

  @override
  String get leaveMessagePart1 =>
      'Kérjük, hagyjon üzenetet, csapatunk a lehető leghamarabb válaszol. Kapcsolatba léphet ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 a gyors támogatásért.';

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
  String get signInRequired => 'Bejelentkezés szükséges';

  @override
  String get signInToExploreSignal =>
      'Jelentkezzen be, hogy felfedezze ezt a kereskedési jelet!';

  @override
  String get activeMember => 'Aktív tag';

  @override
  String get last7Days => 'Elmúlt 7 nap';

  @override
  String get last14Days => 'Elmúlt 14 nap';

  @override
  String get last30Days => 'Elmúlt 30 nap';

  @override
  String get last90Days => 'Elmúlt 90 nap';

  @override
  String get profitStatistics => 'Nyereségstatisztika';

  @override
  String get winrateOfAllSignals => 'Az összes jel nyerési aránya';

  @override
  String get daily => 'Napi';

  @override
  String get weekly => 'Heti';

  @override
  String get lossRate => 'Veszteségarány';

  @override
  String get signalProgress => 'Signal Progress';

  @override
  String get statusHistory => 'Status History';

  @override
  String get signalCreated => 'Signal Created';

  @override
  String get signalMatched => 'Jel egyezés';

  @override
  String get targetReached => 'Cél elérve';

  @override
  String get freeSignalsInfo => 'Ingyenes jelek info';

  @override
  String get freeSignalsInfoDesc =>
      'Napi 1 ingyenes jelet kapsz.\nA fel nem használt jelek átvitelre kerülnek a következő napra.';

  @override
  String freeSignalsCount(int count) {
    return '$count Ingyenes jel';
  }

  @override
  String get close => 'Bezárás';

  @override
  String validUntil(String date) {
    return 'Érvényes eddig: $date';
  }

  @override
  String get wins => 'Nyerő';

  @override
  String get losses => 'Vesztes';

  @override
  String totalOrdersCount(int count) {
    return 'Összesen: $count rendelés';
  }

  @override
  String get passwordResetEmailSent =>
      'Jelszó-visszaállító e-mail elküldve! Kérjük, ellenőrizze a bejövő leveleit.';

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
