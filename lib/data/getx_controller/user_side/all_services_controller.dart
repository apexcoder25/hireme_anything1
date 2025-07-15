import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/category_sub_model.dart';
import 'package:hire_any_thing/data/models/user_side_model/filter_model_services.dart';
import 'package:hire_any_thing/data/services/api_service.dart';

class AllServicesController extends GetxController {
  var isLoading = true.obs;
  var services = <Datum>[].obs; // Use Datum directly from FilterModel
  var funeralServices = <Datum>[].obs;
  var horseServices = <Datum>[].obs;
  var chauffeurServices = <Datum>[].obs;

  var categories = <String>[].obs;
  var subcategories = <String>[].obs;

  var selectedCategory = Rxn<String>();
  var selectedSubcategory = Rxn<String>();
  var selectedSubcategoryId = Rxn<String>();

  final String apiUrl = "https://stag-api.hireanything.com/user/global-filter";

  var subcategoryMap = <String, List<Model1>>{}.obs; // Store mapping globally

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  Future<void> fetchServices() async {
    try {
      isLoading(true);
      final response = await _apiService.postApi(
        apiUrl,
        {
          "categoryId": "676ac544234968d45b494992", // Default to Passenger Transport
          "subCategoryId": "",
          "minBudget": null,
          "maxBudget": null,
        },
      );

      if (response != null) {
        final data = FilterModel.fromJson(response);
        if (data.success == true && data.data.isNotEmpty) {
          services.value = data.data;
          print("Total services fetched: ${services.length}");
          // Separate services by _sourceModel
          funeralServices.value = services.where((service) => service.sourceModel == "funeral").toList();
          horseServices.value = services.where((service) => service.sourceModel == "horse").toList();
          chauffeurServices.value = services.where((service) => service.sourceModel == "chauffeur").toList();
          print("Funeral: ${funeralServices.length}, Horse: ${horseServices.length}, Chauffeur: ${chauffeurServices.length}");
          extractCategories();
        } else {
          print("API response is empty or unsuccessful");
        }
      } else {
        print("API response is null");
        throw Exception("Failed to load services");
      }
    } catch (e, stackTrace) {
      print("Error fetching services: $e, StackTrace: $stackTrace");
      Get.snackbar("Error", "Failed to load services: $e");
    } finally {
      isLoading(false);
    }
  }

  void extractCategories() {
    var categorySet = <String>{};
    subcategoryMap.clear(); // Reset subcategory mapping

    for (var service in services) {
      String categoryName = service.categoryId?.categoryName ?? "Unknown";
      String subcategoryName = service.subcategoryId?.subcategoryName ?? "Unknown";

      categorySet.add(categoryName);
      subcategoryMap.putIfAbsent(categoryName, () => []).add(Model1(subcategoryName: subcategoryName));
    }

    categories.value = categorySet.toList();
    print("Categories extracted: $categories");
  }

  Future<void> applyFilter({
    String? categoryId,
    String? subCategoryId,
    String? location,
    String? date,
    String? budgetRange,
  }) async {
    try {
      isLoading(true);

      double? minBudget;
      double? maxBudget;
      if (budgetRange != null && budgetRange.isNotEmpty) {
        final parts = budgetRange.split('-');
        if (parts.length == 2) {
          minBudget = double.tryParse(parts[0]) ?? 0.0;
          maxBudget = double.tryParse(parts[1]) ?? 0.0;
        } else if (budgetRange == "200+") {
          minBudget = 200.0;
          maxBudget = null;
        }
      }

      final response = await _apiService.postApi(
        apiUrl,
        {
          "categoryId": categoryId ?? "676ac544234968d45b494992",
          "subCategoryId": subCategoryId ?? "",
          "minBudget": minBudget,
          "maxBudget": maxBudget,
        },
      );

      if (response != null) {
        final data = FilterModel.fromJson(response);
        if (data.success == true && data.data.isNotEmpty) {
          services.value = data.data;
          funeralServices.value = services.where((service) => service.sourceModel == "funeral").toList();
          horseServices.value = services.where((service) => service.sourceModel == "horse").toList();
          chauffeurServices.value = services.where((service) => service.sourceModel == "chauffeur").toList();
          print("Filtered - Funeral: ${funeralServices.length}, Horse: ${horseServices.length}, Chauffeur: ${chauffeurServices.length}");
        } else {
          print("API Error: Response is empty or unsuccessful");
          throw Exception("Failed to apply filters");
        }
      } else {
        print("API Error: Response is null");
        throw Exception("Failed to apply filters");
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
    services.clear();
    fetchServices(); // Re-fetch with default Passenger Transport
  }
}