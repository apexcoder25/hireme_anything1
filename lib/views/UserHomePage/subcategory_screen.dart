import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/user_side_model/category_model.dart';
import 'package:hire_any_thing/views/UserHomePage/controller/subcategory_controller.dart';

class SubcategoryScreen extends StatefulWidget {
  final CategoryModelss category;

  const SubcategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  _SubcategoryScreenState createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  final SubcategoryController controller = Get.put(SubcategoryController());
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchSubcategories();
  }

  Future<void> _fetchSubcategories() async {
    try {
      await controller.fetchSubcategories(categoryId: widget.category.id);
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load subcategories: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.category.categoryName} Subcategories',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue[50],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          // Use controller.isLoading directly
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _fetchSubcategories,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (controller.subcategories.isEmpty) {
            return const Center(
              child: Text(
                'No subcategories available.',
                style: TextStyle(fontSize: 16),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: controller.subcategories.length,
              itemBuilder: (context, index) {
                final subcategory = controller.subcategories[index];
                return Card(
                  color: Color.fromARGB(255, 218, 234, 241),
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title: Text(
                      subcategory.subcategoryName,
                      style: const TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      subcategory.description,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    onTap: () {
                      Get.snackbar(
                        'Subcategory Selected',
                        'You selected ${subcategory.subcategoryName}',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}