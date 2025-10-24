import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
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
import 'package:file_picker/file_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

// Document Model
class DocumentFile {
  final String path;
  final String name;
  final String type; // pdf, jpg, png
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
    if (size < 1024) return '${size}B';
    if (size < 1048576) return '${(size / 1024).toStringAsFixed(1)}KB';
    return '${(size / 1048576).toStringAsFixed(1)}MB';
  }

  bool get isValidSize => size <= 5 * 1024 * 1024; // 5MB limit
}

// CHAUFFEUR HIRE CONTROLLER
class ChauffeurHireController extends GetxController {
  // Observable states
  var currentStep = 1.obs;
  var isLoading = false.obs;
  var isNavigating = false.obs;
  var isSubmitting = false.obs;
  var completedSteps = <int>[].obs;

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text controllers
  final TextEditingController listingTitleController = TextEditingController();
  final TextEditingController makeModelController = TextEditingController();
  final TextEditingController numberOfSeatsController = TextEditingController();
  final TextEditingController luggageCapacityController = TextEditingController();
  final TextEditingController basePostcodeController = TextEditingController();
  final TextEditingController locationRadiusController = TextEditingController();
  final TextEditingController mileageRadiusController = TextEditingController();
  final TextEditingController searchCitiesController = TextEditingController();

  // Pricing Controllers - Matching your fields exactly
  final TextEditingController fullDayRateController = TextEditingController();
  final TextEditingController halfDayRateController = TextEditingController();
  final TextEditingController hourlyRateController = TextEditingController();
  final TextEditingController mileageLimitController = TextEditingController(text: '100');
  final TextEditingController weddingPackageController = TextEditingController();
  final TextEditingController airportTransferController = TextEditingController();
  final TextEditingController depositController = TextEditingController();
  final TextEditingController waitingChargesController = TextEditingController();
  final TextEditingController extraMileageChargeController = TextEditingController();

  // Event Extra Price Controllers
  final TextEditingController weddingDecorPriceController = TextEditingController();
  final TextEditingController champagnePackagesPriceController = TextEditingController();
  final TextEditingController partyLightingPriceController = TextEditingController();
  final TextEditingController photographyPackagesPriceController = TextEditingController();

  // Accessibility Controllers
  final TextEditingController wheelchairAccessPriceController = TextEditingController();
  final TextEditingController petFriendlyPriceController = TextEditingController();
  final TextEditingController childCarSeatsPriceController = TextEditingController();
  final TextEditingController disabledAccessRampPriceController = TextEditingController();
  final TextEditingController seniorAssistancePriceController = TextEditingController();
  final TextEditingController strollerStoragePriceController = TextEditingController();

  // Other controllers
  final TextEditingController otherFeatureController = TextEditingController();
  final TextEditingController complimentaryDrinksDetailsController = TextEditingController();

  // Observable selections
  var selectedServiceStatus = 'open'.obs;
  var selectedCancellationPolicy = 'FLEXIBLE'.obs;
  var firstRegistrationDate = DateTime.now().obs;

  // Category and subcategory IDs for chauffeur service
  String categoryId = '676ac544234968d45b494992'; // Your actual chauffeur category ObjectId
  String subcategoryId = '676ace13234968d45b4949db'; // Your actual chauffeur subcategory ObjectId

  // Document storage for API
  RxList<DocumentFile> operatorLicenceDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> publicLiabilityDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> vehicleInsuranceDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> v5cLogbookDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> chauffeurLicenceDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> serviceImages = <DocumentFile>[].obs;

  // Areas management
  RxList<String> selectedAreas = <String>[].obs;
  RxList<String> filteredCities = <String>[].obs;

  // Occasions Features - matching your payload
  var occasions = {
    'weddings': false,
    'airportTransfers': false,
    'vipRedCarpet': false,
    'corporateTravel': false,
    'proms': false,
    'filmTvHire': false,
    'other': false,
  }.obs;

  // Comfort Features - matching your payload
  var comfortFeatures = {
    'leatherInterior': false,
    'wifiAccess': false,
    'airConditioning': false,
    'inCarEntertainment': false,
    'bluetoothUsb': false,
    'redCarpetService': false,
    'onboardRestroom': false,
    'chauffeurInUniform': false,
  }.obs;

  var complimentaryDrinksAvailable = false.obs;

  // Events Features - matching your payload
  var eventsFeatures = {
    'weddingDecor': false,
    'champagnePackages': false,
    'partyLighting': false,
    'photographyPackages': false,
  }.obs;

  // Accessibility Features - matching your payload
  var accessibilityFeatures = {
    'wheelchairAccessVehicle': false,
    'childCarSeats': false,
    'petFriendlyService': false,
    'disabledAccessRamp': false,
    'seniorFriendlyAssistance': false,
    'strollerBuggyStorage': false,
  }.obs;

  // Security Features - matching your payload
  var securityFeatures = {
    'vehicleTrackingGps': false,
    'cctvFitted': false,
    'publicLiabilityInsurance': false,
    'safetyCertifiedDrivers': false,
    'dbsChecked': false,
  }.obs;

  // Pricing booleans
  var fuelIncluded = true.obs;
  var waitingChargesEnabled = false.obs;

  // Terms
  var isAccurateInfo = false.obs;
  var noContactDetailsShared = false.obs;
  var agreeCookiesPolicy = false.obs;
  var agreePrivacyPolicy = false.obs;
  var agreeCancellationPolicy = false.obs;

  // Static data
  final List<String> serviceStatusOptions = ['open', 'close'];
  final List<String> cancellationPolicyOptions = ['FLEXIBLE', 'MODERATE', 'STRICT'];

  // Service controllers
  final ImageController imageController = Get.put(ImageController());
  final CouponController couponController = Get.put(CouponController());
  final CalendarController calendarController = Get.put(CalendarController());

  // Vendor info
  String? vendorId;

  @override
  void onInit() {
    super.onInit();
    initializeData();
    setupListeners();
    loadVendorId();
  }

