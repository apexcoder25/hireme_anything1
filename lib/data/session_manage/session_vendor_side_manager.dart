import 'package:shared_preferences/shared_preferences.dart';

class SessionVendorSideManager {

  setVendorSessionManage(data) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    data.forEach((key,value) async {
      await prefs.setString(key, value);
    });
  }
  deleteSession() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }


Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  print("hello");
  return prefs.getString("token") ?? ""; // Retrieves the stored vendorId
}
Future<String?> getVendorId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("vendorId"); // Retrieves the stored vendorId
}

  Future<String> getcategoryId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString("categoryId").toString() ?? "";
  }
  Future<String> getCityName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString("city_name").toString() ?? "";
  }

  Future<void> clearSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); 
  }

}



