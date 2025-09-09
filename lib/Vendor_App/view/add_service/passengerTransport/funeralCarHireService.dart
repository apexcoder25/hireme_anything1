import 'dart:io';
import 'dart:math' as math;
import 'dart:convert';

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

class FuneralCarHireService extends StatefulWidget {
  final Rxn<String> Category;
  final Rxn<String> SubCategory;
  final String? CategoryId;
  final String? SubCategoryId;

  const FuneralCarHireService({
    super.key,
    required this.Category,
    required this.SubCategory,
    this.CategoryId,
    this.SubCategoryId,
  });

  @override
  State<FuneralCarHireService> createState() => _FuneralCarHireServiceState();
}

class _FuneralCarHireServiceState extends State<FuneralCarHireService> {
  final ImageController imageController = Get.put(ImageController());
  final CouponController couponController = Get.put(CouponController());
  final CalendarController calendarController = Get.put(CalendarController());
  final CityFetchController cityFetchController =
      Get.put(CityFetchController());

  // Form Controllers
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController basePostcodeController = TextEditingController();
  final TextEditingController locationRadiusController =
      TextEditingController();
  final TextEditingController makeModelController = TextEditingController();
  final TextEditingController luggageCapacityController =
      TextEditingController();
  final TextEditingController numberOfSeatsController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController dayRateController = TextEditingController();
  final TextEditingController mileageLimitController = TextEditingController();
  final TextEditingController extraMileageChargeController =
      TextEditingController();
  final TextEditingController hourlyRateController = TextEditingController();
  final TextEditingController halfDayRateController = TextEditingController();
  final TextEditingController uniqueServiceController = TextEditingController();
  final TextEditingController promotionalDescriptionController =
      TextEditingController();

  // Accessibility Price Controllers
  final TextEditingController wheelchairAccessPriceController =
      TextEditingController();
  final TextEditingController visualHearingSupportPriceController =
      TextEditingController();
  final TextEditingController languageTranslationPriceController =
      TextEditingController();
  final TextEditingController careAttendantPriceController =
      TextEditingController();
  final TextEditingController boardingAssistancePriceController =
      TextEditingController();
  final TextEditingController priorityServicePriceController =
      TextEditingController();

  // Features Maps
  final Map<String, bool> vehicleTypes = {
    'Traditional Black Hearse': false,
    'Horse-Drawn Carriage (White/Black)': false,
    'Limousine (Mourner Cars)': false,
    'Vintage Hearse': false,
    'Motorcycle Hearse': false,
    'Specialty Vehicles': false,
  };

  final Map<String, bool> accessibilitySpecial = {
    'Wheelchair Accessible Vehicle': false,
    'Visual/Hearing Impaired Support': false,
    'Language Translation': false,
    'Care/Attendant Assistance': false,
    'Assistance with Boarding': false,
    'Priority Service for Elderly': false,
  };

  final Map<String, bool> driverDetails = {
    'Drivers are uniformed and professionally trained': false,
    'Drivers are DBS checked and appropriately licensed': false,
    'We coordinate with funeral directors': false,
    'We support both religious & non-religious funerals': false,
  };

  final Map<String, bool> additionalSupportServices = {
    'Funeral Escorts': false,
    'Floral Carriage': false,
    'Pallbearer Services': false,
    'Accessible Vehicles for Elderly/Mobility-Impaired Mourners': false,
    'Customisation Options': false,
  };

  // Other variables
  final RxList<String> areasCovered = <String>[].obs;
  final RxList<String> fleetPhotosPaths = <String>[].obs;
  final Rx<DateTime> firstRegistrationDate = DateTime.now().obs;
  String? serviceStatus;
  String? funeralServiceType;
  String? cancellationPolicy;
  bool _isSubmitting = false;
  String? vendorId;

  // Declaration flags
  bool agreeTerms = false;
  bool noContactDetails = false;
  bool agreeCookies = false;
  bool agreePrivacy = false;
  bool agreeCancellation = false;

