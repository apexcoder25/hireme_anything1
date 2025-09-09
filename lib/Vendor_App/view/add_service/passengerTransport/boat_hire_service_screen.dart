import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/signup_textfilled.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/custom_checkbox.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/custom_dropdown.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/calenderController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/controller/add_vendor_services_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupanController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupon_list.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupondialog.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/upload_image.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/vendor_home_Page.dart';
import 'package:hire_any_thing/constants_file/uk_cities.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/city_fetch_controller.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/service_controller.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BoatHireService extends StatefulWidget {
  final Rxn<String> Category;
  final Rxn<String> SubCategory;
  final String? CategoryId;
  final String? SubCategoryId;

  const BoatHireService({
    super.key,
    required this.Category,
    required this.SubCategory,
    this.CategoryId,
    this.SubCategoryId,
  });

  @override
  State<BoatHireService> createState() => _BoatHireServiceState();
}

class _BoatHireServiceState extends State<BoatHireService> {
  final ImageController imageController = Get.put(ImageController());
  final CouponController couponController = Get.put(CouponController());
  final CalendarController calenderController = Get.put(CalendarController());
  final CityFetchController cityFetchController =
      Get.put(CityFetchController());

  // Add this for First Registration Date
  final Rx<DateTime> firstRegistrationDate = DateTime.now().obs;

  // Section 1: Business Information
  TextEditingController serviceNameController = TextEditingController();
  bool _isSubmitting = false;

  // Section 2: Boat Hire Service Details
  Map<String, bool> boatTypes = {
    'canalBoat': false,
    'narrowboat': false,
    'dayCruiser': false,
    'luxuryYacht': false,
    'sailboat': false,
    'fishingBoat': false,
    'houseboat': false,
    'partyBoat': false,
    'rib': false,
    'selfDrive': false,
    'skipperedStaffed': false,
    'other': false,
  };
  TextEditingController otherBoatTypeController = TextEditingController();
  Map<String, bool> typicalUseCases = {
    'privateHire': false,
    'familyTrips': false,
    'corporateEvents': false,
    'henStagParties': false,
    'birthdayParties': false,
    'weddingsProposals': false,
    'fishingTrips': false,
    'sightseeingTours': false,
    'overnightStays': false,
    'other': false,
  };
  TextEditingController otherUseCaseController = TextEditingController();

  // Section 3: Fleet Information
  TextEditingController fleetSizeController = TextEditingController();
  TextEditingController boatNameController = TextEditingController();
  TextEditingController boatTypeController = TextEditingController();
  TextEditingController onboardFeaturesController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController luggageCapacityController = TextEditingController();
  TextEditingController numberOfSeatsController = TextEditingController();

  // Section 3: Locations & Booking Info
  RxString departurePoints = ''.obs;
  RxList<String> navigableRoutes = <String>[].obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController departureSearchController = TextEditingController();
  TextEditingController basePostcodeController = TextEditingController();
  TextEditingController locationRadiusController = TextEditingController();
  TextEditingController hourlyRateController = TextEditingController();
  TextEditingController halfDayRateController = TextEditingController();
  TextEditingController fullDayRateController = TextEditingController();
  TextEditingController overnightCharterRateController =
      TextEditingController();
  TextEditingController packageDealsController = TextEditingController();
  TextEditingController cateringDescriptionController = TextEditingController();
  final TextEditingController perMileRateController = TextEditingController();
  final TextEditingController tenHourDayRateController =
      TextEditingController();

  // Additional Info
  String? advanceBooking;
  bool yearRound = true;
  bool seasonal = false;
  String? seasonStart;
  String? seasonEnd;
  Map<String, bool> bookingOptions = {
    'hourly': false,
    'halfDay': false,
    'fullDay': false,
    'multiDay': false,
    'overnightStay': false,
  };
  bool cateringEntertainmentOffered = false;
  bool licenseRequired = false;

  // Comfort & Luxury
  bool leatherInterior = false;
  bool wifiAccess = false;
  bool airConditioning = false;
  bool complimentaryDrinks = false;
  bool inBoatEntertainment = false;
  bool bluetoothUSB = false;
  bool redCarpetService = false;
  bool onboardRestroom = false;

  // Events & Extras
  bool weddingDecor = false;
  bool partyLighting = false;
  bool champagnePackages = false;
  bool photographyPackages = false;

  // Accessibility & Special Services
  bool wheelchairAccess = false;
  bool childCarSeats = false;
  bool petFriendlyService = false;
  bool disabledAccessRamp = false;
  bool seniorFriendlyAssistance = false;
  bool strollerStorage = false;

  // Security & Compliance
  bool vehicleTracking = false;
  bool cctvFitted = false;
  bool publicLiabilityInsurance = false;
  bool safetyCertifiedDrivers = false;

