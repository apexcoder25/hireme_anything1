import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/image_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupanController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/calenderController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupon_list.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupondialog.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/controller/add_vendor_services_controller.dart';
import 'package:hire_any_thing/constants_file/uk_cities.dart';
import 'package:hire_any_thing/res/routes/routes.dart';
import 'package:hire_any_thing/utilities/colors.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/service_controller.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

// Document Model - Same as boat hire
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

// Limousine Hire Controller with exact fields as required
class LimousineHireController extends GetxController {
  // Observable states
  var currentStep = 1.obs;
  var isLoading = false.obs;
  var isNavigating = false.obs;
  var isSubmitting = false.obs;
  var completedSteps = <int>{}.obs;

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text controllers - Limousine specific fields
  final TextEditingController listingTitleController = TextEditingController();
  final TextEditingController baseLocationController = TextEditingController();
  final TextEditingController numberOfLimousinesController =
      TextEditingController();
  final TextEditingController makeModelController = TextEditingController();
  final TextEditingController numberOfSeatsController = TextEditingController();
  final TextEditingController luggageCapacityController =
      TextEditingController();
  final TextEditingController serviceRadiusController = TextEditingController();
  final TextEditingController searchCitiesController = TextEditingController();
  final TextEditingController otherFeatureController = TextEditingController();

  // Pricing Controllers
  final TextEditingController hourlyRateController = TextEditingController();
  final TextEditingController halfDayRateController = TextEditingController();
  final TextEditingController fullDayRateController = TextEditingController();
  final TextEditingController weddingPackageRateController =
      TextEditingController();
  final TextEditingController airportTransferRateController =
      TextEditingController();
  final TextEditingController depositRequiredController =
      TextEditingController();

  // Service Description
  final TextEditingController serviceHighlightsController =
      TextEditingController();
  final TextEditingController serviceDescriptionController =
      TextEditingController();
  final TextEditingController promotionalVideoController =
      TextEditingController();

  // Observable selections - Limousine specific
  var selectedFleetType = 'Standard Limousine'.obs;
  var selectedServiceStatus = 'Open - Available for bookings'.obs;
  var selectedCancellationPolicy =
      'Flexible'.obs;
  var firstRegistrationDate = DateTime.now().obs;
  var wheelchairAccessibleVehicles = 0.obs;

  // Operating hours
  var operates24Hours = false.obs;
  var openingTime = const TimeOfDay(hour: 9, minute: 0).obs;
  var closingTime = const TimeOfDay(hour: 17, minute: 0).obs;

  // Pricing options
  var fuelIncluded = false.obs;
  var mileageLimitsApplicable = false.obs;

  // Category IDs - Update these with actual limousine category IDs
  String categoryId =
      "676ac544234968d45b494992"; // Update with actual limousine category ID
  String subcategoryId =
      "676ace13234968d45b4949db"; // Update with actual limousine subcategory ID

  // Document storage for API
  RxList<DocumentFile> insuranceCertificateDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> operatorLicenceDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> v5cDocumentDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> vehicleMOTDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> driverLicenceDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> serviceImages = <DocumentFile>[].obs;

  // Areas management
  RxList<String> selectedAreas = <String>[].obs;
  RxList<String> filteredCities = <String>[].obs;

  // Fleet Features
  var fleetFeatures = {
    'onboardBar': false,
    'partyLighting': false,
    'wifi': false,
    'tvScreen': false,
    'bluetoothMusic': false,
    'privacyDivider': false,
    'usbCharging': false,
    'wheelchairAccess': false,
    'other': false,
  }.obs;

  // Occasions covered
  var occasionsCovered = {
    'weddings': false,
    'proms': false,
    'airportTransfers': false,
    'vipBusiness': false,
    'nightOutParty': false,
    'birthday': false,
    'henStag': false,
    'other': false,
  }.obs;

  // Booking options
  var bookingOptions = {
    'hourlyHire': false,
    'fullDayHire': false,
    'oneWayTransfers': false,
    'returnJourney': false,
    'packages': false,
  }.obs;

  // Available days
  var availableDays = {
    'monday': false,
    'tuesday': false,
    'wednesday': false,
    'thursday': false,
    'friday': false,
    'saturday': false,
    'sunday': false,
  }.obs;

  // Terms
  var isAccurateInfo = false.obs;
  var noContactDetailsShared = false.obs;
  var agreeCookiesPolicy = false.obs;
  var agreePrivacyPolicy = false.obs;
  var agreeCancellationPolicy = false.obs;

  // Static data
  final List<String> fleetTypes = [
    'Standard Limousine',
    'Stretch Limousine',
    'SUV Limousine',
    'Other'
  ];

  final List<String> serviceStatusOptions = [
    'Open - Available for bookings',
    'Closed - Not accepting bookings'
  ];

