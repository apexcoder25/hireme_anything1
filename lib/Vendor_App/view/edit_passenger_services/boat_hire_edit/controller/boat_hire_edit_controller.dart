import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/calenderController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupanController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/image_controller.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/city_fetch_controller.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:intl/intl.dart';

class BoatHireEditController extends GetxController {
  final String serviceId; // Add serviceId as a parameter
  // Dependencies
  final ImageController imageController = Get.put(ImageController());
  final CouponController couponController = Get.put(CouponController());
  final CalendarController calenderController = Get.put(CalendarController());
  final CityFetchController cityFetchController = Get.put(CityFetchController());
  final ApiServiceVenderSide apiService = ApiServiceVenderSide();

  // Token
  final RxString token = ''.obs;
  final RxBool isSubmitting = false.obs;

  // Text Controllers
  final serviceNameController = TextEditingController();
  final fleetSizeController = TextEditingController();
  final boatNameController = TextEditingController();
  final boatTypeController = TextEditingController();
  final onboardFeaturesController = TextEditingController();
  final capacityController = TextEditingController();
  final yearController = TextEditingController();
  final notesController = TextEditingController();
  final hourlyRateController = TextEditingController();
  final halfDayRateController = TextEditingController();
  final fullDayRateController = TextEditingController();
  final overnightCharterRateController = TextEditingController();
  final packageDealsController = TextEditingController();
  final publicLiabilityInsuranceProviderController = TextEditingController();
  final vesselInsuranceProviderController = TextEditingController();
  final insuranceProviderController = TextEditingController();
  final policyNumberController = TextEditingController();
  final policyExpiryDateController = TextEditingController();
  final uniqueFeaturesController = TextEditingController();
  final promotionalDescriptionController = TextEditingController();
  final otherBoatTypeController = TextEditingController();
  final otherUseCaseController = TextEditingController();

  // Reactive Variables
  final RxString departurePoints = ''.obs;
  final RxList<String> navigableRoutes = <String>[].obs;
  final Map<String, RxBool> boatTypes = {
    'canalBoat': false.obs,
    'narrowboat': false.obs,
    'dayCruiser': false.obs,
    'luxuryYacht': false.obs,
    'sailboat': false.obs,
    'fishingBoat': false.obs,
    'houseboat': false.obs,
    'partyBoat': false.obs,
    'rib': false.obs,
    'selfDrive': false.obs,
    'skipperedStaffed': false.obs,
    'other': false.obs,
  };
  final Map<String, RxBool> typicalUseCases = {
    'privateHire': false.obs,
    'familyTrips': false.obs,
    'corporateEvents': false.obs,
    'henStagParties': false.obs,
    'birthdayParties': false.obs,
    'weddingsProposals': false.obs,
    'fishingTrips': false.obs,
    'sightseeingTours': false.obs,
    'overnightStays': false.obs,
    'other': false.obs,
  };
  final Map<String, RxBool> bookingOptions = {
    'hourly': false.obs,
    'halfDay': false.obs,
    'fullDay': false.obs,
    'multiDay': false.obs,
    'overnightStay': false.obs,
  };
  final RxList<String> boatMasterLicencePaths = <String>[].obs;
  final RxList<String> boatPhotosPaths = <String>[].obs;
  final RxList<String> skipperCredentialsPaths = <String>[].obs;
  final RxList<String> boatSafetyCertificatePaths = <String>[].obs;
  final RxList<String> vesselInsuranceDocPaths = <String>[].obs;
  final RxList<String> publicLiabilityInsuranceDocPaths = <String>[].obs;
  final RxList<String> localAuthorityLicencePaths = <String>[].obs;

