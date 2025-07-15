import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/signup_textfilled.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/custom_checkbox.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/custom_dropdown.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupon_list.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupondialog.dart';
import 'package:hire_any_thing/Vendor_App/view/edit_passenger_services/boat_hire_edit/controller/boat_hire_edit_controller.dart';
import 'package:hire_any_thing/constants_file/uk_cities.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:intl/intl.dart';

class BoatHireEditScreen extends StatelessWidget {
  final String serviceId;

  BoatHireEditScreen({super.key, required this.serviceId});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final controller = Get.put(BoatHireEditController(serviceId: serviceId), tag: serviceId); // Pass serviceId here

    return Scaffold(
      backgroundColor: colors.scaffold_background_color,
      appBar: AppBar(
        backgroundColor: colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Edit Boat Hire Service', style: TextStyle(fontWeight: FontWeight.bold, color: colors.black)),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Business Information
                const Text('SECTION 1: Business Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Service Name *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 50,
                  textcont: controller.serviceNameController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Service Name",
                  validator: (value) => value?.isEmpty ?? true ? 'Service Name is required' : null,
                ),
                const SizedBox(height: 20),

                // Section 2: Boat Hire Service Details
                const Text('SECTION 2: Boat Hire Service Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Types of Boats Available *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: controller.boatTypes.entries.map((entry) => Obx(() => ChoiceChip(
                    label: Text(entry.key),
                    selected: entry.value.value,
                    onSelected: (selected) => entry.value.value = selected,
                  ))).toList(),
                ),
                if (controller.boatTypes['other']!.value) ...[
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 100,
                    textcont: controller.otherBoatTypeController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Please specify other boat type",
                    validator: (value) => controller.boatTypes['other']!.value && (value?.isEmpty ?? true) ? 'Please specify other boat type' : null,
                  ),
                ],
                const SizedBox(height: 20),
                const Text('Typical Use Cases *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: controller.typicalUseCases.entries.map((entry) => Obx(() => ChoiceChip(
                    label: Text(entry.key),
                    selected: entry.value.value,
                    onSelected: (selected) => entry.value.value = selected,
                  ))).toList(),
                ),
                if (controller.typicalUseCases['other']!.value) ...[
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 100,
                    textcont: controller.otherUseCaseController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Please specify other use case",
                    validator: (value) => controller.typicalUseCases['other']!.value && (value?.isEmpty ?? true) ? 'Please specify other use case' : null,
                  ),
                ],
                const SizedBox(height: 20),

                // Section 3: Fleet Information
                const Text('SECTION 3: Fleet Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Number of Boats in Fleet *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 10,
                  textcont: controller.fleetSizeController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter number of boats",
                  validator: (value) => value?.isEmpty ?? true ? 'Fleet size is required' : null,
                ),
                const SizedBox(height: 10),
                const Text('Boat Name *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 50,
                  textcont: controller.boatNameController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Boat Name",
                  validator: (value) => value?.isEmpty ?? true ? 'Boat name is required' : null,
                ),
                const SizedBox(height: 10),
                const Text('Boat Type *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 50,
                  textcont: controller.boatTypeController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Boat Type",
                  validator: (value) => value?.isEmpty ?? true ? 'Boat type is required' : null,
                ),
                const SizedBox(height: 10),
                const Text('Onboard Features *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 100,
                  textcont: controller.onboardFeaturesController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Onboard Features",
                  validator: (value) => value?.isEmpty ?? true ? 'Onboard features are required' : null,
                ),
                const SizedBox(height: 10),
                const Text('Capacity *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 10,
                  textcont: controller.capacityController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter Capacity",
                  validator: (value) => value?.isEmpty ?? true ? 'Capacity is required' : null,
                ),
                const SizedBox(height: 10),
                const Text('Year *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 4,
                  textcont: controller.yearController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter Year",
                  validator: (value) => value?.isEmpty ?? true ? 'Year is required' : null,
                ),
                const SizedBox(height: 10),
                const Text('Notes', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 200,
                  textcont: controller.notesController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Notes",
                ),
                const SizedBox(height: 20),

                // Section 4: Locations & Booking Info
                const Text('SECTION 4: Locations & Booking Info', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _buildCitySelection(context, controller, 'Primary Dock/Departure Point', true, controller.navigableRoutes, controller.departurePoints),
                const SizedBox(height: 20),
                _buildCitySelection(context, controller, 'Navigable Routes or Locations', false, controller.navigableRoutes, controller.departurePoints),
                const SizedBox(height: 20),
                const Text('Availability Period *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _buildDatePicker(context, controller, 'Start', controller.calenderController.fromDate, true)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildDatePicker(context, controller, 'End', controller.calenderController.toDate, false)),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Boat Rates * (At least one rate is required)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Hourly Rate *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 10,
                  textcont: controller.hourlyRateController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter Hourly Rate (£)",
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                ),
                const SizedBox(height: 10),
                const Text('Half-Day Rate *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 10,
                  textcont: controller.halfDayRateController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter Half-Day Rate (£)",
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                ),
                const SizedBox(height: 10),
                const Text('Full-Day Rate *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 10,
                  textcont: controller.fullDayRateController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter Full-Day Rate (£)",
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                ),
                const SizedBox(height: 10),
                const Text('Overnight Charter Rate *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 10,
                  textcont: controller.overnightCharterRateController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter Overnight Charter Rate (£)",
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                ),
                const SizedBox(height: 10),
                const Text('Package Deals Description', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 500,
                  textcont: controller.packageDealsController,
                  textfilled_height: 10,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Describe Package Deals",
                ),
                const SizedBox(height: 20),
                const Text('Additional Info', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Advance Booking Requirement *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Obx(() => CustomDropdown(
                  hintText: "Select Option",
                  items: ['2+ Weeks', '48 hours', '1 Week'],
                  selectedValue: controller.advanceBooking.value,
                  onChanged: (value) => controller.advanceBooking.value = value ?? '',
                )),
                const SizedBox(height: 20),
                const Text('Availability *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: Obx(() => CustomCheckbox(title: 'Year-Round', value: controller.yearRound.value, onChanged: (value) => controller.yearRound.value = value!))),
                    const SizedBox(width: 20),
                    Expanded(child: Obx(() => CustomCheckbox(title: 'Seasonal', value: controller.seasonal.value, onChanged: (value) => controller.seasonal.value = value!))),
                  ],
                ),
                if (controller.seasonal.value) ...[
                  const SizedBox(height: 10),
                  const Text('Season Start Month *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Obx(() => CustomDropdown(hintText: "Select Start Month", items: controller.months, selectedValue: controller.seasonStart?.value, onChanged: (value) => controller.seasonStart?.value = value!)),
                  const SizedBox(height: 10),
                  const Text('Season End Month *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Obx(() => CustomDropdown(hintText: "Select End Month", items: controller.months, selectedValue: controller.seasonEnd?.value, onChanged: (value) => controller.seasonEnd?.value = value!)),
                ],
                const SizedBox(height: 20),
                const Text('Booking Options *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: controller.bookingOptions.entries.map((entry) => Obx(() => ChoiceChip(
                    label: Text(entry.key),
                    selected: entry.value.value,
                    onSelected: (selected) => entry.value.value = selected,
                  ))).toList(),
                ),
                const SizedBox(height: 20),
                Obx(() => CustomCheckbox(title: 'Catering & Entertainment Hire Options?', value: controller.cateringEntertainmentOffered.value, onChanged: (value) => controller.cateringEntertainmentOffered.value = value!)),
                if (controller.cateringEntertainmentOffered.value) ...[
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 500,
                    textfilled_height: 10,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Describe Catering & Entertainment",
                  ),
                ],
                const SizedBox(height: 20),
                Obx(() => CustomCheckbox(title: 'License Required?', value: controller.licenseRequired.value, onChanged: (value) => controller.licenseRequired.value = value!)),
                const SizedBox(height: 20),
                const Text('Hire Options *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Obx(() => CustomDropdown(
                  hintText: "Select Hire Option",
                  items: ['Skippered Only', 'Self Drive'],
                  selectedValue: controller.hireOption?.value,
                  onChanged: (value) {
                    controller.hireOption?.value = value!;
                    controller.hireOptionSkippered.value = value == 'Skippered Only';
                  },
                )),
                const SizedBox(height: 20),

                // Section 5: Licensing & Insurance
                const Text('SECTION 5: Licensing & Insurance', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Public Liability Insurance Provider *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 100,
                  textcont: controller.publicLiabilityInsuranceProviderController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Public Liability Insurance Provider",
                  validator: (value) => value?.isEmpty ?? true ? 'Public Liability Insurance Provider is required' : null,
                ),
                const SizedBox(height: 20),
                const Text('Vessel Insurance Provider *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 100,
                  textcont: controller.vesselInsuranceProviderController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Vessel Insurance Provider",
                  validator: (value) => value?.isEmpty ?? true ? 'Vessel Insurance Provider is required' : null,
                ),
                const SizedBox(height: 20),
                const Text('Insurance Provider *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 100,
                  textcont: controller.insuranceProviderController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Insurance Provider",
                  validator: (value) => value?.isEmpty ?? true ? 'Insurance Provider is required' : null,
                ),
                const SizedBox(height: 20),
                const Text('Policy Number *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 50,
                  textcont: controller.policyNumberController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Policy Number",
                  validator: (value) => value?.isEmpty ?? true ? 'Policy Number is required' : null,
                ),
                const SizedBox(height: 20),
                const Text('Policy Expiry Date *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2099, 12, 31),
                    );
                    if (picked != null) controller.policyExpiryDateController.text = DateFormat('dd-MM-yyyy').format(picked);
                  },
                  child: AbsorbPointer(
                    child: Signup_textfilled(
                      length: 10,
                      textcont: controller.policyExpiryDateController,
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      keytype: TextInputType.datetime,
                      hinttext: "dd-mm-yyyy",
                      validator: (value) => value?.isEmpty ?? true ? 'Policy Expiry Date is required' : null,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Cancellation Policy *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Obx(() => CustomDropdown(
                  hintText: "Select a Cancellation Policy",
                  items: controller.cancellationPolicyMap.keys.toList(),
                  selectedValue: controller.cancellationPolicyMap.entries.firstWhere((entry) => entry.value == controller.cancellationPolicy?.value, orElse: () => const MapEntry("", "")).key,
                  onChanged: (value) => controller.cancellationPolicy?.value = controller.cancellationPolicyMap[value] ?? '',
                )),
                const SizedBox(height: 20),

                // Section 6: Document Upload
                const Text('SECTION 6: Document Upload', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("Boat Photos *", style: TextStyle(color: Colors.black87, fontSize: 16)),
                const SizedBox(height: 10),
                Obx(() {
                  if (controller.boatPhotosPaths.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Image.network(
                            controller.boatPhotosPaths.first,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey[200],
                              child: const Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: () {
                                controller.boatPhotosPaths.clear();
                              },
                              child: const Icon(Icons.close, color: Colors.redAccent, size: 20),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
                const SizedBox(height: 10),
                _buildDocumentUploadSection(context, controller, "Boat Photos *", controller.boatPhotosPaths, true),
                const SizedBox(height: 20),
                _buildDocumentUploadSection(context, controller, "Boatmaster License *", controller.boatMasterLicencePaths, true),
                _buildDocumentUploadSection(context, controller, "Skipper Credentials *", controller.skipperCredentialsPaths, true),
                _buildDocumentUploadSection(context, controller, "Boat Safety Certificate *", controller.boatSafetyCertificatePaths, true),
                _buildDocumentUploadSection(context, controller, "Vessel Insurance Document *", controller.vesselInsuranceDocPaths, true),
                _buildDocumentUploadSection(context, controller, "Public Liability Insurance Document *", controller.publicLiabilityInsuranceDocPaths, true),
                _buildDocumentUploadSection(context, controller, "Local Authority Licence *", controller.localAuthorityLicencePaths, true),

                // Section 7: Business Highlights
                const Text('SECTION 7: Business Highlights', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('What makes your service unique or premium? *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 500,
                  textcont: controller.uniqueFeaturesController,
                  textfilled_height: 10,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter what makes your service unique",
                  validator: (value) => value?.isEmpty ?? true ? 'Unique features are required' : null,
                ),
                const SizedBox(height: 20),
                const Text('Promotional Description (max 100 words) *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 100,
                  textcont: controller.promotionalDescriptionController,
                  textfilled_height: 10,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter promotional description",
                  validator: (value) => value?.isEmpty ?? true ? 'Promotional description is required' : null,
                ),
                const SizedBox(height: 20),

                // Coupons / Discounts
                const Text("Coupons / Discounts", style: TextStyle(color: Colors.black87, fontSize: 18)),
                const SizedBox(height: 20),
                SizedBox(width: w * 0.45, height: 50, child: ElevatedButton(
                  onPressed: () => Get.dialog(AddCouponDialog()),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.green)),
                  child: const Text("Add Coupon", style: TextStyle(color: Colors.white)),
                )),
                const SizedBox(height: 20),
                Obx(() => controller.couponController.coupons.isEmpty ? const SizedBox.shrink() : CouponList()),
                const SizedBox(height: 20),

             
               

                // Submit Button
                Obx(() => Container(
                  width: w,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.isSubmitting.value
                        ? null
                        : () async {
                            if (formKey.currentState!.validate()) {
                              final data = {
                                "availability": {
                                  "yearRound": controller.yearRound.value,
                                  "seasonal": controller.seasonal.value,
                                  "seasonalMonths": controller.seasonal.value
                                      ? [controller.seasonStart?.value, controller.seasonEnd?.value]
                                      : [],
                                },
                                "boatRates": {
                                  "hourlyRate": double.tryParse(controller.hourlyRateController.text.trim()) ?? 0,
                                  "halfDayRate": double.tryParse(controller.halfDayRateController.text.trim()) ?? 0,
                                  "fullDayRate": double.tryParse(controller.fullDayRateController.text.trim()) ?? 0,
                                  "overnightCharterRate":
                                      double.tryParse(controller.overnightCharterRateController.text.trim()) ?? 0,
                                  "packageDealsDescription": controller.packageDealsController.text.trim(),
                                },
                                "boatTypes": {
                                  for (var entry in controller.boatTypes.entries) entry.key: entry.value.value,
                                  "otherSpecified": controller.boatTypes['other']!.value
                                      ? controller.otherBoatTypeController.text.trim()
                                      : "",
                                },
                                "bookingOptions": {
                                  for (var entry in controller.bookingOptions.entries) entry.key: entry.value.value,
                                },
                                "booking_date_from": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                    .format(controller.calenderController.fromDate.value),
                                "booking_date_to": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                    .format(controller.calenderController.toDate.value),
                                "cancellation_policy_type": controller.cancellationPolicy?.value,
                                "category": "PassengerTransport",
                                "categoryId": "676ac544234968d45b494992",
                                "cateringEntertainment": {
                                  "offered": controller.cateringEntertainmentOffered.value,
                                  "description": controller.cateringEntertainmentOffered.value
                                      ? "Describe Catering & Entertainment"
                                      : "",
                                },
                                "coupons": controller.couponController.coupons.value,
                                "departurePoints": controller.departurePoints.value,
                                "fleetInfo": {
                                  "boatName": controller.boatNameController.text.trim(),
                                  "type": controller.boatTypeController.text.trim(),
                                  "capacity": int.tryParse(controller.capacityController.text.trim()) ?? 0,
                                  "onboardFeatures": controller.onboardFeaturesController.text.trim(),
                                  "year": int.tryParse(controller.yearController.text.trim()) ?? 0,
                                  "notes": controller.notesController.text.trim(),
                                },
                                "fleetSize": int.tryParse(controller.fleetSizeController.text.trim()) ?? 0,
                                "hireOptions": controller.hireOption?.value,
                                "licenseRequired": controller.licenseRequired.value,
                                "licensing": {
                                  "publicLiabilityInsuranceProvider":
                                      controller.publicLiabilityInsuranceProviderController.text.trim(),
                                  "vesselInsuranceProvider":
                                      controller.vesselInsuranceProviderController.text.trim(),
                                  "insuranceProvider": controller.insuranceProviderController.text.trim(),
                                  "policyNumber": controller.policyNumberController.text.trim(),
                                  "expiryDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(
                                      DateFormat('dd-MM-yyyy')
                                          .parse(controller.policyExpiryDateController.text.trim())),
                                  "documents": {
                                    "boatMasterLicence": {
                                      "isAttached": controller.boatMasterLicencePaths.isNotEmpty,
                                      "image": controller.boatMasterLicencePaths.isNotEmpty
                                          ? controller.boatMasterLicencePaths.first
                                          : "",
                                    },
                                    "skipperCredentials": {
                                      "isAttached": controller.skipperCredentialsPaths.isNotEmpty,
                                      "image": controller.skipperCredentialsPaths.isNotEmpty
                                          ? controller.skipperCredentialsPaths.first
                                          : "",
                                    },
                                    "boatSafetyCertificate": {
                                      "isAttached": controller.boatSafetyCertificatePaths.isNotEmpty,
                                      "image": controller.boatSafetyCertificatePaths.isNotEmpty
                                          ? controller.boatSafetyCertificatePaths.first
                                          : "",
                                    },
                                    "localAuthorityLicence": {
                                      "isAttached": controller.localAuthorityLicencePaths.isNotEmpty,
                                      "image": controller.localAuthorityLicencePaths.isNotEmpty
                                          ? controller.localAuthorityLicencePaths.first
                                          : "",
                                    },
                                    "publicLiabilityInsurance": {
                                      "isAttached": controller.publicLiabilityInsuranceDocPaths.isNotEmpty,
                                      "image": controller.publicLiabilityInsuranceDocPaths.isNotEmpty
                                          ? controller.publicLiabilityInsuranceDocPaths.first
                                          : "",
                                    },
                                    "vesselInsurance": {
                                      "isAttached": controller.vesselInsuranceDocPaths.isNotEmpty,
                                      "image": controller.vesselInsuranceDocPaths.isNotEmpty
                                          ? controller.vesselInsuranceDocPaths.first
                                          : "",
                                    },
                                  },
                                },
                                "navigableRoutes": controller.navigableRoutes.value,
                                "offering_price": 0,
                                "promotionalDescription": controller.promotionalDescriptionController.text.trim(),
                                "service_name": controller.serviceNameController.text.trim(),
                                "service_type": "boat",
                                "sub_category": "Boat Hire",
                                "subcategoryId": "676ace13234968d45b4949db",
                                "typicalUseCases": {
                                  for (var entry in controller.typicalUseCases.entries)
                                    entry.key: entry.value.value,
                                  "otherSpecified": controller.typicalUseCases['other']!.value
                                      ? controller.otherUseCaseController.text.trim()
                                      : "",
                                },
                                "uniqueFeatures": controller.uniqueFeaturesController.text.trim(),
                                "vendorId": await SessionVendorSideManager().getVendorId(),
                                "_id": serviceId,
                              };
                              await controller.submitForm(data);
                            }
                          },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.green)),
                    child: controller.isSubmitting.value
                        ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                        : const Text("Update", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                )),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCitySelection(BuildContext context, BoatHireEditController controller, String title, bool isSingleSelection, RxList<String> selectedCities, RxString singleCity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title *',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        if (!isSingleSelection) ...[
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
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            children: [
              if (isSingleSelection)
                DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Search by post code or city name...'),
                  value: singleCity.value.isEmpty ? null : singleCity.value,
                  items: Cities.ukCities.map((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      singleCity.value = newValue;
                    }
                  },
                  underline: const SizedBox(),
                )
              else
                DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Search by post code or city name...'),
                  value: null,
                  items: Cities.ukCities.map((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Row(
                        children: [
                          Obx(() => Checkbox(
                            value: selectedCities.contains(city),
                            onChanged: (bool? value) {
                              if (value == true && !selectedCities.contains(city)) {
                                selectedCities.add(city);
                              } else if (value == false) {
                                selectedCities.remove(city);
                              }
                            },
                          )),
                          Expanded(child: Text(city)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                  underline: const SizedBox(),
                ),
            ],
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
              constraints: const BoxConstraints(
                minHeight: 50,
              ),
              child: isSingleSelection
                  ? singleCity.value.isEmpty
                      ? const Text(
                          'No city selected',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )
                      : Chip(
                          label: Text(
                            singleCity.value,
                            style: const TextStyle(fontSize: 14),
                          ),
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: () => singleCity.value = '',
                          backgroundColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                  : selectedCities.isEmpty
                      ? const Text(
                          'No cities selected',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
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
                                    deleteIcon: const Icon(Icons.close, size: 18),
                                    onDeleted: () => selectedCities.remove(city),
                                    backgroundColor: Colors.grey[200],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ))
                              .toList(),
                        ),
            )),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context, BoatHireEditController controller, String label, Rx<DateTime> date, bool isFromDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label Date',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: date.value,
              firstDate: DateTime.now(),
              lastDate: DateTime(2099, 12, 31),
            );
            if (picked != null) {
              date.value = picked;
              if (isFromDate) {
                controller.calenderController.updateDateRange(controller.calenderController.fromDate.value, controller.calenderController.toDate.value);
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
                Obx(() => Text(
                  DateFormat('dd/MM/yyyy').format(date.value),
                  style: const TextStyle(fontSize: 16),
                )),
                const Icon(Icons.calendar_today, color: Colors.grey),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDocumentUploadSection(BuildContext context, BoatHireEditController controller, String title, RxList<String> documentPaths, bool isRequired) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title${isRequired ? ' *' : ''}",
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(height: 16),
        Obx(() {
          if (documentPaths.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Image.network(
                    documentPaths.first,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey[200],
                      child: const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: GestureDetector(
                      onTap: () {
                        documentPaths.clear();
                      },
                      child: const Icon(Icons.close, color: Colors.redAccent, size: 20),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        }),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Get.bottomSheet(
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('Take a Photo'),
                    onTap: () async {
                      await controller.imageController.pickImages(true);
                      if (controller.imageController.selectedImages.isNotEmpty) {
                        documentPaths.value = [controller.imageController.selectedImages.last];
                        controller.imageController.selectedImages.removeLast();
                      }
                      Get.back();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Choose from Gallery'),
                    onTap: () async {
                      await controller.imageController.pickImages(false);
                      if (controller.imageController.selectedImages.isNotEmpty) {
                        documentPaths.value = [controller.imageController.selectedImages.last];
                        controller.imageController.selectedImages.removeLast();
                      }
                      Get.back();
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
}