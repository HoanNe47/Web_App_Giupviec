import 'package:nb_utils/nb_utils.dart';

import 'languages.dart';

class LanguageVi extends BaseLanguage {
  @override
  String get walkTitle1 => "Tìm dịch vụ của bạn";

  @override
  String get walkTitle2 => "Đặt lịch hẹn";

  @override
  String get walkTitle3 => "Cổng thanh toán";

  @override
  String get getStarted => "Bắt đầu";

  @override
  String get welcomeTxt => "Chúng tôi đang ở cửa của bạn để giúp đỡ";

  @override
  String get signIn => "Đăng nhập";

  @override
  String get signUp => "Đăng ký";

  @override
  String get signInTitle => "Đăng nhập vào tài khoản của bạn";

  @override
  String get signUpTitle => "Tạo một tài khoản";

  @override
  String get hintNameTxt => "Điền tên của bạn";

  @override
  String get hintFirstNameTxt => "Nhập tên của bạn";

  @override
  String get hintLastNameTxt => "Nhập họ của bạn";

  @override
  String get hintContactNumberTxt => "Nhập số liên lạc của bạn";

  @override
  String get hintEmailAddressTxt => "nhập địa chỉ email của bạn";

  @override
  String get hintUserNameTxt => "Nhập tên người dùng của bạn";

  @override
  String get hintPasswordTxt => "Nhập mật khẩu của bạn";

  @override
  String get hintReenterPasswordTxt => "nhập lại mật khẩu của bạn";

  @override
  String get confirm => "Xác nhận";

  @override
  String get hintEmailTxt => "Nhập email của bạn";

  @override
  String get hintConfirmPasswordTxt => "Nhập mật khẩu xác nhận của bạn";

  @override
  String get forgotPassword => "Quên mật khẩu?";

  @override
  String get reset => "Cài lại";

  @override
  String get signInWithTxt => "Hoặc đăng nhập với";

  @override
  String get alreadyHaveAccountTxt =>
      "Bạn co săn san để tạo một tài khoản?";

  @override
  String get rememberMe => "Nhớ tôi";

  @override
  String get forgotPasswordTitleTxt =>
      "Nhập email để đặt lại \n mật khẩu của bạn";

  @override
  String get resetPassword => "Đặt lại mật khẩu";

  @override
  String get dashboard => "Trang chủ";

  @override
  String get search => "Tìm kiếm dịch vụ";

  @override
  String get passwordErrorTxt =>
      "Mật khẩu tối thiểu $passwordLengthGlobal ký tự";

  @override
  String get loginSuccessfully => "Đăng nhập thành công";

  @override
  String get editProfile => "Chỉnh sửa hồ sơ.";

  @override
  String get saveChanges => "Lưu thay đổi";

  @override
  String get camera => "Máy ảnh";

  @override
  String get language => "Ngôn ngữ";

  @override
  String get supportLanguage => "Chọn ngôn ngữ";

  @override
  String get appTheme => "Giao diện";

  @override
  String get bookingHistory => "Đặt lịch sử";

  @override
  String get rateUs => "Đánh giá chúng tôi";

  @override
  String get termsCondition => "Điều khoản & Điều kiện";

  @override
  String get helpSupport => "Trợ giúp & Hỗ trợ";

  @override
  String get privacyPolicy => "Chính sách bảo mật";

  @override
  String get about => "Giới thiệu";

  @override
  String get logout => "Đăng xuất";

  @override
  String get logoutTxt => "Bạn sẽ được đăng xuất khỏi ứng dụng.";

  @override
  String get afterLogoutTxt =>
      "Bạn có muốn đăng xuất khỏi ứng dụng? Bạn luôn có thể đăng nhập lại!";

  @override
  String get chooseTheme => "Chọn Giao diện";

  @override
  String get selectCountry => "Chọn quốc gia";

  @override
  String get selectState => "Chọn trạng thái";

  @override
  String get selectCity => "Lựa chọn thành phố";

  @override
  String get changePassword => "Đổi mật khẩu";

