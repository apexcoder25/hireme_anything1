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

// CORRECTED Boat Hire Controller with EXACT API PAYLOAD STRUCTURE
class BoatHireController extends GetxController {
  // Observable states
  var currentStep = 1.obs;
  var isLoading = false.obs;
  var isNavigating = false.obs;
  var isSubmitting = false.obs;
  var completedSteps = <int>{}.obs;

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text controllers
  final TextEditingController listingTitleController = TextEditingController();
  final TextEditingController boatTypeController = TextEditingController();
  final TextEditingController makeModelController = TextEditingController();
  final TextEditingController numberOfSeatsController = TextEditingController();
  final TextEditingController luggageCapacityController =
      TextEditingController();
  final TextEditingController basePostcodeController = TextEditingController();
  final TextEditingController locationRadiusController =
      TextEditingController();
  final TextEditingController mileageRadiusController = TextEditingController();
  final TextEditingController hourlyRateController = TextEditingController();
  final TextEditingController perMileRateController = TextEditingController();
  final TextEditingController tenHourDayRateController =
      TextEditingController();
  final TextEditingController halfDayRateController = TextEditingController();
  final TextEditingController searchCitiesController = TextEditingController();
  final TextEditingController customDeparturePointController =
      TextEditingController();

  // Event & Extra Price Controllers
  final TextEditingController weddingDecorPriceController =
      TextEditingController();
  final TextEditingController partyLightingPriceController =
      TextEditingController();
  final TextEditingController champagnePackagesPriceController =
      TextEditingController();
  final TextEditingController champagneBottlesController =
      TextEditingController(text: '1');
  final TextEditingController champagneBrandController =
      TextEditingController();
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
  var selectedHireType = 'skippered-only'.obs;
  var selectedDeparturePoint = 'London Bridge City Pier'.obs;
  var selectedServiceStatus = 'open'.obs;
  var selectedCancellationPolicy = 'FLEXIBLE'.obs;
  var firstRegistrationDate = DateTime.now().obs;

  // CORRECTED: Using the exact categoryId and subcategoryId from your payload
  String categoryId =
      "676ac544234968d45b494992"; // Your actual boat hire category ObjectId
  String subcategoryId =
      "676ace13234968d45b4949db"; // Your actual boat hire subcategory ObjectId

  // Document storage for API
  RxList<DocumentFile> publicLiabilityDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> operatorLicenceDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> boatMasterLicenceDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> skipperCredentialsDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> boatSafetyCertDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> vesselInsuranceDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> localAuthorityLicenceDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> serviceImages = <DocumentFile>[].obs;

  // Areas management
  RxList<String> selectedAreas = <String>[].obs;
  RxList<String> filteredCities = <String>[].obs;

  // Basic Features (matching your payload)
  var basicFeatures = {
    'wifi': false,
    'airConditioning': false,
    'tv': false,
    'toilet': false,
    'musicSystem': false,
    'cateringFacilities': false,
    'sunDeck': false,
    'overnightStayCabins': false,
    'other': false,
  }.obs;
  var otherFeatureController = TextEditingController();

  // Comfort Features (matching your payload)
  var comfortFeatures = {
    'leatherInterior': false,
    'wifiAccess': false,
    'airConditioning': false,
    'inCarEntertainment': false,
    'bluetoothUsb': false,
    'redCarpetService': false,
    'onboardRestroom': false,
  }.obs;
  var complimentaryDrinksAvailable = false.obs;
  var complimentaryDrinksDetailsController = TextEditingController();

  // Events Features (matching your payload)
  var eventsFeatures = {
    'weddingDecor': false,
    'partyLightingSystem': false,
    'champagnePackages': false,
    'photographyPackages': false,
  }.obs;

  // Accessibility Features (matching your payload)
  var accessibilityFeatures = {
    'wheelchairAccessVehicle': false,
    'childCarSeats': false,
    'petFriendlyService': false,
    'disabledAccessRamp': false,
    'seniorFriendlyAssistance': false,
    'strollerBuggyStorage': false,
  }.obs;

  // Security Features (matching your payload)
  var securityFeatures = {
    'vehicleTrackingGps': false,
    'cctvFitted': false,
    'publicLiabilityInsurance': false,
    'safetyCertifiedDrivers': false,
  }.obs;

  // Terms
  var isAccurateInfo = false.obs;
  var noContactDetailsShared = false.obs;
  var agreeCookiesPolicy = false.obs;
  var agreePrivacyPolicy = false.obs;
  var agreeCancellationPolicy = false.obs;

