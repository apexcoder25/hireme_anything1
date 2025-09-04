import 'dart:convert';

import 'package:get/get.dart';
import 'package:hire_any_thing/constants_file/app_user_side_urls.dart';
import 'package:hire_any_thing/data/models/user_side_model/user_profile_model.dart';
import 'package:hire_any_thing/data/session_manage/session_user_side_manage.dart';
import 'package:http/http.dart' as http;

class UserProfileController extends GetxController {
  var profile = Rxn<UserProfileModel>();
  var isLoading = false.obs;
  var isLogin = false.obs;
  var token = "".obs;

  @override
  void onInit() {
    super.onInit();
    _initializeProfile();
  }

  Future<void> _initializeProfile() async {
    await _loadToken();
    // Fetch profile only if token is available
    if (token.value.isNotEmpty) {
      await fetchProfile();
    }
  }

  Future<void> _loadToken() async {
    token.value = await SessionManageerUserSide().getToken() ?? "";
    print("Loaded Token: ${token.value}");
  }

  // Add this method to refresh token manually
  Future<void> refreshToken() async {
    await _loadToken();
    print("Token refreshed: ${token.value}");
  }

  Future<void> fetchProfile() async {
    // Always refresh token before fetching to ensure we have the latest token
    await _loadToken();

    if (token.value.isEmpty) {
      print("Token is empty, cannot fetch profile!");
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

      print("Fetch Profile Response Status: ${response.statusCode}");
      print("Fetch Profile Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data != null && data["_id"] != null) {
          profile.value = UserProfileModel.fromJson(data);
          isLogin.value = true;
          print("Profile fetched successfully!");
        } else {
          print("No profile data found in API response");
          isLogin.value = false;
        }
      } else if (response.statusCode == 401) {
        print("Unauthorized: Token might be expired");
        await logout();
      } else {
        print("API Request Failed: ${response.statusCode}");
        isLogin.value = false;
      }
    } catch (e) {
      print("Error fetching profile: $e");
      isLogin.value = false;
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateProfile(UserProfileModel updatedProfile) async {
    // Ensure token is fresh
    await _loadToken();

    if (token.value.isEmpty) {
      print("Token is empty, cannot update profile!");
      return;
    }

    try {
      isLoading(true);
      var response = await http.post(
        Uri.parse("https://api.hireanything.com/user/update_profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token.value}",
        },
        body: jsonEncode(updatedProfile.toJson()),
      );

      print("Update Profile Response Status: ${response.statusCode}");
      print("Update Profile Response Body: ${response.body}");

      if (response.statusCode == 200) {
        profile.value = updatedProfile;
        Get.back();
        print("Profile updated successfully!");
      } else {
        print("Profile update failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Error updating profile: $e");
    } finally {
      isLoading(false);
    }
  }

  // Method to logout and clear session
  Future<void> logout() async {
    await SessionManageerUserSide().removeToken();
    token.value = "";
    profile.value = null;
    isLogin.value = false;
    print("User logged out successfully");
  }
}
