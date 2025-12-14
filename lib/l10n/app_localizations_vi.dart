// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'NÂNG CẤP TÀI KHOẢN THÀNH CÔNG';

  @override
  String get lotPerWeek => 'Lot/tuần';

  @override
  String get tableValueFull => 'đầy đủ';

  @override
  String get tableValueFulltime => 'toàn thời gian';

  @override
  String get packageTitle => 'GÓI DỊCH VỤ';

  @override
  String get duration1Month => '1 tháng';

  @override
  String get duration12Months => '12 tháng';

  @override
  String get featureReceiveAllSignals => 'Nhận tất cả tín hiệu trong ngày';

  @override
  String get featureAnalyzeReason => 'Phân tích lý do vào lệnh';

  @override
  String get featureHighPrecisionAI => 'Tín hiệu AI độ chính xác cao';

  @override
  String get iapStoreNotAvailable =>
      'Cửa hàng không khả dụng trên thiết bị này.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'Lỗi tải sản phẩm: $message';
  }

  @override
  String get iapNoProductsFound =>
      'Không tìm thấy sản phẩm nào. Vui lòng kiểm tra lại cấu hình trên cửa hàng.';

  @override
  String iapTransactionError(Object message) {
    return 'Lỗi giao dịch: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'Lỗi xác thực: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'Đã xảy ra lỗi không xác định: $error';
  }

  @override
  String get iapProcessingTransaction => 'Đang xử lý giao dịch...';

  @override
  String get orderInfo1Month => 'Thanh toán gói Elite 1 tháng';

  @override
  String get orderInfo12Months => 'Thanh toán gói Elite 12 tháng';

  @override
  String get iapNotSupportedOnWeb =>
      'Thanh toán trong ứng dụng không được hỗ trợ trên phiên bản web.';

  @override
  String get vnpayPaymentTitle => 'THANH TOÁN VNPAY';

  @override
  String get creatingOrderWait => 'Đang tạo đơn hàng, vui lòng chờ...';

  @override
  String errorWithMessage(Object message) {
    return 'Lỗi: $message';
  }

  @override
  String get cannotConnectToServer =>
      'Không thể kết nối đến máy chủ. Vui lòng thử lại.';

  @override
  String get transactionCancelledOrFailed =>
      'Giao dịch đã bị hủy hoặc thất bại.';

  @override
  String get cannotCreatePaymentLink =>
      'Không thể tạo link thanh toán.\nVui lòng thử lại.';

  @override
  String get retry => 'Thử lại';

  @override
  String serverErrorRetry(Object message) {
    return 'Lỗi từ máy chủ: $message. Vui lòng thử lại.';
  }

  @override
  String get redirectingToPayment =>
      'Đang chuyển hướng đến trang thanh toán...';

  @override
  String get invalidPaymentUrl =>
      'URL thanh toán không hợp lệ nhận từ máy chủ.';

  @override
  String get processingYourAccount => 'Đang xử lý tài khoản của bạn...';

  @override
  String get verificationFailed => 'Xác thực Thất bại!';

  @override
  String get reuploadImage => 'Tải lại ảnh';

  @override
  String get accountNotLinked => 'Tài khoản chưa liên kết với Minvest';

  @override
  String get accountNotLinkedDesc =>
      'Để nhận tín hiệu độc quyền, tài khoản Exness của bạn phải được đăng ký qua liên kết đối tác của Minvest. Vui lòng tạo tài khoản mới bằng liên kết bên dưới.';

  @override
  String get registerExnessViaMinvest => 'Đăng ký Exness qua Minvest';

  @override
  String get iHaveRegisteredReupload => 'Tôi đã đăng ký, tải lại ảnh';

  @override
  String couldNotLaunch(Object url) {
    return 'Không thể mở $url';
  }

  @override
  String get status => 'Trạng thái';

  @override
  String get sentOn => 'Gửi lúc';

  @override
  String get entryPrice => 'Giá vào lệnh';

  @override
  String get stopLossFull => 'Dừng lỗ';

  @override
  String get takeProfitFull1 => 'Chốt lời 1';

  @override
  String get takeProfitFull2 => 'Chốt lời 2';

  @override
  String get takeProfitFull3 => 'Chốt lời 3';

  @override
  String get noReasonProvided =>
      'Không có lý do nào được cung cấp cho tín hiệu này.';

  @override
  String get upgradeToViewReason =>
      'Nâng cấp tài khoản lên Elite để xem phân tích.';

  @override
  String get upgradeToViewFullAnalysis =>
      'Nâng cấp tài khoản lên Elite để xem phân tích.';

  @override
  String get welcomeTo => 'Chào mừng đến với';

  @override
  String get appSlogan =>
      'Nâng cao giao dịch của bạn với các tín hiệu thông minh.';

  @override
  String get signIn => 'Đăng nhập';

  @override
  String get continueByGoogle => 'Tiếp tục với Google';

  @override
  String get continueByFacebook => 'Tiếp tục với Facebook';

  @override
  String get continueByApple => 'Tiếp tục với Apple';

  @override
  String get loginSuccess => 'Đăng nhập thành công!';

  @override
  String get live => 'TRỰC TIẾP';

  @override
  String get end => 'KẾT THÚC';

  @override
  String get symbol => 'CẶP TIỀN';

  @override
  String get aiSignal => 'TÍN HIỆU AI';

  @override
  String get ruleSignal => 'TÍN HIỆU RULE';

  @override
  String get all => 'TẤT CẢ';

  @override
  String get upgradeToSeeMore => 'Nâng cấp để xem thêm';

  @override
  String get seeDetails => 'xem chi tiết';

  @override
  String get notMatched => 'CHƯA KHỚP';

  @override
  String get matched => 'ĐÃ KHỚP';

  @override
  String get entry => 'Vào lệnh';

  @override
  String get stopLoss => 'Dừng lỗ';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'Nâng cấp';

  @override
  String get upgradeAccount => 'NÂNG CẤP TÀI KHOẢN';

  @override
  String get compareTiers => 'SO SÁNH CÁC HẠNG';

  @override
  String get feature => 'Tính năng';

  @override
  String get tierDemo => 'Demo';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'Số dư';

  @override
  String get signalTime => 'Giờ tín hiệu';

  @override
  String get signalQty => 'Số lượng tín hiệu';

  @override
  String get analysis => 'Phân tích';

  @override
  String get openExnessAccount => 'Mở tài khoản Exness!';

  @override
  String get accountVerificationWithExness => 'Xác thực tài khoản với Exness';

  @override
  String get payInAppToUpgrade => 'Thanh toán trong ứng dụng';

  @override
  String get bankTransferToUpgrade => 'Chuyển khoản Ngân hàng để Nâng cấp';

  @override
  String get accountVerification => 'XÁC THỰC TÀI KHOẢN';

  @override
  String get accountVerificationPrompt =>
      'Vui lòng tải lên ảnh chụp màn hình tài khoản Exness của bạn để được cấp quyền (tài khoản của bạn phải được mở dưới liên kết của Minvest)';

  @override
  String get selectPhotoFromLibrary => 'Chọn ảnh từ thư viện';

  @override
  String get send => 'Gửi';

  @override
  String get accountInfo => 'Thông Tin Tài Khoản';

  @override
  String get accountVerifiedSuccessfully => 'XÁC THỰC TÀI KHOẢN THÀNH CÔNG';

  @override
  String get yourAccountIs => 'Tài khoản của bạn là';

  @override
  String get returnToHomePage => 'Quay về trang chủ';

  @override
  String get upgradeFailed => 'Nâng cấp thất bại! Vui lòng tải lại ảnh';

  @override
  String get package => 'GÓI DỊCH VỤ';

  @override
  String get startNow => 'BẮT ĐẦU NGAY';

  @override
  String get bankTransfer => 'CHUYỂN KHOẢN';

  @override
  String get transferInformation => 'THÔNG TIN CHUYỂN KHOẢN';

  @override
  String get scanForFastTransfer => 'Quét để chuyển khoản nhanh';

  @override
  String get contactUs247 => 'Liên hệ chúng tôi 24/7';

  @override
  String get newAnnouncement => 'THÔNG BÁO MỚI';

  @override
  String get profile => 'Hồ sơ';

  @override
  String get upgradeNow => 'Nâng cấp ngay';

  @override
  String get followMinvest => 'Theo dõi MInvest';

  @override
  String get tabSignal => 'Tín hiệu';

  @override
  String get tabChart => 'Biểu đồ';

  @override
  String get tabProfile => 'Hồ sơ';

  @override
  String get reason => 'LÝ DO';

  @override
  String get error => 'Lỗi';

  @override
  String get noSignalsAvailable => 'Không có tín hiệu nào.';

  @override
  String get outOfGoldenHours => 'Ngoài Giờ Vàng Giao Dịch';

  @override
  String get outOfGoldenHoursVipDesc =>
      'Tín hiệu VIP chỉ có từ 8:00 - 17:00 (GMT+7).\nNâng cấp lên Elite để nhận tín hiệu 24/24!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'Tín hiệu Demo chỉ có từ 8:00 - 17:00 (GMT+7).\nNâng cấp tài khoản để có thêm quyền lợi!';

  @override
  String get yourName => 'Tên của bạn';

  @override
  String get yourEmail => 'your.email@example.com';

  @override
  String get adminPanel => 'Bảng quản trị';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get confirmLogout => 'Xác nhận Đăng xuất';

  @override
  String get confirmLogoutMessage => 'Bạn có chắc chắn muốn đăng xuất không?';

  @override
  String get cancel => 'Hủy';

  @override
  String get upgradeCardTitle => 'NÂNG CẤP TÀI KHOẢN';

  @override
  String get upgradeCardSubtitle => 'Để truy cập nhiều tài nguyên hơn';

  @override
  String get upgradeCardSubtitleWeb =>
      'Để mở khóa tín hiệu cao cấp và hỗ trợ toàn thời gian';

  @override
  String get subscriptionDetails => 'Chi tiết Gói đăng ký';

  @override
  String get notifications => 'Thông báo';

  @override
  String get continueAsGuest => 'Tiếp tục với tư cách khách';

  @override
  String get deleteAccount => 'Xóa tài khoản';

  @override
  String get deleteAccountWarning =>
      'Bạn có chắc chắn muốn xóa tài khoản không? Mọi dữ liệu của bạn sẽ bị xóa vĩnh viễn và không thể khôi phục.';

  @override
  String get delete => 'Xóa';

  @override
  String get privacyPolicy => 'Chính sách bảo mật';

  @override
  String get termsOfService => 'Điều khoản dịch vụ';

  @override
  String get signalStatusMatched => 'ĐÃ KHỚP';

  @override
  String get signalStatusNotMatched => 'CHƯA KHỚP';

  @override
  String get signalStatusCancelled => 'ĐÃ HỦY';

  @override
  String get signalStatusSlHit => 'TRÚNG SL';

  @override
  String get signalStatusTp1Hit => 'TRÚNG TP1';

  @override
  String get signalStatusTp2Hit => 'TRÚNG TP2';

  @override
  String get signalStatusTp3Hit => 'TRÚNG TP3';

  @override
  String get signalStatusRunning => 'ĐANG CHẠY';

  @override
  String get signalStatusClosed => 'ĐÃ ĐÓNG';

  @override
  String get contactUs => 'Liên hệ';

  @override
  String get tabChat => 'Trò chuyện';

  @override
  String get exnessUpgradeNoteForIos =>
      'Đối với khách hàng đã đăng ký tài khoản Exness qua Minvest thì vui lòng bấm liên hệ chúng tôi để được nâng cấp tài khoản.';

  @override
  String get chatWelcomeTitle => '👋 Chào mừng bạn đến với Minvest AI!';

  @override
  String get chatWelcomeBody1 =>
      'Hãy để lại tin nhắn, đội ngũ của chúng tôi sẽ phản hồi sớm nhất.';

  @override
  String get chatWelcomeBody2 => 'Hoặc liên hệ trực tiếp qua Zalo/WhatsApp: ';

  @override
  String get chatWelcomeBody3 => ' để được hỗ trợ nhanh hơn nhé!';

  @override
  String get chatLoginPrompt => 'Vui lòng đăng nhập để sử dụng tính năng này';

  @override
  String get chatStartConversation => 'Bắt đầu cuộc trò chuyện của bạn';

  @override
  String get chatNoMessages => 'Chưa có tin nhắn nào.';

  @override
  String get chatTypeMessage => 'Nhập tin nhắn...';

  @override
  String get chatSupportIsTyping => 'Hỗ trợ đang trả lời...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName đang trả lời...';
  }

  @override
  String get chatSeen => 'Đã xem';

  @override
  String get chatDefaultUserName => 'Người dùng';

  @override
  String get chatDefaultSupportName => 'Hỗ trợ';

  @override
  String get signalEntry => 'Vùng vào lệnh';

  @override
  String get price1Month => '2.056.080đ';

  @override
  String get price12Months => '12.652.789đ';

  @override
  String get foreignTraderSupport =>
      'Đối với nhà giao dịch nước ngoài, vui lòng liên hệ chúng tôi qua WhatsApp (+84969.15.6969) để được hỗ trợ';

  @override
  String get signalSl => 'Dừng lỗ';

  @override
  String get upgradeToSeeDetails => 'Nâng cấp để xem chi tiết tín hiệu...';

  @override
  String get buy => 'MUA';

  @override
  String get sell => 'BÁN';

  @override
  String get logoutDialogTitle => 'Phiên đăng nhập hết hạn';

  @override
  String get logoutDialogDefaultReason =>
      'Tài khoản của bạn đã được đăng nhập trên một thiết bị khác.';

  @override
  String get ok => 'OK';

  @override
  String get contactToUpgrade => 'Liên hệ để nâng cấp';

  @override
  String get noNotificationsYet => 'Chưa có thông báo nào.';

  @override
  String daysAgo(int count) {
    return '$count ngày trước';
  }

  @override
  String hoursAgo(int count) {
    return '$count giờ trước';
  }

  @override
  String minutesAgo(int count) {
    return '$count phút trước';
  }

  @override
  String get justNow => 'Vừa xong';

  @override
  String get getSignalsNow => 'Nhận Tín Hiệu Ngay';

  @override
  String get freeTrial => 'Dùng Thử Miễn Phí';

  @override
  String get heroTitle => 'Dẫn Lối Nhà Giao Dịch & Phát Triển Danh Mục Đầu Tư';

  @override
  String get heroSubtitle =>
      'Công Nghệ AI Tối Ưu – Được Thiết Kế Bởi Các Chuyên Gia Giao Dịch';

  @override
  String get globalAiInnovationTitle =>
      'Đổi Mới AI Toàn Cầu Cho Thế Hệ Trí Tuệ Giao Dịch Tiếp Theo';

  @override
  String get globalAiInnovationDesc =>
      'Chuyển đổi giao dịch truyền thống bằng tín hiệu AI hỗ trợ đám mây — thích ứng với tin tức và xu hướng thị trường theo thời gian thực để có hiệu suất nhanh hơn, chính xác hơn và không cảm xúc.';

  @override
  String get liveTradingSignalsTitle =>
      'TRỰC TIẾP – Tín Hiệu Giao Dịch AI 24/7';

  @override
  String get liveTradingSignalsDesc =>
      'Phân tích đám mây theo thời gian thực cung cấp các chiến lược theo xu hướng, xác suất cao với độ chính xác thích ứng và thực hiện không cảm xúc.';

  @override
  String get trendFollowing => 'Theo Xu Hướng';

  @override
  String get realtime => 'Thời Gian Thực';

  @override
  String get orderExplanationEngineTitle => 'Công Cụ Giải Thích Lệnh';

  @override
  String get orderExplanationEngineDesc =>
      'Giải thích các thiết lập giao dịch một cách đơn giản — chỉ ra cách các điểm hội tụ hình thành, lý do vào lệnh và giúp nhà giao dịch học hỏi từ mỗi quyết định.';

  @override
  String get transparent => 'Minh Bạch';

  @override
  String get educational => 'Mang Tính Giáo Dục';

  @override
  String get logical => 'Hợp Lý';

  @override
  String get transparentRealPerformanceTitle => 'Minh Bạch - Hiệu Suất Thực';

  @override
  String get transparentRealPerformanceDesc =>
      'Xem dữ liệu thực về độ chính xác của tín hiệu, tỷ lệ thành công và khả năng sinh lời — được xác minh và có thể theo dõi trong mọi giao dịch';

  @override
  String get results => 'Kết Quả';

  @override
  String get performanceTracking => 'Theo Dõi Hiệu Suất';

  @override
  String get accurate => 'Chính Xác';

  @override
  String get predictiveAccuracy => 'Độ Chính Xác Dự Đoán';

  @override
  String get improvementInProfitability => 'Cải Thiện Khả Năng Sinh Lời';

  @override
  String get improvedRiskManagement => 'Quản Lý Rủi Ro Nâng Cao';

  @override
  String get signalsPerformanceTitle => 'Hiệu Suất Tín Hiệu';

  @override
  String get riskToRewardRatio => 'Tỷ Lệ Rủi Ro/Lợi Nhuận';

  @override
  String get howRiskComparesToReward => 'Rủi Ro So Với Lợi Nhuận';

  @override
  String get profitLossOverview => 'Tổng Quan Lãi/Lỗ';

  @override
  String get netGainVsLoss => 'Lãi Ròng so với Lỗ';

  @override
  String get winRate => 'Tỷ Lệ Thắng';

  @override
  String get percentageOfWinningTrades => 'Tỷ Lệ Giao Dịch Thắng';

  @override
  String get accuracyRate => 'Tỷ Lệ Chính Xác';

  @override
  String get howPreciseOurSignalsAre => 'Độ Chính Xác Của Tín Hiệu';

  @override
  String get realtimeMarketAnalysis => 'Phân Tích Thị Trường Thời Gian Thực';

  @override
  String get realtimeMarketAnalysisDesc =>
      'AI của chúng tôi liên tục theo dõi thị trường, xác định các vùng hội tụ kỹ thuật và điểm đột phá đáng tin cậy để bạn có thể vào lệnh đúng thời điểm.';

  @override
  String get saveTimeOnAnalysis => 'Tiết Kiệm Thời Gian Phân Tích';

  @override
  String get saveTimeOnAnalysisDesc =>
      'Không còn tốn hàng giờ đọc biểu đồ. Nhận các chiến lược đầu tư phù hợp chỉ trong vài phút mỗi ngày.';

  @override
  String get minimizeEmotionalTrading => 'Giảm Thiểu Giao Dịch Cảm Tính';

  @override
  String get minimizeEmotionalTradingDesc =>
      'Với các cảnh báo thông minh, phát hiện rủi ro và tín hiệu dựa trên dữ liệu chứ không phải cảm xúc, bạn luôn kỷ luật và kiểm soát mọi quyết định.';

  @override
  String get seizeEveryOpportunity => 'Nắm Bắt Mọi Cơ Hội';

  @override
  String get seizeEveryOpportunityDesc =>
      'Các cập nhật chiến lược kịp thời được gửi thẳng vào hộp thư đến của bạn đảm bảo bạn nắm bắt xu hướng thị trường vào thời điểm hoàn hảo.';

  @override
  String get minvestAiCoreValueTitle => 'Minvest AI - Giá Trị Cốt Lõi';

  @override
  String get minvestAiCoreValueDesc =>
      'AI phân tích dữ liệu thị trường theo thời gian thực liên tục, lọc ra các thông tin chi tiết để xác định cơ hội đầu tư nhanh chóng, chính xác.';

  @override
  String get frequentlyAskedQuestions => 'Các Câu Hỏi Thường Gặp';

  @override
  String get maximizeResultsTitle =>
      'Tối Đa Hóa Kết Quả Với Phân Tích Thị Trường Nâng Cao Và Tín Hiệu Lọc Chính Xác Của Minvest AI';

  @override
  String get elevateTradingWithAiStrategies =>
      'Nâng Tầm Giao Dịch Với Các Chiến Lược Nâng Cao Bằng AI Được Xây Dựng Để Có Sự Nhất Quán Và Rõ Ràng';

  @override
  String get winMoreWithAiSignalsTitle =>
      'Chiến Thắng Nhiều Hơn Với Tín Hiệu AI\nTrên Mọi Thị Trường';

  @override
  String get winMoreWithAiSignalsDesc =>
      'AI đa thị trường của chúng tôi quét Forex, Tiền điện tử và Kim loại theo thời gian thực,\ncung cấp các tín hiệu giao dịch được chuyên gia xác nhận —\nvới các mức vào lệnh, dừng lỗ và chốt lời rõ ràng';

  @override
  String get buyLimit => 'Lệnh Mua Giới Hạn';

  @override
  String get sellLimit => 'Lệnh Bán Giới Hạn';

  @override
  String get smarterToolsTitle => 'Công Cụ Thông Minh Hơn - Đầu Tư Tốt Hơn';

  @override
  String get smarterToolsDesc =>
      'Khám phá các tính năng giúp bạn giảm thiểu rủi ro, nắm bắt cơ hội và gia tăng tài sản';

  @override
  String get performanceOverviewTitle => 'Tổng Quan Hiệu Suất';

  @override
  String get performanceOverviewDesc =>
      'AI đa thị trường của chúng tôi quét Forex, Tiền điện tử và Kim loại theo thời gian thực, cung cấp các tín hiệu giao dịch được chuyên gia xác nhận - với các mức vào lệnh, dừng lỗ và chốt lời rõ ràng';

  @override
  String get totalProfit => 'Tổng Lợi Nhuận';

  @override
  String get completionSignal => 'Tín Hiệu Hoàn Thành';

  @override
  String get onDemandFinancialExpertTitle =>
      'Chuyên Gia Tài Chính Theo Yêu Cầu Của Bạn';

  @override
  String get onDemandFinancialExpertDesc =>
      'Nền tảng AI gợi ý các tín hiệu giao dịch - tự học, phân tích thị trường 24/7, không bị ảnh hưởng bởi cảm xúc. Minvest đã hỗ trợ hơn 10.000 nhà phân tích tài chính\ntrong hành trình tìm kiếm các tín hiệu chính xác, ổn định và dễ áp dụng';

  @override
  String get aiPoweredSignalPlatform => 'Nền Tảng Tín Hiệu Giao Dịch Hỗ Trợ AI';

  @override
  String get selfLearningSystems =>
      'Hệ Thống Tự Học, Thông Tin Chi Tiết Sắc Bén, Giao Dịch Mạnh Mẽ Hơn';

  @override
  String get emotionlessExecution =>
      'Thực Thi Không Cảm Xúc Để Giao Dịch Thông Minh Hơn,\nKỷ Luật Hơn';

  @override
  String get analysingMarket247 => 'Phân Tích Thị Trường 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Tối Đa Hóa Kết Quả Với Phân Tích Thị Trường Nâng Cao Và Tín Hiệu Lọc Chính Xác Của Minvest AI';

  @override
  String get minvestAiRegistrationDesc =>
      'Đăng ký Minvest AI hiện đang mở — các suất có thể sẽ sớm đóng lại khi chúng tôi xem xét và phê duyệt các thành viên mới';

  @override
  String get currencyPairs => 'Cặp tiền tệ';

  @override
  String get allCurrencyPairs => 'Tất cả cặp tiền';

  @override
  String get dateRange => 'Khoảng thời gian';

  @override
  String get selectDateRange => 'Chọn khoảng thời gian';

  @override
  String get allAssets => 'Tất cả tài sản';

  @override
  String get asset => 'Tài sản';

  @override
  String get tokenExpired => 'Token đã hết';

  @override
  String get tokenLimitReachedDesc =>
      'Bạn đã dùng hết 10 tokens miễn phí hôm nay. Nâng cấp gói để xem thêm tín hiệu.';

  @override
  String get later => 'Để sau';

  @override
  String get created => 'Đã tạo';

  @override
  String get detail => 'Chi tiết';

  @override
  String get performanceOverview => 'Tổng quan hiệu suất';

  @override
  String get totalProfitPips => 'Tổng lợi nhuận (Pips)';

  @override
  String get winRatePercent => 'Tỷ lệ thắng (%)';

  @override
  String get comingSoon => 'Sắp ra mắt';

  @override
  String get errorLoadingHistory => 'Lỗi tải lịch sử';

  @override
  String get noHistoryAvailable => 'Chưa có lịch sử tín hiệu';

  @override
  String get previous => 'Trước';

  @override
  String get page => 'Trang';

  @override
  String get next => 'Tiếp';

  @override
  String get date => 'Ngày';

  @override
  String get timeGmt7 => 'Thời gian (GMT +7)';

  @override
  String get orders => 'Lệnh';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      'Màn hình nhỏ: xoay ngang hoặc cuộn ngang để xem đầy đủ bảng.';

  @override
  String get history => 'Lịch sử';

  @override
  String get signalsWillAppearHere => 'Tín hiệu sẽ xuất hiện ở đây khi có sẵn';

  @override
  String get pricing => 'Bảng giá';

  @override
  String get choosePlanSubtitle => 'Chọn gói phù hợp với bạn';

  @override
  String get financialNewsHub => 'Trung tâm Tin tức Tài chính';

  @override
  String get financialNewsHubDesc =>
      'Cập nhật quan trọng. Phản ứng thị trường. Không nhiễu loạn – chỉ những gì nhà đầu tư cần biết.';

  @override
  String get newsTabAllArticles => 'Tất cả bài viết';

  @override
  String get newsTabInvestor => 'Nhà đầu tư';

  @override
  String get newsTabKnowledge => 'Kiến thức';

  @override
  String get newsTabTechnicalAnalysis => 'Phân tích kỹ thuật';

  @override
  String noArticlesForCategory(Object category) {
    return 'Chưa có bài viết cho mục $category';
  }

  @override
  String get mostPopular => 'Phổ biến nhất';

  @override
  String get noPosts => 'Không có bài viết';

  @override
  String get relatedArticles => 'Bài viết liên quan';

  @override
  String get contactInfoSentSuccess => 'Đã gửi thông tin liên hệ thành công.';

  @override
  String contactInfoSentFailed(Object error) {
    return 'Gửi thông tin thất bại: $error';
  }

  @override
  String get contactPageSubtitle =>
      'Có câu hỏi hoặc cần giải pháp AI? Hãy cho chúng tôi biết bằng cách điền vào biểu mẫu và chúng tôi sẽ liên hệ lại với bạn!';

  @override
  String get phone => 'Điện thoại';

  @override
  String get firstName => 'Tên';

  @override
  String get enterFirstName => 'Nhập tên';

  @override
  String get lastName => 'Họ';

  @override
  String get enterLastName => 'Nhập họ';

  @override
  String get whatAreYourConcerns => 'Vấn đề của bạn là gì?';

  @override
  String get writeConcernsHere => 'Viết vấn đề của bạn tại đây...';

  @override
  String pleaseEnter(Object field) {
    return 'Vui lòng nhập $field';
  }

  @override
  String get faqQuestion1 =>
      'Các tín hiệu có đảm bảo tỷ lệ thành công 100% không?';

  @override
  String get faqAnswer1 =>
      'Mặc dù không có tín hiệu nào có thể đảm bảo 100%, Minvest AI cố gắng duy trì tỷ lệ thành công ổn định từ 60–80%, được hỗ trợ bởi phân tích chi tiết và quản lý rủi ro để bạn có thể đưa ra quyết định cuối cùng với sự tự tin cao hơn.';

  @override
  String get faqQuestion2 =>
      'Nếu tôi không muốn nạp tiền ngay, tôi có thể nhận gợi ý tín hiệu không?';

  @override
  String get faqAnswer2 =>
      'Có. Chỉ cần tạo tài khoản Exness thông qua liên kết Minvest, bạn sẽ có quyền truy cập vào nhóm tín hiệu demo miễn phí của chúng tôi (Community VIP).';

  @override
  String get faqQuestion3 =>
      'Nếu tôi đã đăng ký nhưng chưa nhận được bất kỳ tín hiệu nào, tôi nên làm gì?';

  @override
  String get faqAnswer3 =>
      'Quá trình xử lý thường tự động. Nếu bạn vẫn không thấy bất kỳ gợi ý tín hiệu nào, vui lòng liên hệ với chúng tôi qua Whatsapp để được hỗ trợ ngay lập tức.';

  @override
  String get faqQuestion4 =>
      'Tôi vẫn có thể tham gia nếu tôi không đăng ký tài khoản Exness không?';

  @override
  String get faqAnswer4 =>
      'Vui lòng liên hệ với chúng tôi qua WhatsApp hoặc Live Chat để được hỗ trợ.';

  @override
  String get priceLevels => 'Mức giá';

  @override
  String get capitalManagement => 'Quản lý vốn';

  @override
  String freeSignalsLeft(Object count) {
    return 'Còn lại $count tín hiệu miễn phí';
  }

  @override
  String get unlimitedSignals => 'Tín hiệu không giới hạn';

  @override
  String get goBack => 'Quay lại';

  @override
  String get goldPlan => 'Gói Vàng';

  @override
  String get perMonth => '/tháng';

  @override
  String get continuouslyUpdating =>
      'Cập nhật dữ liệu thị trường liên tục 24/7';

  @override
  String get providingBestSignals =>
      'Cung cấp tín hiệu tốt nhất theo thời gian thực';

  @override
  String get includesEntrySlTp => 'Bao gồm Điểm vào, SL, TP';

  @override
  String get detailedAnalysis => 'Phân tích và đánh giá chi tiết từng tín hiệu';

  @override
  String get realTimeNotifications => 'Thông báo thời gian thực qua email';

  @override
  String get signalPerformanceStats => 'Thống kê hiệu suất tín hiệu';

  @override
  String get enterpriseCodeDetails =>
      'Mã số doanh nghiệp: 0107136243 do Sở Tài chính Hà Nội cấp ngày 24/11/2015; sửa đổi lần thứ 6 đăng ký bởi Sở Tài chính Hà Nội vào ngày 05/08/2025.';

  @override
  String get addressDetails =>
      'Địa chỉ: C2810, Tầng 18, Tòa nhà C2, Lô HH, Khu đô thị Đông Nam, Đường Trần Duy Hưng, Phường Yên Hòa, Hà Nội, Việt Nam.';

  @override
  String get pagesTitle => 'Trang';

  @override
  String get legalRegulatoryTitle => 'Pháp lý & Quy định';

  @override
  String get termsOfRegistration => 'Điều khoản đăng ký';

  @override
  String get operatingPrinciples => 'Nguyên tắc hoạt động';

  @override
  String get termsConditions => 'Điều khoản & Điều kiện';

  @override
  String get contactTitle => 'Liên hệ';

  @override
  String get navFeatures => 'Tính năng';

  @override
  String get navNews => 'Tin tức';

  @override
  String get tp1Hit => 'Chốt lời 1';

  @override
  String get tp2Hit => 'Chốt lời 2';

  @override
  String get tp3Hit => 'Chốt lời 3';

  @override
  String get slHit => 'Dừng lỗ';

  @override
  String get cancelled => 'Đã hủy';

  @override
  String get exitedByAdmin => 'Admin đóng lệnh';

  @override
  String get signalClosed => 'Đã đóng';

  @override
  String get errorLoadingPackages => 'Lỗi tải gói dịch vụ';
}
