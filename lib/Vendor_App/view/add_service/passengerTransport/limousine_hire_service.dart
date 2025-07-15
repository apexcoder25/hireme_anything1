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

  // Section 1: Service Category
  TextEditingController serviceNameController = TextEditingController();
  Map<String, bool> serviceCategories = {
    'Limousine Hire': false,
    'Chauffeur Service': false,
    'Wedding Car Hire': false,
    'Airport Transfers': false,
    'Corporate Transport': false,
    'Party & Event Transfers': false,
    'Other': false,
  };
  TextEditingController otherServiceCategoryController = TextEditingController();

  // Section 2: Fleet / Vehicle Details
  TextEditingController vehicleIdController = TextEditingController();
  TextEditingController makeAndModelController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController yearOfManufactureController = TextEditingController();
  TextEditingController colourController = TextEditingController();
  TextEditingController passengerCapacityController = TextEditingController();
  TextEditingController vehicleDescriptionController = TextEditingController();
  TextEditingController bootsAndSpaceController = TextEditingController();
  bool _isSubmitting = false;

  // Section 3: Features, Benefits & Extras
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
  Map<String, TextEditingController> comfortLuxuryPrices = {}; // Removed price section
  Map<String, bool> eventsCustomisation = {
    'Red Carpet Service': false,
    'Champagne Packages': false,
    'Floral Décor': false,
    'Themed Interiors': false,
    'Photography Packages': false,
    'Party Packages': false,
  };
  Map<String, TextEditingController> eventsCustomisationPrices = {
    'Red Carpet Service': TextEditingController(),
    'Champagne Packages': TextEditingController(),
    'Floral Décor': TextEditingController(),
    'Themed Interiors': TextEditingController(),
    'Photography Packages': TextEditingController(),
    'Party Packages': TextEditingController(),
  };
  Map<String, bool> accessibilitySpecialServices = {
    'Wheelchair Access': false,
    'Child Car Seats': false,
    'Pet-Friendly Service': false,
    'Luggage Rack / Roof Box': false,
  };
  Map<String, TextEditingController> accessibilitySpecialServicesPrices = {
    'Wheelchair Access': TextEditingController(),
    'Child Car Seats': TextEditingController(),
    'Pet-Friendly Service': TextEditingController(),
    'Luggage Rack / Roof Box': TextEditingController(),
  };
  Map<String, bool> safetyCompliance = {
    'GPS Tracking': false,
    'CCTV Onboard': false,
    'Public Liability Insurance': false,
    'DBS Checked Drivers': false,
  };

  // Section 4: Coverage & Availability
  RxList<String> areasCovered = <String>[].obs;
  String? serviceStatus;

  // Section 5: Pricing Structure
  TextEditingController dayRateController = TextEditingController();
  TextEditingController mileageLimitController = TextEditingController(text: '100');
  TextEditingController extraMileageChargeController = TextEditingController();
  TextEditingController hourlyRateController = TextEditingController();
  TextEditingController halfDayRateController = TextEditingController();
  TextEditingController weddingPackageController = TextEditingController();
  TextEditingController airportTransferController = TextEditingController();
  bool fuelIncluded = false;

  // Section 6: Documents Required
  RxList<String> motCertificatePaths = <String>[].obs;
  RxList<String> driversLicencePaths = <String>[].obs;
  RxList<String> publicLiabilityInsurancePaths = <String>[].obs;
  RxList<String> operatorLicencePaths = <String>[].obs;
  RxList<String> insuranceCertificatePaths = <String>[].obs;
  RxList<String> vscRegistrationPaths = <String>[].obs;

  // Section 7: Photos & Media
  RxList<String> limousinePhotosPaths = <String>[].obs;
  TextEditingController promoVideoUrlController = TextEditingController();

  // Section 8: Service Availability Period
  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;

  // Section 9: Declaration & Agreement
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
    hourlyRateController.addListener(() {
      calendarController.setDefaultPrice(double.tryParse(hourlyRateController.text) ?? 0.0);
    });
    if (fromDate.value.isBefore(DateTime.now())) {
      fromDate.value = DateTime.now();
    }
    if (toDate.value.isBefore(DateTime.now())) {
      toDate.value = DateTime.now();
    }
    calendarController.fromDate.value = fromDate.value;
    calendarController.toDate.value = toDate.value;
  }

  @override
  void dispose() {
    serviceNameController.dispose();
    otherServiceCategoryController.dispose();
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
    calendarController.visibleDates.clear();
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

      if (motCertificatePaths.isNotEmpty) imageController.selectedImages.add(motCertificatePaths.first);
      if (driversLicencePaths.isNotEmpty) imageController.selectedImages.add(driversLicencePaths.first);
      if (publicLiabilityInsurancePaths.isNotEmpty) imageController.selectedImages.add(publicLiabilityInsurancePaths.first);
      if (operatorLicencePaths.isNotEmpty) imageController.selectedImages.add(operatorLicencePaths.first);
      if (insuranceCertificatePaths.isNotEmpty) imageController.selectedImages.add(insuranceCertificatePaths.first);
      if (vscRegistrationPaths.isNotEmpty) imageController.selectedImages.add(vscRegistrationPaths.first);
      if (limousinePhotosPaths.isNotEmpty) imageController.selectedImages.addAll(limousinePhotosPaths);

      for (var path in imageController.selectedImages) {
        await imageController.uploadToCloudinary(path);
      }

      int requiredDocs = 0;
      if (motCertificatePaths.isNotEmpty) requiredDocs++;
      if (driversLicencePaths.isNotEmpty) requiredDocs++;
      if (publicLiabilityInsurancePaths.isNotEmpty) requiredDocs++;
      if (operatorLicencePaths.isNotEmpty) requiredDocs++;
      if (insuranceCertificatePaths.isNotEmpty) requiredDocs++;
      if (vscRegistrationPaths.isNotEmpty) requiredDocs++;
      int additionalPhotos = limousinePhotosPaths.length;

      if (imageController.uploadedUrls.length != (requiredDocs + additionalPhotos)) {
        Get.snackbar(
          "Upload Error",
          "One or more documents failed to upload.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        return false;
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
      Get.snackbar("Validation Error", "Please fill all required fields correctly.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    if (!serviceCategories.values.any((v) => v)) {
      Get.snackbar("Missing Information", "Please select at least one service category.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }
    if (areasCovered.isEmpty) {
      Get.snackbar("Missing Information", "At least one area covered is required.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }
    final dayRate = double.tryParse(dayRateController.text.trim()) ?? 0;
    final mileageLimit = double.tryParse(mileageLimitController.text.trim()) ?? 0;
    final extraMileageCharge = double.tryParse(extraMileageChargeController.text.trim()) ?? 0;
    final hourlyRate = double.tryParse(hourlyRateController.text.trim()) ?? 0;
    final halfDayRate = double.tryParse(halfDayRateController.text.trim()) ?? 0;
    final weddingPackage = double.tryParse(weddingPackageController.text.trim()) ?? 0;
    final airportTransfer = double.tryParse(airportTransferController.text.trim()) ?? 0;
    if (dayRate == 0 && hourlyRate == 0 && halfDayRate == 0 && weddingPackage == 0 && airportTransfer == 0) {
      Get.snackbar("Missing Information", "At least one rate must be provided.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }
    if (limousinePhotosPaths.length < 2) {
      Get.snackbar("Missing Information", "At least 2 limousine photos are required.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }
    if (!agreeTerms || !noContactDetails || !agreeCookies || !agreePrivacy || !agreeCancellation) {
      Get.snackbar("Missing Information", "Please agree to all declarations.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
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
      "service_name": serviceNameController.text.trim(),
      "serviceCategories": {
        ...serviceCategories,
        "otherSpecified": serviceCategories['Other'] == true ? otherServiceCategoryController.text.trim() : ""
      },
      "fleetDetails": {
        "vehicleId": vehicleIdController.text.trim(),
        "makeAndModel": makeAndModelController.text.trim(),
        "type": typeController.text.trim(),
        "yearOfManufacture": yearOfManufactureController.text.trim(),
        "colour": colourController.text.trim(),
        "passengerCapacity": passengerCapacityController.text.trim(),
        "vehicleDescription": vehicleDescriptionController.text.trim(),
        "bootsAndSpace": bootsAndSpaceController.text.trim(),
      },
      "features": {
        "comfortLuxury": comfortLuxury,
        "eventsCustomisation": {
          for (var key in eventsCustomisation.keys) key: {'selected': eventsCustomisation[key]!, 'price': double.tryParse(eventsCustomisationPrices[key]!.text) ?? 0.0}
        },
        "accessibilitySpecialServices": {
          for (var key in accessibilitySpecialServices.keys) key: {'selected': accessibilitySpecialServices[key]!, 'price': double.tryParse(accessibilitySpecialServicesPrices[key]!.text) ?? 0.0}
        },
        "safetyCompliance": safetyCompliance,
      },
      "coverageAvailability": {
        "areasCovered": areasCovered.toList(),
        "serviceStatus": serviceStatus,
        "fromDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(fromDate.value),
        "toDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(toDate.value),
      },
      "pricing": {
        "dayRate": dayRate,
        "mileageLimit": mileageLimit,
        "extraMileageCharge": extraMileageCharge,
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        "weddingPackage": weddingPackage,
        "airportTransfer": airportTransfer,
        "fuelIncluded": fuelIncluded,
      },
      "documents": {
        "motCertificate": {
          "isAttached": motCertificatePaths.isNotEmpty,
          "image": motCertificatePaths.isNotEmpty ? imageController.uploadedUrls[0] : ""
        },
        "driversLicence": {
          "isAttached": driversLicencePaths.isNotEmpty,
          "image": driversLicencePaths.isNotEmpty ? imageController.uploadedUrls[motCertificatePaths.isNotEmpty ? 1 : 0] : ""
        },
        "publicLiabilityInsurance": {
          "isAttached": publicLiabilityInsurancePaths.isNotEmpty,
          "image": publicLiabilityInsurancePaths.isNotEmpty ? imageController.uploadedUrls[motCertificatePaths.isNotEmpty ? (driversLicencePaths.isNotEmpty ? 2 : 1) : 0] : ""
        },
        "operatorLicence": {
          "isAttached": operatorLicencePaths.isNotEmpty,
          "image": operatorLicencePaths.isNotEmpty ? imageController.uploadedUrls[motCertificatePaths.isNotEmpty ? (driversLicencePaths.isNotEmpty ? (publicLiabilityInsurancePaths.isNotEmpty ? 3 : 2) : 1) : 0] : ""
        },
        "insuranceCertificate": {
          "isAttached": insuranceCertificatePaths.isNotEmpty,
          "image": insuranceCertificatePaths.isNotEmpty ? imageController.uploadedUrls[motCertificatePaths.isNotEmpty ? (driversLicencePaths.isNotEmpty ? (publicLiabilityInsurancePaths.isNotEmpty ? (operatorLicencePaths.isNotEmpty ? 4 : 3) : 2) : 1) : 0] : ""
        },
        "vscRegistration": {
          "isAttached": vscRegistrationPaths.isNotEmpty,
          "image": vscRegistrationPaths.isNotEmpty ? imageController.uploadedUrls[motCertificatePaths.isNotEmpty ? (driversLicencePaths.isNotEmpty ? (publicLiabilityInsurancePaths.isNotEmpty ? (operatorLicencePaths.isNotEmpty ? (insuranceCertificatePaths.isNotEmpty ? 5 : 4) : 3) : 2) : 1) : 0] : ""
        },
      },
      "media": {
        "limousinePhotos": limousinePhotosPaths.isNotEmpty ? imageController.uploadedUrls.sublist(motCertificatePaths.length + driversLicencePaths.length + publicLiabilityInsurancePaths.length + operatorLicencePaths.length + insuranceCertificatePaths.length + vscRegistrationPaths.length) : [],
        "promoVideoUrl": promoVideoUrlController.text.trim(),
      },
      "serviceAvailability": {
        "fromDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(fromDate.value),
        "toDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(toDate.value),
      },
      "coupons": couponController.coupons.map((coupon) => {
        "coupon_code": coupon['coupon_code'] ?? "",
        "discount_type": coupon['discount_type'] ?? "",
        "discount_value": coupon['discount_value'] ?? 0,
        "usage_limit": coupon['usage_limit'] ?? 0,
        "current_usage_count": coupon['current_usage_count'] ?? 0,
        "expiry_date": coupon['expiry_date'] != null && coupon['expiry_date'].toString().isNotEmpty ? DateFormat('yyyy-MM-dd').format(DateTime.parse(coupon['expiry_date'].toString())) : "",
        "is_global": coupon['is_global'] ?? false
      }).toList(),
      "special_price_days": calendarController.specialPrices.map((e) => {
        "date": e['date'] != null ? DateFormat('yyyy-MM-dd').format(e['date'] as DateTime) : "",
        "price": e['price'] as double? ?? 0
      }).toList(),
      "isAccurateInfo": agreeTerms,
      "noContactDetailsShared": noContactDetails,
      "agreeCookiesPolicy": agreeCookies,
      "agreePrivacyPolicy": agreePrivacy,
      "agreeCancellationPolicy": agreeCancellation,
    };

    final api = AddVendorServiceApi();
    try {
      final isAdded = await api.addServiceVendor(data);
      if (isAdded) {
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
      setState(() {
        _isSubmitting = false;
      });
    }
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

  Widget _buildDocumentUploadSection(String title, RxList<String> documentPaths, bool isRequired) {
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
                          onTap: () {
                            documentPaths.removeAt(index);
                          },
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
                  setState(() {});
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
                  setState(() {});
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
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Text('Search by post code or city name...'),
              value: null,
              items: Cities.ukCities.map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Row(
                        children: [
                          Checkbox(
                            value: selectedCities.contains(city),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true && !selectedCities.contains(city)) {
                                  selectedCities.add(city);
                                } else if (value == false && selectedCities.contains(city)) {
                                  selectedCities.remove(city);
                                }
                              });
                            },
                          ),
                          Expanded(child: Text(city)),
                        ],
                      );
                    },
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  cityFetchController.onTextChanged(newValue);
                  if (!selectedCities.contains(newValue)) {
                    selectedCities.add(newValue);
                    setState(() {});
                  }
                }
              },
            ),
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
                  ? const Text('No cities selected', style: TextStyle(color: Colors.grey, fontSize: 16))
                  : Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: selectedCities
                          .map((city) => Chip(
                                label: Text(city, style: const TextStyle(fontSize: 14)),
                                deleteIcon: const Icon(Icons.close, size: 18),
                                onDeleted: () {
                                  setState(() {
                                    selectedCities.remove(city);
                                  });
                                },
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
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Service Category
                const Text(
                  'SECTION 1: Service Category',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Service Name *',
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
                    hinttext: "Enter your service name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Service Name is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Select all that apply *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 10,
                    children: serviceCategories.keys.map((category) => ChoiceChip(
                          label: Text(category),
                          selected: serviceCategories[category]!,
                          onSelected: (selected) {
                            setState(() {
                              serviceCategories[category] = selected;
                            });
                          },
                        )).toList(),
                  ),
                ),
                if (serviceCategories['Other']!) ...[
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Signup_textfilled(
                      length: 100,
                      textcont: otherServiceCategoryController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.text,
                      hinttext: "Specify other service categories",
                      validator: (value) {
                        if (serviceCategories['Other']! && (value == null || value.isEmpty)) {
                          return 'Please specify other service categories';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
                const SizedBox(height: 20),

                // Section 2: Fleet / Vehicle Details
                const Text(
                  'SECTION 2: Fleet / Vehicle Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  '(Complete one block per limousine model)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104)),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Vehicle ID *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 20,
                    textcont: vehicleIdController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Enter vehicle ID",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vehicle ID is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Make & Model *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 50,
                    textcont: makeAndModelController,
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
                ),
                const SizedBox(height: 10),
                const Text(
                  'Type *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 50,
                    textcont: typeController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "e.g., Stretch, SUV, H2",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Type is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Year of Manufacture',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 4,
                    textcont: yearOfManufactureController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Enter year",
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Colour',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 20,
                    textcont: colourController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Enter colour",
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Passenger Capacity *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 3,
                    textcont: passengerCapacityController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Number of passengers",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Passenger Capacity is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Vehicle Description for Listing *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 200,
                    textcont: vehicleDescriptionController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Describe the vehicle",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vehicle Description is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Boots & Space',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 50,
                    textcont: bootsAndSpaceController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "e.g., Large, 3 suitcases",
                  ),
                ),
                const SizedBox(height: 20),

                // Section 3: Features, Benefits & Extras
                const Text(
                  'SECTION 3: Features, Benefits & Extras',
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
                    children: comfortLuxury.keys.map((feature) => ChoiceChip(
                          label: Text(feature),
                          selected: comfortLuxury[feature]!,
                          onSelected: (selected) {
                            setState(() {
                              comfortLuxury[feature] = selected;
                            });
                          },
                        )).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Events & Customisation (With Pricing)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 10,
                    children: eventsCustomisation.keys.map((extra) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ChoiceChip(
                              label: Text(extra),
                              selected: eventsCustomisation[extra]!,
                              onSelected: (selected) {
                                setState(() {
                                  eventsCustomisation[extra] = selected;
                                });
                              },
                            ),
                            if (eventsCustomisation[extra]!) ...[
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 80,
                                child: TextField(
                                  controller: eventsCustomisationPrices[extra]!,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  decoration: const InputDecoration(
                                    hintText: 'Price (£)',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        )).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Accessibility & Special Services (With Pricing)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 10,
                    children: accessibilitySpecialServices.keys.map((service) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ChoiceChip(
                              label: Text(service),
                              selected: accessibilitySpecialServices[service]!,
                              onSelected: (selected) {
                                setState(() {
                                  accessibilitySpecialServices[service] = selected;
                                });
                              },
                            ),
                            if (accessibilitySpecialServices[service]!) ...[
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 80,
                                child: TextField(
                                  controller: accessibilitySpecialServicesPrices[service]!,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  decoration: const InputDecoration(
                                    hintText: 'Price (£)',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        )).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Safety & Compliance',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 10,
                    children: safetyCompliance.keys.map((compliance) => ChoiceChip(
                          label: Text(compliance),
                          selected: safetyCompliance[compliance]!,
                          onSelected: (selected) {
                            setState(() {
                              safetyCompliance[compliance] = selected;
                            });
                          },
                        )).toList(),
                  ),
                ),
                const SizedBox(height: 20),

                // Section 4: Coverage & Availability
                const Text(
                  'SECTION 4: Coverage & Availability',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildCitySelection('Areas Covered', areasCovered),
                const SizedBox(height: 20),
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

                // Section 5: Pricing Structure
                const Text(
                  'SECTION 5: Pricing Structure',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Each partner must offer a day hire rate (standard: 10 hours/100 miles)',
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
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
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
                    length: 5,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Extra Mileage Charge is required';
                      }
                      return null;
                    },
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                  ),
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
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Half-Day Rate (£) (5 Hours) *',
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
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Wedding Package (£)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 10,
                    textcont: weddingPackageController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Enter wedding package rate",
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Airport Transfer (£)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 10,
                    textcont: airportTransferController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.number,
                    hinttext: "Enter airport transfer rate",
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Fuel Included?',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CustomCheckbox(
                        title: 'Yes',
                        value: fuelIncluded,
                        onChanged: (value) {
                          setState(() {
                            fuelIncluded = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomCheckbox(
                        title: 'No',
                        value: !fuelIncluded,
                        onChanged: (value) {
                          setState(() {
                            fuelIncluded = !value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Section 6: Documents Required
                const Text(
                  'SECTION 6: Documents Required',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Upload scanned copies or clear photos',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104)),
                ),
                const SizedBox(height: 10),
                _buildDocumentUploadSection("MOT Certificate (if vehicle > 3 years old)", motCertificatePaths, false),
                _buildDocumentUploadSection("Driver's Licence (if chauffeur provided)", driversLicencePaths, false),
                _buildDocumentUploadSection("Public Liability Insurance", publicLiabilityInsurancePaths, false),
                _buildDocumentUploadSection("Operator's Licence (if required)", operatorLicencePaths, false),
                _buildDocumentUploadSection("Insurance Certificate (Hire & Reward)", insuranceCertificatePaths, false),
                _buildDocumentUploadSection("VSC / Registration Document", vscRegistrationPaths, false),
                const SizedBox(height: 20),

                // Section 7: Photos & Media
                const Text(
                  'SECTION 7: Photos & Media',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Upload ≥5 high-quality images (exterior front/back, interior, seating, feature shots)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104)),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Upload Photos of Your Limousines *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
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
                ),
                const SizedBox(height: 20),
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
                                limousinePhotosPaths.add(imageController.selectedImages.last);
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
                                limousinePhotosPaths.add(imageController.selectedImages.last);
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
                      height: 150,
                      width: double.infinity,
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cloud_upload, color: Colors.grey, size: 30),
                            SizedBox(height: 8),
                            Text(
                              'Click to upload PNG, JPG or JPEG',
                              style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '(Optional) Promo Video or YouTube link:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 200,
                    textcont: promoVideoUrlController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Enter video URL",
                  ),
                ),
                const SizedBox(height: 20),

                // Section 8: Service Availability Period
                const Text(
                  'SECTION 8: Service Availability Period',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Select the period during which your service will be available.',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104)),
                ),
                const SizedBox(height: 20),
                Obx(() => _buildDatePicker(context, "From", fromDate, true)),
                Obx(() => _buildDatePicker(context, "To", toDate, false)),
                const SizedBox(height: 10),
                Obx(() {
                  DateTime focusedDay = fromDate.value;
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

                // Section 9: Coupons / Discounts
                const Text(
                  "SECTION 9: Coupons / Discounts",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: w * 0.45,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Get.dialog(AddCouponDialog()),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.green),
                    ),
                    child: const Text("Add Coupon", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => couponController.coupons.isEmpty ? const SizedBox.shrink() : CouponList()),
                const SizedBox(height: 20),

                // Section 10: Declaration & Agreement
                const Text(
                  'SECTION 10: Declaration & Agreement',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomCheckbox(
                    title: 'I confirm that all information provided is accurate and current. *',
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
                    title: 'I have not shared any contact details (Email, Phone, Skype, Website, etc.). *',
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
                    title: 'I agree to the Cookies Policy. *',
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
                    title: 'I agree to the Privacy Policy. *',
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
                    title: 'I agree to the Cancellation Fee Policy. *',
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

                // Submit Button
                Container(
                  width: w,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isSubmitting
                        ? null
                        : () {
                            if (!_formKey.currentState!.validate()) {
                              Get.snackbar(
                                "Validation Error",
                                "Please fill all required fields correctly.",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.redAccent,
                                colorText: Colors.white,
                                duration: const Duration(seconds: 3),
                                icon: const Icon(Icons.warning, color: Colors.white),
                                margin: const EdgeInsets.all(10),
                              );
                              return;
                            }
                            if (!serviceCategories.values.any((v) => v)) {
                              Get.snackbar("Missing Information", "Please select at least one service category.",
                                  snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                              return;
                            }
                            if (areasCovered.isEmpty) {
                              Get.snackbar("Missing Information", "At least one area covered is required.",
                                  snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                              return;
                            }
                            final dayRate = double.tryParse(dayRateController.text.trim()) ?? 0;
                            final mileageLimit = double.tryParse(mileageLimitController.text.trim()) ?? 0;
                            final extraMileageCharge = double.tryParse(extraMileageChargeController.text.trim()) ?? 0;
                            final hourlyRate = double.tryParse(hourlyRateController.text.trim()) ?? 0;
                            final halfDayRate = double.tryParse(halfDayRateController.text.trim()) ?? 0;
                            final weddingPackage = double.tryParse(weddingPackageController.text.trim()) ?? 0;
                            final airportTransfer = double.tryParse(airportTransferController.text.trim()) ?? 0;
                            if (dayRate == 0 && hourlyRate == 0 && halfDayRate == 0 && weddingPackage == 0 && airportTransfer == 0) {
                              Get.snackbar("Missing Information", "At least one rate must be provided.",
                                  snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                              return;
                            }
                            if (limousinePhotosPaths.length < 2) {
                              Get.snackbar("Missing Information", "At least 2 limousine photos are required.",
                                  snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                              return;
                            }
                            if (!agreeTerms || !noContactDetails || !agreeCookies || !agreePrivacy || !agreeCancellation) {
                              Get.snackbar("Missing Information", "Please agree to all declarations.",
                                  snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 3), icon: const Icon(Icons.warning, color: Colors.white), margin: const EdgeInsets.all(10));
                              return;
                            }
                            setState(() {
                              _isSubmitting = true;
                            });
                            _submitForm();
                            setState(() {
                              _isSubmitting = false;
                            });
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
                            "Submit Limousine Service",
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