  @override
  String get passwordNotMatch => "Mật khẩu không hợp lệ";

  @override
  String get doNotHaveAccount => "Không có tài khoản?";

  @override
  String get continueTxt => "Tiếp tục";

  @override
  String get lblSeenMore => "Cho xem nhiều hơn";

  @override
  String get hintNewPasswordTxt => "Nhập mật khẩu mới của bạn";

  @override
  String get hintOldPasswordTxt => "Nhập mật khẩu cũ của bạn";

  @override
  String get hintAddress => "Nhập địa chỉ của bạn";

  @override
  String get lblSeenLess => "Hiện ít hơn";

  @override
  String get lblGallery => "Bộ sưu tập";

  @override
  String get lblProvider => "Nhà cung cấp";

  @override
  String get yourReview => "Đánh giá của bạn";

  @override
  String get review => "Đánh giá";

  @override
  String get lblAddress => "Địa chỉ nhà";

  @override
  String get hintCouponCode => "Nhập mã phiếu giảm giá của bạn";

  @override
  String get lblCouponCode => "mã giảm giá";

  @override
  String get lblDescription => "Sự miêu tả";

  @override
  String get hintDescription => "Nhập mô tả của bạn";

  @override
  String get lblNew => "Mới";

  @override
  String get lblApply => "Ứng dụng";

  @override
  String get bookTheService => "Đặt dịch vụ";

  @override
  String get cantLogin => "không thể đăng nhập";

  @override
  String get contactAdmin => "Vui lòng liên hệ với quản trị viên";

  @override
  String get allServices => "Tất cả các dịch vụ";

  @override
  String get availableCoupon => "Phiếu giảm giá có sẵn";

  @override
  String get duration => "Khoảng thời gian";

  @override
  String get takeTime => "Dịch vụ này có thể mất đến";

  @override
  String get hourly => "hàng giờ";

  @override
  String get providerDetail => "CHI TIẾT CUNG CẤP";

  @override
  String get contact => "tiếp xúc";

  @override
  String get from => "từ";

  @override
  String get serviceList => "Danh sách dịch vụ";

  @override
  String get serviceGallery => "Thư viện dịch vụ";

  @override
  String get payment => "Thanh toán";

  @override
  String get done => "Hoàn thành";

  @override
  String get paymentMethod => "Phương thức thanh toán";

  @override
  String get totalAmount => "Tổng cộng";

  @override
  String get couponDiscount => "Giảm giá phiếu giảm giá";

  @override
  String get applyCoupon => "Áp dụng phiếu giảm giá";

  @override
  String get discountOnMRP => "Giảm giá trên MRP.";

  @override
  String get quantity => "Số lượng";

  @override
  String get rate => "Đánh giá";

  @override
  String get priceDetail => "Chi tiết giá";

  @override
  String get home => "Trang chủ";

  @override
  String get category => "Thể loại";

  @override
  String get booking => "Đặt trước";

  @override
  String get profile => "Hồ sơ";

  @override
  String get bookService => "Đặt dịch vụ";

  @override
  String get dateTime => "Ngày giờ";

  @override
  String get selectDateTime => "Chọn Ngày & Giờ";

  @override
  String get bookingSummary => "Tóm tắt đặt phòng";

  @override
  String get bookingAt => "Đặt phòng tại";

  @override
  String get lblAlertBooking => "Bạn có chắc chắn muốn đặt dịch vụ này";

  @override
  String get bookingService => "Dịch vụ đặt phòng";

  @override
  String get serviceName => "Tên dịch vụ";

  @override
  String get customerName => "tên khách hàng";

  @override
  String get expDate => "Ngày hết hạn";

  @override
  String get discount => "Chiết khấu";

  @override
  String get typeOfService => "Loại dịch vụ";

  @override
  String get thingsInclude => "những thứ bao gồm trong dịch vụ";

  @override
  String get safetyFee => "Phí an toàn và Walfar";

  @override
  String get itemTotal => "Tổng mục";

  @override
  String get loginToApply => "Đăng nhập để áp dụng phiếu giảm giá";

  @override
  String get service => "Dịch vụ";

