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
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/upload_image.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/vendor_home_Page.dart';
import 'package:hire_any_thing/constants_file/uk_cities.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/city_fetch_controller.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CoachHireService extends StatefulWidget {
  final Rxn<String> Category;
  final Rxn<String> SubCategory;
  final String? CategoryId;
  final String? SubCategoryId;

  const CoachHireService({
    super.key,
    required this.Category,
    required this.SubCategory,
    this.CategoryId,
    this.SubCategoryId,
  });

  @override
  State<CoachHireService> createState() => _CoachHireServiceState();
}

class _CoachHireServiceState extends State<CoachHireService> {
  final ImageController imageController = Get.put(ImageController());
  final CouponController couponController = Get.put(CouponController());
  final CalendarController calendarController = Get.put(CalendarController());
  final CityFetchController cityFetchController =
      Get.put(CityFetchController());

  // Section 1: Business Information
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController basePostcodeController = TextEditingController();
  TextEditingController locationRadiusController = TextEditingController();
  bool _isSubmitting = false;

  // Section 2: Services Provided
  Map<String, bool> servicesProvided = {
    'School Trips': false,
    'Corporate Transport': false,
    'Private Group Tours': false,
    'Airport Transfers': false,
    'Long Distance Travel': false,
    'Wedding or Event Transport': false,
    'Shuttle Services': false,
    'Accessible Coach Hire': false,
    'Other': false,
  };
  TextEditingController otherServiceController = TextEditingController();

  // Section 3: Booking Types
  Map<String, bool> bookingTypes = {
    'One Way': false,
    'Return': false,
    'Hourly Hire': false,
    'Daily LongTerm Hire': false,
    'Contractual': false,
  };

  // Section 4: Fleet Information
  TextEditingController makeModelController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  Map<String, bool> onboardFacilities = {
    'Wheelchair Accessible': false,
    'Luggage Space': false,
  };
  TextEditingController fleetSizeController = TextEditingController();

  // Section 5: Rates
  TextEditingController hourlyRateController = TextEditingController();
  TextEditingController halfDayRateController = TextEditingController();
  TextEditingController fullDayRateController = TextEditingController();
  TextEditingController multiDayRateController = TextEditingController();
  bool depositRequired = false;
  TextEditingController mileageAllowanceController = TextEditingController();
  TextEditingController additionalMileageFeeController =
      TextEditingController();

  // Section 6: Coverage & Availability
  RxList<String> areasCovered = <String>[].obs;
  String? serviceStatus;
  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;

  // Section 7: Features, Benefits & Extra Services
  Map<String, bool> comfortLuxury = {
    'Leather Interior': false,
    'Air Conditioning': false,
    'In-Car Entertainment': false,
    'Red Carpet Service': false,
  };
  TextEditingController leatherInteriorPriceController =
      TextEditingController();
  TextEditingController airConditioningPriceController =
      TextEditingController();
  TextEditingController inCarEntertainmentPriceController =
      TextEditingController();
  TextEditingController redCarpetServicePriceController =
      TextEditingController();

  Map<String, bool> wifiAccess = {
    'Wi-Fi Access': false,
    'Complimentary Drinks': false,
    'Bluetooth/USB': false,
  };
  TextEditingController wifiAccessPriceController = TextEditingController();
  TextEditingController complimentaryDrinksPriceController =
      TextEditingController();
  TextEditingController bluetoothUSBPriceController = TextEditingController();

  Map<String, bool> eventsExtras = {
    'Wedding Décor (ribbons, flowers)': false,
    'Party Lighting System': false,
    'Champagne Packages': false,
    'Photography Packages': false,
  };
  TextEditingController weddingDecorPriceController = TextEditingController();
  TextEditingController partyLightingPriceController = TextEditingController();
  TextEditingController champagnePackagesPriceController =
      TextEditingController();
  TextEditingController photographyPackagesPriceController =
      TextEditingController();

