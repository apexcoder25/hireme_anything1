import 'dart:io';
import 'dart:math' as math;

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
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/image_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/vendor_home_Page.dart';
import 'package:hire_any_thing/constants_file/uk_cities.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/city_fetch_controller.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/service_controller.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class LimousineHireService extends StatefulWidget {
  final Rxn<String> Category;
  final Rxn<String> SubCategory;
  final String? CategoryId;
  final String? SubCategoryId;

  const LimousineHireService({
    super.key,
    required this.Category,
    required this.SubCategory,
    this.CategoryId,
    this.SubCategoryId,
  });

  @override
  State<LimousineHireService> createState() => _LimousineHireServiceState();
}

class _LimousineHireServiceState extends State<LimousineHireService> {
  final ImageController imageController = Get.put(ImageController());
  final CouponController couponController = Get.put(CouponController());
  final CalendarController calendarController = Get.put(CalendarController());
  final CityFetchController cityFetchController = Get.put(CityFetchController());

  // Controllers
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController basePostcodeController = TextEditingController();
  TextEditingController locationRadiusController = TextEditingController();
  TextEditingController makeAndModelController = TextEditingController();
  TextEditingController seatsController = TextEditingController();
  TextEditingController luggageCapacityController = TextEditingController();

  // Pricing Controllers
  TextEditingController dayRateController = TextEditingController();
  TextEditingController mileageLimitController = TextEditingController();
  TextEditingController extraMileageChargeController = TextEditingController();
  TextEditingController hourlyRateController = TextEditingController();
  TextEditingController halfDayRateController = TextEditingController();
  TextEditingController fullDayRateController = TextEditingController(); // ADDED: Required field

  // Events & Customisation Price Controllers
  TextEditingController redCarpetPriceController = TextEditingController();
  TextEditingController floralDecorPriceController = TextEditingController();
  TextEditingController photographyPriceController = TextEditingController();
  TextEditingController champagnePriceController = TextEditingController();
  TextEditingController themedInteriorsPriceController = TextEditingController();
  TextEditingController partyPackagesPriceController = TextEditingController();

  // Accessibility Price Controllers
  TextEditingController wheelchairAccessPriceController = TextEditingController();
  TextEditingController petFriendlyPriceController = TextEditingController();
  TextEditingController childCarSeatsPriceController = TextEditingController();
  TextEditingController luggageRackPriceController = TextEditingController();

  // State Variables
  RxList<String> areasCovered = <String>[].obs;
  RxList<String> limousinePhotosPaths = <String>[].obs;
  final Rx<DateTime> firstRegistrationDate = DateTime.now().obs;
  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;

  // Features Maps
  Map<String, bool> comfortLuxury = {
    'Leather Seating': false,
    'Mood Lighting': false,
    'Climate Control': false,
    'Mini-Bar/Fridge': false,
    'Privacy Divider': false,
    'Tinted Windows': false,
    'Wi-Fi': false,
    'Premium Sound System': false,
  };

  Map<String, bool> eventsCustomisation = {
    'Red Carpet Service': false,
    'Champagne Packages': false,
    'Floral Décor': false,
    'Themed Interiors': false,
    'Photography Packages': false,
    'Party Packages': false,
  };

  Map<String, bool> accessibilityServices = {
    'Wheelchair Access': false,
    'Child Car Seats': false,
    'Pet-Friendly Service': false,
    'Luggage Rack / Roof Box': false,
  };

  Map<String, bool> safetyCompliance = {
    'GPS Tracking': false,
    'CCTV Onboard': false,
    'Public Liability Insurance': false,
    'DBS-Checked Drivers': false,
    'First-Aid Trained Chauffeurs': false,
  };

  // Other Variables
  String? serviceStatus;
  String? cancellationPolicy;
  String? vendorId;
  bool _isSubmitting = false;

