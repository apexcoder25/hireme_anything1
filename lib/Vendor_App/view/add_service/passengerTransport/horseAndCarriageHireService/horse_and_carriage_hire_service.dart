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

// Horse and Carriage Controller
class HorseAndCarriageController extends GetxController {
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
  final TextEditingController baseLocationController = TextEditingController();
  final TextEditingController carriageTypeController = TextEditingController();
  final TextEditingController numberOfCarriagesController = TextEditingController();
  final TextEditingController numberOfHorsesController = TextEditingController();
  final TextEditingController seatingCapacityController = TextEditingController();
  final TextEditingController hourlyRateController = TextEditingController();
  final TextEditingController halfDayRateController = TextEditingController();
  final TextEditingController fullDayRateController = TextEditingController();
  final TextEditingController locationRadiusController = TextEditingController();
  final TextEditingController searchCitiesController = TextEditingController();
  final TextEditingController serviceDescriptionController = TextEditingController();
  
  // Additional pricing controllers to match chauffeur service
  final TextEditingController mileageLimitController = TextEditingController(text: '0');
  final TextEditingController weddingPackageController = TextEditingController();
  final TextEditingController airportTransferController = TextEditingController();
  final TextEditingController depositController = TextEditingController();
  final TextEditingController waitingChargesController = TextEditingController();
  final TextEditingController extraMileageChargeController = TextEditingController();

  // Package controllers
  final TextEditingController packageNameController = TextEditingController();
  final TextEditingController packageRateController = TextEditingController();
  final TextEditingController packageDescriptionController = TextEditingController();

  // Observable selections
  var selectedCarriageType = 'Glass Coach'.obs;
  var selectedServiceStatus = 'open'.obs;
  var selectedCancellationPolicy = 'FLEXIBLE'.obs;

  // Document storage for API
  RxList<DocumentFile> operatorLicenceDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> publicLiabilityDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> animalLicenseDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> riskAssessmentDocs = <DocumentFile>[].obs;
  RxList<DocumentFile> serviceImages = <DocumentFile>[].obs;
  RxList<DocumentFile> companyLogoDocs = <DocumentFile>[].obs;

  // Areas management
  RxList<String> selectedAreas = <String>[].obs;
  RxList<String> filteredCities = <String>[].obs;

  // Horse Breeds
  var selectedHorseBreeds = <String>[].obs;
  final List<String> horseBreedsOptions = [
    'Clydesdale', 'Shire', 'Friesian', 'Percheron', 'Belgian', 
    'Suffolk Punch', 'Ardennes', 'Other'
  ];

  // Horse Colors
  var selectedHorseColors = <String>[].obs;
  final List<String> horseColorsOptions = [
    'Black', 'Bay', 'Chestnut', 'Gray/Grey', 'Palomino', 
    'Pinto', 'Dun', 'Other'
  ];

  // Decoration Options
  var selectedDecorationOptions = <String>[].obs;
  final List<String> decorationOptions = [
    'Floral Arrangements', 'Ribbon Decorations', 'Traditional Tack', 
    'Bells', 'Feathered Plumes', 'Custom Signage', 'Seasonal Themes', 'Other'
  ];

  // Service Types
  var selectedServiceTypes = <String>[].obs;
  final List<String> serviceTypeOptions = [
    'Wedding Carriage Hire', 'Funeral Carriage Hire', 'Prom / Special Occasion Hire',
    'Tourist Rides & Tours', 'Corporate / PR Events', 'Other'
  ];

  // Animal Welfare Standards
  var selectedAnimalWelfareStandards = <String>[].obs;
  final List<String> animalWelfareOptions = [
    'Horses vaccinated and groomed regularly',
    'Access to 24/7 veterinary care',
    'Regular rest periods between events',
    'Compliance with RSPCA / DEFRA guidelines',
    'In-house welfare officer or protocol (optional)'
  ];

  // Equipment & Safety
  var carriagesRegularlyMaintained = false.obs;
  var staffTraditionalUniforms = false.obs;
  var preEventVisitsOffered = false.obs;
  
  // Pricing booleans to match chauffeur service
  var fuelIncluded = true.obs;
  var waitingChargesEnabled = false.obs;

  // Fixed Packages
  var packages = <Map<String, dynamic>>[].obs;

  // Terms
  var isAccurateInfo = false.obs;
  var noContactDetailsShared = false.obs;
  var agreeCookiesPolicy = false.obs;
  var agreePrivacyPolicy = false.obs;
  var agreeCancellationPolicy = false.obs;

  // Static data
  final List<String> carriageTypes = [
    'Glass Coach', 'Landau', 'Vis-à-vis', 'Wagonette', 
    'Traditional Open Top', 'Other'
  ];

  final List<String> packageTypes = [
    'Wedding Package', 'Funeral Package', 'Prom Package', 
    'Tourist Ride Package', 'Corporate / PR Event Package', 'Other'
  ];

  final List<String> serviceStatusOptions = ['open', 'close'];
  final List<String> cancellationPolicyOptions = ['FLEXIBLE', 'MODERATE', 'STRICT'];

  // Service controllers
  final ImageController imageController = Get.put(ImageController());
  final CouponController couponController = Get.put(CouponController());
  final CalendarController calendarController = Get.put(CalendarController());

  // Vendor info
  String? vendorId;
  String? categoryId = '676ac544234968d45b494992'; // PassengerTransport category ObjectId
  String? subcategoryId = '676ace13234968d45b4949db'; // Horse and Carriage subcategory ObjectId

