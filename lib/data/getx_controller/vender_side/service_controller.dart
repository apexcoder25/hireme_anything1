import 'dart:convert';

import 'package:get/get.dart';
import 'package:hire_any_thing/data/exceptions/api_exception.dart';
import 'package:hire_any_thing/data/models/vender_side_model/vendor_home_page_services_model.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';

class ServiceController extends GetxController {
  var serviceList = <Service>[].obs;
  var isLoading = true.obs;
  var vendorId = "".obs;
  String get apiUrl => "/vendor-services/${vendorId.value}";
  var authToken = "".obs;
  final ApiServiceVenderSide _apiService = ApiServiceVenderSide();

  @override
  void onInit() {
    super.onInit();
    _loadVendorId();
    _loadToken();
  }

  Future<void> _loadVendorId() async {
    String? id = await SessionVendorSideManager().getVendorId();
    vendorId.value = id ?? "";
    if (vendorId.value.isNotEmpty) {
      print("Vendor ID: ${vendorId.value}");
    }
  }

  Future<void> _loadToken() async {
    String? token = await SessionVendorSideManager().getToken();
    authToken.value = token ?? "";
    if (authToken.value.isNotEmpty) {
      print("Auth Token: ${authToken.value}");
      _apiService.setRequestHeaders({'Authorization': 'Bearer ${authToken.value}'});
      fetchServices();
    }
  }

  void fetchServices() async {
    try {
      if (vendorId.value.isEmpty) {
        print("Vendor ID is not available");
        return;
      }
      isLoading.value = true;
      final response = await _apiService.getApi(apiUrl);

      if (response is Map<String, dynamic> && response['success'] == true) {
        var data = ServicesModel.fromJson(response);
        print("API Response: ${jsonEncode(response)}"); // Debugging
        print("Services fetched: ${data.data?.services.length}"); // Debug service count

        // Update service list with all services from the response
        serviceList.assignAll(data.data!.services);

        print("Updated serviceList: ${serviceList.length}"); // Debug updated list
      } else {
        print("Failed to fetch services. Response: $response");
      }
    } on ApiException catch (e) {
      print("Error fetching services: ${e.message}, StackTrace: ${StackTrace.current}");
    } catch (e, stackTrace) {
      print("Unexpected error fetching services: $e, StackTrace: $stackTrace");
    } finally {
      isLoading.value = false;
    }
  }
}