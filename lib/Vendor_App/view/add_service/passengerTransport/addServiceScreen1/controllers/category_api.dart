import 'dart:convert';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/addServiceScreen1/models/category_model.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/addServiceScreen1/models/sub_category_model.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "https://stageadmin.hireanything.com/api";
const String categoryEndpoint = "/category";
const String subcategoryEndpoint = "/subcategory";

class CategoryApiService {
  
  /// Fetches both categories and subcategories and returns combined subcategory data
  static Future<List<SubCategory>> fetchCategoriesAndSubcategories() async {
    try {
      print("🔄 Starting to fetch categories and subcategories...");
      
      // Step 1: Fetch all categories
      List<Category> categories = await _fetchCategories();
      print("✅ Fetched ${categories.length} categories");
      
      // Step 2: Fetch all subcategories  
      List<SubCategory> allSubcategories = await _fetchAllSubcategories();
      print("✅ Fetched ${allSubcategories.length} total subcategories");
      
      // Step 3: Match subcategories with their categories
      List<SubCategory> enrichedSubcategories = [];
      
      for (SubCategory subcategory in allSubcategories) {
        // Find the matching category for this subcategory
        Category? matchingCategory = categories.firstWhere(
          (category) => category.id == subcategory.categoryId?.id,
          orElse: () => Category(
            id: '',
            categoryName: 'Unknown',
            categoryImage: '',
            description: '',
            categoryStatus: '',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            v: 0,
          ),
        );
        
        // Create enriched subcategory with full category data
        SubCategory enrichedSubcategory = SubCategory(
          id: subcategory.id,
          categoryId: CategoryId(
            id: matchingCategory.id,
            categoryName: matchingCategory.categoryName,
            categoryImage: matchingCategory.categoryImage,
          ),
          subcategoryName: subcategory.subcategoryName,
          subcategoryStatus: subcategory.subcategoryStatus,
          createdAt: subcategory.createdAt,
          updatedAt: subcategory.updatedAt,
          v: subcategory.v,
          description: subcategory.description,
        );
        
        enrichedSubcategories.add(enrichedSubcategory);
      }
      
      print("🎉 Successfully enriched ${enrichedSubcategories.length} subcategories with category data");
      return enrichedSubcategories;
      
    } catch (e) {
      print("❌ Error in fetchCategoriesAndSubcategories: $e");
      throw Exception("Failed to fetch categories and subcategories: $e");
    }
  }
  
  /// Fetches all categories from the API
  static Future<List<Category>> _fetchCategories() async {
    final uri = Uri.parse("$baseUrl$categoryEndpoint");
    
    try {
      print("📡 Fetching categories from: ${uri.toString()}");
      
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      
      print("📊 Categories Response Status: ${response.statusCode}");
      
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        print("📋 Processing ${responseData.length} categories");
        
        return responseData.map((categoryJson) => Category.fromJson(categoryJson)).toList();
        
      } else {
        throw Exception("HTTP ${response.statusCode}: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("❌ Error fetching categories: $e");
      throw Exception("Failed to fetch categories: $e");
    }
  }
  
  /// Fetches all subcategories from the API
  static Future<List<SubCategory>> _fetchAllSubcategories() async {
    final uri = Uri.parse("$baseUrl$subcategoryEndpoint");
    
    try {
      print("📡 Fetching subcategories from: ${uri.toString()}");
      
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      
      print("📊 Subcategories Response Status: ${response.statusCode}");
      
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        print("📋 Processing ${responseData.length} subcategories");
        
        return responseData.map((subcategoryJson) => SubCategory.fromJson(subcategoryJson)).toList();
        
      } else {
        throw Exception("HTTP ${response.statusCode}: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("❌ Error fetching subcategories: $e");
      throw Exception("Failed to fetch subcategories: $e");
    }
  }
  
  /// Alternative method: Fetch subcategories for a specific category
  static Future<List<SubCategory>> fetchSubcategoriesForCategory(String categoryId) async {
    final uri = Uri.parse("$baseUrl$subcategoryEndpoint/category/$categoryId");
    
    try {
      print("📡 Fetching subcategories for category $categoryId from: ${uri.toString()}");
      
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      
      print("📊 Category Subcategories Response Status: ${response.statusCode}");
      
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((subcategoryJson) => SubCategory.fromJson(subcategoryJson)).toList();
      } else {
        throw Exception("HTTP ${response.statusCode}: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("❌ Error fetching subcategories for category: $e");
      throw Exception("Failed to fetch subcategories for category: $e");
    }
  }
  
  /// Fetch only categories
  static Future<List<Category>> fetchCategoriesOnly() async {
    return await _fetchCategories();
  }
}
