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
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupanController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupon_list.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupondialog.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/upload_image.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/add_servie_home.dart';
import 'package:hire_any_thing/data/api_service/api_service_vender_side.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/city_fetch_controller.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/vender_side_getx_controller.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class PassengerTransportService extends StatefulWidget {
  final Rxn<String> Category;
  final Rxn<String> SubCategory;
  final String? CategoryId;
  final String? SubCategoryId;

  const PassengerTransportService(
      {super.key,
      required this.Category,
      required this.SubCategory,
      this.CategoryId,
      this.SubCategoryId});

  @override
  State<PassengerTransportService> createState() =>
      _PassengerTransportServiceState();
}

class _PassengerTransportServiceState extends State<PassengerTransportService> {
  final CityFetchController cityFetchController = Get.put(CityFetchController());
  final ImageController imageController = Get.put(ImageController());
  final CouponController couponController = Get.put(CouponController());
  final CalendarController calenderController = Get.put(CalendarController());
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController citiesAvailableController = TextEditingController();
  TextEditingController priceperMileController = TextEditingController();
  TextEditingController numberofSeatsController = TextEditingController();
  TextEditingController registrationNumberController = TextEditingController();
  TextEditingController makeandModelController = TextEditingController();
  TextEditingController minimumDistancemilesController = TextEditingController();
  TextEditingController maximumDistancemilesController = TextEditingController();
  TextEditingController weeklyPriceController = TextEditingController();
  TextEditingController weeklyDiscountController = TextEditingController();
  TextEditingController monthlyDiscountController = TextEditingController();
  TextEditingController extraTimeWaitingChargeController =
      TextEditingController();
  TextEditingController extraMilesChargesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TextEditingController couponCodeController = TextEditingController();
  TextEditingController discountValueController = TextEditingController();
  TextEditingController usageLimitController = TextEditingController();
  TextEditingController one_day_priceController = TextEditingController();

  RxList<String> selectedCities = <String>[].obs;
  bool isOnedayHire = false;
  bool isCouponForall = false;
  bool isTnc = false;
  bool iscontact = false;
  bool cookies = false;
  bool ispvc = false;
  File? _logoImage;
  File? _coverImage;

  final Map<String, String> cancellationPolicyMap = {
    'Flexible-Full refund if canceled 48+ hours in advance': "FLEXIBLE",
    'Moderate-Full refund if canceled 72+ hours in advance': "MODERATE",
    'Strict-Full refund if canceled 7+ days in advance': "STRICT",
  };

  String? discountType;
  String? cancellationPolicy;
  String? serviceStatus;
  String? wheelchairAccess;
  String? airConditioning;
  String? vendorId;

  final GlobalKey<FormState> _paggengerformKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadVendorId();
    print('Cate ${widget.CategoryId}');
    print(widget.SubCategoryId);

    // Set default price listener
    priceperMileController.addListener(() {
      calenderController.setDefaultPrice(
          double.tryParse(priceperMileController.text) ?? 0.0);
    });

    if (citiesAvailableController.text.isNotEmpty) {
      selectedCities.add(citiesAvailableController.text);
    }

