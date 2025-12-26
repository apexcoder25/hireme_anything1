import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/calenderController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/controller/add_vendor_services_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupanController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupon_list.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupondialog.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/image_controller.dart';
import 'package:hire_any_thing/constants_file/uk_cities.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/service_controller.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:hire_any_thing/res/routes/routes.dart';
import 'package:hire_any_thing/utilities/colors.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

// Document Model
class DocumentFile {
  final String path;
  final String name;
  final String type; // 'pdf', 'jpg', 'png'
  final int size; // in bytes
  bool isUploaded;
  String? uploadUrl;

  DocumentFile({
    required this.path,
    required this.name,
    required this.type,
    required this.size,
    this.isUploaded = false,
    this.uploadUrl,
  });

  String get displaySize {
    if (size < 1024) return '${size} B';
    if (size < 1048576) return '${(size / 1024).toStringAsFixed(1)} KB';
    return '${(size / 1048576).toStringAsFixed(1)} MB';
  }

  bool get isValidSize => size <= 5 * 1024 * 1024; // 5MB limit
}

// Coach Hire Controller with EXACT API PAYLOAD STRUCTURE
class CoachHireController extends GetxController {
  // Observable states
  var currentStep = 1.obs;
  var isLoading = false.obs;
  var isNavigating = false.obs;
  var isSubmitting = false.obs;
  var completedSteps = <int>{}.obs;

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text controllers - Coach Hire specific
  final TextEditingController listingTitleController = TextEditingController();
  final TextEditingController baseLocationController = TextEditingController();
  final TextEditingController makeModelController = TextEditingController();
  final TextEditingController numberOfSeatsController = TextEditingController();
  final TextEditingController largeSuitcasesController =
      TextEditingController();
  final TextEditingController mediumSuitcasesController =
      TextEditingController();
      final TextEditingController otherTypeController = TextEditingController();
  final TextEditingController smallSuitcasesController =
      TextEditingController();
  final TextEditingController dayRateController = TextEditingController();
  final TextEditingController hourlyRateController = TextEditingController();
  final TextEditingController halfDayRateController = TextEditingController();
  final TextEditingController extraMileageChargeController =
      TextEditingController();
  final TextEditingController serviceRadiusController = TextEditingController();
  final TextEditingController searchCitiesController = TextEditingController();

  // Event & Extra Price Controllers
  final TextEditingController champagnePackagePriceController =
      TextEditingController();
  final TextEditingController champagneBrandController =
      TextEditingController();
  final TextEditingController champagneBottlesController =
      TextEditingController(text: '1');
  final TextEditingController champagnePackageDetailsController =
      TextEditingController();
  final TextEditingController photographyPackagePriceController =
      TextEditingController();
  final TextEditingController photographyDurationController =
      TextEditingController(text: '2 hours');
  final TextEditingController photographyTeamSizeController =
      TextEditingController(text: '2 photographers');
  final TextEditingController photographyPackageDetailsController =
      TextEditingController();
  final TextEditingController photographyDeliveryTimeController =
      TextEditingController();

  // Accessibility Controllers
  final TextEditingController wheelchairAccessPriceController =
      TextEditingController();
  final TextEditingController childCarSeatsPriceController =
      TextEditingController();
  final TextEditingController petFriendlyPriceController =
      TextEditingController();
  final TextEditingController disabledAccessRampPriceController =
      TextEditingController();
  final TextEditingController seniorAssistancePriceController =
      TextEditingController();
  final TextEditingController strollerStoragePriceController =
      TextEditingController();

  // Observable selections
  var selectedServiceStatus = 'Open'.obs;
  var selectedCancellationPolicy = 'FLEXIBLE'.obs;
  var firstRegistrationDate = DateTime.now().obs;

  // Coach Hire specific category IDs
  String categoryId =
      "676ac544234968d45b494992"; // Your actual coach hire category ObjectId
  String subcategoryId =
      "676ace13234968d45b4949db"; // Your actual coach hire subcategory ObjectId

  // Document storage for API
  RxList<DocumentFile> publicLiabilityDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> operatorLicenceDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> driverLicencesDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> vehicleMOTDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> serviceImages = <DocumentFile>[].obs;

  // Areas management
  RxList<String> selectedAreas = <String>[].obs;
  RxList<String> filteredCities = <String>[].obs;

  // Luggage capacity
  var totalLuggageCapacity = 0.obs;
  int mileageLimit = 200; // Fixed as per your requirement
  // ADD THESE LINES - Events & Extras Price Controllers
  final TextEditingController partyLightingPriceController = TextEditingController();

  // Types of Hire Map (you already have this, but make sure it's there)
  final Map<String, bool> typesOfHire = {
    'Corporate hire': false,
    'School trips': false,
    'Airport transfers': false,
    'Weddings': false,
    'Funeral service': false,
    'Tourism & day trips': false,
    'Concerts & events': false,
    'Sports teams': false,
    'Shuttle/commuter runs': false,
    'VIP/celebrity': false,
    'Accessible transport': false,
    'Other': false,
  }.obs;
  // Basic Features (matching your payload)
  var comfortLuxuryFeatures = {
    'leatherInterior': false,
    'wifiAccess': false,
    'airConditioning': false,
    'complimentaryDrinks': false,
    'onboardEntertainmentSystem': false,
    'bluetoothUsb': false,
    'redCarpetService': false,
    'onboardRestroom': false,
  }.obs;

  // Events Features
  var eventsExtrasFeatures = {
    'weddingDecor': false,
    'partyLightingSystem': false,
    'champagnePackages': false,
    'photographyPackages': false,
  }.obs;

  final Map<String, String> cancellationPolicyMap = {
    'FLEXIBLE': 'Flexible',
    'MODERATE': 'Moderate',
    'STRICT': 'Strict',
    'SUPER_STRICT': 'Super Strict',
  }.obs;

  // Accessibility Features
  var accessibilityFeatures = {
    'wheelchairAccessVehicle': false,
    'childCarSeats': false,
    'petFriendlyService': false,
    'disabledAccessRamp': false,
    'seniorFriendlyAssistance': false,
    'strollerBuggyStorage': false,
  }.obs;

  // Security Features
  var securityFeatures = {
    'vehicleTrackingGps': false,
    'cctvFitted': false,
  }.obs;

  // Terms
  var isAccurateInfo = false.obs;
  var noContactDetailsShared = false.obs;
  var agreeCookiesPolicy = false.obs;
  var agreePrivacyPolicy = false.obs;
  var agreeCancellationPolicy = false.obs;

  // Static data
  final List<String> serviceStatusOptions = ['Open', 'Closed'];

  // Service controllers
  final ImageController imageController = Get.put(ImageController());
  final CouponController couponController = Get.put(CouponController());
  final CalendarController calendarController = Get.put(CalendarController());

