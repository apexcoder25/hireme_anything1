// service_controller.dart
import 'dart:convert';

import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/vender_side_model/vendor_home_page_services_model.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';

class ServiceController extends GetxController {
  var serviceList = <Service>[].obs;
  var isLoading = true.obs;
  var vendorId = "";
  String get apiUrl => "https://api.hireanything.com/vendor/vendor-services/$vendorId";
  var authToken = "";
  final ApiServiceVenderSide _apiService = ApiServiceVenderSide();

  @override
  void onInit() {
    _loadVendorId();
    _loadToken();
    super.onInit();
  }

  Future<void> _loadVendorId() async {
    vendorId = (await SessionVendorSideManager().getVendorId()) ?? "";
    if (vendorId.isNotEmpty) {
      print("Vendor ID: $vendorId");
    }
  }

  Future<void> _loadToken() async {
    authToken = (await SessionVendorSideManager().getToken()) ?? "";
    if (authToken.isNotEmpty) {
      print("Auth Token: $authToken");
      _apiService.setRequestHeaders({'Authorization': 'Bearer $authToken'});
      fetchServices();
    }
  }

  void fetchServices() async {
    try {
      isLoading(true);
      final response = await _apiService.getApi(apiUrl);

      if (response is Map<String, dynamic> && response['success'] == true) {
        var data = ServicesModel.fromJson(response);
        print("API Response: ${jsonEncode(response)}"); // Debugging
        print("Services fetched: ${data.data.services.length}"); // Debug service count

        // Update service list with all services from the response
        serviceList.assignAll(data.data.services);

        print("Updated serviceList: ${serviceList.length}"); // Debug updated list
      } else {
        print("Failed to fetch services. Response: $response");
      }
    } catch (e, stackTrace) {
      print("Error fetching data: $e, StackTrace: $stackTrace");
    } finally {
      isLoading(false);
    }
  }
}