import 'package:get/get.dart';
import 'package:hire_any_thing/User_app/views/user_booking_screen/controller/user_booking_details_controller.dart';

class UserBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserBookingController>(
      () => UserBookingController(),
    );
  }
}