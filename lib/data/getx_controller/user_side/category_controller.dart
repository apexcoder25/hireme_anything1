import 'dart:convert';

import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/user_side_model/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryController extends GetxController {
  var categories = <CategoryModelss>[].obs;
  var isLoading = false.obs;

  // API Endpoints
  final String categoryApiUrl = "https://admin.hireanything.com/api/category";

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(categoryApiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        categories.value = jsonData.map((item) => CategoryModelss.fromJson(item)).toList();
      } else {
        Get.snackbar("Error", "Failed to load categories: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading(false);
    }
  }
}