import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/category_sub_model.dart';
import 'package:hire_any_thing/data/models/user_side_model/filter_model_services.dart';
import 'package:hire_any_thing/data/services/api_service.dart';


class AllServicesController extends GetxController {
  var isLoading = true.obs;
  var isLoadingMore = false.obs;


  // Updated to handle all 6 categories
  var services = <Datum>[].obs;
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


  final String apiUrl = "https://stag-api.hireanything.com/user/global-filter";


  var subcategoryMap = <String, List<Model1>>{}.obs;


  // Pagination variables
  var currentPage = 1.obs;
  var hasMoreData = true.obs;
  var itemsPerPage = 50.obs;


  final ApiService _apiService = ApiService();


  @override
  void onInit() {
    super.onInit();
    fetchAllServices();
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


      await _fetchWithMultipleApproaches(loadMore);
    } catch (e, stackTrace) {
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


  Future<void> _fetchWithMultipleApproaches(bool loadMore) async {
    List<Map<String, dynamic>> approaches = [
      // Approach 1: No category filter (get all)
      {
        "categoryId": "",
        "subCategoryId": "",
        "minBudget": null,
        "maxBudget": null,
        "page": currentPage.value,
        "limit": itemsPerPage.value,
      },
      // Approach 2: Null category filter
      {
        "categoryId": null,
        "subCategoryId": null,
        "minBudget": null,
        "maxBudget": null,
        "page": currentPage.value,
        "limit": itemsPerPage.value,
      },
      // Approach 3: Remove category filter entirely
      {
        "subCategoryId": "",
        "minBudget": null,
        "maxBudget": null,
        "page": currentPage.value,
        "limit": itemsPerPage.value,
      },
    ];


    for (var approach in approaches) {
      try {
        final response = await _apiService.postApi(apiUrl, approach);


        if (response != null) {
          final data = FilterModel.fromJson(response);
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
            return;
          }
        }
      } catch (e) {
        continue;
      }
    }


    hasMoreData.value = false;
    if (!loadMore) {
      throw Exception("Failed to load services with any approach");
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
    coachServices.value =
        services.where((service) => service.sourceModel == "coach").toList();
    funeralServices.value =
        services.where((service) => service.sourceModel == "funeral").toList();
    horseServices.value =
        services.where((service) => service.sourceModel == "horse").toList();
    chauffeurServices.value = services
        .where((service) => service.sourceModel == "chauffeur")
        .toList();
    boatServices.value =
        services.where((service) => service.sourceModel == "boat").toList();
    minibusServices.value =
        services.where((service) => service.sourceModel == "minibus").toList();


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
      String categoryName = service.categoryId?.categoryName ?? "Unknown";
      String subcategoryName =
          service.subcategoryId?.subcategoryName ?? "Unknown";


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


      await _fetchAllFilteredServices(
        categoryId: categoryId,
        subCategoryId: subCategoryId ?? "",
        minBudget: minBudget,
        maxBudget: maxBudget,
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to apply filters: $e");
    } finally {
      isLoading(false);
    }
  }


  Future<void> _fetchAllFilteredServices({
    String? categoryId,
    required String subCategoryId,
    double? minBudget,
    double? maxBudget,
  }) async {
    int page = 1;
    bool hasMore = true;
    List<Datum> allFilteredServices = [];


    while (hasMore && page <= 10) {
      try {
        final requestPayload = {
          if (categoryId != null && categoryId.isNotEmpty)
            "categoryId": categoryId,
          "subCategoryId": subCategoryId,
          "minBudget": minBudget,
          "maxBudget": maxBudget,
          "page": page,
          "limit": itemsPerPage.value,
        };




        final response = await _apiService.postApi(apiUrl, requestPayload);


        if (response != null) {
          final data = FilterModel.fromJson(response);
          if (data.success == true && data.data.isNotEmpty) {
            var newServices = data.data
                .where((newService) => !allFilteredServices.any(
                    (existingService) => existingService.id == newService.id))
                .toList();


            allFilteredServices.addAll(newServices);
            hasMore = data.data.length >= itemsPerPage.value;
            page++;


          } else {
            hasMore = false;
          }
        } else {
          hasMore = false;
        }
      } catch (e) {
        hasMore = false;
      }
    }


    services.value = allFilteredServices;
    _categorizeAllServices();
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
