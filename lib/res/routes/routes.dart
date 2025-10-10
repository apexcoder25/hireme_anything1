class UserRoutesName {
  // Auth Routes
  static const String authentication = '/auth';
  
  // Main App Routes
  static const String introScreen = '/introduction_screen';
  static const String homeUserView = '/home_page';
  static const String userProfleScreen = '/user_profile_screen';
  
  // Service Routes
  static const String allCategoryView = '/category_all_view';
  static const String tutorHireScreen = '/tutor_hire_screen';
  static const String passengerTransportHireScreen = '/passenger_transport_hire_screen';
  static const String artistHireScreen = '/artist_hire_screen';
  static const String MeetingRoomHireScreen = '/meeting_room_hire';
  
  // Booking & Payment Routes
  static const String userBookingsDetailsScreen = '/user_booking_details';
  static const String paymentSuccess = '/payment_succes';
  
  // Info Routes
  static const String WhyChooseUsScreen = '/WhyChooseUsScreen';
  
  // Legacy Routes (Consider deprecating)
  static const String loginUserView = '/user_login_view';
  static const String registerUserView = '/user_signup_view';
}

class VendorRoutesName {
  // Auth Routes
  static const String authentication = '/vendor_auth';
  
  // Main App Routes
  static const String introScreen = '/vendor_introduction_screen';
  static const String mainDashboard = '/vendor_main_dashboard';

  static const String homeVendorView = '/vendor_dashboard';
  
  // Service Management Routes
  static const String vendorProfileScreen = '/vendor_profile_screen';
  static const String vendorServicesScreen = '/vendor_services_screen';
  static const String bookingStatusScreen = '/booking_status_screen';
  static const String accountsAndManagementScreen = '/accounts_and_management_screen';



  static const String boatHireServiceScreen = '/boat_hire_service_screen';
  
  // Legacy Routes (Consider deprecating)
  static const String loginVendorView = '/login_view';
  static const String registerVendorView = '/vendor_signup_view';
}
