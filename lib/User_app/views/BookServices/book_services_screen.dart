import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/User_app/views/BookServices/controller/all_services_controller.dart';
import 'package:hire_any_thing/User_app/views/BookServices/services_card.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/addServiceScreen1/controllers/category_controller.dart';
import 'package:hire_any_thing/data/models/user_side_model/unifiedOfferingsModel.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: RefreshIndicator(
        color: AppColors.btnColor,
        onRefresh: _refreshServices,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Filter header
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Filters',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Show filters',
                          icon: Icon(_filtersOpen
                              ? Icons.expand_less
                              : Icons.filter_list),
                          onPressed: () =>
                              setState(() => _filtersOpen = !_filtersOpen),
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
                ],
              ),
            ),

            // Promoted Carousel
            SliverToBoxAdapter(
              child: Obx(() {
                final promoted = controller.promotedServices;
                if (promoted.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6.0),
                      child: Text('Featured Service Partner',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 180,
                      child: PageView.builder(
                        itemCount: promoted.length,
                        controller: _promotedPageController,
                        onPageChanged: (i) =>
                            setState(() => _promotedIndex = i),
                        itemBuilder: (context, index) {
                          final item = promoted[index];
                          return GestureDetector(
                            onTap: () => Get.snackbar(
                                'Featured', item.title.toString()),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(item.title,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                              maxLines: 2,
                                              overflow:
                                                  TextOverflow.ellipsis),
                                          SizedBox(height: 6),
                                          Text(item.subtitle,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey[700]),
                                              maxLines: 2,
                                              overflow:
                                                  TextOverflow.ellipsis),
                                          SizedBox(height: 8),
                                          Text(item.startingPrice,
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.w600)),
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
            ),

            // Unified Services Section (Loading or Content)
            SliverToBoxAdapter(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: AppColors.btnColor),
                          SizedBox(height: 16),
                          Text("Loading services...",
                              style: TextStyle(color: AppColors.textLight)),
                        ],
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              }),
            ),

            // Service Categories (Only if not loading)
            ...serviceCategories.expand((category) {
              return [
                SliverToBoxAdapter(
                  child: Obx(() {
                    if (controller.isLoading.value) return SizedBox.shrink();
                    
                    final List<Datum> services = controller
                        .getServicesByCategory(category)
                        .cast<Datum>();

                    if (services.isEmpty) return SizedBox.shrink();

                    String displayName =
                        controller.getCategoryDisplayName(category);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 7, top: 9, bottom: 3),
                          child: Row(
                            children: [
                              Icon(Icons.folder_special,
                                  color: AppColors.blue),
                              SizedBox(width: 8),
                              Text(
                                "$displayName (${services.length})",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.btnColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // We can't put the list here if we want lazy loading of items.
                        // If we put Column here, we lose lazy loading for this category.
                        // But wait, the previous implementation used SliverList for items.
                      ],
                    );
                  }),
                ),
                // The items list
                Obx(() {
                   if (controller.isLoading.value) return SliverToBoxAdapter(child: SizedBox.shrink());
                   final List<Datum> services = controller
                        .getServicesByCategory(category)
                        .cast<Datum>();
                   if (services.isEmpty) return SliverToBoxAdapter(child: SizedBox.shrink());
                   
                   return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10.0, left: 5, right: 5),
                          child: ServiceCard(service: services[index]),
                        );
                      },
                      childCount: services.length,
                    ),
                  );
                }),
                SliverToBoxAdapter(child: Obx(() => controller.isLoading.value ? SizedBox.shrink() : SizedBox(height: 18))),
              ];
            }).toList(),

            // Load More / Loading Indicator
            SliverToBoxAdapter(
              child: Obx(() {
                if (controller.isLoading.value) return SizedBox.shrink(); // Don't show load more if main loading
                
                if (controller.isLoadingMore.value) {
                  return const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (controller.hasMoreData.value) {
                  return Padding(
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
                  );
                }
                if (controller.services.isNotEmpty) {
                  return Padding(
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
                  );
                }
                return SizedBox.shrink();
              }),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
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
