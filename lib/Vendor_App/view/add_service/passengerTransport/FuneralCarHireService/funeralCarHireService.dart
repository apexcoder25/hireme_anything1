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
import 'package:hire_any_thing/utilities/colors.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/service_controller.dart';
import 'package:hire_any_thing/res/routes/routes.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';


// Document model reused
class DocumentFile {
  final String path;
  final String name;
  final String type;
  final int size;
  bool isUploaded;
  String? uploadUrl;
  DocumentFile(
      {required this.path,
      required this.name,
      required this.type,
      required this.size,
      this.isUploaded = false,
      this.uploadUrl});
  String get displaySize {
    if (size < 1024) return '${size} B';
    if (size < 1048576) return '${(size / 1024).toStringAsFixed(1)} KB';
    return '${(size / 1048576).toStringAsFixed(1)} MB';
  }

  bool get isValidSize => size <= 5 * 1024 * 1024; // 5MB
}

// Funeral Car Hire Controller with fields matched to your requirements
class FuneralCarHireController extends GetxController {
  var currentStep = 1.obs;
  var isLoading = false.obs;
  var isNavigating = false.obs;
  var isSubmitting = false.obs;
  var completedSteps = <int>{}.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Funeral Specific fields
  final TextEditingController listingTitleController = TextEditingController();
  final TextEditingController baseLocationController = TextEditingController();
  final TextEditingController makeModelController = TextEditingController();
  final TextEditingController numberOfSeatsController = TextEditingController();
  final TextEditingController dayRateController = TextEditingController();
  final TextEditingController hourlyRateController = TextEditingController();
  final TextEditingController halfDayRateController = TextEditingController();
  final TextEditingController mileageLimitController = TextEditingController();
  final TextEditingController extraMileageChargeController =
      TextEditingController();
  final TextEditingController serviceRadiusController = TextEditingController();
  final TextEditingController searchCitiesController = TextEditingController();
  final TextEditingController uniqueServiceController = TextEditingController();
  final TextEditingController promoDescriptionController =
      TextEditingController();
  final TextEditingController otherVehicleController = TextEditingController();

  // Funeral Availability/Type
  var availableFromDate = DateTime.now().obs;
  var availableToDate = DateTime.now().add(const Duration(days: 365)).obs;
  var firstRegisteredDate = DateTime.now().obs;
  var selectedServiceStatus = 'Open - Available for bookings'.obs;
  final List<String> serviceStatusOptions = [
    'Open - Available for bookings',
    'Closed - Not accepting bookings'
  ];
  final List<String> cancellationPolicies = [
    'Flexible',
    'Moderate',
    'Strict',
    'Super Strict'
  ];
  var selectedCancellationPolicy =
      'Flexible'.obs;

  List<String> funeralServiceTypes = [
    'Religious Services Only',
    'Non-Religious Services Only',
    'Both Religious & Non-Religious'
  ];
  var selectedFuneralServiceType = 'Both Religious & Non-Religious'.obs;

  // Vehicle Options
  Map<String, RxBool> funeralVehicles = {
    'Traditional Hearse': false.obs,
    'Horse-Drawn Hearse': false.obs,
    'Limousine (Family Car)': false.obs,
    'Alternative Vehicle (Motorcycle, Vintage, Other)': false.obs,
  };

  // Availability
  Map<String, RxBool> funeralAvailability = {
    '24/7 Service': false.obs,
    'Weekdays Only': false.obs,
    'Weekends Only': false.obs,
  };

  // Additional Services
  RxList<String> selectedAdditionalServices = <String>[].obs;
  RxList<String> selectedAccessibilityServices = <String>[].obs;
  var selectedAvailability = '24/7 Service'.obs;

  // Documents
  RxList<DocumentFile> operatorLicenceDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> insuranceCertificateDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> driverLicenceDBSDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> vehicleMOTDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> serviceImages = <DocumentFile>[].obs;

  // City and area
  RxList<String> selectedAreas = <String>[].obs;
  RxList<String> filteredCities = <String>[].obs;

  // Terms/Agreements
  var isAccurateInfo = false.obs;
  var noContactDetailsShared = false.obs;
  var agreeCookiesPolicy = false.obs;
  var agreePrivacyPolicy = false.obs;
  var agreeCancellationPolicy = false.obs;

  final CalendarController calendarController = Get.put(CalendarController());
  final CouponController couponController = Get.put(CouponController());
  final ImageController imageController = Get.put(ImageController());

  String? vendorId;
  String categoryId = "676ac544234968d45b494992"; // Funeral car hire category
  String subcategoryId =
      "676ace13234968d45b4949db"; // Funeral car hire subcategory

  final int totalSteps = 10;

