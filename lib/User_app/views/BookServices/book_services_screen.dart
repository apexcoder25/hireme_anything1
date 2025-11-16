import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/addServiceScreen1/controllers/category_controller.dart';
import 'package:hire_any_thing/User_app/views/BookServices/controller/all_services_controller.dart';
import 'package:hire_any_thing/data/models/user_side_model/filter_model_services.dart';
import 'package:hire_any_thing/User_app/views/BookServices/services_card.dart';
import 'package:hire_any_thing/utilities/colors.dart';
import 'package:intl/intl.dart';

class ServicesScreen extends StatefulWidget {
  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen>
    with SingleTickerProviderStateMixin {
  final AllServicesController controller = Get.put(AllServicesController());
  final DropdownController subCatController = Get.put(DropdownController());
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 2;
  bool _filtersOpen = false;
  // Promoted carousel controller & state
  late final PageController _promotedPageController;
  int _promotedIndex = 0;
  Timer? _promotedTimer;

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
    _promotedPageController = PageController(viewportFraction: 1.0);
    _startPromotedAutoScroll();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      controller.loadMoreServices();
    }
  }

  void _startPromotedAutoScroll() {
    _promotedTimer?.cancel();
    _promotedTimer = Timer.periodic(Duration(seconds: 4), (_) {
      final len = controller.promotedServices.length;
      if (len == 0) return;
      _promotedIndex = (_promotedIndex + 1) % len;
      if (!_promotedPageController.hasClients) return;
      _promotedPageController.animateToPage(
        _promotedIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _promotedTimer?.cancel();
    _promotedPageController.dispose();
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
        final List<Datum> categoryServices =
            controller.getServicesByCategory(categoryKey).cast<Datum>();
        List<Datum> allServices = categoryServices;
        if (allServices.isEmpty) return SizedBox.shrink();
        String displayName = controller.getCategoryDisplayName(categoryKey);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2, top: 9, bottom: 3),
              child: Row(
                children: [
                  Icon(Icons.folder_special, color: AppColors.blue),
                  SizedBox(width: 8),
                  Text(
                    "$displayName (${allServices.length})",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.btnColor,
                    ),
                  ),
                ],
              ),
            ),
            ...allServices
                .map((service) => Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ServiceCard(service: service),
                    ))
                .toList(),
            SizedBox(height: 18),
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
      backgroundColor: AppColors.grey50,
      body: Column(
        children: [
          // Filter header with toggle button and animated expand/collapse
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Filters',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  tooltip: 'Show filters',
                  icon: Icon(
                      _filtersOpen ? Icons.expand_less : Icons.filter_list),
                  onPressed: () => setState(() => _filtersOpen = !_filtersOpen),
                ),
              ],
            ),
          ),
          AnimatedCrossFade(
            firstChild: SizedBox.shrink(),
            secondChild: _buildFilterSection(),
            crossFadeState: _filtersOpen
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 280),
            secondCurve: Curves.easeOut,
            firstCurve: Curves.easeIn,
          ),
          // Featured / promoted services carousel (full-width)
          Obx(() {
            final promoted = controller.promotedServices;
            if (promoted.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  child: Text('Featured Service Partner',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 180,
                  child: PageView.builder(
                    itemCount: promoted.length,
                    controller: _promotedPageController,
                    onPageChanged: (i) => setState(() => _promotedIndex = i),
                    itemBuilder: (context, index) {
                      final item = promoted[index];
                      return GestureDetector(
                        onTap: () =>
                            Get.snackbar('Featured', item.title.toString()),
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3))
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(12)),
                                child: Image.network(
                                  item.image,
                                  width: 120,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => Container(
                                      width: 120,
                                      child: Image.asset(
                                          'assets/app_logo/hireanything_logo.png')),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(item.title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                      SizedBox(height: 6),
                                      Text(item.subtitle,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[700]),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                      SizedBox(height: 8),
                                      Text(item.startingPrice,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // page indicators
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(promoted.length, (i) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        width: _promotedIndex == i ? 10 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _promotedIndex == i
                              ? Colors.blueAccent
                              : Colors.grey[400],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            );
          }),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: AppColors.btnColor),
                      SizedBox(height: 16),
                      Text("Loading services...",
                          style: TextStyle(color: AppColors.textLight)),
                    ],
                  ),
                );
              }
              int totalServices = 0;
              try {
                for (String category in serviceCategories) {
                  var categoryServices =
                      controller.getServicesByCategory(category);
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
                      Icon(Icons.search_off,
                          size: 80, color: AppColors.grey300),
                      SizedBox(height: 10),
                      Text("No services available",
                          style: TextStyle(
                              fontSize: 16, color: AppColors.grey600)),
                      SizedBox(height: 10),
                      Text(
                          "Total services loaded: ${controller.services.length}",
                          style: TextStyle(
                              fontSize: 14, color: AppColors.grey600)),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => controller.fetchAllServices(),
                        child: Text("Retry"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                color: AppColors.btnColor,
                onRefresh: _refreshServices,
                child: ListView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  children: [
                    Card(
                      color: AppColors.blueLighten4,
                      margin: EdgeInsets.only(bottom: 16),
                      elevation: 2,
                      shadowColor: AppColors.btnColor.withOpacity(0.07),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: AppColors.blueLighten2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Services",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.7,
                                color: AppColors.primaryDark,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.btnColor,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Text(
                                "${controller.services.length}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ...serviceCategories
                        .map((category) => _buildServiceSection(category))
                        .toList(),
                    if (controller.isLoadingMore.value)
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    if (controller.hasMoreData.value &&
                        !controller.isLoadingMore.value)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () => controller.loadMoreServices(),
                            child: Text("Load More Services"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (!controller.hasMoreData.value &&
                        controller.services.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.grey100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "All ${controller.services.length} services loaded",
                              style: TextStyle(
                                  color: AppColors.grey700, fontSize: 14),
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
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildCategoryDropdown()),
            ],
          ),
          SizedBox(height: 11),
          Row(
            children: [
              Expanded(child: _buildSubcategoryDropdown()),
            ],
          ),
          SizedBox(height: 11),
          Row(
            children: [
              Expanded(child: _buildLocationField()),
              SizedBox(width: 10),
              Expanded(child: _buildDatePicker()),
            ],
          ),
          SizedBox(height: 11),
          Row(
            children: [
              Expanded(child: _buildBudgetDropdown()),
            ],
          ),
          SizedBox(height: 11),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _clearFilters,
                child: Text(
                  "Clear",
                  style: TextStyle(color: AppColors.textLight),
                ),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.btnColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  elevation: 1.8,
                ),
                onPressed: _applyFilters,
                child: Text("Search",
                    style: TextStyle(fontWeight: FontWeight.bold)),
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
        icon: Icon(Icons.arrow_drop_down, color: AppColors.grey600),
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
        icon: Icon(Icons.arrow_drop_down, color: AppColors.grey600),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
        prefixIcon: Icon(Icons.location_on, color: AppColors.secondaryDark),
        hintText: "Location",
        contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 13),
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
        prefixIcon: Icon(Icons.calendar_today, color: AppColors.secondaryDark),
        hintText: selectedDate == null
            ? "Date"
            : DateFormat('dd-MM-yyyy').format(selectedDate!),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
        contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 13),
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
      icon: Icon(Icons.arrow_drop_down, color: AppColors.grey600),
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
      contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 13),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: BorderSide(color: AppColors.grey400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: BorderSide(color: AppColors.btnColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
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