  // Section 4: Licensing & Insurance
  TextEditingController publicLiabilityInsuranceProviderController =
      TextEditingController();
  TextEditingController vesselInsuranceProviderController =
      TextEditingController();
  TextEditingController insuranceProviderController = TextEditingController();
  TextEditingController policyNumberController = TextEditingController();
  TextEditingController policyExpiryDateController = TextEditingController();
  TextEditingController makeModelController = TextEditingController();
  String? cancellationPolicy;
  String? serviceStatus;

  // Section 5: Document Upload
  RxList<String> interiorPhotosPaths = <String>[].obs;
  RxList<String> exteriorPhotosPaths = <String>[].obs;
  RxList<String> onWaterViewPhotosPaths = <String>[].obs;
  RxList<String> vesselInsuranceDocPaths = <String>[].obs;
  RxList<String> publicLiabilityInsuranceDocPaths = <String>[].obs;
  RxList<String> localAuthorityLicencePaths = <String>[].obs;

  List<String> interiorImages = [];
  List<String> exteriorImages = [];
  List<String> onWaterViewImages = [];

  // Section 6: Business Highlights
  TextEditingController uniqueFeaturesController = TextEditingController();
  TextEditingController promotionalDescriptionController =
      TextEditingController();

  // Section 7: Declaration & Agreement
  bool isAccurateInfo = false;
  bool noContactDetailsShared = false;
  bool agreeCookiesPolicy = false;
  bool agreePrivacyPolicy = false;
  bool agreeCancellationPolicy = false;

  final Map<String, String> cancellationPolicyMap = {
    'Flexible-Full refund if canceled 48+ hours in advance': 'FLEXIBLE',
    'Moderate-Full refund if canceled 72+ hours in advance': 'MODERATE',
    'Strict-Full refund if canceled 7+ days in advance': 'STRICT',
  };
  final Map<String, String> serviceStatusMap = {
    'Open': '1',
    'Close': '0',
  };

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String? hireOption;
  String? vendorId;
  bool hireOptionSkippered = false;

