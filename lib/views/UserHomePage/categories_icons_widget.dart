import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/category_controller.dart';
import 'package:hire_any_thing/views/UserHomePage/subcategory_screen.dart';

class CategoriesCarouselScreen extends StatelessWidget {
  final CategoryController controller = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to SubcategoryScreen with the selected category
                      Get.to(() => SubcategoryScreen(category: category));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue[100],
                            child: category.categoryImage != null
                                ? Image.network(
                                    category.categoryImage!,
                                    width: 30,
                                    height: 30,
                                    errorBuilder: (context, error, stackTrace) => const Icon(
                                      Icons.category,
                                      color: Colors.blue,
                                      size: 30,
                                    ),
                                  )
                                : Icon(
                                    _getIcon(category.categoryName),
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            category.categoryName,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  IconData _getIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'vehicles':
        return Icons.directions_car;
      case 'electronics':
        return Icons.devices;
      case 'furniture':
        return Icons.weekend;
      case 'tools':
        return Icons.build;
      case 'sports':
        return Icons.sports_soccer;
      case 'party':
        return Icons.celebration;
      case 'photography':
        return Icons.camera_alt;
      case 'construction':
        return Icons.construction;
      default:
        return Icons.category;
    }
  }
}