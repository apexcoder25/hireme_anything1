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
import 'package:hire_any_thing/Vendor_App/view/edit_passenger_services/limousine_hire_edit/controller/limousine_hire_edit_controller.dart';
import 'package:hire_any_thing/constants_file/uk_cities.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class LimoHireEditScreen extends StatelessWidget {
  final String serviceId;

  LimoHireEditScreen({super.key, required this.serviceId});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final controller = Get.put(LimoHireEditController(serviceId: serviceId), tag: serviceId);

    return Scaffold(
      backgroundColor: colors.scaffold_background_color,
      appBar: AppBar(
        backgroundColor: colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit Limo Hire Service',
          style: TextStyle(fontWeight: FontWeight.bold, color: colors.black),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: colors.black),
        ),
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SECTION 1: Service Category
                      const Text('SECTION 1: Service Category', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      const Text('Service Name *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 50,
                        textcont: controller.serviceNameController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "Enter your service name",
                        validator: (value) => value?.isEmpty ?? true ? 'Service Name is required' : null,
                      ),
                      const SizedBox(height: 20),
                      const Text('Select all that apply *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Obx(() => Wrap(
                            spacing: 10,
                            children: controller.serviceCategories.entries.map((entry) => ChoiceChip(
                                  label: Text(entry.key),
                                  selected: entry.value.value,
                                  onSelected: (selected) => entry.value.value = selected,
                                )).toList(),
                          )),
                      Obx(() => controller.serviceCategories['Other']!.value
                          ? Column(
                              children: [
                                const SizedBox(height: 10),
                                Signup_textfilled(
                                  length: 100,
                                  textcont: controller.otherServiceCategoryController,
                                  textfilled_height: 17,
                                  textfilled_weight: 1,
                                  keytype: TextInputType.text,
                                  hinttext: "Specify other service categories",
                                  validator: (value) => controller.serviceCategories['Other']!.value && (value?.isEmpty ?? true) ? 'Please specify other service categories' : null,
                                ),
                              ],
                            )
                          : const SizedBox.shrink()),
                      const SizedBox(height: 20),

                      // SECTION 2: Fleet / Vehicle Details
                      const Text('SECTION 2: Fleet / Vehicle Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      const Text('(Complete one block per limousine model)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104))),
                      const SizedBox(height: 10),
                      const Text('Vehicle ID *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 20,
                        textcont: controller.vehicleIdController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "Enter vehicle ID",
                        validator: (value) => value?.isEmpty ?? true ? 'Vehicle ID is required' : null,
                      ),
                      const SizedBox(height: 10),
                      const Text('Make & Model *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 50,
                        textcont: controller.makeAndModelController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "Enter make and model",
                        validator: (value) => value?.isEmpty ?? true ? 'Make & Model is required' : null,
                      ),
                      const SizedBox(height: 10),
                      const Text('Type *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 50,
                        textcont: controller.typeController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "e.g., Stretch, SUV, H2",
                        validator: (value) => value?.isEmpty ?? true ? 'Type is required' : null,
                      ),
                      const SizedBox(height: 10),
                      const Text('Year of Manufacture', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 4,
                        textcont: controller.yearOfManufactureController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.number,
                        hinttext: "Enter year",
                      ),
                      const SizedBox(height: 10),
                      const Text('Colour', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 20,
                        textcont: controller.colourController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "Enter colour",
                      ),
                      const SizedBox(height: 10),
                      const Text('Passenger Capacity *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 3,
                        textcont: controller.passengerCapacityController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.number,
                        hinttext: "Number of passengers",
                        validator: (value) => value?.isEmpty ?? true ? 'Passenger Capacity is required' : null,
                      ),
                      const SizedBox(height: 10),
                      const Text('Vehicle Description for Listing *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 200,
                        textcont: controller.vehicleDescriptionController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "Describe the vehicle",
                        validator: (value) => value?.isEmpty ?? true ? 'Vehicle Description is required' : null,
                      ),
                      const SizedBox(height: 10),
                      const Text('Boots & Space', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 50,
                        textcont: controller.bootsAndSpaceController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "e.g., Large, 3 suitcases",
                      ),
                      const SizedBox(height: 20),

                      // SECTION 3: Features, Benefits & Extras
                      const Text('SECTION 3: Features, Benefits & Extras', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      const Text('Comfort & Luxury', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Obx(() => Wrap(
                            spacing: 10,
                            children: controller.comfortLuxury.entries.map((entry) => ChoiceChip(
                                  label: Text(entry.key),
                                  selected: entry.value.value,
                                  onSelected: (selected) => entry.value.value = selected,
                                )).toList(),
                          )),
                      const SizedBox(height: 20),
                      const Text('Events & Customisation (With Pricing)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Obx(() => Wrap(
                            spacing: 10,
                            children: controller.eventsCustomisation.entries.map((entry) => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ChoiceChip(
                                      label: Text(entry.key),
                                      selected: entry.value.value,
                                      onSelected: (selected) => entry.value.value = selected,
                                    ),
                                    if (entry.value.value) ...[
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: 80,
                                        child: Signup_textfilled(
                                          length: 10,
                                          textcont: controller.eventsCustomisationPrices[entry.key]!,
                                          textfilled_height: 17,
                                          textfilled_weight: 1,
                                          keytype: TextInputType.number,
                                          hinttext: "Price (£)",
                                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                                        ),
                                      ),
                                    ],
                                  ],
                                )).toList(),
                          )),
                      const SizedBox(height: 20),
                      const Text('Accessibility &的特 Services (With Pricing)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Obx(() => Wrap(
                            spacing: 10,
                            children: controller.accessibilitySpecialServices.entries.map((entry) => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ChoiceChip(
                                      label: Text(entry.key),
                                      selected: entry.value.value,
                                      onSelected: (selected) => entry.value.value = selected,
                                    ),
                                    if (entry.value.value) ...[
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: 80,
                                        child: Signup_textfilled(
                                          length: 10,
                                          textcont: controller.accessibilitySpecialServicesPrices[entry.key]!,
                                          textfilled_height: 17,
                                          textfilled_weight: 1,
                                          keytype: TextInputType.number,
                                          hinttext: "Price (£)",
                                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                                        ),
                                      ),
                                    ],
                                  ],
                                )).toList(),
                          )),
                      const SizedBox(height: 20),
                      const Text('Safety & Compliance', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Obx(() => Wrap(
                            spacing: 10,
                            children: controller.safetyCompliance.entries.map((entry) => ChoiceChip(
                                  label: Text(entry.key),
                                  selected: entry.value.value,
                                  onSelected: (selected) => entry.value.value = selected,
                                )).toList(),
                          )),
                      const SizedBox(height: 20),

                      // SECTION 4: Coverage & Availability
                      const Text('SECTION 4: Coverage & Availability', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      _buildCitySelection(context, controller, 'Areas Covered', controller.areasCovered),
                      const SizedBox(height: 20),
                      const Text('Service Status *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Obx(() => CustomDropdown(
                            hintText: "Select Service Status",
                            items: ['Open', 'Close'],
                            selectedValue: controller.serviceStatus.value,
                            onChanged: (value) => controller.serviceStatus.value = value ?? '',
                          )),
                      const SizedBox(height: 20),

                      // SECTION 5: Pricing Structure
                      const Text('SECTION 5: Pricing Structure', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      const Text('Each partner must offer a day hire rate (standard: 10 hours/100 miles)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104))),
                      const SizedBox(height: 10),
                      const Text('Day Rate (10 hrs / 100 miles) (£) *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 10,
                        textcont: controller.dayRateController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.number,
                        hinttext: "Enter day rate",
                        validator: (value) => value?.isEmpty ?? true ? 'Day rate is required' : null,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                      ),
                      const SizedBox(height: 10),
                      const Text('Mileage Limit *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 5,
                        textcont: controller.mileageLimitController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.number,
                        hinttext: "Current value: 100 miles",
                        validator: (value) => value?.isEmpty ?? true ? 'Mileage Limit is required' : null,
                      ),
                      const SizedBox(height: 10),
                      const Text('Extra Mileage Charge (£/mile) *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 10,
                        textcont: controller.extraMileageChargeController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.number,
                        hinttext: "Enter extra mileage charge",
                        validator: (value) => value?.isEmpty ?? true ? 'Extra Mileage Charge is required' : null,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                      ),
                      const SizedBox(height: 10),
                      const Text('Hourly Rate (£) *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 10,
                        textcont: controller.hourlyRateController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.number,
                        hinttext: "Enter hourly rate",
                        validator: (value) => value?.isEmpty ?? true ? 'Hourly rate is required' : null,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                      ),
                      const SizedBox(height: 10),
                      const Text('Half-Day Rate (£) (5 Hours) *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 10,
                        textcont: controller.halfDayRateController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.number,
                        hinttext: "Enter half-day rate",
                        validator: (value) => value?.isEmpty ?? true ? 'Half-day rate is required' : null,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                      ),
                      const SizedBox(height: 10),
                      const Text('Wedding Package (£)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 10,
                        textcont: controller.weddingPackageController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.number,
                        hinttext: "Enter wedding package rate",
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                      ),
                      const SizedBox(height: 10),
                      const Text('Airport Transfer (£)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 10,
                        textcont: controller.airportTransferController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.number,
                        hinttext: "Enter airport transfer rate",
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
                      ),
                      const SizedBox(height: 10),
                      const Text('Fuel Included?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Obx(() => Row(
                            children: [
                              Expanded(child: CustomCheckbox(title: 'Yes', value: controller.fuelIncluded.value, onChanged: (value) => controller.fuelIncluded.value = value!)),
                              const SizedBox(width: 20),
                              Expanded(child: CustomCheckbox(title: 'No', value: !controller.fuelIncluded.value, onChanged: (value) => controller.fuelIncluded.value = !value!)),
                            ],
                          )),
                      const SizedBox(height: 20),

                      // SECTION 6: Documents Required
                      const Text('SECTION 6: Documents Required', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      const Text('Upload scanned copies or clear photos', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104))),
                      const SizedBox(height: 10),
                      _buildDocumentUploadSection(context, controller, "MOT Certificate (if vehicle > 3 years old)", controller.motCertificatePaths, false),
                      _buildDocumentUploadSection(context, controller, "Driver's Licence (if chauffeur provided)", controller.driversLicencePaths, false),
                      _buildDocumentUploadSection(context, controller, "Public Liability Insurance", controller.publicLiabilityInsurancePaths, false),
                      _buildDocumentUploadSection(context, controller, "Operator's Licence (if required)", controller.operatorLicencePaths, false),
                      _buildDocumentUploadSection(context, controller, "Insurance Certificate (Hire & Reward)", controller.insuranceCertificatePaths, false),
                      _buildDocumentUploadSection(context, controller, "VSC / Registration Document", controller.vscRegistrationPaths, false),
                      const SizedBox(height: 20),

                      // SECTION 7: Photos & Media
                      const Text('SECTION 7: Photos & Media', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      const Text('Upload ≥5 high-quality images (exterior front/back, interior, seating, feature shots)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104))),
                      const SizedBox(height: 10),
                      const Text('Upload Photos of Your Limousines *', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Obx(() => Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: controller.limousinePhotosPaths.map((path) => Stack(
                                  children: [
                                    Image.network(
                                      path,
                                      fit: BoxFit.cover,
                                      height: 60,
                                      width: 60,
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
                                        onTap: () => controller.limousinePhotosPaths.remove(path),
                                        child: const Icon(Icons.close, color: Colors.redAccent),
                                      ),
                                    ),
                                  ],
                                )).toList(),
                          )),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => Get.bottomSheet(
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text('Take a Photo'),
                                onTap: () async {
                                  await controller.imageController.pickImages(true);
                                  if (controller.imageController.selectedImages.isNotEmpty) {
                                    controller.limousinePhotosPaths.add(controller.imageController.selectedImages.last);
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
                                    controller.limousinePhotosPaths.add(controller.imageController.selectedImages.last);
                                    controller.imageController.selectedImages.removeLast();
                                  }
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        ),
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
                      const Text('(Optional) Promo Video or YouTube link:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Signup_textfilled(
                        length: 200,
                        textcont: controller.promoVideoUrlController,
                        textfilled_height: 17,
                        textfilled_weight: 1,
                        keytype: TextInputType.text,
                        hinttext: "Enter video URL",
                      ),
                      const SizedBox(height: 20),

                      // SECTION 8: Service Availability Period
                      const Text('SECTION 8: Service Availability Period', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      const Text('Select the period during which your service will be available.', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 109, 104, 104))),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: _buildDatePicker(context, controller, 'Start', controller.fromDate, true)),
                          const SizedBox(width: 10),
                          Expanded(child: _buildDatePicker(context, controller, 'End', controller.toDate, false)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TableCalendar(
                        firstDay: DateTime.now(),
                        lastDay: DateTime.utc(2099, 12, 31),
                        focusedDay: controller.fromDate.value.isBefore(DateTime.now()) ? DateTime.now() : controller.fromDate.value,
                        calendarFormat: CalendarFormat.month,
                        availableGestures: AvailableGestures.none,
                        headerStyle: const HeaderStyle(formatButtonVisible: false),
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) => controller.buildCalendarCell(day, controller.calendarController.visibleDates.any((d) => isSameDay(d, day))),
                        ),
                        onDaySelected: (selectedDay, focusedDay) {
                          if (controller.calendarController.visibleDates.any((d) => isSameDay(d, selectedDay))) {
                            controller.showSetPriceDialog(selectedDay);
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Special Prices Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Obx(() => SizedBox(
                            height: 150,
                            child: controller.calendarController.specialPrices.isEmpty
                                ? const Center(child: Text('No special prices set yet', style: TextStyle(fontSize: 16, color: Colors.black)))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.calendarController.specialPrices.length,
                                    itemBuilder: (context, index) {
                                      final entry = controller.calendarController.specialPrices[index];
                                      final date = entry['date'] as DateTime;
                                      final price = entry['price'] as double;
                                      return Container(
                                        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(DateFormat('EEE, d MMM yyyy').found, style: const TextStyle(fontSize: 16)),
                                            Row(
                                              children: [
                                                Text('£${price.toStringAsFixed(2)}/hr', style: TextStyle(fontSize: 16, color: price > 0 ? Colors.black : Colors.red)),
                                                IconButton(
                                                  icon: const Icon(Icons.delete, color: Colors.red),
                                                  onPressed: () => controller.calendarController.deleteSpecialPrice(date),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          )),
                      const SizedBox(height: 20),

                      // SECTION 9: Coupons / Discounts
                      const Text('SECTION 9: Coupons / Discounts', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: w * 0.45,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => Get.dialog(AddCouponDialog()),
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.green)),
                          child: const Text("Add Coupon", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(() => controller.couponController.coupons.isEmpty ? const SizedBox.shrink() : CouponList()),
                      const SizedBox(height: 20),

                      // SECTION 10: Declaration & Agreement
                      const Text('SECTION 10: Declaration & Agreement', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Obx(() => CustomCheckbox(
                            title: 'I confirm that all information provided is accurate and current. *',
                            value: controller.agreeTerms.value,
                            onChanged: (value) => controller.agreeTerms.value = value!,
                          )),
                      const SizedBox(height: 20),
                      Obx(() => CustomCheckbox(
                            title: 'I have not shared any contact details (Email, Phone, Skype, Website, etc.). *',
                            value: controller.noContactDetails.value,
                            onChanged: (value) => controller.noContactDetails.value = value!,
                          )),
                      const SizedBox(height: 20),
                      Obx(() => CustomCheckbox(
                            title: 'I agree to the Cookies Policy. *',
                            value: controller.agreeCookies.value,
                            onChanged: (value) => controller.agreeCookies.value = value!,
                          )),
                      const SizedBox(height: 20),
                      Obx(() => CustomCheckbox(
                            title: 'I agree to the Privacy Policy. *',
                            value: controller.agreePrivacy.value,
                            onChanged: (value) => controller.agreePrivacy.value = value!,
                          )),
                      const SizedBox(height: 20),
                      Obx(() => CustomCheckbox(
                            title: 'I agree to the Cancellation Fee Policy. *',
                            value: controller.agreeCancellation.value,
                            onChanged: (value) => controller.agreeCancellation.value = value!,
                          )),
                      const SizedBox(height: 20),
                      Text('Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}'),
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
                                        if (!controller.serviceCategories.values.any((v) => v.value)) {
                                          Get.snackbar("Missing Information", "Please select at least one service category.",
                                              snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
                                          return;
                                        }
                                        if (controller.areasCovered.isEmpty) {
                                          Get.snackbar("Missing Information", "At least one area covered is required.",
                                              snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
                                          return;
                                        }
                                        final dayRate = double.tryParse(controller.dayRateController.text.trim()) ?? 0;
                                        final hourlyRate = double.tryParse(controller.hourlyRateController.text.trim()) ?? 0;
                                        final halfDayRate = double.tryParse(controller.halfDayRateController.text.trim()) ?? 0;
                                        final weddingPackage = double.tryParse(controller.weddingPackageController.text.trim()) ?? 0;
                                        final airportTransfer = double.tryParse(controller.airportTransferController.text.trim()) ?? 0;
                                        if (dayRate == 0 && hourlyRate == 0 && halfDayRate == 0 && weddingPackage == 0 && airportTransfer == 0) {
                                          Get.snackbar("Missing Information", "At least one rate must be provided.",
                                              snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
                                          return;
                                        }
                                        if (controller.limousinePhotosPaths.length < 2) {
                                          Get.snackbar("Missing Information", "At least 2 limousine photos are required.",
                                              snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
                                          return;
                                        }
                                        if (!controller.agreeTerms.value || !controller.noContactDetails.value || !controller.agreeCookies.value || !controller.agreePrivacy.value || !controller.agreeCancellation.value) {
                                          Get.snackbar("Missing Information", "Please agree to all declarations.",
                                              snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
                                          return;
                                        }

                                        controller.isSubmitting.value = true;
                                        final documentsUploaded = await controller.uploadDocuments();
                                        if (!documentsUploaded) {
                                          controller.isSubmitting.value = false;
                                          return;
                                        }

                                        final data = {
                                          "vendorId": await SessionVendorSideManager().getVendorId(),
                                          "categoryId": "676ac544234968d45b494992",
                                          "subcategoryId": "676ace13234968d45b4949db",
                                          "service_name": controller.serviceNameController.text.trim(),
                                          "serviceCategories": {
                                            for (var entry in controller.serviceCategories.entries)
                                              entry.key: entry.value.value,
                                            "otherSpecified": controller.serviceCategories['Other']!.value ? controller.otherServiceCategoryController.text.trim() : ""
                                          },
                                          "fleetDetails": {
                                            "vehicleId": controller.vehicleIdController.text.trim(),
                                            "makeAndModel": controller.makeAndModelController.text.trim(),
                                            "type": controller.typeController.text.trim(),
                                            "yearOfManufacture": controller.yearOfManufactureController.text.trim(),
                                            "colour": controller.colourController.text.trim(),
                                            "passengerCapacity": controller.passengerCapacityController.text.trim(),
                                            "vehicleDescription": controller.vehicleDescriptionController.text.trim(),
                                            "bootsAndSpace": controller.bootsAndSpaceController.text.trim(),
                                          },
                                          "features": {
                                            "comfortLuxury": controller.comfortLuxury,
                                            "eventsCustomisation": {
                                              for (var entry in controller.eventsCustomisation.entries)
                                                entry.key: {'selected': entry.value.value, 'price': double.tryParse(controller.eventsCustomisationPrices[entry.key]!.text) ?? 0.0}
                                            },
                                            "accessibilitySpecialServices": {
                                              for (var entry in controller.accessibilitySpecialServices.entries)
                                                entry.key: {'selected': entry.value.value, 'price': double.tryParse(controller.accessibilitySpecialServicesPrices[entry.key]!.text) ?? 0.0}
                                            },
                                            "safetyCompliance": controller.safetyCompliance,
                                          },
                                          "coverageAvailability": {
                                            "areasCovered": controller.areasCovered.toList(),
                                            "serviceStatus": controller.serviceStatus.value,
                                            "fromDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(controller.fromDate.value),
                                            "toDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(controller.toDate.value),
                                          },
                                          "pricing": {
                                            "dayRate": double.tryParse(controller.dayRateController.text.trim()) ?? 0,
                                            "mileageLimit": double.tryParse(controller.mileageLimitController.text.trim()) ?? 0,
                                            "extraMileageCharge": double.tryParse(controller.extraMileageChargeController.text.trim()) ?? 0,
                                            "hourlyRate": double.tryParse(controller.hourlyRateController.text.trim()) ?? 0,
                                            "halfDayRate": double.tryParse(controller.halfDayRateController.text.trim()) ?? 0,
                                            "weddingPackage": double.tryParse(controller.weddingPackageController.text.trim()) ?? 0,
                                            "airportTransfer": double.tryParse(controller.airportTransferController.text.trim()) ?? 0,
                                            "fuelIncluded": controller.fuelIncluded.value,
                                          },
                                          "documents": {
                                            "motCertificate": {"isAttached": controller.motCertificatePaths.isNotEmpty, "image": controller.motCertificatePaths.isNotEmpty ? controller.imageController.uploadedUrls[0] : ""},
                                            "driversLicence": {"isAttached": controller.driversLicencePaths.isNotEmpty, "image": controller.driversLicencePaths.isNotEmpty ? controller.imageController.uploadedUrls[controller.motCertificatePaths.isNotEmpty ? 1 : 0] : ""},
                                            "publicLiabilityInsurance": {"isAttached": controller.publicLiabilityInsurancePaths.isNotEmpty, "image": controller.publicLiabilityInsurancePaths.isNotEmpty ? controller.imageController.uploadedUrls[controller.motCertificatePaths.isNotEmpty ? (controller.driversLicencePaths.isNotEmpty ? 2 : 1) : 0] : ""},
                                            "operatorLicence": {"isAttached": controller.operatorLicencePaths.isNotEmpty, "image": controller.operatorLicencePaths.isNotEmpty ? controller.imageController.uploadedUrls[controller.motCertificatePaths.isNotEmpty ? (controller.driversLicencePaths.isNotEmpty ? (controller.publicLiabilityInsurancePaths.isNotEmpty ? 3 : 2) : 1) : 0] : ""},
                                            "insuranceCertificate": {"isAttached": controller.insuranceCertificatePaths.isNotEmpty, "image": controller.insuranceCertificatePaths.isNotEmpty ? controller.imageController.uploadedUrls[controller.motCertificatePaths.isNotEmpty ? (controller.driversLicencePaths.isNotEmpty ? (controller.publicLiabilityInsurancePaths.isNotEmpty ? (controller.operatorLicencePaths.isNotEmpty ? 4 : 3) : 2) : 1) : 0] : ""},
                                            "vscRegistration": {"isAttached": controller.vscRegistrationPaths.isNotEmpty, "image": controller.vscRegistrationPaths.isNotEmpty ? controller.imageController.uploadedUrls[controller.motCertificatePaths.isNotEmpty ? (controller.driversLicencePaths.isNotEmpty ? (controller.publicLiabilityInsurancePaths.isNotEmpty ? (controller.operatorLicencePaths.isNotEmpty ? (controller.insuranceCertificatePaths.isNotEmpty ? 5 : 4) : 3) : 2) : 1) : 0] : ""},
                                          },
                                          "media": {
                                            "limousinePhotos": controller.limousinePhotosPaths.isNotEmpty ? controller.imageController.uploadedUrls.sublist(controller.motCertificatePaths.length + controller.driversLicencePaths.length + controller.publicLiabilityInsurancePaths.length + controller.operatorLicencePaths.length + controller.insuranceCertificatePaths.length + controller.vscRegistrationPaths.length) : [],
                                            "promoVideoUrl": controller.promoVideoUrlController.text.trim(),
                                          },
                                          "serviceAvailability": {
                                            "fromDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(controller.fromDate.value),
                                            "toDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(controller.toDate.value),
                                          },
                                          "coupons": controller.couponController.coupons.map((coupon) => {
                                                "coupon_code": coupon['coupon_code'] ?? "",
                                                "discount_type": coupon['discount_type'] ?? "",
                                                "discount_value": coupon['discount_value'] ?? 0,
                                                "usage_limit": coupon['usage_limit'] ?? 0,
                                                "current_usage_count": coupon['current_usage_count'] ?? 0,
                                                "expiry_date": coupon['expiry_date'] != null && coupon['expiry_date'].toString().isNotEmpty ? DateFormat('yyyy-MM-dd').format(DateTime.parse(coupon['expiry_date'].toString())) : "",
                                                "is_global": coupon['is_global'] ?? false
                                              }).toList(),
                                          "special_price_days": controller.calendarController.specialPrices.map((e) => {
                                                "date": e['date'] != null ? DateFormat('yyyy-MM-dd').format(e['date'] as DateTime) : "",
                                                "price": e['price'] as double? ?? 0
                                              }).toList(),
                                          "isAccurateInfo": controller.agreeTerms.value,
                                          "noContactDetailsShared": controller.noContactDetails.value,
                                          "agreeCookiesPolicy": controller.agreeCookies.value,
                                          "agreePrivacyPolicy": controller.agreePrivacy.value,
                                          "agreeCancellationPolicy": controller.agreeCancellation.value,
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
            )),
    );
  }

  Widget _buildCitySelection(BuildContext context, LimoHireEditController controller, String title, RxList<String> selectedCities) {
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow[700], foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 12)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  selectedCities.clear();
                },
                child: const Text('DESELECT ALL'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300], foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 12)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Text('Search by post code or city name...'),
              value: null,
              items: Cities.ukCities.map((String city) => DropdownMenuItem<String>(
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
                  )).toList(),
              onChanged: (String? newValue) {
                if (newValue != null && !selectedCities.contains(newValue)) {
                  selectedCities.add(newValue);
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Obx(() => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
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

  Widget _buildDatePicker(BuildContext context, LimoHireEditController controller, String label, Rx<DateTime> date, bool isFromDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label Date', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                controller.calendarController.updateDateRange(controller.fromDate.value, controller.toDate.value);
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(DateFormat('dd/MM/yyyy').format(date.value), style: const TextStyle(fontSize: 16))),
                const Icon(Icons.calendar_today, color: Colors.grey),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDocumentUploadSection(BuildContext context, LimoHireEditController controller, String title, RxList<String> documentPaths, bool isRequired) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title${isRequired ? ' *' : ''}", style: const TextStyle(color: Colors.black, fontSize: 16)),
        const SizedBox(height: 16),
        Obx(() => Wrap(
              spacing: 8.0,
              children: documentPaths.map((path) => Stack(
                    children: [
                      Image.network(
                        path,
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
                          onTap: () => documentPaths.remove(path),
                          child: const Icon(Icons.close, color: Colors.redAccent, size: 20),
                        ),
                      ),
                    ],
                  )).toList(),
            )),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => Get.bottomSheet(
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a Photo'),
                  onTap: () async {
                    await controller.imageController.pickImages(true);
                    if (controller.imageController.selectedImages.isNotEmpty) {
                      documentPaths.add(controller.imageController.selectedImages.last);
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
                      documentPaths.add(controller.imageController.selectedImages.last);
                      controller.imageController.selectedImages.removeLast();
                    }
                    Get.back();
                  },
                ),
              ],
            ),
          ),
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
                    Text('Click to upload PDF, PNG, JPG (max 5MB)', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
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