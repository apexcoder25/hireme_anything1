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
import 'package:hire_any_thing/data/getx_controller/vender_side/service_controller.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math' as math;

class HorseAndCarriageHireService extends StatefulWidget {
  final Rxn<String> Category;
  final Rxn<String> SubCategory;
  final String? CategoryId;
  final String? SubCategoryId;

  const HorseAndCarriageHireService({
    super.key,
    required this.Category,
    required this.SubCategory,
    this.CategoryId,
    this.SubCategoryId,
  });

  @override
  State<HorseAndCarriageHireService> createState() =>
      _HorseAndCarriageHireServiceState();
}

class _HorseAndCarriageHireServiceState
    extends State<HorseAndCarriageHireService> {
  final ImageController imageController = Get.put(ImageController());
  final CouponController couponController = Get.put(CouponController());
  final CalendarController calendarController = Get.put(CalendarController());
  final CityFetchController cityFetchController =
      Get.put(CityFetchController());

  // Section 1: Business & Contact Information
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController basePostcodeController = TextEditingController();
  TextEditingController locationRadiusController = TextEditingController();

  // Section 2: Horse and Carriage Services Offered
  Map<String, bool> carriageTypes = {
    'Traditional Horse-Drawn Carriage': false,
    'Luxury Carriage': false,
    'Vintage Carriage': false,
    'Specialty Carriage': false,
  };
  TextEditingController otherCarriageController = TextEditingController();
  TextEditingController seatsController = TextEditingController();
  TextEditingController luggageCapacityController = TextEditingController();

  // Section 3: Equipment & Safety
  bool isMaintainedAndSafetyChecked = false;
  TextEditingController maintenanceFrequencyController =
      TextEditingController();

  // Section 3: Fleet Information
  TextEditingController carriageTypeController = TextEditingController();
  TextEditingController horseBreedController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  // Section 4: Pricing Details
  TextEditingController dayRateController = TextEditingController();
  TextEditingController mileageLimitController = TextEditingController();
  TextEditingController extraMileageChargeController = TextEditingController();
  TextEditingController waitTimeFreeController = TextEditingController();
  TextEditingController decorationFeeController = TextEditingController();
  TextEditingController standardServiceController = TextEditingController();
  TextEditingController premiumServiceController = TextEditingController();
  TextEditingController hourlyRateController = TextEditingController();
  TextEditingController halfDayRateController = TextEditingController();
  TextEditingController bookingProcessController = TextEditingController();
  TextEditingController paymentTermsController = TextEditingController();
  bool fuelAndFeedIncluded = false;

  // Section 5: Coverage & Availability
  RxList<String> areasCovered = <String>[].obs;
  String? serviceStatus;
  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;
  Rx<DateTime> firstRegisteredDate = DateTime.now().obs;

  // Section 6: Accessibility And Special Services
  Map<String, bool> accessibilitySpecial = {
    'Wheelchair Accessible Carriage': false,
    'Assistance for Elderly': false,
    'Custom Decorations': false,
  };
  TextEditingController wheelchairAccessPriceController =
      TextEditingController();
  TextEditingController elderlyAssistancePriceController =
      TextEditingController();
  TextEditingController customDecorationPriceController =
      TextEditingController();

  // Section 7: Driver & Horse Handler Details
  Map<String, bool> handlerDetails = {
    'Handlers in uniform and trained?': false,
    'Handlers DBS checked and licensed?': false,
    'Coordinate with event planners?': false,
  };
  String? eventType;
  Map<String, bool> additionalServices = {
    'Event Escorts': false,
    'Themed Decorations': false,
    'Custom Route Planning': false,
  };

  // Section 8: Licensing & Insurance
  bool hasPublicLiabilityInsurance = false;
  TextEditingController insuranceProviderController = TextEditingController();
  TextEditingController insurancePolicyNumberController =
      TextEditingController();
  TextEditingController insuranceExpiryDateController = TextEditingController();
  bool hasPerformingAnimalLicence = false;
  TextEditingController animalLicenceNumberController = TextEditingController();
  TextEditingController licensingAuthorityController = TextEditingController();
  TextEditingController licenceExpiryDateController = TextEditingController();
  TextEditingController makeAndModelController = TextEditingController();
  RxList<String> licencePaths = <String>[].obs;
  RxList<String> insuranceCertificatePaths = <String>[].obs;
  RxList<String> horseCertificatesPaths = <String>[].obs;
  RxList<String> carriagePhotosPaths = <String>[].obs;
  bool licenceEnabled = false;
  bool insuranceCertificateEnabled = false;
  bool horseCertificatesEnabled = false;

  // Section 9: Business Highlights
  TextEditingController uniqueServiceController = TextEditingController();
  TextEditingController promotionalDescriptionController =
      TextEditingController();
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
  // void initState() {
  //   super.initState();
  //   _loadVendorId();
  //   if (fromDate.value.isBefore(DateTime.now())) fromDate.value = DateTime.now();
  //   if (toDate.value.isBefore(DateTime.now())) toDate.value = DateTime.now();
  //   calendarController.fromDate.value = fromDate.value;
  //   calendarController.toDate.value = toDate.value;
  //   hourlyRateController.addListener(() {
  //     calendarController.setDefaultPrice(double.tryParse(hourlyRateController.text) ?? 0.0);
  //   });
  // }
  @override
  void initState() {
    super.initState();
    _loadVendorId();

    // Use addPostFrameCallback to avoid build conflicts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (fromDate.value.isBefore(DateTime.now()))
        fromDate.value = DateTime.now();
      if (toDate.value.isBefore(DateTime.now())) toDate.value = DateTime.now();
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
    imageController.dispose();
    makeAndModelController.dispose();
    otherCarriageController.dispose();
    seatsController.dispose();
    luggageCapacityController.dispose();
    maintenanceFrequencyController.dispose();
    carriageTypeController.dispose();
    horseBreedController.dispose();
    colorController.dispose();
    capacityController.dispose();
    yearController.dispose();
    notesController.dispose();
    dayRateController.dispose();
    mileageLimitController.dispose();
    extraMileageChargeController.dispose();
    waitTimeFreeController.dispose();
    decorationFeeController.dispose();
    standardServiceController.dispose();
    premiumServiceController.dispose();
    hourlyRateController.dispose();
    halfDayRateController.dispose();
    bookingProcessController.dispose();
    paymentTermsController.dispose();
    wheelchairAccessPriceController.dispose();
    elderlyAssistancePriceController.dispose();
    customDecorationPriceController.dispose();
    insuranceProviderController.dispose();
    insurancePolicyNumberController.dispose();
    insuranceExpiryDateController.dispose();
    animalLicenceNumberController.dispose();
    licensingAuthorityController.dispose();
    licenceExpiryDateController.dispose();
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
    setState(() {
      _isSubmitting = true;
    });

    if (!carriageTypes.values.any((v) => v)) {
      Get.snackbar(
          "Missing Information", "Please select at least one carriage type.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);

      setState(() {
        _isSubmitting = false;
      });
      return;
    }

    if (areasCovered.isEmpty) {
      Get.snackbar(
          "Missing Information", "At least one area covered is required.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);

      setState(() {
        _isSubmitting = false;
      });
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

      setState(() {
        _isSubmitting = false;
      });
      return;
    }
final data = {
    "vendorId": vendorId,
    "categoryId": widget.CategoryId,
    "subcategoryId": widget.SubCategoryId,
    "service_name": serviceNameController.text.trim(),
    "listingTitle": serviceNameController.text.trim(),
    
    "vehicleDetails": {
      "makeAndModel": makeAndModelController.text.trim(),
      "firstRegistered": DateFormat("yyyy-MM-dd").format(firstRegisteredDate.value),
      "basePostcode": basePostcodeController.text.trim(),
      "locationRadius": locationRadiusController.text.trim(),
      // Ensure these are ALWAYS present and non-null
      "luggageCapacity": luggageCapacityController.text.trim(),
      "seats": seatsController.text.trim(),
    },
    
    "carriageTypes": carriageTypes,
    "otherCarriage": carriageTypes['Specialty Carriage'] == true
        ? otherCarriageController.text.trim()
        : "",
    "fleetSize": seatsController.text.trim(),
    
    "equipmentSafety": {
      "isMaintainedAndSafetyChecked": isMaintainedAndSafetyChecked,
      "maintenanceFrequency": "Monthly", 
    },
    
    "fleetInfo": {
      "carriageType": carriageTypeController.text.trim(),
      "horseBreed": horseBreedController.text.trim(),
      "color": colorController.text.trim(),
      "capacity": capacityController.text.trim(),
      "year": yearController.text.trim(),
      "notes": notesController.text.trim(),
    },
    
    "pricing": {
      "dayRate": double.tryParse(dayRateController.text.trim()) ?? 0,
      "mileageLimit": math.max(double.tryParse(mileageLimitController.text.trim()) ?? 200, 200),
      "extraMileageCharge": double.tryParse(extraMileageChargeController.text.trim()) ?? 0,
      "waitTimeFree": double.tryParse(waitTimeFreeController.text.trim()) ?? 0,
      "decorationFee": double.tryParse(decorationFeeController.text.trim()) ?? 0,
      "standardService": double.tryParse(standardServiceController.text.trim()) ?? 0,
      "premiumService": double.tryParse(premiumServiceController.text.trim()) ?? 0,
      "hourlyRate": double.tryParse(hourlyRateController.text.trim()) ?? 0,
      "halfDayRate": double.tryParse(halfDayRateController.text.trim()) ?? 0,
      "bookingProcess": bookingProcessController.text.trim(),
      "paymentTerms": paymentTermsController.text.trim(),
      "fuelAndFeedIncluded": fuelAndFeedIncluded,
    },
    
    "coverageAvailability": {
      "areasCovered": areasCovered.toList(),
      "serviceStatus": serviceStatus,
      "fromDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(fromDate.value),
      "toDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(toDate.value),
    },
    
    "accessibilitySpecial": {
      "Wheelchair Accessible Carriage": accessibilitySpecial['Wheelchair Accessible Carriage']!,
      "Wheelchair Access Price": double.tryParse(wheelchairAccessPriceController.text.trim()) ?? 0,
      "Assistance for Elderly": accessibilitySpecial['Assistance for Elderly']!,
      "Elderly Assistance Price": double.tryParse(elderlyAssistancePriceController.text.trim()) ?? 0,
      "Custom Decorations": accessibilitySpecial['Custom Decorations']!,
      "Custom Decoration Price": double.tryParse(customDecorationPriceController.text.trim()) ?? 0,
    },
    
    "handlerDetails": {
      "handlerDetails": handlerDetails,
      "eventType": eventType,
      "additionalServices": additionalServices,
    },
    
    "licensingInsurance": {
      "hasPublicLiabilityInsurance": hasPublicLiabilityInsurance,
      "insuranceProvider": hasPublicLiabilityInsurance ? insuranceProviderController.text.trim() : "",
      "insurancePolicyNumber": hasPublicLiabilityInsurance ? insurancePolicyNumberController.text.trim() : "",
      "insuranceExpiryDate": hasPublicLiabilityInsurance ? insuranceExpiryDateController.text.trim() : "",
      "hasPerformingAnimalLicence": hasPerformingAnimalLicence,
      "animalLicenceNumber": hasPerformingAnimalLicence ? animalLicenceNumberController.text.trim() : "",
      "licensingAuthority": hasPerformingAnimalLicence ? licensingAuthorityController.text.trim() : "",
      "licenceExpiryDate": hasPerformingAnimalLicence ? licenceExpiryDateController.text.trim() : "",
      "licencePaths": licenceEnabled ? licencePaths : [],
      "insuranceCertificatePaths": insuranceCertificateEnabled ? insuranceCertificatePaths : [],
      "horseCertificatesPaths": horseCertificatesEnabled ? horseCertificatesPaths : [],
      "carriagePhotosPaths": carriagePhotosPaths,
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
    
    "cancellation_policy_type": cancellationPolicy ?? "FLEXIBLE",
  };
    final api = AddVendorServiceApi();
    try {
      final isAdded = await api.addServiceVendor(data, 'horseCarriage');
      if (isAdded) {
        // ✅ Use setState before navigation
        setState(() {
          _isSubmitting = false;
        });
        Get.to(() => HomePageAddService());
      } else {
        Get.snackbar('Error', 'Add Service Failed. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      }
    } catch (e) {
      print("API Error: $e");
      Get.snackbar('Error', 'Server error: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
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

  Widget _buildDocumentUploadSection(
      String title, RxList<String> documentPaths, bool isRequired) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title${isRequired ? ' *' : ''}",
            style: const TextStyle(color: Colors.black, fontSize: 16)),
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
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
        Text(
          '$label Date and Time *',
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
              autovalidateMode: AutovalidateMode.disabled,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Horse and Carriage Hire - Vendor Listing',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'hireanything.com - Elegant Horse and Carriage Hire Services',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 109, 104, 104)),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'List your luxurious horse and carriage hire services for weddings, events, and special occasions across the UK.',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 109, 104, 104)),
                  ),
                  const SizedBox(height: 20),

                  // SECTION 1: Business & Contact Information
                  const Text(
                    'SECTION 1: Business & Contact Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Provide details about your business and contact information.',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 109, 104, 104)),
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
                  const SizedBox(height: 10),
                  const Text(
                    'Base Postcode *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 50,
                      textcont: basePostcodeController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.text,
                      hinttext: "Enter Base Postcode",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Location Radius (in mile)*',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 50,
                      textcont: locationRadiusController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter Location Radius",
                    ),
                  ),
                  const SizedBox(height: 20),

                  // SECTION 2: Horse and Carriage Services Offered
                  const Text(
                    'SECTION 2: Horse and Carriage Services Offered',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Select the types of carriages you offer.',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 109, 104, 104)),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Types of Carriages Available *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 10,
                      children: carriageTypes.keys
                          .map((type) => ChoiceChip(
                                label: Text(type),
                                selected: carriageTypes[type]!,
                                onSelected: (selected) {
                                  setState(() {
                                    carriageTypes[type] = selected;
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ),
                  if (carriageTypes['Specialty Carriage']!) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Signup_textfilled(
                        length: 50,
                        textcont: otherCarriageController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "Other (please specify)",
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  const Text('Make and Model *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 50,
                      textcont: makeAndModelController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.text,
                      hinttext: "Enter Make and Model",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Number of Seats',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: seatsController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter number of seats",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Luggage Capacity',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: luggageCapacityController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Luggage Capacity",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('First Registered Date *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(() => GestureDetector(
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: firstRegisteredDate.value,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              firstRegisteredDate.value = pickedDate;
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(firstRegisteredDate.value),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const Icon(Icons.calendar_today,
                                    color: Colors.grey),
                              ],
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(height: 20),

                  // SECTION 3: Equipment & Safety
                  const Text(
                    'SECTION 3: Equipment & Safety',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Ensure your equipment meets safety standards.',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 109, 104, 104)),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Are carriages regularly maintained and safety-checked? *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomCheckbox(
                          title: 'Yes',
                          value: isMaintainedAndSafetyChecked,
                          onChanged: (value) {
                            setState(() {
                              isMaintainedAndSafetyChecked = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomCheckbox(
                          title: 'No',
                          value: !isMaintainedAndSafetyChecked,
                          onChanged: (value) {
                            setState(() {
                              isMaintainedAndSafetyChecked = !value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  if (isMaintainedAndSafetyChecked) ...[
                    const SizedBox(height: 10),
                    const Text(
                      'How Often *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Signup_textfilled(
                        length: 50,
                        textcont: maintenanceFrequencyController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "e.g., Monthly, Quarterly",
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),

                  // SECTION 3: Fleet Information
                  const Text(
                    'Fleet Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Provide details about your fleet.',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 109, 104, 104)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Carriage Type *',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: Signup_textfilled(
                                length: 50,
                                textcont: carriageTypeController,
                                textfilled_height: 17,
                                textfilled_weight: 1,
                                keytype: TextInputType.text,
                                hinttext: "Carriage Type",
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
                              'Horse Breed *',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: Signup_textfilled(
                                length: 50,
                                textcont: horseBreedController,
                                textfilled_height: 17,
                                textfilled_weight: 1,
                                keytype: TextInputType.text,
                                hinttext: "Horse Breed",
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
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
                    'SECTION 4: Pricing Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Set your pricing structure for the day hire model (standard: 8 hours/80 miles) and additional terms.',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 109, 104, 104)),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Day Rate (8 hrs / 80 miles) (£) *',
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
                    'Decoration Fee *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: decorationFeeController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter decoration fee",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Standard Service *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: standardServiceController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter standard service",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Premium Service *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: premiumServiceController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter premium service",
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
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 109, 104, 104)),
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
                    'Half-Day Rate (£) (4 hours) *',
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
                    'Booking Process *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 100,
                      textcont: bookingProcessController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.text,
                      hinttext: "Describe booking process",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Payment Terms *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 100,
                      textcont: paymentTermsController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.text,
                      hinttext: "Describe payment terms",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Fuel and Feed Charges Included?',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomCheckbox(
                          title: 'Yes',
                          value: fuelAndFeedIncluded,
                          onChanged: (value) {
                            setState(() {
                              fuelAndFeedIncluded = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomCheckbox(
                          title: 'No',
                          value: !fuelAndFeedIncluded,
                          onChanged: (value) {
                            setState(() {
                              fuelAndFeedIncluded = !value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // SECTION 5: Coverage & Availability
                  const Text(
                    'SECTION 5: Coverage & Availability',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Define your service coverage and availability.',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 109, 104, 104)),
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
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 109, 104, 104)),
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
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '£${price.toStringAsFixed(2)}/hr',
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
                                              calendarController
                                                  .deleteSpecialPrice(date);
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
                    'SECTION 6: Accessibility And Special Services',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Offer accessibility and special services to enhance your listing.',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 109, 104, 104)),
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
                            if (isSelected &&
                                service == 'Wheelchair Accessible Carriage')
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
                            if (isSelected &&
                                service == 'Assistance for Elderly')
                              SizedBox(
                                width: 80,
                                child: Signup_textfilled(
                                  length: 10,
                                  textcont: elderlyAssistancePriceController,
                                  textfilled_height: 17,
                                  textfilled_weight: 1,
                                  keytype: TextInputType.number,
                                  hinttext: "Price (£)",
                                ),
                              ),
                            if (isSelected && service == 'Custom Decorations')
                              SizedBox(
                                width: 80,
                                child: Signup_textfilled(
                                  length: 10,
                                  textcont: customDecorationPriceController,
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
                      children: handlerDetails.keys
                          .map((detail) => ChoiceChip(
                                label: Text(detail),
                                selected: handlerDetails[detail]!,
                                onSelected: (selected) {
                                  setState(() {
                                    handlerDetails[detail] = selected;
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Event Type *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: CustomDropdown(
                      hintText: "Select Event Type",
                      items: ['Wedding', 'Event', 'Special Occasion'],
                      selectedValue: eventType,
                      onChanged: (value) {
                        setState(() {
                          eventType = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Additional Services',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 10,
                      children: additionalServices.keys
                          .map((service) => ChoiceChip(
                                label: Text(service),
                                selected: additionalServices[service]!,
                                onSelected: (selected) {
                                  setState(() {
                                    additionalServices[service] = selected;
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // SECTION 7: Licensing & Insurance
                  const Text(
                    'SECTION 7: Licensing & Insurance',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Provide details of your licensing and insurance.',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 109, 104, 104)),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Do you hold Public Liability Insurance? *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomCheckbox(
                          title: 'Yes',
                          value: hasPublicLiabilityInsurance,
                          onChanged: (value) {
                            setState(() {
                              hasPublicLiabilityInsurance = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomCheckbox(
                          title: 'No',
                          value: !hasPublicLiabilityInsurance,
                          onChanged: (value) {
                            setState(() {
                              hasPublicLiabilityInsurance = !value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  if (hasPublicLiabilityInsurance) ...[
                    const SizedBox(height: 10),
                    const Text(
                      'Insurance Provider *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Signup_textfilled(
                        length: 50,
                        textcont: insuranceProviderController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "Enter insurance provider",
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Policy Number *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Signup_textfilled(
                        length: 50,
                        textcont: insurancePolicyNumberController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "Enter policy number",
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Expiry Date *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Signup_textfilled(
                        length: 10,
                        textcont: insuranceExpiryDateController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "dd-mm-yyyy",
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  const Text(
                    'Do you hold a Performing Animal Licence (if applicable)? *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomCheckbox(
                          title: 'Yes',
                          value: hasPerformingAnimalLicence,
                          onChanged: (value) {
                            setState(() {
                              hasPerformingAnimalLicence = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomCheckbox(
                          title: 'No',
                          value: !hasPerformingAnimalLicence,
                          onChanged: (value) {
                            setState(() {
                              hasPerformingAnimalLicence = !value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  if (hasPerformingAnimalLicence) ...[
                    const SizedBox(height: 10),
                    const Text(
                      'Licence Number *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Signup_textfilled(
                        length: 50,
                        textcont: animalLicenceNumberController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "Enter licence number",
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Licensing Authority *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                      'Expiry Date *',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Signup_textfilled(
                        length: 10,
                        textcont: licenceExpiryDateController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "dd-mm-yyyy",
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: licenceEnabled,
                        onChanged: (value) {
                          setState(() {
                            licenceEnabled = value!;
                          });
                        },
                      ),
                      const Text("Licence"),
                      const SizedBox(width: 20),
                      if (licenceEnabled)
                        Radio<bool>(
                          value: false,
                          groupValue: licenceEnabled,
                          onChanged: (value) {
                            setState(() {
                              licenceEnabled = value!;
                              licencePaths.clear();
                            });
                          },
                        ),
                      if (licenceEnabled) const Text("Deselect"),
                    ],
                  ),
                  if (licenceEnabled)
                    _buildDocumentUploadSection("Licence", licencePaths, true),
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
                  if (insuranceCertificateEnabled)
                    _buildDocumentUploadSection("Insurance Certificate",
                        insuranceCertificatePaths, true),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: horseCertificatesEnabled,
                        onChanged: (value) {
                          setState(() {
                            horseCertificatesEnabled = value!;
                          });
                        },
                      ),
                      const Text("Horse Certificates"),
                      const SizedBox(width: 20),
                      if (horseCertificatesEnabled)
                        Radio<bool>(
                          value: false,
                          groupValue: horseCertificatesEnabled,
                          onChanged: (value) {
                            setState(() {
                              horseCertificatesEnabled = value!;
                              horseCertificatesPaths.clear();
                            });
                          },
                        ),
                      if (horseCertificatesEnabled) const Text("Deselect"),
                    ],
                  ),
                  if (horseCertificatesEnabled)
                    _buildDocumentUploadSection(
                        "Horse Certificates", horseCertificatesPaths, true),
                  const Text(
                    'Carriage Photos',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Obx(() => Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: List.generate(carriagePhotosPaths.length,
                                (index) {
                              return Stack(
                                children: [
                                  Image.file(
                                    File(carriagePhotosPaths[index]),
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

                  // SECTION 8: Business Highlights
                  const Text(
                    'SECTION 8: Business Highlights',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Highlight what makes your service stand out.',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 109, 104, 104)),
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

                  // SECTION 9: Declaration & Agreement
                  const Text(
                    'SECTION 9: Declaration & Agreement',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Agree to the terms and conditions.',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 109, 104, 104)),
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
                      title:
                          'I confirm that all information provided is accurate and current.',
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
                      title:
                          'I have not shared any contact details (Email, Phone, Skype, Website etc.)',
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
                  Text(
                      'Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}'),
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
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (states) => Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
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
                              "Save & Continue",
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