  @override
  String get viewAllService => "Xem tất cả các dịch vụ";

  @override
  String get lblCancelReason => "Vui lòng nhập lý do để hủy đặt phòng này.";

  @override
  String get lblreason => "Chỉ định lý do hủy bỏ đặt phòng này";

  @override
  String get enterReason => "Chỉ định lý do ở đây";

  @override
  String get noDataAvailable => "Không có dữ liệu";

  @override
  String get contactProvider => "Nhà cung cấp liên hệ";

  @override
  String get contactHandyman => "Liên hệ với người siêng năng";

  @override
  String get pricingDetail => "Chi tiết giá cả";

  @override
  String get lblOk => "Đồng ý";

  @override
  String get paymentDetail => "Chi tiết thanh toán";

  @override
  String get paymentStatus => "Tình trạng thanh toán";

  @override
  String get totalAmountPaid => "Tổng số tiền thanh toán";

  @override
  String get viewDetail => "xem chi tiết";

  @override
  String get bookingStatus => "Trạng thái đặt phòng";

  @override
  String get appThemeLight => "Sáng";

  @override
  String get appThemeDark => "Tối";

  @override
  String get appThemeDefault => "Mặc định hệ thống";

  @override
  String get lblCheckInternet =>
      "Hãy chắc chắn rằng bạn được kết nối với internet";

  @override
  String get markAsRead => "Đánh dấu tất cả như đã đọc";

  @override
  String get deleteAll => "Xóa hết";

  @override
  String get lblInternetWait => "Trang sẽ quay lại khi Internet có sẵn";

  @override
  String get toastPaymentFail => "Thanh toán thất bại Vui lòng thử lại";

  @override
  String get toastEnterDetail => "Vui lòng nhập chi tiết";

  @override
  String get toastEnterAddress => "Vui lòng nhập địa chỉ";

  @override
  String get toastReason => "Hãy ghi rõ lý do";

  @override
  String get lblComplete => "Hoàn thành";

  @override
  String get lblHoldReason => "Chỉ định lý do giữ dịch vụ này";

  @override
  String get cancelled => "Hủy bỏ";

  @override
  String get lblYes => "Có";

  @override
  String get lblNo => "Không";

  @override
  String get lblRateApp => "Hệ thống đặt phòng giá";

  @override
  String get lblRateTitle => "Ý kiến của bạn ​quan trọng​ với chúng tôi!";

  @override
  String get lblHintRate => "Để lại tin nhắn cho chúng tôi";

  @override
  String get btnRate => "Bình chọn bây giờ";

  @override
  String get btnLater => "Có lẽ sau này";

  @override
  String get toastRateUs => "Hãy đánh giá chúng tôi!";

  @override
  String get toastAddReview => "Vui lòng đưa ra đánh giá";

  @override
  String get toastSorry => "Xin lỗi";

  @override
  String get btnSubmit => "Chấp nhận";

  @override
  String get walkThrough1 => "Tìm một dịch vụ theo sở thích của bạn.";

  @override
  String get walkThrough2 => "Dịch vụ sách vào thời gian của bạn.";

  @override
  String get walkThrough3 =>
      "Chọn tùy chọn thanh toán thích hợp hơn và nhận dịch vụ tốt nhất.";

  @override
  String get lblSkip => "Bỏ qua";

  @override
  String get lnlNotification => "Thông báo.";

  @override
  String get lblUnAuthorized =>
      "Người dùng demo không thể được cấp cho hành động này";

  @override
  String get btnNext => "Kế tiếp";

  @override
  String get lblViewAll => "Xem tất cả";

  @override
  String get notAvailable => "Không có sẵn";

  @override
  String get serviceAvailable => "Dịch vụ có sẵn trong thành phố này";

  @override
  String get writeMsg => "Viết một tin nhắn ...";

  @override
  String get dltMsg => "Xóa tin nhắn?";

  @override
  String get lblFavorite => "Dịch vụ yêu thích";

  @override
  String get lblchat => "Trò chuyện";

