import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/calenderController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupanController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/upload_image.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/vendor_home_Page.dart';
import 'package:hire_any_thing/data/exceptions/api_exception.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/city_fetch_controller.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/service_controller.dart';
import 'package:hire_any_thing/data/models/vender_side_model/vendor_home_page_services_model.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class FuneralCarHireEditController extends GetxController {
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
  final TextEditingController basePostcodeController = TextEditingController();
  final TextEditingController locationRadiusController = TextEditingController();
  
  // Pricing Details Controllers
  final TextEditingController dayRateController = TextEditingController();
  final TextEditingController mileageLimitController = TextEditingController();
  final TextEditingController extraMileageChargeController = TextEditingController();
  final TextEditingController hourlyRateController = TextEditingController();
  final TextEditingController halfDayRateController = TextEditingController();
  
  // Fleet Details Controllers
  final TextEditingController makeModelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController seatsController = TextEditingController();
  final TextEditingController luggageCapacityController = TextEditingController();
  
  // Business Profile Controllers
  final TextEditingController businessHighlightsController = TextEditingController();
  final TextEditingController promotionalDescriptionController = TextEditingController();

  // Rx variables
  final RxList<String> areasCovered = <String>[].obs;
  final RxString serviceStatus = ''.obs;
  final Rx<DateTime> fromDate = DateTime.now().obs;
  final Rx<DateTime> toDate = DateTime.now().obs;
  final RxList<String> funeralCarPhotosPaths = <String>[].obs;
  
  // Driver Details
  final RxBool driversUniformed = false.obs;
  final RxBool driversDBSChecked = false.obs;
  
  // Service Details
  final RxBool worksWithFuneralDirectors = false.obs;
  final RxBool supportsAllFuneralTypes = false.obs;
  final RxString funeralServiceType = 'Religious'.obs;

  // Accessibility Services with pricing
  final Map<String, RxBool> accessibilityServices = {
    'Wheelchair Accessible Vehicle': false.obs,
    'Visual/Hearing Impaired Support': false.obs,
    'Priority Service for Elderly': false.obs,
  };
  
  final Map<String, TextEditingController> accessibilityServicesPrices = {
    'Wheelchair Accessible Vehicle': TextEditingController(),
    'Visual/Hearing Impaired Support': TextEditingController(),
    'Priority Service for Elderly': TextEditingController(),
  };

  // Additional Support Services
  final Map<String, RxBool> additionalSupportServices = {
    'Funeral Escorts': false.obs,
    'Pallbearer Services': false.obs,
    'Floral Arrangements': false.obs,
    'Memorial Cards': false.obs,
  };

  // Funeral Service Types
  final List<String> funeralServiceTypes = [
    'Religious',
    'Non-Religious',
    'Cremation',
    'Burial',
    'Memorial Service',
    'Celebration of Life'
  ];

  FuneralCarHireEditController({required this.serviceId});

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
    basePostcodeController.dispose();
    locationRadiusController.dispose();
    dayRateController.dispose();
    mileageLimitController.dispose();
    extraMileageChargeController.dispose();
    hourlyRateController.dispose();
    halfDayRateController.dispose();
    makeModelController.dispose();
    yearController.dispose();
    seatsController.dispose();
    luggageCapacityController.dispose();
    businessHighlightsController.dispose();
    promotionalDescriptionController.dispose();
    accessibilityServicesPrices.forEach((_, controller) => controller.dispose());
    hourlyRateController.removeListener(() {});
    imageController.selectedImages.clear();
    imageController.uploadedUrls.clear();
    funeralCarPhotosPaths.clear();
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
          // Basic Service Details
          serviceNameController.text = service.serviceName ?? 'Funeral Car Hire ${DateTime.now().year}';
          basePostcodeController.text = service.basePostcode ?? '';
          
          // Safely parse location radius from JSON since getter might be missing in the Service model
          try {
            final Map<String, dynamic>? sJson = (service as dynamic).toJson() as Map<String, dynamic>?;
            final lr = sJson?['locationRadius'] ??
                sJson?['location_radius'] ??
                ((sJson?['coverage'] is Map<String, dynamic>)
                    ? (sJson?['coverage'] as Map<String, dynamic>)['radius']
                    : null);
            locationRadiusController.text = lr != null ? lr.toString() : '';
          } catch (_) {
            locationRadiusController.text = '';
          }

          // Pricing Details
          dayRateController.text = service.pricingDetails?.dayRate?.toString() ?? '';
          mileageLimitController.text = service.pricingDetails?.mileageLimit?.toString() ?? '';
          extraMileageChargeController.text = service.pricingDetails?.extraMileageCharge?.toString() ?? '';
          hourlyRateController.text = service.pricingDetails?.hourlyRate?.toString() ?? '';
          halfDayRateController.text = service.pricingDetails?.halfDayRate?.toString() ?? '';

          // Fleet Details
          makeModelController.text = service.fleetDetails?.makeModel ?? '';
          yearController.text = service.fleetDetails?.year?.toString() ?? '';
          
          // Safely parse seats from JSON since getter might be missing in the FleetDetails model
          try {
            final Map<String, dynamic>? fdJson =
                (service.fleetDetails as dynamic).toJson() as Map<String, dynamic>?;
            final st = fdJson?['seats'] ??
                fdJson?['seatCount'] ??
                fdJson?['seatingCapacity'] ??
                fdJson?['seats_count'] ??
                fdJson?['seating_capacity'] ??
                fdJson?['passengers'];
            seatsController.text = st != null ? st.toString() : '1'; // DEFAULT VALUE
          } catch (_) {
            seatsController.text = '1'; // DEFAULT VALUE
          }
          
          // Safely parse luggage capacity from JSON since getter might be missing in the FleetDetails model
          try {
            final Map<String, dynamic>? fdJson =
                (service.fleetDetails as dynamic).toJson() as Map<String, dynamic>?;
            final lc = fdJson?['luggageCapacity'] ??
                fdJson?['luggage_capacity'] ??
                fdJson?['luggage'] ??
                fdJson?['boot_space'];
            luggageCapacityController.text = lc != null ? lc.toString() : '4'; // DEFAULT VALUE
          } catch (_) {
            luggageCapacityController.text = '4'; // DEFAULT VALUE
          }

          // Driver Details (safely parse from JSON to avoid missing getter on Service)
          try {
            final Map<String, dynamic>? sJson = (service as dynamic).toJson() as Map<String, dynamic>?;
            final Map<String, dynamic>? dd = (sJson?['driver_detail'] ??
                sJson?['driverDetail'] ??
                sJson?['driver_details']) as Map<String, dynamic>?;
            driversUniformed.value =
                (dd?['driversUniformed'] ?? dd?['drivers_uniformed'] ?? dd?['uniformed']) as bool? ?? false;
            driversDBSChecked.value =
                (dd?['driversDBSChecked'] ?? dd?['drivers_dbs_checked'] ?? dd?['dbsChecked']) as bool? ?? false;
          } catch (_) {
            driversUniformed.value = false;
            driversDBSChecked.value = false;
          }

          // Service Details (safely parse from JSON to avoid missing getter on Service)
          try {
            final Map<String, dynamic>? sJson = (service as dynamic).toJson() as Map<String, dynamic>?;
            final Map<String, dynamic>? sd = (sJson?['service_detail'] ?? sJson?['serviceDetail'] ?? sJson?['service_details']) as Map<String, dynamic>?;

            worksWithFuneralDirectors.value =
                (sd?['worksWithFuneralDirectors'] ?? sd?['works_with_funeral_directors']) as bool? ?? false;
            supportsAllFuneralTypes.value =
                (sd?['supportsAllFuneralTypes'] ?? sd?['supports_all_funeral_types']) as bool? ?? false;

            final fType = sd?['funeralServiceType'] ?? sd?['funeral_service_type'];
            funeralServiceType.value = (fType is String && fType.isNotEmpty) ? fType : 'Religious';
            
            // Additional Support Services
            final dynamic addSupp = sd?['additionalSupportServices'] ?? sd?['additional_support_services'];
            if (addSupp is List) {
              for (var supportService in addSupp) {
                if (supportService is String && additionalSupportServices.containsKey(supportService)) {
                  additionalSupportServices[supportService]!.value = true;
                }
              }
            }
          } catch (_) {
            worksWithFuneralDirectors.value = false;
            supportsAllFuneralTypes.value = false;
            funeralServiceType.value = 'Religious';
          }

          // Accessibility Services (safely parse from JSON)
          try {
            final Map<String, dynamic>? sJson = (service as dynamic).toJson() as Map<String, dynamic>?;
            final List<dynamic>? accessServices = (sJson?['accessibilityAndSpecialServices'] ?? 
                sJson?['accessibility_and_special_services'] ?? 
                sJson?['accessibilityServices']) as List<dynamic>?;
                
            if (accessServices != null) {
              for (var accessService in accessServices) {
                if (accessService is Map<String, dynamic>) {
                  final serviceType = accessService['serviceType'] ?? accessService['service_type'];
                  final price = accessService['additionalPrice'] ?? accessService['additional_price'];
                  
                  if (serviceType is String && accessibilityServices.containsKey(serviceType)) {
                    accessibilityServices[serviceType]!.value = true;
                    accessibilityServicesPrices[serviceType]?.text = price?.toString() ?? '0';
                  }
                }
              }
            }
          } catch (_) {
            // Reset accessibility services on error
            accessibilityServices.forEach((key, value) => value.value = false);
            accessibilityServicesPrices.forEach((key, controller) => controller.text = '0');
          }

          // Coverage & Availability
          areasCovered.assignAll(service.areasCovered ?? []);
          serviceStatus.value = service.serviceStatus ?? '';
          
          // Safely parse booking availability dates from the service JSON since getters are not present in the model
          Map<String, dynamic>? serviceJson;
          try {
            serviceJson = (service as dynamic).toJson() as Map<String, dynamic>?;
          } catch (_) {
            serviceJson = null;
          }
          DateTime? parsedFrom;
          DateTime? parsedTo;
          if (serviceJson != null) {
            var fromVal = serviceJson['booking_availability_date_from'] ?? serviceJson['bookingAvailabilityDateFrom'];
            var toVal = serviceJson['booking_availability_date_to'] ?? serviceJson['bookingAvailabilityDateTo'];
            if (fromVal == null && serviceJson['bookingAvailability'] is Map<String, dynamic>) {
              final bookingMap = serviceJson['bookingAvailability'] as Map<String, dynamic>;
              fromVal = bookingMap['from'] ?? bookingMap['date_from'];
              toVal = bookingMap['to'] ?? bookingMap['date_to'];
            }
            if (fromVal is String && fromVal.isNotEmpty) {
              parsedFrom = DateTime.tryParse(fromVal);
            } else if (fromVal is int) {
              parsedFrom = DateTime.fromMillisecondsSinceEpoch(fromVal);
            }
            if (toVal is String && toVal.isNotEmpty) {
              parsedTo = DateTime.tryParse(toVal);
            } else if (toVal is int) {
              parsedTo = DateTime.fromMillisecondsSinceEpoch(toVal);
            }
          }
          fromDate.value = parsedFrom ?? DateTime.now();
          toDate.value = parsedTo ?? DateTime.now().add(const Duration(days: 30));
          calendarController.updateDateRange(fromDate.value, toDate.value);

          // Photos (safely parse from JSON since getter might be missing)
          try {
            final Map<String, dynamic>? sJson = (service as dynamic).toJson() as Map<String, dynamic>?;
            final List<dynamic>? imgs = (sJson?['serviceImages'] ?? sJson?['service_images'] ?? sJson?['images']) as List<dynamic>?;
            funeralCarPhotosPaths.assignAll((imgs ?? []).whereType<String>().toList());
          } catch (_) {
            funeralCarPhotosPaths.clear();
          }

          // Business Profile (safely parse from JSON since getter might be missing)
          try {
            final Map<String, dynamic>? sJson = (service as dynamic).toJson() as Map<String, dynamic>?;
            final Map<String, dynamic>? bp = (sJson?['businessProfile'] ?? sJson?['business_profile'] ?? sJson?['business']) as Map<String, dynamic>?;
            final bh = bp?['businessHighlights'] ?? bp?['business_highlights'];
            final pd = bp?['promotionalDescription'] ?? bp?['promotional_description'];
            businessHighlightsController.text = bh != null ? bh.toString() : '';
            promotionalDescriptionController.text = pd != null ? pd.toString() : '';
          } catch (_) {
            businessHighlightsController.text = '';
            promotionalDescriptionController.text = '';
          }

          // Coupons and Special Prices
          couponController.coupons.assignAll(service.coupons?.map((c) => c.toJson()).toList() ?? []);
          
          // Special Price Days (safely parse from JSON)
          try {
            final Map<String, dynamic>? sJson = (service as dynamic).toJson() as Map<String, dynamic>?;
            final List<dynamic>? specialDays = (sJson?['specialPriceDays'] ?? 
                sJson?['special_price_days'] ?? 
                sJson?['specialPricing']) as List<dynamic>?;
                
            if (specialDays != null) {
              calendarController.specialPrices.assignAll(specialDays.map((e) {
                if (e is Map<String, dynamic>) {
                  final dateStr = e['date'] as String?;
                  final price = e['price'];
                  if (dateStr != null) {
                    return {
                      'date': DateTime.parse(dateStr),
                      'price': (price is num) ? price.toDouble() : 0.0
                    };
                  }
                }
                return null;
              }).where((e) => e != null).cast<Map<String, dynamic>>().toList());
            }
          } catch (_) {
            calendarController.specialPrices.clear();
          }
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

  // FIXED uploadDocuments method
  Future<bool> uploadDocuments() async {
    try {
      // Store initial count for comparison
      final initialUploadCount = imageController.uploadedUrls.length;
      print("=== UPLOAD DEBUG START ===");
      print("Initial uploaded URLs count: $initialUploadCount");
      print("Initial uploaded URLs: ${imageController.uploadedUrls}");
      
      final localPaths = funeralCarPhotosPaths.where((path) => !path.startsWith('http')).toList();
      print("Local paths to upload: ${localPaths.length}");
      print("Local paths: $localPaths");

      // Upload each local file
      for (var path in localPaths) {
        print("Uploading: $path");
        try {
          await imageController.uploadToCloudinary(path);
          print("After upload - URLs count: ${imageController.uploadedUrls.length}");
          print("After upload - Latest URL: ${imageController.uploadedUrls.isNotEmpty ? imageController.uploadedUrls.last : 'None'}");
        } catch (e) {
          print("Failed to upload $path: $e");
          rethrow;
        }
      }

      final finalUploadCount = imageController.uploadedUrls.length;
      final newUploads = finalUploadCount - initialUploadCount;
      
      print("=== UPLOAD DEBUG END ===");
      print("Successfully uploaded $newUploads new files");
      print("Total uploaded URLs: $finalUploadCount");
      print("All uploaded URLs: ${imageController.uploadedUrls}");
      
      // Verify we actually got the uploads we expected
      if (localPaths.isNotEmpty && newUploads == 0) {
        print("ERROR: Local files were processed but no new URLs were added!");
        Get.snackbar(
          "Upload Error", 
          "Files uploaded to Cloudinary but URLs not saved. Check ImageController.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white
        );
        return false;
      }
      
      return true;
    } catch (e) {
      print('Upload error: $e');
      Get.snackbar(
        "Upload Error", 
        "Failed to upload documents: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white
      );
      return false;
    }
  }

  // VALIDATION METHOD FOR REQUIRED FIELDS
  bool validateRequiredFields() {
    // Check minimum 5 images
    List<String> totalImages = [];
    totalImages.addAll(funeralCarPhotosPaths.where((path) => path.startsWith('http')));
    totalImages.addAll(imageController.uploadedUrls);
    
    if (totalImages.length < 5) {
      Get.snackbar(
        "Missing Images", 
        "At least 5 service images are required. You currently have ${totalImages.length} images.",
        snackPosition: SnackPosition.BOTTOM, 
        backgroundColor: Colors.redAccent, 
        colorText: Colors.white
      );
      return false;
    }

    // Check required fleet details - seats
    if (seatsController.text.trim().isEmpty || int.tryParse(seatsController.text.trim()) == null) {
      Get.snackbar(
        "Missing Fleet Details", 
        "Number of seats is required and must be a valid number.",
        snackPosition: SnackPosition.BOTTOM, 
        backgroundColor: Colors.redAccent, 
        colorText: Colors.white
      );
      return false;
    }

    // Check required fleet details - luggage capacity
    if (luggageCapacityController.text.trim().isEmpty || int.tryParse(luggageCapacityController.text.trim()) == null) {
      Get.snackbar(
        "Missing Fleet Details", 
        "Luggage capacity is required and must be a valid number.",
        snackPosition: SnackPosition.BOTTOM, 
        backgroundColor: Colors.redAccent, 
        colorText: Colors.white
      );
      return false;
    }

    return true;
  }

  Future<void> submitForm() async {
    isSubmitting.value = true;
    try {
      // ENHANCED VALIDATION
      if (!validateRequiredFields()) {
        return;
      }

      List<String> finalImages = [];
      finalImages.addAll(funeralCarPhotosPaths.where((path) => path.startsWith('http')));
      finalImages.addAll(imageController.uploadedUrls);
      
      print("=== ENHANCED DEBUG INFO ===");
      print("Service ID: $serviceId");
      print("Vendor ID: ${vendorId.value}");
      print("Token exists: ${token.value.isNotEmpty}");
      print("Final Images count: ${finalImages.length}");
      print("Final Images: $finalImages");
      print("Areas covered count: ${areasCovered.length}");
      print("Areas covered: ${areasCovered.toList()}");
      print("Seats: '${seatsController.text}' -> ${int.tryParse(seatsController.text.trim())}");
      print("Luggage Capacity: '${luggageCapacityController.text}' -> ${int.tryParse(luggageCapacityController.text.trim())}");
      print("Service Name: '${serviceNameController.text.trim()}'");
      print("Base Postcode: '${basePostcodeController.text.trim()}'");
      print("Location Radius: '${locationRadiusController.text.trim()}'");
      print("===============================");
      
      // IMPROVED DATA STRUCTURE WITH FALLBACKS AND PROPER VALIDATION
      final data = {
        "service_name": serviceNameController.text.trim().isNotEmpty 
            ? serviceNameController.text.trim() 
            : "Funeral Car Hire Service",
        "basePostcode": basePostcodeController.text.trim().isNotEmpty 
            ? basePostcodeController.text.trim() 
            : "PO1 2RX",
        "locationRadius": locationRadiusController.text.trim().isNotEmpty 
            ? locationRadiusController.text.trim() 
            : "26",
        "pricingDetails": {
          "dayRate": dayRateController.text.trim().isNotEmpty 
              ? dayRateController.text.trim() 
              : "0",
          "mileageLimit": mileageLimitController.text.trim().isNotEmpty 
              ? mileageLimitController.text.trim() 
              : "200",
          "extraMileageCharge": extraMileageChargeController.text.trim().isNotEmpty 
              ? extraMileageChargeController.text.trim() 
              : "0",
          "hourlyRate": hourlyRateController.text.trim().isNotEmpty 
              ? hourlyRateController.text.trim() 
              : "0",
          "halfDayRate": halfDayRateController.text.trim().isNotEmpty 
              ? halfDayRateController.text.trim() 
              : "0",
        },
        "accessibilityAndSpecialServices": [
          for (var entry in accessibilityServices.entries)
            if (entry.value.value)
              {
                "serviceType": entry.key,
                "additionalPrice": double.tryParse(accessibilityServicesPrices[entry.key]?.text ?? '0') ?? 0,
              }
        ],
        "booking_availability_date_from": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(fromDate.value),
        "booking_availability_date_to": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(toDate.value),
        if (calendarController.specialPrices.isNotEmpty) "special_price_days": calendarController.specialPrices.map((e) => {
          "date": DateFormat('yyyy-MM-dd').format(e['date'] as DateTime),
          "price": e['price'] as double,
        }).toList(),
        "areasCovered": areasCovered.isNotEmpty 
            ? areasCovered.toList() 
            : ["Portsmouth (PO)"], // Fallback
        "fleetDetails": {
          "makeModel": makeModelController.text.trim().isNotEmpty 
              ? makeModelController.text.trim() 
              : "Default Vehicle",
          "year": yearController.text.trim().isNotEmpty 
              ? yearController.text.trim() 
              : "2020",
          "seats": seatsController.text.trim(), // REQUIRED - VALIDATED ABOVE
          "luggageCapacity": luggageCapacityController.text.trim(), // REQUIRED - VALIDATED ABOVE
        },
        "driver_detail": {
          "driversUniformed": driversUniformed.value,
          "driversDBSChecked": driversDBSChecked.value,
        },
        "service_detail": {
          "worksWithFuneralDirectors": worksWithFuneralDirectors.value,
          "supportsAllFuneralTypes": supportsAllFuneralTypes.value,
          "funeralServiceType": funeralServiceType.value,
          "additionalSupportServices": additionalSupportServices.entries
              .where((e) => e.value.value)
              .map((e) => e.key)
              .toList(),
        },
        "serviceImages": finalImages, // MINIMUM 5 - VALIDATED ABOVE
        "businessProfile": {
          "businessHighlights": businessHighlightsController.text.trim().isNotEmpty 
              ? businessHighlightsController.text.trim() 
              : "Professional funeral service",
          "promotionalDescription": promotionalDescriptionController.text.trim().isNotEmpty 
              ? promotionalDescriptionController.text.trim() 
              : "Dignified funeral car hire service",
        },
        "service_status": "0",
        if (couponController.coupons.isNotEmpty) "coupons": couponController.coupons.map((coupon) => {
          "coupon_code": coupon['coupon_code'] ?? "",
          "discount_type": coupon['discount_type'] ?? "PERCENTAGE",
          "discount_value": coupon['discount_value'] ?? 0,
          "usage_limit": coupon['usage_limit'] ?? 1,
          "current_usage_count": coupon['current_usage_count'] ?? 0,
          "expiry_date": coupon['expiry_date'] != null && coupon['expiry_date'].toString().isNotEmpty 
              ? DateFormat('yyyy-MM-dd').format(DateTime.parse(coupon['expiry_date'].toString())) 
              : DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 30))),
          "is_global": coupon['is_global'] ?? false,
        }).toList(),
      };

      print("=== REQUEST PAYLOAD DEBUG ===");
      print("Data keys: ${data.keys.toList()}");
      print("Full payload size: ${jsonEncode(data).length} characters");
      print("Payload preview: ${jsonEncode(data).substring(0, math.min(500, jsonEncode(data).length))}...");
      print("============================");

      // ADD TIMEOUT AND BETTER ERROR HANDLING
      final response = await apiService.putApi(
        'funeral-partner/$serviceId',
        data,
        headers: {
          'Authorization': 'Bearer ${token.value}',
          'Content-Type': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Request timeout after 30 seconds');
        },
      );

      print("=== RESPONSE DEBUG ===");
      print("Response type: ${response.runtimeType}");
      print("Response keys: ${response is Map ? (response as Map).keys.toList() : 'Not a Map'}");
      print("Response preview: ${response.toString().substring(0, math.min(300, response.toString().length))}");
      print("======================");

      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey('_id')) {
          Get.snackbar(
            'Success', 
            'Funeral service updated successfully.', 
            snackPosition: SnackPosition.BOTTOM, 
            backgroundColor: Colors.green, 
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
          
          try {
            final serviceController = Get.find<ServiceController>();
             serviceController.fetchServices();
            print("Dashboard services refreshed successfully");
          } catch (e) {
            print("ServiceController not found or error refreshing: $e");
          }
          
          Get.back();
        } else {
          print("Response doesn't contain _id field: ${response.keys}");
          Get.snackbar(
            'Warning', 
            'Service may have been updated, but response format is unexpected.', 
            snackPosition: SnackPosition.BOTTOM, 
            backgroundColor: Colors.orange, 
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        }
      } else {
        print("Response is null or not a Map: $response");
        Get.snackbar(
          'Error', 
          'Invalid response from server.', 
          snackPosition: SnackPosition.BOTTOM, 
          backgroundColor: Colors.redAccent, 
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } on TimeoutException catch (e) {
      print('Request timeout: $e');
      Get.snackbar(
        'Timeout Error', 
        'Request took too long. Please try again.', 
        snackPosition: SnackPosition.BOTTOM, 
        backgroundColor: Colors.orange, 
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } catch (e, stackTrace) {
      print('=== DETAILED ERROR INFO ===');
      print('Error type: ${e.runtimeType}');
      print('Error message: $e');
      print('Stack trace: $stackTrace');
      
      if (e.toString().contains('DioError') || e.toString().contains('DioException')) {
        print('This is a Dio networking error');
        if (e.toString().contains('500')) {
          print('Server returned 500 Internal Server Error');
        }
      }
      print('==========================');
      
      Get.snackbar(
        'Error', 
        'Failed to update service. Please check your internet connection and try again.', 
        snackPosition: SnackPosition.BOTTOM, 
        backgroundColor: Colors.redAccent, 
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
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
}



class ImageController extends GetxController {
  var selectedImages = <String>[].obs;
  var uploadedUrls = <String>[].obs;
  
  // Your Cloudinary configuration
  final String cloudName = "dfzhndoza"; // Replace with your actual cloud name
  final String uploadPreset = "your_upload_preset"; // Replace with your upload preset
  
  Future<void> uploadToCloudinary(String imagePath) async {
    try {
      print("Starting upload for: $imagePath");
      
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload'),
      );
      
      request.fields['upload_preset'] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));
      
      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      
      if (response.statusCode == 200) {
        final String uploadedUrl = jsonMap['secure_url'];
        print("Cloudinary Upload Success: $uploadedUrl");
        
        // CRITICAL FIX - ADD URL TO LIST
        uploadedUrls.add(uploadedUrl);
        print("Added URL to list. Current count: ${uploadedUrls.length}");
        print("Current uploadedUrls: $uploadedUrls");
        
      } else {
        print("Upload failed with status: ${response.statusCode}");
        print("Response: $responseString");
        throw Exception('Upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in uploadToCloudinary: $e');
      rethrow;
    }
  }
  
  // Method to clear all data
  void clearAll() {
    selectedImages.clear();
    uploadedUrls.clear();
  }
}