  final List<String> cancellationPolicyOptions = [
    'Flexible',
    'Moderate',
    'Strict',
    'Super Strict'
  ];

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
            DateTime.now().add(const Duration(days: 365));
      }
    });
  }

  void _setupListeners() {
    searchCitiesController.addListener(_filterCities);
    hourlyRateController.addListener(() {
      calendarController
          .setDefaultPrice(double.tryParse(hourlyRateController.text) ?? 0.0);
    });
    
    // Listen to calendar date changes to ensure calendar updates properly
    calendarController.fromDate.listen((newDate) {
      // Clear special prices that are outside the new date range
      calendarController.specialPrices.removeWhere((price) {
        final priceDate = price['date'] as DateTime;
        return priceDate.isBefore(newDate) || priceDate.isAfter(calendarController.toDate.value);
      });
    });
    
    calendarController.toDate.listen((newDate) {
      // Clear special prices that are outside the new date range
      calendarController.specialPrices.removeWhere((price) {
        final priceDate = price['date'] as DateTime;
        return priceDate.isBefore(calendarController.fromDate.value) || priceDate.isAfter(newDate);
      });
    });
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
        return await _validateStep1(); // Documents
      case 2:
        return await _validateStep2(); // Listing Details
      case 3:
        return await _validateStep3(); // Vehicle Information
      case 4:
        return await _validateStep4(); // Pricing Details
      case 5:
        return await _validateStep5(); // Coverage & Service Status
      case 6:
        return await _validateStep6(); // Service Availability
      case 7:
        return await _validateStep7(); // Features & Services
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

  Future<bool> _validateStep1() async {
    if (insuranceCertificateDocs.isEmpty) {
      _showError('Insurance Certificate is required');
      return false;
    }
    if (operatorLicenceDocs.isEmpty) {
      _showError('Operator Licence is required');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep2() async {
    if (listingTitleController.text.trim().isEmpty) {
      _showError('Please enter a listing title');
      return false;
    }
    if (baseLocationController.text.trim().isEmpty) {
      _showError('Please enter base location');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep3() async {
    if (numberOfLimousinesController.text.trim().isEmpty ||
        makeModelController.text.trim().isEmpty ||
        numberOfSeatsController.text.trim().isEmpty ||
        luggageCapacityController.text.trim().isEmpty) {
      _showError('All vehicle information fields are required');
      return false;
    }

    final limousines =
        int.tryParse(numberOfLimousinesController.text.trim()) ?? 0;
    if (limousines < 1) {
      _showError('Number of limousines must be at least 1');
      return false;
    }

    final seats = int.tryParse(numberOfSeatsController.text.trim()) ?? 0;
    if (seats < 1 || seats > 50) {
      _showError('Number of seats must be between 1 and 50');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep4() async {
    final hourlyRate = double.tryParse(hourlyRateController.text.trim()) ?? 0;
    final halfDayRate = double.tryParse(halfDayRateController.text.trim()) ?? 0;
    final fullDayRate = double.tryParse(fullDayRateController.text.trim()) ?? 0;

    if (hourlyRate == 0 && halfDayRate == 0 && fullDayRate == 0) {
      _showError('At least one pricing field is required');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep5() async {
    if (selectedAreas.isEmpty) {
      _showError('Please select at least one service area');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep6() async {
    return true; // Service availability is handled by calendar
  }

  Future<bool> _validateStep7() async {
    if (serviceHighlightsController.text.trim().isEmpty) {
      _showError('Service highlights are required');
      return false;
    }
    if (serviceDescriptionController.text.trim().isEmpty) {
      _showError('Service description is required');
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
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Price per Day (£)',
                hintText: 'Enter special price',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
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
            child: const Text('Set Price'),
          ),
        ],
      ),
    );
  }

  // Calendar cell builder method
  Widget _buildCalendarCell(BuildContext context, DateTime day, bool isVisible) {
    final specialPrice = calendarController.specialPrices
        .where((entry) => DateFormat('yyyy-MM-dd').format(entry['date'] as DateTime) == DateFormat('yyyy-MM-dd').format(day))
        .map((entry) => entry['price'] as double?)
        .firstOrNull;
    
    return Container(
      margin: const EdgeInsets.all(2),  
      padding: const EdgeInsets.all(3),
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
          Text(
            '${day.day}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isVisible ? Colors.black : Colors.grey,
            ),
          ),
          if (specialPrice != null)
            Text(
              '£${specialPrice.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 8,
                color: Colors.green.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  // Calendar cell builder - removed duplicate, using the one at bottom of file

  // Form submission with API payload structure
  Future<void> submitForm() async {
    if (!await _validateStep10()) return;

    isSubmitting.value = true;
    try {
      _showSubmissionProgress();
      
      try {
        // Upload all documents first
        await _uploadAllDocuments();

        // Prepare API data
        final formData = await _prepareAPIPayload();

        // Submit to API
        final api = AddVendorServiceApi();
        final isAdded = await api.addServiceVendor(formData, 'limousine');

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
    await _uploadDocumentList(insuranceCertificateDocs);
    await _uploadDocumentList(operatorLicenceDocs);
    await _uploadDocumentList(v5cDocumentDocs);
    await _uploadDocumentList(vehicleMOTDocs);
    await _uploadDocumentList(driverLicenceDocs);
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

  // Helper method to convert cancellation policy to enum value
  String _getCancellationPolicyEnum(String policy) {
    switch (policy) {
      case 'Flexible':
        return 'FLEXIBLE';
      case 'Moderate':
        return 'MODERATE';
      case 'Strict':
        return 'STRICT';
      case 'Super Strict':
        return 'SUPER_STRICT';
      default:
        return 'FLEXIBLE';
    }
  }

  // Helper method to convert fleet features to valid enum values
  String? _getFleetFeatureEnum(String featureKey) {
    switch (featureKey) {
      case 'onboardBar':
        return 'minibar';
      case 'partyLighting':
        return 'mood_lighting';
      case 'wifi':
        return 'wifi';
      case 'tvScreen':
        return 'entertainment_system';
      case 'bluetoothMusic':
        return 'sound_system';
      case 'privacyDivider':
        return 'privacy_glass';
      case 'usbCharging':
        return 'charging_ports';
      case 'wheelchairAccess':
        return 'wheelchair_accessible';
      default:
        return null;
    }
  }

  // Helper method to convert occasions to valid enum values
  String? _getOccasionEnum(String occasionKey) {
    switch (occasionKey) {
      case 'weddings':
        return 'WEDDINGS';
      case 'proms':
        return 'PROMS';
      case 'airportTransfers':
        return 'AIRPORT_TRANSFERS';
      case 'vipBusiness':
        return 'VIP_BUSINESS';
      case 'nightOutParty':
        return 'NIGHT_OUT_PARTY';
      case 'birthday':
        return 'BIRTHDAY';
      case 'henStag':
        return 'HEN_STAG';
      case 'other':
        return 'OTHER';
      default:
        return null;
    }
  }

  // Helper method to convert booking options to valid enum values
  String? _getBookingOptionEnum(String bookingKey) {
    switch (bookingKey) {
      case 'hourlyHire':
        return 'HOURLY_HIRE';
      case 'fullDayHire':
        return 'FULL_DAY_HIRE';
      case 'oneWayTransfers':
        return 'ONE_WAY_TRANSFERS';
      case 'returnJourney':
        return 'RETURN_JOURNEY';
      case 'packages':
        return 'PACKAGES';
      default:
        return null;
    }
  }

  // Helper method to convert available days to valid enum values
  String? _getDayEnum(String dayKey) {
    switch (dayKey) {
      case 'monday':
        return 'MONDAY';
      case 'tuesday':
        return 'TUESDAY';
      case 'wednesday':
        return 'WEDNESDAY';
      case 'thursday':
        return 'THURSDAY';
      case 'friday':
        return 'FRIDAY';
      case 'saturday':
        return 'SATURDAY';
      case 'sunday':
        return 'SUNDAY';
      default:
        return null;
    }
  }

  // Helper method to convert fleet type to valid enum values
  String _getFleetTypeEnum(String fleetType) {
    switch (fleetType) {
      case 'Standard Limousine':
        return 'STANDARD_LIMOUSINE';
      case 'Stretch Limousine':
        return 'STRETCH_LIMOUSINE';
      case 'SUV Limousine':
        return 'SUV_LIMOUSINE';
      case 'Other':
        return 'OTHER';
      default:
        return 'STANDARD_LIMOUSINE';
    }
  }

  // Prepare API payload
  Future<Map<String, dynamic>> _prepareAPIPayload() async {
    return {
      "vendorId": vendorId ?? "68eb757c758ef700653aada8",
      "listingTitle": listingTitleController.text.trim(),
      "baseLocation": baseLocationController.text.trim(),
      "baseLocationPostcode": baseLocationController.text.trim(),
      "locationRadius": int.tryParse(serviceRadiusController.text.trim()) ?? 50,
      "serviceRadius": int.tryParse(serviceRadiusController.text.trim()) ?? 50,
      "areasCovered": selectedAreas.toList(),
      
      "fleetInfo": {
        "numberOfLimousines": int.tryParse(numberOfLimousinesController.text.trim()) ?? 1,
        "fleetType": _getFleetTypeEnum(selectedFleetType.value),
        "wheelchairAccessibleVehicles": wheelchairAccessibleVehicles.value,
        "makeAndModel": makeModelController.text.trim().isNotEmpty ? makeModelController.text.trim() : "Luxury Limousine",
        "seats": int.tryParse(numberOfSeatsController.text.trim()) ?? 4,
        "luggageCapacity": int.tryParse(luggageCapacityController.text.trim()) ?? 2,
        "firstRegistration": firstRegistrationDate.value.toIso8601String(),
      },
      
      "vehicleInfo": {
        "numberOfLimousines":
            int.tryParse(numberOfLimousinesController.text.trim()) ?? 1,
        "fleetType": _getFleetTypeEnum(selectedFleetType.value),
        "wheelchairAccessibleVehicles": wheelchairAccessibleVehicles.value,
        "makeAndModel": makeModelController.text.trim().isNotEmpty ? makeModelController.text.trim() : "Luxury Limousine",
        "numberOfSeats": int.tryParse(numberOfSeatsController.text.trim()) ?? 4,
        "luggageCapacity":
            int.tryParse(luggageCapacityController.text.trim()) ?? 2,
        "firstRegistered": firstRegistrationDate.value.toIso8601String(),
      },
      
      "fleetFeatures": _getEnabledFleetFeatures(),
      "pricingDetails": {
        "hourlyRate": double.tryParse(hourlyRateController.text.trim()) ?? 0,
        "halfDayRate": double.tryParse(halfDayRateController.text.trim()) ?? 0,
        "fullDayRate": double.tryParse(fullDayRateController.text.trim()) ?? 0,
        "weddingPackageRate":
            double.tryParse(weddingPackageRateController.text.trim()) ?? 0,
        "airportTransferRate":
            double.tryParse(airportTransferRateController.text.trim()) ?? 0,
        "depositRequired":
            double.tryParse(depositRequiredController.text.trim()) ?? 0,
        "fuelIncluded": fuelIncluded.value,
        "mileageLimitsApplicable": mileageLimitsApplicable.value,
      },
      "serviceCoverage": {
        "serviceStatus":
            selectedServiceStatus.value == 'Open - Available for bookings'
                ? 'open'
                : 'closed',
        "areasCovered": selectedAreas.toList(),
      },
      "serviceAvailability": {
        "availableFrom": calendarController.fromDate.value.toIso8601String(),
        "availableTo": calendarController.toDate.value.toIso8601String(),
        "cancellationPolicy": _getCancellationPolicyEnum(selectedCancellationPolicy.value),
        "operates24Hours": operates24Hours.value,
        "openingTime": operates24Hours.value
            ? null
            : "${openingTime.value.hour}:${openingTime.value.minute.toString().padLeft(2, '0')}",
        "closingTime": operates24Hours.value
            ? null
            : "${closingTime.value.hour}:${closingTime.value.minute.toString().padLeft(2, '0')}",
        "occasionsCovered": occasionsCovered.entries
            .where((e) => e.value)
            .map((e) => _getOccasionEnum(e.key))
            .where((enumValue) => enumValue != null)
            .cast<String>()
            .toList(),
        "bookingOptions": bookingOptions.entries
            .where((e) => e.value)
            .map((e) => _getBookingOptionEnum(e.key))
            .where((enumValue) => enumValue != null)
            .cast<String>()
            .toList(),
        "availableDays": availableDays.entries
            .where((e) => e.value)
            .map((e) => _getDayEnum(e.key))
            .where((enumValue) => enumValue != null)
            .cast<String>()
            .toList(),
      },
      "service_status":
          selectedServiceStatus.value == 'Open - Available for bookings'
              ? 'open'
              : 'closed',
      "booking_date_from": calendarController.fromDate.value.toIso8601String(),
      "booking_date_to": calendarController.toDate.value.toIso8601String(),
      "special_price_days": calendarController.specialPrices
          .map((e) => {
                'date': DateFormat('yyyy-MM-dd').format(e['date'] as DateTime),
                'price': e['price'] as double? ?? 0
              })
          .toList(),
      "cancellation_policy_type": _getCancellationPolicyEnum(selectedCancellationPolicy.value),
      "documents": {
        "insuranceCertificate": {
          "isAttached": insuranceCertificateDocs.isNotEmpty,
          "image": insuranceCertificateDocs.isNotEmpty
              ? (insuranceCertificateDocs.first.uploadUrl ?? '')
              : '',
          "fileName": insuranceCertificateDocs.isNotEmpty
              ? insuranceCertificateDocs.first.name
              : '',
          "fileType": insuranceCertificateDocs.isNotEmpty
              ? 'image/${insuranceCertificateDocs.first.type}'
              : '',
          "uploadedAt": DateTime.now().toIso8601String(),
        },
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
        "v5cDocument": {
          "isAttached": v5cDocumentDocs.isNotEmpty,
          "image": v5cDocumentDocs.isNotEmpty
              ? (v5cDocumentDocs.first.uploadUrl ?? '')
              : '',
          "fileName":
              v5cDocumentDocs.isNotEmpty ? v5cDocumentDocs.first.name : '',
          "fileType": v5cDocumentDocs.isNotEmpty
              ? 'image/${v5cDocumentDocs.first.type}'
              : '',
          "uploadedAt": DateTime.now().toIso8601String(),
        },
        "vehicleMOT": {
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
        "driverLicence": {
          "isAttached": driverLicenceDocs.isNotEmpty,
          "image": driverLicenceDocs.isNotEmpty
              ? (driverLicenceDocs.first.uploadUrl ?? '')
              : '',
          "fileName":
              driverLicenceDocs.isNotEmpty ? driverLicenceDocs.first.name : '',
          "fileType": driverLicenceDocs.isNotEmpty
              ? 'image/${driverLicenceDocs.first.type}'
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
      "sub_category": "Limousine Hire",
      "categoryId": categoryId,
      "subcategoryId": subcategoryId,
      "service_name": listingTitleController.text.trim(),
      "marketingHighlights": {
        "serviceHighlights": serviceHighlightsController.text.trim(),
        "serviceDescription": serviceDescriptionController.text.trim(),
        "promotionalVideo": promotionalVideoController.text.trim(),
      },
    };
  }

  void _showSubmissionProgress() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.btnColor),
              ),
              const SizedBox(height: 20),
              const Text(
                'Submitting Your Limousine Hire Service',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                'Please wait while we process your service...',
                style: TextStyle(fontSize: 12, color: AppColors.grey600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
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
      'Your limousine hire service has been submitted successfully! Our team will review it and publish within 24 hours.',
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

  // Convert fleetFeatures boolean map to array of enabled feature strings
  List<String> _getEnabledFleetFeatures() {
    List<String> enabledFeatures = [];
    
    final featureMap = {
      'onboardBar': 'Onboard Bar',
      'partyLighting': 'Party Lighting',
      'wifi': 'WiFi',
      'tvScreen': 'TV/Screen',
      'bluetoothMusic': 'Bluetooth Music',
      'privacyDivider': 'Privacy Divider',
      'usbCharging': 'USB Charging',
      'wheelchairAccess': 'Wheelchair Access',
    };

    // Add enabled features to the list
    fleetFeatures.forEach((key, value) {
      if (value == true && featureMap.containsKey(key)) {
        enabledFeatures.add(featureMap[key]!);
      }
    });

    // Handle 'other' feature separately
    if (fleetFeatures['other'] == true && otherFeatureController.text.trim().isNotEmpty) {
      enabledFeatures.add(otherFeatureController.text.trim());
    }

    return enabledFeatures;
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
    baseLocationController.dispose();
    numberOfLimousinesController.dispose();
    makeModelController.dispose();
    numberOfSeatsController.dispose();
    luggageCapacityController.dispose();
    serviceRadiusController.dispose();
    searchCitiesController.dispose();
    otherFeatureController.dispose();

    // Pricing controllers
    hourlyRateController.dispose();
    halfDayRateController.dispose();
    fullDayRateController.dispose();
    weddingPackageRateController.dispose();
    airportTransferRateController.dispose();
    depositRequiredController.dispose();

    // Service description
    serviceHighlightsController.dispose();
    serviceDescriptionController.dispose();
    promotionalVideoController.dispose();

    super.onClose();
  }
}

// Professional Progress Bar Widget - Same as boat hire
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
                          'Limousine Hire Form',
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

// Professional Input Widget - Same as boat hire
class ProfessionalInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool isRequired;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? maxLength;

  const ProfessionalInput({
    Key? key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.validator,
    this.maxLines = 1,
    this.maxLength,
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
          maxLines: maxLines,
          maxLength: maxLength,
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
            counterText: maxLength != null ? null : '',
          ),
        ),
      ],
    );
  }
}

// Professional Dropdown Widget - Same as boat hire
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

// Professional Button Widget - Same as boat hire
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

// Main Limousine Hire Service Widget
class LimousineHireService extends StatelessWidget {
  final LimousineHireController controller = Get.put(LimousineHireController());

  final Rxn<String> category;
  final Rxn<String> subCategory;
  final String? categoryId;
  final String? subCategoryId;

  LimousineHireService({
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
      key: const ValueKey('step1'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Required Documents',
            'Upload required documents to proceed'),

        // Required Documents Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.error.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.error.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 20),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2 required',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'These documents are mandatory for your service listing',
                      style: TextStyle(fontSize: 12, color: AppColors.grey700),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        _buildDocumentUploadSection(
          'Insurance Certificate',
          controller.insuranceCertificateDocs,
          isRequired: true,
        ),

        const SizedBox(height: 20),

        _buildDocumentUploadSection(
          'Operator Licence',
          controller.operatorLicenceDocs,
          isRequired: true,
        ),

        const SizedBox(height: 32),

        // Optional Documents Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.btnColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.btnColor.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline,
                  color: AppColors.primaryDark, size: 20),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3 optional',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Additional documents to enhance your service credibility',
                      style: TextStyle(fontSize: 12, color: AppColors.grey700),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        _buildDocumentUploadSection('V5c Document', controller.v5cDocumentDocs),
        const SizedBox(height: 20),
        _buildDocumentUploadSection('Vehicle M O T', controller.vehicleMOTDocs),
        const SizedBox(height: 20),
        _buildDocumentUploadSection(
            'Driver Licence', controller.driverLicenceDocs),
      ],
    );
  }

  // Step 2: Listing Details
  Widget _buildStep2(BuildContext context) {
    return Column(
      key: const ValueKey('step2'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Listing Details',
            'Create an attractive listing for customers'),
        ProfessionalInput(
          label: 'Listing Title',
          controller: controller.listingTitleController,
          hintText: 'Example: Premium Limousine Hire Service',
          isRequired: true,
          validator: (value) {
            if (value?.trim().isEmpty ?? true) return 'Title is required';
            if (value!.length < 3) return 'Title must be at least 3 characters';
            return null;
          },
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey900,
                  ),
                  children: [
                    TextSpan(text: 'Base Location'),
                    TextSpan(
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
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.length < 2) {
                  return const Iterable<String>.empty();
                }
                return Cities.ukCities.where((String city) {
                  return city
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                }).take(5);
              },
              onSelected: (String selection) {
                controller.baseLocationController.text = selection;
              },
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                // Initialize with current value
                if (textEditingController.text.isEmpty &&
                    controller.baseLocationController.text.isNotEmpty) {
                  textEditingController.text =
                      controller.baseLocationController.text;
                }

                // Sync changes back to main controller
                textEditingController.addListener(() {
                  if (controller.baseLocationController.text !=
                      textEditingController.text) {
                    controller.baseLocationController.text =
                        textEditingController.text;
                  }
                });

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    onSubmitted: (value) => onFieldSubmitted(),
                    decoration: const InputDecoration(
                      hintText: "Enter your base location",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                      hintStyle: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 16,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF333333),
                    ),
                  ),
                );
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(8),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200, maxWidth: 300),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final option = options.elementAt(index);
                          return ListTile(
                            title: Text(
                              option,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF333333),
                              ),
                            ),
                            onTap: () => onSelected(option),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
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
            'Technical details about your limousine fleet'),

        ProfessionalInput(
          label: 'Number of Limousines',
          controller: controller.numberOfLimousinesController,
          hintText: 'Enter number of vehicles in fleet',
          isRequired: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            final num = int.tryParse(value ?? '') ?? 0;
            if (num < 1) return 'Must be at least 1';
            return null;
          },
        ),
        const SizedBox(height: 20),

        ProfessionalDropdown(
          label: 'Fleet Type',
          value: controller.selectedFleetType.value,
          items: controller.fleetTypes,
          onChanged: (value) =>
              controller.selectedFleetType.value = value ?? '',
          isRequired: true,
        ),
        const SizedBox(height: 20),

        // Wheelchair Accessible Vehicles
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Wheelchair Accessible Vehicles',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.grey900,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Available wheelchair accessible vehicles',
              style: TextStyle(fontSize: 12, color: AppColors.grey600),
            ),
            const SizedBox(height: 12),
            Obx(() => Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Number of accessible vehicles'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (controller
                                      .wheelchairAccessibleVehicles.value >
                                  0) {
                                controller.wheelchairAccessibleVehicles.value--;
                              }
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text(
                            '${controller.wheelchairAccessibleVehicles.value}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.wheelchairAccessibleVehicles.value++;
                            },
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
        const SizedBox(height: 24),

        ProfessionalInput(
          label: 'Make & Model',
          controller: controller.makeModelController,
          hintText: 'e.g., Mercedes S-Class Stretch Limousine',
          isRequired: true,
          validator: (value) {
            if (value?.trim().isEmpty ?? true)
              return 'Make & Model is required';
            return null;
          },
        ),
        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: ProfessionalInput(
                label: 'Number of Seats',
                controller: controller.numberOfSeatsController,
                hintText: 'Enter number of seats',
                keyboardType: TextInputType.number,
                isRequired: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  final num = int.tryParse(value ?? '') ?? 0;
                  if (num < 1) return 'Must be at least 1';
                  if (num > 50) return 'Maximum 50 seats';
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ProfessionalInput(
                label: 'Luggage Capacity',
                controller: controller.luggageCapacityController,
                hintText: 'Enter luggage capacity',
                keyboardType: TextInputType.number,
                isRequired: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value?.trim().isEmpty ?? true)
                    return 'Luggage capacity is required';
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        _buildDateField(
            context, 'First Registered', controller.firstRegistrationDate, allowFutureDates: false),
        const SizedBox(height: 24),

        // Fleet Features
        _buildStepHeader(context, 'Fleet Features',
            'Select all features available in your limousine fleet'),

        Column(
          children: [
            _buildFeatureCheckbox(
                'Onboard Bar', controller.fleetFeatures, 'onboardBar'),
            _buildFeatureCheckbox(
                'Party Lighting', controller.fleetFeatures, 'partyLighting'),
            _buildFeatureCheckbox('WiFi', controller.fleetFeatures, 'wifi'),
            _buildFeatureCheckbox(
                'TV/Screen', controller.fleetFeatures, 'tvScreen'),
            _buildFeatureCheckbox(
                'Bluetooth Music', controller.fleetFeatures, 'bluetoothMusic'),
            _buildFeatureCheckbox(
                'Privacy Divider', controller.fleetFeatures, 'privacyDivider'),
            _buildFeatureCheckbox(
                'USB Charging', controller.fleetFeatures, 'usbCharging'),
            _buildFeatureCheckbox('Wheelchair Access', controller.fleetFeatures,
                'wheelchairAccess'),
            _buildFeatureCheckbox('Other', controller.fleetFeatures, 'other'),
          ],
        ),

        Obx(() => controller.fleetFeatures['other'] == true
            ? Column(
                children: [
                  const SizedBox(height: 16),
                  ProfessionalInput(
                    label: 'Specify Other Feature',
                    controller: controller.otherFeatureController,
                    hintText: 'Describe other features...',
                    isRequired: true,
                  ),
                ],
              )
            : const SizedBox()),
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
            'Set competitive rates for your limousine service'),

        Row(
          children: [
            Expanded(
              child: ProfessionalInput(
                label: 'Hourly Rate (£)',
                controller: controller.hourlyRateController,
                hintText: 'Enter hourly rate',
                isRequired: true,
                keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ProfessionalInput(
                label: 'Half Day Rate (£)',
                controller: controller.halfDayRateController,
                hintText: 'Enter half day rate',
                keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: ProfessionalInput(
                label: 'Full Day Rate (10 hrs) (£)',
                controller: controller.fullDayRateController,
                hintText: 'Enter full day rate',
                keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ProfessionalInput(
                label: 'Wedding Package Rate (£)',
                controller: controller.weddingPackageRateController,
                hintText: 'Enter wedding package rate',
                keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: ProfessionalInput(
                label: 'Airport Transfer Rate (£)',
                controller: controller.airportTransferRateController,
                hintText: 'Enter airport transfer rate',
               keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ProfessionalInput(
                label: 'Deposit Required (£)',
                controller: controller.depositRequiredController,
                hintText: 'Enter deposit amount',
                keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Fuel and Mileage Options
        Obx(() => CheckboxListTile(
              title: const Text('Fuel Included'),
              subtitle: const Text('Fuel charges included in rates'),
              value: controller.fuelIncluded.value,
              onChanged: (value) =>
                  controller.fuelIncluded.value = value ?? false,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: AppColors.btnColor,
            )),

        Obx(() => CheckboxListTile(
              title: const Text('Mileage Limits Applicable'),
              subtitle: const Text('Apply mileage limits to bookings'),
              value: controller.mileageLimitsApplicable.value,
              onChanged: (value) =>
                  controller.mileageLimitsApplicable.value = value ?? false,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: AppColors.btnColor,
            )),
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
            'Define your service area and operational status'),
        const Text(
          'Service Coverage Areas *',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.grey900,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: ProfessionalInput(
                label: 'Service Radius (miles)',
                controller: controller.serviceRadiusController,
                hintText:
                    'How far are you willing to travel? (Range: 1-500 miles)',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  final num = int.tryParse(value ?? '') ?? 0;
                  if (num < 1 || num > 500) return 'Range: 1-500 miles';
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildAreasSelection(context),
        const SizedBox(height: 24),
        ProfessionalDropdown(
          label: 'Service Status',
          value: controller.selectedServiceStatus.value,
          items: controller.serviceStatusOptions,
          onChanged: (value) =>
              controller.selectedServiceStatus.value = value ?? '',
          isRequired: true,
        ),
        const SizedBox(height: 8),
        const Text(
          'Set to "Open" to accept new bookings, or "Closed" to temporarily stop accepting bookings.',
          style: TextStyle(fontSize: 12, color: AppColors.grey600),
        ),
      ],
    );
  }

  // Step 6: Service Availability
  Widget _buildStep6(BuildContext context) {
    return Column(
      key: const ValueKey('step6'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Service Availability',
            'Set your availability and policies'),

        _buildDateField(
            context, 'Available From', controller.calendarController.fromDate),
        const SizedBox(height: 16),
        _buildDateField(context, 'Available To', controller.calendarController.toDate),
        const SizedBox(height: 8),
        const Text(
          'Must be after the start date',
          style: TextStyle(fontSize: 12, color: AppColors.grey600),
        ),
        const SizedBox(height: 24),

        ProfessionalDropdown(
          label: 'Cancellation Policy',
          value: controller.selectedCancellationPolicy.value,
          items: controller.cancellationPolicyOptions,
          onChanged: (value) =>
              controller.selectedCancellationPolicy.value = value ?? '',
          isRequired: true,
        ),
        const SizedBox(height: 32),

        // Operating Hours
        _buildStepHeader(context, 'Operating Hours', ''),
        Obx(() => CheckboxListTile(
              title: const Text('We operate 24/7'),
              value: controller.operates24Hours.value,
              onChanged: (value) =>
                  controller.operates24Hours.value = value ?? false,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: AppColors.btnColor,
            )),

        Obx(() => !controller.operates24Hours.value
            ? Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildTimeField(
                            context, 'Opening Time', controller.openingTime),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTimeField(
                            context, 'Closing Time', controller.closingTime),
                      ),
                    ],
                  ),
                ],
              )
            : const SizedBox()),

        const SizedBox(height: 32),

        // Service Options
        _buildStepHeader(context, 'Service Options', ''),

        const Text(
          'Occasions We Cover *',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.grey900,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Select all occasions your limousine service covers',
          style: TextStyle(fontSize: 12, color: AppColors.grey600),
        ),
        const SizedBox(height: 16),

        Column(
          children: [
            _buildFeatureCheckbox(
                'Weddings', controller.occasionsCovered, 'weddings'),
            _buildFeatureCheckbox(
                'Proms', controller.occasionsCovered, 'proms'),
            _buildFeatureCheckbox('Airport Transfers',
                controller.occasionsCovered, 'airportTransfers'),
            _buildFeatureCheckbox('VIP/Business Travel',
                controller.occasionsCovered, 'vipBusiness'),
            _buildFeatureCheckbox('Night Out/Party',
                controller.occasionsCovered, 'nightOutParty'),
            _buildFeatureCheckbox(
                'Birthday', controller.occasionsCovered, 'birthday'),
            _buildFeatureCheckbox(
                'Hen/Stag', controller.occasionsCovered, 'henStag'),
            _buildFeatureCheckbox(
                'Other', controller.occasionsCovered, 'other'),
          ],
        ),

        const SizedBox(height: 24),

        const Text(
          'Booking Options *',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.grey900,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Select all booking options you offer',
          style: TextStyle(fontSize: 12, color: AppColors.grey600),
        ),
        const SizedBox(height: 16),

        Column(
          children: [
            _buildFeatureCheckbox(
                'Hourly Hire', controller.bookingOptions, 'hourlyHire'),
            _buildFeatureCheckbox(
                'Full-Day Hire', controller.bookingOptions, 'fullDayHire'),
            _buildFeatureCheckbox('One-Way Transfers',
                controller.bookingOptions, 'oneWayTransfers'),
            _buildFeatureCheckbox(
                'Return Journey', controller.bookingOptions, 'returnJourney'),
            _buildFeatureCheckbox(
                'Packages', controller.bookingOptions, 'packages'),
          ],
        ),

        const SizedBox(height: 24),

        const Text(
          'Available Days *',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.grey900,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Select the days of the week you operate',
          style: TextStyle(fontSize: 12, color: AppColors.grey600),
        ),
        const SizedBox(height: 16),

        Wrap(
          spacing: 8,
          children: [
            _buildDayChip('Mon', 'Monday', 'monday'),
            _buildDayChip('Tue', 'Tuesday', 'tuesday'),
            _buildDayChip('Wed', 'Wednesday', 'wednesday'),
            _buildDayChip('Thu', 'Thursday', 'thursday'),
            _buildDayChip('Fri', 'Friday', 'friday'),
            _buildDayChip('Sat', 'Saturday', 'saturday'),
            _buildDayChip('Sun', 'Sunday', 'sunday'),
          ],
        ),

        const SizedBox(height: 32),

        const Text('Special Pricing Calendar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 14),

        const Text('Set special prices for specific dates (holidays, peak seasons, events). These will override your standard rates.'),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.btnColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.btnColor.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.btnColor, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Calendar is linked to your "Available From" and "Available To" dates above. Only dates within your availability period can have special pricing.',
                  style: TextStyle(fontSize: 12, color: AppColors.btnColor),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Calendar implementation - following boat hire service pattern
        Obx(() {
          DateTime focusedDay = controller.calendarController.fromDate.value;
          DateTime availableFromDate = controller.calendarController.fromDate.value;
          DateTime availableToDate = controller.calendarController.toDate.value;
          
          // Ensure focused day is within the available range
          if (focusedDay.isBefore(availableFromDate)) {
            focusedDay = availableFromDate;
          } else if (focusedDay.isAfter(availableToDate)) {
            focusedDay = availableToDate;
          }
          
          return TableCalendar(
            onDaySelected: (selectedDay, focusedDay) {
              // Only allow selection within the available date range (inclusive)
              if (selectedDay.isAtSameMomentAs(availableFromDate) ||
                  selectedDay.isAtSameMomentAs(availableToDate) ||
                  (selectedDay.isAfter(availableFromDate) && selectedDay.isBefore(availableToDate))) {
                controller._showSetPriceDialog(selectedDay);
              }
            },
            focusedDay: focusedDay,
            firstDay: availableFromDate, // Link to Available From date
            lastDay: availableToDate,    // Link to Available To date
            calendarFormat: CalendarFormat.month,
            availableGestures: AvailableGestures.none,
            headerStyle: const HeaderStyle(formatButtonVisible: false),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                // Check if day is within the available date range (inclusive)
                bool isWithinRange = day.isAtSameMomentAs(availableFromDate) ||
                                   day.isAtSameMomentAs(availableToDate) ||
                                   (day.isAfter(availableFromDate) && day.isBefore(availableToDate));
                
                if (isWithinRange) {
                  return controller._buildCalendarCell(context, day, true);
                }
                return controller._buildCalendarCell(context, day, false);
              },
            ),
          );
        }),

        const SizedBox(height: 20),
        const Text('Special Prices Summary',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        Obx(() => controller.calendarController.specialPrices.isEmpty
            ? Container(
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.grey300),
                ),
                child: const Center(
                  child: Text(
                    'No special prices set yet. Click on calendar dates to add special pricing.',
                    style: TextStyle(fontSize: 14, color: AppColors.grey600),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Container(
                constraints: const BoxConstraints(maxHeight: 200),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.calendarController.specialPrices.length,
                  itemBuilder: (context, index) {
                    final entry = controller.calendarController.specialPrices[index];
                    final date = entry['date'] as DateTime;
                    final price = entry['price'] as double;
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.grey200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('EEE, d MMM yyyy').format(date),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '£${price.toStringAsFixed(2)}/day',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: price > 0 ? AppColors.success : AppColors.error,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: AppColors.error, size: 20),
                            onPressed: () => controller.calendarController.deleteSpecialPrice(date),
                            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )),
      ],
    );
  }

  // Step 7: Features & Services
  Widget _buildStep7(BuildContext context) {
    return Column(
      key: const ValueKey('step7'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Features & Services',
            'Marketing highlights and service description'),
        ProfessionalInput(
          label: 'Service Highlights',
          controller: controller.serviceHighlightsController,
          hintText:
              'What makes your limousine service stand out from the competition?',
          isRequired: true,
          maxLines: 3,
        ),
        const SizedBox(height: 20),
        ProfessionalInput(
          label: 'Service Description',
          controller: controller.serviceDescriptionController,
          hintText:
              'Provide a compelling description of your limousine service (max 500 characters)',
          isRequired: true,
          maxLines: 4,
          maxLength: 500,
        ),
        const SizedBox(height: 20),
        ProfessionalInput(
          label: 'Promotional Video Link (Optional)',
          controller: controller.promotionalVideoController,
          hintText:
              'Add a YouTube or video link to showcase your limousine fleet',
          keyboardType: TextInputType.url,
        ),
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
            'Upload high-quality images of your limousine fleet'),

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
          'Upload high-quality images of your limousines. Show exterior, interior, and key features.',
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
    return Column(
      key: const ValueKey('step9'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Coupon Management',
            'Create promotional coupons for your limousine service'),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
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
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: AppColors.grey600),
          ),
        ],
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
              firstDate: allowFutureDates ? DateTime.now() : DateTime(1950),
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
              date.value = picked;
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
                        DateFormat('dd-MM-yyyy').format(date.value),
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

  Widget _buildTimeField(
      BuildContext context, String label, Rx<TimeOfDay> time) {
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
            ],
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: time.value,
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
              time.value = picked;
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
                const Icon(Icons.access_time,
                    color: AppColors.btnColor, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(() => Text(
                        time.value.format(context),
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
          hintText: 'Search cities...',
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
                      'Selected Areas (${controller.selectedAreas.length})',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey900),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.selectedAreas.take(5).join(', ') +
                          (controller.selectedAreas.length > 5
                              ? ' ... and ${controller.selectedAreas.length - 5} more'
                              : ''),
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.grey600),
                    ),
                  ],
                ),
              )
            : const SizedBox()),
      ],
    );
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
                      style: TextStyle(
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

  Widget _buildDayChip(String shortLabel, String fullLabel, String key) {
    return Obx(() => FilterChip(
          label: Text(
            shortLabel,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: controller.availableDays[key] == true
                  ? AppColors.white
                  : AppColors.grey700,
            ),
          ),
          selected: controller.availableDays[key] == true,
          onSelected: (selected) {
            controller.availableDays[key] = selected;
          },
          backgroundColor: AppColors.grey200,
          selectedColor: AppColors.btnColor,
          checkmarkColor: AppColors.white,
          elevation: 0,
          pressElevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: controller.availableDays[key] == true
                  ? AppColors.btnColor
                  : AppColors.grey300,
              width: 1,
            ),
          ),
        ));
  }



  IconData _getFileIcon(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }
}