  @override
  void onInit() {
    super.onInit();
    filteredCities.value = Cities.ukCities;
    _loadVendorId();
    searchCitiesController.addListener(_filterCities);
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

  // Step navigation
  Future<void> nextStep() async {
    if (currentStep.value < totalSteps) {
      // Validate current step before proceeding
      if (!validateCurrentStep()) {
        return;
      }

      isNavigating.value = true;
      await Future.delayed(const Duration(milliseconds: 120));
      completedSteps.add(currentStep.value);
      currentStep.value++;
      isNavigating.value = false;
      HapticFeedback.selectionClick();
    }
  }

  Future<void> previousStep() async {
    if (currentStep.value > 1) {
      isNavigating.value = true;
      await Future.delayed(const Duration(milliseconds: 100));
      currentStep.value--;
      isNavigating.value = false;
    }
  }

  // Document upload
  Future<void> pickDocument(RxList<DocumentFile> targetList) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );
      if (result != null && result.files.single.path != null) {
        final file = result.files.single;
        final doc = DocumentFile(
          path: file.path!,
          name: file.name,
          type: file.extension?.toLowerCase() ?? '',
          size: file.size,
        );
        targetList.add(doc);
        Get.snackbar('Success', 'Document uploaded successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.success,
            colorText: AppColors.white,
            duration: const Duration(seconds: 2));
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick document: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.error,
          colorText: AppColors.white);
    }
  }

  void removeDocument(RxList<DocumentFile> docs, int index) {
    if (index < docs.length) docs.removeAt(index);
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

  // Progress text
  double get progressPercentage => currentStep.value / totalSteps;
  String get progressText => '${(progressPercentage * 100).toInt()}% Complete';

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

  // Validation methods
  bool validateCurrentStep() {
    switch (currentStep.value) {
      case 1:
        return _validateDocuments();
      case 2:
        return _validateListingDetails();
      case 3:
        return _validateVehicleInfo();
      case 4:
        return _validatePricing();
      case 5:
        return _validateCoverage();
      case 6:
        return _validateAvailability();
      case 7:
        return _validateFeatures();
      case 8:
        return _validatePhotos();
      case 9:
        return true; // Coupon management is optional
      case 10:
        return _validateTerms();
      default:
        return true;
    }
  }

  bool _validateDocuments() {
    if (operatorLicenceDocs.isEmpty) {
      _showError('Operator Licence document is required');
      return false;
    }
    if (insuranceCertificateDocs.isEmpty) {
      _showError('Insurance Certificate document is required');
      return false;
    }
    return true;
  }

  bool _validateListingDetails() {
    if (listingTitleController.text.trim().isEmpty) {
      _showError('Listing title is required');
      return false;
    }
    if (baseLocationController.text.trim().isEmpty) {
      _showError('Base location is required');
      return false;
    }
    return true;
  }

  bool _validateVehicleInfo() {
    if (makeModelController.text.trim().isEmpty) {
      _showError('Make & Model is required');
      return false;
    }
    if (numberOfSeatsController.text.trim().isEmpty) {
      _showError('Number of seats is required');
      return false;
    }
    final seats = int.tryParse(numberOfSeatsController.text.trim()) ?? 0;
    if (seats < 1 || seats > 20) {
      _showError('Number of seats must be between 1 and 20');
      return false;
    }
    return true;
  }

  bool _validatePricing() {
    if (dayRateController.text.trim().isEmpty ||
        hourlyRateController.text.trim().isEmpty ||
        halfDayRateController.text.trim().isEmpty ||
        mileageLimitController.text.trim().isEmpty ||
        extraMileageChargeController.text.trim().isEmpty) {
      _showError('All pricing fields are required');
      return false;
    }

    final dayRate = double.tryParse(dayRateController.text.trim()) ?? 0;
    final hourlyRate = double.tryParse(hourlyRateController.text.trim()) ?? 0;
    final halfDayRate = double.tryParse(halfDayRateController.text.trim()) ?? 0;

    if (dayRate <= 0 || hourlyRate <= 0 || halfDayRate <= 0) {
      _showError('All rates must be greater than 0');
      return false;
    }
    return true;
  }

  bool _validateCoverage() {
    // Coverage validation can be optional for now
    return true;
  }

  bool _validateAvailability() {
    // Availability validation can be optional for now
    return true;
  }

  bool _validateFeatures() {
    // Check if at least one vehicle type is selected
    bool hasVehicleType =
        funeralVehicles.values.any((selected) => selected.value == true);
    if (!hasVehicleType) {
      _showError('Please select at least one type of funeral vehicle');
      return false;
    }

    // Check if at least one availability option is selected
    bool hasAvailability =
        funeralAvailability.values.any((selected) => selected.value == true);
    if (!hasAvailability) {
      _showError('Please select at least one availability option');
      return false;
    }

    if (uniqueServiceController.text.trim().isEmpty) {
      _showError('Please describe what makes your service unique');
      return false;
    }

    if (promoDescriptionController.text.trim().isEmpty) {
      _showError('Promotional description is required');
      return false;
    }

    final wordCount =
        promoDescriptionController.text.trim().split(RegExp(r'\s+')).length;
    if (wordCount > 100) {
      _showError('Promotional description must be 100 words or less');
      return false;
    }

    return true;
  }

  bool _validatePhotos() {
    if (serviceImages.length < 3) {
      _showError(
          'Please upload at least 3 high-quality images of your funeral vehicles');
      return false;
    }
    return true;
  }

  bool _validateTerms() {
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

  // Enhanced form submission with EXACT API payload structure  
  Future<void> submitForm() async {
    if (!_validateTerms()) return;

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
        final isAdded = await api.addServiceVendor(formData, 'funeral');

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
        // Close progress dialog on any error
        if (Get.isDialogOpen == true) {
          Get.back();
        }
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
    await _uploadDocumentList(operatorLicenceDocs);
    await _uploadDocumentList(insuranceCertificateDocs);
    await _uploadDocumentList(driverLicenceDBSDocs);
    await _uploadDocumentList(vehicleMOTDocs);
    await _uploadDocumentList(serviceImages);
  }

  Future<void> _uploadDocumentList(RxList<DocumentFile> documents) async {
    for (var doc in documents) {
      if (!doc.isUploaded) {
        // Upload to cloudinary
        await imageController.uploadToCloudinary(doc.path);
        if (imageController.uploadedUrls.isNotEmpty) {
          doc.uploadUrl = imageController.uploadedUrls.last;
          doc.isUploaded = true;
        }
      }
    }
  }

  // Prepare API payload with EXACT structure matching the expected payload
  Future<Map<String, dynamic>> _prepareAPIPayload() async {
    return {
      "vendorId": vendorId ?? "68f0ef31b65bc1c05680ae9c",
      "listingTitle": listingTitleController.text.trim(),
      "baseLocationPostcode": baseLocationController.text.trim(),
      "locationRadius": int.tryParse(serviceRadiusController.text.trim()) ?? 50,
      "areasCovered": selectedAreas.toList(),
      "fleetInfo": {
        "makeAndModel": makeModelController.text.trim(),
        "seats": int.tryParse(numberOfSeatsController.text.trim()) ?? 4,
        "luggageCapacity": 2, // Default value as no field exists
        "firstRegistration": DateTime.now().toIso8601String(),
      },
      "pricingDetails": {
        "dayRate": double.tryParse(dayRateController.text.trim()) ?? 0,
        "hourlyRate": double.tryParse(hourlyRateController.text.trim()) ?? 0,
        "halfDayRate": double.tryParse(halfDayRateController.text.trim()) ?? 0,
        "mileageLimit": int.tryParse(mileageLimitController.text.trim()) ?? 100,
        "extraMileageCharge": double.tryParse(extraMileageChargeController.text.trim()) ?? 0,
      },
      "features": {
        "comfort": {
          "leatherInterior": false,
          "wifiAccess": false,
          "airConditioning": false,
          "complimentaryDrinks": {"available": false},
          "inCarEntertainment": false,
          "bluetoothUsb": false,
          "redCarpetService": false,
          "onboardRestroom": false,
        },
        "events": {
          "weddingDecor": false,
          "weddingDecorPrice": 0,
          "partyLightingSystem": false,
          "partyLightingPrice": 0,
          "champagnePackages": false,
          "champagnePackagePrice": 0,
          "photographyPackages": false,
          "photographyPackagePrice": 0,
        },
        "accessibility": {
          "wheelchairAccessVehicle": false,
          "wheelchairAccessPrice": 0,
          "childCarSeats": false,
          "childCarSeatsPrice": 0,
          "petFriendlyService": false,
          "petFriendlyPrice": 0,
          "disabledAccessRamp": false,
          "disabledAccessRampPrice": 0,
          "seniorFriendlyAssistance": false,
          "seniorAssistancePrice": 0,
          "strollerBuggyStorage": false,
          "strollerStoragePrice": 0,
        },
        "security": {
          "vehicleTrackingGps": false,
          "cctvFitted": false,
          "publicLiabilityInsurance": false,
          "safetyCertifiedDrivers": false,
        }
      },
      "service_status": "open",
      "booking_date_from": calendarController.fromDate.value.toIso8601String(),
      "booking_date_to": calendarController.toDate.value.toIso8601String(),
      "special_price_days": calendarController.specialPrices
          .map((e) => {
                'date': DateFormat('yyyy-MM-dd').format(e['date'] as DateTime),
                'price': e['price'] as double? ?? 0
              })
          .toList(),
      "cancellation_policy_type": selectedCancellationPolicy.value.toUpperCase(),
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
        "driverLicencesAndDBS": {
          "isAttached": driverLicenceDBSDocs.isNotEmpty,
          "image": driverLicenceDBSDocs.isNotEmpty
              ? (driverLicenceDBSDocs.first.uploadUrl ?? '')
              : '',
          "fileName": driverLicenceDBSDocs.isNotEmpty
              ? driverLicenceDBSDocs.first.name
              : '',
          "fileType": driverLicenceDBSDocs.isNotEmpty
              ? 'image/${driverLicenceDBSDocs.first.type}'
              : '',
          "uploadedAt": DateTime.now().toIso8601String(),
        },
        "vehicleMOTs": {
          "isAttached": vehicleMOTDocs.isNotEmpty,
          "image": vehicleMOTDocs.isNotEmpty
              ? (vehicleMOTDocs.first.uploadUrl ?? '')
              : '',
          "fileName": vehicleMOTDocs.isNotEmpty
              ? vehicleMOTDocs.first.name
              : '',
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
      "sub_category": "Funeral Car Hire",
      "categoryId": categoryId,
      "subcategoryId": subcategoryId,
      "driversUniformed": false,
      "driversDBSChecked": false,
      "coordinateWithDirectors": false,
      "supportReligious": false,
      "funeralServiceType": selectedFuneralServiceType.value,
      "additionalSupportServices": selectedAdditionalServices.toList(),
      "accessibilityAndSpecialServices": selectedAccessibilityServices.toList(),
      "uniqueFeatures": uniqueServiceController.text.trim(),
      "promotionalDescription": promoDescriptionController.text.trim(),
      "traditionalHearse": funeralVehicles['Traditional Hearse']?.value ?? false,
      "horseDrawnHearse": funeralVehicles['Horse-Drawn Hearse']?.value ?? false,
      "limousine": funeralVehicles['Limousine (Family Car)']?.value ?? false,
      "otherVehicleType": funeralVehicles['Alternative Vehicle (Motorcycle, Vintage, Other)']?.value ?? false,
      "otherVehicleDescription": otherVehicleController.text.trim(),
      "availability": selectedAvailability.value,
      "service_name": listingTitleController.text.trim(),
      "basePostcode": baseLocationController.text.trim(),
      "fleetDetails": {
        "makeModel": makeModelController.text.trim(),
        "year": DateTime.now().toIso8601String(),
        "seats": int.tryParse(numberOfSeatsController.text.trim()) ?? 4,
        "luggageCapacity": 2
      },
      "service_detail": {
        "worksWithFuneralDirectors": false,
        "supportsAllFuneralTypes": false,
        "funeralServiceType": selectedFuneralServiceType.value,
        "additionalSupportServices": selectedAdditionalServices.toList()
      },
      "funeralVehicleTypes": {
        "traditionalHearse": funeralVehicles['Traditional Hearse']?.value ?? false,
        "horseDrawnHearse": funeralVehicles['Horse-Drawn Hearse']?.value ?? false,
        "limousine": funeralVehicles['Limousine (Family Car)']?.value ?? false,
        "alternativeVehicle": false,
        "otherVehicleType": funeralVehicles['Alternative Vehicle (Motorcycle, Vintage, Other)']?.value ?? false,
        "otherVehicleDescription": otherVehicleController.text.trim()
      },
      "funeralPackageOptions": {
        "standard": 0,
        "vipExecutive": 0
      },
      "booking_availability_date_from": calendarController.fromDate.value.toIso8601String(),
      "booking_availability_date_to": calendarController.toDate.value.toIso8601String(),
      "businessProfile": {
        "businessHighlights": "",
        "promotionalDescription": promoDescriptionController.text.trim()
      },
      "serviceImages": serviceImages
          .where((img) => img.isUploaded && img.uploadUrl != null)
          .map((img) => img.uploadUrl!)
          .toList(),
    };
  }

  void _showSubmissionProgress() {
    Get.dialog(
      const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: AppColors.btnColor),
                SizedBox(height: 16),
                Text('Submitting your funeral car hire service...'),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _showSubmissionSuccess() {
    Get.snackbar(
      'Success!',
      'Your funeral car hire service has been submitted successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.success,
      colorText: AppColors.white,
      icon: const Icon(Icons.check_circle, color: AppColors.white),
      duration: const Duration(seconds: 3),
    );
  }

  void _showSubmissionError(String message) {
    Get.snackbar(
      'Submission Failed',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error,
      colorText: AppColors.white,
      icon: const Icon(Icons.error, color: AppColors.white),
      duration: const Duration(seconds: 5),
    );
  }

  // (Add further validation and submission routines as in LimousineHireService...)

  @override
  void onClose() {
    listingTitleController.dispose();
    baseLocationController.dispose();
    makeModelController.dispose();
    numberOfSeatsController.dispose();
    dayRateController.dispose();
    hourlyRateController.dispose();
    halfDayRateController.dispose();
    mileageLimitController.dispose();
    extraMileageChargeController.dispose();
    serviceRadiusController.dispose();
    searchCitiesController.dispose();
    uniqueServiceController.dispose();
    promoDescriptionController.dispose();
    otherVehicleController.dispose();
    super.onClose();
  }
}

// FuneralCarHireService main widget—same UI blocks as LimousineHireService, just adapted to different fields.
class FuneralCarHireService extends StatelessWidget {
  final FuneralCarHireController controller =
      Get.put(FuneralCarHireController());
  final Rxn<String> category;
  final Rxn<String> subCategory;
  final String? categoryId;
  final String? subCategoryId;

  FuneralCarHireService(
      {super.key,
      required this.category,
      required this.subCategory,
      this.categoryId,
      this.subCategoryId});

  @override
  Widget build(BuildContext context) {
    // Custom categoryId/subcategoryId if required
    if (categoryId != null) controller.categoryId = categoryId!;
    if (subCategoryId != null) controller.subcategoryId = subCategoryId!;

    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        title:   Text(
          'Funeral Car Hire Service',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            height: 1,
            color: AppColors.grey200,
          ),
        ),
      ),
      body: Column(
        children: [
          Obx(() => ProfessionalProgressBar(  
                currentStep: controller.currentStep.value,
                totalSteps: controller.totalSteps,
                stepTitle:
                    controller.getStepTitle(controller.currentStep.value),
              )),
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
                  // Main Form Content (see LimousineHireService for widget structure)
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
            text: controller.currentStep.value == controller.totalSteps
                ? 'Submit Service'
                : 'Next',
            onPressed: controller.isLoading.value ||
                    controller.isNavigating.value
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
    if (controller.currentStep.value == controller.totalSteps) {
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

  // Implement _getStepWidget as per your LimousineHireService, swapping in FuneralCar fields as described.

  Widget _getStepWidget(BuildContext context) {
    switch (controller.currentStep.value) {
      case 1:
        return _buildStep1(context); // Required Documents
      case 2:
        return _buildStep2(context); // Listing Details
      case 3:
        return _buildStep3(context); // Vehicle Information
      case 4:
        return _buildStep4(context); // Pricing Details
      case 5:
        return _buildStep5(context); // Coverage & Service Status
      case 6:
        return _buildStep6(context); // Service Availability
      case 7:
        return _buildStep7(context); // Features & Services
      case 8:
        return _buildStep8(context); // Photos & Media
      case 9:
        return _buildStep9(context); // Coupon Management
      case 10:
        return _buildStep10(context); // Terms & Submit
      default:
        return _buildStep1(context);
    }
  }

  // Step 1: Required Documents
  Widget _buildStep1(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Required Documents',
            'Upload essential documents for your funeral car hire service'),
        const SizedBox(height: 24),

        // Required Documents Section
        Text(
          '2 required',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.error,
          ),
        ),
        const SizedBox(height: 16),

        _buildDocumentUploadSection(
          'Operator Licence*',
          controller.operatorLicenceDocs,
          isRequired: true,
        ),
        const SizedBox(height: 24),

        _buildDocumentUploadSection(
          'Insurance Certificate*',
          controller.insuranceCertificateDocs,
          isRequired: true,
        ),
        const SizedBox(height: 32),

        // Optional Documents Section
        Text(
          'Optional Documents',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.grey800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '2 optional',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.grey600,
          ),
        ),
        const SizedBox(height: 16),

        _buildDocumentUploadSection(
          'Driver Licences And D B S',
          controller.driverLicenceDBSDocs,
          isRequired: false,
        ),
        const SizedBox(height: 24),

        _buildDocumentUploadSection(
          'Vehicle M O Ts',
          controller.vehicleMOTDocs,
          isRequired: false,
        ),
      ],
    );
  }

  // Step 2: Listing Details
  Widget _buildStep2(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Listing Details',
            'Basic information about your funeral car hire service'),
        const SizedBox(height: 24),
        ProfessionalInput(
          label: 'Listing Title',
          controller: controller.listingTitleController,
          hintText: 'Enter your service listing title',
          isRequired: true,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Listing title is required';
            }
            if (value.trim().length < 3) {
              return 'Title must be at least 3 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Base Location",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 8),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Vehicle Information',
            'Details about your funeral vehicle'),
        const SizedBox(height: 24),
        ProfessionalInput(
          label: 'Make & Model',
          controller: controller.makeModelController,
          hintText: 'e.g., Mercedes-Benz E-Class Hearse',
          isRequired: true,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Make and model is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        ProfessionalInput(
          label: 'Number of Seats',
          controller: controller.numberOfSeatsController,
          hintText: 'Enter number of passenger seats',
          isRequired: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Number of seats is required';
            }
            final seats = int.tryParse(value.trim()) ?? 0;
            if (seats < 1 || seats > 20) {
              return 'Number of seats must be between 1 and 20';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        _buildDateField(
            context, 'First Registered', controller.firstRegisteredDate,
            allowFutureDates: false),
      ],
    );
  }

  // Step 4: Pricing Details
  Widget _buildStep4(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Pricing Details',
            'Set your rates for funeral car hire services'),
        const SizedBox(height: 24),
        ProfessionalInput(
          label: 'Day Rate (£)',
          controller: controller.dayRateController,
          hintText: 'Enter full day rate',
          isRequired: true,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Day rate is required';
            }
            final rate = double.tryParse(value.trim()) ?? 0;
            if (rate <= 0) {
              return 'Day rate must be greater than 0';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        ProfessionalInput(
          label: 'Hourly Rate (£)',
          controller: controller.hourlyRateController,
          hintText: 'Enter hourly rate',
          isRequired: true,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Hourly rate is required';
            }
            final rate = double.tryParse(value.trim()) ?? 0;
            if (rate <= 0) {
              return 'Hourly rate must be greater than 0';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        ProfessionalInput(
          label: 'Half Day Rate (£)',
          controller: controller.halfDayRateController,
          hintText: 'Enter half day rate',
          isRequired: true,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Half day rate is required';
            }
            final rate = double.tryParse(value.trim()) ?? 0;
            if (rate <= 0) {
              return 'Half day rate must be greater than 0';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        ProfessionalInput(
          label: 'Mileage Limit',
          controller: controller.mileageLimitController,
          hintText: 'Enter mileage limit per day',
          isRequired: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Mileage limit is required';
            }
            final limit = int.tryParse(value.trim()) ?? 0;
            if (limit <= 0) {
              return 'Mileage limit must be greater than 0';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        ProfessionalInput(
          label: 'Extra Mileage Charge (£/mile)',
          controller: controller.extraMileageChargeController,
          hintText: 'Enter charge per extra mile',
          isRequired: true,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Extra mileage charge is required';
            }
            final charge = double.tryParse(value.trim()) ?? 0;
            if (charge < 0) {
              return 'Extra mileage charge cannot be negative';
            }
            return null;
          },
        ),
      ],
    );
  }

  // Step 5: Coverage & Service Status
  Widget _buildStep5(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Coverage & Service Status',
            'Define your service area and availability status'),
        const SizedBox(height: 24),

        // Service Coverage Areas
        Text(
          'Service Coverage Areas',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.grey800,
          ),
        ),
        const SizedBox(height: 16),

        _buildAreasSelection(context),
        const SizedBox(height: 24),

        ProfessionalInput(
          label: 'Service Radius (miles)',
          controller: controller.serviceRadiusController,
          hintText:
              'How far from your base location are you willing to travel? (Range: 1-500 miles)',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value != null && value.trim().isNotEmpty) {
              final radius = int.tryParse(value.trim()) ?? 0;
              if (radius < 1 || radius > 500) {
                return 'Service radius must be between 1 and 500 miles';
              }
            }
            return null;
          },
        ),
        const SizedBox(height: 20),

        ProfessionalDropdown(
          label: 'Service Status',
          value: controller.selectedServiceStatus.value,
          items: controller.serviceStatusOptions,
          onChanged: (value) => controller.selectedServiceStatus.value = value!,
          isRequired: true,
        ),
        const SizedBox(height: 8),
        Text(
          'Set to "Open" to accept new bookings, or "Closed" to temporarily stop accepting bookings.',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.grey600,
          ),
        ),
      ],
    );
  }

  // Step 6: Service Availability
  Widget _buildStep6(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Service Availability',
            'Set your availability dates and cancellation policy'),
        const SizedBox(height: 24),

        _buildDateField(
            context, 'Available From', controller.calendarController.fromDate),
        const SizedBox(height: 16),
        _buildDateField(
            context, 'Available To', controller.calendarController.toDate),
        const SizedBox(height: 8),
        Text(
          'Must be after the start date',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.grey600,
          ),
        ),
        const SizedBox(height: 24),

        ProfessionalDropdown(
          label: 'Cancellation Policy',
          value: controller.selectedCancellationPolicy.value,
          items: controller.cancellationPolicies,
          onChanged: (value) =>
              controller.selectedCancellationPolicy.value = value!,
          isRequired: true,
        ),
        const SizedBox(height: 32),

        // Special Pricing Calendar
        const Text(
          'Special Pricing Calendar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Set special prices for specific dates (holidays, peak seasons, events). These will override your standard rates.',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 16),

        // Calendar Widget
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
                  (selectedDay.isAfter(availableFromDate) &&
                      selectedDay.isBefore(availableToDate))) {
                _showSetPriceDialog(selectedDay);
              }
            },
            focusedDay: focusedDay,
            firstDay: availableFromDate, // Link to Available From date
            lastDay: availableToDate, // Link to Available To date
            calendarFormat: CalendarFormat.month,
            availableGestures: AvailableGestures.none,
            headerStyle: const HeaderStyle(formatButtonVisible: false),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                // Check if day is within the available date range (inclusive)
                bool isWithinRange = day.isAtSameMomentAs(availableFromDate) ||
                    day.isAtSameMomentAs(availableToDate) ||
                    (day.isAfter(availableFromDate) &&
                        day.isBefore(availableToDate));

                if (isWithinRange) {
                  return _buildCalendarCell(day, true);
                }
                return _buildCalendarCell(day, false);
              },
            ),
          );
        }),
        const SizedBox(height: 20),

        // Special Prices Summary
        const Text(
          'Special Prices Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: Obx(() {
            if (controller.calendarController.specialPrices.isEmpty) {
              return const Center(
                child: Text(
                  'No special prices set yet',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.calendarController.specialPrices.length,
              itemBuilder: (context, index) {
                final entry = controller.calendarController.specialPrices[index];
                final date = entry['date'] as DateTime;
                final price = entry['price'] as double;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('EEE, d MMM yyyy').format(date),
                        style: const TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          Text(
                            '£${price.toStringAsFixed(2)}/day',
                            style: TextStyle(
                              fontSize: 16,
                              color: price > 0 ? Colors.black : Colors.red,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => controller.calendarController
                                .deleteSpecialPrice(date),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  // Step 7: Features & Services
  Widget _buildStep7(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(
            context, 'Features & Services', 'Service details and offerings'),
        const SizedBox(height: 24),

        Text(
          'Service Details & Offerings',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.grey800,
          ),
        ),
        const SizedBox(height: 16),

        // Type of Funeral Vehicle Offered
        Text(
          'Type of Funeral Vehicle Offered (tick all that apply) *',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.grey700,
          ),
        ),
        const SizedBox(height: 12),

        ...controller.funeralVehicles.entries.map((entry) {
          return Obx(() => CheckboxListTile(
                title: Text(entry.key),
                value: entry.value.value,
                onChanged: (bool? value) {
                  entry.value.value = value ?? false;
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ));
        }).toList(),

        // Other vehicle option
        Obx(() {
          if (controller
                  .funeralVehicles[
                      'Alternative Vehicle (Motorcycle, Vintage, Other)']
                  ?.value ==
              true) {
            return Padding(
              padding: const EdgeInsets.only(left: 32, top: 8),
              child: ProfessionalInput(
                label: 'Other',
                controller: controller.otherVehicleController,
                hintText: 'Specify other vehicle type',
              ),
            );
          }
          return const SizedBox.shrink();
        }),

        const SizedBox(height: 24),

        // Availability
        Text(
          'Availability *',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.grey700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Select availability',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.grey600,
          ),
        ),
        const SizedBox(height: 12),

        ...controller.funeralAvailability.entries.map((entry) {
          return Obx(() => CheckboxListTile(
                title: Text(entry.key),
                value: entry.value.value,
                onChanged: (bool? value) {
                  entry.value.value = value ?? false;
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ));
        }).toList(),

        const SizedBox(height: 24),

        // Funeral Service Type
        ProfessionalDropdown(
          label: 'Funeral Service Type',
          value: controller.selectedFuneralServiceType.value,
          items: controller.funeralServiceTypes,
          onChanged: (value) =>
              controller.selectedFuneralServiceType.value = value!,
          isRequired: true,
        ),
        const SizedBox(height: 20),

        ProfessionalInput(
          label: 'What makes your service unique or premium?',
          controller: controller.uniqueServiceController,
          hintText: 'Describe what sets your service apart',
          isRequired: true,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please describe what makes your service unique';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),

        ProfessionalInput(
          label: 'Promotional Description (max 100 words)',
          controller: controller.promoDescriptionController,
          hintText: 'Brief promotional description of your service',
          isRequired: true,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Promotional description is required';
            }
            final wordCount = value.trim().split(RegExp(r'\s+')).length;
            if (wordCount > 100) {
              return 'Description must be 100 words or less';
            }
            return null;
          },
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
            'Upload high-quality images of your funeral vehicle'),

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
          'Upload high-quality images of your funeral vehicle. Show exterior, interior, and key features.',
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
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.grey800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.grey600,
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentUploadSection(
      String title, RxList<DocumentFile> documents,
      {bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.grey800,
              ),
            ),
            if (isRequired) ...[
              const SizedBox(width: 4),
              Text(
                '*',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.error,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Accepted formats: JPG, PNG, PDF | Max 5MB',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.grey600,
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (documents.isNotEmpty) {
            return Column(
              children: [
                Text(
                  'Uploaded',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(height: 8),
                ...documents.asMap().entries.map((entry) {
                  int index = entry.key;
                  DocumentFile doc = entry.value;
                  return _buildDocumentChip(
                      doc, () => controller.removeDocument(documents, index));
                }).toList(),
                const SizedBox(height: 8),
              ],
            );
          }
          return const SizedBox.shrink();
        }),
        GestureDetector(
          onTap: () => controller.pickDocument(documents),
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(8),
            dashPattern: const [6, 3],
            color: AppColors.grey400,
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.grey50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 32,
                    color: AppColors.grey500,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Upload Document',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Click to browse or drag and drop your file',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grey500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Supports: JPG, PNG, PDF • Maximum size: 5MB',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grey500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentChip(DocumentFile doc, VoidCallback onRemove) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.success.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            _getFileIcon(doc.type),
            color: AppColors.success,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey800,
                  ),
                ),
                Text(
                  '${doc.type.toUpperCase()} File • Uploaded ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.grey600,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onRemove,
            child: Text(
              'Remove',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(BuildContext context, String label, Rx<DateTime> date,
      {bool allowFutureDates = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.grey700,
              ),
            ),
            Text(
              ' *',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.error,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Obx(() => GestureDetector(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: date.value,
                  firstDate: allowFutureDates ? DateTime.now() : DateTime(1950),
                  lastDate: allowFutureDates ? DateTime(2100) : DateTime.now(),
                );
                if (picked != null && picked != date.value) {
                  date.value = picked;
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey300),
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.white,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: AppColors.grey600,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      DateFormat('dd/MM/yyyy').format(date.value),
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.grey800,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.grey600,
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildAreasSelection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: controller.searchCitiesController,
                  decoration: InputDecoration(
                    hintText: 'Search cities...',
                    prefixIcon: Icon(Icons.search, color: AppColors.grey500),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: controller.selectAllAreas,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Select All'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: controller.clearAllAreas,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.grey300,
                foregroundColor: AppColors.grey700,
              ),
              child: const Text('Clear All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Obx(() => ListView.builder(
                itemCount: controller.filteredCities.length,
                itemBuilder: (context, index) {
                  final city = controller.filteredCities[index];
                  return _buildCityCheckbox(context, city);
                },
              )),
        ),
        const SizedBox(height: 8),
        Obx(() => Text(
              'Selected: ${controller.selectedAreas.length} areas',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey600,
              ),
            )),
      ],
    );
  }

  Widget _buildCityCheckbox(BuildContext context, String city) {
    return Obx(() => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.grey200),
            ),
          ),
          child: CheckboxListTile(
            title: Text(city),
            value: controller.selectedAreas.contains(city),
            onChanged: (bool? value) {
              controller.toggleArea(city);
            },
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
          ),
        ));
  }

  Widget _buildSelectedImagesGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          if (controller.serviceImages.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.grey50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.grey300),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.photo_library_outlined,
                      size: 48,
                      color: AppColors.grey400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No images uploaded yet',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.grey600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Upload at least 3 high-quality images of your funeral vehicles',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: controller.serviceImages.length,
            itemBuilder: (context, index) {
              final image = controller.serviceImages[index];
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.grey300),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(image.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => controller.removeDocument(
                          controller.serviceImages, index),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildTermsCheckbox(BuildContext context, String title, RxBool value,
      Function(bool?) onChanged,
      {String? policyUrl}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CheckboxListTile(
        title: policyUrl != null
            ? _buildClickableTitle(title, policyUrl)
            : Text(
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

  Widget _buildClickableTitle(String title, String url) {
    // Extract the policy name from the title (e.g., "Cookies Policy" from "I agree to the Cookies Policy")
    final policyRegex = RegExp(r'I agree to the (.+?)(?:\s|$)');
    final match = policyRegex.firstMatch(title);

    if (match != null && match.groupCount >= 1) {
      final beforePolicy =
          title.substring(0, match.start + 14); // "I agree to the "
      final policyName = match.group(1)!;
      final afterPolicy = title.substring(match.end - 1); // remaining text

      return RichText(
        text: TextSpan(
          style: const TextStyle(
              fontSize: 13, color: AppColors.grey900, height: 1.3),
          children: [
            TextSpan(text: beforePolicy),
            WidgetSpan(
              child: GestureDetector(
                onTap: () => _launchURL(url),
                child: Text(
                  policyName,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.btnColor,
                    decoration: TextDecoration.underline,
                    height: 1.3,
                  ),
                ),
              ),
            ),
            TextSpan(text: afterPolicy),
          ],
        ),
      );
    }

    // Fallback to regular text if regex doesn't match
    return Text(
      title,
      style:
          const TextStyle(fontSize: 13, color: AppColors.grey900, height: 1.3),
    );
  }

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
                controller.calendarController.setSpecialPrice(selectedDay, price);
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

  // Calendar cell builder
  Widget _buildCalendarCell(DateTime day, bool isVisible) {
    final specialPrice = controller.calendarController.specialPrices
        .where((entry) =>
            DateFormat('yyyy-MM-dd').format(entry['date'] as DateTime) ==
            DateFormat('yyyy-MM-dd').format(day))
        .map((entry) => entry['price'] as double?)
        .firstOrNull;

    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: isVisible
            ? (specialPrice != null
                ? Colors.green.shade100
                : Colors.blue.shade100)
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

  IconData _getFileIcon(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      default:
        return Icons.attach_file;
    }
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
    final progress = currentStep / totalSteps;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step $currentStep of $totalSteps',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey600,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}% Complete',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.grey200,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.blue),
          ),
          const SizedBox(height: 12),
          Text(
            stepTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.grey800,
            ),
          ),
        ],
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
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.grey700,
              ),
            ),
            if (isRequired) ...[
              const SizedBox(width: 4),
              Text(
                ' *',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.error,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.grey300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.grey300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.blue),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.grey700,
              ),
            ),
            if (isRequired) ...[
              const SizedBox(width: 4),
              Text(
                ' *',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.error,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: items.contains(value) ? value : null,
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
              borderSide: BorderSide(color: AppColors.grey300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.grey300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.blue),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
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
      width: width,
      height: height,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.blue),
                      ),
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blue,
                      ),
                    ),
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
    );
  }
}
