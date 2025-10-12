import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/calenderController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupanController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/image_controller.dart';
import 'package:hire_any_thing/data/exceptions/api_exception.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/city_fetch_controller.dart';
import 'package:hire_any_thing/data/models/vender_side_model/vendor_home_page_services_model.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:intl/intl.dart';

class HorseCarriageEditController extends GetxController {
  final String serviceId;
  final ImageController imageController = Get.put(ImageController());
  final CouponController couponController = Get.put(CouponController());
  final CalendarController calenderController = Get.put(CalendarController());
  final CityFetchController cityFetchController =
      Get.put(CityFetchController());
  final ApiServiceVenderSide apiService = ApiServiceVenderSide();

  final RxString token = ''.obs;
  final RxString vendorId = ''.obs;
  final RxBool isLoading = true.obs;
  final RxBool isSubmitting = false.obs;

  // Controllers for text inputs
  final serviceNameController = TextEditingController();
  final fleetSizeController = TextEditingController();
  final carriageTypeController = TextEditingController();
  final horseTypeController = TextEditingController();
  final onboardDecorController = TextEditingController();
  final capacityController = TextEditingController();
  final publicLiabilityInsuranceProviderController = TextEditingController();
  final policyNumberController = TextEditingController();
  final policyExpiryDateController = TextEditingController();
  final maintenanceFrequencyController = TextEditingController();
  final uniqueFeaturesController = TextEditingController();
  final promotionalDescriptionController = TextEditingController();
  final otherCarriageTypeController = TextEditingController();
  final otherHorseTypeController = TextEditingController();
  final otherOccasionController = TextEditingController();
  final Map<String, String> carriageTypeMap = {
  'traditional': 'Traditional Open Top',
  'landau': 'Landau',
  'glassCoach': 'Glass Coach',
  'visavis': 'Vis-à-vis',
  'cinderellaStyle': 'Glass Coach (Cinderella Style)',
  'customDecorated': 'Custom Decorated',
};

final Map<String, String> horseTypeMap = {
  'white': 'White',
  'black': 'Black',
  'brown': 'Brown',
  'matchedPair': 'Matched Pair',
  'unicornStyling': 'Unicorn Styling (Decorative)',
};

final Map<String, String> occasionMap = {
  'weddings': 'Weddings',
  'prom': 'Proms',
  'funerals': 'Funerals',
  'filmShoots': 'Film & TV Shoots',
  'culturalCeremonies': 'Cultural Ceremonies',
  'tours': 'Tours or Historic Events',
  'historicEvents': 'Tours or Historic Events', // fallback match
};


  // Rx variables
  final RxString departurePoints = ''.obs;
  final RxList<String> navigableRoutes = <String>[].obs; // Maps to serviceAreas
  final Map<String, RxBool> carriageTypes = {
    'traditional': false.obs,
    'openTop': false.obs,
    'glassCoach': false.obs,
    'landau': false.obs,
    'cinderellaStyle': false.obs,
    'visavis': false.obs,
    'customDecorated': false.obs,
    'ghostHorseCarts': false.obs,
    'other': false.obs,
  };
  final Map<String, RxBool> horseTypes = {
    'white': false.obs,
    'black': false.obs,
    'brown': false.obs,
    'matchedPair': false.obs,
    'unicornStyling': false.obs,
    'other': false.obs,
  };
  final Map<String, RxBool> occasions = {
    'weddings': false.obs,
    'funerals': false.obs,
    'culturalCeremonies': false.obs,
    'filmShoots': false.obs,
    'tvShoots': false.obs,
    'tours': false.obs,
    'historicEvents': false.obs,
    'prom': false.obs,
    'other': false.obs,
  };
  final Map<String, RxBool> bookingOptions = {
    'hourly': false.obs,
    'halfDay': false.obs,
    'fullDay': false.obs,
    'ceremony': false.obs,
  };
  final RxList<String> carriagePhotosPaths = <String>[].obs;
  final RxList<String> horsePhotosPaths = <String>[].obs;
  final RxList<String> publicLiabilityInsuranceDocPaths = <String>[].obs;
  final RxList<String> performingAnimalLicencePaths = <String>[].obs;

  final RxString advanceBooking = ''.obs;
  final RxBool regularMaintenance = false.obs;
  final RxBool publicLiabilityInsurance = false.obs;
  final RxBool performingAnimalLicence = false.obs;
  final RxString? cancellationPolicy = ''.obs;

  // New fields from screenshots
  final Map<String, RxBool> accessibilityServices = {
    'wheelchair': false.obs,
    'childCarSeats': false.obs,
    'petFriendly': false.obs,
    'disabledRamp': false.obs,
    'seniorAssistance': false.obs,
    'strollerBuggyStorage': false.obs,
  };
  final Map<String, RxBool> safetyChecks = {
    'weekly': false.obs,
    'monthly': false.obs,
  };
  final Map<String, RxBool> animalWelfareStandards = {
    'vaccinatedGroomed': false.obs,
    'restPeriods': false.obs,
    'inHouseOfficer': false.obs,
    'veterinaryCare': false.obs,
    'rspcaDefra': false.obs,
  };
  final RxString issuingAuthority = ''.obs;

