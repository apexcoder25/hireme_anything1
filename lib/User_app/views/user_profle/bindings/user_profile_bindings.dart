import 'package:get/get.dart';
import 'package:hire_any_thing/User_app/views/user_profle/controller/user_profile_controller.dart';

class UserProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileController>(
      () => UserProfileController(),
    );
  }
}