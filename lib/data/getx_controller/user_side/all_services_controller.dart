import 'dart:convert';

import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/category_sub_model.dart';
import 'package:hire_any_thing/data/models/user_side_model/allvendorServicesList.dart';
import 'package:http/http.dart' as http;

class AllServicesController extends GetxController {
  var isLoading = true.obs;
  var vendorServices = <VendorServiceModel>[].obs;
  var tutorHireServices = <TutorHireService>[].obs;
  var automotiveHireServices = <AutomotiveHireService>[].obs;

  var categories = <String>[].obs;
  var subcategories = <String>[].obs;

  var selectedCategory = Rxn<String>();
  var selectedSubcategory = Rxn<String>();
  var selectedSubcategoryId = Rxn<String>();

  final String apiUrl = "https://api.hireanything.com/vendor/allVendorService";

  var subcategoryMap = <String, List<Model1>>{}.obs; // Store mapping globally

  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  Future<void> fetchServices() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data != null) {
          // Parse vendor services
          vendorServices.value = (data['vendorServices'] as List?)
                  ?.map((e) => VendorServiceModel.fromJson(e))
                  .whereType<VendorServiceModel>()
                  .toList() ??
              [];
          print("Vendor Services fetched: ${vendorServices.length} items");

          // Parse tutor hire services
          tutorHireServices.value = (data['tutorHireServices'] as List?)
                  ?.map((e) => TutorHireService.fromJson(e))
                  .whereType<TutorHireService>()
                  .toList() ??
              [];
          print("Tutor Hire Services fetched: ${tutorHireServices.length} items");

          // Parse automotive hire services
          automotiveHireServices.value = (data['automotiveHireServices'] as List?)
                  ?.map((e) => AutomotiveHireService.fromJson(e))
                  .whereType<AutomotiveHireService>()
                  .toList() ??
              [];
          print("Automotive Hire Services fetched: ${automotiveHireServices.length} items");

          extractCategories();
        } else {
          print("API response is null or empty");
        }
      } else {
        print("API Error: ${response.statusCode} - ${response.body}");
        throw Exception("Failed to load services: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("Error fetching services: $e, StackTrace: $stackTrace");
      Get.snackbar("Error", "Failed to load services: $e");
    } finally {
      isLoading(false);
    }
  }

  void extractCategories() {
    var allServices = [
      ...vendorServices,
      ...tutorHireServices,
      ...automotiveHireServices
    ];

    var categorySet = <String>{};
    subcategoryMap.clear(); // Reset subcategory mapping

    for (var service in allServices) {
      String categoryName = "Unknown";
      String subcategoryName = "Unknown";

      if (service is VendorServiceModel) {
        categoryName = service.categoryId?.categoryName ?? "Unknown";
        subcategoryName = service.subcategoryId?.subcategoryName ?? "Unknown";
      } else if (service is TutorHireService) {
        categoryName = service.categoryId?.categoryName ?? "Unknown";
        subcategoryName = service.subcategoryId?.subcategoryName ?? "Unknown";
      } else if (service is AutomotiveHireService) {
        categoryName = service.categoryId?.categoryName ?? "Unknown";
        subcategoryName = service.subcategoryId?.subcategoryName ?? "Unknown";
      }

      categorySet.add(categoryName);

      // Ensure subcategories are stored correctly
      subcategoryMap.putIfAbsent(categoryName, () => []).add(Model1(subcategoryName: subcategoryName));
    }

    categories.value = categorySet.toList();
    print("Categories extracted: $categories");
  }

  Future<void> applyFilter({
    String? category,
    String? subcategory,
    String? location,
    String? date,
    String? budgetRange,
  }) async {
    try {
      isLoading(true);

      // Build URL dynamically based on provided filters
      String filterUrl = "https://hireanything.com/offering?";
      Map<String, String> queryParams = {};

      if (category != null && category.isNotEmpty) queryParams["category"] = category;
      if (subcategory != null && subcategory.isNotEmpty) queryParams["subcategory"] = subcategory;
      if (location != null && location.isNotEmpty) queryParams["location"] = location;
      if (date != null && date.isNotEmpty) queryParams["date"] = date;
      if (budgetRange != null && budgetRange.isNotEmpty) queryParams["budgetRange"] = budgetRange;

      // Append query parameters to URL
      filterUrl += Uri(queryParameters: queryParams).query;

      print("Filter URL: $filterUrl"); // Debugging

      final response = await http.get(Uri.parse(filterUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null) {
          // Update filtered services
          vendorServices.value = (data['vendorServices'] as List?)
                  ?.map((e) => VendorServiceModel.fromJson(e))
                  .whereType<VendorServiceModel>()
                  .toList() ??
              [];
          tutorHireServices.value = (data['tutorHireServices'] as List?)
                  ?.map((e) => TutorHireService.fromJson(e))
                  .whereType<TutorHireService>()
                  .toList() ??
              [];
          automotiveHireServices.value = (data['automotiveHireServices'] as List?)
                  ?.map((e) => AutomotiveHireService.fromJson(e))
                  .whereType<AutomotiveHireService>()
                  .toList() ??
              [];
        }
      } else {
        print("API Error: ${response.statusCode} - ${response.body}");
        throw Exception("Failed to apply filters: ${response.statusCode}");
      }
    } catch (e) {
      print("Error applying filter: $e");
      Get.snackbar("Error", "Failed to apply filters: $e");
    } finally {
      isLoading(false);
    }
  }

  void clearFilters() {
    selectedCategory.value = null;
    selectedSubcategory.value = null;
    selectedSubcategoryId.value = null;
    vendorServices.clear();
    tutorHireServices.clear();
    automotiveHireServices.clear();
    fetchServices(); // Re-fetch all services to reset
  }
}