import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/category_sub_model.dart';
import 'package:hire_any_thing/data/models/user_side_model/unifiedOfferingsModel.dart';
import 'package:hire_any_thing/data/models/user_side_model/promotedServices_model.dart' as promoted_model;
import 'package:hire_any_thing/data/services/api_service.dart';


class AllServicesController extends GetxController {
  var isLoading = true.obs;
  var isLoadingMore = false.obs;


  // Updated to handle all 6 categories
  var services = <Datum>[].obs;
    // promoted/featured services
    var promotedServices = <promoted_model.Datum>[].obs;
  var coachServices = <Datum>[].obs;
  var funeralServices = <Datum>[].obs;
  var horseServices = <Datum>[].obs;
  var chauffeurServices = <Datum>[].obs;
  var boatServices = <Datum>[].obs;
  var minibusServices = <Datum>[].obs;


  var categories = <String>[].obs;
  var subcategories = <String>[].obs;


  var selectedCategory = Rxn<String>();
  var selectedSubcategory = Rxn<String>();
  var selectedSubcategoryId = Rxn<String>();


  // final String apiUrl = "https://stag-api.hireanything.com/user/global-filter";
  final String apiUrl = "https://stag-api.hireanything.com/user/unified-offerings";


  var subcategoryMap = <String, List<Model1>>{}.obs;


  // Pagination variables
  var currentPage = 1.obs;
  var hasMoreData = true.obs;
  var itemsPerPage = 20.obs;


  final ApiService _apiService = ApiService();


  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  Future<void> _initData() async {
    // 1. Fetch promoted services first (lighter request)
    await fetchPromotedServices();
    // 2. Then fetch the heavy unified services list
    fetchAllServices();
  }

  Future<void> fetchPromotedServices() async {
    try {
      final payload = {
        "userLocation": null,
        "categoryId": null,
        "maxDistance": 50,
        "limit": 3,
      };
      final resp = await _apiService.postApi('/promoted/promoted-services', payload);
      if (resp != null) {
        try {
          final promoted = promoted_model.PromotedServices.fromJson(resp);
          promotedServices.value = promoted.data;
        } catch (e) {
          // ignore parse errors for promoted
        }
      }
    } catch (e) {
      // ignore network errors for promoted
    }
  }


  Future<void> fetchAllServices({bool loadMore = false}) async {
    try {
      if (!loadMore) {
        isLoading(true);
        currentPage.value = 1;
        services.clear();
        _clearAllCategoryServices();
      } else {
        if (!hasMoreData.value || isLoadingMore.value) return;
        isLoadingMore(true);
        currentPage.value++;
      }

      await _fetchUnifiedOfferings(loadMore);
    } catch (e) {
      hasMoreData.value = false;
      Get.snackbar("Error", "Failed to load services: $e");
    } finally {
      if (loadMore) {
        isLoadingMore(false);
      } else {
        isLoading(false);
      }
    }
  }

  Future<void> _fetchUnifiedOfferings(bool loadMore) async {
    try {
      final payload = {
        "categoryName": selectedCategory.value ?? "",
        "subCategoryName": selectedSubcategory.value ?? "",
        "date": "",
        "userLocation": null,
        "page": currentPage.value,
        "limit": itemsPerPage.value,
        "maxDistance": null,
        "sortBy": "relevance"
      };

      print("Fetching unified offerings with payload: $payload");
      final response = await _apiService.postApi(apiUrl, payload);
      print("Unified offerings response: $response");

      if (response != null) {
        final data = UnifiedOffering.fromJson(response);
        print("Parsed data success: ${data.success}, count: ${data.count}, data length: ${data.data.length}");
        
        if (data.success == true && data.data.isNotEmpty) {
          if (loadMore) {
            var newServices = data.data
                .where((newService) => !services.any(
                    (existingService) => existingService.id == newService.id))
                .toList();
            services.addAll(newServices);
          } else {
            services.value = data.data;
          }

          hasMoreData.value = data.data.length >= itemsPerPage.value;
          _categorizeAllServices();

          if (!loadMore) {
            extractCategories();
          }
        } else {
          hasMoreData.value = false;
          if (!loadMore) {
             // If it's the first page and no data, ensure services is cleared (though it should be already)
             // services.clear(); // Already cleared in fetchAllServices
          }
        }
      } else {
        print("Response is null");
        hasMoreData.value = false;
      }
    } catch (e, stackTrace) {
      hasMoreData.value = false;
      print("Error fetching unified offerings: $e");
      print("Stack trace: $stackTrace");
    }
  }


