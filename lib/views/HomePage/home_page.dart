import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/category_controller.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/all_services_controller.dart';
import 'package:hire_any_thing/views/HomePage/services_card.dart';
import 'package:hire_any_thing/views/UserHomePage/user_drawer.dart';
import 'package:intl/intl.dart';

class ServicesScreen extends StatefulWidget {
  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final AllServicesController controller = Get.put(AllServicesController());
  final DropdownController subCatController = Get.put(DropdownController());

  int _selectedIndex = 2; 

  String? selectedCategory;
  String? selectedSubcategory;
  String? selectedLocation;
  String? selectedBudget;
  DateTime? selectedDate;


  void _onDrawerItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigation is handled in UserDrawer, so we just update the index here
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      controller.fetchServices();
    });
  }

  Future<void> _refreshServices() async {
    controller.fetchServices();
  }

  Future<void> _applyFilters() async {
    await controller.applyFilter(
      category: subCatController.selectedCategory.value,
      subcategory: subCatController.selectedSubcategory.value,
      location: selectedLocation,
      date: selectedDate != null
          ? DateFormat('yyyy-MM-dd').format(selectedDate!)
          : null,
      budgetRange: selectedBudget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.lightBlue[50], 
      appBar: AppBar(
        title: Text(
          "Available Services",
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18),
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
                return Center(child: CircularProgressIndicator());
              }

              var filteredServices = [
                ...controller.vendorServices.where((s) => s.serviceApproveStatus == "1"),
                ...controller.tutorHireServices.where((s) => s.serviceApproveStatus == "1"),
                ...controller.automotiveHireServices.where((s) => s.serviceApproveStatus == "1"),
              ];

              if (filteredServices.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 80, color: Colors.grey),
                      SizedBox(height: 10),
                      Text("No approved services available", style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: _refreshServices,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  itemCount: filteredServices.length,
                  itemBuilder: (context, index) {
                    final service = filteredServices[index];
                    return ServiceCard(service: service);
                  },
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
    final DropdownController catController = Get.put(DropdownController());
    return Obx(() {
      return DropdownButtonFormField<String>(
        decoration: _dropdownDecoration("Photographers"),
        value: catController.selectedCategory.value,
        hint: Text("Photographers"),
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
        items: catController.categories.map((category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            catController.selectCategory(value);
          }
        },
      );
    });
  }

  Widget _buildSubcategoryDropdown() {
    final DropdownController subCatController = Get.put(DropdownController());
    return Obx(() {
      return DropdownButtonFormField<String>(
        decoration: _dropdownDecoration("Event Type"),
        value: subCatController.selectedSubcategory.value,
        hint: Text("Event Type"),
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
          selectedLocation = value;
        });
      },
    );
  }

  Widget _buildDatePicker() {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_today, color: Colors.orange),
        hintText: selectedDate == null ? "Date" : DateFormat('dd-MM-yyyy').format(selectedDate!),
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
      items: [
        "Any Budget",
        "0-50",
        "50-100",
        "100-200",
        "200+"
      ].map((budget) {
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
      selectedCategory = null;
      selectedSubcategory = null;
      selectedLocation = null;
      selectedBudget = null;
      selectedDate = null;
    });
  }
}