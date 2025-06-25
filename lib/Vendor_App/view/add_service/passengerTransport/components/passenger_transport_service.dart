// passenger_transport_service.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/components/service_form.dart';


class PassengerTransportService extends StatefulWidget {
  final Rxn<String> category;
  final Rxn<String> subCategory;
  final String? categoryId;
  final String? subCategoryId;

  const PassengerTransportService({
    super.key,
    required this.category,
    required this.subCategory,
    this.categoryId,
    this.subCategoryId,
  });

  @override
  State<PassengerTransportService> createState() => _PassengerTransportServiceState();
}

class _PassengerTransportServiceState extends State<PassengerTransportService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffold_background_color,
      appBar: AppBar(
        backgroundColor: colors.white,
        elevation: 0,
        centerTitle: true,
        title: Obx(() => Text(
              'Add ${widget.subCategory.value ?? ''} Service',
              style: const TextStyle(fontWeight: FontWeight.bold, color: colors.black),
            )),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ServiceForm(categoryId: widget.categoryId ?? "", subCategoryId: widget.subCategoryId ?? ""),
        ),
      ),
    );
  }
}