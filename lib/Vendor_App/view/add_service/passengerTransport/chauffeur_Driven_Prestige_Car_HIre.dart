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

class ChauffeurHireService extends StatefulWidget {
  final Rxn<String> Category;
  final Rxn<String> SubCategory;
  final String? CategoryId;
  final String? SubCategoryId;

  const ChauffeurHireService({
    super.key,
    required this.Category,
    required this.SubCategory,
    this.CategoryId,
    this.SubCategoryId,
  });

  @override
  State<ChauffeurHireService> createState() => _ChauffeurHireServiceState();
}

class _ChauffeurHireServiceState extends State<ChauffeurHireService> {
  final ImageController imageController = Get.put(ImageController());
  final CouponController couponController = Get.put(CouponController());
  final CalendarController calendarController = Get.put(CalendarController());
  final CityFetchController cityFetchController =
      Get.put(CityFetchController());

  // Form Controllers
  final TextEditingController listingTitleController = TextEditingController();
  final TextEditingController baseLocationController = TextEditingController();
  final TextEditingController locationRadiusController =
      TextEditingController();
  final TextEditingController makeModelController = TextEditingController();
  final TextEditingController seatsController = TextEditingController();
  final TextEditingController luggageCapacityController =
      TextEditingController();
  final TextEditingController dayRateController = TextEditingController();
  final TextEditingController mileageLimitController =
      TextEditingController(text: '100');
  final TextEditingController extraMileageChargeController =
      TextEditingController();
  final TextEditingController hourlyRateController = TextEditingController();
  final TextEditingController halfDayRateController = TextEditingController();
  final TextEditingController businessDescriptionController =
      TextEditingController();

  // Price Controllers for Extras
  final TextEditingController weddingDecorPriceController =
      TextEditingController();
  final TextEditingController champagnePackagesPriceController =
      TextEditingController();
  final TextEditingController partyLightingPriceController =
      TextEditingController();
  final TextEditingController photographyPackagesPriceController =
      TextEditingController();
  final TextEditingController wheelchairAccessPriceController =
      TextEditingController();
  final TextEditingController petFriendlyPriceController =
      TextEditingController();
  final TextEditingController seniorFriendlyPriceController =
      TextEditingController();
  final TextEditingController childCarSeatsPriceController =
      TextEditingController();
  final TextEditingController disabledAccessRampPriceController =
      TextEditingController();
  final TextEditingController strollerBuggyStoragePriceController =
      TextEditingController();

  // Features Maps
  final Map<String, bool> occasions = {
    'weddings': false,
    'airportTransfers': false,
    'vipRedCarpet': false,
    'corporateTravel': false,
    'proms': false,
    'filmTvHire': false,
    'other': false,
  };

  final Map<String, bool> comfortLuxury = {
    'leatherInterior': false,
    'airConditioning': false,
    'inCarEntertainment': false,
    'redCarpetService': false,
    'onboardRestroom': false,
    'wifiAccess': false,
    'complimentaryDrinks': false,
    'bluetoothUSB': false,
    'chauffeurInUniform': false,
  };

  final Map<String, bool> eventsExtras = {
    'weddingDecor': false,
    'champagnePackages': false,
    'partyLighting': false,
    'photographyPackages': false,
  };

  final Map<String, bool> accessibilitySpecial = {
    'wheelchairAccess': false,
    'petFriendly': false,
    'seniorFriendly': false,
    'childCarSeats': false,
    'disabledAccessRamp': false,
    'strollerBuggyStorage': false,
  };

  final Map<String, bool> securityCompliance = {
    'vehicleTrackingGPS': false,
    'publicLiability': false,
    'insurance': false,
    'cctvFitted': false,
    'safetyCertifiedDrivers': false,
    'dbsChecked': false,
  };

  // Document paths and enablement flags
  final RxList<String> operatorLicencePaths = <String>[].obs;
  final RxList<String> vehicleInsurancePaths = <String>[].obs;
  final RxList<String> publicLiabilityPaths = <String>[].obs;
  final RxList<String> v5cLogbookPaths = <String>[].obs;
  final RxList<String> chauffeurLicencePaths = <String>[].obs;
  final RxList<String> additionalMediaPaths = <String>[].obs;

  bool operatorLicenceEnabled = false;
  bool vehicleInsuranceEnabled = false;
  bool publicLiabilityEnabled = false;
  bool v5cLogbookEnabled = false;
  bool chauffeurLicenceEnabled = false;