  // Static data
  final List<String> hireTypes = ['skippered-only'];
  final List<String> departurePoints = [
    'London Bridge City Pier',
    'Tower Bridge Quay',
    'Canary Wharf Pier',
    'Greenwich Pier',
    'Westminster Pier',
    'Embankment Pier',
    'London Eye Pier',
    'Putney Pier',
    'Kew Gardens Pier',
    'Hampton Court Pier',
    'Brighton Marina',
    'Portsmouth Harbour',
    'Southampton Marina',
    'Poole Harbour',
    'Weymouth Harbour',
    'Torquay Marina',
    'Plymouth Barbican',
    'Dartmouth Marina',
    'Salcombe Harbour',
    'Fowey Harbour',
    'Falmouth Marina',
    'Penzance Harbour',
    'Harwich International Port',
    'Felixstowe Marina',
    'Lowestoft Marina',
    'Great Yarmouth Marina',
    'Wells-next-the-Sea',
    'Blakeney Harbour',
    'King\'s Lynn',
    'Boston Marina',
    'Grimsby Marina',
    'Hull Marina',
    'Bridlington Harbour',
    'Scarborough Harbour',
    'Whitby Marina',
    'Liverpool Marina',
    'Chester Marina',
    'Conwy Marina',
    'Bangor Marina',
    'Caernarfon Harbour',
    'Pwllheli Marina',
    'Aberystwyth Marina',
    'Milford Haven Marina',
    'Tenby Harbour',
    'Swansea Marina',
    'Cardiff Bay',
    'Bristol Marina',
    'Portishead Marina',
    'Burnham-on-Sea',
    'Watchet Marina',
    'Minehead Harbour',
    'Edinburgh - Leith Docks',
    'Glasgow - Clyde Marina',
    'Aberdeen Harbour',
    'Dundee Marina',
    'Perth Marina',
    'Stirling Marina',
    'Oban Marina',
    'Fort William Marina',
    'Mallaig Harbour',
    'Stornoway Harbour',
    'Kirkwall Marina',
    'Lerwick Harbour',
    'Belfast Harbour',
    'Bangor Marina (NI)',
    'Carrickfergus Marina',
    'Coleraine Marina',
    'Londonderry Marina',
    'Lake Windermere - Bowness',
    'Lake Windermere - Ambleside',
    'Lake Coniston',
    'Lake Ullswater',
    'Lake Derwentwater',
    'Loch Lomond Marina',
    'Loch Katrine',
    'Norfolk Broads - Wroxham',
    'Norfolk Broads - Potter Heigham',
    'Norfolk Broads - Hickling',
    'River Thames - Henley',
    'River Thames - Marlow',
    'River Thames - Windsor',
    'River Thames - Oxford',
    'River Severn - Worcester',
    'River Severn - Gloucester',
    'Manchester Ship Canal',
    'Leeds-Liverpool Canal',
    'Grand Union Canal',
    'Custom Location (Please Specify)'
  ];

