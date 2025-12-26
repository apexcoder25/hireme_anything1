import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/addServiceScreen1/controllers/category_api.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/addServiceScreen1/models/sub_category_model.dart';

class DropdownController extends GetxController {
  // Observable lists
  final RxList<String> categories = <String>[].obs;
  final RxList<String> subcategories = <String>[].obs;

  // Map: category name → list of subcategories (with full data)
  final RxMap<String, List<SubCategory>> categoryMap = <String, List<SubCategory>>{}.obs;

  // Selected values
  final Rxn<String> selectedCategory = Rxn<String>();
  final Rxn<String> selectedSubcategory = Rxn<String>();
  final Rxn<String> selectedCategoryId = Rxn<String>();
  final Rxn<String> selectedSubcategoryId = Rxn<String>();

  // Loading state
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  /// Fetch categories and subcategories from API
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      print("Fetching categories and subcategories...");

      final List<SubCategory> rawData = await CategoryApiService.fetchCategoriesAndSubcategories();

      if (rawData.isEmpty) {
        _handleError("No services found. Please contact support.");
        return;
      }

      // Clear previous data
      categoryMap.clear();
      categories.clear();

      // Group by category name
      final Map<String, List<SubCategory>> tempMap = {};

      for (var subcat in rawData) {
        final categoryName = subcat.categoryId?.categoryName?.trim();

        if (categoryName == null || categoryName.isEmpty || categoryName == "null") {
          print("Skipping subcategory due to missing category: ${subcat.subcategoryName}");
          continue;
        }

        if (!tempMap.containsKey(categoryName)) {
          tempMap[categoryName] = [];
        }
        tempMap[categoryName]!.add(subcat);
      }

      if (tempMap.isEmpty) {
        _handleError("No valid categories found.");
        return;
      }

      // Sort categories alphabetically
      final sortedCategories = tempMap.keys.toList()..sort();

      // Update observables
      categories.assignAll(sortedCategories);
      categoryMap.assignAll(tempMap);

      print("Loaded ${categories.length} categories successfully.");

      // Optional success feedback
      Get.snackbar(
        "Updated",
        "Service categories loaded",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
      );
    } catch (e, stackTrace) {
      print("Error fetching categories: $e");
      print(stackTrace);
      _handleError("Failed to load services. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  /// Select a category
  void selectCategory(String categoryName) {
    if (!categories.contains(categoryName)) {
      print("Invalid category selected: $categoryName");
      return;
    }

    selectedCategory.value = categoryName;
    selectedSubcategory.value = null;
    selectedSubcategoryId.value = null;

    final subcatList = categoryMap[categoryName] ?? [];

    // Extract subcategory names and sort
    final names = subcatList
        .map((e) => e.subcategoryName?.trim())
        .where((name) => name != null && name.isNotEmpty)
        .cast<String>()
        .toList()
      ..sort();

    subcategories.assignAll(names);

    // Set category ID (from first item)
    final firstItem = subcatList.firstOrNull;
    selectedCategoryId.value = firstItem?.categoryId?.id;

    print("Selected category: $categoryName (ID: ${selectedCategoryId.value})");
    print("Available subcategories: ${subcategories.length}");
  }

  /// Select a subcategory
  void selectSubcategory(String subcategoryName) {
    final currentCategory = selectedCategory.value;
    if (currentCategory == null) {
      print("Cannot select subcategory without category");
      return;
    }

    final subcatList = categoryMap[currentCategory] ?? [];
    final matched = subcatList.firstWhereOrNull(
      (item) => item.subcategoryName?.trim() == subcategoryName.trim(),
    );

    if (matched == null) {
      print("Subcategory not found: $subcategoryName");
      return;
    }

    selectedSubcategory.value = subcategoryName;
    selectedSubcategoryId.value = matched.id;

    print("Selected subcategory: $subcategoryName (ID: ${selectedSubcategoryId.value})");
  }

  /// Manual refresh (e.g., pull-to-refresh)
  Future<void> refreshData() async {
    print("Manual refresh requested");
    clearSelection();
    await fetchCategories();
  }

  /// Clear all selections
  void clearSelection() {
    selectedCategory.value = null;
    selectedSubcategory.value = null;
    selectedCategoryId.value = null;
    selectedSubcategoryId.value = null;
    subcategories.clear();
  }

  /// Check if selection is complete
  bool get isSelectionComplete =>
      selectedCategory.value != null && selectedSubcategory.value != null;

  /// Helper to show error
  void _handleError(String message) {
    hasError.value = true;
    errorMessage.value = message;

    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      margin: const EdgeInsets.all(16),
    );
  }

  /// Get subcategory ID safely
  String? getSubcategoryId(String subcategoryName) {
    final category = selectedCategory.value;
    if (category == null) return null;

    return categoryMap[category]
        ?.firstWhereOrNull((item) => item.subcategoryName == subcategoryName)
        ?.id;
  }
}