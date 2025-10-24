import 'package:get/get.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/category_controller.dart';

class UserDashboardController extends GetxController {
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
          // Refresh home
          try {
            final categoryController = Get.find<CategoryController>();
            categoryController.fetchCategories();
          } catch (e) {
            print('Category controller not found: $e');
          }
          break;
        case 1:
          // Refresh bookings
          try {

          }
          catch (e){
            print('not found new $e');
          }
          break;
        case 2:
          // Refresh bookings
          break;
        case 3:
          // Refresh bookings
          break;
        case 4:
          // Refresh profile
          break;
        case 5:
          // Refresh contact
          break;
        case 6:
          // Refresh about
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
        return '/user_home';
      case 1:
        return '/user_bookings';
      case 2:
        return '/why_choose_us';
      case 3:
        return 'book_services';
      case 4:
        return '/user_profile';
      case 5:
        return '/contact_us';
      case 6:
        return '/about_screen';
      default:
        return '/user_home';
    }
  }
}