  // Declaration Flags
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
      if (fromDate.value.isBefore(DateTime.now())) fromDate.value = DateTime.now();
      if (toDate.value.isBefore(DateTime.now())) toDate.value = DateTime.now();
      calendarController.fromDate.value = fromDate.value;
      calendarController.toDate.value = toDate.value;
    });

    hourlyRateController.addListener(() {
      calendarController.setDefaultPrice(double.tryParse(hourlyRateController.text) ?? 0.0);
    });
  }

  @override
  void dispose() {
    // Dispose all controllers
    serviceNameController.dispose();
    basePostcodeController.dispose();
    locationRadiusController.dispose();
    makeAndModelController.dispose();
    seatsController.dispose();
    luggageCapacityController.dispose();
    dayRateController.dispose();
    mileageLimitController.dispose();
    extraMileageChargeController.dispose();
    hourlyRateController.dispose();
    halfDayRateController.dispose();
    fullDayRateController.dispose(); // ADDED: Dispose fullDayRate controller
    redCarpetPriceController.dispose();
    floralDecorPriceController.dispose();
    photographyPriceController.dispose();
    champagnePriceController.dispose();
    themedInteriorsPriceController.dispose();
    partyPackagesPriceController.dispose();
    wheelchairAccessPriceController.dispose();
    petFriendlyPriceController.dispose();
    childCarSeatsPriceController.dispose();
    luggageRackPriceController.dispose();
    hourlyRateController.removeListener(() {});
    super.dispose();
  }

  Future<void> _loadVendorId() async {
    vendorId = await SessionVendorSideManager().getVendorId();
    setState(() {});
  }

  void _submitForm() async {
    setState(() {
      _isSubmitting = true;
    });

    if (!_formKey.currentState!.validate()) {
      _showError("Please fill all required fields correctly.");
      return;
    }

    if (areasCovered.isEmpty) {
      _showError("At least one area covered is required.");
      return;
    }

    if (!agreeTerms || !noContactDetails || !agreeCookies || !agreePrivacy || !agreeCancellation) {
      _showError("Please agree to all declarations.");
      return;
    }

    // FIXED: Ensure all required fields are included with proper data structure
    final data = {
      "vendorId": vendorId,
      "categoryId": widget.CategoryId,
      "subcategoryId": widget.SubCategoryId,
      "listingTitle": serviceNameController.text.trim(),
      
      // FIXED: Move required fields to top level as expected by API
      "makeAndModel": makeAndModelController.text.trim(),
      "basePostcode": basePostcodeController.text.trim(),
      "locationRadius": int.tryParse(locationRadiusController.text.trim()) ?? 5,
      "luggageCapacity": int.tryParse(luggageCapacityController.text.trim()) ?? 5,
      "seats": int.tryParse(seatsController.text.trim()) ?? 1,
      "halfDayRate": double.tryParse(halfDayRateController.text.trim()) ?? 0.0,
      "hourlyRate": double.tryParse(hourlyRateController.text.trim()) ?? 0.0,
      "fullDayRate": double.tryParse(fullDayRateController.text.trim()) ?? double.tryParse(dayRateController.text.trim()) ?? 0.0,

      "vehicleDetails": {
        "firstRegistered": DateFormat("yyyy-MM-dd").format(firstRegistrationDate.value),
      },

      "features": {
        "comfortLuxury": comfortLuxury.entries
            .where((entry) => entry.value == true)
            .map((entry) => entry.key)
            .toList(),
        "eventsCustomisation": eventsCustomisation.entries
            .where((entry) => entry.value == true)
            .map((entry) => entry.key)
            .toList(),
        "accessibilityServices": accessibilityServices.entries
            .where((entry) => entry.value == true)
            .map((entry) => entry.key)
            .toList(),
        "safetyCompliance": safetyCompliance.entries
            .where((entry) => entry.value == true)
            .map((entry) => entry.key)
            .toList(),
      },

      "featurePricing": {
        "eventsCustomisation": {
          if (eventsCustomisation['Red Carpet Service'] == true)
            'Red Carpet Service': double.tryParse(redCarpetPriceController.text.trim()) ?? 0.0,
          if (eventsCustomisation['Floral Décor'] == true)
            'Floral Décor': double.tryParse(floralDecorPriceController.text.trim()) ?? 0.0,
          if (eventsCustomisation['Photography Packages'] == true)
            'Photography Packages': double.tryParse(photographyPriceController.text.trim()) ?? 0.0,
          if (eventsCustomisation['Champagne Packages'] == true)
            'Champagne Packages': double.tryParse(champagnePriceController.text.trim()) ?? 0.0,
          if (eventsCustomisation['Themed Interiors'] == true)
            'Themed Interiors': double.tryParse(themedInteriorsPriceController.text.trim()) ?? 0.0,
          if (eventsCustomisation['Party Packages'] == true)
            'Party Packages': double.tryParse(partyPackagesPriceController.text.trim()) ?? 0.0,
        },
        "accessibilityServices": {
          if (accessibilityServices['Wheelchair Access'] == true)
            'Wheelchair Access': double.tryParse(wheelchairAccessPriceController.text.trim()) ?? 0.0,
          if (accessibilityServices['Pet-Friendly Service'] == true)
            'Pet-Friendly Service': double.tryParse(petFriendlyPriceController.text.trim()) ?? 0.0,
          if (accessibilityServices['Child Car Seats'] == true)
            'Child Car Seats': double.tryParse(childCarSeatsPriceController.text.trim()) ?? 0.0,
          if (accessibilityServices['Luggage Rack / Roof Box'] == true)
            'Luggage Rack / Roof Box': double.tryParse(luggageRackPriceController.text.trim()) ?? 0.0,
        },
      },

      "pricing": {
        "dayRate": double.tryParse(dayRateController.text.trim()) ?? 0.0,
        "mileageLimit": double.tryParse(mileageLimitController.text.trim()) ?? 200,
        "extraMileageCharge": double.tryParse(extraMileageChargeController.text.trim()) ?? 0.0,
      },

      "coverage": {
        "areasCovered": areasCovered.toList(),
        "serviceStatus": serviceStatus ?? "open",
        "fromDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(fromDate.value),
        "toDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(toDate.value),
      },

      "special_price_days": calendarController.specialPrices
          .map((entry) => {
                "date": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(entry['date']),
                "price": entry['price']
              })
          .toList(),

      "serviceImages": limousinePhotosPaths.toList(),
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

      "declaration": {
        "agreeTerms": agreeTerms,
        "noContactDetails": noContactDetails,
        "agreeCookies": agreeCookies,
        "agreePrivacy": agreePrivacy,
        "agreeCancellation": agreeCancellation,
      },
    };

    final api = AddVendorServiceApi();
    try {
      final isAdded = await api.addServiceVendor(data, 'limousine');
      if (isAdded) {
        setState(() {
          _isSubmitting = false;
        });
        Get.to(() => HomePageAddService());
      } else {
        _showError('Add Service Failed. Please try again.');
      }
    } catch (e) {
      print("API Error: $e");
      _showError('Server error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
      final ServiceController controller = Get.find<ServiceController>();
      controller.fetchServices();
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

  Widget _buildCitySelection(String title, RxList<String> selectedCities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title *', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                  ? const Text('No cities selected', style: TextStyle(color: Colors.grey, fontSize: 16))
                  : Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: selectedCities
                          .map((city) => Chip(
                                label: Text(city, style: const TextStyle(fontSize: 14)),
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

  Widget _buildDatePickerr(String label, Rx<DateTime> date, bool isFromDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label Date and Time', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                Text(DateFormat('dd/MM/yyyy HH:mm').format(date.value), style: const TextStyle(fontSize: 16)),
                const Icon(Icons.calendar_today, color: Colors.grey),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context, String label, Rx<DateTime> date, bool isFromDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label Date and Time *', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                Text(DateFormat('dd/MM/yyyy HH:mm').format(date.value), style: const TextStyle(fontSize: 16)),
                const Icon(Icons.calendar_today, color: Colors.grey),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _showSetPriceDialog(DateTime date) {
    final TextEditingController priceController = TextEditingController();
    priceController.text = (calendarController.getPriceForDate(date)?.toString() ??
        calendarController.defaultPrice.toString());

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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SECTION 1: LISTING DETAILS
                const Text('SECTION 1: LISTING DETAILS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('LISTING TITLE *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 50,
                  textcont: serviceNameController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Listing Title",
                ),

                const SizedBox(height: 20),
                const Text('Base Location Postcode *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 10,
                  textcont: basePostcodeController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter postcode",
                ),

                const SizedBox(height: 20),
                const Text('Location Radius *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 10,
                  textcont: locationRadiusController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter location radius in miles",
                ),

                const SizedBox(height: 20),

                // SECTION 2: VEHICLE DETAILS
                const Text('SECTION 2: VEHICLE DETAILS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Make & Model *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 50,
                  textcont: makeAndModelController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter make and model",
                ),

                const SizedBox(height: 10),
                const Text('Number of Seats *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 2,
                  textcont: seatsController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter number of seats",
                ),

                const SizedBox(height: 10),
                const Text('Luggage Capacity *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 2,
                  textcont: luggageCapacityController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Luggage capacity in liters",
                ),

                const SizedBox(height: 10),
                _buildDatePickerr('First Registration', firstRegistrationDate, true),

                const SizedBox(height: 20),

                // SECTION 3: Features, Benefits & Extras
                const Text('SECTION 3: Features, Benefits & Extras', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side - Comfort & Luxury and Accessibility & Special Services
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Comfort & Luxury
                          const Text('Comfort & Luxury', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),

                          ...comfortLuxury.keys.map((feature) {
                            return CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(feature),
                              value: comfortLuxury[feature] ?? false,
                              onChanged: (val) {
                                setState(() {
                                  comfortLuxury[feature] = val ?? false;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            );
                          }).toList(),

                          const SizedBox(height: 20),

                          // Accessibility & Special Services (With Pricing)
                          const Text('Accessibility & Special Services (With Pricing)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),

                          Row(
                            children: [
                              Checkbox(
                                value: accessibilityServices['Wheelchair Access'] ?? false,
                                onChanged: (val) {
                                  setState(() {
                                    accessibilityServices['Wheelchair Access'] = val ?? false;
                                    if (!val!) wheelchairAccessPriceController.clear();
                                  });
                                },
                              ),
                              Expanded(child: const Text('Wheelchair Access')),
                              if (accessibilityServices['Wheelchair Access'] == true)
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    controller: wheelchairAccessPriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: '£',
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          Row(
                            children: [
                              Checkbox(
                                value: accessibilityServices['Pet-Friendly Service'] ?? false,
                                onChanged: (val) {
                                  setState(() {
                                    accessibilityServices['Pet-Friendly Service'] = val ?? false;
                                    if (!val!) petFriendlyPriceController.clear();
                                  });
                                },
                              ),
                              Expanded(child: const Text('Pet-Friendly Service')),
                              if (accessibilityServices['Pet-Friendly Service'] == true)
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    controller: petFriendlyPriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: '£',
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          Row(
                            children: [
                              Checkbox(
                                value: accessibilityServices['Child Car Seats'] ?? false,
                                onChanged: (val) {
                                  setState(() {
                                    accessibilityServices['Child Car Seats'] = val ?? false;
                                    if (!val!) childCarSeatsPriceController.clear();
                                  });
                                },
                              ),
                              Expanded(child: const Text('Child Car Seats')),
                              if (accessibilityServices['Child Car Seats'] == true)
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    controller: childCarSeatsPriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: '£',
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          Row(
                            children: [
                              Checkbox(
                                value: accessibilityServices['Luggage Rack / Roof Box'] ?? false,
                                onChanged: (val) {
                                  setState(() {
                                    accessibilityServices['Luggage Rack / Roof Box'] = val ?? false;
                                    if (!val!) luggageRackPriceController.clear();
                                  });
                                },
                              ),
                              Expanded(child: const Text('Luggage Rack / Roof Box')),
                              if (accessibilityServices['Luggage Rack / Roof Box'] == true)
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    controller: luggageRackPriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: '£',
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 20),

                    // Right side - Events & Customisation and Safety & Compliance
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Events & Customisation (With Pricing)
                          const Text('Events & Customisation (With Pricing)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),

                          Row(
                            children: [
                              Checkbox(
                                value: eventsCustomisation['Red Carpet Service'] ?? false,
                                onChanged: (val) {
                                  setState(() {
                                    eventsCustomisation['Red Carpet Service'] = val ?? false;
                                    if (!val!) redCarpetPriceController.clear();
                                  });
                                },
                              ),
                              Expanded(child: const Text('Red Carpet Service')),
                              if (eventsCustomisation['Red Carpet Service'] == true)
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    controller: redCarpetPriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: '£',
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          Row(
                            children: [
                              Checkbox(
                                value: eventsCustomisation['Floral Décor'] ?? false,
                                onChanged: (val) {
                                  setState(() {
                                    eventsCustomisation['Floral Décor'] = val ?? false;
                                    if (!val!) floralDecorPriceController.clear();
                                  });
                                },
                              ),
                              Expanded(child: const Text('Floral Décor')),
                              if (eventsCustomisation['Floral Décor'] == true)
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    controller: floralDecorPriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: '£',
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          Row(
                            children: [
                              Checkbox(
                                value: eventsCustomisation['Photography Packages'] ?? false,
                                onChanged: (val) {
                                  setState(() {
                                    eventsCustomisation['Photography Packages'] = val ?? false;
                                    if (!val!) photographyPriceController.clear();
                                  });
                                },
                              ),
                              Expanded(child: const Text('Photography Packages')),
                              if (eventsCustomisation['Photography Packages'] == true)
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    controller: photographyPriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: '£',
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          Row(
                            children: [
                              Checkbox(
                                value: eventsCustomisation['Champagne Packages'] ?? false,
                                onChanged: (val) {
                                  setState(() {
                                    eventsCustomisation['Champagne Packages'] = val ?? false;
                                    if (!val!) champagnePriceController.clear();
                                  });
                                },
                              ),
                              Expanded(child: const Text('Champagne Packages')),
                              if (eventsCustomisation['Champagne Packages'] == true)
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    controller: champagnePriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: '£',
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          Row(
                            children: [
                              Checkbox(
                                value: eventsCustomisation['Themed Interiors'] ?? false,
                                onChanged: (val) {
                                  setState(() {
                                    eventsCustomisation['Themed Interiors'] = val ?? false;
                                    if (!val!) themedInteriorsPriceController.clear();
                                  });
                                },
                              ),
                              Expanded(child: const Text('Themed Interiors')),
                              if (eventsCustomisation['Themed Interiors'] == true)
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    controller: themedInteriorsPriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: '£',
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          Row(
                            children: [
                              Checkbox(
                                value: eventsCustomisation['Party Packages'] ?? false,
                                onChanged: (val) {
                                  setState(() {
                                    eventsCustomisation['Party Packages'] = val ?? false;
                                    if (!val!) partyPackagesPriceController.clear();
                                  });
                                },
                              ),
                              Expanded(child: const Text('Party Packages')),
                              if (eventsCustomisation['Party Packages'] == true)
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    controller: partyPackagesPriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: '£',
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Safety & Compliance
                          const Text('Safety & Compliance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),

                          ...safetyCompliance.keys.map((feature) {
                            return CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(feature),
                              value: safetyCompliance[feature] ?? false,
                              onChanged: (val) {
                                setState(() {
                                  safetyCompliance[feature] = val ?? false;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // SECTION 4: Coverage & Availability
                const Text('SECTION 4: Coverage & Availability', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _buildCitySelection('Areas Covered', areasCovered),

                const SizedBox(height: 20),
                const Text('Service Status *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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

                // SECTION 5: Pricing Structure
                const Text('SECTION 5: Pricing Structure', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Day Rate (up to 10 hour hire) (£)*', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 10,
                  textcont: dayRateController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter day rate",
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                ),

                const SizedBox(height: 10),
                const Text('Full Day Rate (£)*', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 10,
                  textcont: fullDayRateController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter full day rate",
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                ),

                const SizedBox(height: 10),
                const Text('Mileage Limit *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                const Text('Extra Mileage Charge (£/mile) *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 10,
                  textcont: extraMileageChargeController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter extra mileage charge",
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                ),

                const SizedBox(height: 10),
                const Text('Hourly Rate (£) *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 10,
                  textcont: hourlyRateController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "enter hourly rate",
                ),

                const SizedBox(height: 10),
                const Text('Half Day (up to 5 hour hire) (£) *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 10,
                  textcont: halfDayRateController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "enter half day rate",
                ),

                const SizedBox(height: 20),

                // SECTION 6: Photos & Media
                const Text('SECTION 6: Photos & Media', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("Upload Photos of Your Limousines (min 5 images)", style: TextStyle(color: Colors.black87, fontSize: 16)),
                const SizedBox(height: 10),
                Center(
                  child: Obx(() => Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: List.generate(limousinePhotosPaths.length, (index) {
                          return Stack(
                            children: [
                              Image.file(
                                File(limousinePhotosPaths[index]),
                                fit: BoxFit.cover,
                                height: 60,
                                width: 60,
                              ),
                              Positioned(
                                top: 2,
                                right: 2,
                                child: GestureDetector(
                                  onTap: () => limousinePhotosPaths.removeAt(index),
                                  child: const Icon(Icons.close, color: Colors.redAccent),
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
                                if (imageController.selectedImages.isNotEmpty) {
                                  limousinePhotosPaths.addAll(imageController.selectedImages);
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
                                if (imageController.selectedImages.isNotEmpty) {
                                  limousinePhotosPaths.addAll(imageController.selectedImages);
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

                // Service Availability Period
                const Text('Service Availability Period', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                const Text('Select the Period during which your service will be available', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104))),
                const SizedBox(height: 20),

                Obx(() => _buildDatePicker(context, "From", fromDate, true)),
                Obx(() => _buildDatePicker(context, "To", toDate, false)),

                const SizedBox(height: 10),
                Obx(() {
                  DateTime focusedDay = calendarController.fromDate.value;
                  if (focusedDay.isBefore(DateTime.now())) {
                    focusedDay = DateTime.now();
                  }
                  return TableCalendar(
                    onDaySelected: (selectedDay, focusedDay) {
                      if (calendarController.visibleDates.any((d) => isSameDay(d, selectedDay))) {
                        _showSetPriceDialog(selectedDay);
                      }
                    },
                    focusedDay: focusedDay,
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(2099, 12, 31),
                    calendarFormat: CalendarFormat.month,
                    availableGestures: AvailableGestures.none,
                    headerStyle: const HeaderStyle(formatButtonVisible: false),
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        if (calendarController.visibleDates.any((d) => isSameDay(d, day))) {
                          return _buildCalendarCell(day, true);
                        }
                        return _buildCalendarCell(day, false);
                      },
                    ),
                  );
                }),

                const SizedBox(height: 20),
                const Text('Special Prices Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: calendarController.specialPrices.length == 0
                      ? const Center(child: Text('No special prices set yet', style: TextStyle(fontSize: 16, color: Colors.black)))
                      : Obx(() => ListView.builder(
                            shrinkWrap: true,
                            itemCount: calendarController.specialPrices.length,
                            itemBuilder: (context, index) {
                              final entry = calendarController.specialPrices[index];
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
                                    Text(DateFormat('EEE, d MMM yyyy').format(date), style: const TextStyle(fontSize: 16)),
                                    Row(
                                      children: [
                                        Text('£${price.toStringAsFixed(2)}/hr', style: TextStyle(fontSize: 16, color: price > 0 ? Colors.black : Colors.red)),
                                        IconButton(
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                          onPressed: () => calendarController.deleteSpecialPrice(date),
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
                const Text('Cancellation Policy *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                CustomDropdown(
                  hintText: "Select a Cancellation Policy",
                  items: cancellationPolicyMap.keys.toList(),
                  selectedValue: cancellationPolicyMap.entries
                      .firstWhere((entry) => entry.value == cancellationPolicy, orElse: () => const MapEntry("", ""))
                      .key,
                  onChanged: (value) {
                    setState(() {
                      cancellationPolicy = cancellationPolicyMap[value] ?? "";
                    });
                  },
                ),

                const SizedBox(height: 20),

                // Coupons / Discounts
                const Text("Coupons / Discounts", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                SizedBox(
                  width: w * 0.45,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Get.dialog(AddCouponDialog()),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text("Add Coupon", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => couponController.coupons.isEmpty ? const SizedBox.shrink() : CouponList()),

                const SizedBox(height: 20),

                // Declaration & Agreement
                const Text('Declaration & Agreement', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                CustomCheckbox(
                  title: 'I confirm that all information provided is accurate and current. *',
                  value: agreeTerms,
                  onChanged: (value) {
                    setState(() {
                      agreeTerms = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomCheckbox(
                  title: 'I have not shared any contact details (Email, Phone, Skype, Website, etc.). *',
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
                Text('Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}'),

                const SizedBox(height: 20),

                // Submit Button
                Container(
                  width: w,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitForm,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
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