  // Other variables
  final RxList<String> areasCovered = <String>[].obs;
  final Rx<DateTime> firstRegistrationDate = DateTime.now().obs;
  String? serviceStatus;
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
    'Flexible-Full refund if canceled 48+ hours in advance': 'FLEXIBLE',
    'Moderate-Full refund if canceled 72+ hours in advance': 'MODERATE',
    'Strict-Full refund if canceled 7+ days in advance': 'STRICT',
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadVendorId();

    hourlyRateController.addListener(() {
      final price = double.tryParse(hourlyRateController.text) ?? 0.0;
      calendarController.setDefaultPrice(price);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final now = DateTime.now();
      if (calendarController.fromDate.value.isBefore(now)) {
        calendarController.fromDate.value = now;
      }
      if (calendarController.toDate.value.isBefore(now)) {
        calendarController.toDate.value = now.add(const Duration(days: 7));
      }
    });
  }

  @override
  void dispose() {
    // Dispose all controllers
    listingTitleController.dispose();
    baseLocationController.dispose();
    locationRadiusController.dispose();
    makeModelController.dispose();
    seatsController.dispose();
    luggageCapacityController.dispose();
    dayRateController.dispose();
    mileageLimitController.dispose();
    extraMileageChargeController.dispose();
    hourlyRateController.dispose();
    halfDayRateController.dispose();
    businessDescriptionController.dispose();

    // Dispose price controllers
    weddingDecorPriceController.dispose();
    champagnePackagesPriceController.dispose();
    partyLightingPriceController.dispose();
    photographyPackagesPriceController.dispose();
    wheelchairAccessPriceController.dispose();
    petFriendlyPriceController.dispose();
    seniorFriendlyPriceController.dispose();
    childCarSeatsPriceController.dispose();
    disabledAccessRampPriceController.dispose();
    strollerBuggyStoragePriceController.dispose();

    // Clear lists
    operatorLicencePaths.clear();
    vehicleInsurancePaths.clear();
    publicLiabilityPaths.clear();
    v5cLogbookPaths.clear();
    chauffeurLicencePaths.clear();
    additionalMediaPaths.clear();
    areasCovered.clear();

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

      List<String> documentsToUpload = [];

      if (operatorLicenceEnabled && operatorLicencePaths.isNotEmpty) {
        documentsToUpload.add(operatorLicencePaths.first);
      }
      if (vehicleInsuranceEnabled && vehicleInsurancePaths.isNotEmpty) {
        documentsToUpload.add(vehicleInsurancePaths.first);
      }
      if (publicLiabilityEnabled && publicLiabilityPaths.isNotEmpty) {
        documentsToUpload.add(publicLiabilityPaths.first);
      }
      if (v5cLogbookEnabled && v5cLogbookPaths.isNotEmpty) {
        documentsToUpload.add(v5cLogbookPaths.first);
      }
      if (chauffeurLicenceEnabled && chauffeurLicencePaths.isNotEmpty) {
        documentsToUpload.add(chauffeurLicencePaths.first);
      }
      documentsToUpload.addAll(additionalMediaPaths);

      for (var path in documentsToUpload) {
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

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      Get.snackbar(
          "Validation Error", "Please fill all required fields correctly.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
      return;
    }

    if (areasCovered.isEmpty) {
      Get.snackbar(
          "Missing Information", "At least one area covered is required.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
      return;
    }

    final dayRate = double.tryParse(dayRateController.text.trim()) ?? 0;
    final hourlyRate = double.tryParse(hourlyRateController.text.trim()) ?? 0;
    final halfDayRate = double.tryParse(halfDayRateController.text.trim()) ?? 0;

    if (dayRate == 0 && hourlyRate == 0 && halfDayRate == 0) {
      Get.snackbar("Missing Information",
          "At least one rate (day, hourly, or half-day) must be provided.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
      return;
    }

    if ((operatorLicenceEnabled && operatorLicencePaths.isEmpty) ||
        (vehicleInsuranceEnabled && vehicleInsurancePaths.isEmpty) ||
        (publicLiabilityEnabled && publicLiabilityPaths.isEmpty) ||
        (v5cLogbookEnabled && v5cLogbookPaths.isEmpty) ||
        (chauffeurLicenceEnabled && chauffeurLicencePaths.isEmpty) ||
        imageController.selectedImages.length < 3) {
      Get.snackbar("Missing Information",
          "All enabled document uploads and at least 3 vehicle images are required.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
      return;
    }

    if (!agreeTerms ||
        !noContactDetails ||
        !agreeCookies ||
        !agreePrivacy ||
        !agreeCancellation) {
      Get.snackbar("Missing Information", "Please agree to all declarations.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
      return;
    }

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

    final data = {
      "vendorId": vendorId,
      "categoryId": widget.CategoryId,
      "subcategoryId": widget.SubCategoryId,
      "service_name": listingTitleController.text.trim(),
      "listingTitle": listingTitleController.text.trim(),
      "baseLocationPostcode": baseLocationController.text.trim(),
      "locationRadius": locationRadiusController.text.trim(),
      "areasCovered": areasCovered.toList(),
      "service_status": serviceStatus?.toLowerCase() ?? "open",
      "fleetInfo": {
        "makeAndModel": makeModelController.text.trim(),
        "seats": seatsController.text.trim(),
        "luggageCapacity": luggageCapacityController.text.trim(),
        "firstRegistration": firstRegistrationDate.value.toIso8601String(),
      },
      "pricingDetails": {
        "dayRate": dayRate.toString(),
        "mileageLimit": mileageLimitController.text.trim(),
        "extraMileageCharge": extraMileageChargeController.text.trim(),
        "hourlyRate": hourlyRate.toString(),
        "halfDayRate": halfDayRate.toString(),
      },
      "occasions": occasions,
      "comfort": comfortLuxury,
      "events": eventsExtras,
      "accessibility": accessibilitySpecial,
      "security": securityCompliance,
      "booking_date_from": calendarController.fromDate.value != null
          ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
              .format(calendarController.fromDate.value)
          : "",
      "booking_date_to": calendarController.toDate.value != null
          ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
              .format(calendarController.toDate.value)
          : "",
      "special_price_days": calendarController.specialPrices
          .map((e) => {
                "date": e['date'] != null
                    ? DateFormat('yyyy-MM-dd').format(e['date'] as DateTime)
                    : "",
                "price": e['price'] as double? ?? 0
              })
          .toList(),
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
      "cancellation_policy_type": cancellationPolicy ?? "MODERATE",
      "businessDescription": businessDescriptionController.text.trim(),
      "agreeTerms": agreeTerms,
      "noContactDetails": noContactDetails,
      "agreeCookies": agreeCookies,
      "agreePrivacy": agreePrivacy,
      "agreeCancellation": agreeCancellation,
    };

    final api = AddVendorServiceApi();
    try {
      final isAdded = await api.addServiceVendor(data, 'chauffeur');
      if (isAdded) {
        Get.snackbar('Success', 'Service added successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        Get.to(() => HomePageAddService());
      } else {
        Get.snackbar('Error', 'Add Service Failed. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Server error: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
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
                return Stack(
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
                        onTap: () => documentPaths.removeAt(index),
                        child: const Icon(Icons.cancel,
                            color: Colors.redAccent, size: 20),
                      ),
                    ),
                  ],
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: DropdownButton<String>(
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
        ),
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
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Business Information
                const Text('LISTING TITLE',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('LISTING TITLE *',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 50,
                  textcont: listingTitleController,
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
                  textcont: baseLocationController,
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
                  keytype: TextInputType.text,
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
                const Text('Fleet Information (For This Vehicle Only)',
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
                  textcont: seatsController,
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
                const Text('Pricing Details (Day Hire Model)',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Day Rate (10 hrs / 200 miles) (£) *',
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
                  hinttext: "Current value: 100 miles",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mileage Limit is required';
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

                // Section 6: Features, Benefits & Extras
                const Text('Features, Benefits & Extras',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Comfort & Luxury',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: comfortLuxury.keys
                      .map((feature) => ChoiceChip(
                            label: Text(feature),
                            selected: comfortLuxury[feature]!,
                            onSelected: (selected) {
                              setState(() {
                                comfortLuxury[feature] = selected;
                              });
                            },
                          ))
                      .toList(),
                ),

                const SizedBox(height: 20),
                const Text('Events & Extras',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: eventsExtras.keys.map((extra) {
                    bool isSelected = eventsExtras[extra]!;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ChoiceChip(
                          label: Text(extra),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              eventsExtras[extra] = selected;
                            });
                          },
                        ),
                        if (isSelected) const SizedBox(width: 10),
                        if (isSelected && extra == 'weddingDecor')
                          SizedBox(
                            width: 80,
                            child: Signup_textfilled(
                              length: 10,
                              textcont: weddingDecorPriceController,
                              textfilled_height: 17,
                              textfilled_weight: 1,
                              keytype: TextInputType.number,
                              hinttext: "Price (£)",
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$'))
                              ],
                            ),
                          ),
                        if (isSelected && extra == 'champagnePackages')
                          SizedBox(
                            width: 80,
                            child: Signup_textfilled(
                              length: 10,
                              textcont: champagnePackagesPriceController,
                              textfilled_height: 17,
                              textfilled_weight: 1,
                              keytype: TextInputType.number,
                              hinttext: "Price (£)",
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$'))
                              ],
                            ),
                          ),
                        if (isSelected && extra == 'partyLighting')
                          SizedBox(
                            width: 80,
                            child: Signup_textfilled(
                              length: 10,
                              textcont: partyLightingPriceController,
                              textfilled_height: 17,
                              textfilled_weight: 1,
                              keytype: TextInputType.number,
                              hinttext: "Price (£)",
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$'))
                              ],
                            ),
                          ),
                        if (isSelected && extra == 'photographyPackages')
                          SizedBox(
                            width: 80,
                            child: Signup_textfilled(
                              length: 10,
                              textcont: photographyPackagesPriceController,
                              textfilled_height: 17,
                              textfilled_weight: 1,
                              keytype: TextInputType.number,
                              hinttext: "Price (£)",
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$'))
                              ],
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),
                const Text('Accessibility & Special Services',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: accessibilitySpecial.keys.map((service) {
                    bool isSelected = accessibilitySpecial[service]!;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ChoiceChip(
                          label: Text(service),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              accessibilitySpecial[service] = selected;
                            });
                          },
                        ),
                        if (isSelected) const SizedBox(width: 10),
                        if (isSelected && service == 'wheelchairAccess')
                          SizedBox(
                            width: 80,
                            child: Signup_textfilled(
                              length: 10,
                              textcont: wheelchairAccessPriceController,
                              textfilled_height: 17,
                              textfilled_weight: 1,
                              keytype: TextInputType.number,
                              hinttext: "Price (£)",
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$'))
                              ],
                            ),
                          ),
                        if (isSelected && service == 'petFriendly')
                          SizedBox(
                            width: 80,
                            child: Signup_textfilled(
                              length: 10,
                              textcont: petFriendlyPriceController,
                              textfilled_height: 17,
                              textfilled_weight: 1,
                              keytype: TextInputType.number,
                              hinttext: "Price (£)",
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$'))
                              ],
                            ),
                          ),
                        if (isSelected && service == 'seniorFriendly')
                          SizedBox(
                            width: 80,
                            child: Signup_textfilled(
                              length: 10,
                              textcont: seniorFriendlyPriceController,
                              textfilled_height: 17,
                              textfilled_weight: 1,
                              keytype: TextInputType.number,
                              hinttext: "Price (£)",
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$'))
                              ],
                            ),
                          ),
                        if (isSelected && service == 'childCarSeats')
                          SizedBox(
                            width: 80,
                            child: Signup_textfilled(
                              length: 10,
                              textcont: childCarSeatsPriceController,
                              textfilled_height: 17,
                              textfilled_weight: 1,
                              keytype: TextInputType.number,
                              hinttext: "Price (£)",
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$'))
                              ],
                            ),
                          ),
                        if (isSelected && service == 'disabledAccessRamp')
                          SizedBox(
                            width: 80,
                            child: Signup_textfilled(
                              length: 10,
                              textcont: disabledAccessRampPriceController,
                              textfilled_height: 17,
                              textfilled_weight: 1,
                              keytype: TextInputType.number,
                              hinttext: "Price (£)",
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$'))
                              ],
                            ),
                          ),
                        if (isSelected && service == 'strollerBuggyStorage')
                          SizedBox(
                            width: 80,
                            child: Signup_textfilled(
                              length: 10,
                              textcont: strollerBuggyStoragePriceController,
                              textfilled_height: 17,
                              textfilled_weight: 1,
                              keytype: TextInputType.number,
                              hinttext: "Price (£)",
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$'))
                              ],
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),
                const Text('Security & Compliance',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: securityCompliance.keys
                      .map((compliance) => ChoiceChip(
                            label: Text(compliance),
                            selected: securityCompliance[compliance]!,
                            onSelected: (selected) {
                              setState(() {
                                securityCompliance[compliance] = selected;
                              });
                            },
                          ))
                      .toList(),
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

                // Section 7: Photo and Media
                const Text('Photo and Media',
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
