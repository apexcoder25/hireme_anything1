import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/add_service_screen_1.dart';
import 'package:hire_any_thing/Vendor_App/view/booking_status/booking_status_view.dart';
import 'package:hire_any_thing/Vendor_App/view/main_dashboard/components/vendor_drawer.dart';
import 'package:hire_any_thing/Vendor_App/view/main_dashboard/controllers/vendor_dashboard_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/profile_page.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/vendor_home_Page.dart';
import 'package:hire_any_thing/Vendor_App/view/accounts_and_payment/accounts_and_payment.dart';
import 'package:hire_any_thing/utilities/colors.dart';

class VendorMainDashboard extends StatelessWidget {
  final VendorDashboardController controller =
      Get.put(VendorDashboardController());

  VendorMainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // final apiService = Get.put(ApiServiceVenderSide());
    // final ProfileController profileController =
    //     Get.put(ProfileController(apiService: apiService));

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: _buildAppBar(),
      drawer: VendorDrawer(controller: controller),
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
        return 'Dashboard';
      case 1:
        return 'Vendor Profile';
      case 2:
        return 'Add Services';
      case 3:
        return 'Booking Status';
      case 4:
        return 'Account & Payment';
      default:
        return 'Dashboard';
    }
  }

  Widget _getCurrentScreen() {
    switch (controller.selectedIndex.value) {
      case 0:
        return HomePageAddService();
      case 1:
        return ProfilePage();
      case 2:
        return AddServiceScreenFirst();
      case 3:
        return BookingStatusScreen();
      case 4:
        return AccountsAndManagementScreen();
      default:
        return HomePageAddService();
    }
  }
}
