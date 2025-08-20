import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/edit_passenger_services/funeral_car_edit/controller/funeral_car_edit_controller.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FuneralCarHireEditScreen extends StatefulWidget {
  final String serviceId;
  
  const FuneralCarHireEditScreen({Key? key, required this.serviceId}) : super(key: key);

  @override
  State<FuneralCarHireEditScreen> createState() => _FuneralCarHireEditScreenState();
}

class _FuneralCarHireEditScreenState extends State<FuneralCarHireEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late FuneralCarHireEditController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(FuneralCarHireEditController(serviceId: widget.serviceId));
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Funeral Car Hire', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Basic Service Details
                _buildSectionTitle('Basic Service Details'),
                _buildTextField(
                  controller: controller.serviceNameController,
                  label: 'Service Name*',
                  validator: (value) => value?.isEmpty ?? true ? 'Service name is required' : null,
                ),
                const SizedBox(height: 16),
                
                _buildTextField(
                  controller: controller.basePostcodeController,
                  label: 'Base Postcode*',
                  validator: (value) => value?.isEmpty ?? true ? 'Base postcode is required' : null,
                ),
                const SizedBox(height: 16),
                
                _buildTextField(
                  controller: controller.locationRadiusController,
                  label: 'Location Radius (miles)*',
                  keyboardType: TextInputType.number,
                  validator: (value) => value?.isEmpty ?? true ? 'Location radius is required' : null,
                ),
                const SizedBox(height: 24),

                // Section 2: Pricing Details
                _buildSectionTitle('Pricing Details'),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: controller.dayRateController,
                        label: 'Day Rate (£)',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: controller.hourlyRateController,
                        label: 'Hourly Rate (£)',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: controller.halfDayRateController,
                        label: 'Half Day Rate (£)',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: controller.mileageLimitController,
                        label: 'Mileage Limit',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                _buildTextField(
                  controller: controller.extraMileageChargeController,
                  label: 'Extra Mileage Charge (£)',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),

                // Section 3: Fleet Details
                _buildSectionTitle('Fleet Details'),
                _buildTextField(
                  controller: controller.makeModelController,
                  label: 'Make & Model*',
                  validator: (value) => value?.isEmpty ?? true ? 'Make & Model is required' : null,
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: controller.yearController,
                        label: 'Year',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: controller.seatsController,
                        label: 'Seats*',
                        keyboardType: TextInputType.number,
                        validator: (value) => value?.isEmpty ?? true ? 'Number of seats is required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                _buildTextField(
                  controller: controller.luggageCapacityController,
                  label: 'Luggage Capacity*',
                  keyboardType: TextInputType.number,
                  validator: (value) => value?.isEmpty ?? true ? 'Luggage capacity is required' : null,
                ),
                const SizedBox(height: 24),

                // Section 4: Driver Details
                _buildSectionTitle('Driver Details'),
                Obx(() => CheckboxListTile(
                  title: const Text('Drivers Uniformed'),
                  value: controller.driversUniformed.value,
                  onChanged: (value) => controller.driversUniformed.value = value ?? false,
                  activeColor: Colors.green,
                )),
                Obx(() => CheckboxListTile(
                  title: const Text('Drivers DBS Checked'),
                  value: controller.driversDBSChecked.value,
                  onChanged: (value) => controller.driversDBSChecked.value = value ?? false,
                  activeColor: Colors.green,
                )),
                const SizedBox(height: 24),

                // Section 5: Service Details
                _buildSectionTitle('Service Details'),
                Obx(() => CheckboxListTile(
                  title: const Text('Works with Funeral Directors'),
                  value: controller.worksWithFuneralDirectors.value,
                  onChanged: (value) => controller.worksWithFuneralDirectors.value = value ?? false,
                  activeColor: Colors.green,
                )),
                Obx(() => CheckboxListTile(
                  title: const Text('Supports All Funeral Types'),
                  value: controller.supportsAllFuneralTypes.value,
                  onChanged: (value) => controller.supportsAllFuneralTypes.value = value ?? false,
                  activeColor: Colors.green,
                )),
                const SizedBox(height: 16),
                
                // Funeral Service Type Dropdown
                Obx(() => DropdownButtonFormField<String>(
                  value: controller.funeralServiceType.value,
                  decoration: const InputDecoration(
                    labelText: 'Funeral Service Type',
                    border: OutlineInputBorder(),
                  ),
                  items: controller.funeralServiceTypes.map((type) => 
                    DropdownMenuItem(value: type, child: Text(type))
                  ).toList(),
                  onChanged: (value) => controller.funeralServiceType.value = value ?? 'Religious',
                )),
                const SizedBox(height: 24),

                // Section 6: Additional Support Services
                _buildSectionTitle('Additional Support Services'),
                ...controller.additionalSupportServices.entries.map((entry) =>
                  Obx(() => CheckboxListTile(
                    title: Text(entry.key),
                    value: entry.value.value,
                    onChanged: (value) => entry.value.value = value ?? false,
                    activeColor: Colors.green,
                  ))
                ),
                const SizedBox(height: 24),

                // Section 7: Accessibility Services
                _buildSectionTitle('Accessibility & Special Services'),
                ...controller.accessibilityServices.entries.map((entry) =>
                  Column(
                    children: [
                      Obx(() => CheckboxListTile(
                        title: Text(entry.key),
                        value: entry.value.value,
                        onChanged: (value) => entry.value.value = value ?? false,
                        activeColor: Colors.green,
                      )),
                      Obx(() => entry.value.value 
                        ? Padding(
                            padding: const EdgeInsets.only(left: 32, right: 16, bottom: 16),
                            child: TextFormField(
                              controller: controller.accessibilityServicesPrices[entry.key],
                              decoration: InputDecoration(
                                labelText: '${entry.key} - Additional Price (£)',
                                border: const OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          )
                        : const SizedBox.shrink()
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 24),

                // Section 8: Areas Covered
                _buildSectionTitle('Areas Covered*'),
                // MultiselectDropdown(
                //   options: controller.cityFetchController.cities,
                //   selectedValues: controller.areasCovered,
                //   onChanged: (values) => controller.areasCovered.assignAll(values),
                //   hint: 'Select areas covered',
                // ),
                const SizedBox(height: 24),

                // Section 9: Availability
                _buildSectionTitle('Availability'),
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: controller.fromDate.value,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                          );
                          if (date != null) {
                            controller.fromDate.value = date;
                            controller.calendarController.updateDateRange(date, controller.toDate.value);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Available From', style: TextStyle(fontSize: 12)),
                              Text(DateFormat('dd/MM/yyyy').format(controller.fromDate.value)),
                            ],
                          ),
                        ),
                      )),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Obx(() => InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: controller.toDate.value,
                            firstDate: controller.fromDate.value,
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                          );
                          if (date != null) {
                            controller.toDate.value = date;
                            controller.calendarController.updateDateRange(controller.fromDate.value, date);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Available To', style: TextStyle(fontSize: 12)),
                              Text(DateFormat('dd/MM/yyyy').format(controller.toDate.value)),
                            ],
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Section 10: Service Images
                _buildSectionTitle('Service Images (Minimum 5 required)'),
                Container(
                  height: 120,
                  child: Obx(() => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.funeralCarPhotosPaths.length + 1,
                    itemBuilder: (context, index) {
                      if (index == controller.funeralCarPhotosPaths.length) {
                        return InkWell(
                          onTap: () async {
                            final result = await Get.to(() => const ImagePickerPage());
                            if (result != null) {
                              controller.funeralCarPhotosPaths.add(result);
                            }
                          },
                          child: Container(
                            width: 100,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_a_photo, size: 40, color: Colors.green),
                                Text('Add Photo', style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                        );
                      }
                      return Container(
                        width: 100,
                        margin: const EdgeInsets.only(right: 8),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: controller.funeralCarPhotosPaths[index].startsWith('http')
                                  ? Image.network(
                                      controller.funeralCarPhotosPaths[index],
                                      width: 100,
                                      height: 120,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => 
                                          const Icon(Icons.error, size: 50),
                                    )
                                  : Image.file(
                                      File(controller.funeralCarPhotosPaths[index]),
                                      width: 100,
                                      height: 120,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => 
                                          const Icon(Icons.error, size: 50),
                                    ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: InkWell(
                                onTap: () => controller.funeralCarPhotosPaths.removeAt(index),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.close, color: Colors.white, size: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
                ),
                const SizedBox(height: 8),
                
                // Image count indicator
                Obx(() => Text(
                  'Images: ${controller.funeralCarPhotosPaths.length}/5 (minimum required)',
                  style: TextStyle(
                    color: controller.funeralCarPhotosPaths.length < 5 ? Colors.red : Colors.green,
                    fontSize: 12,
                  ),
                )),
                const SizedBox(height: 24),

                // Section 11: Business Profile
                _buildSectionTitle('Business Profile'),
                _buildTextField(
                  controller: controller.businessHighlightsController,
                  label: 'Business Highlights',
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                
                _buildTextField(
                  controller: controller.promotionalDescriptionController,
                  label: 'Promotional Description',
                  maxLines: 3,
                ),
                const SizedBox(height: 32),

                // Submit Button
                Obx(() => Container(
                  width: w,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.isSubmitting.value
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              if (controller.areasCovered.isEmpty) {
                                Get.snackbar(
                                  "Missing Information", 
                                  "At least one area covered is required.",
                                  snackPosition: SnackPosition.BOTTOM, 
                                  backgroundColor: Colors.redAccent, 
                                  colorText: Colors.white
                                );
                                return;
                              }

                              // Check if there are new images to upload
                              bool hasNewImages = controller.funeralCarPhotosPaths.any((path) => !path.startsWith('http'));
                              
                              if (hasNewImages) {
                                final documentsUploaded = await controller.uploadDocuments();
                                if (!documentsUploaded) {
                                  return;
                                }
                              }

                              await controller.submitForm();
                            }
                          },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (states) => controller.isSubmitting.value ? Colors.grey : Colors.green,
                      ),
                    ),
                    child: controller.isSubmitting.value
                        ? const SizedBox(
                            height: 24, 
                            width: 24, 
                            child: CircularProgressIndicator(
                              color: Colors.white, 
                              strokeWidth: 2.5
                            )
                          )
                        : const Text(
                            "Update Funeral Service", 
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 18, 
                              fontWeight: FontWeight.bold
                            )
                          ),
                  ),
                )),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
    );
  }
}

