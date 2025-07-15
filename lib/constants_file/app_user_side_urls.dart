class AppUrlsUserSide{
  static var baseUrlUserSideUrls="https://api.hireanything.com/user/";
  var baseUrlImages="https://api.hireanything.com/uploads/";
  // https://api.hireanything.com/user/add_enquiry
  
// https://api.hireanything.com/user/login
 static var baseUrlUserSideUrls2 ="https://stag-api.hireanything.com/user/";


 var login = "${baseUrlUserSideUrls2}login";
 static var profile = "${baseUrlUserSideUrls2}profile";



  // var login = "${baseUrlUserSideUrls}login";
  var signup="${baseUrlUserSideUrls}signup";
  var verifyOtp="${baseUrlUserSideUrls}verify_otp";
  var updateUserProfile="${baseUrlUserSideUrls}update_user";
  var resendOtp="${baseUrlUserSideUrls}resend_otp";
  var addUserAddress="${baseUrlUserSideUrls}add_user_address";
  var userProfile="${baseUrlUserSideUrls}user_profile";
  var bannerList="${baseUrlUserSideUrls}banner_header_list";
  var bannerFooterList="${baseUrlUserSideUrls}banner_footer_list";
  var categoryList="${baseUrlUserSideUrls}category_list";
  var subcategoryList="${baseUrlUserSideUrls}subcategory_list";
  var offerList="${baseUrlUserSideUrls}offer_list";
  var addEnquiry="${baseUrlUserSideUrls}add_enquiry";
  var categoryBannerList="${baseUrlUserSideUrls}category_banner_list";
  var updateUserAddress="${baseUrlUserSideUrls}update_user_address";
  var faqList="${baseUrlUserSideUrls}faq_list";
  var termsConditionList="${baseUrlUserSideUrls}terms_condition_list";
  var privacyPolicyList="${baseUrlUserSideUrls}privacy_policy_list";
  var aboutUsList="${baseUrlUserSideUrls}about_us_list";

  var vendorServiceList="${baseUrlUserSideUrls}vendor_service_list";
  var addFavouriteService="${baseUrlUserSideUrls}add_favourite_service";


    var contact="${baseUrlUserSideUrls}add_enquiry";
        static const Duration receiveTimeout = Duration(seconds: 60);

  // connectTimeout
  static const Duration connectionTimeout = Duration(seconds: 60);


  static const String userBookings = "bookings";
  static const String createBooking = "/bookings";

  static const String cancelBooking =  "cancelBooking";
  


  // var subcategoryList="${baseUrlUserSideUrls}subcategory_list";
  // var offerListList="${baseUrlUserSideUrls}offer_list";

}