  // Other Variables
  final RxString advanceBooking = ''.obs;
  final RxBool yearRound = true.obs;
  final RxBool seasonal = false.obs;
  final RxString? seasonStart = ''.obs;
  final RxString? seasonEnd = ''.obs;
  final RxBool cateringEntertainmentOffered = false.obs;
  final RxBool licenseRequired = false.obs;
  final RxString? hireOption = ''.obs;
  final RxBool hireOptionSkippered = false.obs;
  final RxString? cancellationPolicy = ''.obs;
  final RxBool isAccurateInfo = false.obs;
  final RxBool noContactDetailsShared = false.obs;
  final RxBool agreeCookiesPolicy = false.obs;
  final RxBool agreePrivacyPolicy = false.obs;
  final RxBool agreeCancellationPolicy = false.obs;

  final Map<String, String> cancellationPolicyMap = {
    'Flexible-Full refund if canceled 48+ hours in advance': 'FLEXIBLE',
    'Moderate-Full refund if canceled 72+ hours in advance': 'MODERATE',
    'Strict-Full refund if canceled 7+ days in advance': 'STRICT',
  };
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  BoatHireEditController({required this.serviceId}); // Constructor with serviceId

  @override
  void onInit() {
    super.onInit();
    _loadToken();
    _loadServiceData();
    hourlyRateController.addListener(() {
      calenderController.setDefaultPrice(double.tryParse(hourlyRateController.text) ?? 0.0);
    });
  }

  @override
  void onClose() {
    serviceNameController.dispose();
    fleetSizeController.dispose();
    boatNameController.dispose();
    boatTypeController.dispose();
    onboardFeaturesController.dispose();
    capacityController.dispose();
    yearController.dispose();
    notesController.dispose();
    hourlyRateController.dispose();
    halfDayRateController.dispose();
    fullDayRateController.dispose();
    overnightCharterRateController.dispose();
    packageDealsController.dispose();
    publicLiabilityInsuranceProviderController.dispose();
    vesselInsuranceProviderController.dispose();
    insuranceProviderController.dispose();
    policyNumberController.dispose();
    policyExpiryDateController.dispose();
    uniqueFeaturesController.dispose();
    promotionalDescriptionController.dispose();
    otherBoatTypeController.dispose();
    otherUseCaseController.dispose();
    imageController.selectedImages.clear();
    imageController.uploadedUrls.clear();
    boatMasterLicencePaths.clear();
    boatPhotosPaths.clear();
    skipperCredentialsPaths.clear();
    boatSafetyCertificatePaths.clear();
    vesselInsuranceDocPaths.clear();
    publicLiabilityInsuranceDocPaths.clear();
    localAuthorityLicencePaths.clear();
    couponController.coupons.clear();
    calenderController.specialPrices.clear();
    super.onClose();
  }

  Future<void> _loadToken() async {
    token.value = await SessionVendorSideManager().getToken() ?? "";
    if (token.value.isEmpty) {
      Get.snackbar("Error", "No authentication token found");
    }
  }

