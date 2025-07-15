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
  final CityFetchController cityFetchController = Get.put(CityFetchController());

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

  // Section 3: Locations & Booking Info
  RxString departurePoints = ''.obs;
  RxList<String> navigableRoutes = <String>[].obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController departureSearchController = TextEditingController();
  TextEditingController hourlyRateController = TextEditingController();
  TextEditingController halfDayRateController = TextEditingController();
  TextEditingController fullDayRateController = TextEditingController();
  TextEditingController overnightCharterRateController = TextEditingController();
  TextEditingController packageDealsController = TextEditingController();
  TextEditingController cateringDescriptionController = TextEditingController();

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

  // Section 4: Licensing & Insurance
  TextEditingController publicLiabilityInsuranceProviderController = TextEditingController();
  TextEditingController vesselInsuranceProviderController = TextEditingController();
  TextEditingController insuranceProviderController = TextEditingController();
  TextEditingController policyNumberController = TextEditingController();
  TextEditingController policyExpiryDateController = TextEditingController();
  String? cancellationPolicy;

  // Section 5: Document Upload
  RxList<String> boatMasterLicencePaths = <String>[].obs;
  RxList<String> skipperCredentialsPaths = <String>[].obs;
  RxList<String> boatSafetyCertificatePaths = <String>[].obs;
  RxList<String> vesselInsuranceDocPaths = <String>[].obs;
  RxList<String> publicLiabilityInsuranceDocPaths = <String>[].obs;
  RxList<String> localAuthorityLicencePaths = <String>[].obs;

  // Section 6: Business Highlights
  TextEditingController uniqueFeaturesController = TextEditingController();
  TextEditingController promotionalDescriptionController = TextEditingController();

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

  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
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
      calenderController.setDefaultPrice(double.tryParse(hourlyRateController.text) ?? 0.0);
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
    boatMasterLicencePaths.clear();
    skipperCredentialsPaths.clear();
    boatSafetyCertificatePaths.clear();
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

  // Function to upload documents using ImageController and wait for all uploads to complete
  Future<bool> _uploadDocuments() async {
    try {
      // Clear any previous uploads in ImageController
      imageController.selectedImages.clear();
      imageController.uploadedUrls.clear();

      // Add all document paths to ImageController for upload
      if (boatMasterLicencePaths.isNotEmpty) {
        imageController.selectedImages.add(boatMasterLicencePaths.first);
      }
      if (skipperCredentialsPaths.isNotEmpty) {
        imageController.selectedImages.add(skipperCredentialsPaths.first);
      }
      if (boatSafetyCertificatePaths.isNotEmpty) {
        imageController.selectedImages.add(boatSafetyCertificatePaths.first);
      }
      if (vesselInsuranceDocPaths.isNotEmpty) {
        imageController.selectedImages.add(vesselInsuranceDocPaths.first);
      }
      if (publicLiabilityInsuranceDocPaths.isNotEmpty) {
        imageController.selectedImages.add(publicLiabilityInsuranceDocPaths.first);
      }
      if (localAuthorityLicencePaths.isNotEmpty) {
        imageController.selectedImages.add(localAuthorityLicencePaths.first);
      }

      // Trigger upload for all documents
      for (var path in imageController.selectedImages) {
        await imageController.uploadToCloudinary(path);
      }

      // Check if the number of uploaded URLs matches the number of documents
      int requiredDocs = 0;
      if (boatMasterLicencePaths.isNotEmpty) requiredDocs++;
      if (skipperCredentialsPaths.isNotEmpty) requiredDocs++;
      if (boatSafetyCertificatePaths.isNotEmpty) requiredDocs++;
      if (vesselInsuranceDocPaths.isNotEmpty) requiredDocs++;
      if (publicLiabilityInsuranceDocPaths.isNotEmpty) requiredDocs++;
      if (localAuthorityLicencePaths.isNotEmpty) requiredDocs++;

      if (imageController.uploadedUrls.length != requiredDocs) {
        Get.snackbar(
          "Upload Error",
          "One or more documents failed to upload.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        return false;
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
  }void _submitForm() async {
  if (!_boatHireFormKey.currentState!.validate()) {
    Get.snackbar("Validation Error", "Please fill all required fields correctly.",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    return;
  }

  // Client-side validation
  if (!boatTypes.values.any((v) => v)) {
    Get.snackbar("Missing Information", "Please select at least one boat type.",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    return;
  }
  if (!typicalUseCases.values.any((v) => v)) {
    Get.snackbar("Missing Information", "Please select at least one use case.",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    return;
  }
  if (departurePoints.value.isEmpty) {
    Get.snackbar("Missing Information", "Departure point is required.",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    return;
  }
  if (navigableRoutes.isEmpty) {
    Get.snackbar("Missing Information", "At least one navigable route is required.",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    return;
  }
  if (advanceBooking == null) {
    Get.snackbar("Missing Information", "Advance booking requirement is required.",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    return;
  }
  if (!yearRound && !seasonal) {
    Get.snackbar("Missing Information", "Please select availability (Year-round or Seasonal).",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    return;
  }
  if (seasonal && (seasonStart == null || seasonEnd == null)) {
    Get.snackbar("Missing Information", "Season start and end months are required for seasonal availability.",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    return;
  }
  if (!bookingOptions.values.any((v) => v)) {
    Get.snackbar("Missing Information", "Please select at least one booking option.",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    return;
  }
  final hourlyRate = double.tryParse(hourlyRateController.text.trim()) ?? 0;
  final halfDayRate = double.tryParse(halfDayRateController.text.trim()) ?? 0;
  final fullDayRate = double.tryParse(fullDayRateController.text.trim()) ?? 0;
  final overnightRate = double.tryParse(overnightCharterRateController.text.trim()) ?? 0;
  if (hourlyRate == 0 && halfDayRate == 0 && fullDayRate == 0 && overnightRate == 0) {
    Get.snackbar("Missing Information", "At least one boat rate must be provided.",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    return;
  }
  if (packageDealsController.text.trim().isEmpty) {
    Get.snackbar("Missing Information", "Package deals description is required.",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    return;
  }
  if (hireOption == null) {
    Get.snackbar("Missing Information", "Hire option is required.",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    return;
  }
  if (cancellationPolicy == null || cancellationPolicy!.isEmpty) {
    Get.snackbar("Missing Information", "Cancellation policy is required.",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    return;
  }
  if (boatMasterLicencePaths.isEmpty || skipperCredentialsPaths.isEmpty || boatSafetyCertificatePaths.isEmpty ||
      vesselInsuranceDocPaths.isEmpty || publicLiabilityInsuranceDocPaths.isEmpty || localAuthorityLicencePaths.isEmpty) {
    Get.snackbar("Missing Information", "All document uploads are required.",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    return;
  }
  if (!isAccurateInfo || !noContactDetailsShared || !agreeCookiesPolicy || !agreePrivacyPolicy || !agreeCancellationPolicy) {
    Get.snackbar("Missing Information", "Please agree to all declarations.",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    return;
  }

  // Upload documents
  setState(() {
    _isSubmitting = true;
  });
  final documentsUploaded = await _uploadDocuments();
  if (!documentsUploaded) {
    setState(() {
      _isSubmitting = false;
    });
    return;
  }

  // Prepare payload
  final data = {
    "vendorId": vendorId,
    "categoryId": widget.CategoryId,
    "subcategoryId": widget.SubCategoryId,
    "service_name": serviceNameController.text.trim(),
    "boatTypes": {
      "canalBoat": boatTypes['canalBoat'],
      "narrowboat": boatTypes['narrowboat'],
      "dayCruiser": boatTypes['dayCruiser'],
      "luxuryYacht": boatTypes['luxuryYacht'],
      "sailboat": boatTypes['sailboat'],
      "fishingBoat": boatTypes['fishingBoat'],
      "houseboat": boatTypes['houseboat'],
      "partyBoat": boatTypes['partyBoat'],
      "rib": boatTypes['rib'],
      "selfDrive": boatTypes['selfDrive'],
      "skipperedStaffed": boatTypes['skipperedStaffed'],
      "other": boatTypes['other'],
      "otherSpecified": boatTypes['other'] == true ? otherBoatTypeController.text.trim() : ""
    },
    "typicalUseCases": {
      "privateHire": typicalUseCases['privateHire'],
      "familyTrips": typicalUseCases['familyTrips'],
      "corporateEvents": typicalUseCases['corporateEvents'],
      "henStagParties": typicalUseCases['henStagParties'],
      "birthdayParties": typicalUseCases['birthdayParties'],
      "weddingsProposals": typicalUseCases['weddingsProposals'],
      "fishingTrips": typicalUseCases['fishingTrips'],
      "sightseeingTours": typicalUseCases['sightseeingTours'],
      "overnightStays": typicalUseCases['overnightStays'],
      "other": typicalUseCases['other'],
      "otherSpecified": typicalUseCases['other'] == true ? otherUseCaseController.text.trim() : ""
    },
    "fleetSize": fleetSizeController.text.trim(),
    "fleetInfo": {
      "boatName": boatNameController.text.trim(),
      "type": boatTypeController.text.trim(),
      "onboardFeatures": onboardFeaturesController.text.trim(),
      "capacity": capacityController.text.trim(),
      "year": yearController.text.trim(),
      "notes": notesController.text.trim()
    },
    "departurePoints": departurePoints.value,
    "navigableRoutes": navigableRoutes.where((route) => route.isNotEmpty).toList(),
    "boatRates": {
      "hourlyRate": hourlyRate,
      "halfDayRate": halfDayRate,
      "fullDayRate": fullDayRate,
      "overnightCharterRate": overnightRate,
      "packageDealsDescription": packageDealsController.text.trim()
    },
    "advanceBooking": advanceBooking,
    "availability": {
      "yearRound": yearRound,
      "seasonal": seasonal,
      "seasonStart": seasonStart ?? "",
      "seasonEnd": seasonEnd ?? ""
    },
    "bookingOptions": {
      "hourly": bookingOptions['hourly'],
      "halfDay": bookingOptions['halfDay'],
      "fullDay": bookingOptions['fullDay'],
      "multiDay": bookingOptions['multiDay'],
      "overnightStay": bookingOptions['overnightStay']
    },
    "cateringEntertainment": {
      "offered": cateringEntertainmentOffered,
      "description": cateringEntertainmentOffered == true ? cateringDescriptionController.text.trim() : ""
    },
    "licensing": {
      "publicLiabilityInsuranceProvider": publicLiabilityInsuranceProviderController.text.trim(),
      "vesselInsuranceProvider": vesselInsuranceProviderController.text.trim(),
      "insuranceProvider": insuranceProviderController.text.trim(),
      "policyNumber": policyNumberController.text.trim(),
      "expiryDate": policyExpiryDateController.text.trim().isNotEmpty
          ? DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(policyExpiryDateController.text.trim()))
          : ""
    },
    "licenseRequired": licenseRequired,
    "documents": {
      "boatMasterLicence": {
        "isAttached": boatMasterLicencePaths.isNotEmpty,
        "image": boatMasterLicencePaths.isNotEmpty ? imageController.uploadedUrls[0] : ""
      },
      "skipperCredentials": {
        "isAttached": skipperCredentialsPaths.isNotEmpty,
        "image": skipperCredentialsPaths.isNotEmpty ? imageController.uploadedUrls[boatMasterLicencePaths.isNotEmpty ? 1 : 0] : ""
      },
      "boatSafetyCertificate": {
        "isAttached": boatSafetyCertificatePaths.isNotEmpty,
        "image": boatSafetyCertificatePaths.isNotEmpty ? imageController.uploadedUrls[boatMasterLicencePaths.isNotEmpty ? (skipperCredentialsPaths.isNotEmpty ? 2 : 1) : 0] : ""
      },
      "vesselInsurance": {
        "isAttached": vesselInsuranceDocPaths.isNotEmpty,
        "image": vesselInsuranceDocPaths.isNotEmpty ? imageController.uploadedUrls[boatMasterLicencePaths.isNotEmpty ? (skipperCredentialsPaths.isNotEmpty ? (boatSafetyCertificatePaths.isNotEmpty ? 3 : 2) : 1) : 0] : ""
      },
      "publicLiabilityInsurance": {
        "isAttached": publicLiabilityInsuranceDocPaths.isNotEmpty,
        "image": publicLiabilityInsuranceDocPaths.isNotEmpty ? imageController.uploadedUrls[boatMasterLicencePaths.isNotEmpty ? (skipperCredentialsPaths.isNotEmpty ? (boatSafetyCertificatePaths.isNotEmpty ? (vesselInsuranceDocPaths.isNotEmpty ? 4 : 3) : 2) : 1) : 0] : ""
      },
      "localAuthorityLicence": {
        "isAttached": localAuthorityLicencePaths.isNotEmpty,
        "image": localAuthorityLicencePaths.isNotEmpty ? imageController.uploadedUrls[boatMasterLicencePaths.isNotEmpty ? (skipperCredentialsPaths.isNotEmpty ? (boatSafetyCertificatePaths.isNotEmpty ? (vesselInsuranceDocPaths.isNotEmpty ? (publicLiabilityInsuranceDocPaths.isNotEmpty ? 5 : 4) : 3) : 2) : 1) : 0] : ""
      }
    },
    "uniqueFeatures": uniqueFeaturesController.text.trim(),
    "promotionalDescription": promotionalDescriptionController.text.trim(),
    "service_image": imageController.uploadedUrls.isNotEmpty ? imageController.uploadedUrls : [],
    "coupons": couponController.coupons.map((coupon) => {
      "coupon_code": coupon['coupon_code'] ?? "",
      "discount_type": coupon['discount_type'] ?? "",
      "discount_value": coupon['discount_value'] ?? 0,
      "usage_limit": coupon['usage_limit'] ?? 0,
      "current_usage_count": coupon['current_usage_count'] ?? 0,
      "expiry_date": coupon['expiry_date'] != null && coupon['expiry_date'].toString().isNotEmpty ? DateFormat('yyyy-MM-dd').format(DateTime.parse(coupon['expiry_date'].toString())) : "",
      "is_global": coupon['is_global'] ?? false
    }).toList(),
    "special_price_days": calenderController.specialPrices.map((e) => {
      "date": e['date'] != null ? DateFormat('yyyy-MM-dd').format(e['date'] as DateTime) : "",
      "price": e['price'] as double? ?? 0
    }).toList(),
    "booking_date_from": calenderController.fromDate.value != null ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(calenderController.fromDate.value) : "",
    "booking_date_to": calenderController.toDate.value != null ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(calenderController.toDate.value) : "",
    "cancellation_policy_type": cancellationPolicy ?? "FLEXIBLE",
    "hireOptions": hireOptionSkippered == true ? "Skippered Only" : hireOption ?? "",
    "isAccurateInfo": isAccurateInfo,
    "noContactDetailsShared": noContactDetailsShared,
    "agreeCookiesPolicy": agreeCookiesPolicy,
    "agreePrivacyPolicy": agreePrivacyPolicy,
    "agreeCancellationPolicy": agreeCancellationPolicy,
    "formErrors": {
      "booking_date_to": ""
    }
  };

  // Submit to API
  final api = AddVendorServiceApi();
  try {
    final isAdded = await api.addServiceVendor(data);
    if (isAdded) {
      Get.to(() => HomePageAddService());
    } else {
      Get.snackbar('Error', 'Add Service Failed. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    }
  } catch (e) {
    print("API Error: $e");
    Get.snackbar('Error', 'Server error: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white);
  } finally {
    setState(() {
      _isSubmitting = false;
    });
  }
}
  void _showSetPriceDialog(DateTime date) {
    final TextEditingController priceController = TextEditingController();
    priceController.text = (calenderController.getPriceForDate(date)?.toString() ?? calenderController.defaultPrice.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Set Special Price for ${DateFormat('dd/MM/yyyy').format(date)}'),
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
                  const SnackBar(content: Text('Please enter a valid price (≥ 0)')),
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
      // Get the price for the given day; fallback to defaultPrice
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

  Widget _buildDocumentUploadSection(String title, RxList<String> documentPaths, bool isRequired) {
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
                        child: const Icon(Icons.insert_drive_file, size: 40, color: Colors.grey),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: GestureDetector(
                          onTap: () {
                            documentPaths.removeAt(index);
                          },
                          child: const Icon(Icons.cancel, color: Colors.redAccent, size: 20),
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
                      style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w700),
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

  Widget _buildCitySelection(String title, bool isSingleSelection, RxList<String> selectedCities, RxString singleCity) {
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
                              if (value == true && !selectedCities.contains(city)) {
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
                                    deleteIcon: const Icon(Icons.close, size: 18),
                                    onDeleted: () => selectedCities.remove(city),
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

 Widget _buildDatePicker(BuildContext context, String label, Rx<DateTime> date, bool isFromDate) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$label Date',
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
              // Replace updateVisibleDates with updateDateRange
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
            style: const TextStyle(fontWeight: FontWeight.bold, color: colors.black),
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
                'Types of Boats Available *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 10,
                  children: boatTypes.keys.map((type) => ChoiceChip(
                        label: Text(type),
                        selected: boatTypes[type]!,
                        onSelected: (selected) {
                          setState(() {
                            boatTypes[type] = selected;
                          });
                        },
                      )).toList(),
                ),
              ),
              if (boatTypes['other']!) ...[
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 100,
                    textcont: otherBoatTypeController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Please specify other boat type",
                    validator: (value) {
                      if (boatTypes['other']! && (value == null || value.isEmpty)) {
                        return 'Please specify other boat type';
                      }
                      return null;
                    },
                  ),
                ),
              ],
              const SizedBox(height: 20),
              const Text(
                'Typical Use Cases *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 10,
                  children: typicalUseCases.keys.map((useCase) => ChoiceChip(
                        label: Text(useCase),
                        selected: typicalUseCases[useCase]!,
                        onSelected: (selected) {
                          setState(() {
                            typicalUseCases[useCase] = selected;
                          });
                        },
                      )).toList(),
                ),
              ),
              if (typicalUseCases['other']!) ...[
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 100,
                    textcont: otherUseCaseController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Please specify other use case",
                    validator: (value) {
                      if (typicalUseCases['other']! && (value == null || value.isEmpty)) {
                        return 'Please specify other use case';
                      }
                      return null;
                    },
                  ),
                ),
              ],
              const SizedBox(height: 20),

              // Section 3: Fleet Information
              const Text(
                'SECTION 3: Fleet Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Fleet Size *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 10,
                  textcont: fleetSizeController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter number of boats",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fleet size is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Fleet Information',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 50,
                  textcont: boatNameController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Boat Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Boat name is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 50,
                  textcont: boatTypeController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Boat Type",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Boat type is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 100,
                  textcont: onboardFeaturesController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Onboard Features",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Onboard features are required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 10,
                  textcont: capacityController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Capacity",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Capacity is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 4,
                  textcont: yearController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Year",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Year is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 200,
                  textcont: notesController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Notes",
                ),
              ),
              const SizedBox(height: 20),

              // Section 3: Locations & Booking Info
              const Text(
                'SECTION 3: Locations & Booking Info',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildCitySelection('Primary Dock/Departure Point', true, navigableRoutes, departurePoints),
              const SizedBox(height: 20),
              _buildCitySelection('Navigable Routes or Locations', false, navigableRoutes, departurePoints),
              const SizedBox(height: 20),
              const Text(
                'Boat Rates * (At least one rate is required)',
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
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                ),
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
                  hinttext: "Enter half-day rate",
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 10,
                  textcont: fullDayRateController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter full-day rate",
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 10,
                  textcont: overnightCharterRateController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter overnight charter rate",
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 500,
                  textcont: packageDealsController,
                  textfilled_height: 10,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Describe Package Deals",
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Additional Info',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Advance Booking Requirement *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CustomDropdown(
                  hintText: "Select Option",
                  items: ['2+ Weeks', '48 hours', '1 Week'],
                  selectedValue: advanceBooking,
                  onChanged: (value) {
                    setState(() {
                      advanceBooking = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Availability *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomCheckbox(
                        title: 'Year-round',
                        value: yearRound,
                        onChanged: (value) {
                          setState(() {
                            yearRound = value!;
                            if (value) seasonal = false;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomCheckbox(
                        title: 'Seasonal',
                        value: seasonal,
                        onChanged: (value) {
                          setState(() {
                            seasonal = value!;
                            if (value) yearRound = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (seasonal) ...[
                const SizedBox(height: 10),
                const Text(
                  'Season Start Month *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: CustomDropdown(
                    hintText: "Select Start Month",
                    items: months,
                    selectedValue: seasonStart,
                    onChanged: (value) {
                      setState(() {
                        seasonStart = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Season End Month *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: CustomDropdown(
                    hintText: "Select End Month",
                    items: months,
                    selectedValue: seasonEnd,
                    onChanged: (value) {
                      setState(() {
                        seasonEnd = value;
                      });
                    },
                  ),
                ),
              ],
              const SizedBox(height: 20),
              const Text(
                'Booking Options *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 10,
                  children: bookingOptions.keys.map((option) => ChoiceChip(
                        label: Text(option),
                        selected: bookingOptions[option]!,
                        onSelected: (selected) {
                          setState(() {
                            bookingOptions[option] = selected;
                          });
                        },
                      )).toList(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomCheckbox(
                  title: 'Catering & Entertainment Offered?',
                  value: cateringEntertainmentOffered,
                  onChanged: (value) {
                    setState(() {
                      cateringEntertainmentOffered = value!;
                    });
                  },
                ),
              ),
              if (cateringEntertainmentOffered) ...[
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 500,
                    textcont: cateringDescriptionController,
                    textfilled_height: 10,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Describe Catering & Entertainment",
                  ),
                ),
              ],
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomCheckbox(
                  title: 'License Required?',
                  value: licenseRequired,
                  onChanged: (value) {
                    setState(() {
                      licenseRequired = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Hire Options *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CustomDropdown(
                  hintText: "Select Hire Option",
                  items: ['Skippered Only', 'Self Drive'],
                  selectedValue: hireOption,
                  onChanged: (value) {
                    setState(() {
                      hireOption = value;
                      hireOptionSkippered = value == 'Skippered Only';
                    });
                  },
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
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104)),
              ),
              const SizedBox(height: 20),
               Obx(() => _buildDatePicker(context, "From", calenderController.fromDate,
                    true)),
                Obx(() => _buildDatePicker(context, "To", calenderController.toDate,
                    false)),
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
                      headerStyle: const HeaderStyle(formatButtonVisible: false),
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
              const SizedBox(height: 20),

              // Section 4: Licensing & Insurance
              const Text(
                'SECTION 4: Licensing & Insurance',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Public Liability Insurance Provider *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 100,
                  textcont: publicLiabilityInsuranceProviderController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Public Liability Insurance Provider",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Public Liability Insurance Provider is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Vessel Insurance Provider *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 100,
                  textcont: vesselInsuranceProviderController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Vessel Insurance Provider",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vessel Insurance Provider is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Insurance Provider *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 100,
                  textcont: insuranceProviderController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Insurance Provider",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insurance Provider is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Policy Number *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 50,
                  textcont: policyNumberController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Policy Number",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Policy Number is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Policy Expiry Date *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  final DateTime today = DateTime.now();
                  DateTime initialDate = today;

                  if (policyExpiryDateController.text.isNotEmpty) {
                    try {
                      initialDate = DateFormat('dd-MM-yyyy').parse(policyExpiryDateController.text);
                    } catch (e) {
                      initialDate = today;
                    }
                  }

                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: initialDate.isBefore(today) ? today : initialDate,
                    firstDate: today,
                    lastDate: DateTime(2099, 12, 31),
                  );

                  if (picked != null) {
                    policyExpiryDateController.text = DateFormat('dd-MM-yyyy').format(picked);
                  }
                },
                child: AbsorbPointer(
                  child: SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: policyExpiryDateController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.datetime,
                      hinttext: "dd-mm-yyyy",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Policy Expiry Date is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                  selectedValue: cancellationPolicyMap.entries.firstWhere((entry) => entry.value == cancellationPolicy, orElse: () => const MapEntry("", "")).key,
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
                "Boat Photos *",
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Obx(() => Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: List.generate(imageController.selectedImages.length, (index) {
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
                                  onTap: () => imageController.removeImage(index),
                                  child: const Icon(Icons.close, color: Colors.redAccent),
                                ),
                              ),
                            ],
                          );
                        }),
                      )),
                ),
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
                          Icon(Icons.cloud_upload_outlined, size: 40, color: Colors.grey),
                          Text(
                            "Click to upload PNG, JPG (max 5MB)",
                            style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildDocumentUploadSection("Boat Master Licence", boatMasterLicencePaths, true),
              _buildDocumentUploadSection("Skipper Credentials", skipperCredentialsPaths, true),
              _buildDocumentUploadSection("Boat Safety Certificate", boatSafetyCertificatePaths, true),
              _buildDocumentUploadSection("Vessel Insurance Document", vesselInsuranceDocPaths, true),
              _buildDocumentUploadSection("Public Liability Insurance Document", publicLiabilityInsuranceDocPaths, true),
              _buildDocumentUploadSection("Local Authority Licence", localAuthorityLicencePaths, true),

              // Section 6: Business Highlights
              const Text(
                'SECTION 6: Business Highlights',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'What makes your service unique or premium? *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 500,
                  textcont: uniqueFeaturesController,
                  textfilled_height: 10,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter what makes your service unique",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unique features are required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Promotional Description (max 100 words) *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 100,
                  textcont: promotionalDescriptionController,
                  textfilled_height: 10,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter promotional description",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Promotional description is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),

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
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.green),
                  ),
                  child: const Text("Add Coupon", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => couponController.coupons.isEmpty ? const SizedBox.shrink() : CouponList()),
              const SizedBox(height: 20),

              // Section 7: Declaration & Agreement
              const Text(
                'SECTION 7: Declaration & Agreement',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomCheckbox(
                  title: 'I confirm that all information provided is accurate and current. *',
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
                  title: 'I have not shared any contact details (Email, Phone, Skype, Website, etc.). *',
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
        ? null // Disable button while submitting
        : () async {
            if (!_boatHireFormKey.currentState!.validate()) {
              Get.snackbar(
                "Validation Error",
                "Please fill all required fields correctly.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
                duration: const Duration(seconds: 3),
                icon: const Icon(Icons.warning, color: Colors.white),
                margin: const EdgeInsets.all(10),
              );
              return;
            }
                    if (!boatTypes.values.any((v) => v)) {
                      Get.snackbar("Missing Information", "Please select at least one boat type.",
                          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                      return;
                    }
                    if (!typicalUseCases.values.any((v) => v)) {
                      Get.snackbar("Missing Information", "Please select at least one use case.",
                          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                      return;
                    }
                    if (departurePoints.value.isEmpty) {
                      Get.snackbar("Missing Information", "Departure point is required.",
                          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                      return;
                    }
                    if (navigableRoutes.isEmpty) {
                      Get.snackbar("Missing Information", "At least one navigable route is required.",
                          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                      return;
                    }
                    if (advanceBooking == null) {
                      Get.snackbar("Missing Information", "Advance booking requirement is required.",
                          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                      return;
                    }
                    if (!yearRound && !seasonal) {
                      Get.snackbar("Missing Information", "Please select availability (Year-round or Seasonal).",
                          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                      return;
                    }
                    if (seasonal && (seasonStart == null || seasonEnd == null)) {
                      Get.snackbar("Missing Information", "Season start and end months are required for seasonal availability.",
                          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                      return;
                    }
                    if (!bookingOptions.values.any((v) => v)) {
                      Get.snackbar("Missing Information", "Please select at least one booking option.",
                          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                      return;
                    }
                    // Validate Boat Rates
                    final hourlyRate = double.tryParse(hourlyRateController.text.trim()) ?? 0;
                    final halfDayRate = double.tryParse(halfDayRateController.text.trim()) ?? 0;
                    final fullDayRate = double.tryParse(fullDayRateController.text.trim()) ?? 0;
                    final overnightRate = double.tryParse(overnightCharterRateController.text.trim()) ?? 0;
                    if (hourlyRate == 0 && halfDayRate == 0 && fullDayRate == 0 && overnightRate == 0) {
                      Get.snackbar("Missing Information", "At least one boat rate (hourly, half-day, full-day, or overnight) must be provided.",
                          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                      return;
                    }
                    if (hireOption == null) {
                      Get.snackbar("Missing Information", "Hire option is required.",
                          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                      return;
                    }
                    if (boatMasterLicencePaths.isEmpty || skipperCredentialsPaths.isEmpty || boatSafetyCertificatePaths.isEmpty || vesselInsuranceDocPaths.isEmpty || publicLiabilityInsuranceDocPaths.isEmpty || localAuthorityLicencePaths.isEmpty) {
                      Get.snackbar("Missing Information", "All document uploads are required.",
                          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                      return;
                    }
                    if (!isAccurateInfo || !noContactDetailsShared || !agreeCookiesPolicy || !agreePrivacyPolicy || !agreeCancellationPolicy) {
                      Get.snackbar("Missing Information", "Please agree to all declarations.",
                          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                        return;
                      }
                     setState(() {
              _isSubmitting = true; // Start loading
            });
            _submitForm();
            setState(() {
              _isSubmitting = false; // Stop loading after submission
            });
          },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.green),
    ),
    child: _isSubmitting
        ? const SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.5,
            ),
          )
        : const Text(
            "Submit",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
  

  Widget _buildDatePicker(
      BuildContext context, String label, Rx<DateTime> selectedDate, bool isFrom) {
    final CalendarController calendarController = Get.find<CalendarController>();
    return ListTile(
      title: Text(
          "$label: ${DateFormat('dd-MM-yyyy HH:mm').format(selectedDate.value)}"),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        // Set minimum date to today to prevent past dates
        final DateTime today = DateTime.now();
        DateTime firstDate = today;

        // For "To" date, ensure it can't be before "From" date
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

            // Validate date constraints
            if (isFrom) {
              if (finalDateTime
                  .isBefore(calendarController.toDate.value.subtract(Duration(days: 1)))) {
                calendarController.updateDateRange(
                    finalDateTime, calendarController.toDate.value);
              } else {
                // If "From" is after or equal to "To", adjust "To" to be one day after
                calendarController.updateDateRange(
                    finalDateTime, finalDateTime.add(Duration(days: 1)));
              }
            } else {
              if (finalDateTime
                  .isAfter(calendarController.fromDate.value.add(Duration(days: 1)))) {
                calendarController.updateDateRange(
                    calendarController.fromDate.value, finalDateTime);
              } else {
                // Show error if "To" is not after "From"
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
