import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/category_api.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/sub_category_model.dart';

class DropdownController extends GetxController {
  var categories = <String>[].obs;
  var subcategories = <String>[].obs;
  var categoryMap = <String, List<SubCategory>>{}.obs;

  var selectedCategory = Rxn<String>();
  var selectedSubcategory = Rxn<String>();
  var selectedCategoryId = Rxn<String>();
  var selectedSubcategoryId = Rxn<String>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      isLoading(true);
      print("🔄 Starting to fetch categories and subcategories...");
      
      List<SubCategory> data = await CategoryApiService.fetchCategoriesAndSubcategories();
      print("✅ Received ${data.length} subcategories with category data");

      if (data.isEmpty) {
        print("⚠️ No data received from API");
        _showError("No categories found. Please contact support.");
        return;
      }

      // Group subcategories by category name
      Map<String, List<SubCategory>> tempMap = {};
      int processedCount = 0;
      
      for (var subcategory in data) {
        String catName = subcategory.categoryId?.categoryName ?? "";
        
        if (catName.isNotEmpty && catName != "Unknown") {
          if (!tempMap.containsKey(catName)) {
            tempMap[catName] = [];
          }
          tempMap[catName]!.add(subcategory);
          processedCount++;
        } else {
          print("⚠️ Subcategory '${subcategory.subcategoryName}' has no valid category info");
        }
      }

      if (tempMap.isEmpty) {
        print("❌ No valid category-subcategory pairs found");
        _showError("Data processing failed. Please try again.");
        return;
      }

      // Update observables
      categories.value = tempMap.keys.toList()..sort();
      categoryMap.value = tempMap;
      
      print("🎉 Successfully loaded:");
      print("   - ${categories.length} categories");
      print("   - $processedCount total subcategories");
      print("   - Categories: ${categories.value}");
      
      // Show success message
      Get.snackbar(
        "Success",
        "Loaded ${categories.length} categories with $processedCount services",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      
    } catch (e) {
      print("❌ Error in fetchData: $e");
      _showError("Failed to load categories: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  void selectCategory(String category) {
    print("🔘 Selected category: $category");
    selectedCategory.value = category;

    // Get subcategories for selected category
    if (categoryMap.containsKey(category)) {
      subcategories.value = (categoryMap[category]?.map((e) => e.subcategoryName).toList() ?? [])
        ..removeWhere((name) => name.isEmpty)
        ..sort();

      // Get category ID from first subcategory
      final selectedCategoryModel = categoryMap[category]?.first;
      selectedCategoryId.value = selectedCategoryModel?.categoryId?.id;
      
      print("📋 Subcategories for '$category': ${subcategories.value}");
      print("🆔 Category ID: ${selectedCategoryId.value}");
    }

    // Clear subcategory selection
    selectedSubcategory.value = null;
    selectedSubcategoryId.value = null;
  }

  void selectSubcategory(String subcategory) {
    print("🔘 Selected subcategory: $subcategory");
    selectedSubcategory.value = subcategory;

    // Find the subcategory data
    if (selectedCategory.value != null && categoryMap.containsKey(selectedCategory.value!)) {
      final subcatData = categoryMap[selectedCategory.value!]?.firstWhere(
        (item) => item.subcategoryName == subcategory,
        orElse: () => SubCategory(
          id: '',
          categoryId: null,
          subcategoryName: '',
          subcategoryStatus: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          v: 0,
        ),
      );

      if (subcatData?.id != null && subcatData!.id.isNotEmpty) {
        selectedSubcategoryId.value = subcatData.id;
        print("✅ Subcategory ID: ${selectedSubcategoryId.value}");
      } else {
        print("❌ Could not find subcategory ID for: $subcategory");
      }
    }
  }

  // Manual refresh method
  void refreshData() {
    print("🔄 Manual refresh triggered");
    _clearData();
    fetchData();
  }

  void _clearData() {
    categories.clear();
    subcategories.clear();
    categoryMap.clear();
    selectedCategory.value = null;
    selectedSubcategory.value = null;
    selectedCategoryId.value = null;
    selectedSubcategoryId.value = null;
  }

  void _showError(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
    );
  }

  // Debug method
  void debugPrint() {
    print("\n=== 🔍 DROPDOWN CONTROLLER DEBUG ===");
    print("Categories (${categories.length}): ${categories.value}");
    print("Selected Category: ${selectedCategory.value}");
    print("Selected Category ID: ${selectedCategoryId.value}");
    print("Subcategories (${subcategories.length}): ${subcategories.value}");
    print("Selected Subcategory: ${selectedSubcategory.value}");
    print("Selected Subcategory ID: ${selectedSubcategoryId.value}");
    print("Is Loading: ${isLoading.value}");
    print("Category Map Keys: ${categoryMap.keys.toList()}");
    
    if (categoryMap.isNotEmpty) {
      categoryMap.forEach((key, value) {
        print("Category '$key' (${value.length} subcategories):");
        value.take(3).forEach((subcat) {
          print("  - ${subcat.subcategoryName} (ID: ${subcat.id})");
        });
        if (value.length > 3) {
          print("  ... and ${value.length - 3} more");
        }
      });
    }
    print("===================================\n");
  }
}