  // Pricing details getter - Updated to match API expectations
  Map<String, dynamic> get pricingDetails {
    final hourlyRate = double.tryParse(hourlyRateController.text.trim()) ?? 0;
    final halfDayRate = double.tryParse(halfDayRateController.text.trim()) ?? 0;
    final fullDayRate = double.tryParse(fullDayRateController.text.trim()) ?? 0;
    
    // Ensure at least one rate is non-zero
    final effectiveHourlyRate = hourlyRate > 0 ? hourlyRate : (fullDayRate > 0 ? fullDayRate / 8 : 50.0);
    final effectiveHalfDayRate = halfDayRate > 0 ? halfDayRate : (fullDayRate > 0 ? fullDayRate / 2 : 200.0);
    final effectiveFullDayRate = fullDayRate > 0 ? fullDayRate : (hourlyRate > 0 ? hourlyRate * 8 : 400.0);
    
    return {
      "dayRate": effectiveFullDayRate,  // API expects dayRate
      "hourlyRate": effectiveHourlyRate,
      "halfDayRate": effectiveHalfDayRate,
      "mileageLimit": int.tryParse(mileageLimitController.text.trim()) ?? 100,
      "extraMileageCharge": double.tryParse(extraMileageChargeController.text.trim()) ?? 0,
      "fullDayRate": effectiveFullDayRate,  // Also include fullDayRate
      "fixedPackages": packages.isNotEmpty ? packages.map((pkg) => {
        "packageName": pkg['name'] ?? '',
        "packageDescription": pkg['description'] ?? '',
        "packageRate": pkg['rate'] ?? 0,
      }).toList() : [
        {
          "packageName": "Standard Package",
          "packageDescription": "Basic horse and carriage service",
          "packageRate": effectiveHourlyRate,
        }
      ], // API requires at least one package
    };
  }

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
        calendarController.toDate.value = DateTime.now().add(const Duration(days: 7));
      }
    });
  }

  void _setupListeners() {
    searchCitiesController.addListener(_filterCities);
    hourlyRateController.addListener(() {
      calendarController.setDefaultPrice(double.tryParse(hourlyRateController.text) ?? 0.0);
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
        return await _validateStep3(); // Carriage Details
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
    if (operatorLicenceDocs.isEmpty) {
      _showError('Operator Licence document is required');
      return false;
    }
    if (publicLiabilityDocs.isEmpty) {
      _showError('Public Liability Insurance document is required');
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
    if (numberOfCarriagesController.text.trim().isEmpty ||
        numberOfHorsesController.text.trim().isEmpty ||
        seatingCapacityController.text.trim().isEmpty) {
      _showError('All carriage detail fields are required');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep4() async {
    final hourlyRate = double.tryParse(hourlyRateController.text.trim()) ?? 0;
    final halfDayRate = double.tryParse(halfDayRateController.text.trim()) ?? 0;
    final fullDayRate = double.tryParse(fullDayRateController.text.trim()) ?? 0;

    // At least one pricing field with value > 0 is required
    if (fullDayRate <= 0 && hourlyRate <= 0 && halfDayRate <= 0) {
      _showError('At least one pricing field with a value greater than 0 is required');
      return false;
    }
    
    // Debug print to see what values we have
    print('Pricing validation - Hourly: $hourlyRate, Half Day: $halfDayRate, Full Day: $fullDayRate');
    
    return true;
  }

  Future<bool> _validateStep5() async {
    if (selectedAreas.isEmpty) {
      _showError('Please select at least one coverage area');
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

  Future<bool> _validateStep7() async {
    if (selectedAnimalWelfareStandards.isEmpty) {
      _showError('Please select at least one animal welfare standard');
      return false;
    }
    return true;
  }

  Future<bool> _validateStep8() async {
    if (serviceImages.length < 3) {
      _showError('Minimum 3 high-quality service images are required');
      return false;
    }
    
    // Enhanced company logo validation
    if (companyLogoDocs.isEmpty) {
      _showError('Company logo is required');
      return false;
    }
    
   
    
    if (serviceDescriptionController.text.trim().isEmpty) {
      _showError('Service description is required');
      return false;
    }
    
    // Debug: Print logo information
    print('Company Logo Validation - Count: ${companyLogoDocs.length}, Uploaded: ${companyLogoDocs.isNotEmpty ? companyLogoDocs.first.isUploaded : false}, URL: ${companyLogoDocs.isNotEmpty ? companyLogoDocs.first.uploadUrl : 'None'}');
    
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
  Future<void> pickDocument(RxList<DocumentFile> documentList, {String? docType}) async {
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

  // Package management
  void addPackage() {
    if (packageNameController.text.trim().isNotEmpty &&
        packageRateController.text.trim().isNotEmpty &&
        packageDescriptionController.text.trim().isNotEmpty) {
      packages.add({
        'name': packageNameController.text.trim(),
        'rate': double.tryParse(packageRateController.text.trim()) ?? 0.0,
        'description': packageDescriptionController.text.trim(),
      });
      
      // Clear controllers
      packageNameController.clear();
      packageRateController.clear();
      packageDescriptionController.clear();
    }
  }

  void removePackage(int index) {
    if (index < packages.length) {
      packages.removeAt(index);
    }
  }

  // Enhanced form submission
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

        // Debug: Print pricing data being sent to API
        print('=== HORSE CARRIAGE API PAYLOAD DEBUG ===');
        print('Direct Rates - Hourly: ${formData['hourlyRate']}, Half: ${formData['halfDayRate']}, Full: ${formData['fullDayRate']}');
        print('PricingDetails: ${formData['pricingDetails']}');
        print('HorseCarriageRates: ${formData['horseCarriageRates']}');
        print('Pricing Object: ${formData['pricing']}');
        print('Fixed Packages: ${formData['pricing']['fixedPackages']}');
        print('Full Payload Keys: ${formData.keys.toList()}');
        print('=========================================');

        // Submit to API
        final api = AddVendorServiceApi();
        final isAdded = await api.addServiceVendor(formData, 'horseCarriage');

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
    await _uploadDocumentList(publicLiabilityDocs);
    await _uploadDocumentList(animalLicenseDocs);
    await _uploadDocumentList(riskAssessmentDocs);
    await _uploadDocumentList(serviceImages);
    await _uploadDocumentList(companyLogoDocs);
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

  // Prepare API payload to match exact expected structure
  Future<Map<String, dynamic>> _prepareAPIPayload() async {
    final hourlyRate = double.tryParse(hourlyRateController.text.trim()) ?? 0;
    final halfDayRate = double.tryParse(halfDayRateController.text.trim()) ?? 0;
    final fullDayRate = double.tryParse(fullDayRateController.text.trim()) ?? 0;
    
    // Debug print
    print('API Payload Pricing - Hourly: $hourlyRate, Half Day: $halfDayRate, Full Day: $fullDayRate');
    
    // VALIDATION: Ensure at least one pricing field has a reasonable value
    if (hourlyRate <= 0 && halfDayRate <= 0 && fullDayRate <= 0) {
      throw Exception('At least one pricing field (Hourly, Half Day, or Full Day) must have a value greater than 0');
    }
    
    // Additional validation: Ensure rates are reasonable (minimum £1)
    if (hourlyRate > 0 && hourlyRate < 1) {
      throw Exception('Hourly rate must be at least £1');
    }
    if (halfDayRate > 0 && halfDayRate < 1) {
      throw Exception('Half day rate must be at least £1');
    }
    if (fullDayRate > 0 && fullDayRate < 1) {
      throw Exception('Full day rate must be at least £1');
    }
    
    // Ensure effective rates for API submission
    final effectiveHourlyRate = hourlyRate > 0 ? hourlyRate : (fullDayRate > 0 ? fullDayRate / 8 : 50.0);
    final effectiveHalfDayRate = halfDayRate > 0 ? halfDayRate : (fullDayRate > 0 ? fullDayRate / 2 : 200.0);
    final effectiveFullDayRate = fullDayRate > 0 ? fullDayRate : (hourlyRate > 0 ? hourlyRate * 8 : 400.0);
    
    return {
      "vendorId": vendorId ?? "68eb757c758ef700653aada8",
      "listingTitle": listingTitleController.text.trim(),
      "baseLocationPostcode": baseLocationController.text.trim(),
      "locationRadius": int.tryParse(locationRadiusController.text.trim()) ?? 50,
      "areasCovered": selectedAreas.toList(),
      
      "fleetInfo": {
        "makeAndModel": "",
        "seats": int.tryParse(seatingCapacityController.text.trim()) ?? 4,
        "luggageCapacity": 2,
        "firstRegistration": null,
      },
      
      // CRITICAL: API might expect specific rate structure
      "rates": {
        "hourlyRate": effectiveHourlyRate,
        "halfDayRate": effectiveHalfDayRate,
        "fullDayRate": effectiveFullDayRate,
        "dayRate": effectiveFullDayRate,
      },
      
      // Root level pricing fields
      "hourlyRate": effectiveHourlyRate,
      "halfDayRate": effectiveHalfDayRate, 
      "fullDayRate": effectiveFullDayRate,
      "dayRate": effectiveFullDayRate,
      "hasPricing": true,
      
      // Standard pricing details structure
      "pricingDetails": {
        "dayRate": effectiveFullDayRate,
        "hourlyRate": effectiveHourlyRate,
        "halfDayRate": effectiveHalfDayRate,
        "mileageLimit": int.tryParse(mileageLimitController.text.trim()) ?? 100,
        "extraMileageCharge": double.tryParse(extraMileageChargeController.text.trim()) ?? 0,
        "fullDayRate": effectiveFullDayRate,
        "fixedPackages": packages.isNotEmpty ? packages.map((pkg) => {
          "packageName": pkg['name'] ?? '',
          "packageDescription": pkg['description'] ?? '',
          "packageRate": pkg['rate'] ?? 0,
        }).toList() : [
          {
            "packageName": "Standard Package",
            "packageDescription": "Basic horse and carriage service",
            "packageRate": effectiveHourlyRate,
          }
        ], // API requires at least one package
      },
      
      "features": {
        "comfort": {
          "leatherInterior": false,
          "wifiAccess": false,
          "airConditioning": false,
          "complimentaryDrinks": {
            "available": false
          },
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
          "champagneBrand": "",
          "champagneBottles": 1,
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
        },
      },
      
      "service_status": selectedServiceStatus.value,
      "booking_date_from": calendarController.fromDate.value.toIso8601String(),
      "booking_date_to": calendarController.toDate.value.toIso8601String(),
      "special_price_days": calendarController.specialPrices
          .map((e) => {
                'date': DateFormat('yyyy-MM-dd').format(e['date'] as DateTime),
                'price': (e['price'] as num?)?.toDouble() ?? 0.0
              })
          .toList(),
      "cancellation_policy_type": selectedCancellationPolicy.value,
      
      "documents": {
        "operatorLicence": {
          "isAttached": operatorLicenceDocs.isNotEmpty,
          "image": operatorLicenceDocs.isNotEmpty && operatorLicenceDocs.first.isUploaded 
              ? (operatorLicenceDocs.first.uploadUrl ?? '') : '',
          "fileName": operatorLicenceDocs.isNotEmpty ? operatorLicenceDocs.first.name : '',
          "fileType": operatorLicenceDocs.isNotEmpty ? 'image/${operatorLicenceDocs.first.type}' : '',
          "uploadedAt": DateTime.now().toIso8601String(),
        },
        "publicLiabilityInsurance": {
          "isAttached": publicLiabilityDocs.isNotEmpty,
          "image": publicLiabilityDocs.isNotEmpty && publicLiabilityDocs.first.isUploaded
              ? (publicLiabilityDocs.first.uploadUrl ?? '') : '',
          "fileName": publicLiabilityDocs.isNotEmpty ? publicLiabilityDocs.first.name : '',
          "fileType": publicLiabilityDocs.isNotEmpty ? 'image/${publicLiabilityDocs.first.type}' : '',
          "uploadedAt": DateTime.now().toIso8601String(),
        },
      },
      
      "service_image": serviceImages
          .where((img) => img.isUploaded && img.uploadUrl != null && img.uploadUrl!.isNotEmpty)
          .map((img) => img.uploadUrl!)
          .toList(),
      
      "coupons": couponController.coupons.isNotEmpty
          ? couponController.coupons
              .where((coupon) => (coupon['coupon_code']?.toString().trim().isNotEmpty ?? false))
              .map((coupon) => {
                    "coupon_code": coupon['coupon_code']?.toString().trim() ?? '',
                    "discount_type": (coupon['discount_type']?.toString().toUpperCase() ?? 'PERCENTAGE'),
                    "discount_value": (coupon['discount_value'] as num?) ?? 0,
                    "usage_limit": (coupon['usage_limit'] as num?) ?? 1,
                    "expiry_date": coupon['expiry_date'] != null
                        ? DateFormat('yyyy-MM-dd').format(DateTime.parse(coupon['expiry_date'].toString()))
                        : DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 30))),
                    "is_global": (coupon['is_global'] as bool?) ?? false,
                    "minimum_days": (coupon['minimum_days'] as num?) ?? 1,
                    "minimum_vehicles": (coupon['minimum_vehicles'] as num?) ?? 1,
                    "description": (coupon['description']?.toString().trim() ?? ''),
                  })
              .toList()
          : [],
      
      "category": "PassengerTransport",
      "sub_category": "Horse and Carriage Hire",
      "categoryId": categoryId,
      "subcategoryId": subcategoryId,
      "regularlyMaintained": carriagesRegularlyMaintained.value,
      "traditionalUniforms": staffTraditionalUniforms.value,
      "preEventVisits": preEventVisitsOffered.value,
      "animalWelfareStandards": selectedAnimalWelfareStandards.toList(),
      "serviceDescription": serviceDescriptionController.text.trim(),
      "serviceTypes": selectedServiceTypes.toList(),
      "otherServiceType": "",
      
      "carriageDetails": {
        "carriageType": selectedCarriageType.value,
        "numberOfCarriages": int.tryParse(numberOfCarriagesController.text.trim()) ?? 1,
        "horseCount": int.tryParse(numberOfHorsesController.text.trim()) ?? 1,
        "horseBreeds": selectedHorseBreeds.toList(),
        "horseColors": selectedHorseColors.toList(),
        "otherHorseBreed": "",
        "otherHorseColor": "",
        "seats": int.tryParse(seatingCapacityController.text.trim()) ?? 4,
        "decorationOptions": selectedDecorationOptions.toList(),
        "otherDecoration": "",
      },
      
      "marketing": {
        "companyLogo": companyLogoDocs.isNotEmpty && companyLogoDocs.first.isUploaded && companyLogoDocs.first.uploadUrl != null && companyLogoDocs.first.uploadUrl!.isNotEmpty
            ? companyLogoDocs.first.uploadUrl!
            : "https://via.placeholder.com/200x200.png?text=Company+Logo", // Fallback logo
        "description": serviceDescriptionController.text.trim().isNotEmpty ? serviceDescriptionController.text.trim() : "Professional horse and carriage service",
      },
      
      "service_name": listingTitleController.text.trim(),
      "basePostcode": baseLocationController.text.trim(),
      
      // CRITICAL: Try exact "pricing" structure that API expects
      "pricing": {
        "hourlyRate": effectiveHourlyRate,
        "halfDayRate": effectiveHalfDayRate,
        "fullDayRate": effectiveFullDayRate,
        "dayRate": effectiveFullDayRate,
        "deposit": double.tryParse(depositController.text.trim()) ?? 0,
        "mileageLimit": int.tryParse(mileageLimitController.text.trim()) ?? 100,
        "extraMileageCharge": double.tryParse(extraMileageChargeController.text.trim()) ?? 0,
        "waitingCharges": waitingChargesEnabled.value ? double.tryParse(waitingChargesController.text.trim()) ?? 0 : 0,
        "weddingPackage": double.tryParse(weddingPackageController.text.trim()) ?? 0,
        "airportTransfer": double.tryParse(airportTransferController.text.trim()) ?? 0,
        "fixedPackages": packages.isNotEmpty ? packages.map((pkg) => {
          "packageName": pkg['name'] ?? '',
          "packageDescription": pkg['description'] ?? '',
          "packageRate": pkg['rate'] ?? 0,
        }).toList() : [
          {
            "packageName": "Standard Package",
            "packageDescription": "Basic horse and carriage service",
            "packageRate": effectiveHourlyRate,
          }
        ], // API requires at least one package
      },
      
      // Service-specific rates structure (similar to boatRates)
      "horseCarriageRates": {
        "hourlyRate": effectiveHourlyRate,
        "halfDayRate": effectiveHalfDayRate,
        "fullDayRate": effectiveFullDayRate,
        "deposit": double.tryParse(depositController.text.trim()) ?? 0,
        "mileageLimit": int.tryParse(mileageLimitController.text.trim()) ?? 0,
        "extraMileageCharge": double.tryParse(extraMileageChargeController.text.trim()) ?? 0,
        "waitingCharges": waitingChargesEnabled.value ? double.tryParse(waitingChargesController.text.trim()) ?? 0 : 0,
        "weddingPackage": double.tryParse(weddingPackageController.text.trim()) ?? 0,
        "airportTransfer": double.tryParse(airportTransferController.text.trim()) ?? 0,
      },
      
      // REMOVED DUPLICATE "pricing" block to prevent server confusion
      // Only pricingDetails should be present
      
      "images": serviceImages
          .where((img) => img.isUploaded && img.uploadUrl != null && img.uploadUrl!.isNotEmpty)
          .map((img) => img.uploadUrl!)
          .toList(),
    };
  }
  void _showSubmissionProgress() {
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
                'Submitting Your Horse & Carriage Service',
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
      'Your horse & carriage service has been submitted successfully! Our team will review it and publish within 24 hours.',
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
    final citiesToAdd = filteredCities.isNotEmpty ? filteredCities.toList() : Cities.ukCities;
    selectedAreas.addAll(citiesToAdd);
    update(); // Force UI update
  }

  void clearAllAreas() {
    selectedAreas.clear();
    update(); // Force UI update
  }

  void toggleArea(String area) {
    if (selectedAreas.contains(area)) {
      selectedAreas.remove(area);
    } else {
      selectedAreas.add(area);
    }
    update(); // Force UI update
  }

  // Special pricing dialog method
  void _showSetPriceDialog(DateTime selectedDay) {
    final priceController = TextEditingController();
    
    Get.dialog(
      AlertDialog(
        title: Text('Set Special Price for ${DateFormat('EEE, d MMM yyyy').format(selectedDay)}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
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

  // Calendar cell builder
  Widget _buildCalendarCell(DateTime day, bool isVisible) {
    final specialPrice = calendarController.specialPrices
        .where((entry) => DateFormat('yyyy-MM-dd').format(entry['date'] as DateTime) == DateFormat('yyyy-MM-dd').format(day))
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

  // Progress calculation
  double get progressPercentage => currentStep.value / 10;
  String get progressText => '${(progressPercentage * 100).toInt()}% Complete';

  // Step titles
  String getStepTitle(int step) {
    final titles = [
      'Required Documents',
      'Listing Details', 
      'Carriage Details',
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
    carriageTypeController.dispose();
    numberOfCarriagesController.dispose();
    numberOfHorsesController.dispose();
    seatingCapacityController.dispose();
    hourlyRateController.dispose();
    halfDayRateController.dispose();
    fullDayRateController.dispose();
    locationRadiusController.dispose();
    searchCitiesController.dispose();
    serviceDescriptionController.dispose();
    packageNameController.dispose();
    packageRateController.dispose();
    packageDescriptionController.dispose();
    
    // Dispose additional pricing controllers
    mileageLimitController.dispose();
    weddingPackageController.dispose();
    airportTransferController.dispose();
    depositController.dispose();
    waitingChargesController.dispose();
    extraMileageChargeController.dispose();
    
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
                          'Horse & Carriage Form',
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
  final String value;
  final List<String> items;
  final void Function(String?) onChanged;
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
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(value) ? value : null,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
              hint: Text(
                'Select $label',
                style: const TextStyle(color: AppColors.grey500),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Main Horse and Carriage Hire Service Screen
class HorseAndCarriageHireService extends StatelessWidget {
  final Rxn<String> Category;
  final Rxn<String> SubCategory;
  final String? CategoryId;
  final String? SubCategoryId;

  const HorseAndCarriageHireService({
    super.key,
    required this.Category,
    required this.SubCategory,
    this.CategoryId,
    this.SubCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HorseAndCarriageController());
    controller.categoryId = CategoryId;
    controller.subcategoryId = SubCategoryId;

    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: Column(
        children: [
          // Progress Bar Header
          Obx(() => ProfessionalProgressBar(
                currentStep: controller.currentStep.value,
                totalSteps: 10,
                stepTitle: controller.getStepTitle(controller.currentStep.value),
              )),
          
          // Main Content
          Expanded(
            child: Obx(() {
              if (controller.isNavigating.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.btnColor),
                  ),
                );
              }
              
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  child: _buildCurrentStep(context, controller),
                ),
              );
            }),
          ),
          
          // Navigation Buttons
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
    );
  }

  Widget _buildCurrentStep(BuildContext context, HorseAndCarriageController controller) {
    switch (controller.currentStep.value) {
      case 1:
        return _buildStep1(context, controller);
      case 2:
        return _buildStep2(context, controller);
      case 3:
        return _buildStep3(context, controller);
      case 4:
        return _buildStep4(context, controller);
      case 5:
        return _buildStep5(context, controller);
      case 6:
        return _buildStep6(context, controller);
      case 7:
        return _buildStep7(context, controller);
      case 8:
        return _buildStep8(context, controller);
      case 9:
        return _buildStep9(context, controller);
      case 10:
        return _buildStep10(context, controller);
      default:
        return _buildStep1(context, controller);
    }
  }

  // Step 1: Required Documents
  Widget _buildStep1(BuildContext context, HorseAndCarriageController controller) {
    return Column(
      key: const ValueKey('step1'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Required Documents', 
            'Upload essential documents for your service'),

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
              const Icon(Icons.warning_amber_outlined, color: AppColors.error, size: 20),
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
                      'These documents are mandatory for service approval',
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
          'Operator Licence',
          controller.operatorLicenceDocs,
          isRequired: true,
        ),

        const SizedBox(height: 20),

        _buildDocumentUploadSection(
          'Public Liability Insurance',
          controller.publicLiabilityDocs,
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
              const Icon(Icons.info_outline, color: AppColors.primaryDark, size: 20),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2 optional',
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

        _buildDocumentUploadSection('Animal License', controller.animalLicenseDocs),
        const SizedBox(height: 20),
        _buildDocumentUploadSection('Risk Assessment', controller.riskAssessmentDocs),
      ],
    );
  }

  // Step 2: Listing Details
  Widget _buildStep2(BuildContext context, HorseAndCarriageController controller) {
    return Column(
      key: const ValueKey('step2'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Listing Details',
            'Create an attractive listing for customers'),
        ProfessionalInput(
          label: 'Listing Title',
          controller: controller.listingTitleController,
          hintText: 'Example: Royal Horse & Carriage Service',
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
                controller.baseLocationController.text = selection;
              },
              fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                // Initialize with current value
                if (textEditingController.text.isEmpty && controller.baseLocationController.text.isNotEmpty) {
                  textEditingController.text = controller.baseLocationController.text;
                }
                
                // Sync changes back to main controller
                textEditingController.addListener(() {
                  if (controller.baseLocationController.text != textEditingController.text) {
                    controller.baseLocationController.text = textEditingController.text;
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
                    hintText: 'Enter your base location/postcode',
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

  // Step 3: Carriage Details
  Widget _buildStep3(BuildContext context, HorseAndCarriageController controller) {
    return Column(
      key: const ValueKey('step3'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Carriage Details',
            'Specify details about your carriages and horses'),
        
        Obx(() => ProfessionalDropdown(
          label: 'Carriage Type',
          value: controller.selectedCarriageType.value,
          items: controller.carriageTypes,
          onChanged: (value) => controller.selectedCarriageType.value = value ?? '',
          isRequired: true,
        )),
        
        const SizedBox(height: 24),
        
        Row(
          children: [
            Expanded(
              child: ProfessionalInput(
                label: 'Number of Carriages',
                controller: controller.numberOfCarriagesController,
                hintText: 'Enter number',
                keyboardType: TextInputType.number,
                isRequired: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  final num = int.tryParse(value ?? '') ?? 0;
                  if (num < 1) return 'Must be at least 1';
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ProfessionalInput(
                label: 'Number of Horses',
                controller: controller.numberOfHorsesController,
                hintText: 'Enter number',
                keyboardType: TextInputType.number,
                isRequired: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  final num = int.tryParse(value ?? '') ?? 0;
                  if (num < 1) return 'Must be at least 1';
                  return null;
                },
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        ProfessionalInput(
          label: 'Seating Capacity',
          controller: controller.seatingCapacityController,
          hintText: 'Maximum passengers',
          keyboardType: TextInputType.number,
          isRequired: true,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            final num = int.tryParse(value ?? '') ?? 0;
            if (num < 1) return 'Must be at least 1';
            return null;
          },
        ),
        
        const SizedBox(height: 24),
        
        _buildMultiSelectSection('Horse Breeds', controller.horseBreedsOptions, controller.selectedHorseBreeds),
        const SizedBox(height: 24),
        _buildMultiSelectSection('Horse Colors', controller.horseColorsOptions, controller.selectedHorseColors),
        const SizedBox(height: 24),
        _buildMultiSelectSection('Decoration Options', controller.decorationOptions, controller.selectedDecorationOptions),
      ],
    );
  }

  // Step 4: Pricing Details  
  Widget _buildStep4(BuildContext context, HorseAndCarriageController controller) {
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
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                isRequired: true,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ProfessionalInput(
                label: 'Half Day Rate (£)',
                controller: controller.halfDayRateController,
                hintText: 'Enter half day rate',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                isRequired: true,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        ProfessionalInput(
          label: 'Full Day Rate (£)',
          controller: controller.fullDayRateController,
          hintText: 'Enter full day rate',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          isRequired: true,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
          ],
        ),
        
        const SizedBox(height: 32),
        
        // Fixed Packages Section
        _buildFixedPackagesSection(controller),
      ],
    );
  }

  // Step 5: Coverage & Service Status
  Widget _buildStep5(BuildContext context, HorseAndCarriageController controller) {
    return Column(
      key: const ValueKey('step5'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Coverage & Service Status',
            'Define your service area and operational settings'),
        
        ProfessionalInput(
          label: 'Service Radius (miles)',
          controller: controller.locationRadiusController,
          hintText: 'How far from your base location? (Range: 1-500 miles)',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        
        const SizedBox(height: 24),
        
        _buildAreasSelection(context, controller),
        
        const SizedBox(height: 24),
        
        _buildMultiSelectSection('Service Types', controller.serviceTypeOptions, controller.selectedServiceTypes),
        
        const SizedBox(height: 24),
        
        Obx(() => ProfessionalDropdown(
          label: 'Service Status',
          value: controller.selectedServiceStatus.value,
          items: controller.serviceStatusOptions,
          onChanged: (value) => controller.selectedServiceStatus.value = value ?? '',
          isRequired: true,
        )),
      ],
    );
  }

  // Step 6: Service Availability
  Widget _buildStep6(BuildContext context, HorseAndCarriageController controller) {
    return Column(
      key: const ValueKey('step6'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Service Availability', 'Set your availability periods'),

        _buildDateField(context, 'Available From', controller.calendarController.fromDate),
        const SizedBox(height: 16),
        _buildDateField(context, 'Available To', controller.calendarController.toDate),

        const SizedBox(height: 24),

        const Text('Special Pricing Calendar', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 14),
        const Text('Set special prices for specific dates (holidays, peak seasons, events). These will override your standard rates.'),

        const SizedBox(height: 16),

        ProfessionalDropdown(
          label: 'Cancellation Policy',
          value: controller.selectedCancellationPolicy.value,
          items: controller.cancellationPolicyOptions,
          onChanged: (value) => controller.selectedCancellationPolicy.value = value ?? '',
          isRequired: true,
        ),

        const SizedBox(height: 10),
        Obx(() {
          DateTime focusedDay = controller.calendarController.fromDate.value;
          if (focusedDay.isBefore(DateTime.now())) {
            focusedDay = DateTime.now();
          }
          return TableCalendar(
            onDaySelected: (selectedDay, focusedDay) {
              if (controller.calendarController.visibleDates
                  .any((d) => isSameDay(d, selectedDay))) {
                controller._showSetPriceDialog(selectedDay);
              }
            },
            focusedDay: focusedDay,
            firstDay: controller.calendarController.fromDate.value != DateTime(1900) 
              ? controller.calendarController.fromDate.value 
              : DateTime.now(),
            lastDay: controller.calendarController.toDate.value != DateTime(1900) 
              ? controller.calendarController.toDate.value 
              : DateTime.utc(2099, 12, 31),
            calendarFormat: CalendarFormat.month,
            availableGestures: AvailableGestures.none,
            headerStyle: const HeaderStyle(formatButtonVisible: false),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                // Check if the day is within the available date range
                bool isWithinRange = true;
                if (controller.calendarController.fromDate.value != DateTime(1900) && 
                    controller.calendarController.toDate.value != DateTime(1900)) {
                  isWithinRange = !day.isBefore(controller.calendarController.fromDate.value) && 
                                 !day.isAfter(controller.calendarController.toDate.value);
                }
                
                if (isWithinRange && controller.calendarController.visibleDates
                    .any((d) => isSameDay(d, day))) {
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
                                style: const TextStyle(fontSize: 16)),
                            Row(
                              children: [
                                Text('£${price.toStringAsFixed(2)}/day',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: price > 0 ? Colors.black : Colors.red)),
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
                  )),
        ),
      ],
    );
  }

  // Step 7: Features & Services
  Widget _buildStep7(BuildContext context, HorseAndCarriageController controller) {
    return Column(
      key: const ValueKey('step7'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Features & Services',
            'Specify your service features and safety standards'),
        
        // Equipment & Safety
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.grey100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.grey300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Equipment & Safety',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              
              // Carriages regularly maintained
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Are carriages regularly maintained and safety-checked?',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Obx(() => Switch(
                    value: controller.carriagesRegularlyMaintained.value,
                    onChanged: (value) => controller.carriagesRegularlyMaintained.value = value,
                    activeColor: AppColors.btnColor,
                  )),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Staff uniforms
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Staff Attire - Traditional uniforms',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Obx(() => Switch(
                    value: controller.staffTraditionalUniforms.value,
                    onChanged: (value) => controller.staffTraditionalUniforms.value = value,
                    activeColor: AppColors.btnColor,
                  )),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Pre-event visits
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Do you offer pre-event visits or route inspections?',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Obx(() => Switch(
                    value: controller.preEventVisitsOffered.value,
                    onChanged: (value) => controller.preEventVisitsOffered.value = value,
                    activeColor: AppColors.btnColor,
                  )),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        _buildMultiSelectSection('Animal Welfare Standards Met (tick all that apply)', 
            controller.animalWelfareOptions, controller.selectedAnimalWelfareStandards,
            isRequired: true),
        
        const SizedBox(height: 24),
        
        ProfessionalInput(
          label: 'Describe your service and what makes it unique',
          controller: controller.serviceDescriptionController,
          hintText: 'Enter detailed service description...',
          keyboardType: TextInputType.multiline,
          isRequired: true,
        ),
      ],
    );
  }

  // Step 8: Photos & Media
  Widget _buildStep8(BuildContext context, HorseAndCarriageController controller) {
    return Column(
      key: const ValueKey('step8'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Photos & Media',
            'Upload high-quality images and company logo'),
        
        // Service Images Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.grey50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.grey300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Service Images',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    ' *',
                    style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.btnColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Minimum 3 images required',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Upload high-quality images of your vehicle/service. Show exterior, interior, and key features.',
                style: TextStyle(fontSize: 12, color: AppColors.grey600),
              ),
              const SizedBox(height: 16),
              
              _buildImageUploadSection(controller.serviceImages, 'service'),
              
              const SizedBox(height: 16),
              
              // Photo Tips
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.camera_alt, color: Colors.blue.shade700, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'Photo Tips for Better Bookings',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Include exterior shots from multiple angles\n'
                      '• Show interior seating and amenities\n'
                      '• Highlight unique features and luxury elements\n'
                      '• Use good lighting and high resolution\n'
                      '• Avoid blurry or dark images',
                      style: TextStyle(fontSize: 11, color: AppColors.grey700),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Company Logo Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.grey50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.grey300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Company Logo',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    ' *',
                    style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'PNG, JPG, SVG up to 5MB • Recommended: 200x200px',
                style: TextStyle(fontSize: 12, color: AppColors.grey600),
              ),
              const SizedBox(height: 16),
              
              _buildImageUploadSection(controller.companyLogoDocs, 'logo'),
              
              const SizedBox(height: 16),
              
              // Logo Tips
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.palette, color: Colors.green.shade700, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'Logo Best Practices',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Use high-resolution images for crisp display\n'
                      '• Square format (1:1 ratio) works best for consistency\n'
                      '• Ensure your logo is readable at small sizes\n'
                      '• Use transparent backgrounds (PNG) when possible\n'
                      '• Keep file size under 5MB for faster loading',
                      style: TextStyle(fontSize: 11, color: AppColors.grey700),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        ProfessionalInput(
          label: 'Service Description',
          controller: controller.serviceDescriptionController,
          hintText: 'Provide a detailed description of your service...',
          keyboardType: TextInputType.multiline,
          isRequired: true,
        ),
      ],
    );
  }

  Widget _buildStep9(BuildContext context, HorseAndCarriageController controller) {
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
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Add Coupon",
                style: TextStyle(color: Colors.white)),
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
  Widget _buildStep10(BuildContext context, HorseAndCarriageController controller) {
    return Column(
      key: const ValueKey('step10'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(context, 'Terms & Submit',
            'Review and agree to terms before submission'),
        
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.grey50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.grey300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Declaration',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              
              _buildTermsCheckbox(
                context,
                'I confirm all information provided is accurate and up-to-date',
                controller.isAccurateInfo,
                (value) => controller.isAccurateInfo.value = value ?? false,
              ),
              
              _buildTermsCheckbox(
                context,
                'I agree not to share direct contact details in service descriptions',
                controller.noContactDetailsShared,
                (value) => controller.noContactDetailsShared.value = value ?? false,
              ),
              
              _buildTermsCheckboxWithLink(
                context,
                'I agree to the Cookies Policy',
                controller.agreeCookiesPolicy,
                (value) => controller.agreeCookiesPolicy.value = value ?? false,
                'https://stage1.hireanything.com/Cookies_Policy_Hire_Anything_Corrected.pdf',
              ),
              
              _buildTermsCheckboxWithLink(
                context,
                'I agree to the Privacy Policy',
                controller.agreePrivacyPolicy,
                (value) => controller.agreePrivacyPolicy.value = value ?? false,
                'https://stage1.hireanything.com/HireAnything_Privacy_Policy_Corrected.pdf',
              ),
              
              _buildTermsCheckboxWithLink(
                context,
                'I agree to the Cancellation Policy',
                controller.agreeCancellationPolicy,
                (value) => controller.agreeCancellationPolicy.value = value ?? false,
                'https://stage1.hireanything.com/cancellation-fee-policy',
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade600, size: 32),
              const SizedBox(height: 12),
              Text(
                'Ready to Submit!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your horse & carriage service will be reviewed and published within 24 hours.',
                style: TextStyle(fontSize: 13, color: AppColors.grey600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper Widgets

  Widget _buildStepHeader(BuildContext context, String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.btnColor.withOpacity(0.1),
            AppColors.primaryDark.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.btnColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.grey900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.grey600,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentUploadSection(String title, RxList<DocumentFile> documents, {bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w600),
              ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Accepted formats: JPG, PNG, PDF | Max 5MB',
          style: TextStyle(fontSize: 11, color: AppColors.grey500),
        ),
        const SizedBox(height: 12),
        
        Obx(() => Column(
          children: [
            // Display uploaded documents
            ...documents.asMap().entries.map((entry) {
              final index = entry.key;
              final doc = entry.value;
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
                    Icon(
                      _getFileIcon(doc.type),
                      color: AppColors.primaryDark,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doc.name,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            doc.displaySize,
                            style: const TextStyle(fontSize: 11, color: AppColors.grey500),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.find<HorseAndCarriageController>().removeDocument(documents, index),
                      icon: const Icon(Icons.close, color: AppColors.error, size: 18),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    ),
                  ],
                ),
              );
            }).toList(),
            
            // Upload button
            InkWell(
              onTap: () => Get.find<HorseAndCarriageController>().pickDocument(documents),
              child: DottedBorder(
                color: AppColors.btnColor,
                strokeWidth: 2,
                dashPattern: const [6, 3],
                borderType: BorderType.RRect,
                radius: const Radius.circular(8),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: AppColors.btnColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 32,
                        color: AppColors.btnColor.withOpacity(0.7),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Click to upload or drag and drop',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.btnColor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'JPG, PNG, PDF up to 5MB',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.grey500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildMultiSelectSection(String title, List<String> options, RxList<String> selectedItems, {bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w600),
              ),
          ],
        ),
        const SizedBox(height: 12),
        
        Obx(() => Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = selectedItems.contains(option);
            return FilterChip(
              label: Text(
                option,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? AppColors.white : AppColors.grey700,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  selectedItems.add(option);
                } else {
                  selectedItems.remove(option);
                }
              },
              selectedColor: AppColors.btnColor,
              checkmarkColor: AppColors.white,
              backgroundColor: AppColors.grey100,
              side: BorderSide(
                color: isSelected ? AppColors.btnColor : AppColors.grey300,
                width: 1,
              ),
            );
          }).toList(),
        )),
      ],
    );
  }

  Widget _buildAreasSelection(BuildContext context, HorseAndCarriageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Areas Covered',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const Text(
              ' *',
              style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: controller.selectAllAreas,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.btnColor,
                  side: const BorderSide(color: AppColors.btnColor),
                ),
                child: const Text('Select All'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: controller.clearAllAreas,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.grey600,
                  side: const BorderSide(color: AppColors.grey400),
                ),
                child: const Text('Clear All'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        TextField(
          controller: controller.searchCitiesController,
          decoration: InputDecoration(
            hintText: 'Search cities...',
            prefixIcon: const Icon(Icons.search, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        const SizedBox(height: 12),
        
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
              
              return Obx(() {
                final isSelected = controller.selectedAreas.contains(city);
                return CheckboxListTile(
                  title: Text(city, style: const TextStyle(fontSize: 13)),
                  value: isSelected,
                  onChanged: (value) => controller.toggleArea(city),
                  dense: true,
                  controlAffinity: ListTileControlAffinity.leading,
                );
              });
            },
          )),
        ),
        const SizedBox(height: 8),
        
        Obx(() => Text(
          'Selected: ${controller.selectedAreas.length} areas',
          style: const TextStyle(fontSize: 12, color: AppColors.grey600),
        )),
      ],
    );
  }

  Widget _buildFixedPackagesSection(HorseAndCarriageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Fixed Packages',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            TextButton.icon(
              onPressed: () => _showAddPackageDialog(Get.context!, controller),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Package'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.btnColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        Obx(() => Column(
          children: controller.packages.asMap().entries.map((entry) {
            final index = entry.key;
            final package = entry.value;
            
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.grey50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.grey300),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          package['name'] ?? '',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '£${package['rate']?.toStringAsFixed(2) ?? '0.00'}',
                          style: const TextStyle(fontSize: 13, color: AppColors.btnColor, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          package['description'] ?? '',
                          style: const TextStyle(fontSize: 12, color: AppColors.grey600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.removePackage(index),
                    icon: const Icon(Icons.delete, color: AppColors.error, size: 20),
                  ),
                ],
              ),
            );
          }).toList(),
        )),
        
        if (controller.packages.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.grey50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.grey300),
            ),
            child: const Column(
              children: [
                Icon(Icons.inventory_2_outlined, size: 32, color: AppColors.grey400),
                SizedBox(height: 8),
                Text(
                  'No packages added yet',
                  style: TextStyle(fontSize: 14, color: AppColors.grey600),
                ),
                SizedBox(height: 4),
                Text(
                  'Add packages to offer special deals to customers',
                  style: TextStyle(fontSize: 12, color: AppColors.grey500),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildDateField(BuildContext context, String label, Rx<DateTime> dateController, {bool allowFutureDates = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Obx(() => InkWell(
          onTap: () async {
            final DateTime today = DateTime.now();
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: allowFutureDates ? dateController.value : (dateController.value.isAfter(today) ? today : dateController.value),
              firstDate: allowFutureDates ? DateTime.now() : DateTime(1950),
              lastDate: allowFutureDates ? DateTime(2099, 12, 31) : today,
            );
            if (picked != null) {
              dateController.value = picked;
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy').format(dateController.value),
                  style: const TextStyle(fontSize: 14),
                ),
                const Icon(Icons.calendar_today, size: 20, color: AppColors.grey500),
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildImageUploadSection(RxList<DocumentFile> images, String type) {
    return Column(
      children: [
        Obx(() => images.isNotEmpty
          ? Wrap(
              spacing: 8,
              runSpacing: 8,
              children: images.asMap().entries.map((entry) {
                final index = entry.key;
                final image = entry.value;
                
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(image.path),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => Get.find<HorseAndCarriageController>().removeDocument(images, index),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: AppColors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            )
          : const SizedBox.shrink()
        ),
        
        const SizedBox(height: 12),
        
        InkWell(
          onTap: () => Get.find<HorseAndCarriageController>().pickDocument(images),
          child: DottedBorder(
            color: AppColors.btnColor,
            strokeWidth: 2,
            dashPattern: const [6, 3],
            borderType: BorderType.RRect,
            radius: const Radius.circular(8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                color: AppColors.btnColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Icon(
                    type == 'logo' ? Icons.business : Icons.add_photo_alternate,
                    size: 32,
                    color: AppColors.btnColor.withOpacity(0.7),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    type == 'logo' ? 'Choose Logo File' : 'Upload Service Images',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.btnColor.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Click to upload or drag and drop',
                    style: TextStyle(
                      fontSize: 11,
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


  // Helper Methods

  IconData _getFileIcon(String fileType) {
    switch (fileType.toLowerCase()) {
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

  void _showAddPackageDialog(BuildContext context, HorseAndCarriageController controller) {
    Get.dialog(
      AlertDialog(
        title: const Text('Add Package'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Package Type',
                border: OutlineInputBorder(),
              ),
              items: controller.packageTypes.map((type) => 
                DropdownMenuItem(value: type, child: Text(type))
              ).toList(),
              onChanged: (value) => controller.packageNameController.text = value ?? '',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.packageRateController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Package Rate (£)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.packageDescriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Package Description',
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
              controller.addPackage();
              Get.back();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    final controller = Get.find<HorseAndCarriageController>();
    
    return Row(
      children: [
        if (controller.currentStep.value > 1)
          Expanded(
            child: OutlinedButton(
              onPressed: controller.isNavigating.value || controller.isSubmitting.value
                  ? null
                  : () => controller.previousStep(),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.grey700,
                side: const BorderSide(color: AppColors.grey400),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Previous'),
            ),
          ),
        
        if (controller.currentStep.value > 1) const SizedBox(width: 16),
        
        Expanded(
          child: controller.currentStep.value == 10
              ? ElevatedButton(
                  onPressed: controller.isSubmitting.value
                      ? null
                      : () => controller.submitForm(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.btnColor,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: controller.isSubmitting.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Submit Service'),
                )
              : ElevatedButton(
                  onPressed: controller.isNavigating.value || controller.isSubmitting.value
                      ? null
                      : () => controller.nextStep(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.btnColor,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: controller.isNavigating.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Next'),
                ),
        ),
      ],
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
          Obx(() => Checkbox(
            value: value.value,
            onChanged: onChanged,
            activeColor: AppColors.btnColor,
          )),
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

  Widget _buildTermsCheckbox(BuildContext context, String title, RxBool value, 
      Function(bool?) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Obx(() => Checkbox(
            value: value.value,
            onChanged: onChanged,
            activeColor: AppColors.btnColor,
          )),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.grey900,
                height: 1.3,
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