  void initializeData() {
    filteredCities.value = Cities.ukCities;
    
    // Initialize calendar dates
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (calendarController.fromDate.value.isBefore(DateTime.now())) {
        calendarController.fromDate.value = DateTime.now();
      }
      if (calendarController.toDate.value.isBefore(DateTime.now())) {
        calendarController.toDate.value = DateTime.now().add(const Duration(days: 7));
      }
    });
  }

  void setupListeners() {
    searchCitiesController.addListener(filterCities);
    hourlyRateController.addListener(() {
      calendarController.setDefaultPrice(double.tryParse(hourlyRateController.text) ?? 0.0);
    });
  }

  Future<void> loadVendorId() async {
    vendorId = await SessionVendorSideManager().getVendorId();
  }

  void filterCities() {
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
      if (await validateCurrentStep()) {
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
  Future<bool> validateCurrentStep() async {
    switch (currentStep.value) {
      case 1:
        return await validateStep1(); // Documents
      case 2:
        return await validateStep2(); // Listing Details
      case 3:
        return await validateStep3(); // Vehicle Info
      case 4:
        return await validateStep4(); // Pricing Details
      case 5:
        return await validateStep5(); // Coverage Areas
      case 6:
        return await validateStep6(); // Service Availability
      case 7:
        return true; // Features - optional
      case 8:
        return await validateStep8(); // Photos Media
      case 9:
        return true; // Coupon management - optional
      case 10:
        return await validateStep10(); // Terms
      default:
        return true;
    }
  }

  Future<bool> validateStep1() async {
    if (operatorLicenceDocs.isEmpty) {
      showError('Operator Licence document is required');
      return false;
    }
    if (publicLiabilityDocs.isEmpty) {
      showError('Public Liability Insurance document is required');
      return false;
    }
    return true;
  }

  Future<bool> validateStep2() async {
    if (listingTitleController.text.trim().isEmpty) {
      showError('Please enter a listing title');
      return false;
    }
    if (listingTitleController.text.trim().length < 3) {
      showError('Title must be at least 3 characters');
      return false;
    }
    return true;
  }

  Future<bool> validateStep3() async {
    if (makeModelController.text.trim().isEmpty ||
        numberOfSeatsController.text.trim().isEmpty ||
        luggageCapacityController.text.trim().isEmpty) {
      showError('All vehicle information fields are required');
      return false;
    }
    final seats = int.tryParse(numberOfSeatsController.text.trim()) ?? 0;
    if (seats < 1 || seats > 50) {
      showError('Number of seats must be between 1 and 50');
      return false;
    }
    return true;
  }

  Future<bool> validateStep4() async {
    final fullDayRate = double.tryParse(fullDayRateController.text.trim()) ?? 0;
    final hourlyRate = double.tryParse(hourlyRateController.text.trim()) ?? 0;
    final halfDayRate = double.tryParse(halfDayRateController.text.trim()) ?? 0;

    // API requires dayRate (fullDayRate) to be provided
    if (fullDayRate <= 0) {
      showError('Full Day Rate is required');
      return false;
    }
    
    if (fullDayRate <= 0 && hourlyRate <= 0 && halfDayRate <= 0) {
      showError('At least one pricing field is required');
      return false;
    }
    return true;
  }

  Future<bool> validateStep5() async {
    if (basePostcodeController.text.trim().isEmpty) {
      showError('Please enter base postcode');
      return false;
    }
    return true;
  }

  Future<bool> validateStep6() async {
    // Validate required fields for service availability
    if (selectedServiceStatus.value.isEmpty) {
      showError('Please select service status');
      return false;
    }
    if (selectedCancellationPolicy.value.isEmpty) {
      showError('Please select cancellation policy');
      return false;
    }
    if (calendarController.fromDate.value.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      showError('Available from date cannot be in the past');
      return false;
    }
    if (calendarController.toDate.value.isBefore(calendarController.fromDate.value)) {
      showError('Available to date must be after from date');
      return false;
    }
    return true;
  }

  Future<bool> validateStep8() async {
    if (serviceImages.length < 3) {
      showError('Minimum 3 high-quality service images are required');
      return false;
    }
    return true;
  }

  Future<bool> validateStep10() async {
    if (!isAccurateInfo.value ||
        !noContactDetailsShared.value ||
        !agreeCookiesPolicy.value ||
        !agreePrivacyPolicy.value ||
        !agreeCancellationPolicy.value) {
      showError('Please agree to all terms and conditions to continue');
      return false;
    }
    return true;
  }

  void showError(String message) {
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
  Future<void> pickDocument(RxList<DocumentFile> documentList, String? docType) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        final file = result.files.single;
        final filePath = file.path!;
        final fileSize = file.size;

        if (fileSize > 5 * 1024 * 1024) { // 5MB limit
          showError('File size must be less than 5MB');
          return;
        }

        final document = DocumentFile(
          path: filePath,
          name: file.name,
          type: file.extension?.toLowerCase() ?? '',
          size: fileSize,
        );

        documentList.add(document);

        Get.snackbar(
          'Success',
          'Document uploaded successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.success,
          colorText: AppColors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      showError('Failed to pick document: $e');
    }
  }

  void removeDocument(RxList<DocumentFile> documentList, int index) {
    if (index < documentList.length) {
      documentList.removeAt(index);
    }
  }

  // Form submission with EXACT API payload structure
  Future<void> submitForm() async {
    if (!await validateStep10()) return;

    isSubmitting.value = true;

    try {
      showSubmissionProgress();

      try {
        // Upload all documents first
        await uploadAllDocuments();

        // Prepare API data with EXACT payload structure
        final formData = await prepareAPIPayload();

        // Submit to API
        final api = AddVendorServiceApi();
        final isAdded = await api.addServiceVendor(formData, 'chauffeur');

        // Close progress dialog before showing result
        if (Get.isDialogOpen == true) {
          Get.back();
        }

        if (isAdded) {
          showSubmissionSuccess();
          await Future.delayed(const Duration(seconds: 2));
          Get.offAllNamed(VendorRoutesName.mainDashboard);
        } else {
          showSubmissionError('Failed to submit service. Please try again.');
        }
      } catch (e) {
        // Close progress dialog on any error
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        showSubmissionError(e.toString());
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

  Future<void> uploadAllDocuments() async {
    // Upload all document types
    await uploadDocumentList(operatorLicenceDocs);
    await uploadDocumentList(publicLiabilityDocs);
    await uploadDocumentList(vehicleInsuranceDocs);
    await uploadDocumentList(v5cLogbookDocs);
    await uploadDocumentList(chauffeurLicenceDocs);
    await uploadDocumentList(serviceImages);
  }

  Future<void> uploadDocumentList(RxList<DocumentFile> documents) async {
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

  Future<Map<String, dynamic>> prepareAPIPayload() async {
    return {
      'vendorId': vendorId ?? '68eb757c758ef700653aada8',
      'listingTitle': listingTitleController.text.trim(),
      'baseLocationPostcode': basePostcodeController.text.trim(),
      'locationRadius': int.tryParse(locationRadiusController.text.trim()) ?? 50,
      'areasCovered': selectedAreas.toList(),
      'fleetInfo': {
        'makeAndModel': makeModelController.text.trim(),
        'seats': int.tryParse(numberOfSeatsController.text.trim()) ?? 4,
        'luggageCapacity': int.tryParse(luggageCapacityController.text.trim()) ?? 2,
        'firstRegistration': firstRegistrationDate.value.toIso8601String(),
      },
      'pricingDetails': {
        'dayRate': double.tryParse(fullDayRateController.text.trim()) ?? 0,
        'fullDayRate': double.tryParse(fullDayRateController.text.trim()) ?? 0,
        'halfDayRate': double.tryParse(halfDayRateController.text.trim()) ?? 0,
        'hourlyRate': double.tryParse(hourlyRateController.text.trim()) ?? 0,
        'mileageLimit': int.tryParse(mileageLimitController.text.trim()) ?? 100,
        'weddingPackage': double.tryParse(weddingPackageController.text.trim()) ?? 0,
        'airportTransfer': double.tryParse(airportTransferController.text.trim()) ?? 0,
        'deposit': double.tryParse(depositController.text.trim()) ?? 0,
        'fuelIncluded': fuelIncluded.value,
        'waitingChargesEnabled': waitingChargesEnabled.value,
        'waitingCharges': double.tryParse(waitingChargesController.text.trim()) ?? 0,
        'extraMileageCharge': double.tryParse(extraMileageChargeController.text.trim()) ?? 0,
      },
      'occasions': occasions,
      'comfort': comfortFeatures.map((key, value) => MapEntry(key, value)),
      'events': eventsFeatures.map((key, value) => MapEntry(key, value)),
      'accessibility': accessibilityFeatures.map((key, value) => MapEntry(key, value)),
      'security': securityFeatures.map((key, value) => MapEntry(key, value)),
      'service_status': selectedServiceStatus.value,
      'booking_date_from': calendarController.fromDate.value.toIso8601String(),
      'booking_date_to': calendarController.toDate.value.toIso8601String(),
      'special_price_days': calendarController.specialPrices
          .map((e) => {
                'date': DateFormat('yyyy-MM-dd').format(e['date'] as DateTime),
                'price': e['price'] as double? ?? 0
              })
          .toList(),
      'cancellation_policy_type': selectedCancellationPolicy.value,
      'documents': {
        'operatorLicence': {
          'isAttached': operatorLicenceDocs.isNotEmpty,
          'image': operatorLicenceDocs.isNotEmpty ? operatorLicenceDocs.first.uploadUrl ?? '' : '',
          'fileName': operatorLicenceDocs.isNotEmpty ? operatorLicenceDocs.first.name : '',
          'fileType': operatorLicenceDocs.isNotEmpty ? 'image/${operatorLicenceDocs.first.type}' : '',
          'uploadedAt': DateTime.now().toIso8601String(),
        },
        'publicLiabilityInsurance': {
          'isAttached': publicLiabilityDocs.isNotEmpty,
          'image': publicLiabilityDocs.isNotEmpty ? publicLiabilityDocs.first.uploadUrl ?? '' : '',
          'fileName': publicLiabilityDocs.isNotEmpty ? publicLiabilityDocs.first.name : '',
          'fileType': publicLiabilityDocs.isNotEmpty ? 'image/${publicLiabilityDocs.first.type}' : '',
          'uploadedAt': DateTime.now().toIso8601String(),
        },
        'vehicleInsurance': {
          'isAttached': vehicleInsuranceDocs.isNotEmpty,
          'image': vehicleInsuranceDocs.isNotEmpty ? vehicleInsuranceDocs.first.uploadUrl ?? '' : '',
          'fileName': vehicleInsuranceDocs.isNotEmpty ? vehicleInsuranceDocs.first.name : '',
          'fileType': vehicleInsuranceDocs.isNotEmpty ? 'image/${vehicleInsuranceDocs.first.type}' : '',
          'uploadedAt': DateTime.now().toIso8601String(),
        },
        'v5cLogbook': {
          'isAttached': v5cLogbookDocs.isNotEmpty,
          'image': v5cLogbookDocs.isNotEmpty ? v5cLogbookDocs.first.uploadUrl ?? '' : '',
          'fileName': v5cLogbookDocs.isNotEmpty ? v5cLogbookDocs.first.name : '',
          'fileType': v5cLogbookDocs.isNotEmpty ? 'image/${v5cLogbookDocs.first.type}' : '',
          'uploadedAt': DateTime.now().toIso8601String(),
        },
        'chauffeurLicence': {
          'isAttached': chauffeurLicenceDocs.isNotEmpty,
          'image': chauffeurLicenceDocs.isNotEmpty ? chauffeurLicenceDocs.first.uploadUrl ?? '' : '',
          'fileName': chauffeurLicenceDocs.isNotEmpty ? chauffeurLicenceDocs.first.name : '',
          'fileType': chauffeurLicenceDocs.isNotEmpty ? 'image/${chauffeurLicenceDocs.first.type}' : '',
          'uploadedAt': DateTime.now().toIso8601String(),
        },
      },
      'serviceimage': serviceImages
          .where((img) => img.isUploaded && img.uploadUrl != null)
          .map((img) => img.uploadUrl!)
          .toList(),
      'coupons': couponController.coupons.isNotEmpty
          ? couponController.coupons
              .where((coupon) => coupon['couponcode']?.toString().trim().isNotEmpty == true)
              .map((coupon) => {
                    'couponcode': coupon['couponcode']?.toString().trim() ?? '',
                    'discounttype': coupon['discounttype']?.toString().toUpperCase() ?? 'PERCENTAGE',
                    'discountvalue': coupon['discountvalue'] ?? 0,
                    'usagelimit': coupon['usagelimit'] ?? 1,
                    'expirydate': coupon['expirydate'] != null
                        ? DateFormat('yyyy-MM-dd').format(DateTime.parse(coupon['expirydate'].toString()))
                        : DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 30))),
                    'isglobal': coupon['isglobal'] ?? false,
                    'minimumdays': coupon['minimumdays'] ?? 1,
                    'minimumvehicles': coupon['minimumvehicles'] ?? 1,
                    'description': coupon['description'] ?? 'General promotional discount',
                  })
              .toList()
          : [],
      'category': 'PassengerTransport',
      'subcategory': 'Chauffeur Hire',
      'categoryId': categoryId,
      'subcategoryId': subcategoryId,
      'servicename': listingTitleController.text.trim(),
    };
  }

  void showSubmissionProgress() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.btnColor),
              ),
              const SizedBox(height: 20),
              const Text(
                'Submitting Your Chauffeur Service',
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

  void showSubmissionSuccess() {
    Get.snackbar(
      'Success!',
      'Your chauffeur service has been submitted successfully! Our team will review it and publish within 24 hours.',
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

  void showSubmissionError(String error) {
    Get.snackbar(
      'Submission Failed',
      'Failed to submit your service. Please try again. $error',
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
    selectedAreas.addAll(filteredCities.isNotEmpty ? filteredCities : Cities.ukCities);
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
      'Coverage & Location',
      'Service Availability',
      'Features & Extras',
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
    makeModelController.dispose();
    numberOfSeatsController.dispose();
    luggageCapacityController.dispose();
    basePostcodeController.dispose();
    locationRadiusController.dispose();
    mileageRadiusController.dispose();
    searchCitiesController.dispose();
    fullDayRateController.dispose();
    halfDayRateController.dispose();
    hourlyRateController.dispose();
    mileageLimitController.dispose();
    weddingPackageController.dispose();
    airportTransferController.dispose();
    depositController.dispose();
    waitingChargesController.dispose();
    extraMileageChargeController.dispose();
    otherFeatureController.dispose();
    complimentaryDrinksDetailsController.dispose();

    // Event Extra controllers
    weddingDecorPriceController.dispose();
    champagnePackagesPriceController.dispose();
    partyLightingPriceController.dispose();
    photographyPackagesPriceController.dispose();

    // Accessibility controllers
    wheelchairAccessPriceController.dispose();
    petFriendlyPriceController.dispose();
    childCarSeatsPriceController.dispose();
    disabledAccessRampPriceController.dispose();
    seniorAssistancePriceController.dispose();
    strollerStoragePriceController.dispose();

    super.onClose();
  }
}

// Professional Progress Bar Widget (Same as Boat Hire)
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
                    onTap: () => Get.back(),
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
                          'Chauffeur Hire Form',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey900,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Step $currentStep of $totalSteps • $stepTitle',
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
                            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.btnColor),
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

// Professional Input Widget (Same as Boat Hire)
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

// Professional Dropdown Widget (Same as Boat Hire)
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

// Professional Button Widget (Same as Boat Hire)
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

// Main Chauffeur Hire Service Widget
class ChauffeurHireService extends StatelessWidget {
  final ChauffeurHireController controller = Get.put(ChauffeurHireController());
  final Rxn<String> category;
  final Rxn<String> subCategory;
  final String? categoryId;
  final String? subCategoryId;

  ChauffeurHireService({
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
                stepTitle: controller.getStepTitle(controller.currentStep.value),
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
                          child: buildStepContent(context),
                        )),
                  ),

                  // Navigation Footer
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppColors.grey50,
                      border: Border(top: BorderSide(color: AppColors.grey200)),
                    ),
                    child: Obx(() => buildNavigationButtons(context)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavigationButtons(BuildContext context) {
    return Row(
      children: [
        // Previous Button
        if (controller.currentStep.value > 1) ...[
          Expanded(
            child: ProfessionalButton(
              text: 'Previous',
              onPressed: controller.isNavigating.value ? null : controller.previousStep,
              isOutlined: true,
            ),
          ),
          const SizedBox(width: 12),
        ],

        // Next/Submit Button
        Expanded(
          flex: 2,
          child: ProfessionalButton(
            text: controller.currentStep.value == 10 ? 'Submit Service' : 'Next',
            onPressed: controller.isLoading.value || controller.isNavigating.value
                ? null
                : handleNextAction,
            isLoading: controller.isLoading.value || controller.isNavigating.value,
          ),
        ),
      ],
    );
  }

  void handleNextAction() {
    if (controller.currentStep.value == 10) {
      controller.submitForm();
    } else {
      controller.nextStep();
    }
  }

  Widget buildStepContent(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Form(
        key: controller.formKey,
        child: getStepWidget(context),
      ),
    );
  }

  Widget getStepWidget(BuildContext context) {
    switch (controller.currentStep.value) {
      case 1:
        return buildStep1(context);
      case 2:
        return buildStep2(context);
      case 3:
        return buildStep3(context);
      case 4:
        return buildStep4(context);
      case 5:
        return buildStep5(context);
      case 6:
        return buildStep6(context);
      case 7:
        return buildStep7(context);
      case 8:
        return buildStep8(context);
      case 9:
        return buildStep9(context);
      case 10:
        return buildStep10(context);
      default:
        return buildStep1(context);
    }
  }

  // Step 1: Required Documents
  Widget buildStep1(BuildContext context) {
    return Column(
      key: const ValueKey('step1'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildStepHeader(context, 'Required Documents', 'Upload required documents to proceed'),

        // Required Documents Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.error.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.error.withOpacity(0.3)),
          ),
          child:const Row(
            children: [
               Icon(Icons.error_outline, color: AppColors.error, size: 20),
               SizedBox(width: 12),
               Expanded(
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

        buildDocumentUploadSection('Operator Licence', controller.operatorLicenceDocs, isRequired: true),

        const SizedBox(height: 20),

        buildDocumentUploadSection('Public Liability Insurance', controller.publicLiabilityDocs, isRequired: true),

        const SizedBox(height: 32),

        // Optional Documents Section
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

        buildDocumentUploadSection('Vehicle Insurance', controller.vehicleInsuranceDocs),

        const SizedBox(height: 20),

        buildDocumentUploadSection('V5C Logbook', controller.v5cLogbookDocs),

        const SizedBox(height: 20),

        buildDocumentUploadSection('Chauffeur Licence', controller.chauffeurLicenceDocs),
      ],
    );
  }

  // Step 2: Listing Details
  Widget buildStep2(BuildContext context) {
    return Column(
      key: const ValueKey('step2'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildStepHeader(context, 'Listing Details', 'Create an attractive listing for customers'),

        ProfessionalInput(
          label: 'Listing Title',
          controller: controller.listingTitleController,
          hintText: 'Example: Executive Chauffeur Driven Prestige Car Hire Service',
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
                  return city.toLowerCase().contains(textEditingValue.text.toLowerCase());
                }).take(5);
              },
              onSelected: (String selection) {
                controller.basePostcodeController.text = selection;
              },
              fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                // Initialize with current value
                if (textEditingController.text.isEmpty && controller.basePostcodeController.text.isNotEmpty) {
                  textEditingController.text = controller.basePostcodeController.text;
                }
                
                // Sync changes back to main controller
                textEditingController.addListener(() {
                  if (controller.basePostcodeController.text != textEditingController.text) {
                    controller.basePostcodeController.text = textEditingController.text;
                  }
                });
                
                return TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true)
                      return 'Base location is required';
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter postcode or address',
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
                    suffixIcon: const Icon(Icons.location_city_outlined, color: AppColors.grey500),
                  ),
                );
              },
              optionsViewBuilder: (context, onSelected, options) {
                final optionsList = options.toList();
                return Positioned(
                  left: 0,
                  right: 0,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.grey300, width: 1),
                      ),
                      constraints: BoxConstraints(
                        maxHeight: 260,
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: optionsList.length,
                        itemBuilder: (context, index) {
                          final option = optionsList[index];
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => onSelected(option),
                              borderRadius: index == 0 && index == optionsList.length - 1
                                  ? BorderRadius.circular(8)
                                  : index == 0
                                      ? const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        )
                                      : index == optionsList.length - 1
                                          ? const BorderRadius.only(
                                              bottomLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(8),
                                            )
                                          : BorderRadius.zero,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                decoration: index < optionsList.length - 1
                                    ? const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: AppColors.grey200,
                                            width: 0.5,
                                          ),
                                        ),
                                      )
                                    : null,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: AppColors.btnColor,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        option,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.grey900,
                                          height: 1.1,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
  Widget buildStep3(BuildContext context) {
    return Column(
      key: const ValueKey('step3'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildStepHeader(context, 'Vehicle Information', 'Technical details about your vehicle'),

        ProfessionalInput(
          label: 'Make & Model',
          controller: controller.makeModelController,
          hintText: 'e.g., Mercedes-Benz S-Class',
          isRequired: true,
          validator: (value) {
            if (value?.trim().isEmpty ?? true) return 'Make & Model is required';
            return null;
          },
        ),

        const SizedBox(height: 24),

        Row(
          children: [
            Expanded(
              child: ProfessionalInput(
                label: 'Number of Seats',
                controller: controller.numberOfSeatsController,
                hintText: 'Enter Number of Seats',
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
                hintText: 'Enter Luggage Capacity',
                keyboardType: TextInputType.number,
                isRequired: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) return 'Luggage capacity is required';
                  return null;
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        _buildDateField(context, 'First Registered', controller.firstRegistrationDate, allowFutureDates: false),
      ],
    );
  }

  // Step 4: Pricing Details - THE MAIN SCREEN YOU REQUESTED
  Widget buildStep4(BuildContext context) {
    return Column(
      key: const ValueKey('step4'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildStepHeader(context, 'Pricing Details', 'Set competitive rates for your service'),

        Row(
          children: [
            Expanded(
              child: ProfessionalInput(
                label: 'Full Day (£)',
                controller: controller.fullDayRateController,
                hintText: 'Enter full day rate',
                isRequired: true,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ProfessionalInput(
                label: 'Half Day (£)',
                controller: controller.halfDayRateController,
                hintText: 'Enter half day rate',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: ProfessionalInput(
                label: 'Hourly Rate (£)',
                controller: controller.hourlyRateController,
                hintText: 'Enter hourly rate',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ProfessionalInput(
                label: 'Mileage Limit',
                controller: controller.mileageLimitController,
                hintText: 'Enter mileage limit',
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
                label: 'Wedding Package (£)',
                controller: controller.weddingPackageController,
                hintText: 'Enter wedding package rate',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ProfessionalInput(
                label: 'Airport Transfer (£)',
                controller: controller.airportTransferController,
                hintText: 'Enter airport transfer rate',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        ProfessionalInput(
          label: 'Deposit (£)',
          controller: controller.depositController,
          hintText: 'Enter deposit amount',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
        ),

        const SizedBox(height: 20),

        const Text(
          'Fuel Included?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Obx(() => Row(
              children: [
                Row(
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: controller.fuelIncluded.value,
                      onChanged: (bool? value) {
                        controller.fuelIncluded.value = value ?? true;
                      },
                    ),
                    const Text('Yes'),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Radio<bool>(
                      value: false,
                      groupValue: controller.fuelIncluded.value,
                      onChanged: (bool? value) {
                        controller.fuelIncluded.value = value ?? true;
                      },
                    ),
                    const Text('No'),
                  ],
                ),
              ],
            )),

        const SizedBox(height: 20),

        const Text(
          'Waiting Charges?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Obx(() => Row(
              children: [
                Row(
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: controller.waitingChargesEnabled.value,
                      onChanged: (bool? value) {
                        controller.waitingChargesEnabled.value = value ?? false;
                      },
                    ),
                    const Text('Yes'),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Radio<bool>(
                      value: false,
                      groupValue: controller.waitingChargesEnabled.value,
                      onChanged: (bool? value) {
                        controller.waitingChargesEnabled.value = value ?? false;
                      },
                    ),
                    const Text('No'),
                  ],
                ),
              ],
            )),

        Obx(() => controller.waitingChargesEnabled.value
            ? Column(
                children: [
                  const SizedBox(height: 20),
                  ProfessionalInput(
                    label: 'Waiting Charges (£/hr)',
                    controller: controller.waitingChargesController,
                    hintText: 'Enter waiting charges per hour',
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                  ),
                ],
              )
            : const SizedBox()),

        const SizedBox(height: 20),

        ProfessionalInput(
          label: 'Extra Mileage Charge (£/mile)',
          controller: controller.extraMileageChargeController,
          hintText: 'Enter extra mileage charge per mile',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
        ),
      ],
    );
  }

  // Step 5: Coverage & Location
  Widget buildStep5(BuildContext context) {
    return Column(
      key: const ValueKey('step5'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildStepHeader(context, 'Coverage & Location', 'Define your service area and operational range'),

        ProfessionalInput(
          label: 'Service Coverage Areas',
          controller: controller.basePostcodeController,
          hintText: 'Enter base postcode or city',
          isRequired: true,
          validator: (value) {
            if (value?.trim().isEmpty ?? true) return 'Base postcode is required';
            return null;
          },
        ),

        const SizedBox(height: 24),

        Row(
          children: [
            Expanded(
              child: ProfessionalInput(
                label: 'Service Radius (miles)',
                controller: controller.locationRadiusController,
                hintText: 'Range: 1-500 miles',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
          onChanged: (value) {
            controller.selectedServiceStatus.value = value ?? '';
          },
          isRequired: true,
        ),
      ],
    );
  }

  // Step 6: Service Availability with Calendar
  Widget buildStep6(BuildContext context) {
    return Column(
      key: const ValueKey('step6'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildStepHeader(context, 'Service Availability', 'Set your availability periods'),

        _buildDateField(context, 'Available From', controller.calendarController.fromDate),

        const SizedBox(height: 16),

        _buildDateField(context, 'Available To', controller.calendarController.toDate),

        const SizedBox(height: 24),

        ProfessionalDropdown(
          label: 'Cancellation Policy',
          value: controller.selectedCancellationPolicy.value,
          items: controller.cancellationPolicyOptions,
          onChanged: (value) {
            controller.selectedCancellationPolicy.value = value ?? '';
          },
          isRequired: true,
        ),

        const SizedBox(height: 24),

        const Text('Special Pricing Calendar', style: TextStyle(fontSize: 16, )),
        const SizedBox(height: 14),

       const Text('Set special prices for specific dates (holidays, peak seasons, events). These will override your standard rates.)'),

        const SizedBox(height: 10),

        // Calendar for special pricing
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
                // Show special price dialog
                final priceController = TextEditingController();
                Get.dialog(
                  AlertDialog(
                    title: Text('Set Special Price for ${DateFormat('EEE, d MMM yyyy').format(selectedDay)}'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: priceController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                            Get.snackbar("Error", "Please enter a valid price");
                          }
                        },
                        child: const Text('Set Price'),
                      ),
                    ],
                  ),
                );
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
                  return buildCalendarCell(day, true);
                }
                return buildCalendarCell(day, false);
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
          child: controller.calendarController.specialPrices.length > 0
              ? Obx(() => ListView.builder(
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
                                Text('£${price.toStringAsFixed(2)}/day',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: price > 0 ? Colors.black : Colors.red,
                                    )),
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
                  ))
              : const Center(
                  child: Text('No special prices set yet',
                      style: TextStyle(fontSize: 16, color: Colors.black))),
        ),
      ],
    );
  }

  // Step 7: Features & Extras
  Widget buildStep7(BuildContext context) {
    return Column(
      key: const ValueKey('step7'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildStepHeader(context, 'Features & Extras', 'Select features and extras your service offers'),

        // Occasions
        buildStepHeader(context, 'Occasions', 'Special occasions your service caters to'),
        Column(
          children: [
            buildFeatureCheckbox('Weddings', controller.occasions, 'weddings'),
            buildFeatureCheckbox('Airport Transfers', controller.occasions, 'airportTransfers'),
            buildFeatureCheckbox('VIP Red Carpet', controller.occasions, 'vipRedCarpet'),
            buildFeatureCheckbox('Corporate Travel', controller.occasions, 'corporateTravel'),
            buildFeatureCheckbox('Proms', controller.occasions, 'proms'),
            buildFeatureCheckbox('Film/TV Hire', controller.occasions, 'filmTvHire'),
            buildFeatureCheckbox('Other', controller.occasions, 'other'),
          ],
        ),

        const SizedBox(height: 24),

        // Comfort Features
        buildStepHeader(context, 'Comfort Features', 'Premium comfort and luxury amenities'),
        Column(
          children: [
            buildFeatureCheckbox('Leather Interior', controller.comfortFeatures, 'leatherInterior'),
            buildFeatureCheckbox('WiFi Access', controller.comfortFeatures, 'wifiAccess'),
            buildFeatureCheckbox('Air Conditioning', controller.comfortFeatures, 'airConditioning'),
            buildFeatureCheckbox('In-Car Entertainment', controller.comfortFeatures, 'inCarEntertainment'),
            buildFeatureCheckbox('Bluetooth/USB', controller.comfortFeatures, 'bluetoothUsb'),
            buildFeatureCheckbox('Red Carpet Service', controller.comfortFeatures, 'redCarpetService'),
            buildFeatureCheckbox('Onboard Restroom', controller.comfortFeatures, 'onboardRestroom'),
            buildFeatureCheckbox('Chauffeur in Uniform', controller.comfortFeatures, 'chauffeurInUniform'),
          ],
        ),

        const SizedBox(height: 24),

        // Complimentary Drinks Section
        Obx(() => CheckboxListTile(
              title: const Text('Complimentary Drinks Available'),
              value: controller.complimentaryDrinksAvailable.value,
              onChanged: (value) {
                controller.complimentaryDrinksAvailable.value = value ?? false;
              },
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: AppColors.btnColor,
            )),

        Obx(() => controller.complimentaryDrinksAvailable.value
            ? Column(
                children: [
                  const SizedBox(height: 16),
                  ProfessionalInput(
                    label: 'Complimentary Drinks Details',
                    controller: controller.complimentaryDrinksDetailsController,
                    hintText: 'Describe available drinks...',
                  ),
                ],
              )
            : const SizedBox()),

        const SizedBox(height: 24),

        // Events & Extras
        buildStepHeader(context, 'Events & Extras', 'Special event services and pricing'),

        // Wedding Decor
        Obx(() => Column(
              children: [
                buildFeatureCheckbox('Wedding Decor', controller.eventsFeatures, 'weddingDecor'),
                if (controller.eventsFeatures['weddingDecor'] == true) ...[
                  const SizedBox(height: 16),
                  ProfessionalInput(
                    label: 'Wedding Decor Price (£)',
                    controller: controller.weddingDecorPriceController,
                    hintText: 'Enter price',
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ],
              ],
            )),

        const SizedBox(height: 20),

        // Champagne Packages
        Obx(() => Column(
              children: [
                buildFeatureCheckbox('Champagne Packages', controller.eventsFeatures, 'champagnePackages'),
                if (controller.eventsFeatures['champagnePackages'] == true) ...[
                  const SizedBox(height: 16),
                  ProfessionalInput(
                    label: 'Champagne Package Price (£)',
                    controller: controller.champagnePackagesPriceController,
                    hintText: 'Enter price',
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ],
              ],
            )),

        const SizedBox(height: 20),

        // Party Lighting
        Obx(() => Column(
              children: [
                buildFeatureCheckbox('Party Lighting', controller.eventsFeatures, 'partyLighting'),
                if (controller.eventsFeatures['partyLighting'] == true) ...[
                  const SizedBox(height: 16),
                  ProfessionalInput(
                    label: 'Party Lighting Price (£)',
                    controller: controller.partyLightingPriceController,
                    hintText: 'Enter price',
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ],
              ],
            )),

        const SizedBox(height: 20),

        // Photography Packages
        Obx(() => Column(
              children: [
                buildFeatureCheckbox('Photography Packages', controller.eventsFeatures, 'photographyPackages'),
                if (controller.eventsFeatures['photographyPackages'] == true) ...[
                  const SizedBox(height: 16),
                  ProfessionalInput(
                    label: 'Photography Package Price (£)',
                    controller: controller.photographyPackagesPriceController,
                    hintText: 'Enter price',
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ],
              ],
            )),

        const SizedBox(height: 24),

        // Accessibility & Security
        buildStepHeader(context, 'Accessibility & Security', 'Special services and security features'),

        // Accessibility Section
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.accessibility, color: AppColors.success, size: 18),
              SizedBox(width: 8),
              Text(
                'Accessibility Features',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        Column(
          children: [
            buildAccessibilityFeature('Wheelchair Access Vehicle', 'wheelchairAccessVehicle', controller.wheelchairAccessPriceController),
            buildAccessibilityFeature('Child Car Seats', 'childCarSeats', controller.childCarSeatsPriceController),
            buildAccessibilityFeature('Pet Friendly Service', 'petFriendlyService', controller.petFriendlyPriceController),
            buildAccessibilityFeature('Disabled Access Ramp', 'disabledAccessRamp', controller.disabledAccessRampPriceController),
            buildAccessibilityFeature('Senior Friendly Assistance', 'seniorFriendlyAssistance', controller.seniorAssistancePriceController),
            buildAccessibilityFeature('Stroller/Buggy Storage', 'strollerBuggyStorage', controller.strollerStoragePriceController),
          ],
        ),

        const SizedBox(height: 24),

        // Security Section
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.warning.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.security, color: AppColors.warning, size: 18),
              SizedBox(width: 8),
              Text(
                'Security Features',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        Column(
          children: [
            buildFeatureCheckbox('Vehicle Tracking GPS', controller.securityFeatures, 'vehicleTrackingGps'),
            buildFeatureCheckbox('CCTV Fitted', controller.securityFeatures, 'cctvFitted'),
            buildFeatureCheckbox('Public Liability Insurance', controller.securityFeatures, 'publicLiabilityInsurance'),
            buildFeatureCheckbox('Safety Certified Drivers', controller.securityFeatures, 'safetyCertifiedDrivers'),
            buildFeatureCheckbox('DBS Checked', controller.securityFeatures, 'dbsChecked'),
          ],
        ),
      ],
    );
  }

  // Step 8: Photos & Media
  Widget buildStep8(BuildContext context) {
    return Column(
      key: const ValueKey('step8'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildStepHeader(context, 'Photos & Media', 'Upload high-quality images of your vehicle'),

        const Text(
          'Service Images (Minimum 3 images required)',
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
          onTap: () => controller.pickDocument(controller.serviceImages, null),
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
                  Icon(Icons.add_photo_alternate_outlined, size: 40, color: AppColors.grey500),
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
            ? buildSelectedImagesGrid(context)
            : const SizedBox()),
      ],
    );
  }

  // Step 9: Coupon Management
  Widget buildStep9(BuildContext context) {
    return Column(
      key: const ValueKey('step9'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildStepHeader(context, 'Coupon Management', 'Create promotional coupons for your service'),

        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () => Get.dialog(AddCouponDialog()),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Add Coupon', style: TextStyle(color: Colors.white)),
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
  Widget buildStep10(BuildContext context) {
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
                buildTermsCheckbox(
                  context,
                  'I confirm that all information provided is accurate and current.',
                  controller.isAccurateInfo,
                  (value) => controller.isAccurateInfo.value = value ?? false,
                ),
                buildTermsCheckbox(
                  context,
                  'I have not shared any contact details (Email, Phone, Skype, Website etc.)',
                  controller.noContactDetailsShared,
                  (value) => controller.noContactDetailsShared.value = value ?? false,
                ),
                buildTermsCheckboxWithLink(
                  context,
                  'I agree to the Cookies Policy',
                  controller.agreeCookiesPolicy,
                  (value) => controller.agreeCookiesPolicy.value = value ?? false,
                  'https://stage1.hireanything.com/Cookies_Policy_Hire_Anything_Corrected.pdf',
                ),
                buildTermsCheckboxWithLink(
                  context,
                  'I agree to the Privacy Policy',
                  controller.agreePrivacyPolicy,
                  (value) => controller.agreePrivacyPolicy.value = value ?? false,
                  'https://stage1.hireanything.com/HireAnything_Privacy_Policy_Corrected.pdf',
                ),
                buildTermsCheckboxWithLink(
                  context,
                  'I agree to the Cancellation Fee Policy',
                  controller.agreeCancellationPolicy,
                  (value) => controller.agreeCancellationPolicy.value = value ?? false,
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
                        fontSize: 12,
                        color: AppColors.grey700,
                        height: 1.3,
                      ),
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

  Widget buildFeatureCheckbox(String title, RxMap<String, dynamic> features, String key) {
    return Obx(() => CheckboxListTile(
          title: Text(title),
          value: features[key] ?? false,
          onChanged: (value) {
            features[key] = value ?? false;
          },
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: AppColors.btnColor,
          contentPadding: EdgeInsets.zero,
          dense: true,
        ));
  }

  Widget buildAccessibilityFeature(String title, String key, TextEditingController priceController) {
    return Column(
      children: [
        Obx(() => CheckboxListTile(
              title: Text(title),
              value: controller.accessibilityFeatures[key] ?? false,
              onChanged: (value) {
                controller.accessibilityFeatures[key] = value ?? false;
              },
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
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                  const SizedBox(height: 16),
                ],
              )
            : const SizedBox()),
      ],
    );
  }

  Widget buildTermsCheckbox(BuildContext context, String title, RxBool value, Function(bool?) onChanged) {
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
            fontSize: 13,
            color: AppColors.grey900,
            height: 1.3,
          ),
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

  Widget buildTermsCheckboxWithLink(BuildContext context, String title, RxBool value, Function(bool?) onChanged, String url) {
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

   Widget _buildAreasSelection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Areas Covered',
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

  Widget buildSelectedImagesGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected Images (${controller.serviceImages.length})',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.grey900,
          ),
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
                                  Icon(Icons.picture_as_pdf, color: AppColors.error, size: 24),
                                  Text('PDF', style: TextStyle(fontSize: 10, color: AppColors.grey700)),
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
                        onTap: () => controller.removeDocument(controller.serviceImages, index),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, color: AppColors.white, size: 12),
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

  Widget buildCalendarCell(DateTime day, bool isVisible) {
    final specialPrice = controller.calendarController.specialPrices
        .where((entry) =>
            DateFormat('yyyy-MM-dd').format(entry['date'] as DateTime) ==
            DateFormat('yyyy-MM-dd').format(day))
        .map((entry) => entry['price'] as double?)
        .firstOrNull;

    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(4),
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

  Widget buildStepHeader(BuildContext context, String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.grey900,
          ),
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
              firstDate: DateTime(1950),
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

  Widget buildDocumentUploadSection(String title, RxList<DocumentFile> documents, {bool isRequired = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.grey900,
          ),
          children: [
            TextSpan(text: title),
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
      const SizedBox(height: 8),
      const Text(
        'Accepted formats: JPG, PNG, PDF • Max 5MB',
        style: TextStyle(fontSize: 12, color: AppColors.grey600),
      ),
      const SizedBox(height: 12),
      
      // Document Upload Area
      Obx(() => documents.isEmpty
          ? GestureDetector(
              onTap: () => controller.pickDocument(documents, null),
              child: DottedBorder(
                color: AppColors.grey400,
                strokeWidth: 1.5,
                dashPattern: const [8, 4],
                borderType: BorderType.RRect,
                radius: const Radius.circular(8),
                child:const SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 36,
                        color: AppColors.grey500,
                      ),
                       SizedBox(height: 12),
                      Text(
                        'Upload Document',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey700,
                        ),
                      ),
                       SizedBox(height: 4),
                      Text(
                        'Click to browse files',
                        style: TextStyle(fontSize: 12, color: AppColors.grey500),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Column(
              children: [
                // Display uploaded documents
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final doc = documents[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.grey50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.grey300),
                      ),
                      child: Row(
                        children: [
                          // File icon based on type
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: doc.type == 'pdf' 
                                  ? AppColors.error.withOpacity(0.1)
                                  : AppColors.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              doc.type == 'pdf' 
                                  ? Icons.picture_as_pdf
                                  : Icons.image,
                              color: doc.type == 'pdf' 
                                  ? AppColors.error
                                  : AppColors.success,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // File details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doc.name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey900,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text(
                                      doc.displaySize,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.grey600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: doc.isValidSize
                                            ? AppColors.success.withOpacity(0.1)
                                            : AppColors.error.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        doc.isValidSize ? 'Valid' : 'Too Large',
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w500,
                                          color: doc.isValidSize
                                              ? AppColors.success
                                              : AppColors.error,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Remove button
                          GestureDetector(
                            onTap: () => controller.removeDocument(documents, index),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.delete_outline,
                                color: AppColors.error,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                // Add more button
                GestureDetector(
                  onTap: () => controller.pickDocument(documents, null),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.btnColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Icon(
                          Icons.add,
                          color: AppColors.btnColor,
                          size: 18,
                        ),
                         SizedBox(width: 8),
                        Text(
                          'Add Another Document',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.btnColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
    ],
  );
}
}