// MultiselectDropdown Widget
class MultiselectDropdown extends StatefulWidget {
  final List<String> options;
  final RxList<String> selectedValues;
  final Function(List<String>) onChanged;
  final String hint;

  const MultiselectDropdown({
    Key? key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    required this.hint,
  }) : super(key: key);

  @override
  State<MultiselectDropdown> createState() => _MultiselectDropdownState();
}

class _MultiselectDropdownState extends State<MultiselectDropdown> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            _showMultiSelectDialog();
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.selectedValues.isEmpty
                        ? widget.hint
                        : '${widget.selectedValues.length} areas selected',
                    style: TextStyle(
                      color: widget.selectedValues.isEmpty
                          ? Colors.grey[600]
                          : Colors.black87,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        if (widget.selectedValues.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: widget.selectedValues.map((value) => 
              Chip(
                label: Text(value, style: const TextStyle(fontSize: 12)),
                backgroundColor: Colors.green.withOpacity(0.2),
                deleteIcon: const Icon(Icons.close, size: 18),
                onDeleted: () {
                  widget.selectedValues.remove(value);
                  widget.onChanged(widget.selectedValues.toList());
                },
              )
            ).toList(),
          ),
        ],
      ],
    ));
  }

  void _showMultiSelectDialog() {
    List<String> tempSelected = List.from(widget.selectedValues);
    
    Get.dialog(
      AlertDialog(
        title: const Text('Select Areas Covered'),
        content: Container(
          width: double.maxFinite,
          height: 400,
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Search areas...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  // Implement search if needed
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        tempSelected.clear();
                        tempSelected.addAll(widget.options);
                      });
                    },
                    child: const Text('Select All'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        tempSelected.clear();
                      });
                    },
                    child: const Text('Deselect All'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.options.length,
                  itemBuilder: (context, index) {
                    final option = widget.options[index];
                    return CheckboxListTile(
                      title: Text(option),
                      value: tempSelected.contains(option),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            tempSelected.add(option);
                          } else {
                            tempSelected.remove(option);
                          }
                        });
                      },
                      activeColor: Colors.green,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              widget.selectedValues.assignAll(tempSelected);
              widget.onChanged(tempSelected);
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}


class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Image', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.image,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 30),
            const Text(
              'Choose image source',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageSourceButton(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () => _pickImage(ImageSource.camera),
                ),
                _buildImageSourceButton(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () => _pickImage(ImageSource.gallery),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSourceButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.green.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.green,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      if (source == ImageSource.camera) {
        final cameraPermission = await Permission.camera.request();
        if (!cameraPermission.isGranted) {
          _showPermissionDialog('Camera');
          return;
        }
      } else {
        final storagePermission = await Permission.storage.request();
        if (!storagePermission.isGranted) {
          final photosPermission = await Permission.photos.request();
          if (!photosPermission.isGranted) {
            _showPermissionDialog('Storage');
            return;
          }
        }
      }

      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        Get.back(result: pickedFile.path);
      }
    } catch (e) {
      print('Error picking image: $e');
      Get.snackbar(
        'Error',
        'Failed to pick image. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void _showPermissionDialog(String permissionType) {
    Get.dialog(
      AlertDialog(
        title: Text('$permissionType Permission Required'),
        content: Text('This app needs $permissionType permission to select images. Please grant permission in app settings.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              openAppSettings();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Open Settings', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
