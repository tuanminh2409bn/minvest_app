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
  String get contactUs => 'Liên Hệ Hỗ Trợ';

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
  String get errorLoadingPackages => 'Lỗi Tải Gói Nâng Cấp';

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
}
