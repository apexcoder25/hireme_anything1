import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/signup_textfilled.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/custom_checkbox.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/custom_dropdown.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/calenderController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/controller/add_vendor_services_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupanController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/upload_image.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/vendor_home_Page.dart';
import 'package:hire_any_thing/constants_file/uk_cities.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/city_fetch_controller.dart';
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
  final CityFetchController cityFetchController = Get.put(CityFetchController());

  // Section 1: Business & Contact Information
  TextEditingController serviceNameController = TextEditingController();

  // Section 2: Funeral Transport Services Offered
  Map<String, bool> vehicleTypes = {
    'Traditional Black Hearse': false,
    'Horse-Drawn Carriage (White/Black)': false,
    'Limousine (Mourner Cars)': false,
    'Vintage Hearse': false,
    'Motorcycle Hearse': false,
    'Specialty Vehicles': false,
  };
  TextEditingController otherVehicleController = TextEditingController();
  TextEditingController fleetSizeController = TextEditingController();

  // Section 3: Fleet Information
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController makeModelController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  // Section 4: Pricing Details
  TextEditingController dayRateController = TextEditingController();
  TextEditingController mileageLimitController = TextEditingController();
  TextEditingController extraMileageChargeController = TextEditingController();
  TextEditingController waitTimeFreeController = TextEditingController();
  TextEditingController floralDecorationFeeController = TextEditingController();
  TextEditingController standardFuneralServiceController = TextEditingController();
  TextEditingController vipFuneralServiceController = TextEditingController();
  TextEditingController hourlyRateController = TextEditingController();
  TextEditingController halfDayRateController = TextEditingController();
  bool fuelChargesIncluded = false;

  // Section 5: Coverage & Availability
  RxList<String> areasCovered = <String>[].obs;
  String? serviceStatus;
  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;

  // Section 6: Accessibility And Special Services
  Map<String, bool> accessibilitySpecial = {
    'Wheelchair Accessible Vehicle': false,
    'Visual/Hearing Impaired Support': false,
    'Language Translation': false,
    'Care/Attendant Assistance': false,
    'Assistance with Boarding': false,
    'Priority Service for Elderly': false,
  };
  TextEditingController wheelchairAccessPriceController = TextEditingController();
  TextEditingController visualHearingSupportPriceController = TextEditingController();
  TextEditingController languageTranslationPriceController = TextEditingController();
  TextEditingController careAttendantPriceController = TextEditingController();
  TextEditingController boardingAssistancePriceController = TextEditingController();
  TextEditingController priorityServicePriceController = TextEditingController();

  // Section 7: Driver & Service Details
  Map<String, bool> driverDetails = {
    'Drivers in uniform and trained?': false,
    'Drivers DBS checked and licensed?': false,
    'Coordinate with funeral directors?': false,
    'Support religious & non-religious funerals?': false,
  };
  String? funeralServiceType;
  Map<String, bool> additionalSupportServices = {
    'Funeral Escorts': false,
    'Floral Carriage': false,
    'Pallbearer Services': false,
    'Accessible Vehicles for Elderly/Mobility-Impaired Mourners': false,
    'Customisation': false,
  };

  // Section 8: Licensing & Insurance
  TextEditingController privateHireOperatorLicenceNumberController = TextEditingController();
  TextEditingController licensingAuthorityController = TextEditingController();
  TextEditingController publicLiabilityInsuranceProviderController = TextEditingController();
  TextEditingController policyNumberController = TextEditingController();
  TextEditingController policyExpiryDateController = TextEditingController();
  RxList<String> operatorLicencePaths = <String>[].obs;
  RxList<String> insuranceCertificatePaths = <String>[].obs;
  RxList<String> driverLicencesPaths = <String>[].obs;
  RxList<String> vehicleMotCertificatesPaths = <String>[].obs;
  RxList<String> fleetPhotosPaths = <String>[].obs;
  bool operatorLicenceEnabled = false;
  bool insuranceCertificateEnabled = false;
  bool driverLicencesEnabled = false;
  bool vehicleMotCertificatesEnabled = false;

  // Section 9: Business Highlights
  TextEditingController uniqueServiceController = TextEditingController();
  TextEditingController promotionalDescriptionController = TextEditingController();
  final Map<String, String> cancellationPolicyMap = {
    'Flexible-Full refund if canceled 48+ hours in advance': "FLEXIBLE",
    'Moderate-Full refund if canceled 72+ hours in advance': "MODERATE",
    'Strict-Full refund if canceled 7+ days in advance': "STRICT",
  };

  // Section 10: Declaration & Agreement
  bool agreeTerms = false;
  bool noContactDetails = false;
  bool agreeCookies = false;
  bool agreePrivacy = false;
  bool agreeCancellation = false;
  String? cancellationPolicy;

  String? vendorId;
  bool _isSubmitting = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadVendorId();
    if (fromDate.value.isBefore(DateTime.now())) fromDate.value = DateTime.now();
    if (toDate.value.isBefore(DateTime.now())) toDate.value = DateTime.now();
    calendarController.fromDate.value = fromDate.value;
    calendarController.toDate.value = toDate.value;
    hourlyRateController.addListener(() {
      calendarController.setDefaultPrice(double.tryParse(hourlyRateController.text) ?? 0.0);
    });
  }

  @override
  void dispose() {
    serviceNameController.dispose();
    otherVehicleController.dispose();
    fleetSizeController.dispose();
    vehicleTypeController.dispose();
    makeModelController.dispose();
    colorController.dispose();
    capacityController.dispose();
    yearController.dispose();
    notesController.dispose();
    dayRateController.dispose();
    mileageLimitController.dispose();
    extraMileageChargeController.dispose();
    waitTimeFreeController.dispose();
    floralDecorationFeeController.dispose();
    standardFuneralServiceController.dispose();
    vipFuneralServiceController.dispose();
    hourlyRateController.dispose();
    halfDayRateController.dispose();
    wheelchairAccessPriceController.dispose();
    visualHearingSupportPriceController.dispose();
    languageTranslationPriceController.dispose();
    careAttendantPriceController.dispose();
    boardingAssistancePriceController.dispose();
    priorityServicePriceController.dispose();
    privateHireOperatorLicenceNumberController.dispose();
    licensingAuthorityController.dispose();
    publicLiabilityInsuranceProviderController.dispose();
    policyNumberController.dispose();
    policyExpiryDateController.dispose();
    uniqueServiceController.dispose();
    promotionalDescriptionController.dispose();
    hourlyRateController.removeListener(() {});
    super.dispose();
  }

  Future<void> _loadVendorId() async {
    vendorId = await SessionVendorSideManager().getVendorId();
    setState(() {});
  }

  void _submitForm() async {
    _isSubmitting = true;
    if (!vehicleTypes.values.any((v) => v)) {
      Get.snackbar("Missing Information", "Please select at least one vehicle type.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
      _isSubmitting = false;
      return;
    }
    if (areasCovered.isEmpty) {
      Get.snackbar("Missing Information", "At least one area covered is required.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
      _isSubmitting = false;
      return;
    }
    // if (fleetPhotosPaths.length < 3) {
    //   Get.snackbar("Missing Information", "At least 3 fleet photos are required.",
    //       snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    //   _isSubmitting = false;
    //   return;
    // }
    if (!agreeTerms || !noContactDetails || !agreeCookies || !agreePrivacy || !agreeCancellation) {
      Get.snackbar("Missing Information", "Please agree to all declarations.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
      _isSubmitting = false;
      return;
    }

    final data = {
      "vendorId": vendorId,
      "categoryId": widget.CategoryId,
      "subcategoryId": widget.SubCategoryId,
      "service_name": serviceNameController.text.trim(),
      "vehicleTypes": vehicleTypes,
      "otherVehicle": vehicleTypes['Specialty Vehicles'] == true ? otherVehicleController.text.trim() : "",
      "fleetSize": fleetSizeController.text.trim(),
      "fleetInfo": {
        "vehicleType": vehicleTypeController.text.trim(),
        "makeModel": makeModelController.text.trim(),
        "color": colorController.text.trim(),
        "capacity": capacityController.text.trim(),
        "year": yearController.text.trim(),
        "notes": notesController.text.trim(),
      },
      "pricing": {
        "dayRate": double.tryParse(dayRateController.text.trim()) ?? 0,
        "mileageLimit": double.tryParse(mileageLimitController.text.trim()) ?? 0,
        "extraMileageCharge": double.tryParse(extraMileageChargeController.text.trim()) ?? 0,
        "waitTimeFree": double.tryParse(waitTimeFreeController.text.trim()) ?? 0,
        "floralDecorationFee": double.tryParse(floralDecorationFeeController.text.trim()) ?? 0,
        "standardFuneralService": double.tryParse(standardFuneralServiceController.text.trim()) ?? 0,
        "vipFuneralService": double.tryParse(vipFuneralServiceController.text.trim()) ?? 0,
        "hourlyRate": double.tryParse(hourlyRateController.text.trim()) ?? 0,
        "halfDayRate": double.tryParse(halfDayRateController.text.trim()) ?? 0,
        "fuelChargesIncluded": fuelChargesIncluded,
      },
      "coverageAvailability": {
        "areasCovered": areasCovered.toList(),
        "serviceStatus": serviceStatus,
        "fromDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(fromDate.value),
        "toDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(toDate.value),
      },
      "accessibilitySpecial": {
        "Wheelchair Accessible Vehicle": accessibilitySpecial['Wheelchair Accessible Vehicle']!,
        "Wheelchair Access Price": double.tryParse(wheelchairAccessPriceController.text.trim()) ?? 0,
        "Visual/Hearing Impaired Support": accessibilitySpecial['Visual/Hearing Impaired Support']!,
        "Visual/Hearing Support Price": double.tryParse(visualHearingSupportPriceController.text.trim()) ?? 0,
        "Language Translation": accessibilitySpecial['Language Translation']!,
        "Language Translation Price": double.tryParse(languageTranslationPriceController.text.trim()) ?? 0,
        "Care/Attendant Assistance": accessibilitySpecial['Care/Attendant Assistance']!,
        "Care/Attendant Price": double.tryParse(careAttendantPriceController.text.trim()) ?? 0,
        "Assistance with Boarding": accessibilitySpecial['Assistance with Boarding']!,
        "Boarding Assistance Price": double.tryParse(boardingAssistancePriceController.text.trim()) ?? 0,
        "Priority Service for Elderly": accessibilitySpecial['Priority Service for Elderly']!,
        "Priority Service Price": double.tryParse(priorityServicePriceController.text.trim()) ?? 0,
      },
      "driverServiceDetails": {
        "driverDetails": driverDetails,
        "funeralServiceType": funeralServiceType,
        "additionalSupportServices": additionalSupportServices,
      },
      "licensingInsurance": {
        "privateHireOperatorLicenceNumber": privateHireOperatorLicenceNumberController.text.trim(),
        "licensingAuthority": licensingAuthorityController.text.trim(),
        "publicLiabilityInsuranceProvider": publicLiabilityInsuranceProviderController.text.trim(),
        "policyNumber": policyNumberController.text.trim(),
        "policyExpiryDate": policyExpiryDateController.text.trim(),
        "operatorLicencePaths": operatorLicenceEnabled ? operatorLicencePaths : [],
        "insuranceCertificatePaths": insuranceCertificateEnabled ? insuranceCertificatePaths : [],
        "driverLicencesPaths": driverLicencesEnabled ? driverLicencesPaths : [],
        "vehicleMotCertificatesPaths": vehicleMotCertificatesEnabled ? vehicleMotCertificatesPaths : [],
        "fleetPhotosPaths": fleetPhotosPaths,
      },
      "businessHighlights": {
        "uniqueService": uniqueServiceController.text.trim(),
        "promotionalDescription": promotionalDescriptionController.text.trim(),
      },
      "declaration": {
        "agreeTerms": agreeTerms,
        "noContactDetails": noContactDetails,
        "agreeCookies": agreeCookies,
        "agreePrivacy": agreePrivacy,
        "agreeCancellation": agreeCancellation,
        "cancellationPolicy": cancellationPolicy ?? "FLEXIBLE",
      },
    };

    final api = AddVendorServiceApi();
    try {
      final isAdded = await api.addServiceVendor(data);
      if (isAdded) {
        _isSubmitting = false;
        Get.to(() => HomePageAddService());
      } else {
        Get.snackbar('Error', 'Add Service Failed. Please try again.',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      print("API Error: $e");
      Get.snackbar('Error', 'Server error: $e',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  Widget _buildDocumentUploadSection(String title, RxList<String> documentPaths, bool isRequired) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title${isRequired ? ' *' : ''}", style: const TextStyle(color: Colors.black, fontSize: 16)),
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
                          onTap: () => documentPaths.removeAt(index),
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
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
          '$label Date and Time',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
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
                      Text(
                        DateFormat('dd/MM/yyyy HH:mm').format(date.value),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(Icons.calendar_today, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _showSetPriceDialog(DateTime date) {
    final TextEditingController priceController = TextEditingController();
    priceController.text = (calendarController.getPriceForDate(date)?.toString() ?? calendarController.defaultPrice.toString());

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
                    color: isClickable ? (price > 0 ? Colors.red : Colors.red) : Colors.grey,
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Funeral Car Hire - Vendor Listing',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'hireanything.com - Compassionate, Professional Transport Services',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104)),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Join our platform to offer dignified and reliable funeral car hire services to families and funeral planners across the UK.',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104)),
                  ),
                  const SizedBox(height: 20),

                  // SECTION 1: Business & Contact Information
                  const Text(
                    'SECTION 1: Business & Contact Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Enter Service Name *',
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
                    ),
                  ),
                  const SizedBox(height: 20),

                  // SECTION 2: Funeral Transport Services Offered
                  const Text(
                    'SECTION 2: Funeral Transport Services Offered',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Types of Funeral Vehicles Available *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 10,
                      children: vehicleTypes.keys.map((type) => ChoiceChip(
                            label: Text(type),
                            selected: vehicleTypes[type]!,
                            onSelected: (selected) {
                              setState(() {
                                vehicleTypes[type] = selected;
                              });
                            },
                          )).toList(),
                    ),
                  ),
                  if (vehicleTypes['Specialty Vehicles']!) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Signup_textfilled(
                        length: 50,
                        textcont: otherVehicleController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "Other (please specify)",
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  const Text(
                    'Number of Vehicles in Fleet',
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
                      hinttext: "Enter number of vehicles",
                    ),
                  ),
                  const SizedBox(height: 20),

                  // SECTION 3: Fleet Information
                  const Text(
                    'Fleet Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Vehicle Type *',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: Signup_textfilled(
                                length: 50,
                                textcont: vehicleTypeController,
                                textfilled_height: 17,
                                textfilled_weight: 1,
                                keytype: TextInputType.text,
                                hinttext: "Vehicle Type",
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Make/Model *',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: Signup_textfilled(
                                length: 50,
                                textcont: makeModelController,
                                textfilled_height: 17,
                                textfilled_weight: 1,
                                keytype: TextInputType.text,
                                hinttext: "Make/Model",
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Color *',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: Signup_textfilled(
                                length: 50,
                                textcont: colorController,
                                textfilled_height: 17,
                                textfilled_weight: 1,
                                keytype: TextInputType.text,
                                hinttext: "Color",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Capacity *',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Year *',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Notes *',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: Signup_textfilled(
                                length: 100,
                                textcont: notesController,
                                textfilled_height: 17,
                                textfilled_weight: 1,
                                keytype: TextInputType.text,
                                hinttext: "Notes",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // SECTION 4: Pricing Details
                  const Text(
                    'Pricing Details (Day Hire Model)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Each partner must offer a day hire rate (standard: 10 hours/100 miles).',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104)),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Day Rate (10 hrs / 100 miles) (£) *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: dayRateController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter day rate",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Mileage Limit *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: mileageLimitController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter mileage limit",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Extra Mileage Charge (£/mile) *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: extraMileageChargeController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter extra mileage charge",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Wait Time Free (£/hour) *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: waitTimeFreeController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter wait time free",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Floral Decoration Service Fee *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: floralDecorationFeeController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter floral decoration fee",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Standard Funeral Service *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: standardFuneralServiceController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter standard funeral service",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'VIP Funeral Service *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: vipFuneralServiceController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter VIP funeral service",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Hourly Pricing Model',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Enter "starting from" prices',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104)),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Hourly Rate (£) *',
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
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Half-Day Rate (£) (5 hours) *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Fuel Charges Included?',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomCheckbox(
                          title: 'Yes',
                          value: fuelChargesIncluded,
                          onChanged: (value) {
                            setState(() {
                              fuelChargesIncluded = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomCheckbox(
                          title: 'No',
                          value: !fuelChargesIncluded,
                          onChanged: (value) {
                            setState(() {
                              fuelChargesIncluded = !value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // SECTION 5: Coverage & Availability
                  const Text(
                    'Coverage & Availability',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildCitySelection('Areas Covered', areasCovered),
                  const SizedBox(height: 10),
                  const Text(
                    'Service Status *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: CustomDropdown(
                      hintText: "Select Service Status",
                      items: ['Open', 'Close'],
                      selectedValue: serviceStatus,
                      onChanged: (value) {
                        setState(() {
                          serviceStatus = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Service Availability Period',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Select the period during which your service will be available',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104)),
                  ),
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
                  const Text(
                    'Special Prices Summary',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: calendarController.specialPrices.length == 0
                        ? Center(
                            child: Text(
                              'No special prices set yet',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ))
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
                                      Text(
                                        DateFormat('EEE, d MMM yyyy').format(date),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '£${price.toStringAsFixed(2)}/hr',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: price > 0 ? Colors.black : Colors.red,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              calendarController.deleteSpecialPrice(date);
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

                  // SECTION 6: Accessibility And Special Services
                  const Text(
                    'SECTION 3: Driver & Service Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Accessibility And Special Services *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
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
                            if (isSelected && service == 'Wheelchair Accessible Vehicle')
                              SizedBox(
                                width: 80,
                                child: Signup_textfilled(
                                  length: 10,
                                  textcont: wheelchairAccessPriceController,
                                  textfilled_height: 17,
                                  textfilled_weight: 1,
                                  keytype: TextInputType.number,
                                  hinttext: "Price (£)",
                                ),
                              ),
                            if (isSelected && service == 'Visual/Hearing Impaired Support')
                              SizedBox(
                                width: 80,
                                child: Signup_textfilled(
                                  length: 10,
                                  textcont: visualHearingSupportPriceController,
                                  textfilled_height: 17,
                                  textfilled_weight: 1,
                                  keytype: TextInputType.number,
                                  hinttext: "Price (£)",
                                ),
                              ),
                            if (isSelected && service == 'Language Translation')
                              SizedBox(
                                width: 80,
                                child: Signup_textfilled(
                                  length: 10,
                                  textcont: languageTranslationPriceController,
                                  textfilled_height: 17,
                                  textfilled_weight: 1,
                                  keytype: TextInputType.number,
                                  hinttext: "Price (£)",
                                ),
                              ),
                            if (isSelected && service == 'Care/Attendant Assistance')
                              SizedBox(
                                width: 80,
                                child: Signup_textfilled(
                                  length: 10,
                                  textcont: careAttendantPriceController,
                                  textfilled_height: 17,
                                  textfilled_weight: 1,
                                  keytype: TextInputType.number,
                                  hinttext: "Price (£)",
                                ),
                              ),
                            if (isSelected && service == 'Assistance with Boarding')
                              SizedBox(
                                width: 80,
                                child: Signup_textfilled(
                                  length: 10,
                                  textcont: boardingAssistancePriceController,
                                  textfilled_height: 17,
                                  textfilled_weight: 1,
                                  keytype: TextInputType.number,
                                  hinttext: "Price (£)",
                                ),
                              ),
                            if (isSelected && service == 'Priority Service for Elderly')
                              SizedBox(
                                width: 80,
                                child: Signup_textfilled(
                                  length: 10,
                                  textcont: priorityServicePriceController,
                                  textfilled_height: 17,
                                  textfilled_weight: 1,
                                  keytype: TextInputType.number,
                                  hinttext: "Price (£)",
                                ),
                              ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 10,
                      children: driverDetails.keys.map((detail) => ChoiceChip(
                            label: Text(detail),
                            selected: driverDetails[detail]!,
                            onSelected: (selected) {
                              setState(() {
                                driverDetails[detail] = selected;
                              });
                            },
                          )).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Funeral Service Type *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: CustomDropdown(
                      hintText: "Select Funeral Service Type",
                      items: ['Non-Religious', 'Additional Support Services'],
                      selectedValue: funeralServiceType,
                      onChanged: (value) {
                        setState(() {
                          funeralServiceType = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Additional Support Services',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 10,
                      children: additionalSupportServices.keys.map((service) => ChoiceChip(
                            label: Text(service),
                            selected: additionalSupportServices[service]!,
                            onSelected: (selected) {
                              setState(() {
                                additionalSupportServices[service] = selected;
                              });
                            },
                          )).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // SECTION 8: Licensing & Insurance
                  const Text(
                    'SECTION 4: Licensing & Insurance',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Private Hire/Operator Licence Number *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 50,
                      textcont: privateHireOperatorLicenceNumberController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.text,
                      hinttext: "Enter licence number",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Licensing Authority *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 50,
                      textcont: licensingAuthorityController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.text,
                      hinttext: "Enter licensing authority",
                    ),
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
                      length: 50,
                      textcont: publicLiabilityInsuranceProviderController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.text,
                      hinttext: "Enter insurance provider",
                    ),
                  ),
                  const SizedBox(height: 10),
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
                      hinttext: "Enter policy number",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Policy Expiry Date *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: policyExpiryDateController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.text,
                      hinttext: "dd-mm-yyyy",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: operatorLicenceEnabled,
                        onChanged: (value) {
                          setState(() {
                            operatorLicenceEnabled = value!;
                          });
                        },
                      ),
                      const Text("Operator Licence"),
                      const SizedBox(width: 20),
                      if (operatorLicenceEnabled)
                        Radio<bool>(
                          value: false,
                          groupValue: operatorLicenceEnabled,
                          onChanged: (value) {
                            setState(() {
                              operatorLicenceEnabled = value!;
                              operatorLicencePaths.clear();
                            });
                          },
                        ),
                      if (operatorLicenceEnabled) const Text("Deselect"),
                    ],
                  ),
                  if (operatorLicenceEnabled) _buildDocumentUploadSection("Operator Licence", operatorLicencePaths, true),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: insuranceCertificateEnabled,
                        onChanged: (value) {
                          setState(() {
                            insuranceCertificateEnabled = value!;
                          });
                        },
                      ),
                      const Text("Insurance Certificate"),
                      const SizedBox(width: 20),
                      if (insuranceCertificateEnabled)
                        Radio<bool>(
                          value: false,
                          groupValue: insuranceCertificateEnabled,
                          onChanged: (value) {
                            setState(() {
                              insuranceCertificateEnabled = value!;
                              insuranceCertificatePaths.clear();
                            });
                          },
                        ),
                      if (insuranceCertificateEnabled) const Text("Deselect"),
                    ],
                  ),
                  if (insuranceCertificateEnabled) _buildDocumentUploadSection("Insurance Certificate", insuranceCertificatePaths, true),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: driverLicencesEnabled,
                        onChanged: (value) {
                          setState(() {
                            driverLicencesEnabled = value!;
                          });
                        },
                      ),
                      const Text("Driver Licences"),
                      const SizedBox(width: 20),
                      if (driverLicencesEnabled)
                        Radio<bool>(
                          value: false,
                          groupValue: driverLicencesEnabled,
                          onChanged: (value) {
                            setState(() {
                              driverLicencesEnabled = value!;
                              driverLicencesPaths.clear();
                            });
                          },
                        ),
                      if (driverLicencesEnabled) const Text("Deselect"),
                    ],
                  ),
                  if (driverLicencesEnabled) _buildDocumentUploadSection("Driver Licences", driverLicencesPaths, true),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: vehicleMotCertificatesEnabled,
                        onChanged: (value) {
                          setState(() {
                            vehicleMotCertificatesEnabled = value!;
                          });
                        },
                      ),
                      const Text("Vehicle MOT Certificates"),
                      const SizedBox(width: 20),
                      if (vehicleMotCertificatesEnabled)
                        Radio<bool>(
                          value: false,
                          groupValue: vehicleMotCertificatesEnabled,
                          onChanged: (value) {
                            setState(() {
                              vehicleMotCertificatesEnabled = value!;
                              vehicleMotCertificatesPaths.clear();
                            });
                          },
                        ),
                      if (vehicleMotCertificatesEnabled) const Text("Deselect"),
                    ],
                  ),
                  if (vehicleMotCertificatesEnabled) _buildDocumentUploadSection("Vehicle MOT Certificates", vehicleMotCertificatesPaths, true),
                  const Text(
                    'Fleet Photos',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Obx(() => Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: List.generate(fleetPhotosPaths.length, (index) {
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

                  // SECTION 5: Business Highlights
                  const Text(
                    'SECTION 5: Business Highlights',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'What makes your service unique or premium?',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 100,
                      textcont: uniqueServiceController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.text,
                      hinttext: "Enter unique service details",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Promotional Description (max 100 words)',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 100,
                      textcont: promotionalDescriptionController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.text,
                      hinttext: "Enter promotional description",
                    ),
                  ),
                  const SizedBox(height: 20),

                  // SECTION 6: Declaration & Agreement
                  const Text(
                    'SECTION 6: Declaration & Agreement',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
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
                  SizedBox(
                    width: double.infinity,
                    child: CustomCheckbox(
                      title: 'I confirm that all information provided is accurate and current.',
                      value: agreeTerms,
                      onChanged: (value) {
                        setState(() {
                          agreeTerms = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: CustomCheckbox(
                      title: 'I have not shared any contact details (Email, Phone, Skype, Website etc.)',
                      value: noContactDetails,
                      onChanged: (value) {
                        setState(() {
                          noContactDetails = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: CustomCheckbox(
                      title: 'I agree to the Cookies Policy',
                      value: agreeCookies,
                      onChanged: (value) {
                        setState(() {
                          agreeCookies = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: CustomCheckbox(
                      title: 'I agree to the Privacy Policy',
                      value: agreePrivacy,
                      onChanged: (value) {
                        setState(() {
                          agreePrivacy = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: CustomCheckbox(
                      title: 'I agree to the Cancellation Fee Policy',
                      value: agreeCancellation,
                      onChanged: (value) {
                        setState(() {
                          agreeCancellation = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}'),
                  const SizedBox(height: 20),
                  Container(
                    width: w,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isSubmitting
                          ? null
                          : () {
                              _submitForm();
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
                              "Submit Funeral Service",
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
      ),
    );
  }
}