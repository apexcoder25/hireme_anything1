import 'package:get/get.dart';
import 'package:hire_any_thing/User_app/views/user_profle/controller/user_profile_controller.dart';
import 'package:hire_any_thing/data/api_service/user_bookings_api.dart';
import 'package:hire_any_thing/data/models/user_side_model/user_booking_model.dart';
import 'package:hire_any_thing/res/routes/routes.dart';

class UserBookingController extends GetxController {
  final UserBookingApi _bookingApi = UserBookingApi();

  // Observable variables
  var bookings = <BookingDetails>[].obs;
  var isLoading = false.obs;
  var isCreating = false.obs;
  var isCancelling = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Add a small delay to ensure dependencies are loaded
    Future.delayed(Duration(milliseconds: 100), () {
      fetchUserBookings();
    });
  }

  Future<void> fetchUserBookings() async {
    try {
      isLoading.value = true;

      // Check if user is still logged in - use safe approach
      UserProfileController? profileController;
      try {
        profileController = Get.find<UserProfileController>();
      } catch (e) {
        print("UserProfileController not found: $e");
        // If profile controller is not found, continue with API call
      }

      // If profile controller exists and user is not logged in, redirect
      if (profileController != null && !profileController.isLogin.value) {
        print("User not logged in, redirecting to login");
        Get.offAllNamed(UserRoutesName.loginUserView);
        return;
      }

      final result = await _bookingApi.getUserBookings();
      print("API Response: $result");
      bookings.assignAll(result);
    } catch (e) {
      print("Error fetching bookings: $e");
      
      // Handle 401 specifically
      if (e.toString().contains("401") ||
          e.toString().contains("User not found")) {
        print("Session expired, logging out user");
        try {
          final profileController = Get.find<UserProfileController>();
          await profileController.logout();
        } catch (controllerError) {
          print("Error accessing profile controller for logout: $controllerError");
        }
        Get.offAllNamed(UserRoutesName.loginUserView);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> cancelBooking(String bookingId) async {
    try {
      isCancelling.value = true;
      final success = await _bookingApi.cancelBooking(bookingId);
      if (success) {
        await fetchUserBookings();
      }
      return success;
    } finally {
      isCancelling.value = false;
    }
  }
}