  @override
  String get addAddess => "Vui lòng thêm địa chỉ";

  @override
  String get allProvider => "Tất cả các nhà cung cấp";

  @override
  String get getLocation => "Nhận vị trí";

  @override
  String get setAddress => "Đặt địa chỉ";

  @override
  String get requiredText => "Trường này là bắt buộc";

  @override
  String get phnrequiredtext => "Vui lòng nhập số điện thoại di động";

  @override
  String get phnvalidation => "Số liên lạc phải chỉ có 10 chữ số";

  @override
  String get lblVeiwAll => "Xem tất cả";

  @override
  String get toastLocationOff => "Vị trí đã tắt";

  @override
  String get toastLocationOn => "Vị trí là ON.";

  @override
  String get paymentConfirmation => "Xác nhận đang chờ xử lý";

  @override
  String get lblCall => "Gọi";

  @override
  String get lblRateHandyman => "Tỷ lệ Spa.";

  @override
  String get msgForLocationOn =>
      "Vị trí đang bật. Người dùng chỉ có thể duyệt chỉ những dịch vụ có sẵn ở vị trí hiện tại của bạn";

  @override
  String get msgForLocationOff =>
      "Vị trí là off.userer có thể duyệt tất cả các dịch vụ";

  @override
  String get btnCurrent => "Hiện hành";

  @override
  String get lblenterPhnNumber => "Nhập số điện thoại của bạn";

  @override
  String get btnSendOtp => "Gửi OTP.";

  @override
  String get enterOtp => "Nhập OTP bạn nhận được trên số của bạn";

  @override
  String get lblLocationOff => "Tất cả các dịch vụ có sẵn";

  @override
  String get ratings => "Đánh giá";

  @override
  String get lblAppSetting => "Cài đặt ứng dụng.";

  @override
  String get lblVersion => "Phiên bản";

  @override
  String get txtProvider => "Các nhà cung cấp";

  @override
  String get lblShowMore => "Cho xem nhiều hơn";

  @override
  String get lblShowLess => "Hiện ít hơn";

  @override
  String get lblSignInTitle => "Chào mừng bạn đến với người dùng";

  @override
  String get txtPassword => "Mật khẩu";

  @override
  String get txtCreateAccount => "Tạo tài khoản tại đây";

  @override
  String get lblSignInHere => "Đăng nhập tại đây";

  @override
  String get lblSignUpTitle => "Đăng ký như người dùng";

  @override
  String get lblTaxAmount => "Đăng ký như người dùng";

  @override
  String get lblSubTotal => "Số tiền thuế";

  @override
  String get lblNoData => "Không tìm thấy dữ liệu nào";

  @override
  String get lblImage => " Hình ảnh";

  @override
  String get lblVideo => " Băng hình";

  @override
  String get lblAudio => " Âm thanh.";

  @override
  String get lblChangePwdTitle =>
      "Mật khẩu mới của bạn phải khác với mật khẩu đã sử dụng trước đó";

  @override
  String get lblForgotPwdSubtitle =>
      " Một liên kết mật khẩu thiết lập lại sẽ được gửi đến địa chỉ email đã nhập ở trên";

  @override
  String get lblLoginTitle => "Xin chào lần nữa ";

  @override
  String get lblLoginSubTitle =>
      "Chào mừng trở lại, bạn đã bị bỏ lỡ trong một thời gian dài";

  @override
  String get btnTextLogin => "Đăng nhập";

  @override
  String get lblOrContinueWith => "Hoặc tiếp tục với";

  @override
  String get lblHelloUser => " Xin chào người dùng!";

  @override
  String get lblSignUpSubTitle => "Đăng ký để có trải nghiệm tốt hơn";

  @override
  String get lblStepper1Title => " Nhập thông tin chi tiết";

  @override
  String get lblDateAndTime => " Ngày và giờ:";

  @override
  String get lblEnterDateAndTime => "Nhập ngày và giờ";

  @override
  String get lblYourAddress => " Địa chỉ của bạn:";

  @override
  String get lblEnterYourAddress => "Nhập địa chỉ của bạn";

