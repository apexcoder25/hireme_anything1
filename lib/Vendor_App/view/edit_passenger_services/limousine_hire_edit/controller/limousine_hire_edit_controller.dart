
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/calenderController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupanController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/upload_image.dart';
import 'package:hire_any_thing/data/exceptions/api_exception.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/city_fetch_controller.dart';
import 'package:hire_any_thing/data/models/vender_side_model/vendor_home_page_services_model.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:intl/intl.dart';

class LimoHireEditController extends GetxController {
  final String serviceId;
  final ImageController imageController = Get.put(ImageController());
  final CouponController couponController = Get.put(CouponController());
  final CalendarController calendarController = Get.put(CalendarController());
  final CityFetchController cityFetchController = Get.put(CityFetchController());
  final ApiServiceVenderSide apiService = ApiServiceVenderSide();

  final RxString token = ''.obs;
  final RxString vendorId = ''.obs;
  final RxBool isLoading = true.obs;
  final RxBool isSubmitting = false.obs;

  // Controllers for text inputs
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController vehicleIdController = TextEditingController();
  final TextEditingController makeAndModelController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController yearOfManufactureController = TextEditingController();
  final TextEditingController colourController = TextEditingController();
  final TextEditingController passengerCapacityController = TextEditingController();
  final TextEditingController vehicleDescriptionController = TextEditingController();
  final TextEditingController bootsAndSpaceController = TextEditingController();
  final TextEditingController dayRateController = TextEditingController();
  final TextEditingController mileageLimitController = TextEditingController(text: '100');
  final TextEditingController extraMileageChargeController = TextEditingController();
  final TextEditingController hourlyRateController = TextEditingController();
  final TextEditingController halfDayRateController = TextEditingController();
  final TextEditingController weddingPackageController = TextEditingController();
  final TextEditingController airportTransferController = TextEditingController();
  final TextEditingController promoVideoUrlController = TextEditingController();
  final TextEditingController otherServiceCategoryController = TextEditingController();

  // Rx variables
  final RxList<String> areasCovered = <String>[].obs;
  final RxString serviceStatus = ''.obs;
  final Rx<DateTime> fromDate = DateTime.now().obs;
  final Rx<DateTime> toDate = DateTime.now().obs;
  final RxBool fuelIncluded = false.obs;
  final RxList<String> motCertificatePaths = <String>[].obs;
  final RxList<String> driversLicencePaths = <String>[].obs;
  final RxList<String> publicLiabilityInsurancePaths = <String>[].obs;
  final RxList<String> operatorLicencePaths = <String>[].obs;
  final RxList<String> insuranceCertificatePaths = <String>[].obs;
  final RxList<String> vscRegistrationPaths = <String>[].obs;
  final RxList<String> limousinePhotosPaths = <String>[].obs;
  final RxBool agreeTerms = false.obs;
  final RxBool noContactDetails = false.obs;
  final RxBool agreeCookies = false.obs;
  final RxBool agreePrivacy = false.obs;
  final RxBool agreeCancellation = false.obs;

