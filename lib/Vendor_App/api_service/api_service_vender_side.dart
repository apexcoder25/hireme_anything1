import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/Navagation_bar.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/add_service_screen_2.dart';
import 'package:hire_any_thing/Vendor_App/view/commonForAboutUsTermsPrivacyContactAountUsList.dart';
import 'package:hire_any_thing/constants_file/app_vendor_side_urls.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/vender_side_getx_controller.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/login.dart';
import '../view/verify_otp.dart';
import '../../data/session_manage/session_vendor_side_manager.dart';

AppUrlsVendorSide appUrlsVendorSide = AppUrlsVendorSide();

ApiServiceVenderSide apiServiceVenderSide = ApiServiceVenderSide();

final VenderSidetGetXController venderSidetGetXController =
    Get.put(VenderSidetGetXController());

final SessionVendorSideManager sessionVendorSideManager =
    SessionVendorSideManager();

class ApiServiceVenderSide {
  // Base URL for the API
  static const String _baseUrl = 'https://stag-api.hireanything.com';
  
  // API Endpoints
  static const String _checkEmailEndpoint = '/user/check-email';
  static const String _sendOtpEmailEndpoint = '/vendor/send-otp/';
  static const String _verifyOtpEmailEndpoint = '/vendor/verify-otp';
  static const String _sendOtpPhoneEndpoint = '/api/send-otp';
  static const String _verifyOtpPhoneEndpoint = '/api/verify-otp';
  static const String _vendorRegisterEndpoint = '/vendor/signup';
  static const String _vendorLoginEndpoint = '/vendor/partnerlogin';
  static const String _userRegisterEndpoint = '/user/register';
  static const String _addServiceVendorEndpoint = '/vendor/add_vendor_service';

  // Find Moter Claim Request Submit Form In DataBase Exit Or Not
  final StreamController<List<dynamic>> _serviceListController =
      StreamController<List<dynamic>>();

  Stream<List<dynamic>> get serviceListStream => _serviceListController.stream;

  // Helper method to build full URL
  String _buildUrl(String endpoint, {String? pathParam}) {
    if (pathParam != null) {
      return '$_baseUrl$endpoint/$pathParam';
    }
    return '$_baseUrl$endpoint';
  }

  Future<bool> checkEmail(String email) async {
    try {
      var response = await http.get(
          Uri.parse(_buildUrl(_checkEmailEndpoint, pathParam: email)));

      var jsondata = jsonDecode(response.body);
      print(jsondata);

      if (response.statusCode == 200) {
        if (jsondata['exists'] == false) {
          return true;
        } else if (jsondata["exists"] == true) {
          // Show Error
          Get.snackbar(
            "Exists", // Title of the Snackbar
            "This email already exists.", // Message to display
            snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
            backgroundColor: Colors.redAccent, // Background color
            colorText: Colors.white, // Text color
            borderRadius: 8.0, // Border radius for rounding corners
            margin: const EdgeInsets.all(16), // Padding around the snackbar
            duration: const Duration(
                seconds: 3), // How long the snackbar will be visible
          );
        }
      }
    } catch (e) {
      print("signupPageFirst=>$e");
    }
    return false;
  }

  Future<bool> sendOtpEmail(String email) async {
    try {
      var response = await http.post(
        Uri.parse(_buildUrl(_sendOtpEmailEndpoint)),
        body: {"email": email},
      );

      if (response.statusCode == 200) {
        // Show Success
        Get.snackbar(
          "Success", // Title of the Snackbar
          "OTP is sent successfully.", // Message to display
          snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
          backgroundColor:
              const Color.fromARGB(255, 5, 129, 69), // Background color
          colorText: Colors.white, // Text color
          borderRadius: 8.0, // Border radius for rounding corners
          margin: const EdgeInsets.all(16), // Padding around the snackbar
          duration: const Duration(
            seconds: 3,
          ), // How long the snackbar will be visible
        );

        return true;
      }
    } catch (e) {
      Get.snackbar(
        "Error", // Title of the Snackbar
        "Some Error Occured!", // Message to display
        snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
        backgroundColor: Colors.redAccent, // Background color
        colorText: Colors.white, // Text color
        borderRadius: 8.0, // Border radius for rounding corners
        margin: const EdgeInsets.all(16), // Padding around the snackbar
        duration:
            const Duration(seconds: 3), // How long the snackbar will be visible
      );
    }
    return false;
  }