  @override
  String get lblUseCurrentLocation => "Sử dụng vị trí hiện tại";

  @override
  String get lblEnterDescription => "Nhập mô tả";

  @override
  String get lblPrice => " Giá bán";

  @override
  String get lblTax => " Thuế";

  @override
  String get lblDiscount => "Giảm giá";

  @override
  String get lblAvailableCoupons => "Phiếu giảm giá có sẵn";

  @override
  String get lblPrevious => "Trước";

  @override
  String get lblBooking => "Đặt trước";

  @override
  String get lblCoupon => "Phiếu mua hàng";

  @override
  String get lblEditYourReview => "Chỉnh sửa đánh giá của bạn";

  @override
  String get lblTime => "Thời gian";

  @override
  String get textProvider => " Các nhà cung cấp";

  @override
  String get lblConfirmBooking => "Xác nhận đặt phòng";

  @override
  String get lblConfirmMsg => "Bạn có chắc chắn muốn xác nhận đặt phòng này?";

  @override
  String get lblCancel => "Hủy bỏ";

  @override
  String get lblExpiryDate => "Ngày hết hạn :";

  @override
  String get lblRemoveCoupon => "Xóa phiếu giảm giá";

  @override
  String get lblNoCouponsAvailable => "Không có phiếu giảm giá có sẵn";

  @override
  String get lblStep1 => "Bước 1";

  @override
  String get lblStep2 => "Bước 2";

  @override
  String get lblBookingID => "ID đặt chỗ";

  @override
  String get lblDate => "Ngày tháng";

  @override
  String get lblAboutHandyman => " Về Handyman.";

  @override
  String get lblAboutProvider => " Về nhà cung cấp";

  @override
  String get lblNotRatedYet => "Bạn chưa đánh giá";

  @override
  String get lblDeleteReview => "Xóa đánh giá";

  @override
  String get lblConfirmReviewSubTitle =>
      " Bạn có chắc chắn muốn xóa đánh giá này?";

  @override
  String get lblConfirmService => "Bạn có chắc chắn muốn tạm dừng dịch vụ này?";

  @override
  String get lblConFirmResumeService =>
      "Bạn có chắc chắn muốn tiếp tục dịch vụ này?";

  @override
  String get lblEndServicesMsg => "Bạn có muốn kết thúc dịch vụ này?";

  @override
  String get lblCancelBooking => " Hủy đặt";

  @override
  String get lblStart => " Bắt đầu";

  @override
  String get lblHold => "Tạm dừng";

  @override
  String get lblResume => "Sơ yếu lý lịch";

  @override
  String get lblPayNow => "Trả tiền ngay";

  @override
  String get lblCheckStatus => " Kiểm tra trạng thái";

  @override
  String get lblID => "ID";

  @override
  String get lblNoBookingsFound => " Không tìm thấy đặt phòng";

  @override
  String get lblCategory => "Danh mục";

  @override
  String get lblYourComment => "Bình luận của bạn";

  @override
  String get lblIntroducingCustomerRating =>
      " Giới thiệu đánh giá của khách hàng";

  @override
  String get lblSeeYourRatings => "Xem đánh giá của bạn";

  @override
  String get lblFeatured => "Nổi bật";

  @override
  String get lblNoServicesFound => "Không tìm thấy dịch vụ";

  @override
  String get lblNoChatFound => "Không tìm thấy cuộc trò chuyện";

  @override
  String get lblGENERAL => "Thông tin chung";

  @override
  String get lblAboutApp => "Về ứng dụng.";

  @override
  String get lblPurchaseCode => "Mua mã nguồn đầy đủ";

  @override
  String get lblReviewsOnServices => "Đánh giá về dịch vụ";

  @override
  String get lblNoRateYet => "Hiện tại bạn chưa đánh giá bất kỳ dịch vụ nào";

  @override
  String get lblSetting => "Cài đặt";

  @override
  String get lblMemberSince => "Thành viên từ";

  @override
  String get lblFilterBy => "Lọc bởi";

  @override
  String get lblAllFiltersCleared => "Tất cả các bộ lọc được xóa";

