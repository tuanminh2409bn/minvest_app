// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'ÚČET ÚSPĚŠNĚ UPGRADOVÁN';

  @override
  String get lotPerWeek => 'Lot/týden';

  @override
  String get tableValueFull => 'plný';

  @override
  String get tableValueFulltime => 'plný úvazek';

  @override
  String get packageTitle => 'BALÍČEK';

  @override
  String get duration1Month => '1 měsíc';

  @override
  String get duration12Months => '12 měsíců';

  @override
  String get featureReceiveAllSignals => 'Přijímat všechny signály dne';

  @override
  String get featureAnalyzeReason => 'Analyzovat důvod pro vstup do objednávky';

  @override
  String get featureHighPrecisionAI => 'Vysoce přesný AI signál';

  @override
  String get iapStoreNotAvailable =>
      'Obchod není na tomto zařízení k dispozici.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'Chyba při načítání produktů: $message';
  }

  @override
  String get iapNoProductsFound =>
      'Nebyly nalezeny žádné produkty. Zkontrolujte prosím konfiguraci obchodu.';

  @override
  String iapTransactionError(Object message) {
    return 'Chyba transakce: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'Chyba ověření: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'Došlo k neznámé chybě: $error';
  }

  @override
  String get iapProcessingTransaction => 'Zpracovávám transakci...';

  @override
  String get orderInfo1Month => 'Platba za balíček Elite na 1 měsíc';

  @override
  String get orderInfo12Months => 'Platba za balíček Elite na 12 měsíců';

  @override
  String get iapNotSupportedOnWeb =>
      'Nákupy v aplikaci nejsou podporovány ve webové verzi.';

  @override
  String get vnpayPaymentTitle => 'PLATBA VNPAY';

  @override
  String get creatingOrderWait => 'Vytvářím objednávku, prosím čekejte...';

  @override
  String errorWithMessage(Object message) {
    return 'Chyba: $message';
  }

  @override
  String get cannotConnectToServer =>
      'Nelze se připojit k serveru. Zkuste to prosím znovu.';

  @override
  String get transactionCancelledOrFailed =>
      'Transakce byla zrušena nebo selhala.';

  @override
  String get cannotCreatePaymentLink =>
      'Nelze vytvořit platební odkaz.\nZkuste to znovu.';

  @override
  String get retry => 'Zkusit znovu';

  @override
  String serverErrorRetry(Object message) {
    return 'Chyba serveru: $message. Zkuste to prosím znovu.';
  }

  @override
  String get redirectingToPayment => 'Přesměrovávám na platební stránku...';

  @override
  String get invalidPaymentUrl =>
      'Ze serveru byla přijata neplatná platební URL.';

  @override
  String get processingYourAccount => 'Zpracovávám váš účet...';

  @override
  String get verificationFailed => 'Ověření selhalo!';

  @override
  String get reuploadImage => 'Znovu nahrát obrázek';

  @override
  String get accountNotLinked => 'Účet není propojen s Signal GPT';

  @override
  String get accountNotLinkedDesc =>
      'Pro získání exkluzivních signálů musí být váš účet Exness registrován přes partnerský odkaz Signal GPT. Vytvořte si prosím nový účet pomocí níže uvedeného odkazu.';

  @override
  String get registerExnessViaSignalGPT => 'Registrovat Exness přes Signal GPT';

  @override
  String get iHaveRegisteredReupload =>
      'Již jsem se zaregistroval, znovu nahrát';

  @override
  String couldNotLaunch(Object url) {
    return 'Nelze spustit $url';
  }

  @override
  String get status => 'Stav';

  @override
  String get sentOn => 'Odesláno';

  @override
  String get entryPrice => 'Vstupní cena';

  @override
  String get stopLossFull => 'Stop loss';

  @override
  String get takeProfitFull1 => 'Take profit 1';

  @override
  String get takeProfitFull2 => 'Take profit 2';

  @override
  String get takeProfitFull3 => 'Take profit 3';

  @override
  String get noReasonProvided => 'Pro tento signál nebyl uveden žádný důvod.';

  @override
  String get upgradeToViewReason =>
      'Upgradujte svůj účet na Elite pro zobrazení analýzy.';

  @override
  String get upgradeToViewFullAnalysis =>
      'Upgradujte pro zobrazení plné analýzy';

  @override
  String get welcomeTo => 'Vítejte v';

  @override
  String get appSlogan =>
      'Vylepšete své obchodování pomocí inteligentních signálů.';

  @override
  String get signIn => 'Přihlásit se';

  @override
  String get continueByGoogle => 'Pokračovat přes Google';

  @override
  String get continueByFacebook => 'Pokračovat přes Facebook';

  @override
  String get continueByApple => 'Pokračovat přes Apple';

  @override
  String get loginSuccess => 'Přihlášení úspěšné!';

  @override
  String get live => 'ŽIVĚ';

  @override
  String get end => 'KONEC';

  @override
  String get symbol => 'SYMBOL';

  @override
  String get aiSignal => 'AI signály';

  @override
  String get ruleSignal => 'PRAVIDLOVÝ SIGNÁL';

  @override
  String get all => 'VŠE';

  @override
  String get upgradeToSeeMore => 'Upgradujte pro zobrazení více';

  @override
  String get seeDetails => 'zobrazit podrobnosti';

  @override
  String get notMatched => 'NEODPOVÍDÁ';

  @override
  String get matched => 'ODPOVÍDÁ';

  @override
  String get entry => 'Vstup';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'Upgradovat';

  @override
  String get upgradeAccount => 'UPGRADOVAT ÚČET';

  @override
  String get compareTiers => 'POROVNAT ÚROVNĚ';

  @override
  String get feature => 'Funkce';

  @override
  String get tierDemo => 'Demo';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'Zůstatek';

  @override
  String get signalTime => 'Čas signálu';

  @override
  String get signalQty => 'Množství signálů';

  @override
  String get analysis => 'Analýza';

  @override
  String get openExnessAccount => 'Otevřít účet Exness!';

  @override
  String get accountVerificationWithExness => 'Ověření účtu u Exness';

  @override
  String get payInAppToUpgrade => 'Zaplatit v aplikaci pro upgrade';

  @override
  String get bankTransferToUpgrade => 'Bankovní převod pro upgrade';

  @override
  String get accountVerification => 'OVĚŘENÍ ÚČTU';

  @override
  String get accountVerificationPrompt =>
      'Nahrajte prosím snímek obrazovky vašeho účtu Exness pro autorizaci (váš účet musí být otevřen pod odkazem Exness společnosti Signal GPT)';

  @override
  String get selectPhotoFromLibrary => 'Vybrat fotku z knihovny';

  @override
  String get send => 'Odeslat';

  @override
  String get accountInfo => 'Informace o účtu';

  @override
  String get accountVerifiedSuccessfully => 'ÚČET ÚSPĚŠNĚ OVĚŘEN';

  @override
  String get yourAccountIs => 'Váš účet je';

  @override
  String get returnToHomePage => 'Návrat na domovskou stránku';

  @override
  String get upgradeFailed => 'Upgrade selhal! Prosím nahrajte obrázek znovu';

  @override
  String get package => 'BALÍČEK';

  @override
  String get startNow => 'Získat signály nyní';

  @override
  String get bankTransfer => 'BANKOVNÍ PŘEVOD';

  @override
  String get transferInformation => 'INFORMACE O PŘEVODU';

  @override
  String get scanForFastTransfer => 'Naskenujte pro rychlý převod';

  @override
  String get contactUs247 => 'Kontaktujte nás 24/7';

  @override
  String get newAnnouncement => 'NOVÉ OZNÁMENÍ';

  @override
  String get profile => 'Profil';

  @override
  String get upgradeNow => 'Upgradovat nyní';

  @override
  String get followSignalGPT => 'Sledujte Signal GPT';

  @override
  String get tabSignal => 'Signál';

  @override
  String get tabChart => 'Graf';

  @override
  String get tabProfile => 'Profil';

  @override
  String get reason => 'DŮVOD';

  @override
  String get error => 'Chyba';

  @override
  String get noSignalsAvailable => 'Žádné signály k dispozici.';

  @override
  String get outOfGoldenHours => 'Mimo Zlaté hodiny';

  @override
  String get outOfGoldenHoursVipDesc =>
      'VIP signály jsou k dispozici od 8:00 do 17:00 (GMT+7).\nUpgradujte na Elite pro získání signálů 24/24!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'Demo signály jsou k dispozici od 8:00 do 17:00 (GMT+7).\nUpgradujte svůj účet pro více výhod!';

  @override
  String get yourName => 'Vaše jméno';

  @override
  String get yourEmail => 'vas.email@priklad.cz';

  @override
  String get adminPanel => 'Admin panel';

  @override
  String get logout => 'Odhlásit se';

  @override
  String get confirmLogout => 'Potvrdit odhlášení';

  @override
  String get confirmLogoutMessage => 'Opravdu se chcete odhlásit?';

  @override
  String get cancel => 'Zrušit';

  @override
  String get upgradeCardTitle => 'UPGRADUJTE SVŮJ ÚČET';

  @override
  String get upgradeCardSubtitle => 'Pro přístup k více zdrojům';

  @override
  String get upgradeCardSubtitleWeb =>
      'Pro odemknutí prémiových signálů a plné podpory';

  @override
  String get subscriptionDetails => 'Podrobnosti o předplatném';

  @override
  String get notifications => 'Oznámení';

  @override
  String get continueAsGuest => 'Pokračovat jako host';

  @override
  String get deleteAccount => 'Smazat účet';

  @override
  String get deleteAccountWarning =>
      'Opravdu chcete smazat svůj účet? Všechna vaše data budou trvale vymazána a nelze je obnovit.';

  @override
  String get delete => 'Smazat';

  @override
  String get privacyPolicy => 'Zásady ochrany osobních údajů';

  @override
  String get termsOfService => 'Podmínky služby';

  @override
  String get signalStatusMatched => 'ODPOVÍDÁ';

  @override
  String get signalStatusNotMatched => 'NEODPOVÍDÁ';

  @override
  String get signalStatusCancelled => 'ZRUŠENO';

  @override
  String get signalStatusSlHit => 'SL ZASAŽEN';

  @override
  String get signalStatusTp1Hit => 'TP1 ZASAŽEN';

  @override
  String get signalStatusTp2Hit => 'TP2 ZASAŽEN';

  @override
  String get signalStatusTp3Hit => 'TP3 ZASAŽEN';

  @override
  String get signalStatusRunning => 'BĚŽÍCÍ';

  @override
  String get signalStatusClosed => 'ZAVŘENO';

  @override
  String get contactUs => 'Kontaktujte nás';

  @override
  String get tabChat => 'Chat';

  @override
  String get exnessUpgradeNoteForIos =>
      'Pro zákazníky, kteří si zaregistrovali účet Exness přes Signal GPT, klikněte prosím na kontaktujte nás, aby byl váš účet upgradován.';

  @override
  String get chatWelcomeTitle => '👋 Vítejte v Signal GPT!';

  @override
  String get chatWelcomeBody1 =>
      'Zanechte prosím zprávu, náš tým odpoví co nejdříve.';

  @override
  String get chatWelcomeBody2 =>
      'Nebo nás kontaktujte přímo přes Zalo/WhatsApp: ';

  @override
  String get chatWelcomeBody3 => ' pro rychlejší podporu!';

  @override
  String get chatLoginPrompt => 'Pro použití této funkce se prosím přihlaste';

  @override
  String get chatStartConversation => 'Začněte konverzaci';

  @override
  String get chatNoMessages => 'Zatím žádné zprávy.';

  @override
  String get chatTypeMessage => 'Napište zprávu...';

  @override
  String get chatSupportIsTyping => 'Podpora píše...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName píše...';
  }

  @override
  String get chatSeen => 'Zobrazeno';

  @override
  String get chatDefaultUserName => 'Uživatel';

  @override
  String get chatDefaultSupportName => 'Podpora';

  @override
  String get signalEntry => 'Vstup';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      'Pro zahraniční obchodníky nás prosím kontaktujte přes WhatsApp (+84969.15.6969) pro podporu';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails =>
      'Upgradujte pro zobrazení podrobností o signálu...';

  @override
  String get buy => 'NÁKUP';

  @override
  String get sell => 'PRODEJ';

  @override
  String get logoutDialogTitle => 'Relace vypršela';

  @override
  String get logoutDialogDefaultReason =>
      'Váš účet byl přihlášen na jiném zařízení.';

  @override
  String get ok => 'OK';

  @override
  String get contactToUpgrade => 'Kontaktujte pro upgrade';

  @override
  String get noNotificationsYet => 'Zatím žádná oznámení.';

  @override
  String daysAgo(int count) {
    return 'před $count dny';
  }

  @override
  String hoursAgo(int count) {
    return 'před $count hodinami';
  }

  @override
  String minutesAgo(int count) {
    return 'před $count minutami';
  }

  @override
  String get justNow => 'Právě teď';

  @override
  String get getSignalsNow => 'Získat signály nyní';

  @override
  String get freeTrial => 'Zkušební verze zdarma';

  @override
  String get heroTitle => 'Vedení obchodníků a růst portfolií';

  @override
  String get heroSubtitle =>
      'Ultimátní AI motor – Navržen expertními obchodníky';

  @override
  String get globalAiInnovationTitle =>
      'Globální inovace AI pro novou generaci obchodní inteligence';

  @override
  String get globalAiInnovationDesc =>
      'Transformace tradičního obchodování pomocí cloudových AI signálů — adaptabilních na tržní zprávy a trendy v reálném čase\npro rychlejší, přesnější a bezemoční výkon.';

  @override
  String get liveTradingSignalsTitle => 'ŽIVĚ – 24/7 AI obchodní signály';

  @override
  String get liveTradingSignalsDesc =>
      'Cloudová analytika v reálném čase poskytující vysoce pravděpodobné strategie sledující trendy s adaptivní přesností a bezemočním provedením.';

  @override
  String get trendFollowing => 'Sledování trendů';

  @override
  String get realtime => 'Reálný čas';

  @override
  String get orderExplanationEngineTitle => 'Motor vysvětlení objednávek';

  @override
  String get orderExplanationEngineDesc =>
      'Vysvětluje obchodní nastavení jednoduchými slovy — ukazuje, jak se tvoří konfluence, proč jsou prováděny vstupy a pomáhá obchodníkům učit se z každého rozhodnutí.';

  @override
  String get transparent => 'Transparentní';

  @override
  String get educational => 'Vzdělávací';

  @override
  String get logical => 'Logické';

  @override
  String get transparentRealPerformanceTitle =>
      'Transparentní - Skutečný výkon';

  @override
  String get transparentRealPerformanceDesc =>
      'Podívejte se na skutečná data o přesnosti signálů, úspěšnosti a ziskovosti — ověřená a dohledatelná v každém obchodu';

  @override
  String get results => 'Výsledky';

  @override
  String get performanceTracking => 'Sledování výkonu';

  @override
  String get accurate => 'Přesné';

  @override
  String get predictiveAccuracy => 'Prediktivní přesnost';

  @override
  String get improvementInProfitability => 'Zlepšení ziskovosti';

  @override
  String get improvedRiskManagement => 'Vylepšené řízení rizik';

  @override
  String get signalsPerformanceTitle => 'Výkon signálů';

  @override
  String get riskToRewardRatio => 'Poměr rizika k odměně';

  @override
  String get howRiskComparesToReward => 'Jak se riziko srovnává s odměnou';

  @override
  String get profitLossOverview => 'Přehled zisku/ztráty';

  @override
  String get netGainVsLoss => 'Čistý zisk vs ztráta';

  @override
  String get winRate => 'Míra výher';

  @override
  String get percentageOfWinningTrades => 'Procento vítězných obchodů';

  @override
  String get accuracyRate => 'Míra přesnosti';

  @override
  String get howPreciseOurSignalsAre => 'Jak přesné jsou naše signály';

  @override
  String get realtimeMarketAnalysis => 'Analýza trhu v reálném čase';

  @override
  String get realtimeMarketAnalysisDesc =>
      'Naše AI nepřetržitě monitoruje trh, identifikuje zóny technické konvergence a spolehlivé body průlomu, abyste mohli vstoupit do obchodů ve správný okamžik.';

  @override
  String get saveTimeOnAnalysis => 'Ušetřete čas na analýze';

  @override
  String get saveTimeOnAnalysisDesc =>
      'Už žádné hodiny strávené čtením grafů. Získejte investiční strategie na míru za pouhých pár minut denně.';

  @override
  String get minimizeEmotionalTrading =>
      'Minimalizujte emocionální obchodování';

  @override
  String get minimizeEmotionalTradingDesc =>
      'S chytrými upozorněními, detekcí rizik a signály založenými na datech, nikoli emocích, zůstanete disciplinovaní a budete mít kontrolu nad každým rozhodnutím.';

  @override
  String get seizeEveryOpportunity => 'Využijte každou příležitost';

  @override
  String get seizeEveryOpportunityDesc =>
      'Včasné aktualizace strategií doručené přímo do vaší schránky zajistí, že využijete tržní trendy v perfektní čas.';

  @override
  String get minvestAiCoreValueTitle => 'Signal GPT - Základní hodnota';

  @override
  String get minvestAiCoreValueDesc =>
      'AI nepřetržitě analyzuje tržní data v reálném čase, filtruje poznatky pro identifikaci rychlých a přesných investičních příležitostí';

  @override
  String get frequentlyAskedQuestions => 'Často kladené otázky (FAQ)';

  @override
  String get faqSubtitle =>
      'Všechny vaše otázky — od toho, jak se připojit, přes výhody, až po to, jak naše AI funguje — jsou zodpovězeny níže. Pokud máte stále pochybnosti, neváhejte nám napsat na Whatsapp';

  @override
  String get maximizeResultsTitle =>
      'Maximalizujte své výsledky s pokročilou tržní analýzou Signal GPT a přesně filtrovanými signály';

  @override
  String get elevateTradingWithAiStrategies =>
      'Povyšte své obchodování s strategiemi vylepšenými AI, vytvořenými pro konzistenci a jasnost';

  @override
  String get winMoreWithAiSignalsTitle =>
      'Vyhrávejte více se signály poháněnými AI\nna každém trhu';

  @override
  String get winMoreWithAiSignalsDesc =>
      'Naše multimarketová AI skenuje Forex, krypto a kovy v reálném čase,\nposkytuje expertně ověřené obchodní signály —\ns jasnými úrovněmi vstupu, stop-loss a take-profit';

  @override
  String get buyLimit => 'Buy limit';

  @override
  String get sellLimit => 'Sell limit';

  @override
  String get smarterToolsTitle => 'Chytřejší nástroje - Lepší investice';

  @override
  String get smarterToolsDesc =>
      'Objevte funkce, které vám pomohou minimalizovat rizika, využít příležitosti a rozmnožit vaše bohatství';

  @override
  String get performanceOverviewTitle => 'Přehled výkonu';

  @override
  String get performanceOverviewDesc =>
      'Naše multimarketová AI skenuje Forex, krypto a kovy v reálném čase, poskytuje expertně ověřené obchodní signály - s jasnými úrovněmi vstupu, stop-loss a take-profit';

  @override
  String get totalProfit => 'Celkový zisk';

  @override
  String get completionSignal => 'Signál dokončení';

  @override
  String get onDemandFinancialExpertTitle => 'Váš finanční expert na vyžádání';

  @override
  String get onDemandFinancialExpertDesc =>
      'AI platforma navrhuje obchodní signály - samoučící se, analyzuje trh 24/7, neovlivněná emocemi. Signal GPT podpořil více než 10 000 finančních analytiků na jejich cestě k nalezení přesných, stabilních a snadno aplikovatelných signálů';

  @override
  String get aiPoweredSignalPlatform =>
      'Platforma obchodních signálů poháněná AI';

  @override
  String get selfLearningSystems =>
      'Samoučící se systémy, ostřejší poznatky, silnější obchody';

  @override
  String get emotionlessExecution =>
      'Bezemoční provedení pro chytřejší a disciplinovanější obchodování';

  @override
  String get analysingMarket247 => 'Analýza trhu 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Maximalizujte své výsledky s pokročilou tržní analýzou Signal GPT a přesně filtrovanými signály';

  @override
  String get minvestAiRegistrationDesc =>
      'Registrace do Signal GPT je nyní otevřena — místa se mohou brzy uzavřít, jakmile zkontrolujeme a schválíme nové členy';

  @override
  String get currencyPairs => 'Komodita';

  @override
  String get allCurrencyPairs => 'Všechny měnové páry';

  @override
  String get allCommodities => 'Všechny komodity';

  @override
  String get allCryptoPairs => 'Všechny krypto páry';

  @override
  String get dateRange => 'Rozsah dat';

  @override
  String get selectDateRange => 'Vybrat rozsah dat';

  @override
  String get allAssets => 'Všechna aktiva';

  @override
  String get asset => 'Aktivum';

  @override
  String get tokenExpired => 'Token vypršel';

  @override
  String get tokenLimitReachedDesc =>
      'Dnes jste vyčerpali svých 10 bezplatných tokenů. Upgradujte svůj balíček pro zobrazení více signálů.';

  @override
  String get later => 'Později';

  @override
  String get created => 'Vytvořeno';

  @override
  String get detail => 'Detail';

  @override
  String get performanceOverview => 'Přehled výkonu';

  @override
  String get totalProfitPips => 'Celkový zisk (Pips)';

  @override
  String get winRatePercent => 'Míra výher (%)';

  @override
  String get comingSoon => 'Již brzy';

  @override
  String get errorLoadingHistory => 'Chyba při načítání historie';

  @override
  String get noHistoryAvailable => 'Historie signálů není k dispozici';

  @override
  String get previous => 'Předchozí';

  @override
  String get page => 'Stránka';

  @override
  String get next => 'Další';

  @override
  String get date => 'Datum';

  @override
  String get timeGmt7 => 'Čas';

  @override
  String get orders => 'Objednávky';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      'Malá obrazovka: otočte na šířku nebo posuňte vodorovně pro zobrazení celé tabulky.';

  @override
  String get history => 'Historie';

  @override
  String get signalsWillAppearHere =>
      'Signály se zde objeví, až budou k dispozici';

  @override
  String get pricing => 'Ceník';

  @override
  String get choosePlanSubtitle => 'Vyberte si plán, který vám vyhovuje';

  @override
  String get financialNewsHub => 'Centrum finančních zpráv';

  @override
  String get financialNewsHubDesc =>
      'Kritické aktualizace. Reakce trhu. Žádný šum – jen to, co investoři potřebují vědět.';

  @override
  String get newsTabAllArticles => 'Všechny články';

  @override
  String get newsTabInvestor => 'Investor';

  @override
  String get newsTabKnowledge => 'Znalosti';

  @override
  String get newsTabTechnicalAnalysis => 'Technická analýza';

  @override
  String noArticlesForCategory(Object category) {
    return 'Žádné články pro kategorii $category';
  }

  @override
  String get mostPopular => 'Nejoblíbenější';

  @override
  String get noPosts => 'Žádné příspěvky';

  @override
  String get relatedArticles => 'Související články';

  @override
  String get contactInfoSentSuccess => 'Kontaktní informace úspěšně odeslány.';

  @override
  String contactInfoSentFailed(Object error) {
    return 'Odeslání informací selhalo: $error';
  }

  @override
  String get contactPageSubtitle =>
      'Máte otázky nebo potřebujete AI řešení? Dejte nám vědět vyplněním formuláře a my se ozveme!';

  @override
  String get phone => 'Telefon';

  @override
  String get firstName => 'Jméno';

  @override
  String get enterFirstName => 'Zadejte jméno';

  @override
  String get lastName => 'Příjmení';

  @override
  String get enterLastName => 'Zadejte příjmení';

  @override
  String get whatAreYourConcerns => 'Jaké jsou vaše obavy?';

  @override
  String get writeConcernsHere => 'Zde napište své obavy...';

  @override
  String pleaseEnter(Object field) {
    return 'Prosím zadejte $field';
  }

  @override
  String get faqQuestion1 => 'Zaručují signály 100% úspěšnost?';

  @override
  String get faqAnswer1 =>
      'Ačkoli žádný signál nelze zaručit na 100 %, Signal GPT se snaží udržovat stabilní úspěšnost 60–80 %, podpořenou podrobnou analýzou a řízením rizik, abyste mohli učinit konečné rozhodnutí s větší jistotou.';

  @override
  String get faqQuestion2 =>
      'Pokud nechci ihned vložit peníze, mohu stále dostávat návrhy signálů?';

  @override
  String get faqAnswer2 =>
      'Při otevření účtu vám systém daruje 10 bezplatných tokenů, což odpovídá 10 podrobným zobrazením signálů. Poté obdržíte každý den 1 další token k použití. Pokud upgradujete na VIP účet, odemknete mnoho pokročilých funkcí a budete moci sledovat neomezený počet objednávek.';

  @override
  String get faqQuestion3 =>
      'Pokud jsem se zaregistroval, ale neobdržel žádné signály, jaké kroky bych měl podniknout?';

  @override
  String get faqAnswer3 =>
      'Zpracování je obvykle automatické. Pokud stále nevidíte žádné návrhy signálů, kontaktujte nás prosím přes Whatsapp pro okamžitou pomoc.';

  @override
  String get faqQuestion4 =>
      'Kolik signálů obdržím denně při upgradu na VIP účet?';

  @override
  String get faqAnswer4 =>
      'Při upgradu na VIP účet obdržíte každý den neomezené obchodní signály. Počet signálů není pevný, ale závisí zcela na analýze trhu. Kdykoli se objeví vysoce kvalitní vstupní bod s vysokou pravděpodobností, analytický tým vám signál okamžitě zašle.';

  @override
  String get priceLevels => 'Cenové úrovně';

  @override
  String get capitalManagement => 'Řízení kapitálu';

  @override
  String freeSignalsLeft(Object count) {
    return 'Zbývá $count bezplatných signálů';
  }

  @override
  String get unlimitedSignals => 'Neomezené signály';

  @override
  String get goBack => 'Jít zpět';

  @override
  String get goldPlan => 'Zlatý plán';

  @override
  String get perMonth => '/ měsíc';

  @override
  String get continuouslyUpdating => 'Neustálá aktualizace tržních dat 24/7';

  @override
  String get providingBestSignals =>
      'Poskytování nejlepších signálů v reálném čase';

  @override
  String get includesEntrySlTp => 'Zahrnuje Vstup, SL, TP';

  @override
  String get detailedAnalysis => 'Podrobná analýza a hodnocení každého signálu';

  @override
  String get realTimeNotifications => 'Oznámení v reálném čase e-mailem';

  @override
  String get signalPerformanceStats => 'Statistiky výkonu signálů';

  @override
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails => 'IČO: 0110057263';

  @override
  String get addressDetails =>
      'Adresa: č. 8 Do Hanh Street, Hai Ba Trung Ward, město Hanoj, Vietnam';

  @override
  String get pagesTitle => 'Stránky';

  @override
  String get legalRegulatoryTitle => 'Právní a regulační';

  @override
  String get termsOfRegistration => 'Podmínky registrace';

  @override
  String get operatingPrinciples => 'Provozní zásady';

  @override
  String get termsConditions => 'Všeobecné obchodní podmínky';

  @override
  String get contactTitle => 'Kontakt';

  @override
  String get navFeatures => 'Funkce';

  @override
  String get navNews => 'Zprávy';

  @override
  String get tp1Hit => 'TP1 Zasažen';

  @override
  String get tp2Hit => 'TP2 Zasažen';

  @override
  String get tp3Hit => 'TP3 Zasažen';

  @override
  String get slHit => 'SL Zasažen';

  @override
  String get cancelled => 'Zrušeno';

  @override
  String get exitedByAdmin => 'Ukončeno administrátorem';

  @override
  String get signalClosed => 'Zavřeno';

  @override
  String get errorLoadingPackages => 'Chyba při načítání balíčků';

  @override
  String get monthly => 'Měsíčně';

  @override
  String get annually => 'Ročně';

  @override
  String get whatsIncluded => 'Co je zahrnuto:';

  @override
  String get chooseThisPlan => 'Vybrat tento plán';

  @override
  String get bestPricesForPremiumAccess => 'Nejlepší ceny pro prémiový přístup';

  @override
  String get choosePlanFitsNeeds =>
      'Vyberte si plán, který vyhovuje vašim obchodním potřebám, a začněte automatizovat s AI';

  @override
  String get save50Percent => 'UŠETŘETE 50 %';

  @override
  String get tryDemo => 'Zkusit demo';

  @override
  String get pleaseEnterEmailPassword => 'Zadejte prosím e-mail a heslo';

  @override
  String loginFailed(String error) {
    return 'Přihlášení selhalo: $error';
  }

  @override
  String get welcomeBack => 'Vítejte zpět';

  @override
  String get signInToContinue => 'Přihlaste se ke svému účtu pro pokračování';

  @override
  String get or => 'nebo';

  @override
  String get email => 'E-mail';

  @override
  String get emailHint => 'priklad123@gmail.com';

  @override
  String get password => 'Heslo';

  @override
  String get enterPassword => 'Zadejte heslo';

  @override
  String get forgotPassword => 'Zapomněli jste heslo?';

  @override
  String get createNewAccount => 'Vytvořte si nový účet zde!';

  @override
  String get signUp => 'Zaregistrovat se';

  @override
  String get signUpAccount => 'Zaregistrovat účet';

  @override
  String get enterPersonalData => 'Zadejte své osobní údaje pro vytvoření účtu';

  @override
  String get nameLabel => 'Jméno *';

  @override
  String get enterNameHint => 'Zadejte jméno';

  @override
  String get emailLabel => 'E-mail *';

  @override
  String get passwordLabel => 'Heslo *';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get continueButton => 'Pokračovat';

  @override
  String get fillAllFields => 'Vyplňte prosím všechna povinná pole.';

  @override
  String get accountCreatedSuccess => 'Účet úspěšně vytvořen.';

  @override
  String signUpFailed(String error) {
    return 'Registrace selhala: $error';
  }

  @override
  String get nationality => 'Národnost:';

  @override
  String get overview => 'Přehled';

  @override
  String get setting => 'Nastavení';

  @override
  String get paymentHistory => 'Historie plateb';

  @override
  String get signalsPlan => 'Plán signálů';

  @override
  String get aiSignalGPT => 'AI Signal GPT';

  @override
  String get yourTokens => 'Vaše tokeny';

  @override
  String get emailNotificationPreferences => 'Předvolby e-mailových oznámení';

  @override
  String get chooseSignalNotificationTypes =>
      'Vyberte, jaké typy oznámení o signálech chcete dostávat e-mailem';

  @override
  String get allSignalNotifications => 'Všechna oznámení o signálech';

  @override
  String get cryptoSignals => 'Krypto signály';

  @override
  String get forexSignals => 'Forex signály';

  @override
  String get goldSignals => 'Zlaté signály';

  @override
  String get updatePasswordSecure =>
      'Aktualizujte své heslo pro zabezpečení účtu';

  @override
  String get searchLabel => 'Hledat:';

  @override
  String get filterBy => 'Filtrovat podle:';

  @override
  String get allTime => 'Celou dobu';

  @override
  String get startDate => 'Datum zahájení:';

  @override
  String get endDate => 'Datum ukončení:';

  @override
  String get deactivate => 'Deaktivovat';

  @override
  String get unlimited => 'Neomezeno';

  @override
  String get tenLeft => 'zbývá 10';

  @override
  String get termsOfRegistrationContent =>
      'Please read all the terms and agreements below carefully before proceeding with the next steps in our system.\nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\n1. Introduction and Scope of Application\n\nThis policy regulates the collection, use, sharing, and protection of users’ personal information when accessing and using the products and services of the Signal GPT system – a technology and artificial intelligence platform owned and operated by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED (hereinafter referred to as “we” or “us”).\nBy registering an account or using Signal GPT’s products, you agree that such action constitutes a legally binding commitment between you and us, equivalent to an electronic contract.\n\n2. Account Registration\n\nTo access and use certain services on Signal GPT, you must register a valid account.\nWhen registering, you are required to provide complete and accurate personal information, including your full name, email address, phone number, or any other information as requested.\nAfter registration, you must confirm your email to activate the account. All notifications about your account, promotions, or system updates will be sent to this email address.\nIf the information you provide is inaccurate or incomplete, you will be solely responsible for any incidents or damages arising from it.\n\n3. Terms of Use\n\nWhen participating in the Signal GPT system, you are obligated to comply with all of the following:\nThe operating principles of the platform;\nPayment terms;\nPersonal data privacy policy;\nRelevant laws and regulations in effect.\nIn the event of a violation, EZTRADE reserves the right to temporarily suspend or permanently delete your account, and may transfer the case to competent authorities if necessary.\n\n4. Personal Data Privacy Policy\n\n4.1. Purpose and Scope of ... [truncated]';

  @override
  String get operatingPrinciplesContent =>
      'Please read all terms and agreements below carefully before proceeding with the next steps in our system. \nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\nOPERATING RULES\n\n1. Legal Information\n\nSystem Owner:\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness/Tax Code: 0110057263\nPhone: 0862 600 626\n\n2. Scope of Application\n\nThese Operating Principles apply to all users, learners, partners, and collaborators who participate in or use the products and services within the Signal GPT system, including websites, applications, training platforms, and other online channels managed by EZTRADE.\nBy registering an account or using the services of Signal GPT, users are deemed to have read, understood, and agreed to all the terms set forth in these regulations.\n\n3. Definitions\n\n“Signal GPT” refers to the technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED.\n“Customer” / “User” / “Learner” refers to any individual or organization that registers, accesses, or uses the services and products on the Signal GPT system.\n“We” / “Administration” refers to the management team representing EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED, responsible for operating and managing the system.\n“Products” / “Services” include learning packages, analytical newsletters, AI trading signals, analytical tools, or any digital content provided by Signal GPT.\n\n4. Usage Rules and Information Security\n\nUsers must provide accurate and complete information when registering an account.\nSignal GPT is committed to protecting personal information and will not disclose it to third parties unless required by competent authorities.\nUsers are responsible for maintaining the confidentiality of their account and pa... [truncated]';

  @override
  String get termsAndConditionsContent =>
      'By registering an account to participate in the Signal GPT system, you confirm that you have read, understood, and agreed to all the contents of these Account Opening Terms and Conditions.\nBy opening an account on this system, you agree to participate in and use the services and products provided by EZTRADE.\nAccount registration and activation are considered an electronic contract between you and Signal GPT, which has the same legal validity as a civil contract under the laws of Vietnam.\n\n2. Personal Account Information and Privacy\n\n2.1. Purpose and Scope of Information Collection\n\nTo access and use certain Signal GPT services, you must provide basic personal information, including:\nFull name;\nEmail address;\nContact phone number;\nOther information (if any) necessary for verification, support, or access authorization.\nAll information provided must be accurate, truthful, and lawful. Signal GPT shall not be responsible for any losses or disputes arising from false, missing, or fraudulent information provided by the user.\nAdditionally, the system may automatically collect certain technical data, such as:\nIP address, browser type, and language used;\nAccess time and pages viewed within the system.\nThis information helps Signal GPT improve performance, enhance security, and optimize user experience.\n\n2.2. Scope of Information Use\n\nYour personal information is collected and used for legitimate purposes, including:\nManaging accounts, verifying users, and maintaining services;\nSending notifications related to services, accounts, promotions, or policy changes;\nProv... [truncated]';

  @override
  String get performance => 'Výkon';

  @override
  String get minvestSupport => 'Signal GPT Support';

  @override
  String get leaveMessagePart1 =>
      'Zanechte prosím zprávu, náš tým odpoví co nejdříve. Můžete také kontaktovat ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 pro rychlou podporu.';

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
  String get signInRequired => 'Vyžadováno přihlášení';

  @override
  String get signInToExploreSignal =>
      'Přihlaste se a prozkoumejte tento obchodní signál!';

  @override
  String get activeMember => 'Aktivní člen';

  @override
  String get last7Days => 'Posledních 7 dní';

  @override
  String get last14Days => 'Posledních 14 dní';

  @override
  String get last30Days => 'Posledních 30 dní';

  @override
  String get last90Days => 'Posledních 90 dní';

  @override
  String get profitStatistics => 'Statistiky zisku';

  @override
  String get winrateOfAllSignals => 'Míra výhry všech signálů';

  @override
  String get daily => 'Denně';

  @override
  String get weekly => 'Týdně';

  @override
  String get lossRate => 'Míra ztráty';

  @override
  String get signalProgress => 'Signal Progress';

  @override
  String get statusHistory => 'Status History';

  @override
  String get signalCreated => 'Signal Created';

  @override
  String get signalMatched => 'Signál odpovídá';

  @override
  String get targetReached => 'Cíl dosažen';

  @override
  String get freeSignalsInfo => 'Info o bezplatných signálech';

  @override
  String get freeSignalsInfoDesc =>
      'Obdržíte 1 bezplatný signál denně.\nNevyužité signály se převádějí do dalšího dne.';

  @override
  String freeSignalsCount(int count) {
    return '$count Bezplatných signálů';
  }

  @override
  String get close => 'Zavřít';

  @override
  String validUntil(String date) {
    return 'Platí do $date';
  }

  @override
  String get wins => 'Výhry';

  @override
  String get losses => 'Prohry';

  @override
  String totalOrdersCount(int count) {
    return 'Celkem: $count objednávek';
  }

  @override
  String get passwordResetEmailSent =>
      'E-mail pro resetování hesla byl odeslán! Zkontrolujte prosím svou doručenou poštu.';

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