  // Maps for categories and features
  final Map<String, RxBool> serviceCategories = {
    'Limousine Hire': false.obs,
    'Chauffeur Service': false.obs,
    'Wedding Car Hire': false.obs,
    'Airport Transfers': false.obs,
    'Corporate Transport': false.obs,
    'Party & Event Transfers': false.obs,
    'Other': false.obs,
  };
  final Map<String, RxBool> comfortLuxury = {
    'Leather Seating': false.obs,
    'Mood Lighting': false.obs,
    'Climate Control': false.obs,
    'Mini-Bar/Fridge': false.obs,
    'Privacy Divider': false.obs,
    'Tinted Windows': false.obs,
    'Wi-Fi': false.obs,
    'Premium Sound System': false.obs,
  };
  final Map<String, RxBool> eventsCustomisation = {
    'Red Carpet Service': false.obs,
    'Champagne Packages': false.obs,
    'Floral Décor': false.obs,
    'Themed Interiors': false.obs,
    'Photography Packages': false.obs,
    'Party Packages': false.obs,
  };
  final Map<String, TextEditingController> eventsCustomisationPrices = {
    'Red Carpet Service': TextEditingController(),
    'Champagne Packages': TextEditingController(),
    'Floral Décor': TextEditingController(),
    'Themed Interiors': TextEditingController(),
    'Photography Packages': TextEditingController(),
    'Party Packages': TextEditingController(),
  };
  final Map<String, RxBool> accessibilitySpecialServices = {
    'Wheelchair Access': false.obs,
    'Child Car Seats': false.obs,
    'Pet-Friendly Service': false.obs,
    'Luggage Rack / Roof Box': false.obs,
  };
  final Map<String, TextEditingController> accessibilitySpecialServicesPrices = {
    'Wheelchair Access': TextEditingController(),
    'Child Car Seats': TextEditingController(),
    'Pet-Friendly Service': TextEditingController(),
    'Luggage Rack / Roof Box': TextEditingController(),
  };
  final Map<String, RxBool> safetyCompliance = {
    'GPS Tracking': false.obs,
    'CCTV Onboard': false.obs,
    'Public Liability Insurance': false.obs,
    'DBS Checked Drivers': false.obs,
  };

  LimoHireEditController({required this.serviceId});

  @override
  void onInit() {
    super.onInit();
    _loadVendorId();
    _loadToken();
    hourlyRateController.addListener(() {
      calendarController.setDefaultPrice(double.tryParse(hourlyRateController.text) ?? 0.0);
    });
  }

