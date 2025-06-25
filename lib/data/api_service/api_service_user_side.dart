import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/session_manage/session_user_side_manage.dart';
import 'package:hire_any_thing/global_file.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Auth/phoneLogin.dart';
import '../../views/generalinformation.dart';
import '../getx_controller/user_side/auth_user_getx_controller.dart';
import '../getx_controller/user_side/user_basic_getx_controller.dart';

final AuthUserGetXController authUserGetXController =
    Get.put(AuthUserGetXController());

final UserBasicGetxController userBasicGetxController =
    Get.put(UserBasicGetxController());

ApiServiceUserSide apiServiceUserSide = ApiServiceUserSide();

class ApiServiceUserSide {
  Future<void> userLoginSignup(Map<String, dynamic>? requestedData) async {
    try {
      print("requestedData=>${requestedData}");
      final response = await http.post(Uri.parse(appUrlsUserSide.signup),
          body: requestedData);

      print("userLoginSignup=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("userLoginSignup=data=>${data}");

        Future.microtask(
            () => authUserGetXController.setUserSideDetailsModel(data));
        Get.to(OtpPage());
      } else {
        print('UserLoginSignup Failed to load terms and conditions');
      }
    } catch (e) {
      print('UserLoginSignup Error: $e');
    }
  }
Future<bool> userLogin(Map<String, dynamic> data) async {
  try {
    var response = await http.post(
      Uri.parse(appUrlsUserSide.login),
      body: data,
    );

    print('Login Response Status Code: ${response.statusCode}');
    print('Login Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      // Validate the response structure
      if (responseData is Map<String, dynamic>) {
        final token = responseData["token"];
        final userId = responseData["user"]?["id"];

        // Log the extracted values
        print("Extracted Token: $token");
        print("Extracted User ID: $userId");

        // Check if token and userId are present
        if (token == null || userId == null) {
          Get.snackbar(
            "Error",
            "Invalid response: Token or User ID missing",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
            borderRadius: 8.0,
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 3),
          );
          return false;
        }

        // Store token and userId in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("usertoken", token.toString());
        await prefs.setString("userId", userId.toString());

        // Verify storage by retrieving the values
        print("Stored Token: ${await prefs.getString("usertoken")}");
        print("Stored User ID: ${await prefs.getString("userId")}");

        Get.snackbar(
          "Success",
          "User Login Successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 5, 129, 69),
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );

        return true;
      } else {
        print("Invalid response format: $responseData");
        Get.snackbar(
          "Error",
          "Invalid response format from server",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
        return false;
      }
    } else {
      Get.snackbar(
        "Error",
        "Login failed with status code: ${response.statusCode}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        borderRadius: 8.0,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
      return false;
    }
  } catch (e) {
    print("Login Error: $e");
    Get.snackbar(
      "Error",
      "Some Error Occurred: $e",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      borderRadius: 8.0,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
    return false;
  }}

  Future<void> userVerify(Map<String, dynamic>? requestedData) async {
    try {
      print("userVerify=>${requestedData}");
      final response = await http.post(Uri.parse(appUrlsUserSide.verifyOtp),
          body: requestedData);

      print("userVerify=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("userVerify=data=>${data}");

        authUserGetXController.setUserSideDetailsModel(data);

        if (authUserGetXController.userSideDetailsModel.name == "") {
          Get.offAll(() => GeneralInformation(
                userId: authUserGetXController.userSideDetailsModel.userId,
              ));
        } else {
          print("jsonData[data]=>${jsonData["data"]}");
          sessionManageerUserSide.setUserSessionManage(jsonData["data"]);
          // Get.offAll(() => Navi());
        }
      } else {
        Get.snackbar(
          "Invalid Otp", // Title of the Snackbar
          "Please Enter Valid Otp", // Message to display
          snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
          backgroundColor: Colors.redAccent, // Background color
          colorText: Colors.white, // Text color
          borderRadius: 8.0, // Border radius for rounding corners
          margin: const EdgeInsets.all(16), // Padding around the snackbar
          duration:
              Duration(seconds: 3), // How long the snackbar will be visible
        );
        print('userVerify Failed to load terms and conditions');
      }
    } catch (e) {
      print('userVerify Error: $e');
    }
  }

  Future updateUserProfile(
      userId, imagePath, name, email, token, gender) async {
    print("sadas");
    final sessionManager =
        await SessionManageerUserSide(); // Initialize session manager
    dynamic token = await sessionManager.getToken();

    var urlParse = Uri.parse(appUrlsUserSide.updateUserProfile);
    var response = http.MultipartRequest("POST", urlParse);
    response.fields["token"] = token;
    response.fields['userId'] = "$userId";
    response.fields['name'] = "$name";
    response.fields['email'] = "$email";
    response.fields['token'] = "$token";
    response.fields['gender'] = "$gender";

    print("imagePath=>$imagePath");
    print("name=>${name}");
    print("email=>${email}");
    print("token=>${token}");

    if (imagePath != "") {
      response.files.add(await http.MultipartFile.fromPath(
        'user_image',
        imagePath,
        contentType: MediaType('image', 'jpg'),
      ));
    }

    var request = await response.send();
    var responseData = await request.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    if (imagePath != "") {
      var imageFile = File(imagePath);
      print("Yes_image=>${imagePath}");
      response.files.add(await http.MultipartFile.fromPath(
        'user_image',
        imagePath,
        contentType: MediaType(
          'user_image',
          'jpeg',
        ),
      ));
    }

    // dynamic jsondata = responseString;
    print("updateUserProfile_responseString=>${responseString}");
    var jsondata = json.decode(responseString);

    print("updateUserProfile_jsondata[result] => ${jsondata["result"]}");

    if (jsondata["result"] == "true") {
      sessionManageerUserSide.setUserSessionManage(jsondata["data"]);

      // Get.offAll(() => Navi());
    }
  }

  Future<void> resendOtp(Map<String, dynamic>? requestedData) async {
    try {
      print("resendOtp=>${requestedData}");
      final response = await http.post(Uri.parse(appUrlsUserSide.resendOtp),
          body: requestedData);

      print("resendOtp=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("resendOtp=data=>${data}");

        authUserGetXController.setUserSideDetailsModel(data);
      }
    } catch (e) {
      print('userVerify Error: $e');
    }
  }

  Future<void> vendorServiceList(Map<String, dynamic>? requestedData) async {
    try {
      final sessionManager =
          await SessionManageerUserSide(); // Initialize session manager

      dynamic userId = await sessionManager.getUserId();
      requestedData!["userId"] = userId;
      // print("vendorServiceList=>${requestedData}");
      final response = await http.post(
          Uri.parse(appUrlsUserSide.vendorServiceList),
          body: requestedData);

      // print("vendorServiceList=response=>${response.body}");

      final jsonData = jsonDecode(response.body);
      final data = jsonData['data'];
      if (jsonData["result"] == "true") {
        // print("vendorServiceList=data=>${data}");

        userBasicGetxController.setServiceList(data);
      } else {
        print("Error_vendorServiceList=data=>${data}");
        userBasicGetxController.setServiceList(data);
      }
    } catch (e) {
      print('vendorServiceList Error: $e');
    }
  }

  // add user address from current location
  Future<void> addUserAddress(Map<String, dynamic>? requestedData) async {
    final sessionManager =
        await SessionManageerUserSide(); // Initialize session manager

    dynamic userId = await sessionManager.getUserId();
    dynamic token = await sessionManager.getToken();

    // Todo

    requestedData!["userId"] = userId;

    requestedData!["token"] = token;

    try {
      print("resendOtp=>${requestedData}");
      final response = await http
          .post(Uri.parse(appUrlsUserSide.addUserAddress), body: requestedData);

      print("resendOtp=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("resendOtp=data=>${data}");
        await sessionManager.setAddressId(data["addressId"]);
        await sessionManager.setAddress(data["address"]);
        await sessionManager.setLatitude(data["latitude"]);
        await sessionManager.setLongitude(data["longitude"]);
        await sessionManager.setPincode(data["pincode"]);
        await sessionManager.setStreet(data["street"]);
      }
    } catch (e) {
      print('userVerify Error: $e');
    }
  }

  Future<void> addEnquiry(Map<String, dynamic>? requestedData) async {
    final sessionManager =
        await SessionManageerUserSide(); // Initialize session manager

    dynamic userId = await sessionManager.getUserId();
    dynamic token = await sessionManager.getToken();

    // Todo

    requestedData!["userId"] = userId;

    requestedData!["token"] = token;

    try {
      print("addEnquiry=>${requestedData}");

      final response = await http.post(Uri.parse(appUrlsUserSide.addEnquiry),
          body: requestedData);

      print("addEnquiry=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("addEnquiry=data=>${data}");

        Future.microtask(() => userBasicGetxController.setHomePageNavigation(2))
            .whenComplete(() {
          // Get.to(Navi());
        });
      }
    } catch (e) {
      print('addEnquiry Error: $e');
    }
  }

  // get user profile
  Future<void> getUserProfile(Map<String, dynamic>? requestedData) async {
    final sessionManager =
        await SessionManageerUserSide(); // Initialize session manager

    dynamic userId = await sessionManager.getUserId();
    dynamic token = await sessionManager.getToken();

    // Todo

    requestedData!["userId"] = userId;

    requestedData!["token"] = token;

    try {
      print("userProfile=>${requestedData}");
      final response = await http.post(Uri.parse(appUrlsUserSide.userProfile),
          body: requestedData);

      print("userProfile=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("userProfile=data=>${data}");

        await sessionManager.setAddress(data["address"]);
      }
    } catch (e) {
      print('userProfile Error: $e');
    }
  }

  // get user profile

  Future<void> getHomeFirstBanner() async {
    final sessionManager =
        await SessionManageerUserSide(); // Initialize session manager

    dynamic userId = await sessionManager.getUserId();
    dynamic token = await sessionManager.getToken();

    try {
      final response = await http
          .get(Uri.parse("${appUrlsUserSide.bannerList}?token=$token"));

      print("getHomeFirstBanner=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("getHomeFirstBanner=data=>${data}");
        userBasicGetxController.setGetHomebannerFirstList(data);

        // await sessionManager.setAddress(data["address"]);
      }
    } catch (e) {
      print('getHomeFirstBanner Error: $e');
    }
  }

  Future<void> getHomeFooterBanner() async {
    final sessionManager =
        await SessionManageerUserSide(); // Initialize session manager

    dynamic userId = await sessionManager.getUserId();

    dynamic token = await sessionManager.getToken();

    try {
      final response = await http
          .get(Uri.parse("${appUrlsUserSide.bannerFooterList}?token=$token"));

      print("getHomeFooterBanner=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];

        print("getHomeFooterBanner=data=>${data}");

        userBasicGetxController.setGetHomeFooterbannerFirstList(data);
      }
    } catch (e) {
      print('getHomeFooterBanner Error: $e');
    }
  }

  Future<void> getOfferList() async {
    final sessionManager =
        await SessionManageerUserSide(); // Initialize session manager

    dynamic userId = await sessionManager.getUserId();
    dynamic token = await sessionManager.getToken();

    try {
      final response = await http
          .get(Uri.parse("${appUrlsUserSide.offerList}?token=$token"));

      print("getOfferList=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("getOfferList=data=>${data}");
        userBasicGetxController.setOffersListList(data);

        // await sessionManager.setAddress(data["address"]);
      }
    } catch (e) {
      print('getOfferList Error: $e');
    }
  }

  Future<void> getCategoryList() async {
    final sessionManager =
        await SessionManageerUserSide(); // Initialize session manager

    dynamic userId = await sessionManager.getUserId();
    dynamic token = await sessionManager.getToken();

    try {
      final response = await http.post(
          Uri.parse("${appUrlsUserSide.categoryList}"),
          body: {"token": "$token"});

      print("getCategoryList=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("getCategoryList=data=>${data}");
        userBasicGetxController.setCategoryList(data);

        // await sessionManager.setAddress(data["address"]);
      }
    } catch (e) {
      print('getCategoryList Error: $e');
    }
  }

  Future<void> getSubcategoryBannerList(Map<String, dynamic>? data) async {
    final sessionManager =
        await SessionManageerUserSide(); // Initialize session manager

    dynamic userId = await sessionManager.getUserId();
    dynamic token = await sessionManager.getToken();

    data!["token"] = token;

    try {
      final response = await http
          .post(Uri.parse("${appUrlsUserSide.categoryBannerList}"), body: data);

      print("getSubcategoryBannerList=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("getSubcategoryBannerList=data=>${data}");
        userBasicGetxController.setCategoryBannerList(data);
        userBasicGetxController.setCategoryName(jsonData["category_name"]);

        // await sessionManager.setAddress(data["address"]);
      } else {
        userBasicGetxController.setCategoryName(jsonData["category_name"]);
      }
    } catch (e) {
      print('getSubcategoryBannerList Error: $e');
    }
  }

  Future<void> getSubcategoryList(Map<String, dynamic>? data) async {
    final sessionManager =
        await SessionManageerUserSide(); // Initialize session manager

    dynamic userId = await sessionManager.getUserId();
    dynamic token = await sessionManager.getToken();

    data!["token"] = token;

    try {
      final response = await http
          .post(Uri.parse("${appUrlsUserSide.subcategoryList}"), body: data);

      print("getSubcategoryList=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("getSubcategoryList=data=>${data}");
        userBasicGetxController.setSubCategoryList(data);

        // await sessionManager.setAddress(data["address"]);
      }
    } catch (e) {
      print('getSubcategoryList Error: $e');
    }
  }

  Future<void> updateUserAddress(Map<String, dynamic>? data) async {
    final sessionManager =
        await SessionManageerUserSide(); // Initialize session manager

    // dynamic userId=await sessionManager.getUserId();
    dynamic token = await sessionManager.getToken();
    dynamic getAddressId = await sessionManager.getAddressId();

    data!["addressId"] = getAddressId;
    data!["token"] = token;

    try {
      final response = await http
          .post(Uri.parse("${appUrlsUserSide.updateUserAddress}"), body: data);

      print("updateUserAddress=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("updateUserAddress=data=>${data}");
        await sessionManager.setAddressId(data["addressId"]);
        await sessionManager.setAddress(data["address"]);
        await sessionManager.setLatitude(data["latitude"]);
        await sessionManager.setLongitude(data["longitude"]);
        await sessionManager.setPincode(data["pincode"]);
        await sessionManager.setStreet(data["street"]);
      }
    } catch (e) {
      print('updateUserAddress Error: $e');
    }
  }

  Future<void> getFAQ() async {
    final sessionManager =
        await SessionManageerUserSide(); // Initialize session manager

    dynamic userId = await sessionManager.getUserId();
    dynamic token = await sessionManager.getToken();

    Map<String, dynamic>? data;

    data?["token"] = token;

    try {
      final response =
          await http.post(Uri.parse("${appUrlsUserSide.faqList}"), body: data);

      print("getFAQ=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("getFAQ=data=>${data}");
        userBasicGetxController.setFaqModelsListList(data);

        // await sessionManager.setAddress(data["address"]);
      }
    } catch (e) {
      print('getFAQ Error: $e');
    }
  }

  Future<void> getCommenTermsPrivacyAboutusModelList(
      appUrlommenTermsPrivacyAboutusModelList) async {
    final sessionManager =
        await SessionManageerUserSide(); // Initialize session manager

    dynamic userId = await sessionManager.getUserId();
    dynamic token = await sessionManager.getToken();

    Map<String, dynamic>? data;

    data?["token"] = token;

    try {
      final response = await http.post(
          Uri.parse("${appUrlommenTermsPrivacyAboutusModelList}"),
          body: data);

      print("getCommenTermsPrivacyAboutusModelList=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("getCommenTermsPrivacyAboutusModelList=data=>${data}");
        userBasicGetxController.setCommenTermsPrivacyAboutusModel(data[0]);

        // await sessionManager.setAddress(data["address"]);
      }
    } catch (e) {
      print('getCommenTermsPrivacyAboutusModelList Error: $e');
    }
  }

  Future<void> addFavouriteServiceList(
      Map<String, dynamic>? requestedData) async {
    final sessionManager =
        await SessionManageerUserSide(); // Initialize session manager

    dynamic userId = await sessionManager.getUserId();
    dynamic token = await sessionManager.getToken();

    Map<String, dynamic>? data;

    data?["token"] = token;

    try {
      final response = await http.post(
          Uri.parse("${appUrlsUserSide.addFavouriteService}"),
          body: data);

      print("addFavouriteService=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("addFavouriteService=data=>${data}");
        userBasicGetxController.setCommenTermsPrivacyAboutusModel(data[0]);

        // await sessionManager.setAddress(data["address"]);
      }
    } catch (e) {
      print('addFavouriteService Error: $e');
    }
  }

  
  Future<bool> contactUs(Map<String, dynamic> data) async {
  try {
    var response = await http.post(
      Uri.parse(appUrlsUserSide.contact),
      body: data,
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body); 

   Get.snackbar(
        "Success", 
        "Enquiry Submitted Successfully.", 
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color.fromARGB(255, 5, 129, 69), 
        colorText: Colors.white, 
        borderRadius: 8.0, 
        margin: const EdgeInsets.all(16), 
        duration: const Duration(seconds: 3),
      );

      return true;
    }
  } catch (e) {
    print(e);
    Get.snackbar(
      "Error",
      "Some Error Occurred!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      borderRadius: 8.0,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }
  return false;
}
}
