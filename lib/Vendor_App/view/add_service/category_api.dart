import 'dart:convert';

import 'package:hire_any_thing/Vendor_App/view/add_service/category_sub_model.dart';
import 'package:http/http.dart' as http;


class CategoryApiService {
  static Future<List<Model1>> fetchCategoriesAndSubcategories() async {
    final uri = Uri.parse("https://admin.hireanything.com/api/subcategory");

    try {
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final List<dynamic> data = jsonDecode(res.body);
        return data.map((e) => Model1.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Exception: $e");
    }
  }
}
