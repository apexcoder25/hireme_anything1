import 'package:hire_any_thing/Vendor_App/view/Navagation_bar.dart';
import 'package:hire_any_thing/Vendor_App/view/login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash_controller extends GetxController {
  String? id;
  void setId(String? newId) {
    id = newId;
  }

  @override
  void onInit() {
    navigtohome();
    super.onInit();
  }

  void navigtohome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    print('ID from SharedPreferences splash : $id');

    await Future.delayed(Duration(milliseconds: 1000), () {});
    if (id != null) {
      Get.offAll(Nav_bar());
    } else {
      Get.offAll(Login());
    }
  }
}
