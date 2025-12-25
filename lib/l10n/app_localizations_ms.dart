// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'AKAUN BERJAYA DINAIK TARAF';

  @override
  String get lotPerWeek => 'Lot/minggu';

  @override
  String get tableValueFull => 'penuh';

  @override
  String get tableValueFulltime => 'sepenuh masa';

  @override
  String get packageTitle => 'PAKEJ';

  @override
  String get duration1Month => '1 bulan';

  @override
  String get duration12Months => '12 bulan';

  @override
  String get featureReceiveAllSignals => 'Terima semua isyarat hari ini';

  @override
  String get featureAnalyzeReason => 'Analisis sebab kemasukan pesanan';

  @override
  String get featureHighPrecisionAI => 'Isyarat AI berketepatan tinggi';

  @override
  String get iapStoreNotAvailable => 'Kedai tidak tersedia pada peranti ini.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'Ralat memuatkan produk: $message';
  }

  @override
  String get iapNoProductsFound =>
      'Tiada produk ditemui. Sila semak konfigurasi kedai anda.';

  @override
  String iapTransactionError(Object message) {
    return 'Ralat transaksi: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'Ralat pengesahan: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'Ralat tidak diketahui berlaku: $error';
  }

  @override
  String get iapProcessingTransaction => 'Memproses transaksi...';

  @override
  String get orderInfo1Month => 'Bayaran untuk pakej Elite 1 bulan';

  @override
  String get orderInfo12Months => 'Bayaran untuk pakej Elite 12 bulan';

  @override
  String get iapNotSupportedOnWeb =>
      'Pembelian dalam aplikasi tidak disokong pada versi web.';

  @override
  String get vnpayPaymentTitle => 'PEMBAYARAN VNPAY';

  @override
  String get creatingOrderWait => 'Mencipta pesanan, sila tunggu...';

  @override
  String errorWithMessage(Object message) {
    return 'Ralat: $message';
  }

  @override
  String get cannotConnectToServer =>
      'Tidak dapat menyambung ke pelayan. Sila cuba lagi.';

  @override
  String get transactionCancelledOrFailed =>
      'Transaksi telah dibatalkan atau gagal.';

  @override
  String get cannotCreatePaymentLink =>
      'Tidak dapat membuat pautan pembayaran.\nCuba lagi.';

  @override
  String get retry => 'Cuba Lagi';

  @override
  String serverErrorRetry(Object message) {
    return 'Ralat pelayan: $message. Sila cuba lagi.';
  }

  @override
  String get redirectingToPayment => 'Mengalihkan ke halaman pembayaran...';

  @override
  String get invalidPaymentUrl =>
      'URL pembayaran tidak sah diterima daripada pelayan.';

  @override
  String get processingYourAccount => 'Memproses akaun anda...';

  @override
  String get verificationFailed => 'Pengesahan Gagal!';

  @override
  String get reuploadImage => 'Muat Naik Semula Imej';

  @override
  String get accountNotLinked => 'Akaun Tidak Dipautkan ke Minvest';

  @override
  String get accountNotLinkedDesc =>
      'Untuk mendapatkan isyarat eksklusif, akaun Exness anda mesti didaftarkan melalui pautan rakan kongsi Minvest. Sila buat akaun baharu menggunakan pautan di bawah.';

  @override
  String get registerExnessViaMinvest => 'Daftar Exness melalui Minvest';

  @override
  String get iHaveRegisteredReupload =>
      'Saya telah mendaftar, muat naik semula';

  @override
  String couldNotLaunch(Object url) {
    return 'Tidak dapat melancarkan $url';
  }

  @override
  String get status => 'Status';

  @override
  String get sentOn => 'Dihantar pada';

  @override
  String get entryPrice => 'Harga kemasukan';

  @override
  String get stopLossFull => 'Henti rugi';

  @override
  String get takeProfitFull1 => 'Ambil untung 1';

  @override
  String get takeProfitFull2 => 'Ambil untung 2';

  @override
  String get takeProfitFull3 => 'Ambil untung 3';

  @override
  String get noReasonProvided => 'Tiada sebab diberikan untuk isyarat ini.';

  @override
  String get upgradeToViewReason =>
      'Naik taraf akaun anda ke Elite untuk melihat analisis.';

  @override
  String get upgradeToViewFullAnalysis =>
      'Naik taraf untuk Lihat Analisis Penuh';

  @override
  String get welcomeTo => 'Selamat datang ke';

  @override
  String get appSlogan => 'Tingkatkan perdagangan anda dengan isyarat pintar.';

  @override
  String get signIn => 'Log masuk';

  @override
  String get continueByGoogle => 'Teruskan dengan Google';

  @override
  String get continueByFacebook => 'Teruskan dengan Facebook';

  @override
  String get continueByApple => 'Teruskan dengan Apple';

  @override
  String get loginSuccess => 'Log masuk berjaya!';

  @override
  String get live => 'LANGSUNG';

  @override
  String get end => 'TAMAT';

  @override
  String get symbol => 'SIMBOL';

  @override
  String get aiSignal => 'Isyarat AI';

  @override
  String get ruleSignal => 'ISYARAT PERATURAN';

  @override
  String get all => 'SEMUA';

  @override
  String get upgradeToSeeMore => 'Naik taraf untuk melihat lebih banyak';

  @override
  String get seeDetails => 'lihat butiran';

  @override
  String get notMatched => 'TIDAK PADAN';

  @override
  String get matched => 'PADAN';

  @override
  String get entry => 'Kemasukan';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'Naik Taraf';

  @override
  String get upgradeAccount => 'NAIK TARAF AKAUN';

  @override
  String get compareTiers => 'BANDINGKAN TAHAP';

  @override
  String get feature => 'Ciri';

  @override
  String get tierDemo => 'Demo';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'Baki';

  @override
  String get signalTime => 'Masa isyarat';

  @override
  String get signalQty => 'Kuantiti Isyarat';

  @override
  String get analysis => 'Analisis';

  @override
  String get openExnessAccount => 'Buka akaun Exness!';

  @override
  String get accountVerificationWithExness => 'Pengesahan akaun dengan Exness';

  @override
  String get payInAppToUpgrade => 'Bayar dalam apl untuk menaik taraf';

  @override
  String get bankTransferToUpgrade => 'Pindahan Bank untuk Menaik Taraf';

  @override
  String get accountVerification => 'PENGESAHAN AKAUN';

  @override
  String get accountVerificationPrompt =>
      'Sila muat naik tangkapan skrin akaun Exness anda untuk dibenarkan (akaun anda mesti dibuka di bawah pautan Exness Minvest)';

  @override
  String get selectPhotoFromLibrary => 'Pilih foto dari perpustakaan';

  @override
  String get send => 'Hantar';

  @override
  String get accountInfo => 'Maklumat Akaun';

  @override
  String get accountVerifiedSuccessfully => 'AKAUN BERJAYA DISAHKAN';

  @override
  String get yourAccountIs => 'Akaun anda adalah';

  @override
  String get returnToHomePage => 'Kembali ke halaman utama';

  @override
  String get upgradeFailed => 'Naik taraf gagal! Sila muat naik semula imej';

  @override
  String get package => 'PAKEJ';

  @override
  String get startNow => 'Dapatkan Isyarat Sekarang';

  @override
  String get bankTransfer => 'PINDAHAN BANK';

  @override
  String get transferInformation => 'MAKLUMAT PINDAHAN';

  @override
  String get scanForFastTransfer => 'Imbas untuk pindahan pantas';

  @override
  String get contactUs247 => 'Hubungi Kami 24/7';

  @override
  String get newAnnouncement => 'PENGUMUMAN BARU';

  @override
  String get profile => 'Profil';

  @override
  String get upgradeNow => 'Naik Taraf Sekarang';

  @override
  String get followMinvest => 'Ikuti MInvest';

  @override
  String get tabSignal => 'Isyarat';

  @override
  String get tabChart => 'Carta';

  @override
  String get tabProfile => 'Profil';

  @override
  String get reason => 'SEBAB';

  @override
  String get error => 'Ralat';

  @override
  String get noSignalsAvailable => 'Tiada isyarat tersedia.';

  @override
  String get outOfGoldenHours => 'Di Luar Waktu Emas';

  @override
  String get outOfGoldenHoursVipDesc =>
      'Isyarat VIP tersedia dari 8:00 PG hingga 5:00 PTG (GMT+7).\nNaik taraf ke Elite untuk mendapatkan isyarat 24/24!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'Isyarat Demo tersedia dari 8:00 PG hingga 5:00 PTG (GMT+7).\nNaik taraf akaun anda untuk faedah lebih!';

  @override
  String get yourName => 'Nama Anda';

  @override
  String get yourEmail => 'emel.anda@contoh.com';

  @override
  String get adminPanel => 'Panel Admin';

  @override
  String get logout => 'Log Keluar';

  @override
  String get confirmLogout => 'Sahkan Log Keluar';

  @override
  String get confirmLogoutMessage => 'Adakah anda pasti mahu log keluar?';

  @override
  String get cancel => 'Batal';

  @override
  String get upgradeCardTitle => 'NAIK TARAF AKAUN ANDA';

  @override
  String get upgradeCardSubtitle => 'Untuk mengakses lebih banyak sumber';

  @override
  String get upgradeCardSubtitleWeb =>
      'Untuk membuka kunci isyarat premium dan sokongan sepenuh masa';

  @override
  String get subscriptionDetails => 'Butiran Langganan';

  @override
  String get notifications => 'Pemberitahuan';

  @override
  String get continueAsGuest => 'Teruskan sebagai Tetamu';

  @override
  String get deleteAccount => 'Padam Akaun';

  @override
  String get deleteAccountWarning =>
      'Adakah anda pasti mahu memadam akaun anda? Semua data anda akan dipadamkan secara kekal dan tidak dapat dipulihkan.';

  @override
  String get delete => 'Padam';

  @override
  String get privacyPolicy => 'Dasar Privasi';

  @override
  String get termsOfService => 'Syarat Perkhidmatan';

  @override
  String get signalStatusMatched => 'PADAN';

  @override
  String get signalStatusNotMatched => 'TIDAK PADAN';

  @override
  String get signalStatusCancelled => 'DIBATALKAN';

  @override
  String get signalStatusSlHit => 'SL KENA';

  @override
  String get signalStatusTp1Hit => 'TP1 KENA';

  @override
  String get signalStatusTp2Hit => 'TP2 KENA';

  @override
  String get signalStatusTp3Hit => 'TP3 KENA';

  @override
  String get signalStatusRunning => 'BERJALAN';

  @override
  String get signalStatusClosed => 'DITUTUP';

  @override
  String get contactUs => 'Hubungi Kami';

  @override
  String get tabChat => 'Sembang';

  @override
  String get exnessUpgradeNoteForIos =>
      'Bagi pelanggan yang telah mendaftar akaun Exness melalui Minvest, sila klik hubungi kami untuk menaik taraf akaun anda.';

  @override
  String get chatWelcomeTitle => '👋 Selamat datang ke Signal GPT!';

  @override
  String get chatWelcomeBody1 =>
      'Sila tinggalkan mesej, pasukan kami akan membalas secepat mungkin.';

  @override
  String get chatWelcomeBody2 =>
      'Atau hubungi kami terus melalui Zalo/WhatsApp: ';

  @override
  String get chatWelcomeBody3 => ' untuk sokongan lebih pantas!';

  @override
  String get chatLoginPrompt => 'Sila log masuk untuk menggunakan ciri ini';

  @override
  String get chatStartConversation => 'Mulakan perbualan anda';

  @override
  String get chatNoMessages => 'Tiada mesej lagi.';

  @override
  String get chatTypeMessage => 'Taip mesej...';

  @override
  String get chatSupportIsTyping => 'Sokongan sedang menaip...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName sedang menaip...';
  }

  @override
  String get chatSeen => 'Dilihat';

  @override
  String get chatDefaultUserName => 'Pengguna';

  @override
  String get chatDefaultSupportName => 'Sokongan';

  @override
  String get signalEntry => 'Kemasukan';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      'Untuk pedagang asing, sila hubungi kami melalui WhatsApp (+84969.15.6969) untuk sokongan';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails =>
      'Naik taraf untuk melihat butiran isyarat...';

  @override
  String get buy => 'BELI';

  @override
  String get sell => 'JUAL';

  @override
  String get logoutDialogTitle => 'Sesi Tamat';

  @override
  String get logoutDialogDefaultReason =>
      'Akaun anda telah log masuk pada peranti lain.';

  @override
  String get ok => 'OK';

  @override
  String get contactToUpgrade => 'Hubungi untuk menaik taraf';

  @override
  String get noNotificationsYet => 'Tiada pemberitahuan lagi.';

  @override
  String daysAgo(int count) {
    return '$count hari lalu';
  }

  @override
  String hoursAgo(int count) {
    return '$count jam lalu';
  }

  @override
  String minutesAgo(int count) {
    return '$count minit lalu';
  }

  @override
  String get justNow => 'Sebentar tadi';

  @override
  String get getSignalsNow => 'Dapatkan Isyarat Sekarang';

  @override
  String get freeTrial => 'Percubaan Percuma';

  @override
  String get heroTitle => 'Membimbing Pedagang & Mengembangkan Portfolio';

  @override
  String get heroSubtitle => 'Enjin AI Terbaik – Direka oleh Pedagang Pakar';

  @override
  String get globalAiInnovationTitle =>
      'Inovasi AI Global untuk Generasi Seterusnya Kepintaran Perdagangan';

  @override
  String get globalAiInnovationDesc =>
      'Mengubah perdagangan tradisional dengan isyarat AI berkuasa awan — menyesuaikan diri dengan berita pasaran dan trend masa nyata\nuntuk prestasi yang lebih pantas, lebih tepat, dan bebas emosi.';

  @override
  String get liveTradingSignalsTitle =>
      'LANGSUNG – Isyarat Perdagangan AI 24/7';

  @override
  String get liveTradingSignalsDesc =>
      'Analitik awan masa nyata menyampaikan strategi mengikut trend berkebarangkalian tinggi dengan ketepatan adaptif dan pelaksanaan bebas emosi.';

  @override
  String get trendFollowing => 'Mengikut Trend';

  @override
  String get realtime => 'Masa nyata';

  @override
  String get orderExplanationEngineTitle => 'Enjin Penjelasan Pesanan';

  @override
  String get orderExplanationEngineDesc =>
      'Menerangkan persediaan perdagangan dalam istilah mudah — menunjukkan bagaimana pertemuan terbentuk, mengapa kemasukan dibuat, dan membantu pedagang belajar daripada setiap keputusan.';

  @override
  String get transparent => 'Telus';

  @override
  String get educational => 'Pendidikan';

  @override
  String get logical => 'Logik';

  @override
  String get transparentRealPerformanceTitle => 'Telus - Prestasi Sebenar';

  @override
  String get transparentRealPerformanceDesc =>
      'Lihat data sebenar mengenai ketepatan isyarat, kadar kejayaan, dan keuntungan — disahkan dan boleh dikesan dalam setiap perdagangan';

  @override
  String get results => 'Keputusan';

  @override
  String get performanceTracking => 'Penjejakan Prestasi';

  @override
  String get accurate => 'Tepat';

  @override
  String get predictiveAccuracy => 'Ketepatan Ramalan';

  @override
  String get improvementInProfitability => 'Peningkatan dalam Keuntungan';

  @override
  String get improvedRiskManagement => 'Pengurusan Risiko yang Ditingkatkan';

  @override
  String get signalsPerformanceTitle => 'Prestasi Isyarat';

  @override
  String get riskToRewardRatio => 'Nisbah Risiko-ke-Ganjaran';

  @override
  String get howRiskComparesToReward =>
      'Bagaimana risiko dibandingkan dengan ganjaran';

  @override
  String get profitLossOverview => 'Gambaran Keseluruhan Untung/Rugi';

  @override
  String get netGainVsLoss => 'Keuntungan bersih vs kerugian';

  @override
  String get winRate => 'Kadar Kemenangan';

  @override
  String get percentageOfWinningTrades => 'Peratusan perdagangan yang menang';

  @override
  String get accuracyRate => 'Kadar Ketepatan';

  @override
  String get howPreciseOurSignalsAre => 'Seberapa tepat isyarat kami';

  @override
  String get realtimeMarketAnalysis => 'Analisis Pasaran Masa Nyata';

  @override
  String get realtimeMarketAnalysisDesc =>
      'AI kami memantau pasaran secara berterusan, mengenal pasti zon penumpuan teknikal dan titik penembusan yang boleh dipercayai supaya anda boleh memasuki perdagangan pada masa yang tepat.';

  @override
  String get saveTimeOnAnalysis => 'Jimat Masa pada Analisis';

  @override
  String get saveTimeOnAnalysisDesc =>
      'Tiada lagi jam dihabiskan membaca carta. Terima strategi pelaburan yang disesuaikan dalam hanya beberapa minit sehari.';

  @override
  String get minimizeEmotionalTrading => 'Minimumkan Perdagangan Emosi';

  @override
  String get minimizeEmotionalTradingDesc =>
      'Dengan amaran pintar, pengesanan risiko, dan isyarat dipacu data bukan emosi anda kekal berdisiplin dan mengawal setiap keputusan.';

  @override
  String get seizeEveryOpportunity => 'Rebut Setiap Peluang';

  @override
  String get seizeEveryOpportunityDesc =>
      'Kemas kini strategi tepat pada masanya dihantar terus ke peti masuk anda memastikan anda menunggang trend pasaran pada masa yang sempurna.';

  @override
  String get minvestAiCoreValueTitle => 'Signal GPT - Nilai Teras';

  @override
  String get minvestAiCoreValueDesc =>
      'AI menganalisis data pasaran masa nyata secara berterusan, menapis wawasan untuk mengenal pasti peluang pelaburan yang pantas dan tepat';

  @override
  String get frequentlyAskedQuestions => 'Soalan Lazim (FAQ)';

  @override
  String get faqSubtitle =>
      'Semua soalan anda — dari cara menyertai, hingga faedah, hingga cara AI kami berfungsi — dijawab tepat di bawah. Jika anda masih mempunyai keraguan, sila hantar mesej kepada kami di Whatsapp';

  @override
  String get maximizeResultsTitle =>
      'Maksimumkan hasil anda dengan Signal GPT\nanalisis pasaran lanjutan dan isyarat ditapis ketepatan';

  @override
  String get elevateTradingWithAiStrategies =>
      'Tingkatkan perdagangan anda dengan strategi dipertingkatkan AI yang direka untuk konsistensi dan kejelasan';

  @override
  String get winMoreWithAiSignalsTitle =>
      'Menang Lebih Banyak dengan Isyarat Berkuasa AI\ndi Setiap Pasaran';

  @override
  String get winMoreWithAiSignalsDesc =>
      'AI pelbagai pasaran kami mengimbas Forex, Kripto, dan Logam dalam masa nyata,\nmenyampaikan isyarat perdagangan yang disahkan pakar —\ndengan tahap kemasukan, henti rugi, dan ambil untung yang jelas';

  @override
  String get buyLimit => 'Had beli';

  @override
  String get sellLimit => 'Had jual';

  @override
  String get smarterToolsTitle => 'Alat Lebih Pintar - Pelaburan Lebih Baik';

  @override
  String get smarterToolsDesc =>
      'Temui ciri-ciri yang membantu anda meminimumkan risiko, merebut peluang, dan mengembangkan kekayaan anda';

  @override
  String get performanceOverviewTitle => 'Gambaran Keseluruhan Prestasi';

  @override
  String get performanceOverviewDesc =>
      'AI pelbagai pasaran kami mengimbas Forex, Kripto, dan Logam dalam masa nyata, menyampaikan isyarat perdagangan yang disahkan pakar - dengan tahap kemasukan, henti rugi, dan ambil untung yang jelas';

  @override
  String get totalProfit => 'Jumlah Keuntungan';

  @override
  String get completionSignal => 'Isyarat penyelesaian';

  @override
  String get onDemandFinancialExpertTitle =>
      'Pakar Kewangan Atas Permintaan Anda';

  @override
  String get onDemandFinancialExpertDesc =>
      'Platform AI mencadangkan isyarat perdagangan - belajar sendiri, menganalisis pasaran 24/7, tidak dipengaruhi oleh emosi. Minvest telah menyokong lebih daripada 10,000 penganalisis kewangan dalam perjalanan mereka untuk mencari isyarat yang tepat, stabil, dan mudah digunakan';

  @override
  String get aiPoweredSignalPlatform =>
      'Platform Isyarat Perdagangan Berkuasa AI';

  @override
  String get selfLearningSystems =>
      'Sistem Belajar Sendiri, Wawasan Lebih Tajam, Perdagangan Lebih Kukuh';

  @override
  String get emotionlessExecution =>
      'Pelaksanaan Bebas Emosi Untuk Perdagangan yang Lebih Pintar dan Berdisiplin';

  @override
  String get analysingMarket247 => 'Menganalisis pasaran 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Maksimumkan hasil anda dengan Signal GPT\nanalisis pasaran lanjutan dan isyarat ditapis ketepatan';

  @override
  String get minvestAiRegistrationDesc =>
      'Pendaftaran Signal GPT kini dibuka — tempat mungkin ditutup tidak lama lagi kerana kami menyemak dan meluluskan ahli baharu';

  @override
  String get currencyPairs => 'Komoditi';

  @override
  String get allCurrencyPairs => 'Semua Pasangan Mata Wang';

  @override
  String get allCommodities => 'Semua Komoditi';

  @override
  String get allCryptoPairs => 'Semua Pasangan Kripto';

  @override
  String get dateRange => 'Julat Tarikh';

  @override
  String get selectDateRange => 'Pilih Julat Tarikh';

  @override
  String get allAssets => 'Semua Aset';

  @override
  String get asset => 'Aset';

  @override
  String get tokenExpired => 'Token tamat tempoh';

  @override
  String get tokenLimitReachedDesc =>
      'Anda telah menggunakan 10 token percuma anda hari ini. Naik taraf pakej anda untuk melihat lebih banyak isyarat.';

  @override
  String get later => 'Kemudian';

  @override
  String get created => 'Dicipta';

  @override
  String get detail => 'Perincian';

  @override
  String get performanceOverview => 'Gambaran Keseluruhan Prestasi';

  @override
  String get totalProfitPips => 'Jumlah Keuntungan (Pips)';

  @override
  String get winRatePercent => 'Kadar Kemenangan (%)';

  @override
  String get comingSoon => 'Akan datang';

  @override
  String get errorLoadingHistory => 'Ralat memuatkan sejarah';

  @override
  String get noHistoryAvailable => 'Tiada sejarah isyarat tersedia';

  @override
  String get previous => 'Sebelumnya';

  @override
  String get page => 'Halaman';

  @override
  String get next => 'Seterusnya';

  @override
  String get date => 'Tarikh';

  @override
  String get timeGmt7 => 'Masa (GMT)';

  @override
  String get orders => 'Pesanan';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      'Skrin kecil: putar landskap atau tatal mendatar untuk melihat jadual penuh.';

  @override
  String get history => 'Sejarah';

  @override
  String get signalsWillAppearHere =>
      'Isyarat akan muncul di sini apabila tersedia';

  @override
  String get pricing => 'Harga';

  @override
  String get choosePlanSubtitle => 'Pilih pelan yang sesuai untuk anda';

  @override
  String get financialNewsHub => 'Hab Berita Kewangan';

  @override
  String get financialNewsHubDesc =>
      'Kemas kini kritikal. Reaksi pasaran. Tiada gangguan – hanya apa yang pelabur perlu tahu.';

  @override
  String get newsTabAllArticles => 'Semua Artikel';

  @override
  String get newsTabInvestor => 'Pelabur';

  @override
  String get newsTabKnowledge => 'Pengetahuan';

  @override
  String get newsTabTechnicalAnalysis => 'Analisis Teknikal';

  @override
  String noArticlesForCategory(Object category) {
    return 'Tiada artikel untuk kategori $category';
  }

  @override
  String get mostPopular => 'Paling popular';

  @override
  String get noPosts => 'Tiada siaran';

  @override
  String get relatedArticles => 'Artikel berkaitan';

  @override
  String get contactInfoSentSuccess => 'Maklumat hubungan berjaya dihantar.';

  @override
  String contactInfoSentFailed(Object error) {
    return 'Gagal menghantar maklumat: $error';
  }

  @override
  String get contactPageSubtitle =>
      'Ada soalan atau perlukan penyelesaian AI? Beritahu kami dengan mengisi borang, dan kami akan menghubungi anda!';

  @override
  String get phone => 'Telefon';

  @override
  String get firstName => 'Nama Pertama';

  @override
  String get enterFirstName => 'Masukkan Nama Pertama';

  @override
  String get lastName => 'Nama Keluarga';

  @override
  String get enterLastName => 'Masukkan Nama Keluarga';

  @override
  String get whatAreYourConcerns => 'Apakah Kebimbangan Anda?';

  @override
  String get writeConcernsHere => 'Tulis Kebimbangan Di Sini...';

  @override
  String pleaseEnter(Object field) {
    return 'Sila masukkan $field';
  }

  @override
  String get faqQuestion1 => 'Adakah isyarat memastikan kadar kejayaan 100%?';

  @override
  String get faqAnswer1 =>
      'Walaupun tiada isyarat boleh dijamin 100%, Signal GPT berusaha untuk mengekalkan kadar kejayaan stabil 60–80%, disokong oleh analisis terperinci dan pengurusan risiko supaya anda boleh membuat keputusan muktamad dengan lebih yakin.';

  @override
  String get faqQuestion2 =>
      'Jika saya tidak mahu deposit serta-merta, bolehkah saya masih menerima cadangan isyarat?';

  @override
  String get faqAnswer2 =>
      'Apabila membuka akaun, sistem akan menghadiahkan anda 10 token percuma, bersamaan dengan 10 pandangan isyarat terperinci. Selepas itu, anda akan menerima 1 token tambahan setiap hari untuk digunakan. Jika anda menaik taraf ke akaun VIP, anda akan membuka kunci banyak ciri canggih dan menjejaki jumlah pesanan tanpa had.';

  @override
  String get faqQuestion3 =>
      'Jika saya telah mendaftar tetapi belum menerima sebarang isyarat, apakah langkah yang perlu saya ambil?';

  @override
  String get faqAnswer3 =>
      'Pemprosesan biasanya automatik. Jika anda masih tidak melihat sebarang cadangan isyarat, sila hubungi kami melalui Whatsapp untuk bantuan segera.';

  @override
  String get faqQuestion4 =>
      'Berapa banyak isyarat yang akan saya terima sehari apabila menaik taraf ke akaun VIP?';

  @override
  String get faqAnswer4 =>
      'Apabila menaik taraf ke akaun VIP, anda akan menerima isyarat perdagangan tanpa had setiap hari. Jumlah isyarat tidak tetap tetapi bergantung sepenuhnya pada analisis pasaran. Setiap kali titik kemasukan berkualiti tinggi dan berkebarangkalian tinggi muncul, pasukan analisis akan menghantar isyarat kepada anda dengan serta-merta.';

  @override
  String get priceLevels => 'Tahap Harga';

  @override
  String get capitalManagement => 'Pengurusan Modal';

  @override
  String freeSignalsLeft(Object count) {
    return '$count isyarat percuma tinggal';
  }

  @override
  String get unlimitedSignals => 'Isyarat tanpa had';

  @override
  String get goBack => 'Kembali';

  @override
  String get goldPlan => 'Pelan Emas';

  @override
  String get perMonth => '/ bulan';

  @override
  String get continuouslyUpdating =>
      'Mengemas kini data pasaran secara berterusan 24/7';

  @override
  String get providingBestSignals =>
      'Menyediakan isyarat terbaik dalam masa nyata';

  @override
  String get includesEntrySlTp => 'Termasuk Kemasukan, SL, TP';

  @override
  String get detailedAnalysis =>
      'Analisis dan penilaian terperinci setiap isyarat';

  @override
  String get realTimeNotifications => 'Pemberitahuan masa nyata melalui e-mel';

  @override
  String get signalPerformanceStats => 'Statistik prestasi isyarat';

  @override
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails =>
      'Nombor Pendaftaran Perniagaan: 0110057263';

  @override
  String get addressDetails =>
      'Alamat: No. 8 Do Hanh Street, Hai Ba Trung Ward, Bandar Hanoi, Vietnam';

  @override
  String get pagesTitle => 'Halaman';

  @override
  String get legalRegulatoryTitle => 'Undang-undang & Kawal Selia';

  @override
  String get termsOfRegistration => 'Syarat Pendaftaran';

  @override
  String get operatingPrinciples => 'Prinsip Operasi';

  @override
  String get termsConditions => 'Syarat & Ketentuan';

  @override
  String get contactTitle => 'Hubungi';

  @override
  String get navFeatures => 'Ciri';

  @override
  String get navNews => 'Berita';

  @override
  String get tp1Hit => 'TP1 Kena';

  @override
  String get tp2Hit => 'TP2 Kena';

  @override
  String get tp3Hit => 'TP3 Kena';

  @override
  String get slHit => 'SL Kena';

  @override
  String get cancelled => 'Dibatalkan';

  @override
  String get exitedByAdmin => 'Dikeluarkan oleh Admin';

  @override
  String get signalClosed => 'Ditutup';

  @override
  String get errorLoadingPackages => 'Ralat Memuatkan Pakej';

  @override
  String get monthly => 'Bulanan';

  @override
  String get annually => 'Tahunan';

  @override
  String get whatsIncluded => 'Apa yang disertakan:';

  @override
  String get chooseThisPlan => 'Pilih pelan ini';

  @override
  String get bestPricesForPremiumAccess => 'Harga Terbaik untuk Akses Premium';

  @override
  String get choosePlanFitsNeeds =>
      'Pilih pelan yang sesuai dengan keperluan perniagaan anda dan mula mengautomasikan dengan AI';

  @override
  String get save50Percent => 'JIMAT 50%';

  @override
  String get tryDemo => 'Cuba demo';

  @override
  String get pleaseEnterEmailPassword => 'Sila masukkan e-mel dan kata laluan';

  @override
  String loginFailed(String error) {
    return 'Log masuk gagal: $error';
  }

  @override
  String get welcomeBack => 'Selamat Kembali';

  @override
  String get signInToContinue => 'Log masuk ke akaun anda untuk meneruskan';

  @override
  String get or => 'atau';

  @override
  String get email => 'E-mel';

  @override
  String get emailHint => 'contoh123@gmail.com';

  @override
  String get password => 'Kata Laluan';

  @override
  String get enterPassword => 'Masukkan Kata Laluan';

  @override
  String get forgotPassword => 'Lupa kata laluan anda?';

  @override
  String get createNewAccount => 'Buat akaun baharu di sini!';

  @override
  String get signUp => 'Daftar';

  @override
  String get signUpAccount => 'Daftar Akaun';

  @override
  String get enterPersonalData =>
      'Masukkan data peribadi anda untuk membuat akaun anda';

  @override
  String get nameLabel => 'Nama *';

  @override
  String get enterNameHint => 'Masukkan Nama';

  @override
  String get emailLabel => 'E-mel *';

  @override
  String get passwordLabel => 'Kata Laluan *';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get continueButton => 'Teruskan';

  @override
  String get fillAllFields => 'Sila isi semua medan yang diperlukan.';

  @override
  String get accountCreatedSuccess => 'Akaun berjaya dibuat.';

  @override
  String signUpFailed(String error) {
    return 'Pendaftaran gagal: $error';
  }

  @override
  String get nationality => 'Warganegara:';

  @override
  String get overview => 'Gambaran Keseluruhan';

  @override
  String get setting => 'Tetapan';

  @override
  String get paymentHistory => 'Sejarah Pembayaran';

  @override
  String get signalsPlan => 'Pelan Isyarat';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => 'Token Anda';

  @override
  String get emailNotificationPreferences => 'Keutamaan Pemberitahuan E-mel';

  @override
  String get chooseSignalNotificationTypes =>
      'Pilih jenis pemberitahuan isyarat yang anda mahu terima melalui e-mel';

  @override
  String get allSignalNotifications => 'Semua Pemberitahuan Isyarat';

  @override
  String get cryptoSignals => 'Isyarat Kripto';

  @override
  String get forexSignals => 'Isyarat Forex';

  @override
  String get goldSignals => 'Isyarat Emas';

  @override
  String get updatePasswordSecure =>
      'Kemas kini kata laluan anda untuk memastikan akaun anda selamat';

  @override
  String get searchLabel => 'Cari:';

  @override
  String get filterBy => 'Tapis mengikut:';

  @override
  String get allTime => 'Sepanjang Masa';

  @override
  String get startDate => 'Tarikh Mula:';

  @override
  String get endDate => 'Tarikh Tamat:';

  @override
  String get deactivate => 'Nyahaktifkan';

  @override
  String get unlimited => 'Tanpa had';

  @override
  String get tenLeft => '10 tinggal';

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
  String get performance => 'Prestasi';

  @override
  String get minvestSupport => 'Sokongan Minvest';

  @override
  String get leaveMessagePart1 =>
      'Sila tinggalkan mesej, pasukan kami akan membalas secepat mungkin. Anda juga boleh menghubungi ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 untuk sokongan pantas.';

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
  String get signInRequired => 'Log Masuk Diperlukan';

  @override
  String get signInToExploreSignal =>
      'Log masuk untuk meneroka isyarat dagangan ini!';
}