  final Map<String, String> cancellationPolicyMap = {
    'Flexible-Full refund if canceled 48+ hours in advance': 'FLEXIBLE',
    'Moderate-Full refund if canceled 72+ hours in advance': 'MODERATE',
    'Strict-Full refund if canceled 7+ days in advance': 'STRICT',
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

  HorseCarriageEditController({required this.serviceId});

  @override
  void onInit() {
    super.onInit();
    _loadVendorId();
    _loadToken();
  }

  Future<void> _loadVendorId() async {
    String? id = await SessionVendorSideManager().getVendorId();
    vendorId.value = id ?? "";
    if (vendorId.value.isNotEmpty && token.value.isNotEmpty) {
      fetchServiceDetails();
    }
  }

  Future<void> _loadToken() async {
    String? tokenValue = await SessionVendorSideManager().getToken();
    token.value = tokenValue ?? "";
    if (token.value.isNotEmpty && vendorId.value.isNotEmpty) {
      apiService.setRequestHeaders({'Authorization': 'Bearer ${token.value}'});
      fetchServiceDetails();
    }
  }

  void fetchServiceDetails() async {
    try {
      if (vendorId.value.isEmpty) {
        print("Vendor ID is not available");
        return;
      }
      isLoading.value = true;
      final response =
          await apiService.getApi('/vendor-services/${vendorId.value}');

      if (response is Map<String, dynamic> && response['success'] == true) {
        var data = ServicesModel.fromJson(response);
        print("API Response: ${jsonEncode(response)}");
        print("Services fetched: ${data.data?.services.length}");

        final service = data.data?.services.firstWhereOrNull(
          (service) => service.id == serviceId,
        );

        if (service != null) {
          // Section 1: Business Information
          serviceNameController.text = service.serviceName ??
              'Horse & Carriage Hire ${DateTime.now().year}';

          // Section 2: Horse & Carriage Service Details
        carriageTypes.forEach((key, value) {
  final label = carriageTypeMap[key];
  value.value = label != null &&
      service.serviceDetails?.carriageTypes.contains(label) == true;
});


          if (carriageTypes['other']!.value &&
              !service.serviceDetails!.carriageTypes[0].contains('other')) {
            otherCarriageTypeController.text = !carriageTypes.keys
                    .contains(service.serviceDetails!.carriageTypes[0])
                ? service.serviceDetails!.carriageTypes[0]
                : '';
          }
        horseTypes.forEach((key, value) {
  final label = horseTypeMap[key];
  value.value = label != null &&
      service.serviceDetails?.horseTypes.contains(label) == true;
});


          if (horseTypes['other']!.value &&
              !service.serviceDetails!.horseTypes.contains('other')) {
            otherHorseTypeController.text = service.serviceDetails!.horseTypes
                .firstWhere((ht) => !horseTypes.keys.contains(ht),
                    orElse: () => '');
          }
       occasions.forEach((key, value) {
  final label = occasionMap[key];
  value.value = label != null &&
      service.serviceDetails?.occasionsCatered.contains(label) == true;
});


          if (occasions['other']!.value &&
              !service.serviceDetails!.occasionsCatered[0].contains('other')) {
            otherOccasionController.text = service
                .serviceDetails!.occasionsCatered
                .firstWhere((oc) => !occasions.keys.contains(oc),
                    orElse: () => '');
          }

          // Section 3: Fleet Information
          fleetSizeController.text =
              service.serviceDetails?.fleetSize?.toString() ?? '5';
          carriageTypeController.text =
              service.serviceDetails?.carriageTypes.first ??
                  'Traditional Open Top';
          horseTypeController.text =
              service.serviceDetails?.horseTypes.first ?? 'White';
          onboardDecorController.text =
              service.fleetInfo?.onboardFeatures ?? 'ribbons, flowers';
          capacityController.text =
              service.fleetInfo?.capacity?.toString() ?? '6';

          // Section 4: Locations & Booking Info
          departurePoints.value =
              service.serviceDetails?.basePostcode ?? 'SL A091';
          navigableRoutes.value = service.serviceAreas ?? [];
          calenderController.fromDate.value =
              service.availabilityPeriod?.from ?? DateTime.now();
          calenderController.toDate.value = service.availabilityPeriod?.to ??
              DateTime.now().add(Duration(days: 210));
          bookingOptions.forEach((key, value) {
            value.value =
                service.bookingAvailability?.bookingOptions.contains(key) ??
                    false;
          });
          advanceBooking.value =
              service.bookingAvailability?.leadTime ?? '1–2 Weeks';

          // Section 5: Equipment & Safety
          regularMaintenance.value =
              service.equipmentSafety?.isMaintained ?? false;
          safetyChecks.forEach((key, value) {
            value.value =
                service.equipmentSafety?.safetyChecks[0].contains(key) ?? false;
          });
          maintenanceFrequencyController.text =
              service.equipmentSafety?.uniformType ??
                  'Optional / Themed upon request';
          // Note: offersRouteInspection not directly mapped, assume true if safetyChecks exist

          animalWelfareStandards.forEach((key, value) {
            value.value = service.equipmentSafety?.animalWelfareStandards[0]
                    .contains(key) ??
                false;
          });

          // Section 6: Licensing & Insurance
          publicLiabilityInsurance.value =
              service.licensingInsurance?.hasPublicLiabilityInsurance ?? false;
          publicLiabilityInsuranceProviderController.text =
              service.licensingInsurance?.insuranceProviderName ??
                  'ABC Animals';
          policyNumberController.text =
              service.licensingInsurance?.policyNumber ?? '4579465';
          policyExpiryDateController.text =
              service.licensingInsurance?.policyExpiryDate != null
                  ? DateFormat('dd-MM-yyyy')
                      .format(service.licensingInsurance!.policyExpiryDate!)
                  : DateFormat('dd-MM-yyyy')
                      .format(DateTime.now().add(Duration(days: 365)));
          performingAnimalLicence.value =
              service.licensingInsurance?.hasAnimalLicense ?? false;
          issuingAuthority.value =
              service.licensingInsurance?.issuingAuthority ??
                  'Animals Authority';
          cancellationPolicy?.value =
              service.cancellationPolicyType ?? 'FLEXIBLE';

          // Section 7: Document Upload
          carriagePhotosPaths.value =
              service.images.isNotEmpty ? [service.images.first] : [];
          horsePhotosPaths.value =
              service.images.length > 1 ? [service.images[1]] : [];
          publicLiabilityInsuranceDocPaths.value =
              service.uploadedDocuments?.insuranceCertificate != null
                  ? [service.uploadedDocuments!.insuranceCertificate!]
                  : [];
          performingAnimalLicencePaths.value =
              service.uploadedDocuments?.operatorLicence != null
                  ? [service.uploadedDocuments!.operatorLicence!]
                  : [];

          // Section 8: Business Highlights
          uniqueFeaturesController.text = service.serviceHighlights ?? '';
          promotionalDescriptionController.text =
              service.marketing?.description ?? 'Big horses';

          // Accessibility Services (assuming default false if not in response)
          accessibilityServices.forEach((key, value) {
            value.value = false; // Add logic if response includes these
          });

          // Pricing (map to calendar controller)
          calenderController.defaultPrice =
              (service.pricing?.hourlyRate ?? 0.0) as RxDouble;

          if (service.coupons.isNotEmpty) {
            couponController.coupons.value = List<Map<String, dynamic>>.from(
                service.coupons.map((c) => c.toJson()));
          }
        } else {
          print("No service found with ID: $serviceId");
        }
      } else {
        print("Failed to fetch services. Response: $response");
      }
    } on ApiException catch (e) {
      print(
          "Error fetching services: ${e.message}, StackTrace: ${StackTrace.current}");
    } catch (e, stackTrace) {
      print("Unexpected error fetching services: $e, StackTrace: $stackTrace");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    serviceNameController.dispose();
    fleetSizeController.dispose();
    carriageTypeController.dispose();
    horseTypeController.dispose();
    onboardDecorController.dispose();
    capacityController.dispose();
    publicLiabilityInsuranceProviderController.dispose();
    policyNumberController.dispose();
    policyExpiryDateController.dispose();
    maintenanceFrequencyController.dispose();
    uniqueFeaturesController.dispose();
    promotionalDescriptionController.dispose();
    otherCarriageTypeController.dispose();
    otherHorseTypeController.dispose();
    otherOccasionController.dispose();
    imageController.selectedImages.clear();
    imageController.uploadedUrls.clear();
    carriagePhotosPaths.clear();
    horsePhotosPaths.clear();
    publicLiabilityInsuranceDocPaths.clear();
    performingAnimalLicencePaths.clear();
    couponController.coupons.clear();
    calenderController.specialPrices.clear();
    super.onClose();
  }

  Future<void> submitForm(Map<String, dynamic> data) async {
    isSubmitting.value = true;
    try {
      final response = await apiService.putApi(
        'https://stag-api.hireanything.com/vendor/horse-carriage/$serviceId',
        data,
        headers: {'Authorization': 'Bearer ${token.value}'},
      );

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
        'Error',
        'Failed to update service: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void showSetPriceDialog(DateTime date) {
    final TextEditingController priceController = TextEditingController();
    priceController.text =
        (calenderController.getPriceForDate(date)?.toString() ??
            calenderController.defaultPrice.toString());

    Get.dialog(
      AlertDialog(
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
