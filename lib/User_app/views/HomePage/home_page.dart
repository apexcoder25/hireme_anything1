import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/category_controller.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/all_services_controller.dart';
import 'package:hire_any_thing/data/models/user_side_model/filter_model_services.dart';
import 'package:hire_any_thing/User_app/views/HomePage/services_card.dart';
import 'package:hire_any_thing/User_app/views/UserHomePage/user_drawer.dart';
import 'package:intl/intl.dart';

class ServicesScreen extends StatefulWidget {
  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final AllServicesController controller = Get.put(AllServicesController());
  final DropdownController subCatController = Get.put(DropdownController());
  final ScrollController _scrollController = ScrollController();

  int _selectedIndex = 2;

  String? selectedLocation;
  String? selectedBudget;
  DateTime? selectedDate;

  final List<String> serviceCategories = [
    'coach',
    'funeral',
    'horse',
    'chauffeur',
    'boat',
    'minibus'
  ];

  void _onDrawerItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      controller.fetchAllServices();
    });

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      controller.loadMoreServices();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refreshServices() async {
    controller.fetchAllServices();
  }

  Future<void> _applyFilters() async {
    await controller.applyFilter(
      categoryId: subCatController.selectedCategoryId.value,
      subCategoryId: subCatController.selectedSubcategoryId.value,
      location: selectedLocation,
      date: selectedDate != null
          ? DateFormat('yyyy-MM-dd').format(selectedDate!)
          : null,
      budgetRange: selectedBudget,
    );
  }

  Widget _buildServiceSection(String categoryKey) {
    return Obx(() {
      try {
        // Get ALL services for this category with error handling
        final List<Datum> categoryServices = 
            controller.getServicesByCategory(categoryKey).cast<Datum>();

        // Show ALL services (no approval filtering)
        List<Datum> allServices = categoryServices;

        if (allServices.isEmpty) return SizedBox.shrink();

        String displayName = controller.getCategoryDisplayName(categoryKey);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add category header back
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$displayName (${allServices.length})",
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ),
            // Services list
            ...allServices
                .map((service) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ServiceCard(service: service),
                ))
                .toList(),
            // Add spacing between categories
            SizedBox(height: 16),
          ],
        );
      } catch (e) {
        print("❌ Error in _buildServiceSection for $categoryKey: $e");
        return SizedBox.shrink();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(
          "All Available Services",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[50],
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: UserDrawer(onItemSelected: _onDrawerItemSelected),
      body: Column(
        children: [
          _buildFilterSection(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text("Loading services...", 
                           style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                );
              }

              // Calculate total services (no approval filtering)
              int totalServices = 0;
              try {
                for (String category in serviceCategories) {
                  var categoryServices = controller.getServicesByCategory(category);
                  totalServices += categoryServices.length;
                }
              } catch (e) {
                print("❌ Error calculating total services: $e");
              }

              if (totalServices == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 80, color: Colors.grey),
                      SizedBox(height: 10),
                      Text("No services available",
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                      SizedBox(height: 10),
                      Text(
                          "Total services loaded: ${controller.services.length}",
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600])),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => controller.fetchAllServices(),
                        child: Text("Retry"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: _refreshServices,
                child: ListView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  children: [
                    // Services summary card
                    Card(
                      color: Colors.blue[50],
                      margin: EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Services",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "${controller.services.length}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Build sections for all service categories
                    ...serviceCategories
                        .map((category) => _buildServiceSection(category))
                        .toList(),

                    // Loading indicator for pagination
                    if (controller.isLoadingMore.value)
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),

                    // Load more button
                    if (controller.hasMoreData.value &&
                        !controller.isLoadingMore.value)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () => controller.loadMoreServices(),
                            child: Text("Load More Services"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ),

                    // End indicator
                    if (!controller.hasMoreData.value &&
                        controller.services.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "All ${controller.services.length} services loaded",
                              style: TextStyle(color: Colors.grey[600], fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildCategoryDropdown(),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildSubcategoryDropdown(),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildLocationField(),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _buildDatePicker(),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildBudgetDropdown(),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _clearFilters,
                child: Text(
                  "Clear",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: _applyFilters,
                child: Text(
                  "Search",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Obx(() {
      return DropdownButtonFormField<String>(
        decoration: _dropdownDecoration("Category"),
        value: subCatController.selectedCategory.value,
        hint: Text("Category"),
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
        items: subCatController.categories.map((category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            subCatController.selectCategory(value);
          }
        },
      );
    });
  }

  Widget _buildSubcategoryDropdown() {
    return Obx(() {
      return DropdownButtonFormField<String>(
        decoration: _dropdownDecoration("Subcategory"),
        value: subCatController.selectedSubcategory.value,
        hint: Text("Subcategory"),
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
        items: subCatController.subcategories.map((subcat) {
          return DropdownMenuItem<String>(
            value: subcat,
            child: Text(subcat),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            subCatController.selectSubcategory(value);
          }
        },
      );
    });
  }

  Widget _buildLocationField() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: Icon(Icons.location_on, color: Colors.orange),
        hintText: "Location",
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onChanged: (value) {
        setState(() {
          selectedLocation = value.isEmpty ? null : value;
        });
      },
    );
  }

  Widget _buildDatePicker() {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_today, color: Colors.orange),
        hintText: selectedDate == null
            ? "Date"
            : DateFormat('dd-MM-yyyy').format(selectedDate!),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2022),
          lastDate: DateTime(2030),
        );
        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate;
          });
        }
      },
    );
  }

  Widget _buildBudgetDropdown() {
    return DropdownButtonFormField<String>(
      decoration: _dropdownDecoration("Budget"),
      value: selectedBudget,
      hint: Text("Budget"),
      isExpanded: true,
      icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
      items: ["Any Budget", "0-50", "50-100", "100-200", "200+"].map((budget) {
        return DropdownMenuItem<String>(
          value: budget == "Any Budget" ? null : budget,
          child: Text(budget),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedBudget = value;
        });
      },
    );
  }

  InputDecoration _dropdownDecoration(String hint) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.blue),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      hintText: hint,
    );
  }

  void _clearFilters() {
    setState(() {
      selectedLocation = null;
      selectedBudget = null;
      selectedDate = null;
    });
    subCatController.selectedCategory.value = null;
    subCatController.selectedSubcategory.value = null;
    subCatController.selectedCategoryId.value = null;
    subCatController.selectedSubcategoryId.value = null;
    controller.clearFilters();
  }
}