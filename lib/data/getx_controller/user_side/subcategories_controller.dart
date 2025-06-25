import 'dart:convert';

import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/user_side_model/user_subcategory_model.dart';
import 'package:http/http.dart' as http;

class SubcategoryController extends GetxController {
  var subcategories = <SubcategoryModels>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // No automatic fetch; call fetchSubcategories with categoryId when needed
  }

  Future<void> fetchSubcategories({required String categoryId}) async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse("https://admin.hireanything.com/api/subcategory"));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        subcategories.value = data
            .map((json) => SubcategoryModels.fromJson(json))
            .where((subcategory) => 
                subcategory.categoryId == categoryId && 
                subcategory.categoryId.isNotEmpty)
            .toList();
        print("Subcategories fetched for $categoryId: $subcategories");
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

  Map<String, List<SubcategoryModels>> getSubcategoriesByCategory() {
    Map<String, List<SubcategoryModels>> groupedSubcategories = {};
    for (var subcategory in subcategories) {
      if (!groupedSubcategories.containsKey(subcategory.categoryId)) {
        groupedSubcategories[subcategory.categoryId] = [];
      }
      groupedSubcategories[subcategory.categoryId]!.add(subcategory);
    }
    return groupedSubcategories;
  }
}