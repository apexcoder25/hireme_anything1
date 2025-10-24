import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/User_app/views/HomePage/home_page.dart';
import 'package:hire_any_thing/User_app/views/UserHomePage/user_home_page.dart';
import 'package:hire_any_thing/User_app/views/main_dashboard/components/user_drawer.dart';
import 'package:hire_any_thing/User_app/views/main_dashboard/controllers/user_dashboard_controller.dart';
import 'package:hire_any_thing/User_app/views/user_profle/user_profle_screen.dart';
import 'package:hire_any_thing/User_app/views/user_booking_screen/views/my_booking_screen.dart';
import 'package:hire_any_thing/User_app/views/AboutScreen/about_screen.dart';
import 'package:hire_any_thing/User_app/views/contactUs_screen/contact_us.dart';
import 'package:hire_any_thing/User_app/views/whyChooseUsScreen/why_choose_us_screen.dart';
import 'package:hire_any_thing/utilities/colors.dart';

class UserMainDashboard extends StatelessWidget {
  final UserDashboardController controller = Get.put(UserDashboardController());

  UserMainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: _buildAppBar(),
      drawer: UserDrawer(controller: controller),
      body: Obx(() => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.1, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
            child: _getCurrentScreen(),
          )),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.primaryDark,
      foregroundColor: Colors.white,
      title: Obx(() => Text(
            _getAppBarTitle(),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          )),
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(Icons.menu, color: Colors.white),
        ),
      ),
    );
  }

  String _getAppBarTitle() {
    switch (controller.selectedIndex.value) {
      case 0:
        return 'Home';
      case 1:
        return 'My Bookings';
      case 2:
        return 'Why Choose Us';
      case 3:
        return 'Book Services';
      case 4:
        return 'My Profile';
      case 5:
        return 'Contact Us';
      case 6:
        return 'About Us';
      default:
        return 'Home';
    }
  }

  Widget _getCurrentScreen() {
    switch (controller.selectedIndex.value) {
      case 0:
        return UserHomePageScreen();
      case 1:
        return MyBookingsScreen();
      case 2:
        return WhyChooseUsScreen();
      case 3:
        return ServicesScreen();
      case 4:
        return UserProfileScreen();
      case 5:
        return const ContactUsScreen();
      case 6:
        return const AboutScreen();
      default:
        return UserHomePageScreen();
    }
  }
}
