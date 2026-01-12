// lib/User_app/views/BookServices/controller/all_services_controller.dart

import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/user_side_model/promotedServices_model.dart' as promoted_model;
import 'package:hire_any_thing/data/models/user_side_model/unifiedOfferingsModel.dart';
import 'package:hire_any_thing/data/services/api_service.dart';
import 'package:intl/intl.dart';

class AllServicesController extends GetxController {
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var hasMoreData = true.obs;

  var services = <Datum>[].obs;
  var promotedServices = <promoted_model.Datum>[].obs;

  // Categorized lists
  var coachServices = <Datum>[].obs;
  var funeralServices = <Datum>[].obs;
  var horseServices = <Datum>[].obs;
  var chauffeurServices = <Datum>[].obs;
  var boatServices = <Datum>[].obs;
  var minibusServices = <Datum>[].obs;

  var currentPage = 1.obs;
  final int itemsPerPage = 50;

  final ApiService _apiService = ApiService();
  final String apiUrl = "https://stag-api.hireanything.com/user/unified-offerings";

  // Filter values
  String? _filterCategoryId;
  String? _filterSubCategoryId;
  String? _filterLocation;
  DateTime? _filterDate;
  String? _filterBudget;

  @override
  void onInit() {
    super.onInit();
    fetchPromotedServices();
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
        final promoted = promoted_model.PromotedServices.fromJson(resp);
        promotedServices.value = promoted.data ?? [];
      }
    } catch (e) {
      print("Promoted fetch error: $e");
    }
  }

  Future<void> fetchAllServices({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMore.value || !hasMoreData.value) return;
      isLoadingMore(true);
    } else {
      isLoading(true);
      currentPage.value = 1;
      services.clear();
      _clearAllCategoryServices();
      hasMoreData.value = true;
    }

    try {
      final payload = {
        "categoryName": "Passenger Transport",
        "subCategoryName": _filterSubCategoryId ?? "",
        "date": _filterDate != null ? DateFormat('yyyy-MM-dd').format(_filterDate!) : "",
        "userLocation": _filterLocation,
        "page": currentPage.value,
        "limit": itemsPerPage,
        "maxDistance": null,
        "sortBy": "relevance"
      };

      final response = await _apiService.postApi(apiUrl, payload);

      if (response != null && response['success'] == true) {
        final unified = UnifiedOffering.fromJson(response);
        final newData = unified.data ?? [];

        if (loadMore) {
          // Avoid duplicates
          final filteredNew = newData.where((newItem) =>
              !services.any((existing) => existing.id == newItem.id)).toList();
          services.addAll(filteredNew);
        } else {
          services.value = newData;
        }

        hasMoreData.value = newData.length == itemsPerPage;
        _categorizeAllServices();
      } else {
        hasMoreData.value = false;
        if (!loadMore) services.clear();
      }
    } catch (e) {
      print("Fetch error: $e");
      hasMoreData.value = false;
      if (!loadMore) services.clear();
    } finally {
      isLoading(false);
      isLoadingMore(false);
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
    String lower(String? s) => (s ?? '').toLowerCase();

    coachServices.value = services.where((s) =>
        lower(s.sourceModel).contains('coach') ||
        lower(s.subcategoryId?.subcategoryName).contains('coach') ||
        lower(s.categoryId?.categoryName).contains('coach')).toList();

    minibusServices.value = services.where((s) =>
        lower(s.sourceModel).contains('minibus') ||
        lower(s.subcategoryId?.subcategoryName).contains('minibus')).toList();

    funeralServices.value = services.where((s) =>
        lower(s.sourceModel).contains('funeral') ||
        lower(s.subcategoryId?.subcategoryName).contains('funeral')).toList();

    horseServices.value = services.where((s) =>
        lower(s.sourceModel).contains('horse') ||
        lower(s.subcategoryId?.subcategoryName).contains('horse')).toList();

    chauffeurServices.value = services.where((s) =>
        lower(s.sourceModel).contains('chauffeur') ||
        lower(s.subcategoryId?.subcategoryName).contains('limousine') ||
        lower(s.subcategoryId?.subcategoryName).contains('chauffeur')).toList();

    boatServices.value = services.where((s) =>
        lower(s.sourceModel).contains('boat') ||
        lower(s.subcategoryId?.subcategoryName).contains('boat')).toList();
  }

  Future<void> applyFilter({
    String? categoryId,
    String? subCategoryId,
    String? location,
    DateTime? date,
    String? budgetRange,
  }) async {
    _filterCategoryId = categoryId;
    _filterSubCategoryId = subCategoryId;
    _filterLocation = location;
    _filterDate = date;
    _filterBudget = budgetRange;

    await fetchAllServices(); // This will refresh with new filters
  }

  void clearFilters() {
    _filterCategoryId = null;
    _filterSubCategoryId = null;
    _filterLocation = null;
    _filterDate = null;
    _filterBudget = null;
    fetchAllServices();
  }

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

  String getCategoryDisplayName(String key) {
    switch (key.toLowerCase()) {
      case 'coach':
        return 'Coach Hire Services';
      case 'minibus':
        return 'Minibus Hire Services';
      case 'funeral':
        return 'Funeral Transport';
      case 'horse':
        return 'Horse & Carriage';
      case 'chauffeur':
        return 'Chauffeur & Limousine';
      case 'boat':
        return 'Boat Hire';
      default:
        return '${key.capitalize} Services';
    }
  }

  Future<void> loadMoreServices() async {
    currentPage.value++;
    await fetchAllServices(loadMore: true);
  }
}