  final List<String> serviceStatusOptions = ['open', 'close'];
  final List<String> cancellationPolicyOptions = [
    'FLEXIBLE',
    'MODERATE',
    'STRICT'
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
            DateTime.now().add(const Duration(days: 7));
      }
    });
  }

  void _setupListeners() {
    searchCitiesController.addListener(_filterCities);
    hourlyRateController.addListener(() {
      calendarController
          .setDefaultPrice(double.tryParse(hourlyRateController.text) ?? 0.0);
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
      // Updated to 10 steps
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
        return await _validateStep3(); // Fleet Info
      case 4:
        return await _validateStep4(); // Coverage Areas
      case 5:
        return await _validateStep5(); // Pricing Details
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

  Future<bool> _validateStep1() async {
    if (publicLiabilityDocs.isEmpty) {
      _showError('Public Liability Insurance document is required');
      return false;
    }
    if (operatorLicenceDocs.isEmpty) {
      _showError('Operator Licence document is required');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep2() async {
    if (listingTitleController.text.trim().isEmpty) {
      _showError('Please enter a listing title');
      return false;
    }
    if (listingTitleController.text.trim().length < 3) {
      _showError('Title must be at least 3 characters');
      return false;
    }
    if (boatTypeController.text.trim().isEmpty) {
      _showError('Please enter boat type');
      return false;
    }
    // Validate custom departure point if selected
    if (selectedDeparturePoint.value == 'Custom Location (Please Specify)' &&
        customDeparturePointController.text.trim().isEmpty) {
      _showError('Please enter your custom departure point');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep3() async {
    if (makeModelController.text.trim().isEmpty ||
        numberOfSeatsController.text.trim().isEmpty ||
        luggageCapacityController.text.trim().isEmpty) {
      _showError('All fleet information fields are required');
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
    final tenHourRate =
        double.tryParse(tenHourDayRateController.text.trim()) ?? 0;
    final halfDayRate = double.tryParse(halfDayRateController.text.trim()) ?? 0;

    if (hourlyRate == 0 && tenHourRate == 0 && halfDayRate == 0) {
      _showError('At least one pricing field is required');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep5() async {
    if (basePostcodeController.text.trim().isEmpty) {
      _showError('Please enter base postcode');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep6() async {
    return true; // Service availability is handled by calendar
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
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        final file = result.files.single;
        final filePath = file.path!;
        final fileSize = file.size;

        if (fileSize > 5 * 1024 * 1024) {
          // 5MB limit
          _showError('File size must be less than 5MB');
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
            child: Text('Set Price'),
          ),
        ],
      ),
    );
  }

  // Calendar cell builder
  Widget _buildCalendarCell(DateTime day, bool isVisible) {
    final specialPrice = calendarController.specialPrices
        .where((entry) =>
            DateFormat('yyyy-MM-dd').format(entry['date'] as DateTime) ==
            DateFormat('yyyy-MM-dd').format(day))
        .map((entry) => entry['price'] as double?)
        .firstOrNull;

    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(3),
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

  // CORRECTED Enhanced form submission with EXACT API payload structure
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
        final isAdded = await api.addServiceVendor(formData, 'boat');

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
    await _uploadDocumentList(publicLiabilityDocs);
    await _uploadDocumentList(operatorLicenceDocs);
    await _uploadDocumentList(boatMasterLicenceDocs);
    await _uploadDocumentList(skipperCredentialsDocs);
    await _uploadDocumentList(boatSafetyCertDocs);
    await _uploadDocumentList(vesselInsuranceDocs);
    await _uploadDocumentList(localAuthorityLicenceDocs);
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

  // CORRECTED: Prepare API payload with EXACT structure matching your real payload
  Future<Map<String, dynamic>> _prepareAPIPayload() async {
    return {
      "vendorId": vendorId ?? "68eb757c758ef700653aada8",
      "listingTitle": listingTitleController.text.trim(),
      "baseLocationPostcode": basePostcodeController.text.trim(),
      "locationRadius":
          int.tryParse(locationRadiusController.text.trim()) ?? 50,
      "areasCovered": selectedAreas.toList(),
      "fleetInfo": {
        "makeAndModel": makeModelController.text.trim(),
        "seats": int.tryParse(numberOfSeatsController.text.trim()) ?? 4,
        "luggageCapacity":
            int.tryParse(luggageCapacityController.text.trim()) ?? 2,
        "firstRegistration": firstRegistrationDate.value.toIso8601String(),
      },
      "pricingDetails": {
        "dayRate": double.tryParse(tenHourDayRateController.text.trim()) ?? 0,
        "hourlyRate": double.tryParse(hourlyRateController.text.trim()) ?? 0,
        "halfDayRate": double.tryParse(halfDayRateController.text.trim()) ?? 0,
        "mileageLimit": 200,
        "extraMileageCharge": 0,
        "perMileRate": double.tryParse(perMileRateController.text.trim()) ?? 0,
      },
      "features": {
        "wifi": basicFeatures['wifi'] ?? false,
        "airConditioning": basicFeatures['airConditioning'] ?? false,
        "tv": basicFeatures['tv'] ?? false,
        "toilet": basicFeatures['toilet'] ?? false,
        "musicSystem": basicFeatures['musicSystem'] ?? false,
        "cateringFacilities": basicFeatures['cateringFacilities'] ?? false,
        "sunDeck": basicFeatures['sunDeck'] ?? false,
        "overnightStayCabins": basicFeatures['overnightStayCabins'] ?? false,
        "other": basicFeatures['other'] ?? false,
        "otherFeature": otherFeatureController.text.trim(),
      },
      "service_status": selectedServiceStatus.value,
      "booking_date_from": calendarController.fromDate.value.toIso8601String(),
      "booking_date_to": calendarController.toDate.value.toIso8601String(),
      "special_price_days": calendarController.specialPrices
          .map((e) => {
                'date': DateFormat('yyyy-MM-dd').format(e['date'] as DateTime),
                'price': e['price'] as double? ?? 0
              })
          .toList(),
      "cancellation_policy_type": selectedCancellationPolicy.value,
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
        "boatMasterLicence": {
          "isAttached": boatMasterLicenceDocs.isNotEmpty,
          "image": boatMasterLicenceDocs.isNotEmpty
              ? (boatMasterLicenceDocs.first.uploadUrl ?? '')
              : '',
          "fileName": boatMasterLicenceDocs.isNotEmpty
              ? boatMasterLicenceDocs.first.name
              : '',
          "fileType": boatMasterLicenceDocs.isNotEmpty
              ? 'image/${boatMasterLicenceDocs.first.type}'
              : '',
          "uploadedAt": DateTime.now().toIso8601String(),
        },
        "skipperCredentials": {
          "isAttached": skipperCredentialsDocs.isNotEmpty,
          "image": skipperCredentialsDocs.isNotEmpty
              ? (skipperCredentialsDocs.first.uploadUrl ?? '')
              : '',
          "fileName": skipperCredentialsDocs.isNotEmpty
              ? skipperCredentialsDocs.first.name
              : '',
          "fileType": skipperCredentialsDocs.isNotEmpty
              ? 'image/${skipperCredentialsDocs.first.type}'
              : '',
          "uploadedAt": DateTime.now().toIso8601String(),
        },
        "boatSafetyCertificate": {
          "isAttached": boatSafetyCertDocs.isNotEmpty,
          "image": boatSafetyCertDocs.isNotEmpty
              ? (boatSafetyCertDocs.first.uploadUrl ?? '')
              : '',
          "fileName": boatSafetyCertDocs.isNotEmpty
              ? boatSafetyCertDocs.first.name
              : '',
          "fileType": boatSafetyCertDocs.isNotEmpty
              ? 'image/${boatSafetyCertDocs.first.type}'
              : '',
          "uploadedAt": DateTime.now().toIso8601String(),
        },
        "vesselInsurance": {
          "isAttached": vesselInsuranceDocs.isNotEmpty,
          "image": vesselInsuranceDocs.isNotEmpty
              ? (vesselInsuranceDocs.first.uploadUrl ?? '')
              : '',
          "fileName": vesselInsuranceDocs.isNotEmpty
              ? vesselInsuranceDocs.first.name
              : '',
          "fileType": vesselInsuranceDocs.isNotEmpty
              ? 'image/${vesselInsuranceDocs.first.type}'
              : '',
          "uploadedAt": DateTime.now().toIso8601String(),
        },
        "localAuthorityLicence": {
          "isAttached": localAuthorityLicenceDocs.isNotEmpty,
          "image": localAuthorityLicenceDocs.isNotEmpty
              ? (localAuthorityLicenceDocs.first.uploadUrl ?? '')
              : '',
          "fileName": localAuthorityLicenceDocs.isNotEmpty
              ? localAuthorityLicenceDocs.first.name
              : '',
          "fileType": localAuthorityLicenceDocs.isNotEmpty
              ? 'image/${localAuthorityLicenceDocs.first.type}'
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
      "sub_category": "Boat Hire",
      "categoryId": categoryId,
      "subcategoryId": subcategoryId,
      "boatType": boatTypeController.text.trim(),
      "hireType": selectedHireType.value,
      "departurePoint":
          selectedDeparturePoint.value == 'Custom Location (Please Specify)'
              ? customDeparturePointController.text.trim()
              : selectedDeparturePoint.value,
      "navigableRoutes": selectedAreas.toList(),
      "postcode": basePostcodeController.text.trim(),
      "mileageRadius": int.tryParse(mileageRadiusController.text.trim()) ?? 18,
      "makeAndModel": makeModelController.text.trim(),
      "firstRegistered": firstRegistrationDate.value.toIso8601String(),
      "seats": int.tryParse(numberOfSeatsController.text.trim()) ?? 4,
      "luggageCapacity":
          int.tryParse(luggageCapacityController.text.trim()) ?? 2,
      "boatRates": {
        "hourlyRate": double.tryParse(hourlyRateController.text.trim()) ?? 0,
        "perMileRate": double.tryParse(perMileRateController.text.trim()) ?? 0,
        "tenHourDayHire":
            double.tryParse(tenHourDayRateController.text.trim()) ?? 0,
        "halfDayHire": double.tryParse(halfDayRateController.text.trim()) ?? 0,
      },
      "basicFeatures": {
        "wifi": basicFeatures['wifi'] ?? false,
        "airConditioning": basicFeatures['airConditioning'] ?? false,
        "tv": basicFeatures['tv'] ?? false,
        "toilet": basicFeatures['toilet'] ?? false,
        "musicSystem": basicFeatures['musicSystem'] ?? false,
        "cateringFacilities": basicFeatures['cateringFacilities'] ?? false,
        "sunDeck": basicFeatures['sunDeck'] ?? false,
        "overnightStayCabins": basicFeatures['overnightStayCabins'] ?? false,
        "other": basicFeatures['other'] ?? false,
        "otherFeature": otherFeatureController.text.trim(),
      },
      "basePostcode": basePostcodeController.text.trim(),
      "service_name": listingTitleController.text.trim(),
      "comfort": {
        "leatherInterior": comfortFeatures['leatherInterior'] ?? false,
        "wifiAccess": comfortFeatures['wifiAccess'] ?? false,
        "airConditioning": comfortFeatures['airConditioning'] ?? false,
        "complimentaryDrinks": {
          "available": complimentaryDrinksAvailable.value,
          "details": complimentaryDrinksDetailsController.text.trim(),
        },
        "inCarEntertainment": comfortFeatures['inCarEntertainment'] ?? false,
        "bluetoothUsb": comfortFeatures['bluetoothUsb'] ?? false,
        "redCarpetService": comfortFeatures['redCarpetService'] ?? false,
        "onboardRestroom": comfortFeatures['onboardRestroom'] ?? false,
      },
      "events": {
        "weddingDecor": eventsFeatures['weddingDecor'] ?? false,
        "weddingDecorPrice":
            double.tryParse(weddingDecorPriceController.text.trim()) ?? 0,
        "partyLightingSystem": eventsFeatures['partyLightingSystem'] ?? false,
        "partyLightingPrice":
            double.tryParse(partyLightingPriceController.text.trim()) ?? 0,
        "champagnePackages": eventsFeatures['champagnePackages'] ?? false,
        "champagnePackagePrice":
            double.tryParse(champagnePackagesPriceController.text.trim()) ?? 0,
        "champagneBrand": champagneBrandController.text.trim().isNotEmpty
            ? champagneBrandController.text.trim()
            : "true",
        "champagneBottles":
            int.tryParse(champagneBottlesController.text.trim()) ?? 1,
        "champagnePackageDetails":
            champagnePackageDetailsController.text.trim(),
        "photographyPackages": eventsFeatures['photographyPackages'] ?? false,
        "photographyPackagePrice":
            double.tryParse(photographyPackagePriceController.text.trim()) ?? 0,
        "photographyDuration": photographyDurationController.text.trim(),
        "photographyTeamSize": photographyTeamSizeController.text.trim(),
        "photographyPackageDetails":
            photographyPackageDetailsController.text.trim(),
        "photographyDeliveryTime":
            photographyDeliveryTimeController.text.trim(),
      },
      "accessibility": {
        "wheelchairAccessVehicle":
            accessibilityFeatures['wheelchairAccessVehicle'] ?? false,
        "wheelchairAccessPrice":
            double.tryParse(wheelchairAccessPriceController.text.trim()) ?? 0,
        "childCarSeats": accessibilityFeatures['childCarSeats'] ?? false,
        "childCarSeatsPrice":
            double.tryParse(childCarSeatsPriceController.text.trim()) ?? 0,
        "petFriendlyService":
            accessibilityFeatures['petFriendlyService'] ?? false,
        "petFriendlyPrice":
            double.tryParse(petFriendlyPriceController.text.trim()) ?? 0,
        "disabledAccessRamp":
            accessibilityFeatures['disabledAccessRamp'] ?? false,
        "disabledAccessRampPrice":
            double.tryParse(disabledAccessRampPriceController.text.trim()) ?? 0,
        "seniorFriendlyAssistance":
            accessibilityFeatures['seniorFriendlyAssistance'] ?? false,
        "seniorAssistancePrice":
            double.tryParse(seniorAssistancePriceController.text.trim()) ?? 0,
        "strollerBuggyStorage":
            accessibilityFeatures['strollerBuggyStorage'] ?? false,
        "strollerStoragePrice":
            double.tryParse(strollerStoragePriceController.text.trim()) ?? 0,
      },
      "security": {
        "vehicleTrackingGps": securityFeatures['vehicleTrackingGps'] ?? false,
        "cctvFitted": securityFeatures['cctvFitted'] ?? false,
        "publicLiabilityInsurance":
            securityFeatures['publicLiabilityInsurance'] ?? false,
        "safetyCertifiedDrivers":
            securityFeatures['safetyCertifiedDrivers'] ?? false,
      },
      "serviceCoverage": selectedAreas.toList(),
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
                'Submitting Your Boat Hire Service',
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
      'Your boat hire service has been submitted successfully! Our team will review it and publish within 24 hours.',
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
      'Coverage & Location',
      'Pricing Details',
      'Service Availability',
      'Basic Features',
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
    boatTypeController.dispose();
    makeModelController.dispose();
    numberOfSeatsController.dispose();
    luggageCapacityController.dispose();
    basePostcodeController.dispose();
    locationRadiusController.dispose();
    mileageRadiusController.dispose();
    hourlyRateController.dispose();
    perMileRateController.dispose();
    tenHourDayRateController.dispose();
    halfDayRateController.dispose();
    searchCitiesController.dispose();
    otherFeatureController.dispose();
    complimentaryDrinksDetailsController.dispose();

    // Event & Extra controllers
    weddingDecorPriceController.dispose();
    partyLightingPriceController.dispose();
    champagnePackagesPriceController.dispose();
    champagneBottlesController.dispose();
    champagneBrandController.dispose();
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
                          'Boat Hire Form',
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

// Main Boat Hire Service Widget
class BoatHireService extends StatelessWidget {
  final BoatHireController controller = Get.put(BoatHireController());

  final Rxn<String> category;
  final Rxn<String> subCategory;
  final String? categoryId;
  final String? subCategoryId;

  BoatHireService({
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
          child: const Row(
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

        _buildDocumentUploadSection(
          'Public Liability Insurance',
          controller.publicLiabilityDocs,
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
                      '5 optional',
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

        _buildDocumentUploadSection(
            'Boat Master Licence', controller.boatMasterLicenceDocs),
        const SizedBox(height: 20),
        _buildDocumentUploadSection(
            'Skipper Credentials', controller.skipperCredentialsDocs),
        const SizedBox(height: 20),
        _buildDocumentUploadSection(
            'Boat Safety Certificate', controller.boatSafetyCertDocs),
        const SizedBox(height: 20),
        _buildDocumentUploadSection(
            'Vessel Insurance', controller.vesselInsuranceDocs),
        const SizedBox(height: 20),
        _buildDocumentUploadSection(
            'Local Authority Licence', controller.localAuthorityLicenceDocs),
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
          hintText: 'Example: Executive Boat Hire Service',
          isRequired: true,
          validator: (value) {
            if (value?.trim().isEmpty ?? true) return 'Title is required';
            if (value!.length < 3) return 'Title must be at least 3 characters';
            return null;
          },
        ),
        const SizedBox(height: 24),
        ProfessionalInput(
          label: 'Boat Type',
          controller: controller.boatTypeController,
          hintText: 'Enter type of boat',
          isRequired: true,
          validator: (value) {
            if (value?.trim().isEmpty ?? true) return 'Boat type is required';
            return null;
          },
        ),
        const SizedBox(height: 24),
        ProfessionalDropdown(
          label: 'Hire Type',
          value: controller.selectedHireType.value,
          items: controller.hireTypes,
          onChanged: (value) => controller.selectedHireType.value = value ?? '',
          isRequired: true,
        ),
        const SizedBox(height: 24),
        ProfessionalDropdown(
          label: 'Primary Departure Point',
          value: controller.selectedDeparturePoint.value,
          items: controller.departurePoints,
          onChanged: (value) {
            controller.selectedDeparturePoint.value = value ?? '';
            // Clear custom departure point when switching away from custom option
            if (value != 'Custom Location (Please Specify)') {
              controller.customDeparturePointController.clear();
            }
          },
          isRequired: true,
        ),

        // Custom Departure Point Input Field
        Obx(() => controller.selectedDeparturePoint.value ==
                'Custom Location (Please Specify)'
            ? Column(
                children: [
                  const SizedBox(height: 24),
                  ProfessionalInput(
                    label: 'Custom Departure Point',
                    controller: controller.customDeparturePointController,
                    hintText: 'Enter your custom departure location',
                    isRequired: true,
                    validator: (value) {
                      if (controller.selectedDeparturePoint.value ==
                              'Custom Location (Please Specify)' &&
                          (value?.trim().isEmpty ?? true)) {
                        return 'Custom departure point is required';
                      }
                      return null;
                    },
                  ),
                ],
              )
            : const SizedBox()),
      ],
    );
  }

  // Step 3: Fleet Information
  Widget _buildStep3(BuildContext context) {
    return Column(
      key: const ValueKey('step3'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Vehicle Information',
            'Technical details about your boat'),
        ProfessionalInput(
          label: 'Make & Model',
          controller: controller.makeModelController,
          hintText: 'e.g., Sunseeker Predator 68',
          isRequired: true,
          validator: (value) {
            if (value?.trim().isEmpty ?? true)
              return 'Make & Model is required';
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
            context, 'First Registered', controller.firstRegistrationDate,
            allowFutureDates: false),
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
        Row(
          children: [
            Expanded(
              child: ProfessionalInput(
                label: 'Hourly Rate (£)',
                controller: controller.hourlyRateController,
                hintText: 'Enter hourly rate',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ProfessionalInput(
                label: 'Per-Mile Rate (£)',
                controller: controller.perMileRateController,
                hintText: 'Enter per-mile rate',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ProfessionalInput(
                label: 'Ten Hour Day Hire (£)',
                controller: controller.tenHourDayRateController,
                hintText: 'Enter day rate',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ProfessionalInput(
                label: 'Half Day Hire (£)',
                controller: controller.halfDayRateController,
                hintText: 'Enter half day rate',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Step 5: Coverage & Location
  Widget _buildStep5(BuildContext context) {
    return Column(
      key: const ValueKey('step5'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Coverage & Location',
            'Define your service area and operational range'),
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
                    TextSpan(text: 'Service Coverage Areas'),
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
                controller.basePostcodeController.text = selection;
              },
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                // Initialize with current value
                if (textEditingController.text.isEmpty &&
                    controller.basePostcodeController.text.isNotEmpty) {
                  textEditingController.text =
                      controller.basePostcodeController.text;
                }

                // Sync changes back to main controller
                textEditingController.addListener(() {
                  if (controller.basePostcodeController.text !=
                      textEditingController.text) {
                    controller.basePostcodeController.text =
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
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: ProfessionalInput(
                label: 'Service Radius (miles)',
                controller: controller.locationRadiusController,
                hintText: '(Range: 1-500 miles)',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildAreasSelection(context),
      ],
    );
  }

  // Step 6: Service Availability with Calendar
  Widget _buildStep6(BuildContext context) {
    return Column(
      key: const ValueKey('step6'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfessionalDropdown(
          label: 'Service Status',
          value: controller.selectedServiceStatus.value,
          items: controller.serviceStatusOptions,
          onChanged: (value) =>
              controller.selectedServiceStatus.value = value ?? '',
          isRequired: true,
        ),
        const SizedBox(
          height: 24,
        ),
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
          value: controller.selectedCancellationPolicy.value,
          items: controller.cancellationPolicyOptions,
          onChanged: (value) =>
              controller.selectedCancellationPolicy.value = value ?? '',
          isRequired: true,
        ),
        const SizedBox(height: 24),
        const Text('Special Pricing Calendar',
            style: TextStyle(
              fontSize: 16,
            )),
        const SizedBox(height: 14),
        const Text(
            'Set special prices for specific dates (holidays, peak seasons, events). These will override your standard rates.)'),
        const SizedBox(height: 10),
        Obx(() {
          DateTime focusedDay = controller.calendarController.fromDate.value;
          DateTime availableFromDate =
              controller.calendarController.fromDate.value;
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
                controller._showSetPriceDialog(selectedDay);
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
                          color: Colors.grey[200],
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

  // Step 7: Basic Features
  Widget _buildStep7(BuildContext context) {
    return Column(
      key: const ValueKey('step7'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Basic Features',
            'Select basic features your boat offers'),
        Column(
          children: [
            _buildFeatureCheckbox('WiFi', controller.basicFeatures, 'wifi'),
            _buildFeatureCheckbox('Air Conditioning', controller.basicFeatures,
                'airConditioning'),
            _buildFeatureCheckbox('TV', controller.basicFeatures, 'tv'),
            _buildFeatureCheckbox('Toilet', controller.basicFeatures, 'toilet'),
            _buildFeatureCheckbox(
                'Music System', controller.basicFeatures, 'musicSystem'),
            _buildFeatureCheckbox('Catering Facilities',
                controller.basicFeatures, 'cateringFacilities'),
            _buildFeatureCheckbox(
                'Sun Deck', controller.basicFeatures, 'sunDeck'),
            _buildFeatureCheckbox('Overnight Stay Cabins',
                controller.basicFeatures, 'overnightStayCabins'),
            _buildFeatureCheckbox('Other', controller.basicFeatures, 'other'),
          ],
        ),

        Obx(() => controller.basicFeatures['other'] == true
            ? Column(
                children: [
                  const SizedBox(height: 16),
                  ProfessionalInput(
                    label: 'Other Feature Details',
                    controller: controller.otherFeatureController,
                    hintText: 'Describe other features...',
                  ),
                ],
              )
            : const SizedBox()),

        const SizedBox(
          height: 24,
        ),
        _buildStepHeader(context, 'Comfort Features',
            'Premium comfort and luxury amenities'),

        Column(
          children: [
            _buildFeatureCheckbox('Leather Interior',
                controller.comfortFeatures, 'leatherInterior'),
            _buildFeatureCheckbox(
                'WiFi Access', controller.comfortFeatures, 'wifiAccess'),
            _buildFeatureCheckbox('Air Conditioning',
                controller.comfortFeatures, 'airConditioning'),
            _buildFeatureCheckbox('In-Car Entertainment',
                controller.comfortFeatures, 'inCarEntertainment'),
            _buildFeatureCheckbox(
                'Bluetooth/USB', controller.comfortFeatures, 'bluetoothUsb'),
            _buildFeatureCheckbox('Red Carpet Service',
                controller.comfortFeatures, 'redCarpetService'),
            _buildFeatureCheckbox('Onboard Restroom',
                controller.comfortFeatures, 'onboardRestroom'),
          ],
        ),

        const SizedBox(height: 24),

        // Complimentary Drinks Section
        Obx(() => CheckboxListTile(
              title: const Text('Complimentary Drinks Available'),
              value: controller.complimentaryDrinksAvailable.value,
              onChanged: (value) => controller
                  .complimentaryDrinksAvailable.value = value ?? false,
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

        const SizedBox(
          height: 24,
        ),

        _buildStepHeader(
            context, 'Events & Extras', 'Special event services and pricing'),

        // Wedding Decor
        Obx(() => Column(
              children: [
                _buildFeatureCheckbox(
                    'Wedding Decor', controller.eventsFeatures, 'weddingDecor'),
                if (controller.eventsFeatures['weddingDecor'] == true) ...[
                  const SizedBox(height: 16),
                  ProfessionalInput(
                    label: 'Wedding Decor Price (£)',
                    controller: controller.weddingDecorPriceController,
                    hintText: 'Enter price',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                ],
              ],
            )),

        const SizedBox(height: 20),

        // Party Lighting
        Obx(() => Column(
              children: [
                _buildFeatureCheckbox('Party Lighting System',
                    controller.eventsFeatures, 'partyLightingSystem'),
                if (controller.eventsFeatures['partyLightingSystem'] ==
                    true) ...[
                  const SizedBox(height: 16),
                  ProfessionalInput(
                    label: 'Party Lighting Price (£)',
                    controller: controller.partyLightingPriceController,
                    hintText: 'Enter price',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                ],
              ],
            )),

        const SizedBox(height: 20),

        // Champagne Packages
        Obx(() => Column(
              children: [
                _buildFeatureCheckbox('Champagne Packages',
                    controller.eventsFeatures, 'champagnePackages'),
                if (controller.eventsFeatures['champagnePackages'] == true) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ProfessionalInput(
                          label: 'Package Price (£)',
                          controller:
                              controller.champagnePackagesPriceController,
                          hintText: 'Enter price',
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ProfessionalInput(
                          label: 'Bottles Included',
                          controller: controller.champagneBottlesController,
                          hintText: '1',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ProfessionalInput(
                    label: 'Champagne Brand',
                    controller: controller.champagneBrandController,
                    hintText: 'Brand name',
                  ),
                  const SizedBox(height: 16),
                  ProfessionalInput(
                    label: 'Package Details',
                    controller: controller.champagnePackageDetailsController,
                    hintText: 'Describe the package...',
                  ),
                ],
              ],
            )),

        const SizedBox(height: 20),

        // Photography Packages
        Obx(() => Column(
              children: [
                _buildFeatureCheckbox('Photography Packages',
                    controller.eventsFeatures, 'photographyPackages'),
                if (controller.eventsFeatures['photographyPackages'] ==
                    true) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ProfessionalInput(
                          label: 'Package Price (£)',
                          controller:
                              controller.photographyPackagePriceController,
                          hintText: 'Enter price',
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ProfessionalInput(
                          label: 'Duration',
                          controller: controller.photographyDurationController,
                          hintText: '2 hours',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ProfessionalInput(
                          label: 'Team Size',
                          controller: controller.photographyTeamSizeController,
                          hintText: '2 photographers',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ProfessionalInput(
                          label: 'Delivery Time',
                          controller:
                              controller.photographyDeliveryTimeController,
                          hintText: 'e.g., 2 weeks',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ProfessionalInput(
                    label: 'Package Details',
                    controller: controller.photographyPackageDetailsController,
                    hintText: 'Describe the photography package...',
                  ),
                ],
              ],
            )),

        const SizedBox(
          height: 24,
        ),

        _buildStepHeader(context, 'Accessibility & Security',
            'Special services and security features'),

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
            _buildAccessibilityFeature(
                'Wheelchair Access Vehicle',
                'wheelchairAccessVehicle',
                controller.wheelchairAccessPriceController),
            _buildAccessibilityFeature('Child Car Seats', 'childCarSeats',
                controller.childCarSeatsPriceController),
            _buildAccessibilityFeature('Pet Friendly Service',
                'petFriendlyService', controller.petFriendlyPriceController),
            _buildAccessibilityFeature(
                'Disabled Access Ramp',
                'disabledAccessRamp',
                controller.disabledAccessRampPriceController),
            _buildAccessibilityFeature(
                'Senior Friendly Assistance',
                'seniorFriendlyAssistance',
                controller.seniorAssistancePriceController),
            _buildAccessibilityFeature(
                'Stroller/Buggy Storage',
                'strollerBuggyStorage',
                controller.strollerStoragePriceController),
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
            _buildFeatureCheckbox('Vehicle Tracking GPS',
                controller.securityFeatures, 'vehicleTrackingGps'),
            _buildFeatureCheckbox(
                'CCTV Fitted', controller.securityFeatures, 'cctvFitted'),
            _buildFeatureCheckbox('Public Liability Insurance',
                controller.securityFeatures, 'publicLiabilityInsurance'),
            _buildFeatureCheckbox('Safety Certified Drivers',
                controller.securityFeatures, 'safetyCertifiedDrivers'),
          ],
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
            'Upload high-quality images of your boat'),

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
          'Upload high-quality images of your vessel. Show exterior, interior, and key features.',
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

  Widget _buildDateField(BuildContext context, String label, Rx<DateTime> date,
      {bool allowFutureDates = true}) {
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
              initialDate: allowFutureDates
                  ? date.value
                  : (date.value.isAfter(today) ? today : date.value),
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
        return Icons.insert_drive_file;
    }
  }
}