  Future<bool> verifyOtpEmail(String email, String otp) async {
    try {
      var response = await http.post(
        Uri.parse(_buildUrl(_verifyOtpEmailEndpoint)),
        body: {"email": email, "otp": otp},
      );

      if (response.statusCode == 200) {
        // Show Success
        Get.snackbar(
          "Success", // Title of the Snackbar
          "OTP verified successfully.", // Message to display
          snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
          backgroundColor: Color.fromARGB(255, 5, 129, 69), // Background color
          colorText: Colors.white, // Text color
          borderRadius: 8.0, // Border radius for rounding corners
          margin: const EdgeInsets.all(16), // Padding around the snackbar
          duration: const Duration(
              seconds: 4), // How long the snackbar will be visible
        );
        return true;
      }
    } catch (e) {
      Get.snackbar(
        "Error", // Title of the Snackbar
        "Some Error Occured!", // Message to display
        snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
        backgroundColor: Colors.redAccent, // Background color
        colorText: Colors.white, // Text color
        borderRadius: 8.0, // Border radius for rounding corners
        margin: const EdgeInsets.all(16), // Padding around the snackbar
        duration:
            const Duration(seconds: 3), // How long the snackbar will be visible
      );
    }
    return false;
  }

  Future<bool> verifyOtpPhone(
      String phone, String countryCode, String otp) async {
    try {
      var response = await http.post(
        Uri.parse(_buildUrl(_verifyOtpPhoneEndpoint)),
        body: {
          "phoneNumber": phone,
          "countryCode": countryCode,
          "otp": otp,
        },
      );

      if (response.statusCode == 200) {
        // Show Success
        Get.snackbar(
          "Success", // Title of the Snackbar
          "OTP verified successfully.", // Message to display
          snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
          backgroundColor: Color.fromARGB(255, 5, 129, 69), // Background color
          colorText: Colors.white, // Text color
          borderRadius: 8.0, // Border radius for rounding corners
          margin: const EdgeInsets.all(16), // Padding around the snackbar
          duration: const Duration(
              seconds: 4), // How long the snackbar will be visible
        );
        return true;
      }
    } catch (e) {
      Get.snackbar(
        "Error", // Title of the Snackbar
        "Some Error Occured!", // Message to display
        snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
        backgroundColor: Colors.redAccent, // Background color
        colorText: Colors.white, // Text color
        borderRadius: 8.0, // Border radius for rounding corners
        margin: const EdgeInsets.all(16), // Padding around the snackbar
        duration:
            const Duration(seconds: 4), // How long the snackbar will be visible
      );
    }
    return false;
  }

