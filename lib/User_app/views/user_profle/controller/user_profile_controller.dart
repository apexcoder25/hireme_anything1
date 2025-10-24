import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/constants_file/app_user_side_urls.dart';
import 'package:hire_any_thing/User_app/views/user_profle/model/user_profile_model.dart';
import 'package:hire_any_thing/data/session_manage/session_user_side_manage.dart';
import 'package:http/http.dart' as http;

class UserProfileController extends GetxController {
  var profile = Rxn<UserProfileModel>();
  var isLoading = false.obs;
  var isLogin = false.obs;
  var token = "".obs;
  var isUpdating = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeProfile();
  }

  Future<void> _initializeProfile() async {
    await _loadToken();
    if (token.value.isNotEmpty) {
      await fetchProfile();
    }
  }

  Future<void> _loadToken() async {
    token.value = await SessionManageerUserSide().getToken();
  }

  Future<void> refreshToken() async {
    await _loadToken();
  }

  Future<void> fetchProfile() async {
    await _loadToken();

    if (token.value.isEmpty) {
      isLogin.value = false;
      return;
    }

    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse(AppUrlsUserSide.profile),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token.value}",
        },
      );


      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        
        // DEBUG: Print all available keys
        if (jsonData is Map && jsonData["data"] != null) {
        }
        
        // Handle different response structures
        if (jsonData != null) {
          // If the response is directly the user data
          if (jsonData["_id"] != null || jsonData["userId"] != null || jsonData["id"] != null) {
            profile.value = UserProfileModel(
              result: "success",
              msg: "Profile fetched successfully",
              data: Data.fromJson(jsonData),
            );
            isLogin.value = true;
            _debugProfileData();
          }
          // If the response has a nested structure
          else if (jsonData["data"] != null) {
            profile.value = UserProfileModel.fromJson(jsonData);
            isLogin.value = true;
            _debugProfileData();
          }
          // If response has user field
          else if (jsonData["user"] != null) {
            profile.value = UserProfileModel(
              result: "success",
              msg: "Profile fetched successfully",
              data: Data.fromJson(jsonData["user"]),
            );
            isLogin.value = true;
            _debugProfileData();
          }
          else {
            isLogin.value = false;
          }
        } else {
          isLogin.value = false;
        }
      } else if (response.statusCode == 401) {
        await logout();
      } else {
        isLogin.value = false;
      }
    } catch (e) {
      isLogin.value = false;
    } finally {
      isLoading(false);
    }
  }

  void _debugProfileData() {
    if (profile.value?.data != null) {
      var data = profile.value!.data!;
    }
  }

  String? _getUserId() {
    if (profile.value?.data == null) {
      return null;
    }
    
    var data = profile.value!.data!;
    String? userId = data.userId;
    
    
    if (userId == null || userId.isEmpty) {
      return null;
    }
    
    return userId;
  }

  Future<bool> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNo,
    String? countryCode,
  }) async {
    await _loadToken();

    if (token.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Authentication required. Please login again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
      );
      return false;
    }

    // Validation
    if (email != null && email.isNotEmpty && !GetUtils.isEmail(email)) {
      Get.snackbar(
        'Invalid Email',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        icon: const Icon(Icons.warning, color: Colors.white),
      );
      return false;
    }

    if (mobileNo != null && mobileNo.isNotEmpty && mobileNo.length < 10) {
      Get.snackbar(
        'Invalid Mobile',
        'Mobile number must be at least 10 digits',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        icon: const Icon(Icons.warning, color: Colors.white),
      );
      return false;
    }

    try {
      isUpdating(true);
      
      Map<String, dynamic> updateData = {};
      if (firstName != null && firstName.isNotEmpty) updateData['firstName'] = firstName;
      if (lastName != null && lastName.isNotEmpty) updateData['lastName'] = lastName;
      if (email != null && email.isNotEmpty) updateData['email'] = email;
      if (mobileNo != null && mobileNo.isNotEmpty) updateData['mobile_no'] = mobileNo;
      if (countryCode != null && countryCode.isNotEmpty) updateData['country_code'] = countryCode;

      if (updateData.isEmpty) {
        Get.snackbar(
          'No Changes',
          'No changes to update',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white,
          icon: const Icon(Icons.info, color: Colors.white),
        );
        return false;
      }

      print("Update data to send: $updateData");

      // Try to get userId
      String? userId = _getUserId();
      
      // Different update strategies based on whether we have userId or not
      String updateUrl;
      if (userId != null && userId.isNotEmpty) {
        // Use PUT with userId in URL
        updateUrl = "${AppUrlsUserSide.profile}/$userId";
      } else {
        
        updateUrl = AppUrlsUserSide.profile;
      }

      var response = await http.put(
        Uri.parse(updateUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token.value}",
        },
        body: jsonEncode(updateData),
      );


      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchProfile();
        Get.snackbar(
          'Success',
          'Profile updated successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          duration: const Duration(seconds: 3),
        );
        return true;
      } 
      else if (response.statusCode == 404 && userId != null) {
        // If PUT with userId fails, try without userId
        
        var retryResponse = await http.put(
          Uri.parse(AppUrlsUserSide.profile),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${token.value}",
          },
          body: jsonEncode(updateData),
        );


        if (retryResponse.statusCode == 200 || retryResponse.statusCode == 201) {
          await fetchProfile();
          Get.snackbar(
            'Success',
            'Profile updated successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            icon: const Icon(Icons.check_circle, color: Colors.white),
            duration: const Duration(seconds: 3),
          );
          return true;
        } else {
          _handleUpdateError(retryResponse);
          return false;
        }
      }
      else {
        _handleUpdateError(response);
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Network Error',
        'Please check your internet connection and try again',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.network_check, color: Colors.white),
      );
      return false;
    } finally {
      isUpdating(false);
    }
  }

  void _handleUpdateError(http.Response response) {
    String errorMessage = 'Failed to update profile';
    try {
      var errorData = json.decode(response.body);
      errorMessage = errorData['message'] ?? errorData['msg'] ?? errorData['error'] ?? errorMessage;
    } catch (e) {
      if (response.statusCode == 400) {
        errorMessage = 'Invalid data provided';
      } else if (response.statusCode == 401) {
        errorMessage = 'Authentication failed. Please login again.';
      } else if (response.statusCode == 403) {
        errorMessage = 'You do not have permission to update this profile';
      } else if (response.statusCode == 404) {
        errorMessage = 'Profile not found';
      } else if (response.statusCode == 500) {
        errorMessage = 'Server error. Please try again later.';
      }
    }
    
    Get.snackbar(
      'Update Failed',
      errorMessage,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  Future<void> logout() async {
    await SessionManageerUserSide().removeToken();
    token.value = "";
    profile.value = null;
    isLogin.value = false;
  }
}
