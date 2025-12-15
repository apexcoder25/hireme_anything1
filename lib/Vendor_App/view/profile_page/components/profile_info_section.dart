import 'package:flutter/material.dart';
import 'package:hire_any_thing/utilities/colors.dart';
import 'package:hire_any_thing/constants_file/uk_cities.dart';

class ProfileInfoSection extends StatefulWidget {
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
  State<ProfileInfoSection> createState() => _ProfileInfoSectionState();
}

class _ProfileInfoSectionState extends State<ProfileInfoSection> {
  List<String> _filteredCities = [];
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _filteredCities = Cities.ukCities;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _onCityTextChanged(String query) {
    if (!mounted) return;
    
    setState(() {
      if (query.isEmpty) {
        _filteredCities = Cities.ukCities;
      } else {
        _filteredCities = Cities.ukCities
            .where((city) => city.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });

    if (widget.isEditing && _filteredCities.isNotEmpty && query.isNotEmpty) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _showOverlay() {
    _removeOverlay();
    
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 96, // Accounting for padding
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 60),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _filteredCities.length > 50 ? 50 : _filteredCities.length,
                itemBuilder: (context, index) {
                  final city = _filteredCities[index];
                  return InkWell(
                    onTap: () {
                      widget.cityNameController.text = city;
                      _removeOverlay();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade200,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Text(
                        city,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _showSuggestions = true;
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _showSuggestions = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInfoCard("Personal Information", [
          _buildInfoRow(Icons.person_outline, "Full Name", widget.nameController, false),
          _buildInfoRow(Icons.email_outlined, "Email Address", widget.emailController, false),
          _buildPhoneRow(),
          _buildInfoRow(Icons.wc_outlined, "Gender", widget.genderController, false),
        ]),
        const SizedBox(height: 24),
        _buildInfoCard("Address Details", [
          _buildCityRow(),
          _buildInfoRow(Icons.location_on_outlined, "Street Address", widget.streetNameController, false),
          _buildInfoRow(Icons.flag_outlined, "Country", widget.countryNameController, false),
          _buildInfoRow(Icons.pin_drop_outlined, "Post Code", widget.pincodeController, false),
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

  Widget _buildCityRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_city_outlined,
                size: 20,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 10),
              Text(
                'City',
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
          widget.isEditing
              ? CompositedTransformTarget(
                  link: _layerLink,
                  child: TextField(
                    controller: widget.cityNameController,
                    onChanged: _onCityTextChanged,
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
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey.shade600,
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
                    onTap: () {
                      if (_filteredCities.isNotEmpty) {
                        _showOverlay();
                      }
                    },
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
                    _getDisplayText(widget.cityNameController.text),
                    style: TextStyle(
                      fontSize: 16,
                      color: _hasValidData(widget.cityNameController.text)
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

  Widget _buildInfoRow(IconData icon, String label, TextEditingController controller, bool isCity) {
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
          widget.isEditing
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
          widget.isEditing
              ? Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextField(
                        controller: widget.countryCodeController,
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
                        controller: widget.mobileNoController,
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
                    "${widget.countryCodeController.text.isNotEmpty ? '+${widget.countryCodeController.text}' : ''} ${widget.mobileNoController.text}".trim().isEmpty 
                        ? 'Not provided'
                        : "${widget.countryCodeController.text.isNotEmpty ? '+${widget.countryCodeController.text}' : ''} ${widget.mobileNoController.text}".trim(),
                    style: TextStyle(
                      fontSize: 16,
                      color: "${widget.countryCodeController.text} ${widget.mobileNoController.text}".trim().isEmpty 
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
