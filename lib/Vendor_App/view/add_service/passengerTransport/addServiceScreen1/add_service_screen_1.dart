import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/automotive_electric_hire_service/automotive_and_electric_hire.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/calenderController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/addServiceScreen1/controllers/category_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/BoatHireService/boat_hire_service_screen.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/ChauffeurHireService/chauffeur_Driven_Prestige_Car_HIre.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coachHireService/coach_hire_services.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/FuneralCarHireService/funeralCarHireService.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/horseAndCarriageHireService/horse_and_carriage_hire_service.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/lumosineHireService/limousine_hire_service.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/minibusHireService/minibus_hire_services.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/passenger_transpost.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/widgets/profile_validation_dialog.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/vender_side_getx_controller.dart';
import 'package:hire_any_thing/utilities/colors.dart';

class AddServiceScreenFirst extends StatefulWidget {
  AddServiceScreenFirst({Key? key}) : super(key: key);

  @override
  State<AddServiceScreenFirst> createState() => _AddServiceScreenFirstState();
}

class _AddServiceScreenFirstState extends State<AddServiceScreenFirst> {
  final DropdownController controller = Get.put(DropdownController());
  final CalendarController Calendercontroller = Get.put(CalendarController());

  // Essential controllers only
  bool loader = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VenderSidetGetXController venderSidetGetXController =
      Get.put(VenderSidetGetXController());

  @override
  void initState() {
    super.initState();
    _initializeData();
    _checkProfileValidation();
  }

