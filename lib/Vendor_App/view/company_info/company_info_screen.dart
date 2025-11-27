import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/company_info/controllers/company_info_controller.dart';
import 'package:hire_any_thing/utilities/colors.dart';

class CompanyInfoScreen extends StatelessWidget {
  const CompanyInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompanyInfoController());

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Obx(() {
        if (controller.isLoading.value && !controller.hasCompanyInfo.value) {
          return _buildLoadingState();
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: FadeTransition(
              opacity: controller.fadeAnimation,
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(controller),
                    const SizedBox(height: 24),
                    _buildInfoCard(controller),
                    const SizedBox(height: 24),
                    _buildActionButtons(controller),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.btnColor),
            ),
             SizedBox(height: 20),
             Text(
              'Loading company information...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(CompanyInfoController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.btnColor, AppColors.btnColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.business,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fill Company Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.hasCompanyInfo.value
                      ? 'Update your business profile'
                      : 'Complete your business profile',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(CompanyInfoController controller) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Company Information'),
          const SizedBox(height: 20),
          _buildTextField(
            controller: controller.companyNameController,
            label: 'Company Name',
            hint: 'Enter company name',
            icon: Icons.business_outlined,
            isRequired: true,
            enabled: controller.isEditing.value,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Company name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: controller.tradingNameController,
            label: 'Trading Name',
            hint: 'Enter trading name (optional)',
            icon: Icons.store_outlined,
            enabled: controller.isEditing.value,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: controller.companyRegNoController,
            label: 'Company Registration Number',
            hint: 'e.g., 12345678 or SC123456',
            icon: Icons.numbers_outlined,
            isRequired: true,
            enabled: controller.isEditing.value,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Company registration number is required';
              }
              // Validate format: 8 digits or SC/NI/SO/NC + 6 digits
              final regExp =
                  RegExp(r'^(\d{8}|(SC|NI|SO|NC)\d{6})$', caseSensitive: false);
              if (!regExp.hasMatch(value.trim())) {
                return 'Invalid format. Use 8 digits or SC/NI/SO/NC + 6 digits';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: controller.contactNameController,
            label: 'Contact Name',
            hint: 'Enter contact name',
            icon: Icons.person_outline,
            isRequired: true,
            enabled: controller.isEditing.value,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Contact name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: controller.phoneController,
            label: 'Phone',
            hint: 'e.g., 07123456789 or 020 7946 0958',
            icon: Icons.phone_outlined,
            isRequired: true,
            enabled: controller.isEditing.value,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Phone number is required';
              }
              // UK phone format validation
              final regExp =
                  RegExp(r'^(0\d{2,4}\s?\d{3,4}\s?\d{3,4}|07\d{9})$');
              if (!regExp.hasMatch(value.trim().replaceAll(' ', ''))) {
                return 'Invalid UK phone format';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: controller.emailController,
            label: 'Email',
            hint: 'e.g., john@company.co.uk',
            icon: Icons.email_outlined,
            isRequired: true,
            enabled: controller.isEditing.value,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email is required';
              }
              final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegExp.hasMatch(value.trim())) {
                return 'Invalid email format';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Address Details'),
          const SizedBox(height: 20),
          _buildTextField(
            controller: controller.addressController,
            label: 'Address',
            hint: 'Enter your business address for location verification',
            icon: Icons.location_on_outlined,
            isRequired: true,
            enabled: controller.isEditing.value,
            maxLines: 2,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Address is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: controller.postcodeController,
            label: 'Postcode',
            hint: 'Enter your business postcode for location verification',
            icon: Icons.pin_drop_outlined,
            isRequired: true,
            enabled: controller.isEditing.value,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Postcode is required';
              }
              // UK postcode validation
              final regExp = RegExp(
                r'^[A-Z]{1,2}\d[A-Z\d]?\s?\d[A-Z]{2}$',
                caseSensitive: false,
              );
              if (!regExp.hasMatch(value.trim())) {
                return 'Invalid UK postcode format';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isRequired = false,
    bool enabled = true,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            if (isRequired)
              const Text(
                '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: TextStyle(
            fontSize: 16,
            color: enabled ? Colors.black87 : Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            filled: true,
            fillColor: enabled ? Colors.grey.shade50 : Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.btnColor, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(CompanyInfoController controller) {
    return Obx(() {
      if (controller.isEditing.value) {
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.toggleEditMode(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.saveCompanyInfo(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.btnColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: controller.isLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Submit Information',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        );
      } else {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => controller.toggleEditMode(),
            icon: const Icon(Icons.edit, color: Colors.white),
            label: const Text(
              'Edit Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.btnColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
          ),
        );
      }
    });
  }
}