  final Map<String, String> cancellationPolicyMap = {
    'Flexible-Full refund if canceled 48+ hours in advance': "FLEXIBLE",
    'Moderate-Full refund if canceled 72+ hours in advance': "MODERATE",
    'Strict-Full refund if canceled 7+ days in advance': "STRICT",
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadVendorId();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final now = DateTime.now();
      if (calendarController.fromDate.value.isBefore(now)) {
        calendarController.fromDate.value = now;
      }
      if (calendarController.toDate.value.isBefore(now)) {
        calendarController.toDate.value = now.add(const Duration(days: 7));
      }
    });

    hourlyRateController.addListener(() {
      final price = double.tryParse(hourlyRateController.text) ?? 0.0;
      calendarController.setDefaultPrice(price);
    });
  }

  @override
  void dispose() {
    // Dispose all controllers
    serviceNameController.dispose();
    basePostcodeController.dispose();
    locationRadiusController.dispose();
    makeModelController.dispose();
    luggageCapacityController.dispose();
    numberOfSeatsController.dispose();
    yearController.dispose();
    dayRateController.dispose();
    mileageLimitController.dispose();
    extraMileageChargeController.dispose();
    hourlyRateController.dispose();
    halfDayRateController.dispose();
    uniqueServiceController.dispose();
    promotionalDescriptionController.dispose();

    // Dispose accessibility price controllers
    wheelchairAccessPriceController.dispose();
    visualHearingSupportPriceController.dispose();
    languageTranslationPriceController.dispose();
    careAttendantPriceController.dispose();
    boardingAssistancePriceController.dispose();
    priorityServicePriceController.dispose();

    // Clear lists
    areasCovered.clear();
    fleetPhotosPaths.clear();

    super.dispose();
  }

  Future<void> _loadVendorId() async {
    vendorId = await SessionVendorSideManager().getVendorId();
    setState(() {});
  }

  void _submitForm() async {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Validation for minimum mileage limit
      final mileageLimit =
          double.tryParse(mileageLimitController.text.trim()) ?? 0;
      if (mileageLimit < 200) {
        _showError("Mileage limit must be at least 200 miles.");
        return;
      }
      if (yearController.text.trim().isEmpty) {
        yearController.text = DateTime.now().year.toString();
      }

      // Validation for minimum images
      if (fleetPhotosPaths.length < 5) {
        _showError("At least 5 fleet photos are required.");
        return;
      }

      // Areas covered validation
      if (areasCovered.isEmpty) {
        _showError("At least one area covered is required.");
        return;
      }

      // Declaration validation
      if (!agreeTerms ||
          !noContactDetails ||
          !agreeCookies ||
          !agreePrivacy ||
          !agreeCancellation) {
        _showError("Please agree to all declarations.");
        return;
      }

      // Service name validation
      if (serviceNameController.text.trim().isEmpty) {
        _showError("Service name is required.");
        return;
      }

      final data = {
        "vendorId": vendorId,
        "categoryId": widget.CategoryId,
        "subcategoryId": widget.SubCategoryId,
        "service_name": serviceNameController.text.trim(),

        // Base location info
        "basePostcode": basePostcodeController.text.trim(),
        "locationRadius": locationRadiusController.text.trim(),

        // Vehicle types - convert boolean map to array of selected strings
        "funeralVehicleTypes": vehicleTypes.entries
            .where((entry) => entry.value == true)
            .map((entry) => entry.key)
            .toList(),

        // Pricing details - ensure mileage limit is at least 200
        "pricingDetails": {
          "dayRate": dayRateController.text.trim().isEmpty
              ? "0"
              : dayRateController.text.trim(),
          "mileageLimit": math
              .max(200,
                  double.tryParse(mileageLimitController.text.trim()) ?? 200)
              .toString(),
          "extraMileageCharge": extraMileageChargeController.text.trim().isEmpty
              ? "0"
              : extraMileageChargeController.text.trim(),
          "hourlyRate": hourlyRateController.text.trim().isEmpty
              ? "0"
              : hourlyRateController.text.trim(),
          "halfDayRate": halfDayRateController.text.trim().isEmpty
              ? "0"
              : halfDayRateController.text.trim(),
        },

        // FIXED: Changed from booking_date_from/to to booking_availability_date_from/to
        "booking_availability_date_from": calendarController.fromDate.value !=
                null
            ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                .format(calendarController.fromDate.value)
            : DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now()),
        "booking_availability_date_to": calendarController.toDate.value != null
            ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                .format(calendarController.toDate.value)
            : DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                .format(DateTime.now().add(const Duration(days: 30))),

        // Special price days
        "special_price_days": calendarController.specialPrices
            .map((entry) => {
                  "date": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                      .format(entry['date']),
                  "price": entry['price']
                })
            .toList(),

        // Areas covered
        "areasCovered": areasCovered.toList(),

        // FIXED: Fleet details - make year required and not empty
        "fleetDetails": {
          "makeModel": makeModelController.text.trim().isEmpty
              ? "Unknown"
              : makeModelController.text.trim(),
          "year": yearController.text.trim().isEmpty
              ? DateTime.now()
                  .year
                  .toString() // FIXED: Provide default year if empty
              : yearController.text.trim(),
          "seats": numberOfSeatsController.text.trim().isEmpty
              ? "4"
              : numberOfSeatsController.text.trim(),
          "luggageCapacity":
              int.tryParse(luggageCapacityController.text.trim()) ?? 5,
          "firstRegistration": firstRegistrationDate.value.toIso8601String(),
        },

        // Accessibility services - convert boolean map to array of objects
        "accessibilityAndSpecialServices": accessibilitySpecial.entries
            .where((entry) => entry.value == true)
            .map((entry) => {
                  "serviceType": entry.key,
                  "additionalPrice": _getAccessibilityPrice(entry.key)
                })
            .toList(),

        // Driver details
        "driver_detail": {
          "driversUniformed": driverDetails[
                  'Drivers are uniformed and professionally trained'] ??
              true,
          "driversDBSChecked": driverDetails[
                  'Drivers are DBS checked and appropriately licensed'] ??
              false,
        },

        // Service details
        "service_detail": {
          "worksWithFuneralDirectors":
              driverDetails['We coordinate with funeral directors'] ?? false,
          "supportsAllFuneralTypes": driverDetails[
                  'We support both religious & non-religious funerals'] ??
              false,
          "additionalSupportServices": additionalSupportServices.entries
              .where((entry) => entry.value == true)
              .map((entry) => entry.key)
              .toList(),
          "funeralServiceType": funeralServiceType ?? "Religious",
        },

        // FIXED: Changed from service_image to serviceImages (as expected by API)
        "serviceImages": fleetPhotosPaths.toList(),

        // Business profile
        "businessProfile": {
          "businessHighlights": uniqueServiceController.text.trim(),
          "promotionalDescription":
              promotionalDescriptionController.text.trim(),
        },

        "service_status": serviceStatus ?? "open",
        "cancellation_policy_type": cancellationPolicy ?? "FLEXIBLE",

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

        "agreeTerms": agreeTerms,
        "noContactDetails": noContactDetails,
        "agreeCookies": agreeCookies,
        "agreePrivacy": agreePrivacy,
        "agreeCancellation": agreeCancellation,
      };

      print("Submitting data: ${json.encode(data)}");

      // API call
      final api = AddVendorServiceApi();
      final isAdded = await api.addServiceVendor(data, 'funeral');

      if (isAdded) {
        Get.snackbar('Success', 'Service added successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        Get.to(() => HomePageAddService());
      } else {
        _showError('Add Service Failed. Please try again.');
      }
    } catch (e) {
      print("API Error: $e");
      _showError('Server error: ${e.toString()}');
    } finally {
      setState(() {
        _isSubmitting = false;
      });

      // Refresh services
      try {
        final ServiceController controller = Get.find<ServiceController>();
        controller.fetchServices();
      } catch (e) {
        print("Error refreshing services: $e");
      }
    }
  }

  void _showError(String message) {
    setState(() {
      _isSubmitting = false;
    });
    Get.snackbar('Error', message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white);
  }

  double _getAccessibilityPrice(String serviceType) {
    switch (serviceType) {
      case 'Wheelchair Accessible Vehicle':
        return double.tryParse(wheelchairAccessPriceController.text.trim()) ??
            0;
      case 'Visual/Hearing Impaired Support':
        return double.tryParse(
                visualHearingSupportPriceController.text.trim()) ??
            0;
      case 'Language Translation':
        return double.tryParse(
                languageTranslationPriceController.text.trim()) ??
            0;
      case 'Care/Attendant Assistance':
        return double.tryParse(careAttendantPriceController.text.trim()) ?? 0;
      case 'Assistance with Boarding':
        return double.tryParse(boardingAssistancePriceController.text.trim()) ??
            0;
      case 'Priority Service for Elderly':
        return double.tryParse(priorityServicePriceController.text.trim()) ?? 0;
      default:
        return 0;
    }
  }

  void _showSetPriceDialog(DateTime date) {
    final TextEditingController priceController = TextEditingController();
    priceController.text =
        (calendarController.getPriceForDate(date)?.toString() ??
            calendarController.defaultPrice.toString());

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
                calendarController.setSpecialPrice(date, price);
                Navigator.pop(context);
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
      final double price = calendarController.getPriceForDate(day);
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
                  '£${price.toStringAsFixed(2)}/hr',
                  style: TextStyle(
                    fontSize: 7,
                    color: isClickable ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCitySelection(String title, RxList<String> selectedCities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title *',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
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
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () => selectedCities.clear(),
                child: const Text('DESELECT ALL'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Obx(() => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: Cities.ukCities.map((city) {
                  return FilterChip(
                    label: Text(city),
                    selected: selectedCities.contains(city),
                    onSelected: (bool value) {
                      if (value && !selectedCities.contains(city)) {
                        selectedCities.add(city);
                      } else if (!value) {
                        selectedCities.remove(city);
                      }
                    },
                  );
                }).toList(),
              ),
            )),
        const SizedBox(height: 10),
        Obx(() => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: const BoxConstraints(minHeight: 50),
              child: selectedCities.isEmpty
                  ? const Text('No cities selected',
                      style: TextStyle(color: Colors.grey, fontSize: 16))
                  : Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: selectedCities
                          .map((city) => Chip(
                                label: Text(city,
                                    style: const TextStyle(fontSize: 14)),
                                deleteIcon: const Icon(Icons.close, size: 18),
                                onDeleted: () => selectedCities.remove(city),
                                backgroundColor: Colors.grey[200],
                              ))
                          .toList(),
                    ),
            )),
      ],
    );
  }

  Widget _buildDatePicker(String label, Rx<DateTime> date, bool isFromDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label Date and Time',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: date.value,
              firstDate: DateTime.now(),
              lastDate: DateTime(2099, 12, 31),
            );
            if (pickedDate != null) {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(date.value),
              );
              if (pickedTime != null) {
                final newDateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );
                if (newDateTime.isBefore(DateTime.now())) {
                  Get.snackbar(
                    "Invalid Date",
                    "Please select a date and time in the future.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                  return;
                }
                date.value = newDateTime;
                if (isFromDate) {
                  calendarController.fromDate.value = date.value;
                  calendarController.updateDateRange(
                    calendarController.fromDate.value,
                    calendarController.toDate.value,
                  );
                } else {
                  calendarController.toDate.value = date.value;
                  calendarController.updateDateRange(
                    calendarController.fromDate.value,
                    calendarController.toDate.value,
                  );
                }
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
                Text(DateFormat('dd/MM/yyyy HH:mm').format(date.value),
                    style: const TextStyle(fontSize: 16)),
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section 1: Business Information
                  const Text('SECTION 1: LISTING DETAILS',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text('LISTING TITLE *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 50,
                    textcont: serviceNameController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Enter Listing Title",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Listing Title is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  const Text('Base Location Postcode *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 10,
                    textcont: basePostcodeController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Enter postcode",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Base Location is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  const Text('Location Radius *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 10,
                    textcont: locationRadiusController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Enter location radius in miles",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Location radius is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Section 2: Fleet Information
                  const Text('SECTION 2: VEHICLE DETAILS',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text('Make & Model *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 50,
                    textcont: makeModelController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Enter make and model",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Make & Model is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),
                  const Text('Number of Seats *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 2,
                    textcont: numberOfSeatsController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Enter number of seats",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Number of Seats is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),
                  const Text('Luggage Capacity *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 2,
                    textcont: luggageCapacityController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Luggage capacity in liters",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Luggage Capacity is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),
                  _buildDatePicker(
                      'First Registration', firstRegistrationDate, true),

                  const SizedBox(height: 20),

                  // Section 3: Pricing Details
                  const Text('SECTION 3: Pricing Structure',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 10),
                  const Text('Day Rate (up to 10 hour hire) (£)*',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 10,
                    textcont: dayRateController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Enter day rate",
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}$'))
                    ],
                  ),

                  const SizedBox(height: 10),
                  const Text('Mileage Limit *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 10,
                    textcont: mileageLimitController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Minimum 200 miles",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mileage Limit is required';
                      }
                      final limit = double.tryParse(value) ?? 0;
                      if (limit < 200) {
                        return 'Minimum 200 miles required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),
                  const Text('Extra Mileage Charge (£/mile) *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 10,
                    textcont: extraMileageChargeController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Enter extra mileage charge",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Extra Mileage Charge is required';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}$'))
                    ],
                  ),

                  const SizedBox(height: 10),
                  const Text('Hourly Rate (£) *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 10,
                    textcont: hourlyRateController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "enter hourly rate",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Hourly Rate is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),
                  const Text('Half Day (up to 5 hour hire) (£) *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 10,
                    textcont: halfDayRateController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "enter half day rate",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Half Day Rate is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Section 4: Coverage & Availability
                  const Text('SECTION 4: Coverage & Availability',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  _buildCitySelection('Areas Covered', areasCovered),

                  const SizedBox(height: 20),
                  const Text('Service Status *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  CustomDropdown(
                    hintText: "Select Service Status",
                    items: ['open', 'close'],
                    selectedValue: serviceStatus,
                    onChanged: (value) {
                      setState(() {
                        serviceStatus = value;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  // Section 5: Service Availability Period
                  const Text('Service Availability Period',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  const Text(
                      'Select the Period during which your service will be available',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Color.fromARGB(255, 109, 104, 104))),
                  const SizedBox(height: 20),

                  Obx(() => _buildDatePicker(
                      "From", calendarController.fromDate, true)),
                  Obx(() =>
                      _buildDatePicker("To", calendarController.toDate, false)),

                  const SizedBox(height: 10),
                  Obx(() {
                    DateTime focusedDay = calendarController.fromDate.value;
                    if (focusedDay.isBefore(DateTime.now())) {
                      focusedDay = DateTime.now();
                    }
                    return TableCalendar(
                      onDaySelected: (selectedDay, focusedDay) {
                        if (calendarController.visibleDates
                            .any((d) => isSameDay(d, selectedDay))) {
                          _showSetPriceDialog(selectedDay);
                        }
                      },
                      focusedDay: focusedDay,
                      firstDay: DateTime.now(),
                      lastDay: DateTime.utc(2099, 12, 31),
                      calendarFormat: CalendarFormat.month,
                      availableGestures: AvailableGestures.none,
                      headerStyle:
                          const HeaderStyle(formatButtonVisible: false),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          if (calendarController.visibleDates
                              .any((d) => isSameDay(d, day))) {
                            return _buildCalendarCell(day, true);
                          }
                          return _buildCalendarCell(day, false);
                        },
                      ),
                    );
                  }),

                  const SizedBox(height: 20),
                  const Text('Special Prices Summary',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: calendarController.specialPrices.length == 0
                        ? const Center(
                            child: Text('No special prices set yet',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)))
                        : Obx(() => ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  calendarController.specialPrices.length,
                              itemBuilder: (context, index) {
                                final entry =
                                    calendarController.specialPrices[index];
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
                                          style: const TextStyle(fontSize: 16)),
                                      Row(
                                        children: [
                                          Text(
                                              '£${price.toStringAsFixed(2)}/hr',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: price > 0
                                                      ? Colors.black
                                                      : Colors.red)),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () => calendarController
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

                  const SizedBox(height: 20),
                  const Text('Cancellation Policy *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  CustomDropdown(
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
                  const SizedBox(height: 20),

                  // Section 5: Service Details & Offerings
                  const Text('SECTION 5: Service Details & Offerings',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Driver & Service Standards
                            Row(
                              children: [
                                const Text('Driver & Service Standards',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const Text(' *',
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ...driverDetails.keys
                                .map((detail) => CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(detail),
                                      value: driverDetails[detail],
                                      onChanged: (value) {
                                        setState(() {
                                          driverDetails[detail] =
                                              value ?? false;
                                        });
                                      },
                                    )),

                            const SizedBox(height: 20),

                            // Funeral Service Type
                            Row(
                              children: [
                                const Text('Funeral Service Type',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const Text(' *',
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomDropdown(
                              hintText: "Select a service type",
                              items: [
                                'Religious',
                                'Non-Religious',
                                'Both religious & non-religious'
                              ],
                              selectedValue: funeralServiceType,
                              onChanged: (value) {
                                setState(() {
                                  funeralServiceType = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 40),

                      // Right Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Additional Support Services (Optional)',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            ...additionalSupportServices.keys
                                .map((service) => CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(service),
                                      value: additionalSupportServices[service],
                                      onChanged: (value) {
                                        setState(() {
                                          additionalSupportServices[service] =
                                              value ?? false;
                                        });
                                      },
                                    )),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Accessibility & Special Services
                  Row(
                    children: [
                      const Text('Accessibility & Special Services',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const Text(' *', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 8,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: accessibilitySpecial.length,
                    itemBuilder: (context, index) {
                      String key = accessibilitySpecial.keys.elementAt(index);
                      return CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(key),
                        value: accessibilitySpecial[key],
                        onChanged: (value) {
                          setState(() {
                            accessibilitySpecial[key] = value ?? false;
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Section 6: Photo and Media
                  const Text('SECTION 6: Photos & Media',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text("Fleet Images * (Upload minimum 5 images)",
                      style: TextStyle(color: Colors.black87, fontSize: 16)),
                  const SizedBox(height: 10),
                  Center(
                    child: Obx(() => Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children:
                              List.generate(fleetPhotosPaths.length, (index) {
                            return Stack(
                              children: [
                                Image.file(
                                  File(fleetPhotosPaths[index]),
                                  fit: BoxFit.cover,
                                  height: 60,
                                  width: 60,
                                ),
                                Positioned(
                                  top: 2,
                                  right: 2,
                                  child: GestureDetector(
                                    onTap: () =>
                                        fleetPhotosPaths.removeAt(index),
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
                                onTap: () async {
                                  await imageController.pickImages(true);
                                  if (imageController
                                      .selectedImages.isNotEmpty) {
                                    fleetPhotosPaths
                                        .addAll(imageController.selectedImages);
                                    imageController.selectedImages.clear();
                                  }
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text('Choose from Gallery'),
                                onTap: () async {
                                  await imageController.pickImages(false);
                                  if (imageController
                                      .selectedImages.isNotEmpty) {
                                    fleetPhotosPaths
                                        .addAll(imageController.selectedImages);
                                    imageController.selectedImages.clear();
                                  }
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

                  // Section 7: Business Highlights
                  const Text('SECTION 7: Business Highlights',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text('What makes your service unique or premium?',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 100,
                    textcont: uniqueServiceController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Enter unique service details",
                  ),
                  const SizedBox(height: 10),
                  const Text('Promotional Description (max 100 words)',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 100,
                    textcont: promotionalDescriptionController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Enter promotional description",
                  ),

                  const SizedBox(height: 20),

                  // Section 8: Coupons / Discounts
                  const Text("Coupons / Discounts",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: w * 0.45,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Get.dialog(AddCouponDialog()),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const Text("Add Coupon",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() => couponController.coupons.isEmpty
                      ? const SizedBox.shrink()
                      : CouponList()),

                  const SizedBox(height: 20),

                  // Section 9: Declaration & Agreement
                  const Text('Declaration & Agreement',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  CustomCheckbox(
                    title:
                        'I confirm that all information provided is accurate and current. *',
                    value: agreeTerms,
                    onChanged: (value) {
                      setState(() {
                        agreeTerms = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomCheckbox(
                    title:
                        'I have not shared any contact details (Email, Phone, Skype, Website, etc.). *',
                    value: noContactDetails,
                    onChanged: (value) {
                      setState(() {
                        noContactDetails = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomCheckbox(
                    title: 'I agree to the Cookies Policy. *',
                    value: agreeCookies,
                    onChanged: (value) {
                      setState(() {
                        agreeCookies = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomCheckbox(
                    title: 'I agree to the Privacy Policy. *',
                    value: agreePrivacy,
                    onChanged: (value) {
                      setState(() {
                        agreePrivacy = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomCheckbox(
                    title: 'I agree to the Cancellation Fee Policy. *',
                    value: agreeCancellation,
                    onChanged: (value) {
                      setState(() {
                        agreeCancellation = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                      'Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}'),

                  const SizedBox(height: 20),

                  // Submit Button
                  Container(
                    width: w,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
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
      ),
    );
  }
}
