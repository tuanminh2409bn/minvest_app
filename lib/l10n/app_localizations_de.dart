// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'KONTO ERFOLGREICH AKTUALISIERT';

  @override
  String get lotPerWeek => 'Lot/Woche';

  @override
  String get tableValueFull => 'voll';

  @override
  String get tableValueFulltime => 'Vollzeit';

  @override
  String get packageTitle => 'PAKET';

  @override
  String get duration1Month => '1 Monat';

  @override
  String get duration12Months => '12 Monate';

  @override
  String get featureReceiveAllSignals => 'Alle Signale des Tages erhalten';

  @override
  String get featureAnalyzeReason =>
      'Grund für den Auftragseingang analysieren';

  @override
  String get featureHighPrecisionAI => 'Hochpräzises KI-Signal';

  @override
  String get iapStoreNotAvailable =>
      'Der Store ist auf diesem Gerät nicht verfügbar.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'Fehler beim Laden der Produkte: $message';
  }

  @override
  String get iapNoProductsFound =>
      'Keine Produkte gefunden. Bitte überprüfen Sie Ihre Store-Konfiguration.';

  @override
  String iapTransactionError(Object message) {
    return 'Transaktionsfehler: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'Verifizierungsfehler: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'Ein unbekannter Fehler ist aufgetreten: $error';
  }

  @override
  String get iapProcessingTransaction => 'Transaktion wird verarbeitet...';

  @override
  String get orderInfo1Month => 'Zahlung für Elite 1-Monats-Paket';

  @override
  String get orderInfo12Months => 'Zahlung für Elite 12-Monats-Paket';

  @override
  String get iapNotSupportedOnWeb =>
      'In-App-Käufe werden in der Webversion nicht unterstützt.';

  @override
  String get vnpayPaymentTitle => 'VNPAY ZAHLUNG';

  @override
  String get creatingOrderWait => 'Bestellung wird erstellt, bitte warten...';

  @override
  String errorWithMessage(Object message) {
    return 'Fehler: $message';
  }

  @override
  String get cannotConnectToServer =>
      'Verbindung zum Server fehlgeschlagen. Bitte versuchen Sie es erneut.';

  @override
  String get transactionCancelledOrFailed =>
      'Transaktion wurde abgebrochen oder ist fehlgeschlagen.';

  @override
  String get cannotCreatePaymentLink =>
      'Zahlungslink konnte nicht erstellt werden.\nVersuchen Sie es erneut.';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String serverErrorRetry(Object message) {
    return 'Serverfehler: $message. Bitte versuchen Sie es erneut.';
  }

  @override
  String get redirectingToPayment => 'Weiterleitung zur Zahlungsseite...';

  @override
  String get invalidPaymentUrl => 'Ungültige Zahlungs-URL vom Server erhalten.';

  @override
  String get processingYourAccount => 'Ihr Konto wird verarbeitet...';

  @override
  String get verificationFailed => 'Verifizierung fehlgeschlagen!';

  @override
  String get reuploadImage => 'Bild erneut hochladen';

  @override
  String get accountNotLinked => 'Konto nicht mit Minvest verknüpft';

  @override
  String get accountNotLinkedDesc =>
      'Um exklusive Signale zu erhalten, muss Ihr Exness-Konto über den Minvest-Partnerlink registriert sein. Bitte erstellen Sie ein neues Konto über den untenstehenden Link.';

  @override
  String get registerExnessViaMinvest => 'Exness über Minvest registrieren';

  @override
  String get iHaveRegisteredReupload =>
      'Ich habe mich registriert, erneut hochladen';

  @override
  String couldNotLaunch(Object url) {
    return 'Konnte $url nicht starten';
  }

  @override
  String get status => 'Status';

  @override
  String get sentOn => 'Gesendet am';

  @override
  String get entryPrice => 'Einstiegspreis';

  @override
  String get stopLossFull => 'Stop Loss';

  @override
  String get takeProfitFull1 => 'Take Profit 1';

  @override
  String get takeProfitFull2 => 'Take Profit 2';

  @override
  String get takeProfitFull3 => 'Take Profit 3';

  @override
  String get noReasonProvided => 'Kein Grund für dieses Signal angegeben.';

  @override
  String get upgradeToViewReason =>
      'Aktualisieren Sie Ihr Konto auf Elite, um die Analyse zu sehen.';

  @override
  String get upgradeToViewFullAnalysis => 'Upgrade für vollständige Analyse';

  @override
  String get welcomeTo => 'Willkommen bei';

  @override
  String get appSlogan =>
      'Verbessern Sie Ihren Handel mit intelligenten Signalen.';

  @override
  String get signIn => 'Anmelden';

  @override
  String get continueByGoogle => 'Weiter mit Google';

  @override
  String get continueByFacebook => 'Weiter mit Facebook';

  @override
  String get continueByApple => 'Weiter mit Apple';

  @override
  String get loginSuccess => 'Anmeldung erfolgreich!';

  @override
  String get live => 'LIVE';

  @override
  String get end => 'ENDE';

  @override
  String get symbol => 'SYMBOL';

  @override
  String get aiSignal => 'KI-Signale';

  @override
  String get ruleSignal => 'REGEL-SIGNAL';

  @override
  String get all => 'ALLE';

  @override
  String get upgradeToSeeMore => 'Upgrade für mehr';

  @override
  String get seeDetails => 'Details ansehen';

  @override
  String get notMatched => 'NICHT ABGEGLICHEN';

  @override
  String get matched => 'ABGEGLICHEN';

  @override
  String get entry => 'Einstieg';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get upgradeAccount => 'KONTO UPGRADEN';

  @override
  String get compareTiers => 'STUFEN VERGLEICHEN';

  @override
  String get feature => 'Funktion';

  @override
  String get tierDemo => 'Demo';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'Guthaben';

  @override
  String get signalTime => 'Signalzeit';

  @override
  String get signalQty => 'Signalmenge';

  @override
  String get analysis => 'Analyse';

  @override
  String get openExnessAccount => 'Exness-Konto eröffnen!';

  @override
  String get accountVerificationWithExness => 'Kontoverifizierung mit Exness';

  @override
  String get payInAppToUpgrade => 'In der App bezahlen für Upgrade';

  @override
  String get bankTransferToUpgrade => 'Banküberweisung für Upgrade';

  @override
  String get accountVerification => 'KONTOVERIFIZIERUNG';

  @override
  String get accountVerificationPrompt =>
      'Bitte laden Sie einen Screenshot Ihres Exness-Kontos hoch, um autorisiert zu werden (Ihr Konto muss unter dem Exness-Link von Minvest eröffnet worden sein)';

  @override
  String get selectPhotoFromLibrary => 'Foto aus Bibliothek auswählen';

  @override
  String get send => 'Senden';

  @override
  String get accountInfo => 'Kontoinformationen';

  @override
  String get accountVerifiedSuccessfully => 'KONTO ERFOLGREICH VERIZIERT';

  @override
  String get yourAccountIs => 'Ihr Konto ist';

  @override
  String get returnToHomePage => 'Zur Startseite zurückkehren';

  @override
  String get upgradeFailed =>
      'Upgrade fehlgeschlagen! Bitte laden Sie das Bild erneut hoch';

  @override
  String get package => 'PAKET';

  @override
  String get startNow => 'Signale jetzt erhalten';

  @override
  String get bankTransfer => 'BANKÜBERWEISUNG';

  @override
  String get transferInformation => 'ÜBERWEISUNGSINFORMATIONEN';

  @override
  String get scanForFastTransfer => 'Scannen für schnelle Überweisung';

  @override
  String get contactUs247 => 'Kontaktieren Sie uns 24/7';

  @override
  String get newAnnouncement => 'NEUE ANKÜNDIGUNG';

  @override
  String get profile => 'Profil';

  @override
  String get upgradeNow => 'Jetzt upgraden';

  @override
  String get followMinvest => 'Folgen Sie MInvest';

  @override
  String get tabSignal => 'Signal';

  @override
  String get tabChart => 'Chart';

  @override
  String get tabProfile => 'Profil';

  @override
  String get reason => 'GRUND';

  @override
  String get error => 'Fehler';

  @override
  String get noSignalsAvailable => 'Keine Signale verfügbar.';

  @override
  String get outOfGoldenHours => 'Außerhalb der Goldenen Stunden';

  @override
  String get outOfGoldenHoursVipDesc =>
      'VIP-Signale sind von 8:00 bis 17:00 Uhr (GMT+7) verfügbar.\nUpgraden Sie auf Elite, um Signale rund um die Uhr zu erhalten!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'Demo-Signale sind von 8:00 bis 17:00 Uhr (GMT+7) verfügbar.\nUpgraden Sie Ihr Konto für mehr Vorteile!';

  @override
  String get yourName => 'Ihr Name';

  @override
  String get yourEmail => 'ihre.email@beispiel.de';

  @override
  String get adminPanel => 'Admin-Panel';

  @override
  String get logout => 'Abmelden';

  @override
  String get confirmLogout => 'Abmeldung bestätigen';

  @override
  String get confirmLogoutMessage => 'Möchten Sie sich wirklich abmelden?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get upgradeCardTitle => 'KONTO UPGRADEN';

  @override
  String get upgradeCardSubtitle => 'Für Zugang zu mehr Ressourcen';

  @override
  String get upgradeCardSubtitleWeb =>
      'Um Premium-Signale und Vollzeit-Support freizuschalten';

  @override
  String get subscriptionDetails => 'Abonnement-Details';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get continueAsGuest => 'Als Gast fortfahren';

  @override
  String get deleteAccount => 'Konto löschen';

  @override
  String get deleteAccountWarning =>
      'Sind Sie sicher, dass Sie Ihr Konto löschen möchten? Alle Ihre Daten werden dauerhaft gelöscht und können nicht wiederhergestellt werden.';

  @override
  String get delete => 'Löschen';

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get signalStatusMatched => 'ABGEGLICHEN';

  @override
  String get signalStatusNotMatched => 'NICHT ABGEGLICHEN';

  @override
  String get signalStatusCancelled => 'STORNIERT';

  @override
  String get signalStatusSlHit => 'SL GETROFFEN';

  @override
  String get signalStatusTp1Hit => 'TP1 GETROFFEN';

  @override
  String get signalStatusTp2Hit => 'TP2 GETROFFEN';

  @override
  String get signalStatusTp3Hit => 'TP3 GETROFFEN';

  @override
  String get signalStatusRunning => 'LÄUFT';

  @override
  String get signalStatusClosed => 'GESCHLOSSEN';

  @override
  String get contactUs => 'Kontaktieren Sie uns';

  @override
  String get tabChat => 'Chat';

  @override
  String get exnessUpgradeNoteForIos =>
      'Kunden, die ein Exness-Konto über Minvest registriert haben, klicken bitte auf Kontakt, um ihr Konto upgraden zu lassen.';

  @override
  String get chatWelcomeTitle => '👋 Willkommen bei Signal GPT!';

  @override
  String get chatWelcomeBody1 =>
      'Bitte hinterlassen Sie eine Nachricht, unser Team wird so schnell wie möglich antworten.';

  @override
  String get chatWelcomeBody2 =>
      'Oder kontaktieren Sie uns direkt über Zalo/WhatsApp: ';

  @override
  String get chatWelcomeBody3 => ' für schnelleren Support!';

  @override
  String get chatLoginPrompt =>
      'Bitte melden Sie sich an, um diese Funktion zu nutzen';

  @override
  String get chatStartConversation => 'Starten Sie Ihre Unterhaltung';

  @override
  String get chatNoMessages => 'Noch keine Nachrichten.';

  @override
  String get chatTypeMessage => 'Nachricht eingeben...';

  @override
  String get chatSupportIsTyping => 'Support schreibt...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName schreibt...';
  }

  @override
  String get chatSeen => 'Gesehen';

  @override
  String get chatDefaultUserName => 'Benutzer';

  @override
  String get chatDefaultSupportName => 'Support';

  @override
  String get signalEntry => 'Einstieg';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      'Für ausländische Händler kontaktieren Sie uns bitte über WhatsApp (+84969.15.6969) für Unterstützung';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails => 'Upgrade für Signaldetails...';

  @override
  String get buy => 'KAUFEN';

  @override
  String get sell => 'VERKAUFEN';

  @override
  String get logoutDialogTitle => 'Sitzung abgelaufen';

  @override
  String get logoutDialogDefaultReason =>
      'Ihr Konto wurde auf einem anderen Gerät angemeldet.';

  @override
  String get ok => 'OK';

  @override
  String get contactToUpgrade => 'Kontakt für Upgrade';

  @override
  String get noNotificationsYet => 'Noch keine Benachrichtigungen.';

  @override
  String daysAgo(int count) {
    return 'vor $count Tagen';
  }

  @override
  String hoursAgo(int count) {
    return 'vor $count Stunden';
  }

  @override
  String minutesAgo(int count) {
    return 'vor $count Minuten';
  }

  @override
  String get justNow => 'Gerade eben';

  @override
  String get getSignalsNow => 'Signale jetzt erhalten';

  @override
  String get freeTrial => 'Kostenlose Testversion';

  @override
  String get heroTitle => 'Händler führen & Portfolios vergrößern';

  @override
  String get heroSubtitle =>
      'Die ultimative KI-Engine – Entwickelt von Experten-Händlern';

  @override
  String get globalAiInnovationTitle =>
      'Globale KI-Innovation für die nächste Generation der Handelsintelligenz';

  @override
  String get globalAiInnovationDesc =>
      'Veränderung des traditionellen Handels mit Cloud-basierten KI-Signalen – anpassungsfähig an Echtzeit-Marktnachrichten und Trends\nfür schnellere, präzisere und emotionsfreie Leistung.';

  @override
  String get liveTradingSignalsTitle => 'LIVE – 24/7 KI-Handelssignale';

  @override
  String get liveTradingSignalsDesc =>
      'Echtzeit-Cloud-Analysen liefern Strategien mit hoher Wahrscheinlichkeit und Trendfolge mit adaptiver Präzision und emotionsfreier Ausführung.';

  @override
  String get trendFollowing => 'Trendfolgend';

  @override
  String get realtime => 'Echtzeit';

  @override
  String get orderExplanationEngineTitle => 'Order-Erklärungs-Engine';

  @override
  String get orderExplanationEngineDesc =>
      'Erklärt Handelskonfigurationen in einfachen Worten – zeigt, wie Konfluenzen entstehen, warum Einstiege erfolgen, und hilft Händlern, aus jeder Entscheidung zu lernen.';

  @override
  String get transparent => 'Transparent';

  @override
  String get educational => 'Lehrreich';

  @override
  String get logical => 'Logisch';

  @override
  String get transparentRealPerformanceTitle => 'Transparent - Echte Leistung';

  @override
  String get transparentRealPerformanceDesc =>
      'Sehen Sie echte Daten zu Signalgenauigkeit, Erfolgsquote und Rentabilität – verifiziert und nachvollziehbar in jedem Handel';

  @override
  String get results => 'Ergebnisse';

  @override
  String get performanceTracking => 'Leistungsverfolgung';

  @override
  String get accurate => 'Präzise';

  @override
  String get predictiveAccuracy => 'Vorhersagegenauigkeit';

  @override
  String get improvementInProfitability => 'Verbesserung der Rentabilität';

  @override
  String get improvedRiskManagement => 'Verbessertes Risikomanagement';

  @override
  String get signalsPerformanceTitle => 'Signalleistung';

  @override
  String get riskToRewardRatio => 'Risiko-Ertrags-Verhältnis';

  @override
  String get howRiskComparesToReward =>
      'Wie sich das Risiko zum Ertrag verhält';

  @override
  String get profitLossOverview => 'Gewinn/Verlust Übersicht';

  @override
  String get netGainVsLoss => 'Nettogewinn vs Verlust';

  @override
  String get winRate => 'Gewinnrate';

  @override
  String get percentageOfWinningTrades => 'Prozentsatz der Gewinngeschäfte';

  @override
  String get accuracyRate => 'Genauigkeitsrate';

  @override
  String get howPreciseOurSignalsAre => 'Wie präzise unsere Signale sind';

  @override
  String get realtimeMarketAnalysis => 'Echtzeit-Marktanalyse';

  @override
  String get realtimeMarketAnalysisDesc =>
      'Unsere KI überwacht den Markt kontinuierlich und identifiziert technische Konvergenzzonen und zuverlässige Ausbruchspunkte, damit Sie zum richtigen Zeitpunkt in den Handel einsteigen können.';

  @override
  String get saveTimeOnAnalysis => 'Zeit bei der Analyse sparen';

  @override
  String get saveTimeOnAnalysisDesc =>
      'Keine stundenlange Chartanalyse mehr. Erhalten Sie maßgeschneiderte Anlagestrategien in nur wenigen Minuten am Tag.';

  @override
  String get minimizeEmotionalTrading => 'Emotionalen Handel minimieren';

  @override
  String get minimizeEmotionalTradingDesc =>
      'Mit intelligenten Warnungen, Risikoerkennung und datengesteuerten Signalen statt Emotionen bleiben Sie diszipliniert und behalten die Kontrolle über jede Entscheidung.';

  @override
  String get seizeEveryOpportunity => 'Jede Gelegenheit nutzen';

  @override
  String get seizeEveryOpportunityDesc =>
      'Rechtzeitige Strategie-Updates direkt in Ihren Posteingang sorgen dafür, dass Sie Markttrends zum perfekten Zeitpunkt nutzen.';

  @override
  String get minvestAiCoreValueTitle => 'Signal GPT - Kernwert';

  @override
  String get minvestAiCoreValueDesc =>
      'KI analysiert kontinuierlich Echtzeit-Marktdaten und filtert Erkenntnisse, um schnelle und präzise Investitionsmöglichkeiten zu identifizieren';

  @override
  String get frequentlyAskedQuestions => 'Häufig gestellte Fragen (FAQ)';

  @override
  String get faqSubtitle =>
      'Alle Ihre Fragen – von der Anmeldung über die Vorteile bis hin zur Funktionsweise unserer KI – werden unten beantwortet. Wenn Sie noch Zweifel haben, schreiben Sie uns gerne auf Whatsapp';

  @override
  String get maximizeResultsTitle =>
      'Maximieren Sie Ihre Ergebnisse mit Signal GPT\nfortschrittliche Marktanalyse und präzisionsgefilterte Signale';

  @override
  String get elevateTradingWithAiStrategies =>
      'Verbessern Sie Ihren Handel mit KI-optimierten Strategien, die auf Konsistenz und Klarheit ausgelegt sind';

  @override
  String get winMoreWithAiSignalsTitle =>
      'Gewinnen Sie mehr mit KI-gestützten Signalen\nin jedem Markt';

  @override
  String get winMoreWithAiSignalsDesc =>
      'Unsere Multi-Market-KI scannt Forex, Krypto und Metalle in Echtzeit\nund liefert von Experten validierte Handelssignale –\nmit klaren Einstiegs-, Stop-Loss- und Take-Profit-Leveln';

  @override
  String get buyLimit => 'Kauflimit';

  @override
  String get sellLimit => 'Verkaufslimit';

  @override
  String get smarterToolsTitle =>
      'Intelligenter Werkzeuge - Bessere Investitionen';

  @override
  String get smarterToolsDesc =>
      'Entdecken Sie die Funktionen, die Ihnen helfen, Risiken zu minimieren, Chancen zu nutzen und Ihr Vermögen zu vermehren';

  @override
  String get performanceOverviewTitle => 'Leistungsübersicht';

  @override
  String get performanceOverviewDesc =>
      'Unsere Multi-Market-KI scannt Forex, Krypto und Metalle in Echtzeit und liefert von Experten validierte Handelssignale – mit klaren Einstiegs-, Stop-Loss- und Take-Profit-Leveln';

  @override
  String get totalProfit => 'Gesamtgewinn';

  @override
  String get completionSignal => 'Abschlusssignal';

  @override
  String get onDemandFinancialExpertTitle => 'Ihr Finanzexperte auf Abruf';

  @override
  String get onDemandFinancialExpertDesc =>
      'KI-Plattform schlägt Handelssignale vor - selbstlernend, analysiert den Markt 24/7, unbeeinflusst von Emotionen. Minvest hat über 10.000 Finanzanalysten auf ihrem Weg zu präzisen, stabilen und einfach anzuwendenden Signalen unterstützt';

  @override
  String get aiPoweredSignalPlatform => 'KI-gestützte Handelssignal-Plattform';

  @override
  String get selfLearningSystems =>
      'Selbstlernende Systeme, Schärfere Erkenntnisse, Stärkere Trades';

  @override
  String get emotionlessExecution =>
      'Emotionsfreie Ausführung für intelligenteren, disziplinierteren Handel';

  @override
  String get analysingMarket247 => 'Marktanalyse 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Maximieren Sie Ihre Ergebnisse mit Signal GPT\nfortschrittliche Marktanalyse und präzisionsgefilterte Signale';

  @override
  String get minvestAiRegistrationDesc =>
      'Die Signal GPT-Registrierung ist jetzt geöffnet – Plätze könnten bald geschlossen werden, während wir neue Mitglieder prüfen und genehmigen';

  @override
  String get currencyPairs => 'Ware';

  @override
  String get allCurrencyPairs => 'Alle Währungspaare';

  @override
  String get allCommodities => 'Alle Waren';

  @override
  String get allCryptoPairs => 'Alle Krypto-Paare';

  @override
  String get dateRange => 'Datumsbereich';

  @override
  String get selectDateRange => 'Datumsbereich auswählen';

  @override
  String get allAssets => 'Alle Vermögenswerte';

  @override
  String get asset => 'Vermögenswert';

  @override
  String get tokenExpired => 'Token abgelaufen';

  @override
  String get tokenLimitReachedDesc =>
      'Sie haben Ihre 10 kostenlosen Token heute verbraucht. Upgraden Sie Ihr Paket, um mehr Signale zu sehen.';

  @override
  String get later => 'Später';

  @override
  String get created => 'Erstellt';

  @override
  String get detail => 'Detail';

  @override
  String get performanceOverview => 'Leistungsübersicht';

  @override
  String get totalProfitPips => 'Gesamtgewinn (Pips)';

  @override
  String get winRatePercent => 'Gewinnrate (%)';

  @override
  String get comingSoon => 'Demnächst';

  @override
  String get errorLoadingHistory => 'Fehler beim Laden des Verlaufs';

  @override
  String get noHistoryAvailable => 'Kein Signalverlauf verfügbar';

  @override
  String get previous => 'Zurück';

  @override
  String get page => 'Seite';

  @override
  String get next => 'Weiter';

  @override
  String get date => 'Datum';

  @override
  String get timeGmt7 => 'Zeit (GMT)';

  @override
  String get orders => 'Aufträge';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      'Kleiner Bildschirm: Drehen Sie ins Querformat oder scrollen Sie horizontal, um die vollständige Tabelle zu sehen.';

  @override
  String get history => 'Verlauf';

  @override
  String get signalsWillAppearHere =>
      'Signale erscheinen hier, sobald verfügbar';

  @override
  String get pricing => 'Preise';

  @override
  String get choosePlanSubtitle => 'Wählen Sie einen Plan, der zu Ihnen passt';

  @override
  String get financialNewsHub => 'Finanznachrichten-Hub';

  @override
  String get financialNewsHubDesc =>
      'Kritische Updates. Marktreaktionen. Kein Rauschen – nur was Investoren wissen müssen.';

  @override
  String get newsTabAllArticles => 'Alle Artikel';

  @override
  String get newsTabInvestor => 'Investor';

  @override
  String get newsTabKnowledge => 'Wissen';

  @override
  String get newsTabTechnicalAnalysis => 'Technische Analyse';

  @override
  String noArticlesForCategory(Object category) {
    return 'Keine Artikel für Kategorie $category';
  }

  @override
  String get mostPopular => 'Beliebteste';

  @override
  String get noPosts => 'Keine Beiträge';

  @override
  String get relatedArticles => 'Ähnliche Artikel';

  @override
  String get contactInfoSentSuccess =>
      'Kontaktinformationen erfolgreich gesendet.';

  @override
  String contactInfoSentFailed(Object error) {
    return 'Senden der Informationen fehlgeschlagen: $error';
  }

  @override
  String get contactPageSubtitle =>
      'Haben Sie Fragen oder benötigen Sie KI-Lösungen? Lassen Sie es uns wissen, indem Sie das Formular ausfüllen, und wir melden uns bei Ihnen!';

  @override
  String get phone => 'Telefon';

  @override
  String get firstName => 'Vorname';

  @override
  String get enterFirstName => 'Vorname eingeben';

  @override
  String get lastName => 'Nachname';

  @override
  String get enterLastName => 'Nachname eingeben';

  @override
  String get whatAreYourConcerns => 'Was sind Ihre Anliegen?';

  @override
  String get writeConcernsHere => 'Anliegen hier schreiben...';

  @override
  String pleaseEnter(Object field) {
    return 'Bitte geben Sie $field ein';
  }

  @override
  String get faqQuestion1 =>
      'Garantieren die Signale eine 100%ige Erfolgsquote?';

  @override
  String get faqAnswer1 =>
      'Obwohl kein Signal zu 100% garantiert werden kann, strebt Signal GPT eine stabile Erfolgsquote von 60–80% an, unterstützt durch detaillierte Analysen und Risikomanagement, damit Sie die endgültige Entscheidung mit größerer Zuversicht treffen können.';

  @override
  String get faqQuestion2 =>
      'Wenn ich nicht sofort einzahlen möchte, kann ich trotzdem Signalvorschläge erhalten?';

  @override
  String get faqAnswer2 =>
      'Bei der Kontoeröffnung schenkt Ihnen das System 10 kostenlose Token, was 10 detaillierten Signalansichten entspricht. Danach erhalten Sie jeden Tag 1 zusätzlichen Token zur Verwendung. Wenn Sie auf ein VIP-Konto upgraden, schalten Sie viele erweiterte Funktionen frei und verfolgen eine unbegrenzte Anzahl von Aufträgen.';

  @override
  String get faqQuestion3 =>
      'Wenn ich mich angemeldet habe, aber keine Signale erhalten habe, welche Schritte sollte ich unternehmen?';

  @override
  String get faqAnswer3 =>
      'Die Verarbeitung erfolgt in der Regel automatisch. Wenn Sie immer noch keine Signalvorschläge sehen, kontaktieren Sie uns bitte über Whatsapp für sofortige Unterstützung.';

  @override
  String get faqQuestion4 =>
      'Wie viele Signale erhalte ich pro Tag beim Upgrade auf ein VIP-Konto?';

  @override
  String get faqAnswer4 =>
      'Beim Upgrade auf ein VIP-Konto erhalten Sie jeden Tag unbegrenzte Handelssignale. Die Anzahl der Signale ist nicht festgelegt, hängt aber vollständig von der Marktanalyse ab. Wann immer ein Einstiegspunkt von hoher Qualität und hoher Wahrscheinlichkeit erscheint, sendet das Analyseteam das Signal sofort an Sie.';

  @override
  String get priceLevels => 'Preisstufen';

  @override
  String get capitalManagement => 'Kapitalmanagement';

  @override
  String freeSignalsLeft(Object count) {
    return '$count kostenlose Signale übrig';
  }

  @override
  String get unlimitedSignals => 'Unbegrenzte Signale';

  @override
  String get goBack => 'Zurück';

  @override
  String get goldPlan => 'Gold-Plan';

  @override
  String get perMonth => '/ Monat';

  @override
  String get continuouslyUpdating =>
      'Marktdaten kontinuierlich 24/7 aktualisieren';

  @override
  String get providingBestSignals =>
      'Bereitstellung der besten Signale in Echtzeit';

  @override
  String get includesEntrySlTp => 'Enthält Einstieg, SL, TP';

  @override
  String get detailedAnalysis =>
      'Detaillierte Analyse und Bewertung jedes Signals';

  @override
  String get realTimeNotifications => 'Echtzeit-Benachrichtigungen per E-Mail';

  @override
  String get signalPerformanceStats => 'Signal-Leistungsstatistiken';

  @override
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails => 'Handelsregisternummer: 0110057263';

  @override
  String get addressDetails =>
      'Adresse: Nr. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam';

  @override
  String get pagesTitle => 'Seiten';

  @override
  String get legalRegulatoryTitle => 'Rechtlich & Regulatorisch';

  @override
  String get termsOfRegistration => 'Registrierungsbedingungen';

  @override
  String get operatingPrinciples => 'Betriebsgrundsätze';

  @override
  String get termsConditions => 'Allgemeine Geschäftsbedingungen';

  @override
  String get contactTitle => 'Kontakt';

  @override
  String get navFeatures => 'Funktionen';

  @override
  String get navNews => 'Nachrichten';

  @override
  String get tp1Hit => 'TP1 Getroffen';

  @override
  String get tp2Hit => 'TP2 Getroffen';

  @override
  String get tp3Hit => 'TP3 Getroffen';

  @override
  String get slHit => 'SL Getroffen';

  @override
  String get cancelled => 'Storniert';

  @override
  String get exitedByAdmin => 'Von Admin beendet';

  @override
  String get signalClosed => 'Geschlossen';

  @override
  String get errorLoadingPackages => 'Fehler beim Laden der Pakete';

  @override
  String get monthly => 'Monatlich';

  @override
  String get annually => 'Jährlich';

  @override
  String get whatsIncluded => 'Was enthalten ist:';

  @override
  String get chooseThisPlan => 'Diesen Plan wählen';

  @override
  String get bestPricesForPremiumAccess => 'Beste Preise für Premium-Zugang';

  @override
  String get choosePlanFitsNeeds =>
      'Wählen Sie einen Plan, der zu Ihren Geschäftsanforderungen passt, und beginnen Sie mit der Automatisierung mit KI';

  @override
  String get save50Percent => 'SPAREN SIE 50%';

  @override
  String get tryDemo => 'Demo testen';

  @override
  String get pleaseEnterEmailPassword =>
      'Bitte geben Sie E-Mail und Passwort ein';

  @override
  String loginFailed(String error) {
    return 'Anmeldung fehlgeschlagen: $error';
  }

  @override
  String get welcomeBack => 'Willkommen zurück';

  @override
  String get signInToContinue =>
      'Melden Sie sich bei Ihrem Konto an, um fortzufahren';

  @override
  String get or => 'oder';

  @override
  String get email => 'E-Mail';

  @override
  String get emailHint => 'beispiel123@gmail.com';

  @override
  String get password => 'Passwort';

  @override
  String get enterPassword => 'Passwort eingeben';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get createNewAccount => 'Neues Konto hier erstellen!';

  @override
  String get signUp => 'Registrieren';

  @override
  String get signUpAccount => 'Konto registrieren';

  @override
  String get enterPersonalData =>
      'Geben Sie Ihre persönlichen Daten ein, um Ihr Konto zu erstellen';

  @override
  String get nameLabel => 'Name *';

  @override
  String get enterNameHint => 'Namen eingeben';

  @override
  String get emailLabel => 'E-Mail *';

  @override
  String get passwordLabel => 'Passwort *';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get continueButton => 'Weiter';

  @override
  String get fillAllFields => 'Bitte füllen Sie alle Pflichtfelder aus.';

  @override
  String get accountCreatedSuccess => 'Konto erfolgreich erstellt.';

  @override
  String signUpFailed(String error) {
    return 'Registrierung fehlgeschlagen: $error';
  }

  @override
  String get nationality => 'Nationalität:';

  @override
  String get overview => 'Übersicht';

  @override
  String get setting => 'Einstellung';

  @override
  String get paymentHistory => 'Zahlungshistorie';

  @override
  String get signalsPlan => 'Signal-Plan';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => 'Ihre Token';

  @override
  String get emailNotificationPreferences =>
      'E-Mail-Benachrichtigungseinstellungen';

  @override
  String get chooseSignalNotificationTypes =>
      'Wählen Sie, welche Arten von Signalbenachrichtigungen Sie per E-Mail erhalten möchten';

  @override
  String get allSignalNotifications => 'Alle Signalbenachrichtigungen';

  @override
  String get cryptoSignals => 'Krypto-Signale';

  @override
  String get forexSignals => 'Forex-Signale';

  @override
  String get goldSignals => 'Gold-Signale';

  @override
  String get updatePasswordSecure =>
      'Aktualisieren Sie Ihr Passwort, um Ihr Konto sicher zu halten';

  @override
  String get searchLabel => 'Suche:';

  @override
  String get filterBy => 'Filtern nach:';

  @override
  String get allTime => 'Alle Zeit';

  @override
  String get startDate => 'Startdatum:';

  @override
  String get endDate => 'Enddatum:';

  @override
  String get deactivate => 'Deaktivieren';

  @override
  String get unlimited => 'Unbegrenzt';

  @override
  String get tenLeft => '10 übrig';

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
  String get performance => 'Leistung';

  @override
  String get minvestSupport => 'SignalGpt Support';

  @override
  String get leaveMessagePart1 =>
      'Bitte hinterlassen Sie eine Nachricht, unser Team wird so schnell wie möglich antworten. Sie können auch ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 =>
      ' +84 969 156 969 für schnellen Support kontaktieren.';

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
  String get signInRequired => 'Anmeldung erforderlich';

  @override
  String get signInToExploreSignal =>
      'Melden Sie sich an, um dieses Handelssignal zu erkunden!';
}