    // Removed redundant updateDateRange call since it's handled in CalendarController's onInit
  }

  @override
  void dispose() {
    // Dispose TextEditingControllers
    serviceNameController.dispose();
    priceperMileController.dispose();
    numberofSeatsController.dispose();
    registrationNumberController.dispose();
    makeandModelController.dispose();
    minimumDistancemilesController.dispose();
    maximumDistancemilesController.dispose();
    weeklyPriceController.dispose();
    weeklyDiscountController.dispose();
    monthlyDiscountController.dispose();
    extraTimeWaitingChargeController.dispose();
    extraMilesChargesController.dispose();
    descriptionController.dispose();
    couponCodeController.dispose();
    discountValueController.dispose();
    usageLimitController.dispose();
    one_day_priceController.dispose();

    // Clear GetX controllers' data
    cityFetchController.clearSearch();
    cityFetchController.placeList.clear();
    selectedCities.clear();

    // Clear image controller data (deferred to avoid rebuild during dispose)
    Future.microtask(() {
      imageController.selectedImages.clear();
      imageController.uploadedUrls.clear();
       couponController.coupons.clear();

    // Clear calendar controller data
    calenderController.specialPrices.clear();
    calenderController.visibleDates.clear();
    calenderController.fromDate.value = DateTime.now();
    calenderController.toDate.value = DateTime.now();
    });

    // Clear coupon controller data
   

    // Remove listeners
    priceperMileController.removeListener(() {});

    super.dispose();
  }

  Future<void> _loadVendorId() async {
    vendorId = await SessionVendorSideManager().getVendorId();
    print(vendorId);
    setState(() {});
  }

  IconData currentIcon = Icons.add;

  String getFormattedTime(TimeOfDay time) {
    int hour = time.hour;
    int minute = time.minute;
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';

    String formattedHour = hour < 10 ? '0$hour' : '$hour';
    String formattedMinute = minute < 10 ? '0$minute' : '$minute';

    return '$formattedHour:$formattedMinute $period';
  }

  void _submitForm() async {
    if (_paggengerformKey.currentState!.validate()) {
      final data = {
        "service_name": serviceNameController.text.trim(),
        "city_name": selectedCities.toList(),
        "kilometer_price":
            double.tryParse(priceperMileController.text.trim()) ?? 0,
        "no_of_seats": int.tryParse(numberofSeatsController.text.trim()) ?? 0,
        "registration_no": registrationNumberController.text.trim(),
        "make_and_model": makeandModelController.text.trim(),
        "minimum_distance":
            double.tryParse(minimumDistancemilesController.text.trim()) ?? 0,
        "maximum_distance":
            double.tryParse(maximumDistancemilesController.text.trim()) ?? 0,
        "weekly_price": double.tryParse(weeklyPriceController.text.trim()) ?? 0,
        "weekly_discount":
            double.tryParse(weeklyDiscountController.text.trim()) ?? 0,
        "monthly_discount":
            double.tryParse(monthlyDiscountController.text.trim()) ?? 0,
        "extra_time_waiting_charge":
            double.tryParse(extraTimeWaitingChargeController.text.trim()) ?? 0,
        "extra_miles_charges":
            double.tryParse(extraMilesChargesController.text.trim()) ?? 0,
        "description": descriptionController.text.trim(),
        "is_one_day_hire": isOnedayHire,
        "service_status": serviceStatus ?? "open",
        "wheel_chair": wheelchairAccess ?? "",
        "airon_fitted": airConditioning ?? "",
        "cancellation_policy_type": cancellationPolicy ?? "FLEXIBLE",
        "vendorId": vendorId,
        "coupons": couponController.coupons.toList(),
        "one_day_price":
            double.tryParse(one_day_priceController.text.trim()) ?? 0,
        "hourlyRate": 0,
        "fullDayRate": 0,
        "monthly_rate": 0,
        "per_hour_price": 0,
        "allowedEvents": false,
        "byoAlcohol": false,
        "byoAlcoholFee": false,
        "byoCatering": false,
        "externalCateres": false,
        "refreshements": false,
        "alcoholLicence": false,
        "alcoholLicenceExtention": false,
        "alcoholLicenceUntil": "",
        "stepFree": false,
        "noiseRistriction": false,
        "ownDj": false,
        "ownMusic": false,
        "freeParkingSpaces": 0,
        "freeStreetParking": 0,
        "paidParkingSpaces": 0,
        "toilet": false,
        "toilet_facility": "",
        "venueName": "",
        "venueType": [],
        "subcategoryId": widget.SubCategoryId,
        "categoryId": widget.CategoryId,
        "booking_date_from": calenderController.bookingDateFrom,
        "booking_date_to": calenderController.bookingDateTo,
        "employmentStatus": "",
        "highestDegree": "",
        "fieldsOfExpertise": [],
        "languages_known": [],
        "yearsOfExperience": "",
        "automativeDefaultPrice": "",
        "automativeServicePrice": "",
        "automativeYearsOfExperience": "",
        "automotiveJobTitle": "",
        "automotivePreferredWorkLocation": [],
        "automotiveService_image": [],
        "automotiveServicesOffered": [],
        "automotiveSpecialization": "",
        "automotive_keySkills": "",
        "classroom": 0,
        "dining": 0,
        "cabaret": 0,
        "theatre": 0,
        "uShaped": 0,
        "boardroom": 0,
        "images": [],
        "service_image": imageController.uploadedUrls,
        "address": "",
        "country": "",
        "postcode": "",
        "special_price_days": calenderController.specialPrices
            .map((entry) => {
                  "date": DateFormat('yyyy-MM-dd')
                      .format(entry['date'] as DateTime),
                  "price": entry['price'] as num,
                })
            .toList(),
      };

      final isAdded = await apiServiceVenderSide.addServiceVendor(data);

      if (isAdded) {
        Get.to(HomePageAddService());
      } else {
        Get.snackbar("Error", "Add Service Failed. Please try again.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      }
    }
  }

  final VenderSidetGetXController venderSidetGetXController =
      Get.put(VenderSidetGetXController());

  bool loader = false;

  void _showSetPriceDialog(DateTime date) {
    final TextEditingController priceController = TextEditingController();
    priceController.text = (calenderController.getPriceForDate(date)?.toString() ??
        calenderController.defaultPrice.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            Text('Set Special Price for ${DateFormat('dd/MM/yyyy').format(date)}'),
        content: TextField(
          controller: priceController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Price per Mile (£)',
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

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colors.scaffold_background_color,
      appBar: AppBar(
        backgroundColor: colors.white,
        elevation: 0,
        centerTitle: true,
        title: Obx(() => Text(
              'Add ${widget.SubCategory.value ?? ''} Service',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, color: colors.black),
            )),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _paggengerformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Service Name *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 50,
                  textcont: serviceNameController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Service name",
                ),
                const SizedBox(height: 20),
                const Text(
                  'Cities Available *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) async {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
                    cityFetchController.onTextChanged(textEditingValue.text);
                    return cityFetchController.placeList
                        .map((place) => place['description'] as String);
                  },
                  onSelected: (String selection) {
                    if (!selectedCities.contains(selection)) {
                      selectedCities.add(selection);
                    }
                    citiesAvailableController.clear();
                    cityFetchController.clearSearch();
                  },
                  fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                    citiesAvailableController = controller;
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        hintText: "Type to search cities",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  },
                ),

                // Custom TextField-like container with chips
                const SizedBox(height: 10),
                Obx(() => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: const BoxConstraints(
                        minHeight: 50, // Minimum height similar to TextField
                      ),
                      child: selectedCities.isEmpty
                          ? const Text(
                              'No cities selected',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
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
                                        onDeleted: () {
                                          selectedCities.remove(city);
                                        },
                                        backgroundColor: Colors.grey[200],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ))
                                  .toList(),
                            ),
                    )),
                const SizedBox(height: 20),
                const Text(
                  'Price per Mile (£) *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 500,
                  textcont: priceperMileController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter price per mile",
                ),
                const SizedBox(height: 20),
                const Text(
                  'Number of Seats *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 500,
                  textcont: numberofSeatsController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter Number of Seats",
                ),
                const SizedBox(height: 20),
                const Text(
                  'Registration Number *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 50,
                  textcont: registrationNumberController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter registration number",
                ),
                const SizedBox(height: 20),
                const Text(
                  'Make and Model *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 100,
                  textcont: makeandModelController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter make and model",
                ),
                const SizedBox(height: 20),
                const Text(
                  'Wheelchair Access *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomDropdown(
                  hintText: "Select Option",
                  items: ['yes', 'no'],
                  selectedValue: wheelchairAccess,
                  onChanged: (value) {
                    setState(() {
                      wheelchairAccess = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Air Conditioning *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomDropdown(
                  hintText: "Select Option",
                  items: ['yes', 'no'],
                  selectedValue: airConditioning,
                  onChanged: (value) {
                    setState(() {
                      airConditioning = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Minimum Distance (miles) *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 500,
                  textcont: minimumDistancemilesController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter minimum distance",
                ),
                const SizedBox(height: 20),
                const Text(
                  'Maximum Distance (miles) *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 500,
                  textcont: maximumDistancemilesController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter maximum distance",
                ),
                const SizedBox(height: 20),
                const Text(
                  'Service Status *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomDropdown(
                  hintText: "Select Option",
                  items: ['Yes', 'No'],
                  selectedValue: serviceStatus,
                  onChanged: (value) {
                    setState(() {
                      serviceStatus = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Weekly Price',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 500,
                  textcont: weeklyPriceController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter Weekly Price (optional)",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,5}$')),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Weekly Discount (%)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 500,
                  textcont: weeklyDiscountController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter Weekly Discount Percentage",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,5}$')),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Monthly Discount (%)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 500,
                  textcont: monthlyDiscountController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter Monthly Discount Percentage",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,5}$')),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Extra Time Waiting Charge (£/hour)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 500,
                  textcont: extraTimeWaitingChargeController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter waiting charge per hour (optional)",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,5}$')),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Extra Miles Charges (£/mile)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 500,
                  textcont: extraMilesChargesController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter charge per extra mile (optional)",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,5}$')),
                  ],
                ),
                const SizedBox(height: 20),
                CustomCheckboxContainer(
                  title: "One Day Hire?",
                  description:
                      "This package includes service for up to 200 miles or 10 hours, whichever comes first",
                  value: isOnedayHire,
                  onChanged: (value) {
                    setState(() {
                      isOnedayHire = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                if (isOnedayHire)
                  Signup_textfilled(
                    length: 500,
                    textcont: one_day_priceController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Enter package Price (£)",
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
                const SizedBox(height: 40),
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
                            ))),
                const SizedBox(height: 20),
                const Text(
                  'Description *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 5000,
                  textcont: descriptionController,
                  textfilled_height: 10,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter service description",
                ),
                const SizedBox(height: 20),
                const Text(
                  'Cancellation Policy *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomDropdown(
                  hintText: "Select a Cancellation Policy",
                  items: cancellationPolicyMap.keys.toList(),
                  selectedValue: cancellationPolicyMap.entries
                      .firstWhere(
                        (entry) => entry.value == cancellationPolicy,
                        orElse: () => MapEntry("", ""),
                      )
                      .key,
                  onChanged: (value) {
                    setState(() {
                      cancellationPolicy = cancellationPolicyMap[value] ?? "";
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Service Images *",
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Obx(() => Wrap(
                          children: List.generate(
                              imageController.selectedImages.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
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
                              ),
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
                    strokeWidth: 1,
                    dashPattern: [5, 5],
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
                              "Click to upload or drag and drop PNG, JPG (MAX. 800x400px)",
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
                const SizedBox(height: 30),
                const Text(
                  "Coupons / Discounts",
                  style: TextStyle(color: Colors.black87, fontSize: 20),
                ),
                const SizedBox(height: 20),
                Container(
                  width: w * 0.5,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.dialog(AddCouponDialog());
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) => Colors.green,
                      ),
                    ),
                    child: loader
                        ? const CircularProgressIndicator(color: Colors.blue)
                        : const Text(
                            "Add Coupon",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => couponController.coupons.isNotEmpty
                    ? CouponList()
                    : const Center(child: Text("No coupons added yet."))),
                const SizedBox(height: 20),
                CustomCheckbox(
                  title: 'I agree to the Terms and Conditions',
                  value: isTnc,
                  onChanged: (value) {
                    setState(() {
                      isTnc = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomCheckbox(
                  title:
                      'I have not shared any contact details (Email, Phone, Skype, Website etc.)',
                  value: iscontact,
                  onChanged: (value) {
                    setState(() {
                      iscontact = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomCheckbox(
                  title: 'I agree to the Cookies Policy',
                  value: cookies,
                  onChanged: (value) {
                    setState(() {
                      cookies = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomCheckbox(
                  title: 'I agree to the Privacy Policy',
                  value: ispvc,
                  onChanged: (value) {
                    setState(() {
                      ispvc = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  width: w,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (serviceNameController.text.isEmpty) {
                        Get.snackbar(
                          "Missing Information",
                          "Service Name is required.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(Icons.warning, color: Colors.white),
                          margin: const EdgeInsets.all(10),
                        );
                        return;
                      }
                      if (selectedCities.isEmpty) {
                        Get.snackbar(
                          "Missing Information",
                          "Please select at least one city.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(Icons.warning, color: Colors.white),
                          margin: const EdgeInsets.all(10),
                        );
                        return;
                      }
                      if (priceperMileController.text.isEmpty) {
                        Get.snackbar(
                          "Missing Information",
                          "Price per mile is required.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(Icons.warning, color: Colors.white),
                          margin: const EdgeInsets.all(10),
                        );
                        return;
                      }
                      if (numberofSeatsController.text.isEmpty) {
                        Get.snackbar(
                          "Missing Information",
                          "Number of seats is required.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(Icons.warning, color: Colors.white),
                          margin: const EdgeInsets.all(10),
                        );
                        return;
                      }
                      if (registrationNumberController.text.isEmpty) {
                        Get.snackbar(
                          "Missing Information",
                          "Registration number is required.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(Icons.warning, color: Colors.white),
                          margin: const EdgeInsets.all(10),
                        );
                        return;
                      }
                      if (makeandModelController.text.isEmpty) {
                        Get.snackbar(
                          "Missing Information",
                          "Please enter the make and model.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(Icons.warning, color: Colors.white),
                          margin: const EdgeInsets.all(10),
                        );
                        return;
                      }
                      if (minimumDistancemilesController.text.isEmpty) {
                        Get.snackbar(
                          "Missing Information",
                          "Minimum distance in miles is required.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(Icons.warning, color: Colors.white),
                          margin: const EdgeInsets.all(10),
                        );
                        return;
                      }
                      if (maximumDistancemilesController.text.isEmpty) {
                        Get.snackbar(
                          "Missing Information",
                          "Maximum distance in miles is required.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(Icons.warning, color: Colors.white),
                          margin: const EdgeInsets.all(10),
                        );
                        return;
                      }
                      if (cancellationPolicy == null) {
                        Get.snackbar(
                          "Missing Information",
                          "Please select a cancellation policy.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(Icons.warning, color: Colors.white),
                          margin: const EdgeInsets.all(10),
                        );
                        return;
                      }
                      if (serviceStatus == null) {
                        Get.snackbar(
                          "Missing Information",
                          "Please select a service status.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(Icons.warning, color: Colors.white),
                          margin: const EdgeInsets.all(10),
                        );
                        return;
                      }
                      if (!isTnc) {
                        Get.snackbar(
                          "Agreement Required",
                          "Please agree to the Terms and Conditions.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(Icons.warning, color: Colors.white),
                          margin: const EdgeInsets.all(10),
                        );
                        return;
                      }
                      if (!iscontact) {
                        Get.snackbar(
                          "Privacy Confirmation",
                          "Please confirm that you have not shared any contact details.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(Icons.warning, color: Colors.white),
                          margin: const EdgeInsets.all(10),
                        );
                        return;
                      }
                      if (!cookies) {
                        Get.snackbar(
                          "Cookies Policy",
                          "Please agree to the Cookies Policy.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(Icons.warning, color: Colors.white),
                          margin: const EdgeInsets.all(10),
                        );
                        return;
                      }
                      if (!ispvc) {
                        Get.snackbar(
                          "Privacy Policy",
                          "Please agree to the Privacy Policy.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          icon: const Icon(Icons.warning, color: Colors.white),
                          margin: const EdgeInsets.all(10),
                        );
                        return;
                      }

                      _submitForm();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) => Colors.green,
                      ),
                    ),
                    child: loader
                        ? const CircularProgressIndicator(color: Colors.blue)
                        : const Text(
                            "Submit Service",
                            style: TextStyle(color: Colors.white),
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
}