  @override
  String get lblClearFilter => "Làm sạch bộ lọc";

  @override
  String get lblNumber => "Con số";

  @override
  String get lblNoReviews => "Không có bài đánh giá nào";

  @override
  String get lblUnreadNotification => "Thông báo chưa đọc";

  @override
  String get lblChoosePaymentMethod => "Lựa chọn hình thức thanh toán";

  @override
  String get lblNoPayments => "Không có khoản thanh toán nào";

  @override
  String get lblPayWith => " Bạn có muốn trả tiền với";

  @override
  String get payWith => "Thanh toán bằng";

  @override
  String get lblYourRating => "Đánh giá của bạn";

  @override
  String get lblEnterReview => "Nhập đánh giá của bạn (tùy chọn)";

  @override
  String get lblDelete => "Xóa bỏ";

  @override
  String get lblDeleteRatingMsg => " Bạn có chắc chắn muốn xóa xếp hạng này?";

  @override
  String get lblSelectRating => "Vui lòng chọn Đánh giá";

  @override
  String get lblServiceRatings => "Xếp hạng dịch vụ";

  @override
  String get lblNoServiceRatings => "Không có xếp hạng dịch vụ";

  @override
  String get lblSearchFor => "Tìm kiếm";

  @override
  String get lblRating => "Xếp hạng";

  @override
  String get lblAvailableAt => "Có sẵn tại";

  @override
  String get lblRelatedServices => "Dịch vụ liên quan";

  @override
  String get lblBookNow => "Đặt bây giờ";

  @override
  String get lblWelcomeToHandyman => "Chào mừng bạn đến Spa.";

  @override
  String get lblWalkThroughSubTitle =>
      "Dịch vụ Spa - Ứng dụng dịch vụ gia đình theo yêu cầu với giải pháp hoàn chỉnh";

  @override
  String get textHandyman => "Spa";

  @override
  String get lblChooseFromMap => "Chọn từ bản đồ";

  @override
  String get lblAbout => "Giới thiệu";

  @override
  String get lblDeleteAddress => "Xóa địa chỉ";

  @override
  String get lblDeleteSunTitle => "Bạn có chắc chắn muốn xóa địa chỉ này?";

  @override
  String get lblFaq => "Câu hỏi thường gặp";

  @override
  String get lblServiceFaq => "Câu hỏi thường gặp về dịch vụ";

  @override
  String get lblLogoutTitle => "Ồ không, bạn đang rời đi!";

  @override
  String get lblLogoutSubTitle => "Bạn có muốn đăng xuất?";

  @override
  String get lblFeaturedProduct => "Đây là sản phẩm đặc trưng";

  @override
  String get lblRequiredValidation => "Trường này là bắt buộc";

  @override
  String get lblAlert => "Báo động";

  @override
  String get lblLocationOffMsg =>
      "Vị trí bị tắt. Khám phá và tìm các dịch vụ có sẵn cho khu vực đã chọn của bạn.";

  @override
  String get lblOnBase => "Trên cơ sở của";

  @override
  String get lblInvalidCoupon => "Mã phiếu giảm giá không hợp lệ";

  @override
  String get lblSelectCode => "Vui lòng chọn mã phiếu giảm giá";

  @override
  String get lblBackPressMsg => "Nhấn Back lại để thoát ứng dụng";

  @override
  String get lblHour => "giờ";

  @override
  String get lblHelplineNumber => "Số đường dây trợ giúp";

  @override
  String get lblNotAvailableNumber =>
      "Không có số đường dây trợ giúp không có sẵn";

  @override
  String get lblSubcategories => "Thể loại phụ";

  @override
  String get lblAgree => "tôi đồng ý với";

  @override
  String get lblTermsOfService => "Điều khoản dịch vụ";

  @override
  String get lblPrivacyPolicy => "Chính sách bảo mật";

  @override
  String get lblWalkThrough0 =>
      "Dịch vụ Spa - Ứng dụng dịch vụ gia đình theo yêu cầu với giải pháp hoàn chỉnh";