  Future<void> _loadServiceData() async {
    try {
      final response = await apiService.getApi(
        'https://stag-api.hireanything.com/vendor/boat/$serviceId', // Use the stored serviceId
        queryParameters: {'authorization': 'Bearer ${token.value}'},
      );

      final data = response as Map<String, dynamic>;

      // Populate controllers and variables
      serviceNameController.text = data['service_name'] ?? 'boat hire service test June 2025';
      fleetSizeController.text = data['fleetSize'].toString() ?? '5';
      boatNameController.text = data['fleetInfo']['boatName'] ?? 'Fleet 2';
      boatTypeController.text = data['fleetInfo']['type'] ?? 'BOAT';
      onboardFeaturesController.text = data['fleetInfo']['onboardFeatures'] ?? 'Fleet 564';
      capacityController.text = data['fleetInfo']['capacity'].toString() ?? '8';
      yearController.text = data['fleetInfo']['year'].toString() ?? '2022';
      notesController.text = data['fleetInfo']['notes'] ?? 'test Notes';

      hourlyRateController.text = data['boatRates']['hourlyRate'].toString() ?? '1';
      halfDayRateController.text = data['boatRates']['halfDayRate'].toString() ?? '2';
      fullDayRateController.text = data['boatRates']['fullDayRate'].toString() ?? '3';
      overnightCharterRateController.text = data['boatRates']['overnightCharterRate'].toString() ?? '4';
      packageDealsController.text = data['boatRates']['packageDealsDescription'] ?? '5';

      publicLiabilityInsuranceProviderController.text = data['licensing']['publicLiabilityInsuranceProvider'] ?? 'Public Liability Insurance Provider test';
      vesselInsuranceProviderController.text = data['licensing']['vesselInsuranceProvider'] ?? 'Vessel Insurance Provider ltd';
      insuranceProviderController.text = data['licensing']['insuranceProvider'] ?? 'Insurance Provider mx';
      policyNumberController.text = data['licensing']['policyNumber'] ?? '7872818448';
      policyExpiryDateController.text = DateFormat('dd-MM-yyyy').format(DateTime.parse(data['licensing']['expiryDate'] ?? '2026-02-01T00:00:00.000Z'));

      uniqueFeaturesController.text = data['uniqueFeatures'] ?? 'Well serviced';
      promotionalDescriptionController.text = data['promotionalDescription'] ?? 'Promotional Description test\n';

      departurePoints.value = data['departurePoints'] ?? 'Slough (SL)';
      navigableRoutes.value = List<String>.from(data['navigableRoutes'] ?? []);

      boatTypes.forEach((key, value) => value.value = data['boatTypes'][key] ?? false);
      typicalUseCases.forEach((key, value) => value.value = data['typicalUseCases'][key] ?? false);
      bookingOptions.forEach((key, value) => value.value = data['bookingOptions'][key] ?? false);

      yearRound.value = data['availability']['yearRound'] ?? true;
      seasonal.value = data['availability']['seasonal'] ?? false;
      seasonStart?.value = data['availability']['seasonStart'] ?? 'June';
      seasonEnd?.value = data['availability']['seasonEnd'] ?? 'August';
      advanceBooking.value = data['advanceBooking'] ?? '2+ Weeks';
      hireOption?.value = data['hireOptions'] ?? 'Skippered Only';
      hireOptionSkippered.value = hireOption?.value == 'Skippered Only';
      cancellationPolicy?.value = data['cancellation_policy_type'] ?? 'FLEXIBLE';

      calenderController.fromDate.value = DateTime.parse(data['booking_date_from'] ?? '2025-07-14T08:00:00.000Z');
      calenderController.toDate.value = DateTime.parse(data['booking_date_to'] ?? '2026-03-25T10:00:00.000Z');

      if (data['service_image'] != null && data['service_image'].isNotEmpty) {
        boatPhotosPaths.value = [data['service_image'][0]];
      }
      if (data['licensing']['documents']['boatMasterLicence']['image'] != null) {
        boatMasterLicencePaths.value = [data['licensing']['documents']['boatMasterLicence']['image']];
      }

      if (data['coupons'] != null) {
        couponController.coupons.value = List<Map<String, dynamic>>.from(data['coupons']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load service data: $e',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

 Future<void> submitForm(Map<String, dynamic> data) async {
  isSubmitting.value = true;
  try {
    final response = await apiService.putApi(
      'https://stag-api.hireanything.com/vendor/boat/$serviceId',
      data,
      headers: {'Authorization': 'Bearer ${token.value}'},
    );

    // Check if the status code is 200
    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'Service updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.back();
    } else {
      // Handle non-200 status codes (optional)
      Get.snackbar(
        'Error',
        'Failed to update service: Status ${response.statusCode}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  } catch (e) {
    Get.snackbar(
      'Success',
        'Service updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
    );
  } finally {
    isSubmitting.value = false;
  }
}

  void showSetPriceDialog(DateTime date) {
    final TextEditingController priceController = TextEditingController();
    priceController.text = (calenderController.getPriceForDate(date)?.toString() ?? calenderController.defaultPrice.toString());

    Get.dialog(
      AlertDialog(
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
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final price = double.tryParse(priceController.text) ?? 0.0;
              if (price >= 0) {
                calenderController.setSpecialPrice(date, price);
                Get.back();
              } else {
                Get.snackbar('Error', 'Please enter a valid price (≥ 0)');
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}