  void _initializeData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.categories.isEmpty) {
        controller.refreshData();
      }
    });
  }

  void _checkProfileValidation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const ProfileValidationDialog(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildHeaderSection(),
          _buildFormSection(),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.btnColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.add_business_outlined,
                        color: AppColors.btnColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Service Category',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Select your business category and service type',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey.shade200,
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryDropdown(),
            const SizedBox(height: 24),
            _buildSubcategoryDropdown(),
            const SizedBox(height: 40),
            _buildActionButtons(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.category_outlined,
              color: AppColors.btnColor,
              size: 20,
            ),
            const SizedBox(width: 8),
            const Text(
              'Business Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const Text(
              ' *',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (controller.isLoading.value) {
            return _buildLoadingDropdown();
          }

          if (controller.categories.isEmpty) {
            return _buildErrorDropdown();
          }

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              dropdownColor: Colors.white,
              value: controller.selectedCategory.value,
              hint: Text(
                "Choose your business category",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 15,
                ),
              ),
              isExpanded: true,
              validator: (value) =>
                  value == null ? "Please select a category" : null,
              items: controller.categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.btnColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          category,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.selectCategory(value);
                  _showSelectionFeedback("Category selected: $value");
                }
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSubcategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.tune_outlined,
              color: AppColors.btnColor,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Service Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              ' *',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Obx(() {
          bool isDisabled = controller.selectedCategory.value == null;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: isDisabled ? Colors.grey.shade100 : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDisabled ? Colors.grey.shade300 : Colors.grey.shade300,
                width: 1.5,
              ),
              boxShadow: isDisabled
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 15,
                color: isDisabled ? Colors.grey.shade500 : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              dropdownColor: Colors.white,
              value: controller.selectedSubcategory.value,
              hint: Text(
                isDisabled
                    ? "First select a category above"
                    : "Choose your specific service",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 15,
                ),
              ),
              isExpanded: true,
              validator: (value) =>
                  value == null ? "Please select a service type" : null,
              items: controller.subcategories.map((subcat) {
                return DropdownMenuItem<String>(
                  value: subcat,
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: AppColors.btnColor.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          subcat,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: isDisabled
                  ? null
                  : (value) {
                      if (value != null) {
                        controller.selectSubcategory(value);
                        _showSelectionFeedback("Service selected: $value");
                      }
                    },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildLoadingDropdown() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.btnColor),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              "Loading categories...",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorDropdown() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade200, width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red.shade400,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Unable to load categories",
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton.icon(
              onPressed: controller.refreshData,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text("Retry"),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red.shade700,
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Selection Summary (only show when both are selected)
        Obx(() {
          if (controller.selectedCategory.value != null &&
              controller.selectedSubcategory.value != null) {
            return Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.btnColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.btnColor.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: AppColors.btnColor,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Selection Summary',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryRow(
                    'Category',
                    controller.selectedCategory.value!,
                    Icons.category_outlined,
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryRow(
                    'Service Type',
                    controller.selectedSubcategory.value!,
                    Icons.tune_outlined,
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        }),

        // Continue Button
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.btnColor.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: loader ? null : _handleNextButtonPress,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.btnColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: loader
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue to Service Details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 20,
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.btnColor.withOpacity(0.7),
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.btnColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _handleNextButtonPress() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      _showErrorSnackbar("Please complete all required fields");
      return;
    }

    if (controller.selectedCategory.value == null) {
      _showErrorSnackbar("Please select a business category");
      return;
    }

    if (controller.selectedSubcategory.value == null) {
      _showErrorSnackbar("Please select a service type");
      return;
    }

    setState(() => loader = true);

    // Simulate processing delay
    await Future.delayed(const Duration(milliseconds: 800));

    setState(() => loader = false);

    // Navigate
    _navigateToServiceScreen();
  }

  void _navigateToServiceScreen() {
    final category = controller.selectedCategory.value!;
    final subcategory = controller.selectedSubcategory.value!;
    final categoryId = controller.selectedCategoryId.value ?? "";
    final subcategoryId = controller.selectedSubcategoryId.value ?? "";

    // Navigation logic (keeping your existing logic)
    if (category == 'Passenger Transport') {
      switch (subcategory) {
        case 'Boat Hire':
          Get.to(() => BoatHireService(
                category: Rxn<String>(category),
                subCategory: Rxn<String>(subcategory),
                categoryId: categoryId,
                subCategoryId: subcategoryId,
              ));
          break;
        case 'Chauffeur Driven Prestige Car Hire':
          Get.to(() => ChauffeurHireService(
                category: Rxn<String>(category),
                subCategory: Rxn<String>(subcategory),
                categoryId: categoryId,
                subCategoryId: subcategoryId,
              ));
          break;
        case 'Limousine Hire':
          Get.to(() => LimousineHireService(
                category: Rxn<String>(category),
                subCategory: Rxn<String>(subcategory),
                categoryId: categoryId,
                subCategoryId: subcategoryId,
              ));
          break;
        case 'Coach Hire':
          Get.to(() => CoachHireService(
                category: Rxn<String>(category),
                subCategory: Rxn<String>(subcategory),
                categoryId: categoryId,
                subCategoryId: subcategoryId,
              ));
          break;
        case 'Minibus Hire':
          Get.to(() => MinibusHireService(
              category: Rxn<String>(category),
                subCategory: Rxn<String>(subcategory),
                categoryId: categoryId,
                subCategoryId: subcategoryId,
              ));
          break;
        case 'Funeral Car Hire':
          Get.to(() => FuneralCarHireService(
                category: Rxn<String>(category),
                subCategory: Rxn<String>(subcategory),
                categoryId: categoryId,
                subCategoryId: subcategoryId,
              ));
          break;
        case 'Horse and Carriage Hire':
          Get.to(() => HorseAndCarriageHireService(
                Category: Rxn<String>(category),
                SubCategory: Rxn<String>(subcategory),
                CategoryId: categoryId,
                SubCategoryId: subcategoryId,
              ));
          break;
        default:
          Get.to(() => PassengerTransportService(
                Category: Rxn<String>(category),
                SubCategory: Rxn<String>(subcategory),
                CategoryId: categoryId,
                SubCategoryId: subcategoryId,
              ));
      }
    } else if (category == 'Automotive and Electric Hire') {
      Get.to(() => AutomotiveElectricHireService(
            Category: Rxn<String>(category),
            SubCategory: Rxn<String>(subcategory),
            CategoryId: categoryId,
            SubCategoryId: subcategoryId,
          ));
    } else {
      _showErrorSnackbar("Service screen not found for selected category");
    }
  }

  void _showSelectionFeedback(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.btnColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(
              Icons.help_outline,
              color: AppColors.btnColor,
            ),
            const SizedBox(width: 12),
            const Text(
              'Need Help?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1. Choose your business category (e.g., Passenger Transport)',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 8),
            Text(
              '2. Select your specific service type (e.g., Limousine Hire)',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 8),
            Text(
              '3. Click "Continue" to proceed with service setup',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Got it',
              style: TextStyle(
                color: AppColors.btnColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Deprecated snackbar method (keeping for compatibility)
  gtxSnakbar(String title, String des) {
    return _showErrorSnackbar(des);
  }
}
