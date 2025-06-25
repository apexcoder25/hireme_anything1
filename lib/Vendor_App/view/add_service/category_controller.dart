import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/category_api.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/category_sub_model.dart';

class DropdownController extends GetxController {
  var categories = <String>[].obs;
  var subcategories = <String>[].obs;
  var categoryMap = <String, List<Model1>>{}.obs; 

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
      List<Model1> data = await CategoryApiService.fetchCategoriesAndSubcategories();

      Map<String, List<Model1>> tempMap = {}; 
      for (var i in data) {
        String catName = i.categoryId?.categoryName ?? "";
        if (!tempMap.containsKey(catName)) {
          tempMap[catName] = [];
        }
        tempMap[catName]!.add(i);
      }

      
      categories.value = tempMap.keys.toList()..sort();
      categoryMap.value = tempMap;
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
   
    subcategories.value = (categoryMap[category]?.map((e) => e.subcategoryName ?? "").toList() ?? [])..sort();
    selectedSubcategory.value = null;

 
    final selectedCategoryModel = categoryMap[category]?.first;
    selectedCategoryId.value = selectedCategoryModel?.categoryId?.id; 
  }

  void selectSubcategory(String subcategory) {
    selectedSubcategory.value = subcategory;

 
    final selectedCategoryModel = categoryMap[selectedCategory.value]?.firstWhere(
      (item) => item.subcategoryName == subcategory,
      orElse: () => Model1(), 
    );

    selectedSubcategoryId.value = selectedCategoryModel?.id;
  }
}