  // Vendor info
  String? vendorId;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
    _setupListeners();
    _loadVendorId();
  }

  void _initializeData() {
    filteredCities.value = Cities.ukCities;

    // Initialize calendar dates
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (calendarController.fromDate.value.isBefore(DateTime.now())) {
        calendarController.fromDate.value = DateTime.now();
      }
      if (calendarController.toDate.value.isBefore(DateTime.now())) {
        calendarController.toDate.value =
            DateTime.now().add(const Duration(days: 7));
      }
    });
  }

  void _setupListeners() {
    searchCitiesController.addListener(_filterCities);
    dayRateController.addListener(() {
      calendarController
          .setDefaultPrice(double.tryParse(dayRateController.text) ?? 0.0);
    });

    // Setup luggage calculation
    largeSuitcasesController.addListener(_calculateLuggageCapacity);
    mediumSuitcasesController.addListener(_calculateLuggageCapacity);
    smallSuitcasesController.addListener(_calculateLuggageCapacity);
  }

  void _calculateLuggageCapacity() {
    final large = int.tryParse(largeSuitcasesController.text) ?? 0;
    final medium = int.tryParse(mediumSuitcasesController.text) ?? 0;
    final small = int.tryParse(smallSuitcasesController.text) ?? 0;
    totalLuggageCapacity.value = large + medium + small;
  }

  Future<void> _loadVendorId() async {
    vendorId = await SessionVendorSideManager().getVendorId();
  }

  void _filterCities() {
    final query = searchCitiesController.text.toLowerCase();
    if (query.isEmpty) {
      filteredCities.value = Cities.ukCities;
    } else {
      filteredCities.value = Cities.ukCities
          .where((city) => city.toLowerCase().contains(query))
          .toList();
    }
  }

  // Navigation methods
  Future<void> nextStep() async {
    if (currentStep.value < 10) {
      if (await _validateCurrentStep()) {
        isNavigating.value = true;
        await Future.delayed(const Duration(milliseconds: 200));

        completedSteps.add(currentStep.value);
        currentStep.value++;

        isNavigating.value = false;
        HapticFeedback.selectionClick();
      }
    }
  }

  Future<void> previousStep() async {
    if (currentStep.value > 1) {
      isNavigating.value = true;
      await Future.delayed(const Duration(milliseconds: 150));
      currentStep.value--;
      isNavigating.value = false;
    }
  }

  // Validation methods
  Future<bool> _validateCurrentStep() async {
    switch (currentStep.value) {
      case 1:
        return true;
         // Documents
      case 2:
        return await _validateStep2(); // Listing Details
      case 3:
        return await _validateStep3(); // Vehicle Info
      case 4:
        return await _validateStep4(); // Pricing Details
      case 5:
        return await _validateStep5(); // Coverage & Location
      case 6:
        return await _validateStep6(); // Service Availability
      case 7:
        return true; // Basic Features - optional
      case 8:
        return await _validateStep8(); // Photos & Media
      case 9:
        return true; // Coupon management - optional
      case 10:
        return await _validateStep10(); // Terms
      default:
        return true;
    }
  }

  // Future<bool> _validateStep1() async {
  //   if (publicLiabilityDocs.isEmpty) {
  //     _showError('Public Liability Insurance document is required');
  //     return false;
  //   }
  //   if (operatorLicenceDocs.isEmpty) {
  //     _showError('Operator Licence document is required');
  //     return false;
  //   }
  //   return true;
  // }

  Future<bool> _validateStep2() async {
    if (listingTitleController.text.trim().isEmpty) {
      _showError('Please enter a listing title');
      return false;
    }
    if (listingTitleController.text.trim().length < 3) {
      _showError('Title must be at least 3 characters');
      return false;
    }
    if (baseLocationController.text.trim().isEmpty) {
      _showError('Please enter base location');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep3() async {
    if (makeModelController.text.trim().isEmpty ||
        numberOfSeatsController.text.trim().isEmpty) {
      _showError('All vehicle information fields are required');
      return false;
    }

    final seats = int.tryParse(numberOfSeatsController.text.trim()) ?? 0;
    if (seats < 1 || seats > 70) {
      _showError('Number of seats must be between 1 and 70');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep4() async {
    final dayRate = double.tryParse(dayRateController.text.trim()) ?? 0;
    final hourlyRate = double.tryParse(hourlyRateController.text.trim()) ?? 0;
    final halfDayRate = double.tryParse(halfDayRateController.text.trim()) ?? 0;

    // API requires fullDayRate (dayRate) to be provided
    if (dayRate <= 0) {
      _showError('Full Day Rate is required');
      return false;
    }
    
    if (dayRate == 0 && hourlyRate == 0 && halfDayRate == 0) {
      _showError('At least one pricing field is required');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep5() async {
    if (selectedAreas.isEmpty) {
      _showError('Please select at least one area covered');
      return false;
    }
    // Validate locationRadius requirement
    if (serviceRadiusController.text.trim().isEmpty) {
      _showError('Please enter service radius');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep6() async {
    // Validate required fields for service availability
    if (selectedCancellationPolicy.value.isEmpty) {
      _showError('Please select cancellation policy');
      return false;
    }
    if (calendarController.fromDate.value.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      _showError('Available from date cannot be in the past');
      return false;
    }
    if (calendarController.toDate.value.isBefore(calendarController.fromDate.value)) {
      _showError('Available to date must be after from date');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep8() async {
    if (serviceImages.length < 3) {
      _showError('Minimum 3 high-quality service images are required');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep10() async {
    if (!isAccurateInfo.value ||
        !noContactDetailsShared.value ||
        !agreeCookiesPolicy.value ||
        !agreePrivacyPolicy.value ||
        !agreeCancellationPolicy.value) {
      _showError('Please agree to all terms and conditions to continue');
      return false;
    }
    return true;
  }

  void _showError(String message) {
    Get.snackbar(
      'Validation Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error,
      colorText: AppColors.white,
      icon: const Icon(Icons.error_outline, color: AppColors.white),
      duration: const Duration(seconds: 4),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
    HapticFeedback.lightImpact();
  }

  // Document upload methods
  Future<void> pickDocument(RxList<DocumentFile> documentList,
      {String? docType}) async {
    try {
      // Allow multiple file selection for service images, single for others
      bool allowMultiple = documentList == serviceImages;
      
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        allowMultiple: allowMultiple,
      );

      if (result != null && result.files.isNotEmpty) {
        int addedCount = 0;
        int failedCount = 0;
        
        for (var file in result.files) {
          if (file.path == null) continue;
          
          final filePath = file.path!;
          final fileSize = file.size;

          if (fileSize > 5 * 1024 * 1024) {
            // 5MB limit
            failedCount++;
            continue;
          }

          final document = DocumentFile(
            path: filePath,
            name: file.name,
            type: file.extension?.toLowerCase() ?? '',
            size: fileSize,
          );

          documentList.add(document);
          addedCount++;
        }

        if (addedCount > 0) {
          Get.snackbar(
            'Success',
            '$addedCount document(s) added successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.success,
            colorText: AppColors.white,
            duration: const Duration(seconds: 2),
          );
        }
        
        if (failedCount > 0) {
          _showError('$failedCount file(s) exceeded 5MB limit');
        }
      }
    } catch (e) {
      _showError('Failed to pick document: $e');
    }
  }

  void removeDocument(RxList<DocumentFile> documentList, int index) {
    if (index < documentList.length) {
      documentList.removeAt(index);
    }
  }

  // Special pricing dialog method
  void _showSetPriceDialog(DateTime selectedDay) {
    final priceController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: Text(
            'Set Special Price for ${DateFormat('EEE, d MMM yyyy').format(selectedDay)}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Day Rate (£)',
                hintText: 'Enter special price',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final price = double.tryParse(priceController.text) ?? 0.0;
              if (price > 0) {
                calendarController.setSpecialPrice(selectedDay, price);
                Get.back();
              } else {
                Get.snackbar('Error', 'Please enter a valid price');
              }
            },
            child: Text('Set Price'),
          ),
        ],
      ),
    );
  }
Widget _buildCalendarCell(DateTime day, bool isVisible) {
  final defaultRate = double.tryParse(dayRateController.text) ?? 0.0;
  final specialPrice = calendarController.specialPrices
      .firstWhereOrNull((entry) => isSameDay(entry['date'] as DateTime, day))
      ?['price'] as double?;
  final displayPrice = specialPrice ?? defaultRate;

  return Container(
    margin: const EdgeInsets.all(2),
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: isVisible
          ? (specialPrice != null ? Colors.green.shade100 : Colors.blue.shade100)
          : Colors.grey.shade200,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        color: isVisible
            ? (specialPrice != null ? Colors.green : Colors.blue)
            : Colors.grey,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${day.day}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: isVisible ? Colors.black : Colors.grey)),
        if (displayPrice > 0)
          Text('£${displayPrice.toStringAsFixed(0)}', style: TextStyle(fontSize: 9, color: specialPrice != null ? Colors.green.shade700 : Colors.blue.shade700, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
  // Enhanced form submission with EXACT API payload structure
  Future<void> submitForm() async {
    if (!await _validateStep10()) return;

    isSubmitting.value = true;
    try {
      _showSubmissionProgress();

      try {
        // Upload all documents first
        await _uploadAllDocuments();

        // Prepare API data with EXACT payload structure
        final formData = await _prepareAPIPayload();

        // Submit to API
        final api = AddVendorServiceApi();
        final isAdded = await api.addServiceVendor(formData, 'coach');

        // Close progress dialog before showing result
        if (Get.isDialogOpen == true) {
          Get.back();
        }

        if (isAdded) {
          _showSubmissionSuccess();
          await Future.delayed(const Duration(seconds: 2));
          Get.offAllNamed(VendorRoutesName.mainDashboard);
        } else {
          _showSubmissionError('Failed to submit service. Please try again.');
        }
      } catch (e) {
        // Close progress dialog on any error - use multiple methods to ensure it closes
        try {
          if (Get.isDialogOpen == true) {
            Get.back();
          }
          // Additional safety: close any remaining dialogs
          while (Get.isDialogOpen ?? false) {
            Get.back();
          }
        } catch (_) {}
        _showSubmissionError(e.toString());
      }
    } finally {
      isSubmitting.value = false;

      // Refresh services list
      try {
        final ServiceController controller = Get.find<ServiceController>();
        controller.fetchServices();
      } catch (e) {
        print('Error refreshing services: $e');
      }
    }
  }

  Future<void> _uploadAllDocuments() async {
    // Upload all document types
    await _uploadDocumentList(publicLiabilityDocs);
    await _uploadDocumentList(operatorLicenceDocs);
    await _uploadDocumentList(driverLicencesDocs);
    await _uploadDocumentList(vehicleMOTDocs);
    await _uploadDocumentList(serviceImages);
  }

  Future<void> _uploadDocumentList(RxList<DocumentFile> documents) async {
    // Upload all documents in parallel for better performance
    final uploadFutures = documents
        .where((doc) => !doc.isUploaded)
        .map((doc) async {
          try {
            final uploadedUrl = await imageController.uploadToCloudinary(doc.path);
            if (uploadedUrl != null && uploadedUrl.isNotEmpty) {
              doc.uploadUrl = uploadedUrl;
              doc.isUploaded = true;
              print('Uploaded ${doc.name}: $uploadedUrl');
            }
          } catch (e) {
            print('Failed to upload ${doc.name}: $e');
          }
        })
        .toList();
    
    await Future.wait(uploadFutures);
  }

  // Prepare API payload with EXACT structure for coach hire
  Future<Map<String, dynamic>> _prepareAPIPayload() async {
    return {
      "vendorId": vendorId ?? "68eb757c758ef700653aada8",
      "listingTitle": listingTitleController.text.trim(),
      "service_name": listingTitleController.text.trim(),
      "service_status": selectedServiceStatus.value.toLowerCase(),
      "baseLocation": baseLocationController.text.trim(),
      "basePostcode": baseLocationController.text.trim(), // Required field
      "serviceRadius": int.tryParse(serviceRadiusController.text.trim()) ?? 50,
      "locationRadius": int.tryParse(serviceRadiusController.text.trim()) ?? 50, // Required field
      "fleetInfo": {
        "makeAndModel": makeModelController.text.trim(),
        "numberOfSeats": int.tryParse(numberOfSeatsController.text.trim()) ?? 0,
        "seats": int.tryParse(numberOfSeatsController.text.trim()) ?? 0, // Required field
        "luggageCapacity": totalLuggageCapacity.value, // API expects number, not object
        "luggageCapacityDetails": {
          "largeSuitcases":
              int.tryParse(largeSuitcasesController.text.trim()) ?? 0,
          "mediumSuitcases":
              int.tryParse(mediumSuitcasesController.text.trim()) ?? 0,
          "smallSuitcases":
              int.tryParse(smallSuitcasesController.text.trim()) ?? 0,
          "totalCapacity": totalLuggageCapacity.value,
        },
        "firstRegistered": firstRegistrationDate.value.toIso8601String(),
      },
      "pricingDetails": {
        "dayRate": double.tryParse(dayRateController.text.trim()) ?? 0,
        "fullDayRate": double.tryParse(dayRateController.text.trim()) ?? 0, // Required field
        "hourlyRate": double.tryParse(hourlyRateController.text.trim()) ?? 0,
        "halfDayRate": double.tryParse(halfDayRateController.text.trim()) ?? 0,
        "mileageLimit": mileageLimit,
        "extraMileageCharge":
            double.tryParse(extraMileageChargeController.text.trim()) ?? 0,
        "additionalMileageFee":
            double.tryParse(extraMileageChargeController.text.trim()) ?? 0, // Required field
      },
      "coverageServiceStatus": {
        "serviceCoverageAreas": selectedAreas.toList(),
        "serviceRadius":
            int.tryParse(serviceRadiusController.text.trim()) ?? 50,
        "serviceStatus": selectedServiceStatus.value.toLowerCase(),
      },
      "serviceAvailability": {
        "availableFrom": calendarController.fromDate.value.toIso8601String(),
        "availableTo": calendarController.toDate.value.toIso8601String(),
        "cancellationPolicy": selectedCancellationPolicy.value,
      },
      "cancellation_policy_type": selectedCancellationPolicy.value, // Required field
      "specialPricingCalendar": calendarController.specialPrices
          .map((e) => {
                "date": e['date'] != null
                    ? DateFormat('yyyy-MM-dd').format(e['date'] as DateTime)
                    : "",
                "price": e['price'] as double? ?? 0
              })
          .toList(),
      "featuresServices": {
        "comfortLuxury": comfortLuxuryFeatures,
        "eventsExtras": {
          ...eventsExtrasFeatures,
          "champagnePackagePrice":
              double.tryParse(champagnePackagePriceController.text.trim()) ?? 0,
          "champagneBrand": champagneBrandController.text.trim(),
          "champagneBottles":
              int.tryParse(champagneBottlesController.text.trim()) ?? 1,
          "champagnePackageDetails":
              champagnePackageDetailsController.text.trim(),
          "photographyPackagePrice":
              double.tryParse(photographyPackagePriceController.text.trim()) ??
                  0,
          "photographyDuration": photographyDurationController.text.trim(),
          "photographyTeamSize": photographyTeamSizeController.text.trim(),
          "photographyPackageDetails":
              photographyPackageDetailsController.text.trim(),
          "photographyDeliveryTime":
              photographyDeliveryTimeController.text.trim(),
        },
        "accessibilitySpecialServices": {
          ...accessibilityFeatures,
          "wheelchairAccessPrice":
              double.tryParse(wheelchairAccessPriceController.text.trim()) ?? 0,
          "childCarSeatsPrice":
              double.tryParse(childCarSeatsPriceController.text.trim()) ?? 0,
          "petFriendlyPrice":
              double.tryParse(petFriendlyPriceController.text.trim()) ?? 0,
          "disabledAccessRampPrice":
              double.tryParse(disabledAccessRampPriceController.text.trim()) ??
                  0,
          "seniorAssistancePrice":
              double.tryParse(seniorAssistancePriceController.text.trim()) ?? 0,
          "strollerStoragePrice":
              double.tryParse(strollerStoragePriceController.text.trim()) ?? 0,
        },
        "securityCompliance": securityFeatures,
      },
      "documents": {
        "operatorLicence": {
          "isAttached": operatorLicenceDocs.isNotEmpty,
          "image": operatorLicenceDocs.isNotEmpty
              ? (operatorLicenceDocs.first.uploadUrl ?? '')
              : '',
          "fileName": operatorLicenceDocs.isNotEmpty
              ? operatorLicenceDocs.first.name
              : '',
          "fileType": operatorLicenceDocs.isNotEmpty
              ? 'image/${operatorLicenceDocs.first.type}'
              : '',
          "uploadedAt": DateTime.now().toIso8601String(),
        },
        "publicLiabilityInsurance": {
          "isAttached": publicLiabilityDocs.isNotEmpty,
          "image": publicLiabilityDocs.isNotEmpty
              ? (publicLiabilityDocs.first.uploadUrl ?? '')
              : '',
          "fileName": publicLiabilityDocs.isNotEmpty
              ? publicLiabilityDocs.first.name
              : '',
          "fileType": publicLiabilityDocs.isNotEmpty
              ? 'image/${publicLiabilityDocs.first.type}'
              : '',
          "uploadedAt": DateTime.now().toIso8601String(),
        },
        "driverLicencesAndDBS": {
          "isAttached": driverLicencesDocs.isNotEmpty,
          "image": driverLicencesDocs.isNotEmpty
              ? (driverLicencesDocs.first.uploadUrl ?? '')
              : '',
          "fileName": driverLicencesDocs.isNotEmpty
              ? driverLicencesDocs.first.name
              : '',
          "fileType": driverLicencesDocs.isNotEmpty
              ? 'image/${driverLicencesDocs.first.type}'
              : '',
          "uploadedAt": DateTime.now().toIso8601String(),
        },
        "vehicleMOTAndInsurance": {
          "isAttached": vehicleMOTDocs.isNotEmpty,
          "image": vehicleMOTDocs.isNotEmpty
              ? (vehicleMOTDocs.first.uploadUrl ?? '')
              : '',
          "fileName":
              vehicleMOTDocs.isNotEmpty ? vehicleMOTDocs.first.name : '',
          "fileType": vehicleMOTDocs.isNotEmpty
              ? 'image/${vehicleMOTDocs.first.type}'
              : '',
          "uploadedAt": DateTime.now().toIso8601String(),
        },
      },
      "service_image": serviceImages
          .where((img) => img.isUploaded && img.uploadUrl != null)
          .map((img) => img.uploadUrl!)
          .toList(),
      "coupons": couponController.coupons.isNotEmpty
          ? couponController.coupons
              .where((coupon) =>
                  coupon['coupon_code']?.toString().trim().isNotEmpty == true)
              .map((coupon) => {
                    "coupon_code":
                        coupon['coupon_code']?.toString().trim() ?? '',
                    "discount_type":
                        coupon['discount_type']?.toString().toUpperCase() ??
                            'PERCENTAGE',
                    "discount_value": coupon['discount_value'] ?? 0,
                    "usage_limit": coupon['usage_limit'] ?? 1,
                    "expiry_date": coupon['expiry_date'] != null
                        ? DateFormat('yyyy-MM-dd').format(
                            DateTime.parse(coupon['expiry_date'].toString()))
                        : DateFormat('yyyy-MM-dd').format(
                            DateTime.now().add(const Duration(days: 30))),
                    "is_global": coupon['is_global'] ?? false,
                    "minimum_days": coupon['minimum_days'] ?? 1,
                    "minimum_vehicles": coupon['minimum_vehicles'] ?? 1,
                    "description":
                        coupon['description'] ?? 'General promotional discount',
                  })
              .toList()
          : [],
      "category": "PassengerTransport",
      "sub_category": "Coach Hire",
      "categoryId": categoryId,
      "subcategoryId": subcategoryId,
    };
  }

  void _showSubmissionProgress() {
    Get.dialog(
       WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.btnColor),
              ),
              SizedBox(height: 20),
              Text(
                'Submitting Your Coach Hire Service',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'Please wait while we process your service...',
                style: TextStyle(fontSize: 12, color: AppColors.grey600),
                textAlign: TextAlign.center,
              ),
               SizedBox(height: 16),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _showSubmissionSuccess() {
    Get.snackbar(
      'Success!',
      'Your coach hire service has been submitted successfully! Our team will review it and publish within 24 hours.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.success,
      colorText: AppColors.white,
      icon: const Icon(Icons.check_circle, color: AppColors.white),
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
    HapticFeedback.heavyImpact();
  }

  void _showSubmissionError(String error) {
    Get.snackbar(
      'Submission Failed',
      'Failed to submit your service. Please try again.\nError: $error',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error,
      colorText: AppColors.white,
      icon: const Icon(Icons.error, color: AppColors.white),
      duration: const Duration(seconds: 6),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
    HapticFeedback.heavyImpact();
  }

  // Area management
  void selectAllAreas() {
    selectedAreas.clear();
    selectedAreas
        .addAll(filteredCities.isNotEmpty ? filteredCities : Cities.ukCities);
  }

  void clearAllAreas() {
    selectedAreas.clear();
  }

  void toggleArea(String area) {
    if (selectedAreas.contains(area)) {
      selectedAreas.remove(area);
    } else {
      selectedAreas.add(area);
    }
  }

  // Progress calculation
  double get progressPercentage => currentStep.value / 10;
  String get progressText => '${(progressPercentage * 100).toInt()}% Complete';

  // Step titles
  String getStepTitle(int step) {
    final titles = [
      'Required Documents',
      'Listing Details',
      'Vehicle Information',
      'Pricing Details',
      'Coverage & Service Status',
      'Service Availability',
      'Features & Services',
      'Photos & Media',
      'Coupon Management',
      'Terms & Submit'
    ];
    return titles[step - 1];
  }

  @override
  void onClose() {
    // Dispose controllers
    listingTitleController.dispose();
    partyLightingPriceController.dispose(); 
    baseLocationController.dispose();
    makeModelController.dispose();
    numberOfSeatsController.dispose();
    largeSuitcasesController.dispose();
    mediumSuitcasesController.dispose();
    smallSuitcasesController.dispose();
    dayRateController.dispose();
    hourlyRateController.dispose();
    halfDayRateController.dispose();
    extraMileageChargeController.dispose();
    serviceRadiusController.dispose();
    searchCitiesController.dispose();

    // Event & Extra controllers
    champagnePackagePriceController.dispose();
    champagneBrandController.dispose();
    champagneBottlesController.dispose();
    champagnePackageDetailsController.dispose();
    photographyPackagePriceController.dispose();
    photographyDurationController.dispose();
    photographyTeamSizeController.dispose();
    photographyPackageDetailsController.dispose();
    photographyDeliveryTimeController.dispose();

    // Accessibility controllers
    wheelchairAccessPriceController.dispose();
    childCarSeatsPriceController.dispose();
    petFriendlyPriceController.dispose();
    disabledAccessRampPriceController.dispose();
    seniorAssistancePriceController.dispose();
    strollerStoragePriceController.dispose();

    super.onClose();
  }
}

// Professional Progress Bar Widget
class ProfessionalProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String stepTitle;

  const ProfessionalProgressBar({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.btnColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Coach Hire Form',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey900,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Step $currentStep of $totalSteps: $stepTitle',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.grey600,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${((currentStep / totalSteps) * 100).toInt()}% Complete',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppColors.grey600,
                              ),
                            ),
                            Text(
                              '$currentStep/$totalSteps',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: currentStep / totalSteps,
                            backgroundColor: AppColors.grey200,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.btnColor),
                            minHeight: 6,
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
      ),
    );
  }
}

// Professional Input Widget
class ProfessionalInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool isRequired;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const ProfessionalInput({
    Key? key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.grey900,
              ),
              children: [
                TextSpan(text: label),
                if (isRequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.grey500, fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.grey300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.btnColor, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.grey300),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }
}

// Professional Dropdown Widget
class ProfessionalDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final bool isRequired;

  const ProfessionalDropdown({
    Key? key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.grey900,
              ),
              children: [
                TextSpan(text: label),
                if (isRequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          value: value?.isEmpty == true ? null : value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.grey300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.btnColor, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.grey300),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
          dropdownColor: AppColors.white,
        ),
      ],
    );
  }
}

// Professional Button Widget
class ProfessionalButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final double? width;
  final double height;

  const ProfessionalButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.width,
    this.height = 48,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? AppColors.white : AppColors.btnColor,
          foregroundColor: isOutlined ? AppColors.grey700 : AppColors.white,
          side: BorderSide(
            color: isOutlined ? AppColors.grey400 : AppColors.btnColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}

// Main Coach Hire Service Widget
class CoachHireService extends StatelessWidget {
  final CoachHireController controller = Get.put(CoachHireController());

  final Rxn<String> category;
  final Rxn<String> subCategory;
  final String? categoryId;
  final String? subCategoryId;

  CoachHireService({
    Key? key,
    required this.category,
    required this.subCategory,
    this.categoryId,
    this.subCategoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Update the controller with provided categoryId and subCategoryId
    if (categoryId != null) controller.categoryId = categoryId!;
    if (subCategoryId != null) controller.subcategoryId = subCategoryId!;

    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: Column(
        children: [
          // Progress Header
          Obx(() => ProfessionalProgressBar(
                currentStep: controller.currentStep.value,
                totalSteps: 10,
                stepTitle:
                    controller.getStepTitle(controller.currentStep.value),
              )),

          // Form Content
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.grey300.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Content Area
                  Expanded(
                    child: Obx(() => AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: _buildStepContent(context),
                        )),
                  ),

                  // Navigation Footer
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppColors.grey50,
                      border: Border(top: BorderSide(color: AppColors.grey200)),
                    ),
                    child: Obx(() => _buildNavigationButtons(context)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Row(
      children: [
        if (controller.currentStep.value > 1) ...[
          Expanded(
            child: ProfessionalButton(
              text: 'Previous',
              onPressed: controller.isNavigating.value
                  ? null
                  : controller.previousStep,
              isOutlined: true,
            ),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          flex: 2,
          child: ProfessionalButton(
            text:
                controller.currentStep.value == 10 ? 'Submit Service' : 'Next',
            onPressed:
                controller.isLoading.value || controller.isNavigating.value
                    ? null
                    : () => _handleNextAction(),
            isLoading:
                controller.isLoading.value || controller.isNavigating.value,
          ),
        ),
      ],
    );
  }

  void _handleNextAction() {
    if (controller.currentStep.value == 10) {
      controller.submitForm();
    } else {
      controller.nextStep();
    }
  }

  Widget _buildStepContent(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Form(
        key: controller.formKey,
        child: _getStepWidget(context),
      ),
    );
  }

  Widget _getStepWidget(BuildContext context) {
    switch (controller.currentStep.value) {
      case 1:
        return _buildStep1(context);
      case 2:
        return _buildStep2(context);
      case 3:
        return _buildStep3(context);
      case 4:
        return _buildStep4(context);
      case 5:
        return _buildStep5(context);
      case 6:
        return _buildStep6(context);
      case 7:
        return _buildStep7(context);
      case 8:
        return _buildStep8(context);
      case 9:
        return _buildStep9(context);
      case 10:
        return _buildStep10(context);

      default:
        return _buildStep1(context);
    }
  }

  // Step 1: Required Documents
 Widget _buildStep1(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildStepHeader(context, 'Required Documents', 'Upload required documents to proceed'),
      // Changed to "4 optional"
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.btnColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.btnColor.withOpacity(0.3)),
        ),
        child: const Row(
          children: [
            Icon(Icons.info_outline, color: AppColors.primaryDark, size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('4 optional', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryDark)),
                  SizedBox(height: 4),
                  Text('Additional documents to enhance your service credibility', style: TextStyle(fontSize: 12, color: AppColors.grey700)),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      _buildDocumentUploadSection('Operator Licence', controller.operatorLicenceDocs),
      const SizedBox(height: 20),
      _buildDocumentUploadSection('Public Liability Insurance', controller.publicLiabilityDocs),
      const SizedBox(height: 20),
      _buildDocumentUploadSection('Driver Licences And D B S', controller.driverLicencesDocs),
      const SizedBox(height: 20),
      _buildDocumentUploadSection('Vehicle M O T And Insurance', controller.vehicleMOTDocs),
    ],
  );
}

Widget _buildStep2(BuildContext context) {
  // Add this controller inside the CoachHireController class (with other controllers)
  // final TextEditingController otherTypeController = TextEditingController();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildStepHeader(context, 'Listing Details', 'Create an attractive listing for customers'),
      ProfessionalInput(
        label: 'Listing Title',
        controller: controller.listingTitleController,
        hintText: 'Example: Executive Coach Hire Service',
        isRequired: true,
      ),
      const SizedBox(height: 24),
      const Text('Type of Hire *', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      const SizedBox(height: 8),
      const Text('Help operators plan the right driver and vehicle mix (school trips, corporate hire, events, funerals, etc.)', style: TextStyle(fontSize: 12, color: AppColors.grey600)),
      const SizedBox(height: 16),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: controller.typesOfHire.keys.map((type) {
          return Obx(() {
            final isSelected = controller.typesOfHire[type]!;
            return FilterChip(
              label: Text(type),
              selected: isSelected,
              onSelected: (selected) {
                controller.typesOfHire[type] = selected;
                // If "Other" is deselected, clear the text field
                if (type == 'Other' && !selected) {
                  controller.otherTypeController.clear();
                }
              },
              selectedColor: AppColors.btnColor,
              checkmarkColor: Colors.white,
              backgroundColor: Colors.grey.shade100,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            );
          });
        }).toList(),
      ),
      const SizedBox(height: 20),
      // Show text field only when "Other" is selected
      Obx(() {
        if (controller.typesOfHire['Other'] == true) {
          return ProfessionalInput(
            label: 'Please specify',
            controller: controller.otherTypeController,
            hintText: 'Enter your custom type of hire',
            isRequired: true,
          );
        }
        return const SizedBox.shrink();
      }),
      const SizedBox(height: 24),
      ProfessionalInput(
        label: 'Base Location',
        controller: controller.baseLocationController,
        hintText: 'Enter postcode or address',
        isRequired: true,
      ),
    ],
  );
}

  // Step 3: Vehicle Information
  Widget _buildStep3(BuildContext context) {
    return Column(
      key: const ValueKey('step3'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Vehicle Information',
            'Technical details about your coach'),
        ProfessionalInput(
          label: 'Make & Model',
          controller: controller.makeModelController,
          hintText: 'e.g., Mercedes Sprinter',
          isRequired: true,
          validator: (value) {
            if (value?.trim().isEmpty ?? true)
              return 'Make & Model is required';
            return null;
          },
        ),
        const SizedBox(height: 24),
        ProfessionalInput(
          label: 'Number of Seats',
          controller: controller.numberOfSeatsController,
          hintText: 'Enter Number of Seats',
          keyboardType: TextInputType.number,
          isRequired: true,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            final num = int.tryParse(value ?? '') ?? 0;
            if (num < 1) return 'Must be at least 1';
            if (num > 70) return 'Maximum 70 seats';
            return null;
          },
        ),
        const SizedBox(height: 24),
        const Text(
          'Luggage Capacity *',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.grey900),
        ),
        const SizedBox(height: 16),
        ProfessionalInput(
          label: 'Large Suitcases',
          controller: controller.largeSuitcasesController,
          hintText: '0',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 16),
        ProfessionalInput(
          label: 'Medium Suitcases',
          controller: controller.mediumSuitcasesController,
          hintText: '0',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 16),
        ProfessionalInput(
          label: 'Small Suitcases',
          controller: controller.smallSuitcasesController,
          hintText: '0',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 16),
        Obx(() => Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.grey100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.grey300),
              ),
              child: Text(
                'Total luggage capacity: ${controller.totalLuggageCapacity.value} suitcases',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            )),
        const SizedBox(height: 24),
        _buildDateField(
            context, 'First Registered', controller.firstRegistrationDate, allowFutureDates: false),
      ],
    );
  }

  // Step 4: Pricing Details
  Widget _buildStep4(BuildContext context) {
    return Column(
      key: const ValueKey('step4'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Pricing Details',
            'Set competitive rates for your service'),
        ProfessionalInput(
          label: 'Day Rate (£)',
          controller: controller.dayRateController,
          hintText: 'Enter day rate',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          isRequired: true,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
          ],
          validator: (value) {
            if (value?.trim().isEmpty ?? true) return 'Day Rate is required';
            return null;
          },
        ),
        const SizedBox(height: 20),
        ProfessionalInput(
          label: 'Hourly Rate (£)',
          controller: controller.hourlyRateController,
          hintText: 'Enter hourly rate',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          isRequired: true,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
          ],
          validator: (value) {
            if (value?.trim().isEmpty ?? true) return 'Hourly Rate is required';
            return null;
          },
        ),
        const SizedBox(height: 20),
        ProfessionalInput(
          label: 'Half Day Rate (£)',
          controller: controller.halfDayRateController,
          hintText: 'Enter half day rate',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          isRequired: true,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
          ],
          validator: (value) {
            if (value?.trim().isEmpty ?? true)
              return 'Half Day Rate is required';
            return null;
          },
        ),
        const SizedBox(height: 20),
        const Text(
          'Mileage Limit *',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.grey900),
        ),
        const Text(
          'miles (Fixed at 200)',
          style: TextStyle(fontSize: 12, color: AppColors.grey600),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.grey100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.grey300),
          ),
          child: Text(
            '${controller.mileageLimit} miles',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 20),
        ProfessionalInput(
          label: 'Extra Mileage Charge (£/mile)',
          controller: controller.extraMileageChargeController,
          hintText: 'Enter extra mileage charge per mile',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          isRequired: true,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
          ],
          validator: (value) {
            if (value?.trim().isEmpty ?? true)
              return 'Extra Mileage Charge is required';
            return null;
          },
        ),
      ],
    );
  }

  // Step 5: Coverage & Service Status
  Widget _buildStep5(BuildContext context) {
    return Column(
      key: const ValueKey('step5'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Coverage & Service Status',
            'Define your service area and operational range'),
        ProfessionalInput(
          label: 'Service Coverage Areas',
          controller: controller.baseLocationController,
          hintText: 'Enter Service Coverage Areas',
          isRequired: true,
          validator: (value) {
            if (value?.trim().isEmpty ?? true)
              return 'Service Coverage Areas is required';
            return null;
          },
        ),
        const SizedBox(height: 10),
        const Text(
          'Service Radius (miles)',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const Text(
          'How far from your base location are you willing to travel? (Range: 1-500 miles)',
          style: TextStyle(fontSize: 12, color: AppColors.grey600),
        ),
        const SizedBox(height: 10),
        ProfessionalInput(
          label: '',
          controller: controller.serviceRadiusController,
          hintText: 'Enter service radius',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 24),
        _buildAreasSelection(context),
        const SizedBox(height: 24),
        const Text(
          'Service Status *',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.grey900),
        ),
        const Text(
          'Set to "Open" to accept new bookings, or "Closed" to temporarily stop accepting bookings.',
          style: TextStyle(fontSize: 12, color: AppColors.grey600),
        ),
        const SizedBox(height: 10),
        ProfessionalDropdown(
          label: '',
          value: controller.selectedServiceStatus.value.capitalizeFirst,
          items: ['Open', 'Closed'],
          onChanged: (value) => controller.selectedServiceStatus.value =
              value?.toLowerCase() ?? 'Open',
          isRequired: true,
        ),
      ],
    );
  }

  // Step 6: Service Availability with Calendar
  Widget _buildStep6(BuildContext context) {
    return Column(
      key: const ValueKey('step6'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(
            context, 'Service Availability', 'Set your availability periods'),
        _buildDateField(
            context, 'Available From', controller.calendarController.fromDate),
        const SizedBox(height: 16),
        _buildDateField(
            context, 'Available To', controller.calendarController.toDate),
        const SizedBox(height: 24),
        ProfessionalDropdown(
          label: 'Cancellation Policy',
          value: controller.cancellationPolicyMap[
              controller.selectedCancellationPolicy.value],
          items: controller.cancellationPolicyMap.values.toList(),
          onChanged: (value) {
            if (value != null) {
              // Find the key for the selected descriptive value
              final policy = controller.cancellationPolicyMap.entries
                  .firstWhere((entry) => entry.value == value)
                  .key;
              controller.selectedCancellationPolicy.value = policy;
            }
          },
          isRequired: true,
        ),
        const SizedBox(height: 24),

        const Text('Special Pricing Calendar', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 14),
        const Text('Set special prices for specific dates (holidays, peak seasons, events). These will override your standard rates.'),

        const SizedBox(height: 16),
        Obx(() {
          DateTime focusedDay = controller.calendarController.fromDate.value;
          DateTime availableFromDate = controller.calendarController.fromDate.value;
          DateTime availableToDate = controller.calendarController.toDate.value;
          
          // Ensure focused day is within the available range or at least today
          if (focusedDay.isBefore(DateTime.now())) {
            focusedDay = DateTime.now();
          }
          if (availableFromDate.isBefore(DateTime.now())) {
            availableFromDate = DateTime.now();
          }
          if (availableToDate.isBefore(availableFromDate)) {
            availableToDate = availableFromDate.add(const Duration(days: 365));
          }
          
          return TableCalendar(
            onDaySelected: (selectedDay, focusedDay) {
              // Check if the selected day is within the available date range and calendar's visible dates
              bool isWithinAvailableRange = (selectedDay.isAtSameMomentAs(availableFromDate) ||
                  selectedDay.isAtSameMomentAs(availableToDate) ||
                  (selectedDay.isAfter(availableFromDate) && selectedDay.isBefore(availableToDate)));
              
              bool isInVisibleDates = controller.calendarController.visibleDates
                  .any((d) => isSameDay(d, selectedDay));
                  
              if (isWithinAvailableRange && isInVisibleDates) {
                controller._showSetPriceDialog(selectedDay);
              }
            },
            focusedDay: focusedDay,
            firstDay: availableFromDate,
            lastDay: availableToDate,
            calendarFormat: CalendarFormat.month,
            availableGestures: AvailableGestures.none,
            headerStyle: const HeaderStyle(formatButtonVisible: false),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                // Check if day is within the available date range (inclusive)
                bool isWithinRange = (day.isAtSameMomentAs(availableFromDate) ||
                    day.isAtSameMomentAs(availableToDate) ||
                    (day.isAfter(availableFromDate) && day.isBefore(availableToDate)));
                
                // Check if day is in calendar controller's visible dates
                bool isInVisibleDates = controller.calendarController.visibleDates
                    .any((d) => isSameDay(d, day));
                
                if (isWithinRange && isInVisibleDates) {
                  return controller._buildCalendarCell(day, true);
                }
                return controller._buildCalendarCell(day, false);
              },
            ),
          );
        }),
        const SizedBox(height: 20),
        const Text('Special Prices Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: controller.calendarController.specialPrices.length == 0
              ? const Center(
                  child: Text('No special prices set yet',
                      style: TextStyle(fontSize: 16, color: Colors.black)))
              : Obx(() => ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        controller.calendarController.specialPrices.length,
                    itemBuilder: (context, index) {
                      final entry =
                          controller.calendarController.specialPrices[index];
                      final date = entry['date'] as DateTime;
                      final price = entry['price'] as double;
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.grey200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(DateFormat('EEE, d MMM yyyy').format(date),
                                style: const TextStyle(fontSize: 16)),
                            Row(
                              children: [
                                Text('£${price.toStringAsFixed(2)}/day',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: price > 0
                                            ? Colors.black
                                            : Colors.red)),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => controller.calendarController
                                      .deleteSpecialPrice(date),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )),
        ),
      ],
    );
  }

  // Step 7: Features & Services
 Widget _buildStep7(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildStepHeader(context, 'Events & Extras', 'Add premium extras to enhance your service'),
      // Party Lighting System
      Obx(() => Column(
            children: [
              CheckboxListTile(
                title: const Text('Party Lighting System', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                subtitle: const Text('Extra charge (£) - optional', style: TextStyle(fontSize: 12, color: AppColors.grey600)),
                value: controller.eventsExtrasFeatures['partyLightingSystem'],
                onChanged: (value) => controller.eventsExtrasFeatures['partyLightingSystem'] = value ?? false,
              ),
              if (controller.eventsExtrasFeatures['partyLightingSystem'] == true)
                ProfessionalInput(label: '', controller: controller.partyLightingPriceController, hintText: 'Enter price (£)'),
            ],
          )),
      const SizedBox(height: 20),
      // Champagne Packages
      Obx(() => Column(
            children: [
              CheckboxListTile(
                title: const Text('Champagne Packages', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                subtitle: const Text('Extra charge (£) - optional', style: TextStyle(fontSize: 12, color: AppColors.grey600)),
                value: controller.eventsExtrasFeatures['champagnePackages'],
                onChanged: (value) => controller.eventsExtrasFeatures['champagnePackages'] = value ?? false,
              ),
              if (controller.eventsExtrasFeatures['champagnePackages'] == true) ...[
                ProfessionalInput(label: '', controller: controller.champagnePackagePriceController, hintText: 'Price (£)'),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Champagne Package Details', style: TextStyle(fontWeight: FontWeight.w600)),
                      ProfessionalInput(label: 'Champagne Brand', controller: controller.champagneBrandController, hintText: 'e.g., Moët & Chandon'),
                      ProfessionalInput(label: 'Number of Bottles', controller: controller.champagneBottlesController, hintText: '1'),
                      TextField(
                        controller: controller.champagnePackageDetailsController,
                        maxLines: 3,
                        decoration: const InputDecoration(hintText: 'e.g., Chilled champagne, crystal flutes, ice bucket, napkins, toast service'),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          )),
      const SizedBox(height: 20),
      // Photography Packages
      Obx(() => Column(
            children: [
              CheckboxListTile(
                title: const Text('Photography Packages', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                subtitle: const Text('Extra charge (£) - optional', style: TextStyle(fontSize: 12, color: AppColors.grey600)),
                value: controller.eventsExtrasFeatures['photographyPackages'],
                onChanged: (value) => controller.eventsExtrasFeatures['photographyPackages'] = value ?? false,
              ),
              if (controller.eventsExtrasFeatures['photographyPackages'] == true) ...[
                ProfessionalInput(label: '', controller: controller.photographyPackagePriceController, hintText: 'Price (£)'),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Photography Package Details', style: TextStyle(fontWeight: FontWeight.w600)),
                      Row(
                        children: [
                          Expanded(child: ProfessionalInput(label: 'Package Duration *', controller: controller.photographyDurationController, hintText: 'e.g., 2 hours')),
                          const SizedBox(width: 10),
                          Expanded(child: ProfessionalInput(label: 'Number of Photographers', controller: controller.photographyTeamSizeController, hintText: 'e.g., 2')),
                        ],
                      ),
                      TextField(
                        controller: controller.photographyPackageDetailsController,
                        maxLines: 3,
                        decoration: const InputDecoration(hintText: 'e.g., Professional photographer, edited photos, online gallery, USB drive, 2-hour coverage'),
                      ),
                      ProfessionalInput(label: 'Delivery Timeline', controller: controller.photographyDeliveryTimeController, hintText: 'e.g., 7-10 days'),
                    ],
                  ),
                ),
              ],
            ],
          )),
    ],
  );
}
  // Step 8: Photos & Media
  Widget _buildStep8(BuildContext context) {
    return Column(
      key: const ValueKey('step8'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Photos & Media',
            'Upload high-quality images of your coach'),

        const Text(
          'Service Images * (Minimum 3 images required)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.grey900,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Upload high-quality images of your vehicle. Show exterior, interior, and key features.',
          style: TextStyle(fontSize: 12, color: AppColors.grey600),
        ),
        const SizedBox(height: 16),

        GestureDetector(
          onTap: () => controller.pickDocument(controller.serviceImages),
          child: DottedBorder(
            color: AppColors.grey400,
            strokeWidth: 1.5,
            dashPattern: const [8, 4],
            borderType: BorderType.RRect,
            radius: const Radius.circular(8),
            child: Container(
              height: 180,
              width: double.infinity,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_outlined,
                      size: 40, color: AppColors.grey500),
                  SizedBox(height: 16),
                  Text(
                    'Upload Service Images',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey700,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Click to upload or drag and drop',
                    style: TextStyle(fontSize: 12, color: AppColors.grey500),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'JPG, PNG up to 5MB each • Minimum 3 images required',
                    style: TextStyle(fontSize: 10, color: AppColors.grey400),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Display selected images
        Obx(() => controller.serviceImages.isNotEmpty
            ? _buildSelectedImagesGrid(context)
            : const SizedBox()),
      ],
    );
  }

  // Step 9: Coupon Management
  Widget _buildStep9(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Column(
      key: const ValueKey('step9'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Coupon Management',
            'Create promotional coupons for your service'),
        SizedBox(
          width: w * 0.45,
          height: 50,
          child: ElevatedButton(
            onPressed: () => Get.dialog(AddCouponDialog()),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child:
                const Text("Add Coupon", style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 20),
        Obx(() => controller.couponController.coupons.isEmpty
            ? const SizedBox.shrink()
            : CouponList()),
        const SizedBox(height: 20),
      ],
    );
  }

  // Step 10: Terms & Submit
  Widget _buildStep10(BuildContext context) {
    return Column(
      key: const ValueKey('step10'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Declaration & Agreement',
            'Review and accept terms to complete your listing'),
        const Text(
          'Please review and accept the following terms and conditions to complete your service listing.',
          style: TextStyle(fontSize: 14, color: AppColors.grey600, height: 1.4),
        ),
        const SizedBox(height: 24),
        Obx(() => Column(
              children: [
                _buildTermsCheckbox(
                  context,
                  'I confirm that all information provided is accurate and current.',
                  controller.isAccurateInfo,
                  (value) => controller.isAccurateInfo.value = value ?? false,
                ),
                _buildTermsCheckbox(
                  context,
                  'I have not shared any contact details (Email, Phone, Skype, Website etc.)',
                  controller.noContactDetailsShared,
                  (value) =>
                      controller.noContactDetailsShared.value = value ?? false,
                ),
                _buildTermsCheckboxWithLink(
                  context,
                  'I agree to the Cookies Policy',
                  controller.agreeCookiesPolicy,
                  (value) =>
                      controller.agreeCookiesPolicy.value = value ?? false,
                  'https://stage1.hireanything.com/Cookies_Policy_Hire_Anything_Corrected.pdf',
                ),
                _buildTermsCheckboxWithLink(
                  context,
                  'I agree to the Privacy Policy',
                  controller.agreePrivacyPolicy,
                  (value) =>
                      controller.agreePrivacyPolicy.value = value ?? false,
                  'https://stage1.hireanything.com/HireAnything_Privacy_Policy_Corrected.pdf',
                ),
                _buildTermsCheckboxWithLink(
                  context,
                  'I agree to the Cancellation Fee Policy',
                  controller.agreeCancellationPolicy,
                  (value) =>
                      controller.agreeCancellationPolicy.value = value ?? false,
                  'https://stage1.hireanything.com/cancellation-fee-policy',
                ),
              ],
            )),
        const SizedBox(height: 20),
        Text(
            'Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}'),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.btnColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.btnColor.withOpacity(0.2)),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.primaryDark, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ready to Submit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Once you submit your service, it will be reviewed by our team and published within 24 hours.',
                      style: TextStyle(
                          fontSize: 12, color: AppColors.grey700, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper Widgets
  Widget _buildStepHeader(BuildContext context, String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.grey900),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 14, color: AppColors.grey600),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDocumentUploadSection(
      String title, RxList<DocumentFile> documents,
      {bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.grey900),
            children: [
              TextSpan(text: title),
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                      color: AppColors.error, fontWeight: FontWeight.w600),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Accepted formats: JPG, PNG, PDF | Max 5MB',
          style: TextStyle(fontSize: 12, color: AppColors.grey600),
        ),
        const SizedBox(height: 12),
        Obx(() => documents.isNotEmpty
            ? Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: documents.asMap().entries.map((entry) {
                  final index = entry.key;
                  final doc = entry.value;
                  return _buildDocumentChip(
                      doc, () => controller.removeDocument(documents, index));
                }).toList(),
              )
            : const SizedBox()),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => controller.pickDocument(documents),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                  color: AppColors.grey300, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(8),
              color: AppColors.grey50,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cloud_upload_outlined, color: AppColors.grey500),
                SizedBox(width: 8),
                Text(
                  'Click to upload document',
                  style: TextStyle(fontSize: 14, color: AppColors.grey700),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentChip(DocumentFile doc, VoidCallback onRemove) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: doc.isValidSize
            ? AppColors.success.withOpacity(0.1)
            : AppColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: doc.isValidSize
              ? AppColors.success.withOpacity(0.3)
              : AppColors.error.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getFileIcon(doc.type),
            size: 16,
            color: doc.isValidSize ? AppColors.success : AppColors.error,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                doc.name.length > 20
                    ? '${doc.name.substring(0, 20)}...'
                    : doc.name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: doc.isValidSize ? AppColors.success : AppColors.error,
                ),
              ),
              Text(
                doc.displaySize,
                style: TextStyle(
                  fontSize: 10,
                  color: doc.isValidSize ? AppColors.grey600 : AppColors.error,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, size: 16, color: AppColors.error),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(
      BuildContext context, String label, Rx<DateTime> date, {bool allowFutureDates = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.grey900),
            children: [
              TextSpan(text: '$label *'),
              if (label == 'Available To')
                const TextSpan(
                  text: '\nMust be after the start date',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grey600,
                      fontWeight: FontWeight.normal),
                ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () async {
            final DateTime today = DateTime.now();
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: allowFutureDates ? date.value : (date.value.isAfter(today) ? today : date.value),
              firstDate: allowFutureDates 
                  ? (label == 'Available From' 
                      ? DateTime.now() 
                      : controller.calendarController.fromDate.value)
                  : DateTime(1950),
              lastDate: allowFutureDates ? DateTime(2099, 12, 31) : today,
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: AppColors.btnColor,
                      onPrimary: AppColors.white,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              if (label == 'Available From') {
                if (picked.isBefore(DateTime.now())) {
                  Get.snackbar(
                    "Invalid Date",
                    "Please select a date in the future.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                  return;
                }
              }
              if (label == 'Available To') {
                if (picked
                    .isBefore(controller.calendarController.fromDate.value)) {
                  Get.snackbar(
                    "Invalid Date",
                    "End date must be after start date.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                  return;
                }
              }
              date.value = picked;
              controller.calendarController.updateDateRange(
                controller.calendarController.fromDate.value,
                controller.calendarController.toDate.value,
              );
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey300),
              borderRadius: BorderRadius.circular(8),
              color: AppColors.white,
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today,
                    color: AppColors.btnColor, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(() => Text(
                        DateFormat('dd/MM/yyyy').format(date.value),
                        style: const TextStyle(
                            fontSize: 14, color: AppColors.grey900),
                      )),
                ),
                const Icon(Icons.keyboard_arrow_down,
                    color: AppColors.grey500, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedImagesGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected Images (${controller.serviceImages.length})',
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.grey900),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.serviceImages.length,
            itemBuilder: (context, index) {
              final doc = controller.serviceImages[index];
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.grey300),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: doc.type == 'pdf'
                          ? Container(
                              width: 100,
                              height: 100,
                              color: AppColors.grey200,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.picture_as_pdf,
                                      color: AppColors.error, size: 24),
                                  Text('PDF',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.grey700)),
                                ],
                              ),
                            )
                          : Image.file(
                              File(doc.path),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => controller.removeDocument(
                            controller.serviceImages, index),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close,
                              color: AppColors.white, size: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAreasSelection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Areas Covered *',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.grey900),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ProfessionalButton(
                text: 'Select All',
                onPressed: controller.selectAllAreas,
                isOutlined: true,
                height: 36,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ProfessionalButton(
                text: 'Clear All',
                onPressed: controller.clearAllAreas,
                isOutlined: true,
                height: 36,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ProfessionalInput(
          label: 'Search Cities',
          controller: controller.searchCitiesController,
          hintText: 'Search by post code or city name...',
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey300),
            borderRadius: BorderRadius.circular(8),
            color: AppColors.white,
          ),
          child: Obx(() => ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: controller.filteredCities.length,
                itemBuilder: (context, index) {
                  final city = controller.filteredCities[index];
                  return _buildCityCheckbox(context, city);
                },
              )),
        ),
        const SizedBox(height: 16),
        Obx(() => controller.selectedAreas.isNotEmpty
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.grey200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected ${controller.selectedAreas.length} areas: ${controller.selectedAreas.take(3).join(', ')}${controller.selectedAreas.length > 3 ? ' +${controller.selectedAreas.length - 3} more' : ''}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            : const Text('No cities selected',
                style: TextStyle(color: AppColors.grey600, fontSize: 16))),
      ],
    );
  }

  Widget _buildAccessibilityFeature(
      String title, String key, TextEditingController priceController) {
    return Column(
      children: [
        Obx(() => CheckboxListTile(
              title: Text(title),
              value: controller.accessibilityFeatures[key] ?? false,
              onChanged: (value) =>
                  controller.accessibilityFeatures[key] = value ?? false,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: AppColors.btnColor,
              contentPadding: EdgeInsets.zero,
              dense: true,
            )),
        Obx(() => controller.accessibilityFeatures[key] == true
            ? Column(
                children: [
                  const SizedBox(height: 8),
                  ProfessionalInput(
                    label: '$title Price (£)',
                    controller: priceController,
                    hintText: 'Enter additional price',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                  const SizedBox(height: 16),
                ],
              )
            : const SizedBox()),
      ],
    );
  }

  String _getAccessibilityFeatureDisplayName(String feature) {
    switch (feature) {
      case 'wheelchairAccessVehicle':
        return 'Wheelchair Access Vehicle';
      case 'childCarSeats':
        return 'Child Car Seats';
      case 'petFriendlyService':
        return 'Pet Friendly Service';
      case 'disabledAccessRamp':
        return 'Disabled Access Ramp';
      case 'seniorFriendlyAssistance':
        return 'Senior Friendly Assistance';
      case 'strollerBuggyStorage':
        return 'Stroller/Buggy Storage';
      default:
        return feature; // Fallback to original if not found
    }
  }

  TextEditingController _getAccessibilityPriceController(String feature) {
    switch (feature) {
      case 'wheelchairAccessVehicle':
        return controller.wheelchairAccessPriceController;
      case 'childCarSeats':
        return controller.childCarSeatsPriceController;
      case 'petFriendlyService':
        return controller.petFriendlyPriceController;
      case 'disabledAccessRamp':
        return controller.disabledAccessRampPriceController;
      case 'seniorFriendlyAssistance':
        return controller.seniorAssistancePriceController;
      case 'strollerBuggyStorage':
        return controller.strollerStoragePriceController;
      default:
        return TextEditingController();
    }
  }

  Widget _buildCityCheckbox(BuildContext context, String city) {
    return Obx(() => Container(
          margin: const EdgeInsets.only(bottom: 2),
          child: CheckboxListTile(
            title: Text(
              city,
              style: TextStyle(
                fontSize: 13,
                color: controller.selectedAreas.contains(city)
                    ? AppColors.primaryDark
                    : AppColors.grey900,
                fontWeight: controller.selectedAreas.contains(city)
                    ? FontWeight.w500
                    : FontWeight.w400,
              ),
            ),
            value: controller.selectedAreas.contains(city),
            onChanged: (value) => controller.toggleArea(city),
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            activeColor: AppColors.btnColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          ),
        ));
  }

// Helper method to get file icon based on file type
  IconData _getFileIcon(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      default:
        return Icons.description;
    }
  }

  Widget _buildFeatureCheckbox(
      String title, RxMap<String, dynamic> features, String key) {
    return Obx(() => CheckboxListTile(
          title: Text(title),
          value: features[key] ?? false,
          onChanged: (value) => features[key] = value ?? false,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: AppColors.btnColor,
          contentPadding: EdgeInsets.zero,
          dense: true,
        ));
  }

  Widget _buildTermsCheckbox(BuildContext context, String title, RxBool value,
      Function(bool?) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CheckboxListTile(
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 13, color: AppColors.grey900, height: 1.3),
        ),
        value: value.value,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
        activeColor: AppColors.btnColor,
        dense: true,
      ),
    );
  }

  Widget _buildTermsCheckboxWithLink(BuildContext context, String title, RxBool value, 
      Function(bool?) onChanged, String url) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Checkbox(
            value: value.value,
            onChanged: onChanged,
            activeColor: AppColors.btnColor,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => _launchURL(url),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: title,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.btnColor,
                        height: 1.3,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
