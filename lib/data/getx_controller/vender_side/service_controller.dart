import 'dart:convert';

import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/vender_side_model/service_model.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:http/http.dart' as http;

class ServiceController extends GetxController {
  var serviceList = <ServiceModel>[].obs;
  var automotiveServiceList = <AutomotiveHireServiceModel>[].obs;
  var isLoading = true.obs;
  var vendorId = "";
  final String apiUrl = "https://api.hireanything.com/vendor/vendor_service_list";
  var authToken = "";

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
      fetchServices();
    }
  }

  void fetchServices() async {
    try {
      isLoading(true);
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
        body: jsonEncode({"vendorId": vendorId}),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("API Response: ${response.body}"); // Debugging

        // Fetch Passenger Transport Services
        var passengerServices = (data["passengerTransportServices"] as List?)
                ?.map((json) => ServiceModel.fromJson(json))
                .toList() ??
            [];

        // Fetch Automotive Hire Services (only if key exists)
        var automotiveServices = (data.containsKey("AutomotiveHireServices") &&
                data["AutomotiveHireServices"] is List)
            ? (data["AutomotiveHireServices"] as List)
                .map((json) => AutomotiveHireServiceModel.fromJson(json))
                .toList()
            : [];

        // Update lists separately
        serviceList.assignAll(passengerServices);
        automotiveServiceList.assignAll(automotiveServices as Iterable<AutomotiveHireServiceModel>);

        print("Fetched Passenger Services: ${serviceList.length}");
        print("Fetched Automotive Services: ${automotiveServiceList.length}");
      } else {
        print("Failed to fetch services. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading(false);
    }
  }
}
