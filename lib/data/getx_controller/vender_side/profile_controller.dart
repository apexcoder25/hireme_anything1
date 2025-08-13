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

  @override
  void onClose() { 
    super.onClose();
  }

  Future<void> _initializeProfile() async {
    try {
      await _loadToken();
      if (token.value.isNotEmpty) {
        await fetchProfile(); 
      } else {
        isLoading(false); 
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar("Error", "Failed to initialize profile");
    }
  }

  Future<void> _loadToken() async {
    try {
      token.value = await SessionVendorSideManager().getToken() ?? "";
      print("Loaded Tokenn ${token.value}");

      if (token.value.isEmpty) {
        print("No authentication token found");
        Get.snackbar("Error", "No authentication token found");
        throw Exception("No authentication token found");
      }
    } catch (e) {
      print("Error loading token: $e");
      token.value = "";
      rethrow; 
    }
  }

  Future<void> fetchProfile() async {
    if (token.value.isEmpty) {

      Get.snackbar("Error", "Authentication token is missing");
      isLoading(false);
      return;
    }

    try {
      isLoading(true);
      // print("token value??? ${token.value}");

      apiService.setRequestHeaders({"Authorization": "Bearer ${token.value}"});

      final response = await apiService.getApi("profile");
      print("profile responnse show $response");

      if (response != null) {
        if (response["_id"] != null) {
          profile.value = ProfileModel.fromJson(response);
          print("Profile fetched successfully: ${profile.value!.toJson()}");
        } else if (response["error"] != null) {
          print("API Error: ${response["error"]}");
          Get.snackbar(
              "Error", response["message"] ?? "Failed to fetch profile");
        } else {
          print("No profile data found in API response");
          Get.snackbar("Error", "No profile data found");
        }
      } else {
        Get.snackbar(
            "Error", "Failed to fetch profile: No response from server");
      }
    } catch (e) {
      print("Error fetching profile: $e");
      Get.snackbar("Error", "Failed to fetch profile: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateProfile(
      ProfileModel updatedProfile,
      List<Map<String, String>> legalDocuments,
      List<String> vehicleImages) async {
    if (token.value.isEmpty) {
      print("Token is empty, cannot update profile!");
      Get.snackbar("Error", "Authentication token is missing");
      return;
    }

    // Validate required data
    if (updatedProfile.id == null || updatedProfile.id!.isEmpty) {
      
      Get.snackbar("Error", "Profile ID is required for update");
      return;
    }

    try {
      isLoading(true);

      // Prepare payload
      var payload = updatedProfile.toJson();
      payload['legal_documents'] = legalDocuments;
      payload['vehicle_image'] = vehicleImages;

      print("Update Profile Payload: $payload");

      // Set headers
      apiService.setRequestHeaders({"Authorization": "Bearer ${token.value}"});

      final response = await apiService.putApi(
        "vendors/${updatedProfile.id}",
        payload,
      );

      print("Update Profile Response: $response");

      if (response != null) {
        if (response["vendor"] != null && response["vendor"]["_id"] != null) {
          profile.value = ProfileModel.fromJson(response["vendor"]);
          Get.snackbar("Success", "Profile updated successfully");
          Get.back();
        } else if (response["error"] != null) {
          Get.snackbar(
              "Error", response["message"] ?? "Failed to update profile");
        } else {
          Get.snackbar("Error", "Failed to update profile: Invalid response");
        }
      } else {
        Get.snackbar(
            "Error", "Failed to update profile: No response from server");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshProfile() async {
    await fetchProfile();
  }

  bool get hasProfile => profile.value != null;

  ProfileModel? get currentProfile => profile.value;
}
