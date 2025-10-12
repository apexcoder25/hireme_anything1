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
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/image_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/vendor_home_Page.dart';
import 'package:hire_any_thing/constants_file/uk_cities.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/city_fetch_controller.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/service_controller.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MinibusHireService extends StatefulWidget {
  final Rxn<String> Category;
  final Rxn<String> SubCategory;
  final String? CategoryId;
  final String? SubCategoryId;

  const MinibusHireService({
    super.key,
    required this.Category,
    required this.SubCategory,
    this.CategoryId,
    this.SubCategoryId,
  });

  @override
  State<MinibusHireService> createState() => _MinibusHireServiceState();
}

class _MinibusHireServiceState extends State<MinibusHireService> {
  final ImageController imageController = Get.put(ImageController());
  final CouponController couponController = Get.put(CouponController());
  final CalendarController calendarController = Get.put(CalendarController());
  final CityFetchController cityFetchController =
      Get.put(CityFetchController());

  // Essential Controllers
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController basePostcodeController = TextEditingController();
  TextEditingController locationRadiusController = TextEditingController();
  TextEditingController makeAndModelController = TextEditingController();
  TextEditingController seatsController = TextEditingController();
  TextEditingController luggageCapacityController = TextEditingController();
  TextEditingController hourlyRateController = TextEditingController();
  TextEditingController halfDayRateController = TextEditingController();
  TextEditingController fullDayRateController = TextEditingController();
  TextEditingController mileageLimitController = TextEditingController();
  TextEditingController extraMileageChargeController = TextEditingController();

  // State Variables
  RxList<String> areasCovered = <String>[].obs;
  RxList<String> minibusPhotosPaths = <String>[].obs;
  Rx<DateTime> firstRegistrationDate = DateTime.now().obs;
  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;

