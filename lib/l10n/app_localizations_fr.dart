// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'COMPTE MIS À NIVEAU AVEC SUCCÈS';

  @override
  String get lotPerWeek => 'Lot/semaine';

  @override
  String get tableValueFull => 'complet';

  @override
  String get tableValueFulltime => 'plein temps';

  @override
  String get packageTitle => 'FORFAIT';

  @override
  String get duration1Month => '1 mois';

  @override
  String get duration12Months => '12 mois';

  @override
  String get featureReceiveAllSignals => 'Recevoir tous les signaux du jour';

  @override
  String get featureAnalyzeReason => 'Analyser la raison de l\'entrée';

  @override
  String get featureHighPrecisionAI => 'Signal IA haute précision';

  @override
  String get iapStoreNotAvailable =>
      'La boutique n\'est pas disponible sur cet appareil.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'Erreur lors du chargement des produits : $message';
  }

  @override
  String get iapNoProductsFound =>
      'Aucun produit trouvé. Veuillez vérifier la configuration de votre boutique.';

  @override
  String iapTransactionError(Object message) {
    return 'Erreur de transaction : $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'Erreur de vérification : $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'Une erreur inconnue s\'est produite : $error';
  }

  @override
  String get iapProcessingTransaction => 'Traitement de la transaction...';

  @override
  String get orderInfo1Month => 'Paiement pour le forfait Elite 1 mois';

  @override
  String get orderInfo12Months => 'Paiement pour le forfait Elite 12 mois';

  @override
  String get iapNotSupportedOnWeb =>
      'Les achats in-app ne sont pas pris en charge sur la version web.';

  @override
  String get vnpayPaymentTitle => 'PAIEMENT VNPAY';

  @override
  String get creatingOrderWait =>
      'Création de la commande, veuillez patienter...';

  @override
  String errorWithMessage(Object message) {
    return 'Erreur : $message';
  }

  @override
  String get cannotConnectToServer =>
      'Impossible de se connecter au serveur. Veuillez réessayer.';

  @override
  String get transactionCancelledOrFailed =>
      'La transaction a été annulée ou a échoué.';

  @override
  String get cannotCreatePaymentLink =>
      'Impossible de créer le lien de paiement.\nVeuillez réessayer.';

  @override
  String get retry => 'Réessayer';

  @override
  String serverErrorRetry(Object message) {
    return 'Erreur serveur : $message. Veuillez réessayer.';
  }

  @override
  String get redirectingToPayment => 'Redirection vers la page de paiement...';

  @override
  String get invalidPaymentUrl => 'URL de paiement invalide reçue du serveur.';

  @override
  String get processingYourAccount => 'Traitement de votre compte...';

  @override
  String get verificationFailed => 'Échec de la vérification !';

  @override
  String get reuploadImage => 'Réimporter l\'image';

  @override
  String get accountNotLinked => 'Compte non lié à Minvest';

  @override
  String get accountNotLinkedDesc =>
      'Pour obtenir des signaux exclusifs, votre compte Exness doit être enregistré via le lien partenaire Minvest. Veuillez créer un nouveau compte en utilisant le lien ci-dessous.';

  @override
  String get registerExnessViaMinvest => 'S\'inscrire à Exness via Minvest';

  @override
  String get iHaveRegisteredReupload => 'Je suis inscrit, réimporter';

  @override
  String couldNotLaunch(Object url) {
    return 'Impossible de lancer $url';
  }

  @override
  String get status => 'Statut';

  @override
  String get sentOn => 'Envoyé le';

  @override
  String get entryPrice => 'Prix d\'entrée';

  @override
  String get stopLossFull => 'Stop loss';

  @override
  String get takeProfitFull1 => 'Take profit 1';

  @override
  String get takeProfitFull2 => 'Take profit 2';

  @override
  String get takeProfitFull3 => 'Take profit 3';

  @override
  String get noReasonProvided => 'Aucune raison fournie pour ce signal.';

  @override
  String get upgradeToViewReason =>
      'Mettez votre compte à niveau vers Elite pour voir l\'analyse.';

  @override
  String get upgradeToViewFullAnalysis =>
      'Mettre à niveau pour voir l\'analyse complète';

  @override
  String get welcomeTo => 'Bienvenue sur';

  @override
  String get appSlogan =>
      'Améliorez votre trading avec des signaux intelligents.';

  @override
  String get signIn => 'Se connecter';

  @override
  String get continueByGoogle => 'Continuer avec Google';

  @override
  String get continueByFacebook => 'Continuer avec Facebook';

  @override
  String get continueByApple => 'Continuer avec Apple';

  @override
  String get loginSuccess => 'Connexion réussie !';

  @override
  String get live => 'EN DIRECT';

  @override
  String get end => 'FIN';

  @override
  String get symbol => 'SYMBOLE';

  @override
  String get aiSignal => 'Signal IA';

  @override
  String get ruleSignal => 'SIGNAL RÈGLE';

  @override
  String get all => 'TOUT';

  @override
  String get upgradeToSeeMore => 'Mettre à niveau pour voir plus';

  @override
  String get seeDetails => 'voir détails';

  @override
  String get notMatched => 'NON CORRESPONDANT';

  @override
  String get matched => 'CORRESPONDANT';

  @override
  String get entry => 'Entrée';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'Mettre à niveau';

  @override
  String get upgradeAccount => 'METTRE À NIVEAU LE COMPTE';

  @override
  String get compareTiers => 'COMPARER LES NIVEAUX';

  @override
  String get feature => 'Fonctionnalité';

  @override
  String get tierDemo => 'Démo';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'Solde';

  @override
  String get signalTime => 'Heure du signal';

  @override
  String get signalQty => 'Qté de signaux';

  @override
  String get analysis => 'Analyse';

  @override
  String get openExnessAccount => 'Ouvrir un compte Exness !';

  @override
  String get accountVerificationWithExness =>
      'Vérification de compte avec Exness';

  @override
  String get payInAppToUpgrade => 'Payer dans l\'appli';

  @override
  String get bankTransferToUpgrade => 'Virement bancaire';

  @override
  String get accountVerification => 'VÉRIFICATION DU COMPTE';

  @override
  String get accountVerificationPrompt =>
      'Veuillez télécharger une capture d\'écran de votre compte Exness pour être autorisé (votre compte doit être ouvert sous le lien Exness de Minvest)';

  @override
  String get selectPhotoFromLibrary => 'Sélectionner une photo';

  @override
  String get send => 'Envoyer';

  @override
  String get accountInfo => 'Informations sur le compte';

  @override
  String get accountVerifiedSuccessfully => 'COMPTE VÉRIFIÉ AVEC SUCCÈS';

  @override
  String get yourAccountIs => 'Votre compte est';

  @override
  String get returnToHomePage => 'Retour à l\'accueil';

  @override
  String get upgradeFailed =>
      'Échec de la mise à niveau ! Veuillez réimporter l\'image';

  @override
  String get package => 'FORFAIT';

  @override
  String get startNow => 'COMMENCER';

  @override
  String get bankTransfer => 'VIREMENT BANCAIRE';

  @override
  String get transferInformation => 'INFORMATIONS DE VIREMENT';

  @override
  String get scanForFastTransfer => 'Scanner pour virement rapide';

  @override
  String get contactUs247 => 'Contactez-nous 24/7';

  @override
  String get newAnnouncement => 'NOUVELLE ANNONCE';

  @override
  String get profile => 'Profil';

  @override
  String get upgradeNow => 'METTRE À NIVEAU MAINTENANT';

  @override
  String get followMinvest => 'Suivre MInvest';

  @override
  String get tabSignal => 'Signal';

  @override
  String get tabChart => 'Graphique';

  @override
  String get tabProfile => 'Profil';

  @override
  String get reason => 'RAISON';

  @override
  String get error => 'Erreur';

  @override
  String get noSignalsAvailable => 'Aucun signal disponible.';

  @override
  String get outOfGoldenHours => 'Hors des heures dorées';

  @override
  String get outOfGoldenHoursVipDesc =>
      'Les signaux VIP sont disponibles de 8h00 à 17h00 (GMT+7).\nPassez à Elite pour obtenir des signaux 24/24 !';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'Les signaux démo sont disponibles de 8h00 à 17h00 (GMT+7).\nMettez votre compte à niveau pour plus d\'avantages !';

  @override
  String get yourName => 'Votre nom';

  @override
  String get yourEmail => 'votre.email@exemple.com';

  @override
  String get adminPanel => 'Panneau d\'administration';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get confirmLogout => 'Confirmer la déconnexion';

  @override
  String get confirmLogoutMessage =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get upgradeCardTitle => 'METTEZ VOTRE COMPTE À NIVEAU';

  @override
  String get upgradeCardSubtitle => 'Pour accéder à plus de ressources';

  @override
  String get upgradeCardSubtitleWeb =>
      'Pour débloquer des signaux premium et un support à temps plein';

  @override
  String get subscriptionDetails => 'Détails de l\'abonnement';

  @override
  String get notifications => 'Notifications';

  @override
  String get continueAsGuest => 'Continuer en tant qu\'invité';

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get deleteAccountWarning =>
      'Êtes-vous sûr de vouloir supprimer votre compte ? Toutes vos données seront définitivement effacées et ne pourront pas être récupérées.';

  @override
  String get delete => 'Supprimer';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get signalStatusMatched => 'CORRESPONDANT';

  @override
  String get signalStatusNotMatched => 'NON CORRESPONDANT';

  @override
  String get signalStatusCancelled => 'ANNULÉ';

  @override
  String get signalStatusSlHit => 'SL ATTEINT';

  @override
  String get signalStatusTp1Hit => 'TP1 ATTEINT';

  @override
  String get signalStatusTp2Hit => 'TP2 ATTEINT';

  @override
  String get signalStatusTp3Hit => 'TP3 ATTEINT';

  @override
  String get signalStatusRunning => 'EN COURS';

  @override
  String get signalStatusClosed => 'FERMÉ';

  @override
  String get contactUs => 'Contactez-nous';

  @override
  String get tabChat => 'Chat';

  @override
  String get exnessUpgradeNoteForIos =>
      'Pour les clients qui ont enregistré un compte Exness via Minvest, veuillez cliquer sur contactez-nous pour mettre votre compte à niveau.';

  @override
  String get chatWelcomeTitle => '👋 Bienvenue sur Minvest AI !';

  @override
  String get chatWelcomeBody1 =>
      'Veuillez laisser un message, notre équipe vous répondra dès que possible.';

  @override
  String get chatWelcomeBody2 =>
      'Ou contactez-nous directement via Zalo/WhatsApp : ';

  @override
  String get chatWelcomeBody3 => ' pour un support plus rapide !';

  @override
  String get chatLoginPrompt =>
      'Veuillez vous connecter pour utiliser cette fonctionnalité';

  @override
  String get chatStartConversation => 'Commencer votre conversation';

  @override
  String get chatNoMessages => 'Pas encore de messages.';

  @override
  String get chatTypeMessage => 'Tapez un message...';

  @override
  String get chatSupportIsTyping => 'Le support est en train d\'écrire...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName est en train d\'écrire...';
  }

  @override
  String get chatSeen => 'Vu';

  @override
  String get chatDefaultUserName => 'Utilisateur';

  @override
  String get chatDefaultSupportName => 'Support';

  @override
  String get signalEntry => 'Entrée';

  @override
  String get price1Month => '78 \$';

  @override
  String get price12Months => '460 \$';

  @override
  String get foreignTraderSupport =>
      'Pour les traders étrangers, veuillez nous contacter via WhatsApp (+84969.15.6969) pour obtenir de l\'aide';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails => 'Mettre à niveau pour voir les détails...';

  @override
  String get buy => 'ACHETER';

  @override
  String get sell => 'VENDRE';

  @override
  String get logoutDialogTitle => 'Session expirée';

  @override
  String get logoutDialogDefaultReason =>
      'Votre compte a été connecté sur un autre appareil.';

  @override
  String get ok => 'OK';

  @override
  String get contactToUpgrade => 'Contacter pour mettre à niveau';

  @override
  String get noNotificationsYet => 'Pas encore de notifications.';

  @override
  String daysAgo(int count) {
    return 'il y a $count jours';
  }

  @override
  String hoursAgo(int count) {
    return 'il y a $count heures';
  }

  @override
  String minutesAgo(int count) {
    return 'il y a $count minutes';
  }

  @override
  String get justNow => 'À l\'instant';

  @override
  String get getSignalsNow => 'Obtenir des Signaux';

  @override
  String get freeTrial => 'Essai Gratuit';

  @override
  String get heroTitle =>
      'Guider les traders & faire croître les portefeuilles';

  @override
  String get heroSubtitle => 'Le moteur IA ultime – Conçu par des experts';

  @override
  String get globalAiInnovationTitle =>
      'Innovation IA mondiale pour la prochaine génération de trading intelligent';

  @override
  String get globalAiInnovationDesc =>
      'Transformer le trading traditionnel avec des signaux IA basés sur le cloud — s\'adaptant aux nouvelles et tendances du marché en temps réel pour des performances plus rapides, plus précises et sans émotion.';

  @override
  String get liveTradingSignalsTitle =>
      'EN DIRECT – Signaux de trading IA 24/7';

  @override
  String get liveTradingSignalsDesc =>
      'Analyses cloud en temps réel fournissant des stratégies de suivi de tendance à haute probabilité avec une précision adaptative et une exécution sans émotion.';

  @override
  String get trendFollowing => 'Suivi de tendance';

  @override
  String get realtime => 'Temps réel';

  @override
  String get orderExplanationEngineTitle => 'Moteur d\'explication des ordres';

  @override
  String get orderExplanationEngineDesc =>
      'Explique les configurations de trading en termes simples — montrant comment les confluences se forment, pourquoi les entrées sont faites, et aidant les traders à apprendre de chaque décision.';

  @override
  String get transparent => 'Transparent';

  @override
  String get educational => 'Éducatif';

  @override
  String get logical => 'Logique';

  @override
  String get transparentRealPerformanceTitle =>
      'Transparent - Performance réelle';

  @override
  String get transparentRealPerformanceDesc =>
      'Voir des données réelles sur la précision des signaux, le taux de réussite et la rentabilité — vérifiées et traçables dans chaque transaction';

  @override
  String get results => 'Résultats';

  @override
  String get performanceTracking => 'Suivi de performance';

  @override
  String get accurate => 'Précis';

  @override
  String get predictiveAccuracy => 'Précision prédictive';

  @override
  String get improvementInProfitability => 'Amélioration de la rentabilité';

  @override
  String get improvedRiskManagement => 'Gestion des risques améliorée';

  @override
  String get signalsPerformanceTitle => 'Performance des signaux';

  @override
  String get riskToRewardRatio => 'Ratio risque/récompense';

  @override
  String get howRiskComparesToReward =>
      'Comment le risque se compare à la récompense';

  @override
  String get profitLossOverview => 'Aperçu Profits/Pertes';

  @override
  String get netGainVsLoss => 'Gain net vs perte';

  @override
  String get winRate => 'Taux de réussite';

  @override
  String get percentageOfWinningTrades =>
      'Pourcentage de transactions gagnantes';

  @override
  String get accuracyRate => 'Taux de précision';

  @override
  String get howPreciseOurSignalsAre => 'La précision de nos signaux';

  @override
  String get realtimeMarketAnalysis => 'Analyse de marché en temps réel';

  @override
  String get realtimeMarketAnalysisDesc =>
      'Notre IA surveille le marché en continu, identifiant les zones de convergence technique et les points de rupture fiables pour que vous puissiez entrer au bon moment.';

  @override
  String get saveTimeOnAnalysis => 'Gagnez du temps sur l\'analyse';

  @override
  String get saveTimeOnAnalysisDesc =>
      'Plus besoin de passer des heures à lire des graphiques. Recevez des stratégies d\'investissement sur mesure en quelques minutes par jour.';

  @override
  String get minimizeEmotionalTrading => 'Minimisez le trading émotionnel';

  @override
  String get minimizeEmotionalTradingDesc =>
      'Avec des alertes intelligentes, une détection des risques et des signaux basés sur des données (pas des émotions), vous restez discipliné et en contrôle de chaque décision.';

  @override
  String get seizeEveryOpportunity => 'Saisissez chaque opportunité';

  @override
  String get seizeEveryOpportunityDesc =>
      'Des mises à jour de stratégie opportunes livrées directement dans votre boîte de réception vous assurent de surfer sur les tendances du marché au moment parfait.';

  @override
  String get minvestAiCoreValueTitle => 'Valeur fondamentale de Minvest AI';

  @override
  String get minvestAiCoreValueDesc =>
      'L\'IA analyse les données de marché en temps réel en continu, filtrant les informations pour identifier des opportunités d\'investissement rapides et précises';

  @override
  String get frequentlyAskedQuestions => 'Foire aux questions';

  @override
  String get maximizeResultsTitle =>
      'Maximisez vos résultats avec l\'analyse de marché avancée de Minvest AI et les signaux filtrés avec précision';

  @override
  String get elevateTradingWithAiStrategies =>
      'Élevez votre trading avec des stratégies améliorées par l\'IA conçues pour la cohérence et la clarté';

  @override
  String get winMoreWithAiSignalsTitle =>
      'Gagnez plus avec des signaux alimentés par l\'IA\ndans chaque marché';

  @override
  String get winMoreWithAiSignalsDesc =>
      'Notre IA multi-marchés scanne le Forex, les Cryptos et les Métaux en temps réel,\nfournissant des signaux de trading validés par des experts —\navec des niveaux d\'entrée, de stop-loss et de take-profit clairs';

  @override
  String get buyLimit => 'Achat limite';

  @override
  String get sellLimit => 'Vente limite';

  @override
  String get smarterToolsTitle =>
      'Outils plus intelligents - Meilleurs investissements';

  @override
  String get smarterToolsDesc =>
      'Découvrez les fonctionnalités qui vous aident à minimiser les risques, saisir les opportunités et faire croître votre patrimoine';

  @override
  String get performanceOverviewTitle => 'Aperçu des performances';

  @override
  String get performanceOverviewDesc =>
      'Notre IA multi-marchés scanne le Forex, les Cryptos et les Métaux en temps réel, fournissant des signaux de trading validés par des experts - avec des niveaux d\'entrée, de stop-loss et de take-profit clairs';

  @override
  String get totalProfit => 'Profit total';

  @override
  String get completionSignal => 'Signal d\'achèvement';

  @override
  String get onDemandFinancialExpertTitle =>
      'Votre expert financier à la demande';

  @override
  String get onDemandFinancialExpertDesc =>
      'La plateforme IA suggère des signaux de trading - auto-apprenante, analyse le marché 24/7, non affectée par les émotions. Minvest a soutenu plus de 10 000 analystes financiers\ndans leur parcours pour trouver des signaux précis, stables et faciles à appliquer';

  @override
  String get aiPoweredSignalPlatform =>
      'Plateforme de signaux de trading alimentée par l\'IA';

  @override
  String get selfLearningSystems =>
      'Systèmes auto-apprenants, perspectives plus nettes, transactions plus fortes';

  @override
  String get emotionlessExecution =>
      'Exécution sans émotion pour un trading plus intelligent\net plus discipliné';

  @override
  String get analysingMarket247 => 'Analyse du marché 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Maximisez vos résultats avec l\'analyse de marché avancée\net les signaux filtrés avec précision de Minvest AI';

  @override
  String get minvestAiRegistrationDesc =>
      'L\'inscription à Minvest AI est maintenant ouverte — les places peuvent se fermer bientôt car nous examinons et approuvons les nouveaux membres';

  @override
  String get currencyPairs => 'Paires de devises';

  @override
  String get allCurrencyPairs => 'Toutes les paires de devises';

  @override
  String get dateRange => 'Plage de dates';

  @override
  String get selectDateRange => 'Sélectionner une plage de dates';

  @override
  String get allAssets => 'Tous les actifs';

  @override
  String get asset => 'Actif';

  @override
  String get tokenExpired => 'Jeton expiré';

  @override
  String get tokenLimitReachedDesc =>
      'Vous avez utilisé vos 10 jetons gratuits aujourd\'hui. Mettez à niveau votre forfait pour voir plus de signaux.';

  @override
  String get later => 'Plus tard';

  @override
  String get created => 'Créé';

  @override
  String get detail => 'Détail';

  @override
  String get performanceOverview => 'Aperçu des performances';

  @override
  String get totalProfitPips => 'Profit total (Pips)';

  @override
  String get winRatePercent => 'Taux de réussite (%)';

  @override
  String get comingSoon => 'Bientôt disponible';

  @override
  String get errorLoadingHistory =>
      'Erreur lors du chargement de l\'historique';

  @override
  String get noHistoryAvailable => 'Aucun historique de signal disponible';

  @override
  String get previous => 'Précédent';

  @override
  String get page => 'Page';

  @override
  String get next => 'Suivant';

  @override
  String get date => 'Date';

  @override
  String get timeGmt7 => 'Heure (GMT +7)';

  @override
  String get orders => 'Ordres';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      'Petit écran : tournez en paysage ou faites défiler horizontalement pour voir le tableau complet.';

  @override
  String get history => 'Historique';

  @override
  String get signalsWillAppearHere =>
      'Les signaux apparaîtront ici lorsqu\'ils seront disponibles';

  @override
  String get pricing => 'Tarification';

  @override
  String get choosePlanSubtitle => 'Choisissez un plan qui vous convient';

  @override
  String get financialNewsHub => 'Centre d\'actualités financières';

  @override
  String get financialNewsHubDesc =>
      'Mises à jour critiques. Réactions du marché. Pas de bruit – juste ce que les investisseurs doivent savoir.';

  @override
  String get newsTabAllArticles => 'Tous les articles';

  @override
  String get newsTabInvestor => 'Investisseur';

  @override
  String get newsTabKnowledge => 'Connaissances';

  @override
  String get newsTabTechnicalAnalysis => 'Analyse technique';

  @override
  String noArticlesForCategory(Object category) {
    return 'Aucun article pour la catégorie $category';
  }

  @override
  String get mostPopular => 'Le plus populaire';

  @override
  String get noPosts => 'Aucun article';

  @override
  String get relatedArticles => 'Articles connexes';

  @override
  String get contactInfoSentSuccess =>
      'Informations de contact envoyées avec succès.';

  @override
  String contactInfoSentFailed(Object error) {
    return 'Échec de l\'envoi des informations : $error';
  }

  @override
  String get contactPageSubtitle =>
      'Des questions ou besoin de solutions d\'IA ? Faites-le nous savoir en remplissant le formulaire, et nous vous contacterons !';

  @override
  String get phone => 'Téléphone';

  @override
  String get firstName => 'Prénom';

  @override
  String get enterFirstName => 'Entrez le prénom';

  @override
  String get lastName => 'Nom de famille';

  @override
  String get enterLastName => 'Entrez le nom de famille';

  @override
  String get whatAreYourConcerns => 'Quelles sont vos préoccupations ?';

  @override
  String get writeConcernsHere => 'Écrivez vos préoccupations ici...';

  @override
  String pleaseEnter(Object field) {
    return 'Veuillez entrer $field';
  }

  @override
  String get faqQuestion1 =>
      'Les signaux garantissent-ils un taux de réussite de 100 % ?';

  @override
  String get faqAnswer1 =>
      'Bien qu\'aucun signal ne puisse être garanti à 100 %, Minvest AI s\'efforce de maintenir un taux de réussite stable de 60 à 80 %, soutenu par une analyse détaillée et une gestion des risques afin que vous puissiez prendre la décision finale avec une plus grande confiance.';

  @override
  String get faqQuestion2 =>
      'Si je ne souhaite pas déposer tout de suite, puis-je toujours recevoir des suggestions de signaux ?';

  @override
  String get faqAnswer2 =>
      'Oui. Créez simplement un compte Exness via le lien Minvest, et vous aurez accès à notre groupe de signaux de démonstration gratuit (Community VIP).';

  @override
  String get faqQuestion3 =>
      'Si je me suis inscrit mais que je n\'ai reçu aucun signal, quelles mesures dois-je prendre ?';

  @override
  String get faqAnswer3 =>
      'Le traitement est généralement automatique. Si vous ne voyez toujours aucune suggestion de signal, veuillez nous contacter via Whatsapp pour une assistance immédiate.';

  @override
  String get faqQuestion4 =>
      'Puis-je toujours participer si je ne m\'inscris pas à un compte Exness ?';

  @override
  String get faqAnswer4 =>
      'Veuillez nous contacter via WhatsApp ou Live Chat pour obtenir de l\'aide.';

  @override
  String get priceLevels => 'Niveaux de prix';

  @override
  String get capitalManagement => 'Gestion du capital';

  @override
  String freeSignalsLeft(Object count) {
    return '$count signaux gratuits restants';
  }

  @override
  String get unlimitedSignals => 'Signaux illimités';

  @override
  String get goBack => 'Retour';

  @override
  String get goldPlan => 'Plan Or';

  @override
  String get perMonth => '/mois';

  @override
  String get continuouslyUpdating =>
      'Mise à jour continue des données de marché 24/7';

  @override
  String get providingBestSignals =>
      'Fournissant les meilleurs signaux en temps réel';

  @override
  String get includesEntrySlTp => 'Comprend Entrée, SL, TP';

  @override
  String get detailedAnalysis =>
      'Analyse détaillée et évaluation de chaque signal';

  @override
  String get realTimeNotifications => 'Notifications en temps réel par e-mail';

  @override
  String get signalPerformanceStats =>
      'Statistiques de performance des signaux';

  @override
  String get enterpriseCodeDetails =>
      'Code d\'entreprise : 0107136243 délivré par le Département des Finances de Hanoï le 24/11/2015 ; 6e amendement enregistré par le Département des Finances de Hanoï le 05/08/2025.';

  @override
  String get addressDetails =>
      'Adresse : C2810, 18e étage, Immeuble C2, Lot HH, Zone urbaine de Dong Nam, Rue Tran Duy Hung, Quartier Yen Hoa, Hanoï, Vietnam.';

  @override
  String get pagesTitle => 'Pages';

  @override
  String get legalRegulatoryTitle => 'Légal et réglementaire';

  @override
  String get termsOfRegistration => 'Conditions d\'inscription';

  @override
  String get operatingPrinciples => 'Principes de fonctionnement';

  @override
  String get termsConditions => 'Termes et Conditions';

  @override
  String get contactTitle => 'Contact';

  @override
  String get navFeatures => 'Fonctionnalités';

  @override
  String get navNews => 'Actualités';

  @override
  String get tp1Hit => 'TP1 Atteint';

  @override
  String get tp2Hit => 'TP2 Atteint';

  @override
  String get tp3Hit => 'TP3 Atteint';

  @override
  String get slHit => 'SL Atteint';

  @override
  String get cancelled => 'Annulé';

  @override
  String get exitedByAdmin => 'Sorti par Admin';

  @override
  String get signalClosed => 'Fermé';

  @override
  String get errorLoadingPackages => 'Erreur de chargement des forfaits';

  @override
  String get monthly => 'Mensuel';

  @override
  String get annually => 'Annuel';

  @override
  String get whatsIncluded => 'Ce qui est inclus :';

  @override
  String get chooseThisPlan => 'Choisir ce plan';

  @override
  String get bestPricesForPremiumAccess =>
      'Meilleurs prix pour un accès premium';

  @override
  String get choosePlanFitsNeeds =>
      'Choisissez un plan adapté aux besoins de votre entreprise et commencez à automatiser avec l\'IA';

  @override
  String get save50Percent => 'ÉCONOMISEZ 50%';

  @override
  String get tryDemo => 'Essayer la démo';

  @override
  String get pleaseEnterEmailPassword =>
      'Veuillez saisir l\'e-mail et le mot de passe';

  @override
  String loginFailed(String error) {
    return 'Échec de la connexion : $error';
  }

  @override
  String get welcomeBack => 'Bon retour';

  @override
  String get signInToContinue => 'Connectez-vous à votre compte pour continuer';

  @override
  String get or => 'ou';

  @override
  String get email => 'E-mail';

  @override
  String get emailHint => 'exemple123@gmail.com';

  @override
  String get password => 'Mot de passe';

  @override
  String get enterPassword => 'Entrez le mot de passe';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get createNewAccount => 'Créer un nouveau compte ici !';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get signUpAccount => 'Créer un compte';

  @override
  String get enterPersonalData =>
      'Saisissez vos données personnelles pour créer votre compte';

  @override
  String get nameLabel => 'Nom *';

  @override
  String get enterNameHint => 'Entrez le nom';

  @override
  String get emailLabel => 'E-mail *';

  @override
  String get passwordLabel => 'Mot de passe *';

  @override
  String get phoneLabel => 'Téléphone';

  @override
  String get continueButton => 'Continuer';

  @override
  String get fillAllFields => 'Veuillez remplir tous les champs obligatoires.';

  @override
  String get accountCreatedSuccess => 'Compte créé avec succès.';

  @override
  String signUpFailed(String error) {
    return 'Échec de l\'inscription : $error';
  }

  @override
  String get nationality => 'Nationalité :';

  @override
  String get overview => 'Aperçu';

  @override
  String get setting => 'Paramètres';

  @override
  String get paymentHistory => 'Historique des paiements';

  @override
  String get signalsPlan => 'Plan de signaux';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => 'Vos jetons';

  @override
  String get emailNotificationPreferences =>
      'Préférences de notification par e-mail';

  @override
  String get chooseSignalNotificationTypes =>
      'Choisissez les types de notifications de signaux que vous souhaitez recevoir par e-mail';

  @override
  String get allSignalNotifications => 'Toutes les notifications de signaux';

  @override
  String get cryptoSignals => 'Signaux Crypto';

  @override
  String get forexSignals => 'Signaux Forex';

  @override
  String get goldSignals => 'Signaux Or';

  @override
  String get updatePasswordSecure =>
      'Mettez à jour votre mot de passe pour sécuriser votre compte';

  @override
  String get searchLabel => 'Rechercher :';

  @override
  String get filterBy => 'Filtrer par :';

  @override
  String get allTime => 'Tout le temps';

  @override
  String get startDate => 'Date de début :';

  @override
  String get endDate => 'Date de fin :';

  @override
  String get deactivate => 'Désactiver';

  @override
  String get unlimited => 'Illimité';

  @override
  String get tenLeft => '10 restants';
}
