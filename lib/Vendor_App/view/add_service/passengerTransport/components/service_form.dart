// components/service_form.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/signup_textfilled.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/custom_checkbox.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/custom_dropdown.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/components/calendar_section.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/components/city_selector.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/components/coupon_section.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/components/image_upload_section.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/components/passenger_service_viewmodel.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/components/terms_and_conditions.dart';



class ServiceForm extends StatelessWidget {
  final String? categoryId;
  final String? subCategoryId;

  const ServiceForm({super.key, required this.categoryId, required this.subCategoryId});

  @override
  Widget build(BuildContext context) {
    final vm = Get.put(PassengerServiceViewModel());
    final w = MediaQuery.of(context).size.width;

    return Form(
      key: vm.formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            label: "Service Name *",
            controller: TextEditingController(text: vm.vendorServiceModel.value.serviceName ?? ""),
            onChanged: (value) => vm.updateField(value, (m) => m?.serviceName = value),
            hintText: "Enter Service name",
          ),
          const CitySelector(),
          _buildTextField(
            label: "Price per Mile (£) *",
            controller: TextEditingController(text: vm.vendorServiceModel.value.kilometerPrice.toString()),
            onChanged: (value) => vm.updateField(int.tryParse(value) ?? 0, (m) => m!.kilometerPrice = int.tryParse(value) ?? 0),
            hintText: "Enter price per mile",
            keyboardType: TextInputType.number,
          ),
          _buildTextField(
            label: "Number of Seats *",
            controller: TextEditingController(text: vm.vendorServiceModel.value.noOfSeats.toString()),
            onChanged: (value) => vm.updateField(int.tryParse(value) ?? 0, (m) => m!.noOfSeats = int.tryParse(value) ?? 0),
            hintText: "Enter Number of Seats",
            keyboardType: TextInputType.number,
          ),
          _buildTextField(
            label: "Registration Number *",
            controller: TextEditingController(text: vm.vendorServiceModel.value.registrationNo),
            onChanged: (value) => vm.updateField(value, (m) => m!.registrationNo = value),
            hintText: "Enter registration number",
          ),
          _buildTextField(
            label: "Make and Model *",
            controller: TextEditingController(text: vm.vendorServiceModel.value.makeAndModel),
            onChanged: (value) => vm.updateField(value, (m) => m!.makeAndModel = value),
            hintText: "Enter make and model",
          ),
          _buildDropdown(
            label: "Wheelchair Access *",
            items: const ['yes', 'no'],
            value: vm.vendorServiceModel.value.wheelChair,
            onChanged: (value) => vm.updateField(value, (m) => m!.wheelChair = value ?? ""),
          ),
          _buildDropdown(
            label: "Air Conditioning *",
            items: const ['yes', 'no'],
            value: vm.vendorServiceModel.value.aironFitted,
            onChanged: (value) => vm.updateField(value, (m) => m!.aironFitted = value ?? ""),
          ),
          _buildTextField(
            label: "Minimum Distance (miles) *",
            controller: TextEditingController(text: vm.vendorServiceModel.value.minimumDistance),
            onChanged: (value) => vm.updateField(value, (m) => m!.minimumDistance = value),
            hintText: "Enter minimum distance",
            keyboardType: TextInputType.number,
          ),
          _buildTextField(
            label: "Maximum Distance (miles) *",
            controller: TextEditingController(text: vm.vendorServiceModel.value.maximumDistance),
            onChanged: (value) => vm.updateField(value, (m) => m!.maximumDistance = value),
            hintText: "Enter maximum distance",
            keyboardType: TextInputType.number,
          ),
          _buildDropdown(
            label: "Service Status *",
            items: const ['Yes', 'No'],
            value: vm.vendorServiceModel.value.serviceStatus,
            onChanged: (value) => vm.updateField(value, (m) => m!.serviceStatus = value ?? "open"),
          ),
          _buildTextField(
            label: "Weekly Price",
            controller: TextEditingController(text: vm.vendorServiceModel.value.weeklyPrice?.toString() ?? ""),
            onChanged: (value) => vm.updateField(int.tryParse(value), (m) => m!.weeklyPrice = int.tryParse(value)),
            hintText: "Enter Weekly Price (optional)",
            keyboardType: TextInputType.number,
          ),
          _buildTextField(
            label: "Weekly Discount (%)",
            controller: TextEditingController(text: vm.vendorServiceModel.value.weeklyDiscount.toString()),
            onChanged: (value) => vm.updateField(int.tryParse(value) ?? 0, (m) => m!.weeklyDiscount = int.tryParse(value) ?? 0),
            hintText: "Enter Weekly Discount Percentage",
            keyboardType: TextInputType.number,
          ),
          _buildTextField(
            label: "Monthly Discount (%)",
            controller: TextEditingController(text: vm.vendorServiceModel.value.monthlyDiscount.toString()),
            onChanged: (value) => vm.updateField(int.tryParse(value) ?? 0, (m) => m!.monthlyDiscount = int.tryParse(value) ?? 0),
            hintText: "Enter Monthly Discount Percentage",
            keyboardType: TextInputType.number,
          ),
          _buildTextField(
            label: "Extra Time Waiting Charge (£/hour)",
            controller: TextEditingController(text: vm.vendorServiceModel.value.extraTimeWaitingCharge.toString()),
            onChanged: (value) => vm.updateField(int.tryParse(value) ?? 0, (m) => m!.extraTimeWaitingCharge = int.tryParse(value) ?? 0),
            hintText: "Enter waiting charge per hour (optional)",
            keyboardType: TextInputType.number,
          ),
         _buildTextField(
            label: "Extra Miles Charges (£/mile)",
            controller: TextEditingController(text: vm.vendorServiceModel.value.extraMilesCharges.toString()),
            onChanged: (value) => vm.updateField(int.tryParse(value) ?? 0, (m) => m?.extraMilesCharges = int.tryParse(value) ?? 0),
            hintText: "Enter charge per extra mile (optional)",
            keyboardType: TextInputType.number,
          ),
          Obx(() { 
            
            return  _buildCheckbox(
              title: "One Day Hire?",
              description: "This package includes service for up to 200 miles or 10 hours",
              value: vm.isOneDayHire,
              onChanged: (value) => vm.isOneDayHire.value = value ?? false,
            );
            
            

          }
          ),

          Obx(() => vm.isOneDayHire.value // Obx only for the conditional text field
        ? _buildTextField(
            label: "One Day Price (£)",
            controller: TextEditingController(text: vm.vendorServiceModel.value.oneDayPrice.toString()),
            onChanged: (value) => vm.updateField(int.tryParse(value) ?? 0, (m) => m?.oneDayPrice = int.tryParse(value) ?? 0),
            hintText: "Enter package Price (£)",
            keyboardType: TextInputType.number,
          )
        : const SizedBox.shrink()),
        
        
          CalendarSection(),
          _buildTextField(
            label: "Description *",
            controller: TextEditingController(text: vm.vendorServiceModel.value.description ?? ""),
            onChanged: (value) => vm.updateField(value, (m) => m?.description = value),
            hintText: "Enter service description",
            maxLines: 5,
          ),
          _buildDropdown(
            label: "Cancellation Policy *",
            items: const [
              'Flexible-Full refund if canceled 48+ hours in advance',
              'Moderate-Full refund if canceled 72+ hours in advance',
              'Strict-Full refund if canceled 7+ days in advance',
            ],
            value: vm.vendorServiceModel.value.cancellationPolicyType,
            onChanged: (value) => vm.updateField(value, (m) => m?.cancellationPolicyType = value ?? "FLEXIBLE"),
          ),
          const ImageUploadSection(),
           CouponSection(),
          TermsAndConditions(vm: vm),
          const SizedBox(height: 20),
          Obx(() => SizedBox(
                width: w,
                height: 50,
                child: ElevatedButton(
                  onPressed: vm.isLoading.value ? null : () => vm.submitForm(categoryId!, subCategoryId!),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: vm.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.blue)
                      : const Text("Submit Service", style: TextStyle(color: Colors.white)),
                ),
              )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Signup_textfilled(
          length: 500,
          textcont: controller,
          onChanged: onChanged,
          textfilled_height: maxLines == 1 ? 17 : 10,
          textfilled_weight: 1,
          keytype: keyboardType,
          hinttext: hintText,
          maxLines: maxLines,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        CustomDropdown(
          hintText: "Select Option",
          items: items,
          selectedValue: value,
          onChanged: onChanged,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCheckbox({
    required String title,
    String? description,
    required RxBool value,
    required Function(bool?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        description != null
            ? CustomCheckboxContainer(title: title, description: description, value: value.value, onChanged: onChanged)
            : CustomCheckbox(title: title, value: value.value, onChanged: onChanged),
        const SizedBox(height: 20),
      ],
    );
  }
}