  Map<String, bool> accessibilitySpecial = {
    'Wheelchair Access': false,
    'Child Car Seats': false,
    'Pet-Friendly Service': false,
    'Disabled-Access Ramp': false,
    'Senior-Friendly Assistance': false,
    'Stroller / Buggy Storage': false,
  };
  TextEditingController wheelchairAccessPriceController =
      TextEditingController();
  TextEditingController childCarSeatsPriceController = TextEditingController();
  TextEditingController petFriendlyPriceController = TextEditingController();
  TextEditingController disabledAccessRampPriceController =
      TextEditingController();
  TextEditingController seniorFriendlyPriceController = TextEditingController();
  TextEditingController strollerBuggyStoragePriceController =
      TextEditingController();

  Map<String, bool> securityCompliance = {
    'Vehicle Tracking / GPS': false,
    'CCTV Fitted': false,
    'Public Liability Insurance': false,
    'Safety-Certified Drivers (DBS Checked)': false,
  };

  // Section 8: Operating Hours
  bool available24_7 = false;
  TextEditingController specificOperatingTimesController =
      TextEditingController();

  // Section 9: Driver Details
  Map<String, bool> driverDetails = {
    'Fully Licensed': false,
    'DBS Checked': false,
    'Wear Uniforms': false,
  };
  TextEditingController languagesSpokenController = TextEditingController();

  // Section 10: Cancellation Policy
  String? cancellationPolicy;

  // Section 11: Licensing & Documents
  TextEditingController psvOperatorLicenceNumberController =
      TextEditingController();
  TextEditingController licensingAuthorityController = TextEditingController();
  TextEditingController publicLiabilityInsuranceProviderController =
      TextEditingController();
  TextEditingController policyNumberExpiryDateController =
      TextEditingController();
  RxList<String> psvOperatorLicencePaths = <String>[].obs;
  RxList<String> publicLiabilityPaths = <String>[].obs;
  RxList<String> driverLicencePaths = <String>[].obs;
  RxList<String> vehicleMotInsurancePaths = <String>[].obs;
  RxList<String> vehicleImagesPaths = <String>[].obs;
  bool psvOperatorLicenceEnabled = false;
  bool publicLiabilityEnabled = false;
  bool driverLicenceEnabled = false;
  bool vehicleMotInsuranceEnabled = false;

  // Section 12: Business Profile & Promotion
  TextEditingController promotionalListingDescriptionController =
      TextEditingController();
  TextEditingController serviceHighlightsController = TextEditingController();
  bool brandingLogoRemove = false;

  // Section 13: Declaration
  bool agreeTerms = false;
  bool noContactDetails = false;
  bool agreeCookies = false;
  bool agreePrivacy = false;
  bool agreeCancellation = false;

  String? vendorId;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadVendorId();

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

  String mapCancellationPolicy(String? policy) {
    switch (policy) {
      case 'Flexible':
        return 'FLEXIBLE';
      case 'Moderate':
        return 'MODERATE';
      case 'Strict':
        return 'STRICT';
      default:
        return 'MODERATE';
    }
  }

  @override
  void dispose() {
    serviceNameController.dispose();
    basePostcodeController.dispose();
    locationRadiusController.dispose();
    otherServiceController.dispose();
    makeModelController.dispose();
    yearController.dispose();
    capacityController.dispose();
    fleetSizeController.dispose();
    hourlyRateController.dispose();
    halfDayRateController.dispose();
    fullDayRateController.dispose();
    multiDayRateController.dispose();
    mileageAllowanceController.dispose();
    additionalMileageFeeController.dispose();
    specificOperatingTimesController.dispose();
    languagesSpokenController.dispose();
    psvOperatorLicenceNumberController.dispose();
    licensingAuthorityController.dispose();
    publicLiabilityInsuranceProviderController.dispose();
    policyNumberExpiryDateController.dispose();
    promotionalListingDescriptionController.dispose();
    serviceHighlightsController.dispose();
    leatherInteriorPriceController.dispose();
    airConditioningPriceController.dispose();
    inCarEntertainmentPriceController.dispose();
    redCarpetServicePriceController.dispose();
    wifiAccessPriceController.dispose();
    complimentaryDrinksPriceController.dispose();
    bluetoothUSBPriceController.dispose();
    weddingDecorPriceController.dispose();
    partyLightingPriceController.dispose();
    champagnePackagesPriceController.dispose();
    photographyPackagesPriceController.dispose();
    wheelchairAccessPriceController.dispose();
    childCarSeatsPriceController.dispose();
    petFriendlyPriceController.dispose();
    disabledAccessRampPriceController.dispose();
    seniorFriendlyPriceController.dispose();
    strollerBuggyStoragePriceController.dispose();
    hourlyRateController.removeListener(() {});
    super.dispose();
  }