  @override
  String get lblServiceTotalTime => "Dịch vụ tổng thời gian";

  @override
  String get lblDateTimeUpdated => "Cập nhật thời gian";

  @override
  String get lblSelectDate => "Vui lòng chọn Thời gian Ngày";

  @override
  String get lblReasonCancelling => "Lý do để hủy đặt phòng này";

  @override
  String get lblReasonRejecting => "Lý do từ chối đặt phòng này";

  @override
  String get lblFailed => "Lý do tại sao đặt phòng này không thành công";

  @override
  String get lblNoChatsFound => "Không tìm thấy cuộc trò chuyện";

  @override
  String get lblNotDescription => "Không có mô tả nào";

  @override
  String get lblMaterialTheme => "Bật chủ đề tài liệu bạn";

  @override
  String get lblServiceProof => "Bằng chứng dịch vụ";

  @override
  String get lblAndroid12Support =>
      "Hành động này sẽ khởi động lại ứng dụng của bạn. Xác nhận?";

  @override
  String get lblOff => "Miễn giảm";

  @override
  String get lblHr => "giờ";

  @override
  String get lblSignInWithGoogle => "Đăng nhập bằng Google";

  @override
  String get lblSignInWithOTP => "Đăng nhập bằng OTP";

  @override
  String get lblEditService => "Chỉnh sửa dịch vụ";

  @override
  String get lblOnlyUserCanLoggedInHere =>
      "Chỉ người dùng mới có thể đăng nhập ở đây";

  @override
  String get lblDangerZone => "Khu vực nguy hiểm";

  @override
  String get lblDeleteAccount => "Xóa tài khoản";

  @override
  String get lblUnderMaintenance => "Đang bảo trì...";

  @override
  String get lblCatchUpAfterAWhile => "Bắt kịp sau một thời gian";

  @override
  String get lblId => "ID";

  @override
  String get lblMethod => "Phương pháp";

  @override
  String get lblStatus => "Trạng thái";

  @override
  String get lblPending => "Chưa giải quyết";

  @override
  String get confirmationRequestTxt =>
      "Bạn có chắc chắn muốn thực hiện hành động này không?";

  @override
  String get lblDeleteAccountConformation =>
      "Tài khoản của bạn sẽ bị xóa vĩnh viễn. Dữ liệu của bạn sẽ không được khôi phục lại.";

  @override
  String get lblAutoSliderStatus => "Trạng thái thanh trượt tự động";

  @override
  String get lblPickAddress => "Chọn địa chỉ";

  @override
  String get lblUpdateDateAndTime => "Cập nhật ngày và thời gian";

  @override
  String get lblRecheck => "Kiểm tra lại";

  @override
  String get lblLoginAgain => "Xin vui lòng đăng nhập lại";

  @override
  String get lblAcceptTermsCondition =>
      "Vui lòng chấp nhận các điều khoản và điều kiện";

  @override
  String get lblOTPLogin => "Đăng nhập OTP";

  @override
  String get lblUpdate => "Cập nhật";

  @override
  String get lblNewUpdate => "Cập nhật mới";

  @override
  String get lblOptionalUpdateNotify => "Cập nhật tùy chọn thông báo";

  @override
  String get lblAnUpdateTo => "Cập nhật về";

  @override
  String get lblIsAvailableWouldYouLike => "có sẵn. Bạn có muốn cập nhật?";

  @override
  String get lblRegisterAsPartner => "Đăng ký làm đối tác";

  @override
  String get lblSignInWithApple => "Đăng nhập bằng Apple";

  @override
  String get lblWaitingForProviderApproval =>
      "Chờ đợi sự chấp thuận của nhà cung cấp";

  @override
  String get lblFree => "Chưa thanh toán";

  @override
  String get lblAppleSignInNotAvailable =>
      "Apple Signin không có sẵn cho thiết bị của bạn";

  @override
  String get lblAddAppleIdEmail =>
      "Địa chỉ e-mail là bắt buộc. Vui lòng cập nhật email trong tài khoản Apple của bạn.";
}
