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
  String get aiSignal => 'Tín hiệu AI';

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
  String get startNow => 'Nhận Tín Hiệu Ngay';

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
  String get chatWelcomeTitle => '👋 Chào mừng bạn đến với Signal GPT!';

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
  String get minvestAiCoreValueTitle => 'Signal GPT - Giá Trị Cốt Lõi';

  @override
  String get minvestAiCoreValueDesc =>
      'AI phân tích dữ liệu thị trường theo thời gian thực liên tục, lọc ra các thông tin chi tiết để xác định cơ hội đầu tư nhanh chóng, chính xác.';

  @override
  String get frequentlyAskedQuestions => 'Các Câu Hỏi Thường Gặp (FAQ)';

  @override
  String get faqSubtitle =>
      'Tất cả câu hỏi của bạn — từ cách tham gia, lợi ích, đến cách AI của chúng tôi hoạt động — đều được giải đáp ngay bên dưới. Nếu bạn vẫn còn thắc mắc, đừng ngần ngại nhắn tin cho chúng tôi qua Whatsapp';

  @override
  String get maximizeResultsTitle =>
      'Tối đa hóa kết quả của bạn với Signal GPT\nphân tích thị trường nâng cao và tín hiệu được lọc chính xác';

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
      'Tối Đa Hóa Kết Quả Với Phân Tích Thị Trường Nâng Cao Và Tín Hiệu Lọc Chính Xác Của Signal GPT';

  @override
  String get minvestAiRegistrationDesc =>
      'Đăng ký Signal GPT hiện đã mở — số lượng có hạn, có thể đóng sớm khi chúng tôi xem xét và chấp thuận thành viên mới.';

  @override
  String get currencyPairs => 'Sản phẩm';

  @override
  String get allCurrencyPairs => 'Tất cả cặp tiền';

  @override
  String get allCommodities => 'Tất cả sản phẩm';

  @override
  String get allCryptoPairs => 'Tất cả Crypto';

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
  String get timeGmt7 => 'Thời gian (GMT)';

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
      'Mặc dù không có tín hiệu nào có thể đảm bảo 100%, Signal GPT cố gắng duy trì tỷ lệ thành công ổn định từ 60–80%, được hỗ trợ bởi phân tích chi tiết và quản lý rủi ro để bạn có thể đưa ra quyết định cuối cùng với sự tự tin cao hơn.';

  @override
  String get faqQuestion2 =>
      'Nếu tôi không muốn nạp tiền ngay, tôi có thể nhận gợi ý tín hiệu không?';

  @override
  String get faqAnswer2 =>
      'Khi mở tài khoản, hệ thống sẽ tặng bạn 10 token miễn phí, tương đương 10 lần xem tín hiệu chi tiết. Sau đó, mỗi ngày bạn tiếp tục nhận thêm 1 token để sử dụng. Nếu nâng cấp lên tài khoản VIP, bạn sẽ được mở khóa nhiều tính năng nâng cao và theo dõi không giới hạn số lệnh.';

  @override
  String get faqQuestion3 =>
      'Nếu tôi đã đăng ký nhưng chưa nhận được bất kỳ tín hiệu nào, tôi nên làm gì?';

  @override
  String get faqAnswer3 =>
      'Quá trình xử lý thường tự động. Nếu bạn vẫn không thấy bất kỳ gợi ý tín hiệu nào, vui lòng liên hệ với chúng tôi qua Whatsapp để được hỗ trợ ngay lập tức.';

  @override
  String get faqQuestion4 =>
      'Khi nâng cấp lên tài khoản VIP, tôi sẽ nhận được bao nhiêu tín hiệu mỗi ngày?';

  @override
  String get faqAnswer4 =>
      'Khi nâng cấp lên tài khoản VIP, bạn sẽ được nhận tín hiệu giao dịch không giới hạn mỗi ngày. Số lượng tín hiệu không cố định, mà phụ thuộc hoàn toàn vào phân tích thị trường. Bất cứ khi nào xuất hiện điểm vào lệnh chất lượng, xác suất cao, đội ngũ phân tích sẽ gửi tín hiệu ngay cho bạn.';

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
  String get companyName => 'CÔNG TY TNHH ĐẦU TƯ CÔNG NGHỆ EZTRADE';

  @override
  String get enterpriseCodeDetails => 'Mã số doanh nghiệp: 0110057263';

  @override
  String get addressDetails =>
      'Địa chỉ: Số 8 phố Đỗ Hạnh, Phường Hai Bà Trưng, Thành Phố Hà Nội, Việt Nam';

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

  @override
  String get monthly => 'Hàng tháng';

  @override
  String get annually => 'Hàng năm';

  @override
  String get whatsIncluded => 'Bao gồm những gì:';

  @override
  String get chooseThisPlan => 'Chọn gói này';

  @override
  String get bestPricesForPremiumAccess =>
      'Giá tốt nhất cho Quyền truy cập Cao cấp';

  @override
  String get choosePlanFitsNeeds =>
      'Chọn một gói phù hợp với nhu cầu doanh nghiệp của bạn và bắt đầu tự động hóa với AI';

  @override
  String get save50Percent => 'TIẾT KIỆM 50%';

  @override
  String get tryDemo => 'Dùng thử demo';

  @override
  String get pleaseEnterEmailPassword => 'Vui lòng nhập email và mật khẩu';

  @override
  String loginFailed(String error) {
    return 'Đăng nhập thất bại: $error';
  }

  @override
  String get welcomeBack => 'Chào mừng trở lại';

  @override
  String get signInToContinue => 'Đăng nhập vào tài khoản của bạn để tiếp tục';

  @override
  String get or => 'hoặc';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'example123@gmail.com';

  @override
  String get password => 'Mật khẩu';

  @override
  String get enterPassword => 'Nhập mật khẩu';

  @override
  String get forgotPassword => 'Quên mật khẩu?';

  @override
  String get createNewAccount => 'Tạo tài khoản mới tại đây!';

  @override
  String get signUp => 'Đăng ký';

  @override
  String get signUpAccount => 'Đăng Ký Tài Khoản';

  @override
  String get enterPersonalData =>
      'Nhập dữ liệu cá nhân của bạn để tạo tài khoản';

  @override
  String get nameLabel => 'Tên *';

  @override
  String get enterNameHint => 'Nhập Tên';

  @override
  String get emailLabel => 'Email *';

  @override
  String get passwordLabel => 'Mật khẩu *';

  @override
  String get phoneLabel => 'Điện thoại';

  @override
  String get continueButton => 'Tiếp tục';

  @override
  String get fillAllFields => 'Vui lòng điền tất cả các trường bắt buộc.';

  @override
  String get accountCreatedSuccess => 'Tạo tài khoản thành công.';

  @override
  String signUpFailed(String error) {
    return 'Đăng ký thất bại: $error';
  }

  @override
  String get nationality => 'Quốc tịch:';

  @override
  String get overview => 'Tổng quan';

  @override
  String get setting => 'Cài đặt';

  @override
  String get paymentHistory => 'Lịch sử thanh toán';

  @override
  String get signalsPlan => 'Gói tín hiệu';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => 'Token của bạn';

  @override
  String get emailNotificationPreferences => 'Tùy chọn thông báo trình duyệt';

  @override
  String get chooseSignalNotificationTypes =>
      'Chọn loại thông báo tín hiệu bạn muốn nhận qua thông báo đẩy trình duyệt';

  @override
  String get allSignalNotifications => 'Tất cả thông báo tín hiệu';

  @override
  String get cryptoSignals => 'Tín hiệu Crypto';

  @override
  String get forexSignals => 'Tín hiệu Forex';

  @override
  String get goldSignals => 'Tín hiệu Vàng';

  @override
  String get updatePasswordSecure =>
      'Cập nhật mật khẩu để giữ tài khoản của bạn an toàn';

  @override
  String get searchLabel => 'Tìm kiếm:';

  @override
  String get filterBy => 'Lọc theo:';

  @override
  String get allTime => 'Mọi lúc';

  @override
  String get startDate => 'Ngày bắt đầu:';

  @override
  String get endDate => 'Ngày kết thúc:';

  @override
  String get deactivate => 'Vô hiệu hóa';

  @override
  String get unlimited => 'Không giới hạn';

  @override
  String get tenLeft => 'Còn 10';

  @override
  String get termsOfRegistrationContent =>
      'Vui lòng đọc kỹ tất cả các điều khoản và thỏa thuận dưới đây trước khi tiếp tục các bước tiếp theo trong hệ thống của chúng tôi.\nBằng việc đăng ký tài khoản trên hệ thống Signal GPT, bạn xác nhận và hiểu rằng bạn đã đọc và hoàn toàn đồng ý với tất cả các điều khoản được nêu trong các Điều khoản và Điều kiện này.\n\n1. Giới thiệu và Phạm vi Áp dụng\n\nChính sách này quy định việc thu thập, sử dụng, chia sẻ và bảo vệ thông tin cá nhân của người dùng khi truy cập và sử dụng các sản phẩm và dịch vụ của hệ thống Signal GPT – một nền tảng công nghệ và trí tuệ nhân tạo thuộc sở hữu và vận hành bởi CÔNG TY TNHH ĐẦU TƯ CÔNG NGHỆ EZTRADE (sau đây gọi tắt là “chúng tôi”).\nBằng việc đăng ký tài khoản hoặc sử dụng các sản phẩm của Signal GPT, bạn đồng ý rằng hành động đó cấu thành một cam kết ràng buộc về mặt pháp lý giữa bạn và chúng tôi, tương đương với một hợp đồng điện tử.\n\n2. Đăng ký Tài khoản\n\nĐể truy cập và sử dụng một số dịch vụ trên Signal GPT, bạn phải đăng ký một tài khoản hợp lệ.\nKhi đăng ký, bạn được yêu cầu cung cấp thông tin cá nhân đầy đủ và chính xác, bao gồm họ tên đầy đủ, địa chỉ email, số điện thoại hoặc bất kỳ thông tin nào khác theo yêu cầu.\nSau khi đăng ký, bạn phải xác nhận email để kích hoạt tài khoản. Tất cả các thông báo về tài khoản, chương trình khuyến mãi hoặc cập nhật hệ thống sẽ được gửi đến địa chỉ email này.\nNếu thông tin bạn cung cấp không chính xác hoặc không đầy đủ, bạn sẽ hoàn toàn chịu trách nhiệm về mọi sự cố hoặc thiệt hại phát sinh từ đó.\n\n3. Điều khoản Sử dụng\n\nKhi tham gia hệ thống Signal GPT, bạn có nghĩa vụ tuân thủ tất cả những điều sau:\nCác nguyên tắc hoạt động của nền tảng;\nĐiều khoản thanh toán;\nChính sách bảo mật dữ liệu cá nhân;\nCác luật và quy định có liên quan hiện hành.\nTrong trường hợp vi phạm, EZTRADE bảo lưu quyền tạm ngừng hoặc xóa vĩnh viễn tài khoản của bạn và có thể chuyển vụ việc cho cơ quan có thẩm quyền nếu cần thiết.\n\n4. Chính sách Bảo mật Dữ liệu Cá nhân\n\n4.1. Mục đích và Phạm vi Thu thập\n\nĐể cung cấp dịch vụ, Signal GPT thu thập thông tin cần thiết bao gồm: họ tên, email, số điện thoại, phương tiện liên hệ và dữ liệu kỹ thuật như địa chỉ IP, loại trình duyệt, thời gian truy cập, ngôn ngữ và các trang đã truy cập.\nThông tin này được sử dụng cho các mục đích sau:\nĐể xác minh tài khoản và quản lý người dùng;\nĐể cung cấp dịch vụ và hỗ trợ khách hàng;\nĐể gửi thông báo, ưu đãi hoặc cập nhật quan trọng;\nĐể cải thiện chất lượng hệ thống và trải nghiệm người dùng.\nMọi thông tin kê khai phải chính xác và hợp pháp. Chúng tôi không chịu trách nhiệm về bất kỳ tranh chấp hoặc thiệt hại nào do khai báo sai lệch.\n\n4.2. Phạm vi Sử dụng Thông tin\n\nSignal GPT chỉ sử dụng thông tin cá nhân của bạn cho các mục đích nội bộ và tuân thủ pháp luật Việt Nam.\nChúng tôi có thể liên hệ với bạn qua email, điện thoại, SMS hoặc các kênh liên lạc khác để hỗ trợ kỹ thuật, xác nhận đơn hàng hoặc cập nhật khuyến mãi.\n\n4.3. Thời gian Lưu trữ Dữ liệu\n\nThông tin cá nhân của bạn sẽ được lưu trữ cho đến khi một trong các trường hợp sau xảy ra:\nBạn yêu cầu xóa tài khoản; hoặc\nHệ thống Signal GPT ngừng hoạt động theo quy định.\nTrong thời gian này, dữ liệu của bạn sẽ được bảo vệ an toàn trên máy chủ của EZTRADE.\n\n4.4. Quyền và Nghĩa vụ của Chủ thể Dữ liệu\n\nQuyền của Người dùng:\nĐược biết, đồng ý hoặc từ chối việc xử lý dữ liệu cá nhân của mình;\nTruy cập, chỉnh sửa, xóa hoặc yêu cầu hạn chế xử lý dữ liệu;\nPhản đối, khiếu nại, khởi kiện hoặc yêu cầu bồi thường thiệt hại theo quy định của pháp luật.\nNghĩa vụ của Người dùng:\nCung cấp thông tin trung thực và chính xác;\nBảo vệ dữ liệu cá nhân của chính mình và tôn trọng quyền riêng tư của người khác;\nTuân thủ pháp luật hiện hành và chính sách bảo mật của Signal GPT.\n\n4.5. Thông tin của Bên Xử lý Dữ liệu Cá nhân\n\nCÔNG TY TNHH ĐẦU TƯ CÔNG NGHỆ EZTRADE\nĐịa chỉ: Số 8 Phố Đỗ Hành, Phường Nguyễn Du, Quận Hai Bà Trưng, Thành phố Hà Nội, Việt Nam\nMã số doanh nghiệp: 0110057263\nĐiện thoại: 0862 600 626\n\n4.6. Phương thức và Công cụ Chỉnh sửa Thông tin\n\nBạn có thể truy cập phần “Cài đặt Tài khoản” để cập nhật hoặc chỉnh sửa thông tin cá nhân của mình.\nTrong trường hợp cần hỗ trợ, bạn có thể liên hệ với chúng tôi qua các kênh liên lạc chính thức của Signal GPT được công bố trên website.\n\n4.7. Biện pháp Bảo vệ Dữ liệu\n\nSignal GPT áp dụng các biện pháp kỹ thuật và hành chính tiên tiến như:\nMã hóa dữ liệu, tường lửa và kiểm soát truy cập nội bộ;\nHạn chế quyền truy cập;\nĐào tạo nhân viên về bảo mật dữ liệu.\nMọi hành vi truy cập, tiết lộ, hủy hoại hoặc thay đổi dữ liệu trái phép sẽ bị xử lý theo quy định của pháp luật.\n\n4.8. Các đối tượng được phép Tiếp cận Thông tin của Bạn\n\nĐội ngũ quản trị hệ thống Signal GPT;\nBạn, khách hàng (khi đăng nhập vào tài khoản của chính mình);\nCơ quan chức năng Việt Nam khi có yêu cầu bằng văn bản hợp lệ.\n\n4.9. Khiếu nại và Giải quyết Tranh chấp\n\nMọi khiếu nại hoặc phản hồi liên quan đến việc bảo vệ dữ liệu cá nhân hoặc việc sử dụng dịch vụ trên hệ thống Signal GPT có thể được gửi qua các kênh hỗ trợ chính thức được công bố trên website của chúng tôi.\nChúng tôi sẽ tiếp nhận, xem xét và phản hồi sớm nhất có thể để đảm bảo quyền và lợi ích hợp pháp của khách hàng theo quy định pháp luật.\n\n5. Hiệu lực và Cập nhật\n\nChính sách này có hiệu lực từ ngày 14 tháng 11 năm 2025.\nChúng tôi có thể thay đổi, cập nhật hoặc bổ sung nội dung này để tuân thủ các yêu cầu pháp lý và thực tế hoạt động.\nMọi thay đổi sẽ được công bố công khai trên website mInvest.ai trước khi áp dụng.';

  @override
  String get operatingPrinciplesContent =>
      'Vui lòng đọc kỹ tất cả các điều khoản và thỏa thuận dưới đây trước khi tiếp tục các bước tiếp theo trong hệ thống của chúng tôi.\nBằng việc đăng ký tài khoản trên hệ thống Signal GPT, bạn xác nhận và hiểu rằng bạn đã đọc và hoàn toàn đồng ý với tất cả các điều khoản được nêu trong các Điều khoản và Điều kiện này.\n\nQUY TẮC HOẠT ĐỘNG\n\n1. Thông tin Pháp lý\n\nChủ sở hữu hệ thống:\nCÔNG TY TNHH ĐẦU TƯ CÔNG NGHỆ EZTRADE\nĐịa chỉ: Số 8 Phố Đỗ Hành, Phường Nguyễn Du, Quận Hai Bà Trưng, Thành phố Hà Nội, Việt Nam\nMã số doanh nghiệp/Mã số thuế: 0110057263\nĐiện thoại: 0862 600 626\n\n2. Phạm vi Áp dụng\n\nCác Nguyên tắc Hoạt động này áp dụng cho tất cả người dùng, học viên, đối tác và cộng tác viên tham gia hoặc sử dụng các sản phẩm và dịch vụ trong hệ thống Signal GPT, bao gồm các trang web, ứng dụng, nền tảng đào tạo và các kênh trực tuyến khác do EZTRADE quản lý.\nBằng việc đăng ký tài khoản hoặc sử dụng dịch vụ của Signal GPT, người dùng được coi là đã đọc, hiểu và đồng ý với tất cả các điều khoản được quy định trong các quy định này.\n\n3. Định nghĩa\n\n“Signal GPT” là nền tảng công nghệ và trí tuệ nhân tạo thuộc sở hữu của CÔNG TY TNHH ĐẦU TƯ CÔNG NGHỆ EZTRADE.\n“Khách hàng” / “Người dùng” / “Học viên” là bất kỳ cá nhân hoặc tổ chức nào đăng ký, truy cập hoặc sử dụng các dịch vụ và sản phẩm trên hệ thống Signal GPT.\n“Chúng tôi” / “Ban quản trị” là đội ngũ quản lý đại diện cho CÔNG TY TNHH ĐẦU TƯ CÔNG NGHỆ EZTRADE, chịu trách nhiệm vận hành và quản lý hệ thống.\n“Sản phẩm” / “Dịch vụ” bao gồm các gói học tập, bản tin phân tích, tín hiệu giao dịch AI, công cụ phân tích hoặc bất kỳ nội dung kỹ thuật số nào do Signal GPT cung cấp.\n\n4. Quy tắc Sử dụng và Bảo mật Thông tin\n\nNgười dùng phải cung cấp thông tin chính xác và đầy đủ khi đăng ký tài khoản.\nSignal GPT cam kết bảo vệ thông tin cá nhân và sẽ không tiết lộ cho bên thứ ba trừ khi có yêu cầu của cơ quan có thẩm quyền.\nNgười dùng có trách nhiệm bảo mật tài khoản và mật khẩu của mình. Mọi thiệt hại phát sinh từ sự sơ suất trong bảo mật cá nhân sẽ không thuộc trách nhiệm của EZTRADE.\nSignal GPT bảo lưu quyền đình chỉ hoặc chấm dứt các tài khoản bị phát hiện vi phạm các điều khoản, bao gồm nhưng không giới hạn ở: chia sẻ tài khoản, phát tán nội dung hoặc vi phạm quyền sở hữu trí tuệ.\n\n5. Chính sách Hoàn tiền và Sử dụng Dịch vụ\n\nMọi khoản thanh toán, sau khi được xác nhận, đều không được hoàn lại trong mọi trường hợp, trừ trường hợp lỗi hệ thống xuất phát từ Signal GPT.\nNgười dùng có thể ngừng sử dụng dịch vụ bất kỳ lúc nào; tuy nhiên, mọi khoản phí đã trả sẽ không được giữ lại hoặc chuyển đổi.\nSignal GPT bảo lưu quyền điều chỉnh giá dịch vụ, chính sách khuyến mãi hoặc ưu đãi đặc biệt mà không cần thông báo trước. Người dùng có trách nhiệm thường xuyên xem xét và cập nhật thông tin.\n\n6. Quy định về Hành vi và Sử dụng Nội dung\n\nCác hành vi sau đây bị nghiêm cấm:\nSao chép, tải xuống, phân phối hoặc chia sẻ nội dung, video hoặc tài liệu thuộc hệ thống Signal GPT;\nSử dụng phần mềm hoặc công cụ để can thiệp hoặc thu thập dữ liệu bất hợp pháp;\nMạo danh Signal GPT, EZTRADE hoặc bất kỳ đại diện nào của chúng tôi nhằm mục đích gian lận, lừa đảo hoặc bôi nhọ thương hiệu;\nChia sẻ tài khoản với nhiều người dùng;\nĐăng tải, phát ngôn hoặc tham gia vào các hành động chứa nội dung xúc phạm, phỉ báng hoặc có hại đối với hệ thống.\nMọi hành vi vi phạm các điều trên có thể dẫn đến việc đình chỉ tài khoản vĩnh viễn và có thể bị xử lý theo pháp luật Việt Nam.\n\n7. Cam kết và Giới hạn Trách nhiệm\n\nSignal GPT cung cấp các sản phẩm dựa trên kiến thức, dữ liệu và thuật toán AI do đội ngũ EZTRADE phát triển.\nHiệu quả sử dụng phụ thuộc vào năng lực, kinh nghiệm và hành động của từng cá nhân. Signal GPT không đảm bảo lợi nhuận hoặc kết quả đầu tư cụ thể.\nEZTRADE sẽ được miễn trừ mọi trách nhiệm đối với các rủi ro hoặc thiệt hại gián tiếp phát sinh trong quá trình sử dụng dịch vụ, trừ trường hợp chứng minh được lỗi trực tiếp từ hệ thống.\n\n8. Quyền của Ban quản trị Signal GPT\n\nSignal GPT bảo lưu quyền sửa đổi, cập nhật hoặc bổ sung các điều khoản hoạt động bất kỳ lúc nào mà không cần báo trước.\nChúng tôi có quyền đình chỉ hoặc chấm dứt việc cung cấp dịch vụ trong trường hợp vi phạm pháp luật, vi phạm chính sách hoặc vì lý do kỹ thuật hoặc bảo trì hệ thống.\nChúng tôi có thể hợp tác với các cơ quan có thẩm quyền trong việc giải quyết khiếu nại, điều tra vi phạm và cung cấp thông tin cần thiết theo yêu cầu của pháp luật.\n\n9. Xác nhận Đồng ý\n\nBằng việc đăng ký và sử dụng hệ thống Signal GPT, bạn xác nhận rằng:\nBạn đã đọc kỹ, hiểu rõ và đồng ý với tất cả nội dung của các Nguyên tắc Hoạt động này;\nBạn đồng ý cho phép EZTRADE sử dụng thông tin liên hệ của bạn (điện thoại, email, SMS, Zalo, v.v.) để gửi thông báo, cập nhật sản phẩm, khuyến mãi hoặc thông báo chương trình mới.';

  @override
  String get termsAndConditionsContent =>
      'Bằng việc đăng ký tài khoản tham gia vào hệ thống Signal GPT, bạn xác nhận rằng bạn đã đọc, hiểu và đồng ý với tất cả nội dung của các Điều khoản và Điều kiện Mở Tài khoản này.\nCác bản cập nhật mới nhất (nếu có) sẽ được công bố tại đây và Signal GPT sẽ không gửi thông báo riêng cho từng khách hàng. Do đó, vui lòng truy cập trang này thường xuyên để cập nhật các chính sách mới nhất.\n\n1. Thỏa thuận chung\n\nSignal GPT là một nền tảng công nghệ và trí tuệ nhân tạo thuộc sở hữu của CÔNG TY TNHH ĐẦU TƯ CÔNG NGHỆ EZTRADE. Bằng việc mở tài khoản trên hệ thống này, bạn đồng ý tham gia và sử dụng các dịch vụ và sản phẩm do EZTRADE cung cấp.\nViệc đăng ký và kích hoạt tài khoản được coi là một hợp đồng điện tử giữa bạn và Signal GPT, có giá trị pháp lý tương đương với một hợp đồng dân sự theo pháp luật Việt Nam.\n\n2. Thông tin Tài khoản Cá nhân và Quyền riêng tư\n\n2.1. Mục đích và Phạm vi Thu thập Thông tin\n\nĐể truy cập và sử dụng một số dịch vụ của Signal GPT, bạn phải cung cấp thông tin cá nhân cơ bản, bao gồm:\nHọ và tên đầy đủ;\nĐịa chỉ email;\nSố điện thoại liên hệ;\nCác thông tin khác (nếu có) cần thiết cho việc xác minh, hỗ trợ hoặc cấp quyền truy cập.\nMọi thông tin được cung cấp phải chính xác, trung thực và hợp pháp. Signal GPT sẽ không chịu trách nhiệm đối với bất kỳ tổn thất hoặc tranh chấp nào phát sinh từ thông tin sai lệch, thiếu sót hoặc gian lận do người dùng cung cấp.\nNgoài ra, hệ thống có thể tự động thu thập một số dữ liệu kỹ thuật, chẳng hạn như:\nĐịa chỉ IP, loại trình duyệt và ngôn ngữ sử dụng;\nThời gian truy cập và các trang đã xem trong hệ thống.\nThông tin này giúp Signal GPT cải thiện hiệu suất, tăng cường bảo mật và tối ưu hóa trải nghiệm người dùng.\n\n2.2. Phạm vi Sử dụng Thông tin\n\nThông tin cá nhân của bạn được thu thập và sử dụng cho các mục đích hợp pháp, bao gồm:\nQuản lý tài khoản, xác minh người dùng và duy trì dịch vụ;\nGửi thông báo liên quan đến dịch vụ, tài khoản, khuyến mãi hoặc thay đổi chính sách;\nCung cấp hỗ trợ kỹ thuật, dịch vụ khách hàng và giải quyết tranh chấp (nếu có);\nPhân tích dữ liệu để cải thiện chất lượng sản phẩm và trải nghiệm người dùng.\nChúng tôi cam kết bảo vệ thông tin cá nhân của bạn và sẽ không chia sẻ nó với bên thứ ba trừ khi được pháp luật hoặc cơ quan có thẩm quyền yêu cầu.\n\n2.3. Thời gian Lưu trữ Dữ liệu\n\nThông tin của bạn sẽ được lưu trữ cho đến khi một trong các trường hợp sau xảy ra:\nBạn yêu cầu xóa tài khoản; hoặc\nHệ thống Signal GPT ngừng hoạt động theo quy định của pháp luật hiện hành.\nTrong mọi trường hợp, dữ liệu của bạn sẽ được lưu trữ an toàn và bảo vệ nghiêm ngặt trên máy chủ của EZTRADE.\n\n2.4. Đơn vị Chịu trách nhiệm Thu thập và Quản lý Thông tin Cá nhân\n\nCÔNG TY TNHH ĐẦU TƯ CÔNG NGHỆ EZTRADE\nĐịa chỉ: Số 8 Phố Đỗ Hành, Phường Nguyễn Du, Quận Hai Bà Trưng, Thành phố Hà Nội, Việt Nam\nMã số doanh nghiệp: 0110057263\n\n2.5. Phương thức và Công cụ Chỉnh sửa Thông tin\n\nBạn có thể truy cập phần “Cài đặt Tài khoản” trong hệ thống để chỉnh sửa hoặc cập nhật thông tin cá nhân của mình. Nếu bạn gặp khó khăn trong quá trình này, vui lòng liên hệ với chúng tôi qua các kênh hỗ trợ chính thức của Signal GPT được công bố trên website.\n\n2.6. Cung cấp và Xác minh Thông tin\n\nĐể đảm bảo an toàn tài khoản và bảo vệ quyền lợi của bạn, bạn phải:\nCung cấp chính xác họ tên, email và số điện thoại khi đăng ký;\nXác minh thông tin qua email xác nhận do hệ thống gửi;\nNhận thông báo kích hoạt, đặt lại mật khẩu hoặc các thông báo quan trọng khác từ Signal GPT.\nNếu thông tin cung cấp không chính xác hoặc không đầy đủ, bạn sẽ hoàn toàn chịu trách nhiệm về mọi rủi ro liên quan (ví dụ: không kích hoạt được tài khoản, mất quyền truy cập hoặc bỏ lỡ thông báo).\n\n2.7. Nghĩa vụ và Trách nhiệm Bảo mật của Người dùng\n\nBạn chịu trách nhiệm bảo vệ thông tin đăng nhập và mật khẩu của mình.\nNếu mật khẩu của bạn bị mất, bị tiết lộ hoặc bị truy cập trái phép, Signal GPT sẽ không chịu trách nhiệm về bất kỳ thiệt hại nào phát sinh.\nBạn đồng ý cho phép EZTRADE lưu trữ, quản lý và xử lý thông tin cá nhân của bạn theo quy định của pháp luật Việt Nam.\n\n2.8. Quyền Tiếp cận Thông tin của Bạn\n\nThông tin cá nhân của bạn chỉ có thể được tiếp cận bởi:\nĐội ngũ quản trị hệ thống Signal GPT (cho mục đích quản lý và kỹ thuật);\nChủ sở hữu tài khoản (thông qua phần quản lý thông tin cá nhân);\nCơ quan chức năng Việt Nam, khi có yêu cầu hợp lệ và hợp pháp theo quy định của pháp luật.\n\n2.9. Cơ chế Khiếu nại và Giải quyết\n\nĐối với mọi khiếu nại hoặc phản hồi liên quan đến việc đăng ký, sử dụng tài khoản hoặc bảo mật thông tin, bạn có thể gửi yêu cầu thông qua trang Liên hệ chính thức của Signal GPT.\nChúng tôi sẽ tiếp nhận, xử lý và phản hồi sớm nhất có thể để đảm bảo quyền và lợi ích hợp pháp của khách hàng theo quy định pháp luật hiện hành.\n\n3. Hiệu lực và Cập nhật\n\nCác Điều khoản và Điều kiện Mở Tài khoản này có hiệu lực từ ngày 14 tháng 11 năm 2025. Signal GPT bảo lưu quyền cập nhật, sửa đổi hoặc bổ sung nội dung bất kỳ lúc nào mà không cần báo trước. Mọi thay đổi sẽ được công bố công khai trên website mInvest.ai trước khi áp dụng.';

  @override
  String get performance => 'Hiệu suất';

  @override
  String get minvestSupport => 'SignalGpt Support';

  @override
  String get leaveMessagePart1 =>
      'Hãy để lại tin nhắn, đội ngũ của chúng tôi sẽ phản hồi sớm nhất. Bạn cũng có thể liên hệ ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 để được hỗ trợ nhanh.';

  @override
  String get currentPlan => 'Gói hiện tại';

  @override
  String get standard => 'TIÊU CHUẨN';

  @override
  String get availableTokens => 'Token khả dụng';

  @override
  String get subscriptions => 'Gói đăng ký';

  @override
  String get usesTokenPerView => 'Sử dụng 1 Token mỗi lần xem';

  @override
  String get unlimitedAccess => 'Truy cập không giới hạn';

  @override
  String get activeElite => 'Đang hoạt động (Elite)';

  @override
  String get active => 'Đang hoạt động';

  @override
  String get inactive => 'Không hoạt động';

  @override
  String get transactionHistory => 'Lịch sử giao dịch';

  @override
  String get noTransactionsFound => 'Không tìm thấy giao dịch nào.';

  @override
  String get colDate => 'Ngày';

  @override
  String get colProduct => 'Sản phẩm';

  @override
  String get colAmount => 'Số tiền';

  @override
  String get colMethod => 'Phương thức';

  @override
  String get colStatus => 'Trạng thái';

  @override
  String get statusSuccess => 'Thành công';

  @override
  String get featureForVipOnly =>
      'Tính năng này chỉ dành cho khách hàng VIP, vui lòng nâng cấp để nhận thông báo.';

  @override
  String get changePassword => 'Đổi mật khẩu';

  @override
  String get currentPassword => 'Mật khẩu hiện tại';

  @override
  String get newPassword => 'Mật khẩu mới';

  @override
  String get confirmNewPassword => 'Xác nhận mật khẩu mới';

  @override
  String get passwordsDoNotMatch => 'Mật khẩu không khớp';

  @override
  String get passwordUpdateSuccess => 'Cập nhật mật khẩu thành công';

  @override
  String passwordUpdateFailed(String error) {
    return 'Cập nhật thất bại: $error';
  }

  @override
  String get reauthFailed => 'Mật khẩu hiện tại không đúng';

  @override
  String get signInRequired => 'Yêu cầu đăng nhập';

  @override
  String get signInToExploreSignal =>
      'Đăng nhập để khám phá tín hiệu giao dịch này!';

  @override
  String get activeMember => 'Thành viên hoạt động';

  @override
  String get last7Days => '7 ngày qua';

  @override
  String get last14Days => '14 ngày qua';

  @override
  String get last30Days => '30 ngày qua';

  @override
  String get last90Days => '90 ngày qua';

  @override
  String get profitStatistics => 'Thống kê lợi nhuận';

  @override
  String get winrateOfAllSignals => 'Tỷ lệ thắng tất cả tín hiệu';

  @override
  String get daily => 'Hàng ngày';

  @override
  String get weekly => 'Hàng tuần';

  @override
  String get lossRate => 'Tỷ lệ thua';

  @override
  String get signalProgress => 'Tiến trình tín hiệu';

  @override
  String get statusHistory => 'Lịch sử trạng thái';

  @override
  String get signalCreated => 'Tín hiệu được tạo';

  @override
  String get signalMatched => 'Tín hiệu đã khớp';

  @override
  String get targetReached => 'Đã đạt mục tiêu';

  @override
  String get freeSignalsInfo => 'Thông tin Free Signals';

  @override
  String get freeSignalsInfoDesc =>
      'Bạn sẽ nhận được 1 tín hiệu miễn phí mỗi ngày.\nCác tín hiệu chưa sử dụng sẽ được cộng dồn sang ngày hôm sau.';

  @override
  String freeSignalsCount(int count) {
    return '$count Free Signals';
  }

  @override
  String get close => 'Đóng';

  @override
  String validUntil(String date) {
    return 'Có hiệu lực đến $date';
  }

  @override
  String get wins => 'Thắng';

  @override
  String get losses => 'Thua';

  @override
  String totalOrdersCount(int count) {
    return 'Tổng cộng: $count lệnh';
  }

  @override
  String get passwordResetEmailSent =>
      'Email đặt lại mật khẩu đã được gửi! Vui lòng kiểm tra hộp thư của bạn.';
}