  Future<void> _loadVendorId() async {
    vendorId = await SessionVendorSideManager().getVendorId();
    setState(() {});
  }

  void _submitForm() async {
    // Prevent duplicate submissions
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    // Validation checks with early returns — make sure to set _isSubmitting = false inside setState
    if (!servicesProvided.values.any((v) => v)) {
      Get.snackbar(
        "Missing Information",
        "Please select at least one service.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      setState(() {
        _isSubmitting = false;
      });
      return;
    }

    if (areasCovered.isEmpty) {
      Get.snackbar(
        "Missing Information",
        "At least one area covered is required.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      setState(() {
        _isSubmitting = false;
      });
      return;
    }

    // if (vehicleImagesPaths.length < 3) {
    //   Get.snackbar(
    //     "Missing Information",
    //     "At least 3 vehicle images are required.",
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.redAccent,
    //     colorText: Colors.white,
    //   );
    //   setState(() {
    //     _isSubmitting = false;
    //   });
    //   return;
    // }

    if (!agreeTerms ||
        !noContactDetails ||
        !agreeCookies ||
        !agreePrivacy ||
        !agreeCancellation) {
      Get.snackbar(
        "Missing Information",
        "Please agree to all declarations.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      setState(() {
        _isSubmitting = false;
      });
      return;
    }

    final data = {
      "vendorId": vendorId,
      "categoryId": widget.CategoryId,
      "subcategoryId": widget.SubCategoryId,
      "listingTitle":
          serviceNameController.text.trim(), // Changed from service_name
      "service_status": serviceStatus, // Add this field
      "basePostcode": basePostcodeController.text.trim(),
      "locationRadius": locationRadiusController.text.trim(),
      "servicesProvided": servicesProvided,
      "booking_date_from":
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(fromDate.value),
      "booking_date_to":
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(toDate.value),
      "special_price_days": [], // Add this field
      "offering_price": 0, // Add this field
      "areasCovered": areasCovered.toList(),
      "bookingTypes": bookingTypes,

      // Fix fleet info structure
      "fleetInfo": {
        "makeAndModel": makeModelController.text.trim(),
        "capacity": capacityController.text.trim(),
        "firstRegistered": yearController.text.trim(),
        'seats': fleetSizeController.text.trim(),
        'luggageCapacity': capacityController.text.trim(),
      },

      // Fix pricing structure
      "pricingDetails": {
        // Changed from rates
        "hourlyRate": double.tryParse(hourlyRateController.text.trim()) ?? 0,
        "halfDayRate": double.tryParse(halfDayRateController.text.trim()) ?? 0,
        "fullDayRate": double.tryParse(fullDayRateController.text.trim()) ?? 0,
        "additionalMileageFee":
            double.tryParse(additionalMileageFeeController.text.trim()) ?? 0,
        "mileageLimit": mileageAllowanceController.text.trim(),
      },

      // Map your features to the expected structure
      "comfort": {
        "leatherInterior": comfortLuxury["Leather Interior"] ?? false,
        "wifiAccess": wifiAccess["Wi-Fi Access"] ?? false,
        "airConditioning": comfortLuxury["Air Conditioning"] ?? false,
        "complimentaryDrinks": {
          "available": wifiAccess["Complimentary Drinks"] ?? false,
          "details": ""
        },
        "inCarEntertainment": comfortLuxury["In-Car Entertainment"] ?? false,
        "bluetoothUsb": wifiAccess["Bluetooth/USB"] ?? false,
        "redCarpetService": comfortLuxury["Red Carpet Service"] ?? false,
        "onboardRestroom": false, // Add if you have this field
      },

      "events": {
        "weddingDecor":
            eventsExtras["Wedding Décor (ribbons, flowers)"] ?? false,
        "weddingDecorPrice":
            double.tryParse(weddingDecorPriceController.text.trim()) ?? 0,
        "partyLightingSystem": eventsExtras["Party Lighting System"] ?? false,
        "partyLightingPrice":
            double.tryParse(partyLightingPriceController.text.trim()) ?? 0,
        "champagnePackages": eventsExtras["Champagne Packages"] ?? false,
        "champagnePackagePrice":
            double.tryParse(champagnePackagesPriceController.text.trim()) ?? 0,
        "photographyPackages": eventsExtras["Photography Packages"] ?? false,
        "photographyPackagePrice":
            double.tryParse(photographyPackagesPriceController.text.trim()) ??
                0,
      },

      "accessibility": {
        "wheelchairAccessVehicle":
            accessibilitySpecial["Wheelchair Access"] ?? false,
        "wheelchairAccessPrice":
            double.tryParse(wheelchairAccessPriceController.text.trim()) ?? 0,
        "childCarSeats": accessibilitySpecial["Child Car Seats"] ?? false,
        "childCarSeatsPrice":
            double.tryParse(childCarSeatsPriceController.text.trim()) ?? 0,
        "petFriendlyService":
            accessibilitySpecial["Pet-Friendly Service"] ?? false,
        "petFriendlyPrice":
            double.tryParse(petFriendlyPriceController.text.trim()) ?? 0,
        "disabledAccessRamp":
            accessibilitySpecial["Disabled-Access Ramp"] ?? false,
        "disabledAccessRampPrice":
            double.tryParse(disabledAccessRampPriceController.text.trim()) ?? 0,
        "seniorFriendlyAssistance":
            accessibilitySpecial["Senior-Friendly Assistance"] ?? false,
        "seniorAssistancePrice":
            double.tryParse(seniorFriendlyPriceController.text.trim()) ?? 0,
        "strollerBuggyStorage":
            accessibilitySpecial["Stroller / Buggy Storage"] ?? false,
        "strollerStoragePrice":
            double.tryParse(strollerBuggyStoragePriceController.text.trim()) ??
                0,
      },

      "security": {
        "vehicleTrackingGps":
            securityCompliance["Vehicle Tracking/GPS"] ?? false,
        "cctvFitted": securityCompliance["CCTV Fitted"] ?? false,
        "publicLiabilityInsurance":
            securityCompliance["Public Liability Insurance"] ?? false,
        "safetyCertifiedDrivers":
            securityCompliance["Safety-Certified Drivers"] ?? false,
      },

      "service_image": vehicleImagesPaths,
      "cancellation_policy_type": mapCancellationPolicy(cancellationPolicy),
      "coupons": [],
    };

    final api = AddVendorServiceApi();

    try {
      final isAdded = await api.addServiceVendor(data, 'coach');
      if (isAdded) {
        setState(() {
          _isSubmitting = false;
        });
        Get.to(() => HomePageAddService());
      } else {
        setState(() {
          _isSubmitting = false;
        });
        Get.snackbar(
          'Error',
          'Add Service Failed. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("API Error: $e");
      setState(() {
        _isSubmitting = false;
      });
      Get.snackbar(
        'Error',
        'Server error: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
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
                          onTap: () {
                            documentPaths.removeAt(index);
                          },
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
                    'Coach Hire Form',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Service Name',
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
                  const Text(
                    'Services Provided',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 10,
                      children: servicesProvided.keys
                          .map((service) => ChoiceChip(
                                label: Text(service),
                                selected: servicesProvided[service]!,
                                onSelected: (selected) {
                                  setState(() {
                                    servicesProvided[service] = selected;
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ),
                  if (servicesProvided['Other']!) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Signup_textfilled(
                        length: 100,
                        textcont: otherServiceController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "Please specify other service",
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  const Text(
                    'Base Postcode',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: basePostcodeController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter postcode",
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Location Radius (in miles) *',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: locationRadiusController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter Radius",
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Booking Types',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 10,
                      children: bookingTypes.keys
                          .map((type) => ChoiceChip(
                                label: Text(type),
                                selected: bookingTypes[type]!,
                                onSelected: (selected) {
                                  setState(() {
                                    bookingTypes[type] = selected;
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Fleet Information (For This Vehicle Only)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Make & Model',
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
                      hinttext: "Enter make and model",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Year',
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
                      hinttext: "Enter year",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Capacity',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 3,
                      textcont: capacityController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter fleet capacity",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Onboard Facilities',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 10,
                      children: onboardFacilities.keys
                          .map((facility) => ChoiceChip(
                                label: Text(facility),
                                selected: onboardFacilities[facility]!,
                                onSelected: (selected) {
                                  setState(() {
                                    onboardFacilities[facility] = selected;
                                  });
                                },
                              ))
                          .toList(),
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
                      textcont: fleetSizeController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter number of Seats",
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Rates (from)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Set your base rates for different time periods.',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 109, 104, 104)),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Hourly Rate (£)',
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
                    'Half-Day Rate (£)',
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
                    'Full-Day Rate (£)',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: fullDayRateController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter full-day rate",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Multi-Day/Contract Rate (£ per day)',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: multiDayRateController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter multi-day rate",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Deposit Required',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomCheckbox(
                          title: 'Yes',
                          value: depositRequired,
                          onChanged: (value) {
                            setState(() {
                              depositRequired = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomCheckbox(
                          title: 'No',
                          value: !depositRequired,
                          onChanged: (value) {
                            setState(() {
                              depositRequired = !value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Mileage Allowance (miles included)',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: mileageAllowanceController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter included miles",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Additional Mileage Fee (£ per mile)',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 10,
                      textcont: additionalMileageFeeController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.number,
                      hinttext: "Enter fee per mile",
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Coverage & Availability',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildCitySelection('Areas Covered', areasCovered),
                  const SizedBox(height: 20),
                  const Text(
                    'Service Status',
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  const Text(
                    'Features, Benefits & Extra Services',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Comfort & Luxury',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 10,
                      children: comfortLuxury.keys.map((feature) {
                        bool isSelected = comfortLuxury[feature]!;
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ChoiceChip(
                              label: Text(feature),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  comfortLuxury[feature] = selected;
                                });
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Wi-Fi Access',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 10,
                      children: wifiAccess.keys.map((feature) {
                        bool isSelected = wifiAccess[feature]!;
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ChoiceChip(
                              label: Text(feature),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  wifiAccess[feature] = selected;
                                });
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Events & Extras',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
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
                            if (isSelected &&
                                extra == 'Wedding Décor (ribbons, flowers)')
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
                            if (isSelected && extra == 'Party Lighting System')
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
                            if (isSelected && extra == 'Champagne Packages')
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
                            if (isSelected && extra == 'Photography Packages')
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
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Accessibility & Special Services',
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
                            if (isSelected && service == 'Wheelchair Access')
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
                            if (isSelected && service == 'Child Car Seats')
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
                            if (isSelected && service == 'Pet-Friendly Service')
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
                            if (isSelected && service == 'Disabled-Access Ramp')
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
                            if (isSelected &&
                                service == 'Senior-Friendly Assistance')
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
                            if (isSelected &&
                                service == 'Stroller / Buggy Storage')
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
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Security & Compliance',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
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
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Operating Hours',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomCheckbox(
                          title: 'Available 24/7',
                          value: available24_7,
                          onChanged: (value) {
                            setState(() {
                              available24_7 = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomCheckbox(
                          title: 'Specific Operating Times',
                          value: !available24_7,
                          onChanged: (value) {
                            setState(() {
                              available24_7 = !value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  if (!available24_7) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Signup_textfilled(
                        length: 50,
                        textcont: specificOperatingTimesController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "e.g., Mon-Fri 9am-6pm",
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  const Text(
                    'Driver Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 10,
                      children: driverDetails.keys
                          .map((detail) => ChoiceChip(
                                label: Text(detail),
                                selected: driverDetails[detail]!,
                                onSelected: (selected) {
                                  setState(() {
                                    driverDetails[detail] = selected;
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Languages Spoken',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 50,
                      textcont: languagesSpokenController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.text,
                      hinttext: "Enter languages spoken",
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Cancellation Policy',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Around line 1157 in your code, change:
                  SizedBox(
                    width: double.infinity,
                    child: CustomDropdown(
                      hintText: "Select a Cancellation Policy",
                      items: ['FLEXIBLE', 'MODERATE', 'STRICT'],
                      selectedValue: cancellationPolicy,
                      onChanged: (value) {
                        setState(() {
                          cancellationPolicy = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    'Licensing & Documents',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'PSV Operator Licence Number',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 50,
                      textcont: psvOperatorLicenceNumberController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.text,
                      hinttext: "Enter PSV operator licence number",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Licensing Authority',
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
                    'Public Liability Insurance Provider',
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
                    'Policy Number and Expiry Date',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 50,
                      textcont: policyNumberExpiryDateController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.text,
                      hinttext: "Enter policy number and expiry date",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: psvOperatorLicenceEnabled,
                        onChanged: (value) {
                          setState(() {
                            psvOperatorLicenceEnabled = value!;
                          });
                        },
                      ),
                      const Text("PSV Operator Licence"),
                      const SizedBox(width: 20),
                      if (psvOperatorLicenceEnabled)
                        Radio<bool>(
                          value: false,
                          groupValue: psvOperatorLicenceEnabled,
                          onChanged: (value) {
                            setState(() {
                              psvOperatorLicenceEnabled = value!;
                              psvOperatorLicencePaths.clear();
                            });
                          },
                        ),
                      if (psvOperatorLicenceEnabled) const Text("Deselect"),
                    ],
                  ),
                  if (psvOperatorLicenceEnabled)
                    _buildDocumentUploadSection(
                        "PSV Operator Licence", psvOperatorLicencePaths, true),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: publicLiabilityEnabled,
                        onChanged: (value) {
                          setState(() {
                            publicLiabilityEnabled = value!;
                          });
                        },
                      ),
                      const Text("Public Liability Insurance"),
                      const SizedBox(width: 20),
                      if (publicLiabilityEnabled)
                        Radio<bool>(
                          value: false,
                          groupValue: publicLiabilityEnabled,
                          onChanged: (value) {
                            setState(() {
                              publicLiabilityEnabled = value!;
                              publicLiabilityPaths.clear();
                            });
                          },
                        ),
                      if (publicLiabilityEnabled) const Text("Deselect"),
                    ],
                  ),
                  if (publicLiabilityEnabled)
                    _buildDocumentUploadSection("Public Liability Insurance",
                        publicLiabilityPaths, true),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: driverLicenceEnabled,
                        onChanged: (value) {
                          setState(() {
                            driverLicenceEnabled = value!;
                          });
                        },
                      ),
                      const Text("Driver Licences And DBS"),
                      const SizedBox(width: 20),
                      if (driverLicenceEnabled)
                        Radio<bool>(
                          value: false,
                          groupValue: driverLicenceEnabled,
                          onChanged: (value) {
                            setState(() {
                              driverLicenceEnabled = value!;
                              driverLicencePaths.clear();
                            });
                          },
                        ),
                      if (driverLicenceEnabled) const Text("Deselect"),
                    ],
                  ),
                  if (driverLicenceEnabled)
                    _buildDocumentUploadSection(
                        "Driver Licences And DBS", driverLicencePaths, true),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: vehicleMotInsuranceEnabled,
                        onChanged: (value) {
                          setState(() {
                            vehicleMotInsuranceEnabled = value!;
                          });
                        },
                      ),
                      const Text("Vehicle MOT And Insurance"),
                      const SizedBox(width: 20),
                      if (vehicleMotInsuranceEnabled)
                        Radio<bool>(
                          value: false,
                          groupValue: vehicleMotInsuranceEnabled,
                          onChanged: (value) {
                            setState(() {
                              vehicleMotInsuranceEnabled = value!;
                              vehicleMotInsurancePaths.clear();
                            });
                          },
                        ),
                      if (vehicleMotInsuranceEnabled) const Text("Deselect"),
                    ],
                  ),
                  if (vehicleMotInsuranceEnabled)
                    _buildDocumentUploadSection("Vehicle MOT And Insurance",
                        vehicleMotInsurancePaths, true),
                  const Text(
                    'Vehicle Images (Upload minimum 3 images)',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Obx(() => Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: List.generate(vehicleImagesPaths.length,
                                (index) {
                              return Stack(
                                children: [
                                  Image.file(
                                    File(vehicleImagesPaths[index]),
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
                  // Vehicle Images Upload Section
                  Container(
                    height: 120,
                    child: vehicleImagesPaths.isEmpty
                        ? GestureDetector(
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
                                          await imageController
                                              .pickImages(true);
                                          if (imageController
                                              .selectedImages.isNotEmpty) {
                                            setState(() {
                                              vehicleImagesPaths.addAll(
                                                  imageController
                                                      .selectedImages);
                                            });
                                            imageController.selectedImages
                                                .clear();
                                          }
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading:
                                            const Icon(Icons.photo_library),
                                        title:
                                            const Text('Choose from Gallery'),
                                        onTap: () async {
                                          await imageController
                                              .pickImages(false);
                                          if (imageController
                                              .selectedImages.isNotEmpty) {
                                            setState(() {
                                              vehicleImagesPaths.addAll(
                                                  imageController
                                                      .selectedImages);
                                            });
                                            imageController.selectedImages
                                                .clear();
                                          }
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_photo_alternate,
                                      size: 40, color: Colors.grey),
                                  Text('Add Vehicle Images',
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: vehicleImagesPaths.length + 1,
                            itemBuilder: (context, index) {
                              if (index == vehicleImagesPaths.length) {
                                return GestureDetector(
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
                                                await imageController
                                                    .pickImages(true);
                                                if (imageController
                                                    .selectedImages
                                                    .isNotEmpty) {
                                                  setState(() {
                                                    vehicleImagesPaths.addAll(
                                                        imageController
                                                            .selectedImages);
                                                  });
                                                  imageController.selectedImages
                                                      .clear();
                                                }
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.photo_library),
                                              title: const Text(
                                                  'Choose from Gallery'),
                                              onTap: () async {
                                                await imageController
                                                    .pickImages(false);
                                                if (imageController
                                                    .selectedImages
                                                    .isNotEmpty) {
                                                  setState(() {
                                                    vehicleImagesPaths.addAll(
                                                        imageController
                                                            .selectedImages);
                                                  });
                                                  imageController.selectedImages
                                                      .clear();
                                                }
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 100,
                                    margin: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.add,
                                        size: 40, color: Colors.grey),
                                  ),
                                );
                              }

                              return Container(
                                width: 100,
                                margin: const EdgeInsets.all(4),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        File(vehicleImagesPaths[index]),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 2,
                                      right: 2,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            vehicleImagesPaths
                                                .removeAt(index); 
                                          });
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Business Profile & Promotion',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Promotional Listing Description (Max 100 words. This will be displayed on your profile)',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 100,
                      textcont: promotionalListingDescriptionController,
                      textfilled_height: 10,
                      textfilled_weight: 1,
                      keytype: TextInputType.text,
                      hinttext: "Enter description",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Service Highlights',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 100,
                      textcont: serviceHighlightsController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.text,
                      hinttext:
                          "What makes your coach hire service reliable or premium?",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Branding Logo Remove',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: CustomDropdown(
                      hintText: "Select",
                      items: ['Yes', 'No'],
                      selectedValue: brandingLogoRemove ? 'Yes' : 'No',
                      onChanged: (value) {
                        setState(() {
                          brandingLogoRemove = value == 'Yes';
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Coupons / Discounts',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: w * 0.45,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Get.dialog(AddCouponDialog()),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (states) => Colors.green),
                      ),
                      child: const Text("Add Coupon",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() => couponController.coupons.isEmpty
                      ? const SizedBox.shrink()
                      : CouponList()),
                  const SizedBox(height: 20),
                  const Text(
                    'Declaration & Agreement',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: CustomCheckbox(
                      title: 'I agree to the Terms and Conditions',
                      value: agreeTerms,
                      onChanged: (value) {
                        setState(() {
                          agreeTerms = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: CustomCheckbox(
                      title:
                          'I have not shared any contact details (Email, Phone, Skype, Website, etc.)',
                      value: noContactDetails,
                      onChanged: (value) {
                        setState(() {
                          noContactDetails = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
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
                                (states) => Colors.green),
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
                              "Save and Submit",
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
