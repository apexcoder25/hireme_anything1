import 'package:flutter/material.dart';
import 'package:hire_any_thing/utilities/colors.dart';

class ProfileInfoSection extends StatelessWidget {
  final bool isEditing;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController mobileNoController;
  final TextEditingController countryCodeController;
  final TextEditingController genderController;
  final TextEditingController cityNameController;
  final TextEditingController streetNameController;
  final TextEditingController countryNameController;
  final TextEditingController pincodeController;

  const ProfileInfoSection({
    super.key,
    required this.isEditing,
    required this.nameController,
    required this.emailController,
    required this.mobileNoController,
    required this.countryCodeController,
    required this.genderController,
    required this.cityNameController,
    required this.streetNameController,
    required this.countryNameController,
    required this.pincodeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInfoCard("Personal Information", [
          _buildInfoRow(Icons.person_outline, "Full Name", nameController),
          _buildInfoRow(Icons.email_outlined, "Email Address", emailController),
          _buildPhoneRow(),
          _buildInfoRow(Icons.wc_outlined, "Gender", genderController),
        ]),
        const SizedBox(height: 24),
        _buildInfoCard("Address Details", [
          _buildInfoRow(Icons.location_city_outlined, "City", cityNameController),
          _buildInfoRow(Icons.location_on_outlined, "Street Address", streetNameController),
          _buildInfoRow(Icons.flag_outlined, "Country", countryNameController),
          _buildInfoRow(Icons.pin_drop_outlined, "Post Code", pincodeController),
        ]),
      ],
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.btnColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    title == "Personal Information" 
                        ? Icons.person_outline 
                        : Icons.business_outlined,
                    color: AppColors.btnColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          isEditing
              ? TextField(
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: AppColors.btnColor, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                )
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    _getDisplayText(controller.text),
                    style: TextStyle(
                      fontSize: 16,
                      color: _hasValidData(controller.text)
                          ? Colors.black87 
                          : Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildPhoneRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.phone_outlined,
                size: 20,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 10),
              Text(
                'Phone Number',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          isEditing
              ? Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextField(
                        controller: countryCodeController,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          isDense: true,
                          prefixText: '+',
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: AppColors.btnColor, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: mobileNoController,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: AppColors.btnColor, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    "${countryCodeController.text.isNotEmpty ? '+${countryCodeController.text}' : ''} ${mobileNoController.text}".trim().isEmpty 
                        ? 'Not provided'
                        : "${countryCodeController.text.isNotEmpty ? '+${countryCodeController.text}' : ''} ${mobileNoController.text}".trim(),
                    style: TextStyle(
                      fontSize: 16,
                      color: "${countryCodeController.text} ${mobileNoController.text}".trim().isEmpty 
                          ? Colors.grey.shade500 
                          : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
        ],
      ),
    );
  }



  // Helper methods to check for placeholder values
  bool _hasValidData(String text) {
    if (text.isEmpty) return false;
    
    // List of placeholder values that should be treated as "not provided"
    final placeholders = [
      'No Company',
      'No Street',
      'No City',
      'No Country',
      'Not Specified',
      'Unknown',
      'No Email',
    ];
    
    return !placeholders.contains(text);
  }

  String _getDisplayText(String text) {
    return _hasValidData(text) ? text : 'Not provided';
  }
}
