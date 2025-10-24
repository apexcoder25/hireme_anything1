import 'package:get/get.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/service_controller.dart';

class VendorDashboardController extends GetxController {
  var selectedIndex = 0.obs;
  var isRefreshing = false.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void refreshCurrentScreen() async {
    isRefreshing.value = true;
    
    try {
      // Add refresh logic based on current screen
      switch (selectedIndex.value) {
        case 0:
          // Refresh dashboard
          final serviceController = Get.find<ServiceController>();
          serviceController.fetchServices();
          break;
        case 1:
          // Refresh profile
          // Add profile refresh logic if needed
          break;
        case 2:
          // Refresh services
          break;
        case 3:
          // Refresh bookings
          
          break;
        case 4:
          // Refresh accounts
          break;
      }
      
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      print('Refresh error: $e');
    } finally {
      isRefreshing.value = false;
    }
  }

  String getCurrentRoute() {
    switch (selectedIndex.value) {
      case 0:
        return '/vendor_dashboard';
      case 1:
        return '/vendor_profile_screen';
      case 2:
        return '/vendor_services_screen';
      case 3:
        return '/booking_status_screen';
      case 4:
        return '/accounts_and_management_screen';
      default:
        return '/vendor_dashboard';
    }
  }
}
