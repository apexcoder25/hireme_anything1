// components/terms_and_conditions.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/custom_checkbox.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/components/passenger_service_viewmodel.dart';


class TermsAndConditions extends StatefulWidget {
  final PassengerServiceViewModel vm;

  const TermsAndConditions({super.key, required this.vm});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          CustomCheckbox(
            title: 'I agree to the Terms and Conditions',
            value: widget.vm.isTnc.value,
            onChanged: (value) => widget.vm.isTnc.value = value ?? false,
          ),
          const SizedBox(height: 20),
          CustomCheckbox(
            title: 'I have not shared any contact details (Email, Phone, Skype, Website etc.)',
            value: widget.vm.isContact.value,
            onChanged: (value) => widget.vm.isContact.value = value ?? false,
          ),
          const SizedBox(height: 20),
          CustomCheckbox(
            title: 'I agree to the Cookies Policy',
            value: widget.vm.isCookies.value,
            onChanged: (value) => widget.vm.isCookies.value = value ?? false,
          ),
          const SizedBox(height: 20),
          CustomCheckbox(
            title: 'I agree to the Privacy Policy',
            value: widget.vm.isPvc.value,
            onChanged: (value) => widget.vm.isPvc.value = value ?? false,
          ),
        ],
      );
    }
    );
  }
}