import 'package:shared_preferences/shared_preferences.dart';

SessionManageerUserSide sessionManageerUserSide=SessionManageerUserSide();

class SessionManageerUserSide{


  setUserSessionManage(data) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    data.forEach((key,value) async {
      await prefs.setString(key, value);
    });
  }
Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId") ?? "";
    print("Retrieved User ID: $userId");
    return userId;
  }
  Future<void> setHasSeenOnboarding(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("hasSeenOnboarding", value);
  }
  Future<bool> getHasSeenOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("hasSeenOnboarding") ?? false;
  }


  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("usertoken") ?? "";
    print("Retrieved User Token: $token");
    return token;
  
}

 Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("usertoken");
  }

  Future<String> getCountryCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   return await prefs.getString("country_code").toString() ?? "";
  }


  Future<String> getMobileNo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   return await prefs.getString("mobile_no").toString();
  }

  Future<String> getRoleType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   return await prefs.getString("role_type").toString();
  }

  Future<String> setRoleType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   return await prefs.setString("role_type","").toString();
  }

  Future<String> getUserImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   return await prefs.getString("user_image").toString() ?? "";
  }
  Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   return await prefs.getString("name").toString();
  }

  Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   return await prefs.getString("email").toString() ?? "";
  }



  setAddress(address) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("address",'$address').toString() ?? "";
  }

  Future<String> getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString("address").toString() ?? "";
  }

  Future<String> getGender() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString("gender").toString() ?? "";
  }

  Future<String> setAddressId(addressId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("addressId",addressId).toString() ?? "";
  }

  Future<String> getAddressId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString("addressId").toString() ?? "";
  }

  Future<String> setLatitude(latitude) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("latitude",latitude).toString() ?? "";
  }

  Future<String> getLatitude() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString("latitude").toString() ?? "";
  }

  Future<String> setLongitude(longitude) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("longitude",longitude).toString() ?? "";
  }

  Future<String> getLongitude() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString("longitude").toString() ?? "";
  }

  Future<String> getStreet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString("street").toString() ?? "";
  }

  Future<String> setStreet(street) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("street",street).toString() ?? "";
  }

  Future<String> getPincode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString("pincode").toString() ?? "";
  }
  Future<String> setPincode(pincode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("pincode",pincode).toString() ?? "";
  }




}