  Future<bool> sendOtpPhone(String phone, String countryCode) async {
    try {
      var response = await http.post(
        Uri.parse(_buildUrl(_sendOtpPhoneEndpoint)),
        headers: {
          "Content-Type": "application/json", // Add Content-Type header
        },
        body: jsonEncode({"phoneNumber": phone, "countryCode": countryCode}), // JSON-encode the body
      );

      print("Send OTP Response Status: ${response.statusCode}");
      print("Send OTP Response Body: ${response.body}");

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "OTP is sent successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 5, 129, 69),
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 4),
        );
        return true;
      } else {
        Get.snackbar(
          "Error",
          "Failed to send OTP. Status: ${response.statusCode}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 4),
        );
        return false;
      }
    } catch (e) {
      print("Error sending OTP: $e");
      Get.snackbar(
        "Error",
        "Some Error Occurred: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        borderRadius: 8.0,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
      );
      return false;
    }
  }
  
  Future<bool> vendorRegisterUser(Map<String, dynamic> data) async {
    try {
      var response = await http.post(
        Uri.parse(_buildUrl(_vendorRegisterEndpoint)),
        body: data,
      );
      print('response.body=>${response.body}');
      print( 'response.statusCode=>${response.statusCode}');

      if (response.statusCode == 201) {
        Get.snackbar(
          "Success", 
          "User Registered Successfully.", 
          snackPosition: SnackPosition.BOTTOM, 
          backgroundColor: Color.fromARGB(255, 5, 129, 69),
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16), 
          duration: const Duration(
              seconds: 3), 
        );
        return true;
      }
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success", 
          "User Registered Successfully.", 
          snackPosition: SnackPosition.BOTTOM, 
          backgroundColor: Color.fromARGB(255, 5, 129, 69),
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16), 
          duration: const Duration(
              seconds: 3), 
        );
        return true;
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        "Error", // Title of the Snackbar
        "Some Error Occured!", // Message to display
        snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
        backgroundColor: Colors.redAccent, // Background color
        colorText: Colors.white, // Text color
        borderRadius: 8.0, // Border radius for rounding corners
        margin: const EdgeInsets.all(16), // Padding around the snackbar
        duration:
            const Duration(seconds: 3), // How long the snackbar will be visible
      );
    }
    // finally{
    //   print("Vendor Register User API called");
    // }
    return false;
  }

  Future<bool> vendorLogin(Map<String, dynamic> data) async {
    try {
      print("ta dlmpped??");
      var response = await http.post(
        Uri.parse(_buildUrl(_vendorLoginEndpoint)),
        body: data,
      );

      print(response.body);
      print("response.statusCode=>${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body); // Parse JSON response

        final token = responseData["token"];
        final vendorId = responseData["partner"]?["id"]; // Access id under partner key

        // Print the token and vendor id
        print("Token: $token");
        print("Vendor ID: $vendorId");

        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", token); // Store token in SharedPreferences
        }

        if (vendorId != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("vendorId", vendorId); // Store vendorId in SharedPreferences
          print(vendorId); // Store vendorId in SharedPreferences
        }

        // Show Success Message
        Get.snackbar(
          "Success", 
          "Partner Login Successfully.", 
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(255, 5, 129, 69), 
          colorText: Colors.white, 
          borderRadius: 8.0, 
          margin: const EdgeInsets.all(16), 
          duration: const Duration(seconds: 3),
        );

        return true;
      }
      else if (response.statusCode == 401) {
        final responseData = jsonDecode(response.body); // Parse JSON response
        final message = responseData["message"];
        
        Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        borderRadius: 8.0,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ); // Access message key
      }
      else{
        
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

  Future<bool> registerUser(Map<String, dynamic> data) async {
    try {
      var response = await http.post(
        Uri.parse(_buildUrl(_userRegisterEndpoint)),
        body: data,
      );
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        // Show Success
        Get.snackbar(
          "Success", // Title of the Snackbar
          "User Registered Successfully.", // Message to display
          snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
          backgroundColor: Color.fromARGB(255, 5, 129, 69), // Background color
          colorText: Colors.white, // Text color
          borderRadius: 8.0, // Border radius for rounding corners
          margin: const EdgeInsets.all(16), // Padding around the snackbar
          duration: const Duration(
              seconds: 3), // How long the snackbar will be visible
        );
        return true;
      }
    } catch (e) {
      Get.snackbar(
        "Error", // Title of the Snackbar
        "Some Error Occured!", // Message to display
        snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
        backgroundColor: Colors.redAccent, // Background color
        colorText: Colors.white, // Text color
        borderRadius: 8.0, // Border radius for rounding corners
        margin: const EdgeInsets.all(16), // Padding around the snackbar
        duration:
            const Duration(seconds: 3), // How long the snackbar will be visible
      );
    }
    return false;
  }

  Future<bool> addServiceVendor(Map<String, dynamic> data) async {
    try {
      var response = await http.post(
        Uri.parse(_buildUrl(_addServiceVendorEndpoint)),
        headers: {
          "Content-Type": "application/json", // Specify JSON format
        },
        body: jsonEncode(data), // Encode to JSON string
      );
      
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Vendor service added successfully",
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
      print("API Error: $e");
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

  Future<void> signupPageFirst(List<String>? imageList,
      Map<String, dynamic>? requestedData, BuildContext context) async {
    print("In=$imageList");
    try {
      var request =
          http.MultipartRequest("POST", Uri.parse(appUrlsVendorSide.signup));

      requestedData?.forEach((key, value) {
        request.fields[key] = value;
      });

      for (var image in imageList!) {
        final file = await http.MultipartFile.fromPath(
            'vehicle_image', // The name of the field to which the file is associated
            image,
            contentType: MediaType(
                'image', 'jpg')); // Adjust this if your images are not JPEG
        request.files.add(file);
      }

      print("Out");

      var response = await request.send();

      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsondata = jsonDecode(responseString);

      print("motorClaimRequest=>$jsondata");

      if (jsondata["result"] == "true") {
        Get.off(const Login());
      } else {}
    } catch (e) {
      print("signupPageFirst=>$e");
    }
  }

  // login
  Future<void> userLogin(Map<String, dynamic>? requestedData) async {
    try {
      print("requestedData=>$requestedData");
      final response = await http.post(Uri.parse(appUrlsVendorSide.login),
          body: requestedData);

      print("userLogin=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("userLogin=data=>$data");

        Future.microtask(
                () => venderSidetGetXController.setVendorSideDetailsModel(data))
            .whenComplete(() {
          Get.to(Verify());
        });
      } else {
        Get.snackbar(
          "Pending Approval", // Title of the Snackbar
          "Your account has not been approved by the admin yet.", // Message to display
          snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
          backgroundColor: Colors.redAccent, // Background color
          colorText: Colors.white, // Text color
          borderRadius: 8.0, // Border radius for rounding corners
          margin: const EdgeInsets.all(16), // Padding around the snackbar
          duration: const Duration(
              seconds: 3), // How long the snackbar will be visible
        );
        print('userLogin Failed to load terms and conditions');
      }
    } catch (e) {
      print('userLogin Error: $e');
    }
  }

  Future<void> resendOtp(Map<String, dynamic>? requestedData) async {
    try {
      print("resendOtp=>$requestedData");
      final response = await http.post(Uri.parse(appUrlsVendorSide.resendOtp),
          body: requestedData);

      print("resendOtp=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("resendOtp=data=>$data");

        Future.microtask(
                () => venderSidetGetXController.setVendorSideDetailsModel(data))
            .whenComplete(() {
          Get.to(Verify());
        });
      } else {}
    } catch (e) {
      print('resendOtp Error: $e');
    }
  }

  Future<void> verifyVederOtp(Map<String, dynamic>? requestedData) async {
    try {
      print("VendorverifyOtp=>$requestedData");
      final response = await http.post(Uri.parse(appUrlsVendorSide.verifyOtp),
          body: requestedData);

      print("VendorverifyOtp=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("VendorverifyOtp=data=>$data");

        Future.microtask(
                () => sessionVendorSideManager.setVendorSessionManage(data))
            .whenComplete(() {
          Get.off(const Nav_bar());
        });
      } else {}
    } catch (e) {
      print('VendorverifyOtp Error: $e');
    }
  }

  Future<void> commonForAboutUsTermsPrivacyContactAountUsList(url) async {
    final sessionManager =
        SessionVendorSideManager(); // Initialize session manager
    dynamic token = await sessionManager.getToken();
    Map<String, dynamic>? requestedData = {"token": "$token"};
    try {
      final response = await http.post(Uri.parse(url), body: requestedData);

      print(
          "commonForAboutUsTermsPrivacyContactAountUsList=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("commonForAboutUsTermsPrivacyContactAountUsList=data=>$data");

        // sessionVendorSideManager.setVendorSessionManage(data);
        venderSidetGetXController
            .setCommonForTermsPrivacyContactUsAndAboutUs(data[0]);

        Get.to(const CommonForAboutUsTermsPrivacyContactAountUsList());
      } else {}
    } catch (e) {
      print('commonForAboutUsTermsPrivacyContactAountUsList Error: $e');
    }
  }

  Future<void> contactUs() async {
    final sessionManager =
        SessionVendorSideManager(); // Initialize session manager
    dynamic token = await sessionManager.getToken();
    Map<String, dynamic>? requestedData = {"token": "$token"};
    try {
      final response = await http.post(
          Uri.parse(appUrlsVendorSide.contactUsList),
          body: requestedData);

      print(
          "commonForAboutUsTermsPrivacyContactAountUsList=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("commonForAboutUsTermsPrivacyContactAountUsList=data=>$data");

        // sessionVendorSideManager.setVendorSessionManage(data);
        venderSidetGetXController.setContactUsModel(data[0]);

        Get.to(const CommonForAboutUsTermsPrivacyContactAountUsList());
      } else {}
    } catch (e) {
      print('commonForAboutUsTermsPrivacyContactAountUsList Error: $e');
    }
  }

  Future<void> categoryList([deafult]) async {
    final sessionManager =
        SessionVendorSideManager(); // Initialize session manager
    dynamic token = await sessionManager.getToken();
    Map<String, dynamic>? requestedData = {"token": "$token"};
    try {
      print("categoryList=>$requestedData");
      final response = await http
          .post(Uri.parse(appUrlsVendorSide.categoryList), body: requestedData);

      print("categoryList=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("categoryList=data=>$data");

        venderSidetGetXController.setCategoryList(data);
      } else {}
    } catch (e) {
      print('categoryList Error: $e');
    }
  }

  Future<void> subcategoryList(categoryId) async {
    final sessionManager = SessionVendorSideManager();

    // final sessionManager = await SessionVendorSideManager(); // Initialize session manager
    dynamic token = await sessionManager.getToken();

    dynamic vendorId = await sessionManager.getVendorId();

    print("vendorId=>$vendorId");

    Map<String, dynamic>? requestedData = {
      "token": "$token",
      "categoryId": "$categoryId"
    };
    try {
      print("subcategoryList=>$requestedData");
      final response = await http.post(
          Uri.parse(appUrlsVendorSide.subcategoryList),
          body: requestedData);

      print("subcategoryList=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("subcategoryList=data=>$data");

        venderSidetGetXController.setSubCategoryList(data);
      } else {}
    } catch (e) {
      print('subcategoryList Error: $e');
    }
  }

  Future<void> dashboard() async {
    final sessionManager = SessionVendorSideManager();

    // final sessionManager = await SessionVendorSideManager(); // Initialize session manager
    dynamic token = await sessionManager.getToken();

    dynamic vendorId = await sessionManager.getVendorId();

    print("vendorId=>$vendorId");

    Map<String, dynamic>? requestedData = {
      "token": "$token",
      "vendorId": "$vendorId",
    };
    try {
      print("dashboard=>$requestedData");
      final response = await http.post(Uri.parse(appUrlsVendorSide.dashboard),
          body: requestedData);

      print("dashboard=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("dashboard=data=>$data");

        venderSidetGetXController.setVendorDashboardDataModelDetail(data);
      } else {}
    } catch (e) {
      print('subcategoryList Error: $e');
    }
  }

  Future<void> addVendorService(List<String>? imageList,
      Map<String, dynamic>? requestedData, BuildContext context) async {
    print("In=$imageList");
    print("requestedData=>$requestedData");

    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse(appUrlsVendorSide.addVendorService));
      final sessionManager =
          SessionVendorSideManager(); // Initialize session manager
      dynamic vendorId = await sessionManager.getVendorId();
      dynamic token = await sessionManager.getToken();
      dynamic categoryId = await sessionManager.getcategoryId();
      dynamic cityName = await sessionManager.getCityName();
      print("cityName=>$cityName");

      requestedData!["token"] = token;
      requestedData["vendorId"] = vendorId;
      requestedData["categoryId"] = categoryId;
      requestedData["city_name"] = cityName;

      requestedData.forEach((key, value) {
        request.fields[key] = value;
      });

      // vendorId

      for (var image in imageList!) {
        final file = await http.MultipartFile.fromPath(
            'service_image', // The name of the field to which the file is associated
            image,
            contentType: MediaType(
                'image', 'jpg')); // Adjust this if your images are not JPEG
        request.files.add(file);
      }

      print("Out");

      var response = await request.send();

      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsondata = jsonDecode(responseString);

      print("addVendorService=>$jsondata");

      if (jsondata["result"] == "true") {
        print("jsondata[result]=>${jsondata["result"]}");

        // Get.offAll(Nav_bar());

        venderSidetGetXController.setselectedIndexVenderHomeNavi(3);
        Get.to(AddServiceScreenServiceSecond(serviceID: jsondata["serviceId"]));
      } else {}
    } catch (e) {
      print("addVendorService=>$e");
    }
  }

  // Todo
  Future<void> updateVendorService(List<String>? imageList,
      Map<dynamic, dynamic>? requestedData, BuildContext context) async {
    print("In=$imageList");
    print("requestedData=>$requestedData");

    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse(appUrlsVendorSide.updateVendorService));
      final sessionManager =
          SessionVendorSideManager(); // Initialize session manager
      dynamic vendorId = await sessionManager.getVendorId();
      dynamic token = await sessionManager.getToken();
      dynamic categoryId = await sessionManager.getcategoryId();
      dynamic cityName = await sessionManager.getCityName();

      requestedData!["token"] = token;
      requestedData["vendorId"] = vendorId;
      requestedData["categoryId"] = categoryId;
      requestedData["city_name"] = cityName;

      requestedData.forEach((key, value) {
        request.fields['$key'] = value;
      });

      // vendorId
      print("inside_service_image_add_imageList=>$imageList");
      print("inside_service_image_add_imageList=>${imageList?.isNotEmpty}");
      if (imageList!.isNotEmpty != false) {
        print("inside_service_image_add");
        for (var image in imageList) {
          final file = await http.MultipartFile.fromPath(
              'service_image', // The name of the field to which the file is associated
              image,
              contentType: MediaType(
                  'image', 'jpg')); // Adjust this if your images are not JPEG
          request.files.add(file);
        }
      }

      print("Out");

      var response = await request.send();

      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsondata = jsonDecode(responseString);

      print("addVendorService=>$jsondata");

      if (jsondata["result"] == "true") {
        // Get.offAll(Nav_bar());

        venderSidetGetXController.setselectedIndexVenderHomeNavi(3);
        Get.to(const Nav_bar());
      } else {}
    } catch (e) {
      print("addVendorService=>$e");
    }
  }

  Future<dynamic> vendorServiceList() async {
    final sessionManager = SessionVendorSideManager();

    // final sessionManager = await SessionVendorSideManager(); // Initialize session manager
    dynamic token = await sessionManager.getToken();

    dynamic vendorId = await sessionManager.getVendorId();

    print("vendorId=>$vendorId");

    Map<String, dynamic>? requestedData = {
      "token": "$token",
      "vendorId": "$vendorId"
    };
    try {
      // print("vendor_service_list=>${requestedData}");
      final response = await http.post(
          Uri.parse(appUrlsVendorSide.vendorServiceList),
          body: requestedData);

      // print("vendor_service_list=response=>${response.body}");

      final jsonData = jsonDecode(response.body);

      if (jsonData["result"] == "true") {
        final data = jsonData['data'];
        print("vendor_service_list=data=>$data");

        venderSidetGetXController.setServiceList(data);
        _serviceListController.sink.add(data);
        _serviceListController.sink.add(data); // Emit the data to the stream
        return venderSidetGetXController.getServiceList;
      } else {
        _serviceListController.sink.addError("No data found");
        return;
      }
    } catch (e) {
      print('vendor_service_list Error: $e');
      _serviceListController.sink.addError('Error: $e');
    }
  }

  void dispose() {
    _serviceListController.close(); 
  }
}
