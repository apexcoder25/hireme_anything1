import 'dart:convert';

import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/user_side_model/user_subcategory_model.dart';
import 'package:http/http.dart' as http;

class SubcategoryController extends GetxController {
  var subcategories = <SubcategoryModels>[].obs;
  var isLoading = false.obs;

  Future<void> fetchSubcategories({required String categoryId}) async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse("https://admin.hireanything.com/api/subcategory"));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // Filter subcategories by categoryId and ensure categoryId is not null
        subcategories.value = data
            .map((json) => SubcategoryModels.fromJson(json))
            .where((subcategory) => 
                subcategory.categoryId != null && 
                subcategory.categoryId.isNotEmpty && 
                subcategory.categoryId == categoryId)
            .toList();
        
        if (subcategories.isEmpty) {
          Get.snackbar("Info", "No subcategories found for this category.");
        }
      } else {
        Get.snackbar("Error", "Failed to fetch subcategories: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
      print("Error fetching subcategories: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Get subcategories grouped by category ID
  Map<String, List<SubcategoryModels>> getSubcategoriesByCategory() {
    Map<String, List<SubcategoryModels>> groupedSubcategories = {};
    
    for (var subcategory in subcategories) {
      if (subcategory.categoryId.isNotEmpty) {
        if (!groupedSubcategories.containsKey(subcategory.categoryId)) {
          groupedSubcategories[subcategory.categoryId] = [];
        }
        groupedSubcategories[subcategory.categoryId]!.add(subcategory);
      }
    }

    return groupedSubcategories;
  }
}