  final GlobalKey<FormState> _boatHireFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadVendorId();
    hourlyRateController.addListener(() {
      calenderController
          .setDefaultPrice(double.tryParse(hourlyRateController.text) ?? 0.0);
    });
    searchController.addListener(() {
      cityFetchController.onTextChanged(searchController.text);
    });
    departureSearchController.addListener(() {
      cityFetchController.onTextChanged(departureSearchController.text);
    });
  }

  @override
  void dispose() {
    serviceNameController.dispose();
    imageController.dispose();
    couponController.dispose();
    calenderController.dispose();
    fleetSizeController.dispose();
    boatNameController.dispose();
    boatTypeController.dispose();
    onboardFeaturesController.dispose();
    capacityController.dispose();
    yearController.dispose();
    notesController.dispose();
    searchController.dispose();
    departureSearchController.dispose();
    hourlyRateController.dispose();
    halfDayRateController.dispose();
    fullDayRateController.dispose();
    overnightCharterRateController.dispose();
    packageDealsController.dispose();
    cateringDescriptionController.dispose();
    publicLiabilityInsuranceProviderController.dispose();
    vesselInsuranceProviderController.dispose();
    insuranceProviderController.dispose();
    policyNumberController.dispose();
    policyExpiryDateController.dispose();
    uniqueFeaturesController.dispose();
    promotionalDescriptionController.dispose();
    otherBoatTypeController.dispose();
    otherUseCaseController.dispose();
    hourlyRateController.removeListener(() {});
    searchController.removeListener(() {});
    departureSearchController.removeListener(() {});
    imageController.selectedImages.clear();
    imageController.uploadedUrls.clear();
    makeModelController.dispose();
    luggageCapacityController.dispose();
    numberOfSeatsController.dispose();
    interiorPhotosPaths.clear();
    exteriorPhotosPaths.clear();
    onWaterViewPhotosPaths.clear();
    vesselInsuranceDocPaths.clear();
    publicLiabilityInsuranceDocPaths.clear();
    localAuthorityLicencePaths.clear();
    couponController.coupons.clear();
    calenderController.specialPrices.clear();
    calenderController.visibleDates.clear();
    calenderController.fromDate.value = DateTime.now();
    calenderController.toDate.value = DateTime.now();
    super.dispose();
  }

  Future<void> _loadVendorId() async {
    vendorId = await SessionVendorSideManager().getVendorId();
    setState(() {});
  }

  Future<bool> _uploadDocuments() async {
    try {
      imageController.selectedImages.clear();
      imageController.uploadedUrls.clear();

      if (interiorPhotosPaths.isNotEmpty) {
        imageController.selectedImages.add(interiorPhotosPaths.first);
      }
      if (exteriorPhotosPaths.isNotEmpty) {
        imageController.selectedImages.add(exteriorPhotosPaths.first);
      }
      if (onWaterViewPhotosPaths.isNotEmpty) {
        imageController.selectedImages.add(onWaterViewPhotosPaths.first);
      }
      if (vesselInsuranceDocPaths.isNotEmpty) {
        imageController.selectedImages.add(vesselInsuranceDocPaths.first);
      }
      if (publicLiabilityInsuranceDocPaths.isNotEmpty) {
        imageController.selectedImages
            .add(publicLiabilityInsuranceDocPaths.first);
      }
      if (localAuthorityLicencePaths.isNotEmpty) {
        imageController.selectedImages.add(localAuthorityLicencePaths.first);
      }

      for (var path in imageController.selectedImages) {
        await imageController.uploadToCloudinary(path);
      }

      return true;
    } catch (e) {
      Get.snackbar(
        "Upload Error",
        "Failed to upload documents: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return false;
    }
  }

  Future<void> _submitForm() async {
    try {
      if (!_boatHireFormKey.currentState!.validate()) {
        Get.snackbar(
            "Validation Error", "Please fill all required fields correctly.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
        return;
      }

      if (departurePoints.value.isEmpty) {
        Get.snackbar("Missing Information", "Departure point is required.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
        return;
      }
      if (hireOption == null || hireOption!.isEmpty) {
        Get.snackbar("Missing Information", "Hire type is required.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
        return;
      }

      if (navigableRoutes.isEmpty) {
        Get.snackbar(
            "Missing Information", "At least one navigable route is required.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
        return;
      }

      final hourlyRate = double.tryParse(hourlyRateController.text.trim()) ?? 0;
      final halfDayRate =
          double.tryParse(halfDayRateController.text.trim()) ?? 0;
      final fullDayRate =
          double.tryParse(fullDayRateController.text.trim()) ?? 0;
      final overnightRate =
          double.tryParse(overnightCharterRateController.text.trim()) ?? 0;

      if (hourlyRate == 0 &&
          halfDayRate == 0 &&
          fullDayRate == 0 &&
          overnightRate == 0) {
        Get.snackbar(
            "Missing Information", "At least one boat rate must be provided.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
        return;
      }

      if (cancellationPolicy == null || cancellationPolicy!.isEmpty) {
        Get.snackbar("Missing Information", "Cancellation policy is required.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
        return;
      }

      if (interiorPhotosPaths.isEmpty ||
          exteriorPhotosPaths.isEmpty ||
          onWaterViewPhotosPaths.isEmpty) {
        Get.snackbar(
            "Missing Information", "All document uploads are required.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
        return;
      }

      if (!isAccurateInfo ||
          !noContactDetailsShared ||
          !agreeCookiesPolicy ||
          !agreePrivacyPolicy ||
          !agreeCancellationPolicy) {
        Get.snackbar("Missing Information", "Please agree to all declarations.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
        return;
      }

      final documentsUploaded = await _uploadDocuments();
      if (!documentsUploaded) {
        return;
      }

      final data = {
        "vendorId": vendorId,
        "categoryId": widget.CategoryId,
        "subcategoryId": widget.SubCategoryId,
        "service_name": serviceNameController.text.trim(),
        "boatType": otherBoatTypeController.text.trim(),
        "makeAndModel": makeModelController.text.trim(),
        "firstRegistered": firstRegistrationDate.value.toIso8601String(),
        "luggageCapacity":
            int.tryParse(luggageCapacityController.text.trim()) ?? 0,
        "seats": int.tryParse(numberOfSeatsController.text.trim()) ?? 0,
        "departurePoints": departurePoints.value,
        "departurePoint":
            departurePoints.value, // ADD THIS - API expects singular
        "navigableRoutes":
            navigableRoutes.where((route) => route.isNotEmpty).toList(),
        "postcode": basePostcodeController.text.trim(),
        "mileageRadius":
            int.tryParse(locationRadiusController.text.trim()) ?? 0,
        "boatRates": {
          "hourlyRate":
              double.tryParse(hourlyRateController.text.trim()) ?? 0.0,
          "halfDayHire":
              double.tryParse(halfDayRateController.text.trim()) ?? 0.0,
          "tenHourDayHire":
              double.tryParse(tenHourDayRateController.text.trim()) ?? 0.0,
          "perMileRate":
              double.tryParse(perMileRateController.text.trim()) ?? 0.0,
        },
        "booking_date_from": calenderController.fromDate.value != null
            ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                .format(calenderController.fromDate.value)
            : "",
        "booking_date_to": calenderController.toDate.value != null
            ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                .format(calenderController.toDate.value)
            : "",
        "special_price_days": calenderController.specialPrices
            .map((e) => {
                  "date": e['date'] != null
                      ? DateFormat('yyyy-MM-dd').format(e['date'] as DateTime)
                      : "",
                  "price": e['price'] as double? ?? 0
                })
            .toList(),
        "comfort": {
          "leatherInterior": leatherInterior,
          "wifiAccess": wifiAccess,
          "airConditioning": airConditioning,
          "complimentaryDrinks": complimentaryDrinks,
          "inCarEntertainment": inBoatEntertainment,
          "bluetoothUsb": bluetoothUSB,
          "redCarpetService": redCarpetService,
          "onboardRestroom": onboardRestroom
        },
        "events": {
          "weddingDecor": weddingDecor,
          "partyLightingSystem": partyLighting,
          "champagnePackages": champagnePackages,
          "photographyPackages": photographyPackages
        },
        "accessibility": {
          "wheelchairAccessVehicle": wheelchairAccess,
          "childCarSeats": childCarSeats,
          "petFriendlyService": petFriendlyService,
          "disabledAccessRamp": disabledAccessRamp,
          "seniorFriendlyAssistance": seniorFriendlyAssistance,
          "strollerBuggyStorage": strollerStorage
        },
        "security": {
          "vehicleTrackingGps": vehicleTracking,
          "cctvFitted": cctvFitted,
          "publicLiabilityInsurance": publicLiabilityInsurance,
          "safetyCertifiedDrivers": safetyCertifiedDrivers
        },
        "service_status": serviceStatus ?? "1",
        "cancellation_policy_type": cancellationPolicy ?? "FLEXIBLE",
        "documents": {
          "interiorPhotos": {
            "isAttached": interiorPhotosPaths.isNotEmpty,
            "image": (interiorPhotosPaths.isNotEmpty &&
                    imageController.uploadedUrls.length > 0)
                ? imageController.uploadedUrls[0]
                : ""
          },
          "exteriorPhotos": {
            "isAttached": exteriorPhotosPaths.isNotEmpty,
            "image": (exteriorPhotosPaths.isNotEmpty &&
                    imageController.uploadedUrls.length > 1)
                ? imageController.uploadedUrls[1]
                : ""
          },
          "onWaterViewPhotos": {
            "isAttached": onWaterViewPhotosPaths.isNotEmpty,
            "image": (onWaterViewPhotosPaths.isNotEmpty &&
                    imageController.uploadedUrls.length > 2)
                ? imageController.uploadedUrls[2]
                : ""
          }
        },
        "service_image": imageController.uploadedUrls.isNotEmpty
            ? imageController.uploadedUrls
            : [],
        "coupons": couponController.coupons
            .map((coupon) => {
                  "coupon_code": coupon['coupon_code'] ?? "",
                  "discount_type": coupon['discount_type'] ?? "",
                  "discount_value": coupon['discount_value'] ?? 0,
                  "usage_limit": coupon['usage_limit'] ?? 0,
                  "current_usage_count": coupon['current_usage_count'] ?? 0,
                  "expiry_date": coupon['expiry_date'] != null &&
                          coupon['expiry_date'].toString().isNotEmpty
                      ? DateFormat('yyyy-MM-dd').format(
                          DateTime.parse(coupon['expiry_date'].toString()))
                      : "",
                  "is_global": coupon['is_global'] ?? false
                })
            .toList(),
        "isAccurateInfo": isAccurateInfo,
        "noContactDetailsShared": noContactDetailsShared,
        "agreeCookiesPolicy": agreeCookiesPolicy,
        "agreePrivacyPolicy": agreePrivacyPolicy,
        "agreeCancellationPolicy": agreeCancellationPolicy,

        // FIX THE HIRETYPE - convert to proper enum value
        "hireType": hireOption == 'Self-Drive'
            ? 'self-drive'
            : hireOption == 'Skippered Only'
                ? 'skippered-only' // Convert to kebab-case
                : hireOption == 'Both Options Available'
                    ? 'both'
                    : 'self-drive', // Default
      };

      final api = AddVendorServiceApi();
      final isAdded = await api.addServiceVendor(data, 'boat');

      if (isAdded) {
        Get.snackbar(
          'Success',
          'Service added successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        Get.to(() => HomePageAddService());
      } else {
        Get.snackbar(
          'Error',
          'Add Service Failed. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      print("API Error: $e");
      Get.snackbar(
        'Error',
        'Server error: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });

      try {
        final ServiceController controller = Get.find<ServiceController>();
        controller.fetchServices();
      } catch (e) {
        print("Error refreshing services: $e");
      }
    }
  }

  void _showSetPriceDialog(DateTime date) {
    final TextEditingController priceController = TextEditingController();
    priceController.text =
        (calenderController.getPriceForDate(date)?.toString() ??
            calenderController.defaultPrice.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
            'Set Special Price for ${DateFormat('dd/MM/yyyy').format(date)}'),
        content: TextField(
          controller: priceController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Hourly Rate (£)',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final price = double.tryParse(priceController.text) ?? 0.0;
              if (price >= 0) {
                calenderController.setSpecialPrice(date, price);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Please enter a valid price (≥ 0)')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarCell(DateTime day, bool isClickable) {
    return Obx(() {
      final double price = calenderController.getPriceForDate(day);

      return Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
          color: isClickable ? Colors.white : Colors.grey.withOpacity(0.3),
        ),
        child: InkWell(
          onTap: isClickable ? () => _showSetPriceDialog(day) : null,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('d').format(day),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isClickable ? Colors.black : Colors.grey,
                  ),
                ),
                Text(
                  '£${price.toStringAsFixed(2)}/mile',
                  style: TextStyle(
                    fontSize: 7,
                    color: isClickable
                        ? (price > 0 ? Colors.red : Colors.red)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildDocumentUploadSection(
      String title, RxList<String> documentPaths, bool isRequired) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title${isRequired ? ' *' : ''}",
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(height: 16),
        Obx(() => Wrap(
              spacing: 8.0,
              children: List.generate(documentPaths.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Icon(Icons.insert_drive_file,
                            size: 40, color: Colors.grey),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: GestureDetector(
                          onTap: () {
                            documentPaths.removeAt(index);
                          },
                          child: const Icon(Icons.cancel,
                              color: Colors.redAccent, size: 20),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            )),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('Take a Photo'),
                    onTap: () async {
                      await imageController.pickImages(true);
                      if (imageController.selectedImages.isNotEmpty) {
                        documentPaths.add(imageController.selectedImages.last);
                        imageController.selectedImages.removeLast();
                      }
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Choose from Gallery'),
                    onTap: () async {
                      await imageController.pickImages(false);
                      if (imageController.selectedImages.isNotEmpty) {
                        documentPaths.add(imageController.selectedImages.last);
                        imageController.selectedImages.removeLast();
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
          child: DottedBorder(
            color: Colors.black,
            strokeWidth: 2,
            dashPattern: const [5, 5],
            child: Container(
              height: 100,
              width: double.infinity,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload, color: Colors.grey, size: 30),
                    SizedBox(height: 8),
                    Text(
                      'Click to upload PDF, PNG, JPG (max 5MB)',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCitySelection(String title, bool isSingleSelection,
      RxList<String> selectedCities, RxString singleCity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title *',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        if (!isSingleSelection) ...[
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    selectedCities.clear();
                    selectedCities.addAll(Cities.ukCities);
                  },
                  child: const Text('SELECT ALL'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[700],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    selectedCities.clear();
                  },
                  child: const Text('DESELECT ALL'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            children: [
              if (isSingleSelection)
                DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Search by post code or city name...'),
                  value: singleCity.value.isEmpty ? null : singleCity.value,
                  items: Cities.ukCities.map((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      singleCity.value = newValue;
                    }
                  },
                  underline: const SizedBox(),
                )
              else
                DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Search by post code or city name...'),
                  value: null,
                  items: Cities.ukCities.map((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Row(
                        children: [
                          Checkbox(
                            value: selectedCities.contains(city),
                            onChanged: (bool? value) {
                              if (value == true &&
                                  !selectedCities.contains(city)) {
                                selectedCities.add(city);
                              } else if (value == false) {
                                selectedCities.remove(city);
                              }
                              setState(() {});
                            },
                          ),
                          Expanded(child: Text(city)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                  underline: const SizedBox(),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Obx(() => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: const BoxConstraints(
                minHeight: 50,
              ),
              child: isSingleSelection
                  ? singleCity.value.isEmpty
                      ? const Text(
                          'No city selected',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )
                      : Chip(
                          label: Text(
                            singleCity.value,
                            style: const TextStyle(fontSize: 14),
                          ),
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: () => singleCity.value = '',
                          backgroundColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                  : selectedCities.isEmpty
                      ? const Text(
                          'No cities selected',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )
                      : Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: selectedCities
                              .map((city) => Chip(
                                    label: Text(
                                      city,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    deleteIcon:
                                        const Icon(Icons.close, size: 18),
                                    onDeleted: () =>
                                        selectedCities.remove(city),
                                    backgroundColor: Colors.grey[200],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ))
                              .toList(),
                        ),
            )),
      ],
    );
  }

  Widget _buildDatePicker(
      BuildContext context, String label, Rx<DateTime> date, bool isFromDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label Date *',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: date.value,
              firstDate: DateTime.now(),
              lastDate: DateTime(2099, 12, 31),
            );
            if (picked != null) {
              date.value = picked;
              if (isFromDate) {
                calenderController.updateDateRange(
                  calenderController.fromDate.value,
                  calenderController.toDate.value,
                );
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy').format(date.value),
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.calendar_today, color: Colors.grey),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colors.scaffold_background_color,
      appBar: AppBar(
        backgroundColor: colors.white,
        elevation: 0,
        centerTitle: true,
        title: Obx(() => Text(
              'Add ${widget.SubCategory.value ?? ''} Service',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: colors.black),
            )),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _boatHireFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Business Information
                const Text(
                  'SECTION 1: Business Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Service Name *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 50,
                    textcont: serviceNameController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Enter Service Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Service Name is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Section 2: Boat Hire Service Details
                const Text(
                  'SECTION 2: Boat Hire Service Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),
                const Text(
                  'Boat Type *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 50,
                    textcont: otherBoatTypeController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Enter Boat Type",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Boat Type is required';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 10),

                Text('Make and Model *',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 50,
                    textcont: makeModelController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Enter Make and Model",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Make and Model is required';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 10),
                _buildDatePicker(
                  context,
                  'First Registration',
                  firstRegistrationDate,
                  true,
                ),

                const Text('Luggage Capacity (kg) *',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 10,
                    textcont: luggageCapacityController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Enter Luggage Capacity (kg)",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Luggage capacity is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Number of Seats *',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 10,
                    textcont: numberOfSeatsController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Enter Number of Seats",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Number of seats is required';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 10),
                const Text(
                  'Hire Type *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: CustomDropdown(
                    hintText: "Select Hire Type",
                    items: [
                      'Skippered Only',
                    ],
                    selectedValue: hireOption,
                    onChanged: (value) {
                      setState(() {
                        hireOption = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Section 3: Locations & Booking Info
                const Text(
                  'SECTION 3: Locations ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildCitySelection('Primary Dock/Departure Point', true,
                    navigableRoutes, departurePoints),
                const SizedBox(height: 20),
                _buildCitySelection('Navigable Routes or Locations', false,
                    navigableRoutes, departurePoints),
                const SizedBox(height: 10),

                const Text('Postcode *',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 10,
                    textcont: basePostcodeController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Enter Postcode",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Postcode is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),

                const Text('Location Radius *',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 10,
                    textcont: locationRadiusController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Enter Location Radius (miles)",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Location Radius is required';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                // Section 4: Pricing
                const Text(
                  'SECTION 4: Pricing',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Hourly Rate (£) *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 10,
                    textcont: hourlyRateController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Enter hourly rate",
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}$'))
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Per-Mile/Route Rate *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 10,
                    textcont: perMileRateController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Enter per-mile rate",
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}$'))
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  '10-Hour Day Hire (with 200 miles included) (£) *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 10,
                    textcont: tenHourDayRateController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Enter Ten-Hour Day rate",
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}$'))
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Half Day Hire',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 10,
                    textcont: halfDayRateController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Enter Half Day Hire rate",
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}$'))
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                const Text(
                  'Service Availability Period',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Select the Period during which your service will be available',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 109, 104, 104)),
                ),
                const SizedBox(height: 20),
                Obx(() => _buildDatePicker(
                    context, "From", calenderController.fromDate, true)),
                Obx(() => _buildDatePicker(
                    context, "To", calenderController.toDate, false)),
                const SizedBox(height: 10),
                Obx(() => TableCalendar(
                      onDaySelected: (selectedDay, focusedDay) {
                        if (calenderController.visibleDates
                            .any((d) => isSameDay(d, selectedDay))) {
                          _showSetPriceDialog(selectedDay);
                        }
                      },
                      focusedDay: calenderController.fromDate.value,
                      firstDay: DateTime.now(),
                      lastDay: DateTime.utc(2099, 12, 31),
                      calendarFormat: CalendarFormat.month,
                      availableGestures: AvailableGestures.none,
                      headerStyle:
                          const HeaderStyle(formatButtonVisible: false),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          if (calenderController.visibleDates
                              .any((d) => isSameDay(d, day))) {
                            return _buildCalendarCell(day, true);
                          }
                          return _buildCalendarCell(day, false);
                        },
                      ),
                    )),
                const SizedBox(height: 20),
                const Text(
                  'Special Prices Summary',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: calenderController.specialPrices.length == 0
                      ? Center(
                          child: Text(
                          'No special prices set yet',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ))
                      : Obx(() => ListView.builder(
                            shrinkWrap: true,
                            itemCount: calenderController.specialPrices.length,
                            itemBuilder: (context, index) {
                              final entry =
                                  calenderController.specialPrices[index];
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat('EEE, d MMM yyyy')
                                          .format(date),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '£${price.toStringAsFixed(2)}/mile',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: price > 0
                                                ? Colors.black
                                                : Colors.red,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () {
                                            calenderController
                                                .deleteSpecialPrice(date);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
                ),

                const Text(
                  'Features, Benefits & Extra Services',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                // Comfort & Luxury Section
                const Text(
                  'Comfort & Luxury',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),

                const SizedBox(height: 15),

                // First row - Comfort & Luxury
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Leather Interior'),
                        value: leatherInterior,
                        onChanged: (bool? value) {
                          setState(() {
                            leatherInterior = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Wi-Fi Access'),
                        value: wifiAccess,
                        onChanged: (bool? value) {
                          setState(() {
                            wifiAccess = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Air Conditioning'),
                        value: airConditioning,
                        onChanged: (bool? value) {
                          setState(() {
                            airConditioning = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Complimentary Drinks'),
                        value: complimentaryDrinks,
                        onChanged: (bool? value) {
                          setState(() {
                            complimentaryDrinks = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('In-Boat Entertainment'),
                        value: inBoatEntertainment,
                        onChanged: (bool? value) {
                          setState(() {
                            inBoatEntertainment = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Bluetooth/USB'),
                        value: bluetoothUSB,
                        onChanged: (bool? value) {
                          setState(() {
                            bluetoothUSB = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Red Carpet Service'),
                        value: redCarpetService,
                        onChanged: (bool? value) {
                          setState(() {
                            redCarpetService = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Onboard Restroom'),
                        value: onboardRestroom,
                        onChanged: (bool? value) {
                          setState(() {
                            onboardRestroom = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Events & Extras Section
                const Text(
                  'Events & Extras',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Wedding Décor (ribbons, flowers)'),
                        value: weddingDecor,
                        onChanged: (bool? value) {
                          setState(() {
                            weddingDecor = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Party Lighting System'),
                        value: partyLighting,
                        onChanged: (bool? value) {
                          setState(() {
                            partyLighting = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Champagne Packages'),
                        value: champagnePackages,
                        onChanged: (bool? value) {
                          setState(() {
                            champagnePackages = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Photography Packages'),
                        value: photographyPackages,
                        onChanged: (bool? value) {
                          setState(() {
                            photographyPackages = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Accessibility & Special Services Section
                const Text(
                  'Accessibility & Special Services',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Wheelchair Access Vehicle'),
                        value: wheelchairAccess,
                        onChanged: (bool? value) {
                          setState(() {
                            wheelchairAccess = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Child Car Seats'),
                        value: childCarSeats,
                        onChanged: (bool? value) {
                          setState(() {
                            childCarSeats = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Pet-Friendly Service'),
                        value: petFriendlyService,
                        onChanged: (bool? value) {
                          setState(() {
                            petFriendlyService = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Disabled-Access Ramp'),
                        value: disabledAccessRamp,
                        onChanged: (bool? value) {
                          setState(() {
                            disabledAccessRamp = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Senior-Friendly Assistance'),
                        value: seniorFriendlyAssistance,
                        onChanged: (bool? value) {
                          setState(() {
                            seniorFriendlyAssistance = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Stroller / Buggy Storage'),
                        value: strollerStorage,
                        onChanged: (bool? value) {
                          setState(() {
                            strollerStorage = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Security & Compliance Section
                const Text(
                  'Security & Compliance',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Vehicle Tracking / GPS'),
                        value: vehicleTracking,
                        onChanged: (bool? value) {
                          setState(() {
                            vehicleTracking = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('CCTV Fitted'),
                        value: cctvFitted,
                        onChanged: (bool? value) {
                          setState(() {
                            cctvFitted = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Public Liability Insurance'),
                        value: publicLiabilityInsurance,
                        onChanged: (bool? value) {
                          setState(() {
                            publicLiabilityInsurance = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text(
                            'Safety-Certified Drivers (DBS Checked)'),
                        value: safetyCertifiedDrivers,
                        onChanged: (bool? value) {
                          setState(() {
                            safetyCertifiedDrivers = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),

                const Text(
                  'Service Status *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: CustomDropdown(
                    hintText: "Select Status",
                    items: serviceStatusMap.keys.toList(),
                    selectedValue: serviceStatusMap.entries
                        .firstWhere((entry) => entry.value == serviceStatus,
                            orElse: () => const MapEntry("", ""))
                        .key,
                    onChanged: (value) {
                      setState(() {
                        serviceStatus = serviceStatusMap[value] ?? "";
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                const Text(
                  'Cancellation Policy *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: CustomDropdown(
                    hintText: "Select a Cancellation Policy",
                    items: cancellationPolicyMap.keys.toList(),
                    selectedValue: cancellationPolicyMap.entries
                        .firstWhere(
                            (entry) => entry.value == cancellationPolicy,
                            orElse: () => const MapEntry("", ""))
                        .key,
                    onChanged: (value) {
                      setState(() {
                        cancellationPolicy = cancellationPolicyMap[value] ?? "";
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Section 5: Document Upload
                const Text(
                  'SECTION 5: Document Upload',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Boat Service Images *",
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
                Center(
                  child: Obx(() => Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: List.generate(
                            imageController.selectedImages.length, (index) {
                          return Stack(
                            children: [
                              Image.file(
                                File(imageController.selectedImages[index]),
                                fit: BoxFit.cover,
                                height: 60,
                                width: 60,
                              ),
                              Positioned(
                                top: 2,
                                right: 2,
                                child: GestureDetector(
                                  onTap: () =>
                                      imageController.removeImage(index),
                                  child: const Icon(Icons.close,
                                      color: Colors.redAccent),
                                ),
                              ),
                            ],
                          );
                        }),
                      )),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.camera),
                              title: const Text('Take a Photo'),
                              onTap: () {
                                imageController.pickImages(true);
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Choose from Gallery'),
                              onTap: () {
                                imageController.pickImages(false);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: DottedBorder(
                    color: Colors.black,
                    strokeWidth: 2,
                    dashPattern: const [5, 5],
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cloud_upload_outlined,
                                size: 40, color: Colors.grey),
                            Text(
                              "Click to upload PNG, JPG (max 5MB)",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildDocumentUploadSection(
                    "Interior Photos *", interiorPhotosPaths, true),
                _buildDocumentUploadSection(
                    "Exterior Photos *", exteriorPhotosPaths, true),
                _buildDocumentUploadSection(
                    "On Water View Photos *", onWaterViewPhotosPaths, true),

                // Coupons / Discounts
                const Text(
                  "Coupons / Discounts",
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: w * 0.45,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Get.dialog(AddCouponDialog()),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => Colors.green),
                    ),
                    child: const Text("Add Coupon",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => couponController.coupons.isEmpty
                    ? const SizedBox.shrink()
                    : CouponList()),
                const SizedBox(height: 20),

                // Section 6: Declaration & Agreement
                const Text(
                  'SECTION 6: Declaration & Agreement',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomCheckbox(
                    title:
                        'I confirm that all information provided is accurate and current. *',
                    value: isAccurateInfo,
                    onChanged: (value) {
                      setState(() {
                        isAccurateInfo = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomCheckbox(
                    title:
                        'I have not shared any contact details (Email, Phone, Skype, Website, etc.). *',
                    value: noContactDetailsShared,
                    onChanged: (value) {
                      setState(() {
                        noContactDetailsShared = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomCheckbox(
                    title: 'I agree to the Cookies Policy. *',
                    value: agreeCookiesPolicy,
                    onChanged: (value) {
                      setState(() {
                        agreeCookiesPolicy = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomCheckbox(
                    title: 'I agree to the Privacy Policy. *',
                    value: agreePrivacyPolicy,
                    onChanged: (value) {
                      setState(() {
                        agreePrivacyPolicy = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomCheckbox(
                    title: 'I agree to the Cancellation Fee Policy. *',
                    value: agreeCancellationPolicy,
                    onChanged: (value) {
                      setState(() {
                        agreeCancellationPolicy = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Submit Button
                Container(
                  width: w,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isSubmitting
                        ? null
                        : () async {
                            setState(() {
                              _isSubmitting = true;
                            });
                            await _submitForm();
                          },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => Colors.green),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2.5),
                          )
                        : const Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildDatePicker(BuildContext context, String label,
    Rx<DateTime> selectedDate, bool isFrom) {
  final CalendarController calendarController = Get.find<CalendarController>();
  return ListTile(
    title: Text(
        "$label: ${DateFormat('dd-MM-yyyy HH:mm').format(selectedDate.value)}"),
    trailing: const Icon(Icons.calendar_today),
    onTap: () async {
      final DateTime today = DateTime.now();
      DateTime firstDate = today;

      if (!isFrom && calendarController.fromDate.value.isAfter(today)) {
        firstDate = calendarController.fromDate.value;
      }

      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate.value.isBefore(firstDate)
            ? firstDate
            : selectedDate.value,
        firstDate: firstDate,
        lastDate: DateTime(2099, 12, 31),
      );

      if (pickedDate != null) {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(selectedDate.value),
        );

        if (pickedTime != null) {
          DateTime finalDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          if (isFrom) {
            if (finalDateTime.isBefore(
                calendarController.toDate.value.subtract(Duration(days: 1)))) {
              calendarController.updateDateRange(
                  finalDateTime, calendarController.toDate.value);
            } else {
              calendarController.updateDateRange(
                  finalDateTime, finalDateTime.add(Duration(days: 1)));
            }
          } else {
            if (finalDateTime.isAfter(
                calendarController.fromDate.value.add(Duration(days: 1)))) {
              calendarController.updateDateRange(
                  calendarController.fromDate.value, finalDateTime);
            } else {
              Get.snackbar(
                "Invalid Date",
                "The 'To' date must be after the 'From' date.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
                duration: const Duration(seconds: 3),
              );
              return;
            }
          }
        }
      }
    },
  );
}
