import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/signup_textfilled.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/custom_checkbox.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/custom_dropdown.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupon_list.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupondialog.dart';
import 'package:hire_any_thing/Vendor_App/view/edit_passenger_services/horse_and_carriage_edit/controller/horse_and_carriage_controller.dart';
import 'package:hire_any_thing/constants_file/uk_cities.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:intl/intl.dart';

class HorseCarriageEditScreen extends StatelessWidget {
  final String serviceId;

  HorseCarriageEditScreen({super.key, required this.serviceId});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final controller = Get.put(HorseCarriageEditController(serviceId: serviceId), tag: serviceId);

    return Scaffold(
      backgroundColor: colors.scaffold_background_color,
      appBar: AppBar(
        backgroundColor: colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Edit Horse & Carriage Service', style: TextStyle(fontWeight: FontWeight.bold, color: colors.black)),
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

                const Text('SECTION 2: Horse & Carriage Service Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Carriage Types *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: controller.carriageTypes.entries.map((entry) => Obx(() => ChoiceChip(
                    label: Text(entry.key.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}').trim()),
                    selected: entry.value.value,
                    onSelected: (selected) => entry.value.value = selected,
                  ))).toList(),
                ),
                if (controller.carriageTypes['other']!.value) ...[
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 100,
                    textcont: controller.otherCarriageTypeController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Specify other carriage type",
                    validator: (value) => controller.carriageTypes['other']!.value && (value?.isEmpty ?? true) ? 'Specify other carriage type' : null,
                  ),
                ],
                const SizedBox(height: 20),
                const Text('Horse Types *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: controller.horseTypes.entries.map((entry) => Obx(() => ChoiceChip(
                    label: Text(entry.key.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}').trim()),
                    selected: entry.value.value,
                    onSelected: (selected) => entry.value.value = selected,
                  ))).toList(),
                ),
                if (controller.horseTypes['other']!.value) ...[
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 100,
                    textcont: controller.otherHorseTypeController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Specify other horse type",
                    validator: (value) => controller.horseTypes['other']!.value && (value?.isEmpty ?? true) ? 'Specify other horse type' : null,
                  ),
                ],
                const SizedBox(height: 20),
                const Text('Occasions *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: controller.occasions.entries.map((entry) => Obx(() => ChoiceChip(
                    label: Text(entry.key.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}').trim()),
                    selected: entry.value.value,
                    onSelected: (selected) => entry.value.value = selected,
                  ))).toList(),
                ),
                if (controller.occasions['other']!.value) ...[
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 100,
                    textcont: controller.otherOccasionController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Specify other occasion",
                    validator: (value) => controller.occasions['other']!.value && (value?.isEmpty ?? true) ? 'Specify other occasion' : null,
                  ),
                ],
                const SizedBox(height: 20),

                const Text('SECTION 3: Fleet Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Number of Carriages in Fleet *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 10,
                  textcont: controller.fleetSizeController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.number,
                  hinttext: "Enter number of carriages",
                  validator: (value) => value?.isEmpty ?? true ? 'Fleet size is required' : null,
                ),
                const SizedBox(height: 10),
                const Text('Carriage Type *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 50,
                  textcont: controller.carriageTypeController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Carriage Type",
                  validator: (value) => value?.isEmpty ?? true ? 'Carriage type is required' : null,
                ),
                const SizedBox(height: 10),
                const Text('Horse Type *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 50,
                  textcont: controller.horseTypeController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Horse Type",
                  validator: (value) => value?.isEmpty ?? true ? 'Horse type is required' : null,
                ),
                const SizedBox(height: 10),
                const Text('Onboard Decor *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  length: 100,
                  textcont: controller.onboardDecorController,
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  keytype: TextInputType.text,
                  hinttext: "Enter Onboard Decor",
                  validator: (value) => value?.isEmpty ?? true ? 'Onboard decor is required' : null,
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
                const SizedBox(height: 20),

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
                const Text('Booking Options *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: controller.bookingOptions.entries.map((entry) => Obx(() => ChoiceChip(
                    label: Text(entry.key.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}').trim()),
                    selected: entry.value.value,
                    onSelected: (selected) => entry.value.value = selected,
                  ))).toList(),
                ),
                const SizedBox(height: 20),
                const Text('Advance Booking Requirement *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Obx(() => CustomDropdown(
                  hintText: "Select Option",
                  items: ['2+ Weeks', '48 hours', '1 Week'],
                  selectedValue: controller.advanceBooking.value,
                  onChanged: (value) => controller.advanceBooking.value = value ?? '',
                )),
                const SizedBox(height: 20),

                const Text('SECTION 5: Equipment & Safety', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Obx(() => CustomCheckbox(
                  title: 'Are carriages regularly maintained and safety-checked?',
                  value: controller.regularMaintenance.value,
                  onChanged: (value) => controller.regularMaintenance.value = value!,
                )),
                if (controller.regularMaintenance.value) ...[
                  const SizedBox(height: 10),
                  const Text('Safety Checks *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: controller.safetyChecks.entries.map((entry) => Obx(() => ChoiceChip(
                      label: Text(entry.key.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}').trim()),
                      selected: entry.value.value,
                      onSelected: (selected) => entry.value.value = selected,
                    ))).toList(),
                  ),
                  const SizedBox(height: 10),
                  const Text('How Often *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 50,
                    textcont: controller.maintenanceFrequencyController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Enter frequency (e.g., Optional / Themed upon request)",
                    validator: (value) => controller.regularMaintenance.value && (value?.isEmpty ?? true) ? 'Maintenance frequency is required' : null,
                  ),
                  const SizedBox(height: 10),
                  const Text('Animal Welfare Standards *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: controller.animalWelfareStandards.entries.map((entry) => Obx(() => ChoiceChip(
                      label: Text(entry.key.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}').trim()),
                      selected: entry.value.value,
                      onSelected: (selected) => entry.value.value = selected,
                    ))).toList(),
                  ),
                ],
                const SizedBox(height: 20),

                const Text('SECTION 6: Accessibility Services', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: controller.accessibilityServices.entries.map((entry) => Obx(() => ChoiceChip(
                    label: Text(entry.key.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}').trim()),
                    selected: entry.value.value,
                    onSelected: (selected) => entry.value.value = selected,
                  ))).toList(),
                ),
                const SizedBox(height: 20),

                const Text('SECTION 7: Licensing & Insurance', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Obx(() => CustomCheckbox(title: 'Do you hold Public Liability Insurance?', value: controller.publicLiabilityInsurance.value, onChanged: (value) => controller.publicLiabilityInsurance.value = value!)),
                if (controller.publicLiabilityInsurance.value) ...[
                  const SizedBox(height: 10),
                  const Text('Public Liability Insurance Provider *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 100,
                    textcont: controller.publicLiabilityInsuranceProviderController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Enter Provider",
                    validator: (value) => controller.publicLiabilityInsurance.value && (value?.isEmpty ?? true) ? 'Provider is required' : null,
                  ),
                  const SizedBox(height: 10),
                  const Text('Policy Number *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 50,
                    textcont: controller.policyNumberController,
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Enter Policy Number",
                    validator: (value) => controller.publicLiabilityInsurance.value && (value?.isEmpty ?? true) ? 'Policy number is required' : null,
                  ),
                  const SizedBox(height: 10),
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
                        validator: (value) => controller.publicLiabilityInsurance.value && (value?.isEmpty ?? true) ? 'Expiry date is required' : null,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                Obx(() => CustomCheckbox(title: 'Do you hold a Performing Animal Licence (if applicable)?', value: controller.performingAnimalLicence.value, onChanged: (value) => controller.performingAnimalLicence.value = value!)),
                if (controller.performingAnimalLicence.value) ...[
                  const SizedBox(height: 10),
                  _buildDocumentUploadSection(context, controller, "Performing Animal Licence *", controller.performingAnimalLicencePaths, true),
                  const SizedBox(height: 10),
                  const Text('Issuing Authority *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Signup_textfilled(
                    length: 100,
                    textcont: TextEditingController(text: controller.issuingAuthority.value),
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    keytype: TextInputType.text,
                    hinttext: "Enter Issuing Authority",
                    validator: (value) => controller.performingAnimalLicence.value && (value?.isEmpty ?? true) ? 'Issuing authority is required' : null,
                    onChanged: (value) => controller.issuingAuthority.value = value,
                  ),
                ],
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

                const Text('SECTION 8: Document Upload', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _buildDocumentUploadSection(context, controller, "Carriage Photos *", controller.carriagePhotosPaths, true),
                const SizedBox(height: 20),
                _buildDocumentUploadSection(context, controller, "Horse Photos *", controller.horsePhotosPaths, true),
                if (controller.publicLiabilityInsurance.value) ...[
                  const SizedBox(height: 20),
                  _buildDocumentUploadSection(context, controller, "Public Liability Insurance Document *", controller.publicLiabilityInsuranceDocPaths, true),
                ],

                const Text('SECTION 9: Business Highlights', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                                  "booking_date_from": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(controller.calenderController.fromDate.value),
                                  "booking_date_to": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(controller.calenderController.toDate.value),
                                },
                                "carriageTypes": {
                                  for (var entry in controller.carriageTypes.entries) entry.key: entry.value.value,
                                  "otherSpecified": controller.carriageTypes['other']!.value ? controller.otherCarriageTypeController.text.trim() : "",
                                },
                                "horseTypes": {
                                  for (var entry in controller.horseTypes.entries) entry.key: entry.value.value,
                                  "otherSpecified": controller.horseTypes['other']!.value ? controller.otherHorseTypeController.text.trim() : "",
                                },
                                "occasions": {
                                  for (var entry in controller.occasions.entries) entry.key: entry.value.value,
                                  "otherSpecified": controller.occasions['other']!.value ? controller.otherOccasionController.text.trim() : "",
                                },
                                "bookingOptions": {
                                  for (var entry in controller.bookingOptions.entries) entry.key: entry.value.value,
                                },
                                "cancellation_policy_type": controller.cancellationPolicy?.value,
                                "category": "PassengerTransport",
                                "categoryId": "676ac544234968d45b494992",
                                "departurePoints": controller.departurePoints.value,
                                "equipmentSafety": {
                                  "regularMaintenance": controller.regularMaintenance.value,
                                  "safetyChecks": {
                                    for (var entry in controller.safetyChecks.entries) entry.key: entry.value.value,
                                  },
                                  "maintenanceFrequency": controller.regularMaintenance.value ? controller.maintenanceFrequencyController.text.trim() : "",
                                  "animalWelfareStandards": {
                                    for (var entry in controller.animalWelfareStandards.entries) entry.key: entry.value.value,
                                  },
                                },
                                "fleetInfo": {
                                  "carriageType": controller.carriageTypeController.text.trim(),
                                  "horseType": controller.horseTypeController.text.trim(),
                                  "onboardDecor": controller.onboardDecorController.text.trim(),
                                  "capacity": int.tryParse(controller.capacityController.text.trim()) ?? 0,
                                },
                                "fleetSize": int.tryParse(controller.fleetSizeController.text.trim()) ?? 0,
                                "accessibilityServices": {
                                  for (var entry in controller.accessibilityServices.entries) entry.key: entry.value.value,
                                },
                                "licensing": {
                                  "publicLiabilityInsurance": controller.publicLiabilityInsurance.value,
                                  "publicLiabilityInsuranceProvider": controller.publicLiabilityInsurance.value ? controller.publicLiabilityInsuranceProviderController.text.trim() : "",
                                  "policyNumber": controller.publicLiabilityInsurance.value ? controller.policyNumberController.text.trim() : "",
                                  "expiryDate": controller.publicLiabilityInsurance.value ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateFormat('dd-MM-yyyy').parse(controller.policyExpiryDateController.text.trim())) : "",
                                  "performingAnimalLicence": controller.performingAnimalLicence.value,
                                  "issuingAuthority": controller.performingAnimalLicence.value ? controller.issuingAuthority.value : "",
                                  "documents": {
                                    "publicLiabilityInsurance": {
                                      "isAttached": controller.publicLiabilityInsuranceDocPaths.isNotEmpty,
                                      "image": controller.publicLiabilityInsuranceDocPaths.isNotEmpty ? controller.publicLiabilityInsuranceDocPaths.first : "",
                                    },
                                    "performingAnimalLicence": {
                                      "isAttached": controller.performingAnimalLicencePaths.isNotEmpty,
                                      "image": controller.performingAnimalLicencePaths.isNotEmpty ? controller.performingAnimalLicencePaths.first : "",
                                    },
                                  },
                                },
                                "navigableRoutes": controller.navigableRoutes.value,
                                "promotionalDescription": controller.promotionalDescriptionController.text.trim(),
        "service_name": controller.serviceNameController.text.trim(),
        "service_type": "horse_carriage",
        "sub_category": "Horse & Carriage Hire",
        "subcategoryId": "676ace13234968d45b4949db",
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

  Widget _buildCitySelection(BuildContext context, HorseCarriageEditController controller, String title, bool isSingleSelection, RxList<String> selectedCities, RxString singleCity) {
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

  Widget _buildDatePicker(BuildContext context, HorseCarriageEditController controller, String label, Rx<DateTime> date, bool isFromDate) {
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

  Widget _buildDocumentUploadSection(BuildContext context, HorseCarriageEditController controller, String title, RxList<String> documentPaths, bool isRequired) {
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