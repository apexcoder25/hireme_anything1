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
   final CalendarController calenderController = Get.put(CalendarController());
  final CityFetchController cityFetchController = Get.put(CityFetchController());

  // Section 1: Service Category
  TextEditingController serviceNameController = TextEditingController();
  Map<String, bool> serviceCategories = {
    'Local Group Transport': false,
    'Airport Transfers': false,
    'School Trips': false,
    'Corporate Transport': false,
    'Event/Wedding Shuttles': false,
    'Day Tours': false,
    'Contract Hire': false,
    'Accessible Minibus Hire': false,
    'Other': false,
  };
  TextEditingController otherServiceCategoryController = TextEditingController();

  // Section 2: Fleet / Vehicle Details
  TextEditingController basePostcodeController = TextEditingController();
  TextEditingController makeAndModelController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController availableMinibusesController = TextEditingController();
  bool airConditioning = false;
  bool wheelchairAccessible = false;
  bool luggageSpace = false;
  bool seatBeltsAllVehicles = false;
  String foodDrinksAllowed = 'Select Option';
   final Map<String, String> cancellationPolicyMap = {
    'Flexible-Full refund if canceled 48+ hours in advance': 'FLEXIBLE',
    'Moderate-Full refund if canceled 72+ hours in advance': 'MODERATE',
    'Strict-Full refund if canceled 7+ days in advance': 'STRICT',
  };

  // Section 3: Booking Types
  Map<String, bool> bookingTypes = {
    'One Way': false,
    'Return': false,
    'Hourly Hire': false,
    'Daily Long Term Hire': false,
    'Contractual': false,
  };

  // Section 4: Pricing Structure
  TextEditingController hourlyRateController = TextEditingController();
  TextEditingController halfDayRateController = TextEditingController();
  TextEditingController fullDayRateController = TextEditingController();
  TextEditingController mileageAllowanceController = TextEditingController();
  TextEditingController additionalMileageFeeController = TextEditingController();

  // Section 5: Coverage & Availability
  RxList<String> areasCovered = <String>[].obs;
  String? serviceStatus;
  bool available24x7 = false;
  TextEditingController operatingHoursController = TextEditingController();
  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;

  // Section 6: Documents Required
  RxList<String> operatorLicencePaths = <String>[].obs;
  RxList<String> driversLicencePaths = <String>[].obs;
  RxList<String> publicLiabilityInsurancePaths = <String>[].obs;
  RxList<String> vehicleInsuranceAndMOTsPaths = <String>[].obs;
  RxList<String> dbsCertificatesPaths = <String>[].obs;
  RxList<String> minibusPhotosPaths = <String>[].obs;

  // Section 7: Driver Details
  bool fullyLicensedInsured = false;
  bool dbsChecked = false;
  String dressCode = 'Formal';
   String? vendorId;

  // Section 8: Cancellation Policy
  String cancellationPolicy = 'Select a Cancellation Policy';

  // Section 9: Licensing & Documents
  TextEditingController privateHireOperatorLicenceNumberController = TextEditingController();
  TextEditingController licensingAuthorityController = TextEditingController();
  TextEditingController publicLiabilityInsuranceProviderController = TextEditingController();
  TextEditingController policyNumberController = TextEditingController();
  Rx<DateTime> expiryDate = DateTime.now().obs;

  bool _isSubmitting = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadVendorId();
    hourlyRateController.addListener(() {
      calenderController.setDefaultPrice(double.tryParse(hourlyRateController.text) ?? 0.0);
    });
    if (fromDate.value.isBefore(DateTime.now())) {
      fromDate.value = DateTime.now();
    }
    if (toDate.value.isBefore(DateTime.now())) {
      toDate.value = DateTime.now();
    }
    calenderController.fromDate.value = fromDate.value;
    calenderController.toDate.value = toDate.value;
  }

  @override
  void dispose() {
    serviceNameController.dispose();
    otherServiceCategoryController.dispose();
    basePostcodeController.dispose();
    makeAndModelController.dispose();
    yearController.dispose();
    capacityController.dispose();
    notesController.dispose();
    availableMinibusesController.dispose();
    hourlyRateController.dispose();
    halfDayRateController.dispose();
    fullDayRateController.dispose();
    mileageAllowanceController.dispose();
    additionalMileageFeeController.dispose();
    operatingHoursController.dispose();
    privateHireOperatorLicenceNumberController.dispose();
    licensingAuthorityController.dispose();
    publicLiabilityInsuranceProviderController.dispose();
    policyNumberController.dispose();
    hourlyRateController.removeListener(() {});
    imageController.selectedImages.clear();
    imageController.uploadedUrls.clear();
    operatorLicencePaths.clear();
    driversLicencePaths.clear();
    publicLiabilityInsurancePaths.clear();
    vehicleInsuranceAndMOTsPaths.clear();
    dbsCertificatesPaths.clear();
    minibusPhotosPaths.clear();
    couponController.coupons.clear();
    calenderController.specialPrices.clear();
    calenderController.visibleDates.clear();
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

      if (operatorLicencePaths.isNotEmpty) imageController.selectedImages.add(operatorLicencePaths.first);
      if (driversLicencePaths.isNotEmpty) imageController.selectedImages.add(driversLicencePaths.first);
      if (publicLiabilityInsurancePaths.isNotEmpty) imageController.selectedImages.add(publicLiabilityInsurancePaths.first);
      if (vehicleInsuranceAndMOTsPaths.isNotEmpty) imageController.selectedImages.add(vehicleInsuranceAndMOTsPaths.first);
      if (dbsCertificatesPaths.isNotEmpty) imageController.selectedImages.add(dbsCertificatesPaths.first);
      if (minibusPhotosPaths.isNotEmpty) imageController.selectedImages.addAll(minibusPhotosPaths);

      for (var path in imageController.selectedImages) {
        await imageController.uploadToCloudinary(path);
      }

      int requiredDocs = 0;
      if (operatorLicencePaths.isNotEmpty) requiredDocs++;
      if (driversLicencePaths.isNotEmpty) requiredDocs++;
      if (publicLiabilityInsurancePaths.isNotEmpty) requiredDocs++;
      if (vehicleInsuranceAndMOTsPaths.isNotEmpty) requiredDocs++;
      if (dbsCertificatesPaths.isNotEmpty) requiredDocs++;
      int additionalPhotos = minibusPhotosPaths.length;

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
    final hourlyRate = double.tryParse(hourlyRateController.text.trim()) ?? 0;
    final halfDayRate = double.tryParse(halfDayRateController.text.trim()) ?? 0;
    final fullDayRate = double.tryParse(fullDayRateController.text.trim()) ?? 0;
    final mileageAllowance = double.tryParse(mileageAllowanceController.text.trim()) ?? 0;
    final additionalMileageFee = double.tryParse(additionalMileageFeeController.text.trim()) ?? 0;
    if (hourlyRate == 0 && halfDayRate == 0 && fullDayRate == 0) {
      Get.snackbar("Missing Information", "At least one rate must be provided.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }
    if (minibusPhotosPaths.length < 3) {
      Get.snackbar("Missing Information", "At least 3 minibus photos are required.",
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
        "basePostcode": basePostcodeController.text.trim(),
        "makeAndModel": makeAndModelController.text.trim(),
        "year": yearController.text.trim(),
        "capacity": capacityController.text.trim(),
        "notes": notesController.text.trim(),
        "availableMinibuses": availableMinibusesController.text.trim(),
        "airConditioning": airConditioning,
        "wheelchairAccessible": wheelchairAccessible,
        "luggageSpace": luggageSpace,
      },
      "bookingTypes": bookingTypes,
      "pricing": {
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        "fullDayRate": fullDayRate,
        "mileageAllowance": mileageAllowance,
        "additionalMileageFee": additionalMileageFee,
      },
      "comfortPolicy": {
        "seatBeltsAllVehicles": seatBeltsAllVehicles,
        "foodDrinksAllowed": foodDrinksAllowed,
      },
      "coverageAvailability": {
        "areasCovered": areasCovered.toList(),
        "serviceStatus": serviceStatus,
        "fromDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(fromDate.value),
        "toDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(toDate.value),
        "operatingHours": available24x7 ? "24x7" : operatingHoursController.text.trim(),
      },
      "driverDetails": {
        "fullyLicensedInsured": fullyLicensedInsured,
        "dbsChecked": dbsChecked,
        "dressCode": dressCode,
      },
      "cancellation_policy_type": cancellationPolicy ?? "FLEXIBLE",
      "licensingDocuments": {
        "privateHireOperatorLicenceNumber": privateHireOperatorLicenceNumberController.text.trim(),
        "licensingAuthority": licensingAuthorityController.text.trim(),
        "publicLiabilityInsuranceProvider": publicLiabilityInsuranceProviderController.text.trim(),
        "policyNumber": policyNumberController.text.trim(),
        "expiryDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(expiryDate.value),
      },
      "documents": {
        "operatorLicence": {"isAttached": operatorLicencePaths.isNotEmpty, "image": operatorLicencePaths.isNotEmpty ? imageController.uploadedUrls[0] : ""},
        "driversLicence": {"isAttached": driversLicencePaths.isNotEmpty, "image": driversLicencePaths.isNotEmpty ? imageController.uploadedUrls[operatorLicencePaths.isNotEmpty ? 1 : 0] : ""},
        "publicLiabilityInsurance": {"isAttached": publicLiabilityInsurancePaths.isNotEmpty, "image": publicLiabilityInsurancePaths.isNotEmpty ? imageController.uploadedUrls[operatorLicencePaths.isNotEmpty ? (driversLicencePaths.isNotEmpty ? 2 : 1) : 0] : ""},
        "vehicleInsuranceAndMOTs": {"isAttached": vehicleInsuranceAndMOTsPaths.isNotEmpty, "image": vehicleInsuranceAndMOTsPaths.isNotEmpty ? imageController.uploadedUrls[operatorLicencePaths.isNotEmpty ? (driversLicencePaths.isNotEmpty ? (publicLiabilityInsurancePaths.isNotEmpty ? 3 : 2) : 1) : 0] : ""},
        "dbsCertificates": {"isAttached": dbsCertificatesPaths.isNotEmpty, "image": dbsCertificatesPaths.isNotEmpty ? imageController.uploadedUrls[operatorLicencePaths.isNotEmpty ? (driversLicencePaths.isNotEmpty ? (publicLiabilityInsurancePaths.isNotEmpty ? (vehicleInsuranceAndMOTsPaths.isNotEmpty ? 4 : 3) : 2) : 1) : 0] : ""},
        "minibusPhotos": {"isAttached": minibusPhotosPaths.isNotEmpty, "images": minibusPhotosPaths.isNotEmpty ? imageController.uploadedUrls.sublist(operatorLicencePaths.length + driversLicencePaths.length + publicLiabilityInsurancePaths.length + vehicleInsuranceAndMOTsPaths.length + dbsCertificatesPaths.length) : []},
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
      "special_price_days": calenderController.specialPrices.map((e) => {
        "date": e['date'] != null ? DateFormat('yyyy-MM-dd').format(e['date'] as DateTime) : "",
        "price": e['price'] as double? ?? 0
      }).toList(),
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
    priceController.text = (calenderController.getPriceForDate(date)?.toString() ?? calenderController.defaultPrice.toString());

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
               calenderController.setSpecialPrice(date, price);
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
      final double price =calenderController.getPriceForDate(day);
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
                        calenderController.fromDate.value = date.value;
                          calenderController.updateDateRange(
                          calenderController.fromDate.value,
                          calenderController.toDate.value,
                        );
                      } else {
                        calenderController.toDate.value = date.value;
                        calenderController.updateDateRange(
                          calenderController.fromDate.value,
                          calenderController.toDate.value,
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
      child: Padding( // Ensure padding is correctly set here
        padding: const EdgeInsets.all(15.0), // Explicit padding value
        child: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Service Category
              const Text(
                'Minibus Hire Form',
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
                  hinttext: "Enter service name",
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
                'Services Offered *',
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
              const Text(
                'Base Postcode *',
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
                  keytype: TextInputType.text,
                  hinttext: "Enter postcode",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Base Postcode is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Section 2: Fleet / Vehicle Details
              const Text(
                'Fleet Information (For This Vehicle Only)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  hinttext: "Enter year",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Year is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Capacity *',
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
                  hinttext: "Enter capacity",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Capacity is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Air Conditioning *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomCheckbox(
                      title: 'Yes',
                      value: airConditioning,
                      onChanged: (value) {
                        setState(() {
                          airConditioning = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomCheckbox(
                      title: 'No',
                      value: !airConditioning,
                      onChanged: (value) {
                        setState(() {
                          airConditioning = !value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Wheelchair Accessible *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomCheckbox(
                      title: 'Yes',
                      value: wheelchairAccessible,
                      onChanged: (value) {
                        setState(() {
                          wheelchairAccessible = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomCheckbox(
                      title: 'No',
                      value: !wheelchairAccessible,
                      onChanged: (value) {
                        setState(() {
                          wheelchairAccessible = !value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Luggage Space *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomCheckbox(
                      title: 'Yes',
                      value: luggageSpace,
                      onChanged: (value) {
                        setState(() {
                          luggageSpace = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomCheckbox(
                      title: 'No',
                      value: !luggageSpace,
                      onChanged: (value) {
                        setState(() {
                          luggageSpace = !value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Notes',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 200,
                  textcont: notesController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter notes",
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Available Minibuses',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 10,
                  textcont: availableMinibusesController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter fleet size",
                ),
              ),
              const SizedBox(height: 20),

              // Section 3: Booking Types
              const Text(
                'Booking Types',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 10,
                  children: bookingTypes.keys.map((type) => ChoiceChip(
                        label: Text(type),
                        selected: bookingTypes[type]!,
                        onSelected: (selected) {
                          setState(() {
                            bookingTypes[type] = selected;
                          });
                        },
                      )).toList(),
                ),
              ),
              const SizedBox(height: 20),

              // Section 4: Pricing Structure
              const Text(
                'Rates',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Set your standard rates and mileage terms.',
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
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hourly Rate is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Half-Day Rate (£) * (Up to 4 hours)',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Half-Day Rate is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Full-Day Rate (£) * (Up to 10 hours)',
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
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Full-Day Rate is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Mileage Allowance (included miles) *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 5,
                  textcont: mileageAllowanceController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter included mileage",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mileage Allowance is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Additional Mileage Fee (£ per mile) *',
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
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Additional Mileage Fee is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Section 5: Vehicle Comfort & Policy
              const Text(
                'Vehicle Comfort & Policy',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CustomCheckbox(
                  title: 'Seat Belts in All Vehicles',
                  value: seatBeltsAllVehicles,
                  onChanged: (value) {
                    setState(() {
                      seatBeltsAllVehicles = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Are Food & Drinks Allowed? *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CustomDropdown(
                  hintText: "Select Option",
                  items: ['Yes', 'No', 'Select Option'],
                  selectedValue: foodDrinksAllowed,
                  onChanged: (value) {
                    setState(() {
                      foodDrinksAllowed = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Section 6: Coverage & Availability
              const Text(
                'Coverage & Availability',
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
              const Text(
                'Operating Hours',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomCheckbox(
                      title: 'Available 24x7',
                      value: available24x7,
                      onChanged: (value) {
                        setState(() {
                          available24x7 = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              if (!available24x7) ...[
                const SizedBox(height: 10),
                const Text(
                  'Specific Operating Hours *',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Signup_textfilled(
                    length: 50,
                    textcont: operatingHoursController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "e.g., Mon-Fri 8am-6pm",
                    validator: (value) {
                      if (!available24x7 && (value == null || value.isEmpty)) {
                        return 'Specific Operating Hours are required';
                      }
                      return null;
                    },
                  ),
                ),
              ],
              const SizedBox(height: 20),
              const Text(
                'Service Availability Period',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'Select the Period during which your service will be available',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104)),
              ),
              const SizedBox(height: 20),
              Obx(() => _buildDatePicker(context, "From", calenderController.fromDate, true)),
              Obx(() => _buildDatePicker(context, "To", calenderController.toDate, false)),
              const SizedBox(height: 10),
              Obx(() => TableCalendar(
                    onDaySelected: (selectedDay, focusedDay) {
                      if (calenderController.visibleDates.any((d) => isSameDay(d, selectedDay))) {
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
                        if (calenderController.visibleDates.any((d) => isSameDay(d, day))) {
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
                            final entry = calenderController.specialPrices[index];
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
                                        '£${price.toStringAsFixed(2)}/mile',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: price > 0 ? Colors.black : Colors.red,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        onPressed: () {
                                          calenderController.deleteSpecialPrice(date);
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

              // Section 7: Driver Details
              const Text(
                'Driver Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CustomCheckbox(
                  title: 'Fully Licensed & Insured',
                  value: fullyLicensedInsured,
                  onChanged: (value) {
                    setState(() {
                      fullyLicensedInsured = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CustomCheckbox(
                  title: 'DBS Checked',
                  value: dbsChecked,
                  onChanged: (value) {
                    setState(() {
                      dbsChecked = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Dress Code *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CustomDropdown(
                  hintText: "Select Dress Code",
                  items: ['Formal', 'Casual', 'Uniform'],
                  selectedValue: dressCode,
                  onChanged: (value) {
                    setState(() {
                      dressCode = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Section 8: Cancellation Policy
              const Text(
                'Cancellation Policy *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CustomDropdown(
                  hintText: "Select a Cancellation Policy",
                  items: cancellationPolicyMap.keys.toList(),
                  selectedValue: cancellationPolicyMap.entries.firstWhere((entry) => entry.value == cancellationPolicy, orElse: () => const MapEntry("", "")).key,
                  onChanged: (value) {
                    setState(() {
                      cancellationPolicy = cancellationPolicyMap[value] ?? "";
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Section 9: Licensing & Documents
              const Text(
                'Licensing & Documents',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Private Hire Operator Licence Number *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 20,
                  textcont: privateHireOperatorLicenceNumberController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter private hire operator licence number",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Private Hire Operator Licence Number is required';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Licensing Authority is required';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Public Liability Insurance Provider is required';
                    }
                    return null;
                  },
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
                  length: 20,
                  textcont: policyNumberController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter policy number",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Policy Number is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Expiry Date *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: expiryDate.value,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2099, 12, 31),
                        );
                        if (pickedDate != null) {
                          if (pickedDate.isBefore(DateTime.now())) {
                            Get.snackbar(
                              "Invalid Date",
                              "Please select a future date.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                            );
                            return;
                          }
                          expiryDate.value = pickedDate;
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
                              DateFormat('dd-MM-yyyy').format(expiryDate.value),
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
              _buildDocumentUploadSection("Operator Licence", operatorLicencePaths, true),
              _buildDocumentUploadSection("Driver Licences", driversLicencePaths, true),
              _buildDocumentUploadSection("Public Liability Insurance", publicLiabilityInsurancePaths, true),
              _buildDocumentUploadSection("Vehicle Insurance And MOTs", vehicleInsuranceAndMOTsPaths, true),
              _buildDocumentUploadSection("DBS Certificates", dbsCertificatesPaths, true),
              const SizedBox(height: 10),
              const Text(
                'Vehicle Images * (Upload minimum 3 images)',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0), // Ensure padding is correct
                child: Center(
                  child: Obx(() => Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: List.generate(minibusPhotosPaths.length, (index) {
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
                                  onTap: () => minibusPhotosPaths.removeAt(index),
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
                              minibusPhotosPaths.add(imageController.selectedImages.last);
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
                              minibusPhotosPaths.add(imageController.selectedImages.last);
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
                            'Click to upload or drag and drop PNG, JPG or JPEG',
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

              // Section 10: Business Highlights
              const Text(
                'Business Highlights',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Unique Features *',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'What makes your service reliable or unique? e.g., punctuality, eco-friendly fleet, partnerships, multilingual drivers',
                style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 109, 104, 104)),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Signup_textfilled(
                  length: 1000,
                  textcont: TextEditingController(),
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unique Features are required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Section 11: Coupons / Discounts
              const Text(
                "Coupons / Discounts",
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

              // Section 12: Declaration & Agreement
              const Text(
                'SECTION 12: Declaration & Agreement',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomCheckbox(
                  title: 'I agree to the Terms and Conditions',
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomCheckbox(
                  title: 'I have not shared any contact details (Email, Phone, Skype, Website etc.)',
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomCheckbox(
                  title: 'I agree to the Cookies Policy',
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomCheckbox(
                  title: 'I agree to the Privacy Policy',
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomCheckbox(
                  title: 'I agree to the Cancellation Fee Policy',
                  value: false,
                  onChanged: (value) {},
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
                          _submitForm();
                        },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.grey),
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
                          "Save & Submit",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
  ));
  }
}