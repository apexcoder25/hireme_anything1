import 'package:get/get.dart';
import 'package:hire_any_thing/data/exceptions/api_exception.dart';
import 'package:hire_any_thing/data/models/vender_side_model/vendor_home_page_services_model.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceController extends GetxController {
  var serviceList = <Service>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = "".obs;
  var vendorId = "".obs;
  String get apiUrl => "/vendor-services/${vendorId.value}";
  var authToken = "".obs;
  var isInitialized = false.obs;
  final ApiServiceVenderSide _apiService = ApiServiceVenderSide();

  @override
  void onInit() {
    super.onInit();
    print("ServiceController onInit called");
    _initializeController();
  }

  Future<void> _initializeController() async {
    try {
      print("Starting controller initialization...");
      isLoading.value = true;
      hasError.value = false;
      
      // Wait for both vendor ID and token to load
      await Future.wait([
        _loadVendorId(),
        _loadToken(),
      ]);
      
      print("Vendor ID loaded: '${vendorId.value}'");
      print("Auth token loaded: '${authToken.value.isNotEmpty ? 'Yes' : 'No'}'");
      
      // Only fetch services if both vendor ID and token are available
      if (vendorId.value.isNotEmpty && authToken.value.isNotEmpty) {
        print("Both vendor ID and token available, fetching services...");
        await fetchServices();
      } else {
        print("Missing credentials - Vendor ID: '${vendorId.value}', Token: ${authToken.value.isNotEmpty}");
        hasError.value = true;
        errorMessage.value = "Missing vendor ID or authentication token";
      }
    } catch (e) {
      print("Error during initialization: $e");
      hasError.value = true;
      errorMessage.value = "Failed to initialize: $e";
    } finally {
      isLoading.value = false;
      isInitialized.value = true;
      print("Controller initialization complete. Loading: ${isLoading.value}, Error: ${hasError.value}, Initialized: ${isInitialized.value}");
    }
  }

  Future<void> _loadVendorId() async {
    try {
      print("Loading vendor ID...");
      
      // Let's check what's actually stored in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      Set<String> keys = prefs.getKeys();
      print("📱 All SharedPreferences keys: $keys");
      
      // Check specifically for vendor-related keys
      keys.where((key) => key.toLowerCase().contains('vendor')).forEach((key) {
        print("  Vendor key '$key': '${prefs.getString(key)}'");
      });
      
      // Check for common auth keys
      ['token', 'auth_token', 'vendorId', 'vendor_id', 'id'].forEach((key) {
        var value = prefs.getString(key);
        if (value != null) {
          print("  Auth key '$key': '${value.length > 20 ? value.substring(0, 20) + "..." : value}'");
        }
      });
      
      String? id = await SessionVendorSideManager().getVendorId();
      vendorId.value = id ?? "";
      print("🆔 Vendor ID loaded: '${vendorId.value}'");
    } catch (e) {
      print("❌ Error loading vendor ID: $e");
      vendorId.value = "";
    }
  }

  Future<void> _loadToken() async {
    try {
      print("Loading auth token...");
      String? token = await SessionVendorSideManager().getToken();
      authToken.value = token ?? "";
      print("Auth token loaded: ${authToken.value.isNotEmpty ? 'Yes, length: ${authToken.value.length}' : 'No'}");
      if (authToken.value.isNotEmpty) {
        _apiService.setRequestHeaders({'Authorization': 'Bearer ${authToken.value}'});
        print("Authorization header set for API service");
      }
    } catch (e) {
      print("Error loading auth token: $e");
      authToken.value = "";
    }
  }

  Future<void> fetchServices() async {
    try {
      if (vendorId.value.isEmpty) {
        hasError.value = true;
        errorMessage.value = "Vendor ID is not available";
        print("❌ Fetch failed: Vendor ID is empty");
        return;
      }
      
      if (authToken.value.isEmpty) {
        hasError.value = true;
        errorMessage.value = "Authentication token is not available";
        print("❌ Fetch failed: Auth token is empty");
        return;
      }

      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";
      
      print("🔄 Fetching services from API: $apiUrl");
      final response = await _apiService.getApi(apiUrl);
      print("📡 Raw API Response received:");
      print("Response type: ${response.runtimeType}");
      print("Response content: $response");

      if (response is Map<String, dynamic>) {
        print("✅ Response is a valid Map");
        print("Success field: ${response['success']}");
        print("Message field: ${response['message']}");
        print("Data field exists: ${response.containsKey('data')}");
        
        if (response['success'] == true) {
          print("✅ API Success = true");
          try {
            print("🔄 Parsing ServicesModel...");
            var data = ServicesModel.fromJson(response);
            print("✅ ServicesModel parsed successfully");
            print("Data object: ${data.data}");
            print("Services in data: ${data.data.services}");
            print("Services count in response: ${data.data.services.length}");
            
            // Before assignment
            print("📋 ServiceList before assignment: ${serviceList.length}");
            
            // Safe assignment
            serviceList.assignAll(data.data.services);
            hasError.value = false;
            
            // After assignment
            print("📋 ServiceList after assignment: ${serviceList.length}");
            print("✅ ServiceList updated with ${serviceList.length} services");
            
            // Print first few service details for debugging
            if (serviceList.isNotEmpty) {
              print("🔍 First service details:");
              var firstService = serviceList.first;
              print("  - ID: ${firstService.id}");
              print("  - Title: ${firstService.listingTitle}");
              print("  - Service Name: ${firstService.serviceName}");
            }
            
          } catch (parseError, stackTrace) {
            print("❌ Error parsing ServicesModel: $parseError");
            print("❌ Parse error stack trace: $stackTrace");
            hasError.value = true;
            errorMessage.value = "Error parsing server response: $parseError";
            serviceList.clear();
          }
        } else {
          print("❌ API Success = false");
          hasError.value = true;
          errorMessage.value = response['message'] ?? "Server returned error";
          serviceList.clear();
          print("❌ Server error message: ${response['message']}");
        }
      } else {
        print("❌ Response is not a Map, type: ${response.runtimeType}");
        hasError.value = true;
        errorMessage.value = "Invalid response format from server";
        serviceList.clear();
      }
    } on ApiException catch (e) {
      hasError.value = true;
      errorMessage.value = e.message;
      serviceList.clear();
      print("❌ API error fetching services: ${e.message}");
    } catch (e, stackTrace) {
      hasError.value = true;
      errorMessage.value = "Unexpected error occurred";
      serviceList.clear();
      print("❌ Unexpected error fetching services: $e");
      print("❌ Stack trace: $stackTrace");
    } finally {
      isLoading.value = false;
      print("🏁 Fetch complete. Final serviceList length: ${serviceList.length}");
    }
  }

  // Method to refresh services (useful for pull-to-refresh)
  Future<void> refreshServices() async {
    await fetchServices();
  }

  // Debug method to manually test the full flow
  Future<void> debugFullFlow() async {
    print("🔍 DEBUG: Starting full flow test...");
    
    // Test 1: Check session values
    await _loadVendorId();
    await _loadToken();
    
    // Test 2: Check API URL construction
    print("🔗 API URL: $apiUrl");
    
    // Test 3: Try API call
    if (vendorId.value.isNotEmpty && authToken.value.isNotEmpty) {
      print("✅ Credentials available, testing API call...");
      await fetchServices();
    } else {
      print("❌ Missing credentials:");
      print("  - Vendor ID: '${vendorId.value}'");
      print("  - Auth Token: ${authToken.value.isNotEmpty ? 'Available' : 'Missing'}");
    }
    
    print("🔍 DEBUG: Full flow test completed.");
  }
}