  void _clearAllCategoryServices() {
    coachServices.clear();
    funeralServices.clear();
    horseServices.clear();
    chauffeurServices.clear();
    boatServices.clear();
    minibusServices.clear();
  }


  void _categorizeAllServices() {
    String lower(dynamic s) => (s?.toString() ?? '').toLowerCase();
    print("Categorizing ${services.length} services...");

    coachServices.value = services.where((service) {
      final src = lower(service.sourceModel);
      final cat = lower(service.categoryId?.categoryName);
      final name = lower(service.serviceName);
      return src.contains('coach') || cat.contains('coach') || name.contains('coach') || cat.contains('bus');
    }).toList();
    print("Coach services: ${coachServices.length}");

    funeralServices.value = services.where((service) {
      final src = lower(service.sourceModel);
      final cat = lower(service.categoryId?.categoryName);
      final name = lower(service.serviceName);
      return src.contains('funeral') || cat.contains('funeral') || name.contains('funeral');
    }).toList();
    print("Funeral services: ${funeralServices.length}");

    horseServices.value = services.where((service) {
      final src = lower(service.sourceModel);
      final cat = lower(service.categoryId?.categoryName);
      final name = lower(service.serviceName);
      return src.contains('horse') || cat.contains('horse') || name.contains('horse');
    }).toList();
    print("Horse services: ${horseServices.length}");

    chauffeurServices.value = services.where((service) {
      final src = lower(service.sourceModel);
      final cat = lower(service.categoryId?.categoryName);
      final name = lower(service.serviceName);
      return src.contains('chauffeur') || cat.contains('chauffeur') || name.contains('chauffeur');
    }).toList();
    print("Chauffeur services: ${chauffeurServices.length}");

    boatServices.value = services.where((service) {
      final src = lower(service.sourceModel);
      final cat = lower(service.categoryId?.categoryName);
      final name = lower(service.serviceName);
      return src.contains('boat') || cat.contains('boat') || name.contains('boat');
    }).toList();
    print("Boat services: ${boatServices.length}");

    minibusServices.value = services.where((service) {
      final src = lower(service.sourceModel);
      final cat = lower(service.categoryId?.categoryName);
      final name = lower(service.serviceName);
      return src.contains('minibus') || cat.contains('minibus') || name.contains('minibus');
    }).toList();
    print("Minibus services: ${minibusServices.length}");
  }

  Future<void> loadMoreServices() async {
    if (hasMoreData.value && !isLoadingMore.value) {
      await fetchAllServices(loadMore: true);
    }
  }

  void extractCategories() {
    var categorySet = <String>{};
    subcategoryMap.clear();

    for (var service in services) {
      String categoryName = service.categoryId?.categoryName?.toString() ?? "Unknown";
      String subcategoryName =
          service.subcategoryId?.subcategoryName?.toString() ?? "Unknown";

      categorySet.add(categoryName);
      subcategoryMap
          .putIfAbsent(categoryName, () => [])
          .add(Model1(subcategoryName: subcategoryName));
    }

    categories.value = categorySet.toList();
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
      currentPage.value = 1;
      services.clear();
      _clearAllCategoryServices();

      // Update selected values
      selectedCategory.value = categoryId;
      selectedSubcategory.value = subCategoryId;

      await _fetchUnifiedOfferings(false);
    } catch (e) {
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
    _clearAllCategoryServices();
    currentPage.value = 1;
    hasMoreData.value = true;
    fetchAllServices();
  }


  // Essential method to get services by category
  List<Datum> getServicesByCategory(String category) {
    switch (category.toLowerCase()) {
      case 'coach':
        return coachServices;
      case 'funeral':
        return funeralServices;
      case 'horse':
        return horseServices;
      case 'chauffeur':
        return chauffeurServices;
      case 'boat':
        return boatServices;
      case 'minibus':
        return minibusServices;
      default:
        return [];
    }
  }


  // Essential method to get display name
  String getCategoryDisplayName(String sourceModel) {
    switch (sourceModel.toLowerCase()) {
      case 'coach':
        return 'Coach Hire Services';
      case 'funeral':
        return 'Funeral Car Services';
      case 'horse':
        return 'Horse and Carriage Services';
      case 'chauffeur':
        return 'Chauffeur Services';
      case 'boat':
        return 'Boat Hire Services';
      case 'minibus':
        return 'Minibus Hire Services';
      default:
        return '${sourceModel.capitalize} Services';
    }
  }


  // For backward compatibility
  Future<void> fetchServices() async {
    await fetchAllServices();
  }
}
