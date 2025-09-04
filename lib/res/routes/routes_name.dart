import 'package:get/get.dart';
import 'package:hire_any_thing/Auth/agree.dart';
import 'package:hire_any_thing/Auth/user_login_view.dart';
import 'package:hire_any_thing/Vendor_App/view/accounts_and_payment/accounts_and_payment.dart';
import 'package:hire_any_thing/Vendor_App/view/login_view.dart/login_view.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/vendor_home_Page.dart';
import 'package:hire_any_thing/Vendor_App/view/signup%20form/user_signup_view.dart';
import 'package:hire_any_thing/Vendor_App/view/signup%20form/vendor_signup_view.dart';
import 'package:hire_any_thing/res/routes/routes.dart';
import 'package:hire_any_thing/views/About/about_screen.dart';
import 'package:hire_any_thing/views/Category/categories_view_all_screen.dart';
import 'package:hire_any_thing/views/HomePage/home_page.dart';
import 'package:hire_any_thing/views/Introduction/introduction_screen.dart';
import 'package:hire_any_thing/views/UserHomePage/user_home_page.dart';
import 'package:hire_any_thing/views/about_services/artist_hire_screen.dart';
import 'package:hire_any_thing/views/about_services/meeting_room_hire.dart';
import 'package:hire_any_thing/views/about_services/passenger_transport_hire_screen.dart';
import 'package:hire_any_thing/views/about_services/tutor_hire_details.dart';
import 'package:hire_any_thing/views/contactUs/contact_us.dart';
import 'package:hire_any_thing/views/payment_success/payment_succes.dart';
import 'package:hire_any_thing/views/user_booking_details/views/my_booking_screen.dart';
import 'package:hire_any_thing/views/user_profle/user_profle_screen.dart';
import 'package:hire_any_thing/views/why_choose_us_screen/why_choose_us_screen.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
            name: UserRoutesName.introScreen,
            page: () => IntroductionScreen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
        GetPage(
            name: UserRoutesName.loginUserView,
            page: () => UserLoginScreeen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
        GetPage(
            name: UserRoutesName.registerUserView,
            page: () => UserSignUp(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
        GetPage(
            name: UserRoutesName.homeUserView,
            page: () => UserHomePageScreen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
        GetPage(
            name: UserRoutesName.tutorHireScreen,
            page: () => TutorHireScreen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
        GetPage(
            name: UserRoutesName.passengerTransportHireScreen,
            page: () => PassengerTransportHireDetailsScreen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
        GetPage(
            name: UserRoutesName.artistHireScreen,
            page: () => ArtistHireDetailsScreen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
        GetPage(
            name: UserRoutesName.userProfleScreen,
            page: () => UserProfileScreen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
        GetPage(
            name: UserRoutesName.userBookingsDetailsScreen,
            page: () => MyBookingsScreen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
        GetPage(name: '/home', page: () => UserHomePageScreen()),
        GetPage(name: '/login', page: () => const Agree_screen()),
        GetPage(name: '/services', page: () => ServicesScreen()),
        GetPage(name: '/contact', page: () => const ContactUsScreen()),
        GetPage(name: '/about', page: () => const AboutScreen()),
        GetPage(
            name: VendorRoutesName.loginVendorView,
            page: () => VendorLoginScreen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
        GetPage(
            name: VendorRoutesName.homeVendorView,
            page: () => HomePageAddService(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
        GetPage(
            name: VendorRoutesName.accountsAndManagementScreen,
            page: () => AccountsAndManagementScreen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
        GetPage(
            name: VendorRoutesName.registerVendorView,
            page: () => VendorSignUp(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
        GetPage(
            name: UserRoutesName.allCategoryView,
            page: () => CategoryGridPage(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
        GetPage(
            name: UserRoutesName.paymentSuccess,
            page: () => PaymentSuccessScreen(orderId: Get.arguments['orderId']),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
        GetPage(
            name: UserRoutesName.MeetingRoomHireScreen,
            page: () => MeetingRoomHireScreen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
        GetPage(
            name: UserRoutesName.WhyChooseUsScreen,
            page: () => WhyChooseUsScreen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 250)),
      ];
}