  // Simple boolean variables for radio buttons
  bool wheelchairAccessible = false;
  bool airConditioning = false;
  bool luggageSpace = false;

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
      final now = DateTime.now();
      if (fromDate.value.isBefore(now)) fromDate.value = now;
      if (toDate.value.isBefore(now)) toDate.value = now;
      calendarController.fromDate.value = fromDate.value;
      calendarController.toDate.value = toDate.value;
    });

    hourlyRateController.addListener(() {
      calendarController
          .setDefaultPrice(double.tryParse(hourlyRateController.text) ?? 0.0);
    });
  }

  @override
  void dispose() {
    serviceNameController.dispose();
    basePostcodeController.dispose();
    locationRadiusController.dispose();
    makeAndModelController.dispose();
    seatsController.dispose();
    luggageCapacityController.dispose();
    hourlyRateController.dispose();
    halfDayRateController.dispose();
    fullDayRateController.dispose();
    mileageLimitController.dispose();
    extraMileageChargeController.dispose();
    hourlyRateController.removeListener(() {});
    super.dispose();
  }

  Future<void> _loadVendorId() async {
    vendorId = await SessionVendorSideManager().getVendorId();
    setState(() {});
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      _showError("Please fill all required fields correctly.");
      return;
    }

    if (areasCovered.isEmpty) {
      _showError("At least one area covered is required.");
      return;
    }

    if (minibusPhotosPaths.length < 3) {
      _showError("At least 3 minibus photos are required.");
      return;
    }

    if (!agreeTerms ||
        !noContactDetails ||
        !agreeCookies ||
        !agreePrivacy ||
        !agreeCancellation) {
      _showError("Please agree to all declarations.");
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // FIXED: Clean data structure using UI controllers
    final data = {
      "vendorId": vendorId,
      "categoryId": widget.CategoryId,
      "subcategoryId": widget.SubCategoryId,
      "listingTitle": serviceNameController.text.trim(),
      "basePostcode": basePostcodeController.text.trim(),
      "locationRadius": int.tryParse(locationRadiusController.text.trim()) ?? 5,

      // FIXED: Fleet info object as required by API
      "fleetInfo": {
        "makeAndModel": makeAndModelController.text.trim(),
        "seats": int.tryParse(seatsController.text.trim()) ?? 1,
        "luggageCapacity":
            int.tryParse(luggageCapacityController.text.trim()) ?? 1,
        "firstRegistered":
            DateFormat("yyyy-MM-dd").format(firstRegistrationDate.value),
        "wheelchairAccessible": wheelchairAccessible,
        "airConditioning": airConditioning,
        "luggageSpace": luggageSpace,
      },

      // FIXED: MiniBusRates object as required by API
      "miniBusRates": {
        "hourlyRate": double.tryParse(hourlyRateController.text.trim()) ?? 0.0,
        "halfDayRate":
            double.tryParse(halfDayRateController.text.trim()) ?? 0.0,
        "fullDayRate":
            double.tryParse(fullDayRateController.text.trim()) ?? 0.0,
        "additionalMileageFee":
            double.tryParse(extraMileageChargeController.text.trim()) ?? 0.0,
        "mileageLimit": int.tryParse(mileageLimitController.text.trim()) ?? 200,
      },

      "coverage": {
        "areasCovered": areasCovered.toList(),
        "serviceStatus": serviceStatus ?? "open",
        "fromDate":
            DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(fromDate.value),
        "toDate":
            DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(toDate.value),
      },

      "special_price_days": calendarController.specialPrices
          .map((entry) => {
                "date": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                    .format(entry['date']),
                "price": entry['price']
              })
          .toList(),

      "serviceImages": minibusPhotosPaths.toList(),
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
      final isAdded = await api.addServiceVendor(data, 'minibus');
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

  Widget _buildDatePicker(
      BuildContext context, String label, Rx<DateTime> date, bool isFromDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label Date and Time *',
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

  Widget _buildDatePickerr(String label, Rx<DateTime> date, bool isFromDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label Date',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: date.value,
              firstDate: DateTime(1990),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              date.value = pickedDate;
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
                Text(DateFormat('dd/MM/yyyy').format(date.value),
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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SECTION 1: LISTING DETAILS
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
                ),

                const SizedBox(height: 20),

                // SECTION 2: VEHICLE DETAILS
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
                  textcont: makeAndModelController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter make and model",
                ),

                const SizedBox(height: 10),
                const Text('Number of Seats *',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                ),

                const SizedBox(height: 10),
                _buildDatePickerr(
                    'First Registration', firstRegistrationDate, true),

                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Wheelchair Accessible',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(' *', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<bool>(
                            title: Text('Yes'),
                            value: true,
                            groupValue: wheelchairAccessible,
                            onChanged: (val) {
                              setState(() {
                                wheelchairAccessible = val ?? false;
                              });
                            },
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            title: Text('No'),
                            value: false,
                            groupValue: wheelchairAccessible,
                            onChanged: (val) {
                              setState(() {
                                wheelchairAccessible = val ?? false;
                              });
                            },
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Air Conditioning',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(' *', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<bool>(
                            title: Text('Yes'),
                            value: true,
                            groupValue: airConditioning,
                            onChanged: (val) {
                              setState(() {
                                airConditioning = val ?? false;
                              });
                            },
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            title: Text('No'),
                            value: false,
                            groupValue: airConditioning,
                            onChanged: (val) {
                              setState(() {
                                airConditioning = val ?? false;
                              });
                            },
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Luggage Space',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(' *', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<bool>(
                            title: Text('Yes'),
                            value: true,
                            groupValue: luggageSpace,
                            onChanged: (val) {
                              setState(() {
                                luggageSpace = val ?? false;
                              });
                            },
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            title: Text('No'),
                            value: false,
                            groupValue: luggageSpace,
                            onChanged: (val) {
                              setState(() {
                                luggageSpace = val ?? false;
                              });
                            },
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // SECTION 4: PRICING
                const Text('Rates',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  hinttext: "Enter hourly rate",
                ),

                const SizedBox(height: 10),
                const Text('Half Day Rate (£) *',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 10,
                  textcont: halfDayRateController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter half day rate",
                ),

                const SizedBox(height: 10),
                const Text('Full Day Rate (£) *',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 10,
                  textcont: fullDayRateController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter full day rate",
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
                ),

                const SizedBox(height: 20),

                // SECTION 5: Coverage & Availability
                const Text('Coverage & Availability',
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

                // Service Availability Period
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
                    headerStyle: const HeaderStyle(formatButtonVisible: false),
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
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)))
                      : Obx(() => ListView.builder(
                            shrinkWrap: true,
                            itemCount: calendarController.specialPrices.length,
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
                                        Text('£${price.toStringAsFixed(2)}/hr',
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
                      .firstWhere((entry) => entry.value == cancellationPolicy,
                          orElse: () => const MapEntry("", ""))
                      .key,
                  onChanged: (value) {
                    setState(() {
                      cancellationPolicy = cancellationPolicyMap[value] ?? "";
                    });
                  },
                ),

                const SizedBox(height: 20),

                // SECTION 6: Photos & Media
                const Text('Photos & Media',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("Vehicle Images * (Upload minimum 3 images)",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
                const SizedBox(height: 10),
                Center(
                  child: Obx(() => Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children:
                            List.generate(minibusPhotosPaths.length, (index) {
                          return Stack(
                            children: [
                              Image.file(
                                File(minibusPhotosPaths[index]),
                                fit: BoxFit.cover,
                                height: 60,
                                width: 60,
                              ),
                              Positioned(
                                top: 2,
                                right: 2,
                                child: GestureDetector(
                                  onTap: () =>
                                      minibusPhotosPaths.removeAt(index),
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
                                if (imageController.selectedImages.isNotEmpty) {
                                  minibusPhotosPaths
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
                                if (imageController.selectedImages.isNotEmpty) {
                                  minibusPhotosPaths
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

                // Coupons / Discounts
                const Text("Coupons / Discounts",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
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
                Obx(() => couponController.coupons.isEmpty
                    ? const SizedBox.shrink()
                    : CouponList()),

                const SizedBox(height: 20),

                // Declaration & Agreement
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
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
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