  @override
  void onClose() {
    serviceNameController.dispose();
    vehicleIdController.dispose();
    makeAndModelController.dispose();
    typeController.dispose();
    yearOfManufactureController.dispose();
    colourController.dispose();
    passengerCapacityController.dispose();
    vehicleDescriptionController.dispose();
    bootsAndSpaceController.dispose();
    dayRateController.dispose();
    mileageLimitController.dispose();
    extraMileageChargeController.dispose();
    hourlyRateController.dispose();
    halfDayRateController.dispose();
    weddingPackageController.dispose();
    airportTransferController.dispose();
    promoVideoUrlController.dispose();
    otherServiceCategoryController.dispose();
    eventsCustomisationPrices.forEach((_, controller) => controller.dispose());
    accessibilitySpecialServicesPrices.forEach((_, controller) => controller.dispose());
    hourlyRateController.removeListener(() {});
    imageController.selectedImages.clear();
    imageController.uploadedUrls.clear();
    motCertificatePaths.clear();
    driversLicencePaths.clear();
    publicLiabilityInsurancePaths.clear();
    operatorLicencePaths.clear();
    insuranceCertificatePaths.clear();
    vscRegistrationPaths.clear();
    limousinePhotosPaths.clear();
    couponController.coupons.clear();
    calendarController.specialPrices.clear();
    super.onClose();
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
      final response = await apiService.getApi('/vendor-services/${vendorId.value}');

      if (response is Map<String, dynamic> && response['success'] == true) {
        var data = ServicesModel.fromJson(response);
        print("API Response: ${jsonEncode(response)}");
        print("Services fetched: ${data.data?.services.length}");

        final service = data.data?.services.firstWhereOrNull(
          (service) => service.id == serviceId,
        );

        if (service != null) {
          // Section 1: Service Category
          serviceNameController.text = service.serviceName ?? 'Limo Hire ${DateTime.now().year}';
          serviceCategories.forEach((key, value) => value.value = service.occasionsCovered.contains(key));
          if (serviceCategories['Other']!.value && !service.occasionsCovered.contains('Other')) {
            otherServiceCategoryController.text = service.otherOccasions ?? '';
          }

          // Section 2: Fleet / Vehicle Details
          if (service.serviceFleetDetails.isNotEmpty) {
            vehicleIdController.text = service.serviceFleetDetails[0].vehicleId ?? '';
            makeAndModelController.text = service.serviceFleetDetails[0].makeModel ?? '';
            typeController.text = service.serviceFleetDetails[0].type ?? '';
            yearOfManufactureController.text = service.serviceFleetDetails[0].year?.toString() ?? '';
            colourController.text = service.serviceFleetDetails[0].color ?? '';
            passengerCapacityController.text = service.serviceFleetDetails[0].capacity?.toString() ?? '';
            vehicleDescriptionController.text = service.serviceFleetDetails[0].vehicleDescription ?? '';
            bootsAndSpaceController.text = service.serviceFleetDetails[0].bootSpace ?? '';
          }

          // Section 3: Features, Benefits & Extras
          comfortLuxury.forEach((key, value) => value.value = service.features?.comfortAndLuxury.contains(key) ?? false);
          eventsCustomisation.forEach((key, value) => value.value = service.features?.eventsAndCustomization.contains(key) ?? false);
          accessibilitySpecialServices.forEach((key, value) => value.value = service.features?.accessibilityServices.contains(key) ?? false);
          safetyCompliance.forEach((key, value) => value.value = service.features?.safetyAndCompliance.contains(key) ?? false);
          for (var entry in (service.featurePricing?.eventsAndCustomization?.toJson().entries ?? <MapEntry<String, dynamic>>[])) {
            eventsCustomisationPrices[entry.key]?.text = entry.value.toString();
          }
          for (var entry in (service.featurePricing?.accessibilityServices?.toJson().entries ?? <MapEntry<String, dynamic>>[])) {
            accessibilitySpecialServicesPrices[entry.key]?.text = entry.value.toString();
          }

          // Section 4: Coverage & Availability
          areasCovered.assignAll(service.areasCovered ?? []);
          serviceStatus.value = service.serviceStatus ?? '';
          fromDate.value = service.bookingDateFrom ?? DateTime.now();
          toDate.value = service.bookingDateTo ?? DateTime.now().add(const Duration(days: 210));
          calendarController.updateDateRange(fromDate.value, toDate.value);

          // Section 5: Pricing Structure
          dayRateController.text = service.fullDayRate?.toString() ?? '';
          mileageLimitController.text = service.mileageCapLimit?.toString() ?? '100';
          extraMileageChargeController.text = service.mileageCapExcessCharge?.toString() ?? '';
          hourlyRateController.text = service.hourlyRate?.toString() ?? '';
          halfDayRateController.text = service.halfDayRate?.toString() ?? '';
          weddingPackageController.text = service.weddingPackageRate?.toString() ?? '';
          airportTransferController.text = service.airportTransferRate?.toString() ?? '';
          fuelIncluded.value = service.fuelIncluded ?? false;

          // Section 6: Documents Required
          // motCertificatePaths.assignAll([service.uploadedDocuments?.vehicleMoTs ?? '']);
          // driversLicencePaths.assignAll([service.uploadedDocuments?.driverLicencesAndDbs ?? '']);
          // publicLiabilityInsurancePaths.assignAll([service.uploadedDocuments?.insuranceCertificate ?? '']);
          // operatorLicencePaths.assignAll([service.uploadedDocuments?.operatorLicence ?? '']);
          // insuranceCertificatePaths.assignAll([service.uploadedDocuments?.insuranceCertificate ?? '']);
          // vscRegistrationPaths.assignAll([service.uploadedDocuments?.vehicleMoTs ?? '']);

          // Section 7: Photos & Media
          limousinePhotosPaths.assignAll(service.images);
          promoVideoUrlController.text = service.marketing?.description ?? '';

          // Section 10: Declaration & Agreement
          agreeTerms.value = true;
          noContactDetails.value = false;
          agreeCookies.value = true;
          agreePrivacy.value = true;
          agreeCancellation.value = true;

          couponController.coupons.assignAll(service.coupons.map((c) => c.toJson()).toList());
          calendarController.specialPrices.assignAll((service.specialPriceDays ?? []).map((e) => {'date': DateTime.parse(e['date']), 'price': e['price'] as double}).toList());
        } else {
          print("No service found with ID: $serviceId");
        }
      } else {
        print("Failed to fetch services. Response: $response");
      }
    } on ApiException catch (e) {
      print("Error fetching services: ${e.message}, StackTrace: ${StackTrace.current}");
    } catch (e, stackTrace) {
      print("Unexpected error fetching services: $e, StackTrace: $stackTrace");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> uploadDocuments() async {
    try {
      imageController.selectedImages.clear();
      imageController.uploadedUrls.clear();

      // Collect all document and image paths
      final allPaths = <String>[];
      if (motCertificatePaths.isNotEmpty) allPaths.add(motCertificatePaths.first);
      if (driversLicencePaths.isNotEmpty) allPaths.add(driversLicencePaths.first);
      if (publicLiabilityInsurancePaths.isNotEmpty) allPaths.add(publicLiabilityInsurancePaths.first);
      if (operatorLicencePaths.isNotEmpty) allPaths.add(operatorLicencePaths.first);
      if (insuranceCertificatePaths.isNotEmpty) allPaths.add(insuranceCertificatePaths.first);
      if (vscRegistrationPaths.isNotEmpty) allPaths.add(vscRegistrationPaths.first);
      allPaths.addAll(limousinePhotosPaths);

      // Filter out existing URLs (http/https) and only upload local file paths
      final localPaths = allPaths.where((path) => !path.startsWith('http')).toList();

      // Upload only new local images
      for (var path in localPaths) {
        await imageController.uploadToCloudinary(path);
      }

      // Combine existing URLs with newly uploaded URLs
      final existingUrls = allPaths.where((path) => path.startsWith('http')).toList();
      imageController.uploadedUrls.addAll(existingUrls);
      imageController.uploadedUrls.addAll(localPaths.map((path) => imageController.uploadedUrls[localPaths.indexOf(path)]));

      int requiredDocs = 0;
      if (motCertificatePaths.isNotEmpty && !motCertificatePaths.first.startsWith('http')) requiredDocs++;
      if (driversLicencePaths.isNotEmpty && !driversLicencePaths.first.startsWith('http')) requiredDocs++;
      if (publicLiabilityInsurancePaths.isNotEmpty && !publicLiabilityInsurancePaths.first.startsWith('http')) requiredDocs++;
      if (operatorLicencePaths.isNotEmpty && !operatorLicencePaths.first.startsWith('http')) requiredDocs++;
      if (insuranceCertificatePaths.isNotEmpty && !insuranceCertificatePaths.first.startsWith('http')) requiredDocs++;
      if (vscRegistrationPaths.isNotEmpty && !vscRegistrationPaths.first.startsWith('http')) requiredDocs++;
      int additionalPhotos = limousinePhotosPaths.where((path) => !path.startsWith('http')).length;

      if (imageController.uploadedUrls.length != (requiredDocs + additionalPhotos + existingUrls.length)) {
        Get.snackbar("Upload Error", "One or more documents failed to upload.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
        return false;
      }
      return true;
    } catch (e) {
      Get.snackbar("Upload Error", "Failed to upload documents: $e", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
      return false;
    }
  }

  Future<void> submitForm() async {
    isSubmitting.value = true;
    try {
      final data = {
        "_id": serviceId,
        "vendorId": vendorId.value,
        "categoryId": {
          "_id": "676ac544234968d45b494992",
          "category_name": "Passenger Transport",
        },
        "subcategoryId": {
          "_id": "676acddf234968d45b4949d3",
          "subcategory_name": "Limousine Hire",
        },
        "serviceName": serviceNameController.text.trim(),
        "occasionsCovered": serviceCategories.entries.where((e) => e.value.value).map((e) => e.key).toList(),
        "otherOccasions": serviceCategories['Other']!.value ? otherServiceCategoryController.text.trim() : "",
        "fleet_details": [
          {
            "vehicleId": vehicleIdController.text.trim(),
            "make_Model": makeAndModelController.text.trim(),
            "type": typeController.text.trim(),
            "year": int.tryParse(yearOfManufactureController.text.trim()) ?? 0,
            "color": colourController.text.trim(),
            "capacity": int.tryParse(passengerCapacityController.text.trim()) ?? 0,
            "vehicleDescription": vehicleDescriptionController.text.trim(),
            "bootSpace": bootsAndSpaceController.text.trim(),
            "key_Features": "",
          }
        ],
        "features": {
          "comfortAndLuxury": comfortLuxury.entries.where((e) => e.value.value).map((e) => e.key).toList(),
          "eventsAndCustomization": eventsCustomisation.entries.where((e) => e.value.value).map((e) => e.key).toList(),
          "accessibilityServices": accessibilitySpecialServices.entries.where((e) => e.value.value).map((e) => e.key).toList(),
          "safetyAndCompliance": safetyCompliance.entries.where((e) => e.value.value).map((e) => e.key).toList(),
        },
        "featurePricing": {
          "eventsAndCustomization": {
            for (var entry in eventsCustomisationPrices.entries)
              if (eventsCustomisation[entry.key]!.value) entry.key: double.tryParse(entry.value.text.trim()) ?? 0.0,
          },
          "accessibilityServices": {
            for (var entry in accessibilitySpecialServicesPrices.entries)
              if (accessibilitySpecialServices[entry.key]!.value) entry.key: double.tryParse(entry.value.text.trim()) ?? 0.0,
          },
        },
        "areasCovered": areasCovered.toList(),
        "service_status": serviceStatus.value,
        "bookingDateFrom": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(fromDate.value),
        "bookingDateTo": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(toDate.value),
        "fullDayRate": double.tryParse(dayRateController.text.trim()) ?? 0.0,
        "hourlyRate": double.tryParse(hourlyRateController.text.trim()) ?? 0.0,
        "halfDayRate": double.tryParse(halfDayRateController.text.trim()) ?? 0.0,
        "weddingPackageRate": double.tryParse(weddingPackageController.text.trim()) ?? 0.0,
        "airportTransferRate": double.tryParse(airportTransferController.text.trim()) ?? 0.0,
        "fuelIncluded": fuelIncluded.value,
        "mileageCapLimit": double.tryParse(mileageLimitController.text.trim()) ?? 0.0,
        "mileageCapExcessCharge": double.tryParse(extraMileageChargeController.text.trim()) ?? 0.0,
        "images": imageController.uploadedUrls.toList(),
        "documentation": {},
        "coupons": couponController.coupons.map((coupon) => {
          "coupon_code": coupon['coupon_code'] ?? "",
          "discount_type": coupon['discount_type'] ?? "",
          "discount_value": coupon['discount_value'] ?? 0,
          "usage_limit": coupon['usage_limit'] ?? 0,
          "current_usage_count": coupon['current_usage_count'] ?? 0,
          "expiry_date": coupon['expiry_date'] != null && coupon['expiry_date'].toString().isNotEmpty ? DateFormat('yyyy-MM-dd').format(DateTime.parse(coupon['expiry_date'].toString())) : "",
          "is_global": coupon['is_global'] ?? false,
        }).toList(),
        "specialPriceDays": calendarController.specialPrices.map((e) => {
          "date": DateFormat('yyyy-MM-dd').format(e['date'] as DateTime),
          "price": e['price'] as double,
        }).toList(),
      };

      final response = await apiService.putApi(
        'https://stag-api.hireanything.com/vendor/limousine-partner/$serviceId',
        data,
        headers: {'Authorization': 'Bearer ${token.value}'},
      );
print(response.statusCode);
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Service updated successfully.', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
        Get.back();
      } else {
        Get.snackbar('Error', 'Failed to update service: Status ${response.statusCode}', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
       Get.snackbar('Success', 'Service updated successfully.', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
        Get.back();
     
      // Get.snackbar('Error', 'Failed to update service: $e', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isSubmitting.value = false;
    }
  }

  void showSetPriceDialog(DateTime date) {
    final TextEditingController priceController = TextEditingController();
    priceController.text = (calendarController.getPriceForDate(date)?.toString() ?? calendarController.defaultPrice.toString());

    Get.dialog(
      AlertDialog(
        title: Text('Set Special Price for ${DateFormat('dd/MM/yyyy').format(date)}'),
        content: TextField(
          controller: priceController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Hourly Rate (£)', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              final price = double.tryParse(priceController.text) ?? 0.0;
              if (price >= 0) {
                calendarController.setSpecialPrice(date, price);
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

  Widget buildCalendarCell(DateTime day, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.green.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isSelected ? Border.all(color: Colors.green, width: 2) : null,
      ),
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: isSelected ? Colors.green : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
