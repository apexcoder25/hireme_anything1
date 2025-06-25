import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/vender_side_model/profile_model.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';

class ProfileController extends GetxController {
  var profile = Rxn<ProfileModel>();
  var isLoading = true.obs;
  var token = "".obs;
  final ApiServiceVenderSide apiService;

  ProfileController({required this.apiService});

  @override
  void onInit() {
    super.onInit();
    _initializeProfile();
  }

  Future<void> _initializeProfile() async {
    await _loadToken();
    fetchProfile();
  }

  Future<void> _loadToken() async {
    token.value = await SessionVendorSideManager().getToken() ?? "";
    print("Loaded Token: ${token.value}");
    if (token.value.isEmpty) {
      Get.snackbar("Error", "No authentication token found");
    }
  }

  void fetchProfile() async {
    if (token.value.isEmpty) {
      print("Token is empty, cannot fetch profile!");
      Get.snackbar("Error", "Authentication token is missing");
      isLoading(false);
      return;
    }

    try {
      isLoading(true);
      apiService.setRequestHeaders({"Authorization": "Bearer ${token.value}"});
      
      final response = await apiService.getApi("profile");

      print("Fetch Profile Response: $response");

      if (response != null && response["_id"] != null) {
        profile.value = ProfileModel.fromJson(response);
        print("Profile fetched successfully: ${profile.value!.toJson()}");
      } else {
        print("No profile data found in API response");
        Get.snackbar("Error", "No profile data found");
      }
    } catch (e) {
      print("Error fetching profile: $e");
      Get.snackbar("Error", "Failed to fetch profile: $e");
    } finally {
      isLoading(false);
    }
  }

  void updateProfile(ProfileModel updatedProfile, List<Map<String, String>> legalDocuments, List<String> vehicleImages) async {
    if (token.value.isEmpty) {
      print("Token is empty, cannot update profile!");
      Get.snackbar("Error", "Authentication token is missing");
      return;
    }

    try {
      isLoading(true);
      var payload = updatedProfile.toJson();
      payload['legal_documents'] = legalDocuments;
      payload['vehicle_image'] = vehicleImages;

      print("Update Profile Payload: $payload");

      apiService.setRequestHeaders({"Authorization": "Bearer ${token.value}"});

      final response = await apiService.putApi(
        "vendors/${updatedProfile.id}",
        payload,
      );

      print("Update Profile Response: $response");

      if (response != null && response["vendor"] != null && response["vendor"]["_id"] != null) {
        profile.value = ProfileModel.fromJson(response["vendor"]);
        print("Profile updated successfully: ${profile.value!.toJson()}");
        Get.snackbar("Success", "Profile updated successfully");
        Get.back();
      } else {
        print("Profile update failed: Invalid response");
        Get.snackbar("Error", "Failed to update profile: Invalid response");
      }
    } catch (e) {
      print("Error updating profile: $e");
      Get.snackbar("Error", "Failed to update profile: $e");
    } finally {
      isLoading(false);
    }
  }
}