
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/category_controller.dart';
import 'package:hire_any_thing/User_app/views/UserHomePage/controller/subcategory_controller.dart';
import 'package:hire_any_thing/data/models/user_side_model/category_model.dart';
import 'package:hire_any_thing/res/routes/routes.dart' as UserRoutes;
import 'package:shimmer/shimmer.dart';
import 'package:hire_any_thing/User_app/views/UserHomePage/subcategory_screen.dart';

class CategoryGridPage extends StatefulWidget {
  @override
  _CategoryGridPageState createState() => _CategoryGridPageState();
}

class _CategoryGridPageState extends State<CategoryGridPage> {
  final CategoryController categoryController = Get.put(CategoryController());
  final SubcategoryController subcategoryController = Get.put(SubcategoryController());

  @override
  void initState() {
    super.initState();
    // No need to call fetchCategories here; it's handled in CategoryController.onInit
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[50],
        title: Text("Find Affordable Services"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (categoryController.isLoading.value) {
          return _buildShimmerEffect();
        }

        if (categoryController.categories.isEmpty) {
          return Center(
            child: Text(
              "No categories available",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: categoryController.categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.65, // Adjusted for larger cards similar to the image
            ),
            itemBuilder: (context, index) {
              final category = categoryController.categories[index];
              return _buildCategoryCard(context, category);
            },
          ),
        );
      }),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        itemCount: 4, // Placeholder for 4 shimmer cards
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 20,
                    width: 100,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Column(
                      children: List.generate(3, (index) => Container(
                        height: 20,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 4),
                        color: Colors.white,
                      )),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    width: 100,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, CategoryModelss category) {
    return Obx(() {
      final subcategories = subcategoryController.getSubcategoriesByCategory()[category.id] ?? [];

        return GestureDetector(
        onTap: () {
          // Navigate to subcategory screen; SubcategoryScreen will fetch items itself
          Get.to(() => SubcategoryScreen(category: category));
        },
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cached Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    category.categoryImage,
                    height: 120, // Slightly larger to match the image
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 120,
                        width: double.infinity,
                        color: Colors.grey[300],
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 120,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  category.categoryName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                // Subcategories below image
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: subcategories.length > 3 ? 3 : subcategories.length,
                      itemBuilder: (context, index) {
                        final sub = subcategories[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            sub.subcategoryName,
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      String route = '/';
                      switch (category.categoryName) {
                        case 'Tutor Hire':
                          route = UserRoutes.UserRoutesName.tutorHireScreen;
                          break;
                        case 'Passenger Transport':
                          route = UserRoutes.UserRoutesName.passengerTransportHireScreen;
                          break;
                        case 'Artist Hire':
                          route = UserRoutes.UserRoutesName.artistHireScreen;
                          break;
                      }
                      if (route != '/') {
                        Get.toNamed(route);
                      } else {
                        // Fallback route
                        Get.toNamed(UserRoutes.UserRoutesName.MeetingRoomHireScreen);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('More Info →', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}