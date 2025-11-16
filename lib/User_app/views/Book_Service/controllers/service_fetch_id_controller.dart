import 'dart:convert';

import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/user_side_model/allvendorServicesList.dart';
import 'package:http/http.dart' as http;

class VendorServiceController extends GetxController {
  var isLoading = true.obs;
  var vendorServices = <VendorServiceModel>[].obs;

  @override
  void onInit() {
    fetchVendorServices();
    super.onInit();
  }

  // Fetch all vendor services from API
  Future<void> fetchVendorServices() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://api.hireanything.com/vendor/allVendorService'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> servicesJson = jsonData['vendorServices'];
        vendorServices.assignAll(servicesJson.map((e) => VendorServiceModel.fromJson(e)).toList());
      } else {
        Get.snackbar("Error", "Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading(false);
    }
  }

  // Fetch a single service by ID from API (if not in list)
  Future<VendorServiceModel?> fetchServiceById(String id) async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://api.hireanything.com/vendor/service/$id'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final service = VendorServiceModel.fromJson(jsonData);
        addVendorService(service);
        return service;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching service by ID $id: $e');
      return null;
    } finally {
      isLoading(false);
    }
  }

  // Get a service by ID from the list
  VendorServiceModel? getServiceById(String id) {
    return vendorServices.firstWhereOrNull((service) => service.id == id);
  }

  // Add a new service
  void addVendorService(VendorServiceModel service) {
    vendorServices.add(service);
  }

  // Update an existing service
  void updateVendorService(String id, VendorServiceModel updatedService) {
    int index = vendorServices.indexWhere((service) => service.id == id);
    if (index != -1) {
      vendorServices[index] = updatedService;
    }
  }

  // Remove a service by ID
  void removeVendorService(String id) {
    vendorServices.removeWhere((service) => service.id == id);
  }
}