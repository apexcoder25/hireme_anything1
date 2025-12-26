import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/constants_file/uk_cities.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/utilities/colors.dart';

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
  final TextEditingController descriptionController;

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
    required this.descriptionController,
  });

  @override
  State<ProfileInfoSection> createState() => ProfileInfoSectionState();
}

class ProfileInfoSectionState extends State<ProfileInfoSection> {
  List<String> _filteredCities = [];
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  String? _selectedGender;

  // List of countries for dropdown
  final List<String> _countries = [
    'United Kingdom',
    'United States',
   
  ];

  // Email verification state
  bool isEmailEdited = false;
  bool showOtpField = false;
  bool isEmailVerified = false;
  String _originalEmail = '';
  final TextEditingController _otpController = TextEditingController();

  final ApiServiceVenderSide _apiService = Get.find<ApiServiceVenderSide>();

  @override
  void initState() {
    super.initState();
    _filteredCities = Cities.ukCities;
    _selectedGender = widget.genderController.text.isNotEmpty
        ? widget.genderController.text
        : null;

    // Initialize country if empty
    if (widget.countryNameController.text.isEmpty) {
      widget.countryNameController.text = 'United Kingdom';
    }

    // Save original email
    _originalEmail = widget.emailController.text.trim();

    // Listen for email changes
    widget.emailController.addListener(_onEmailChanged);
  }

  void _onEmailChanged() {
    final newEmail = widget.emailController.text.trim();
    if (newEmail != _originalEmail && newEmail.isNotEmpty) {
      setState(() {
        isEmailEdited = true;
        showOtpField = false;
        isEmailVerified = false;
      });
    } else {
      setState(() {
        isEmailEdited = false;
        showOtpField = false;
        isEmailVerified = true;
      });
    }
  }

  Future<void> _sendOtp() async {
    final email = widget.emailController.text.trim();
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      Get.snackbar("Invalid Email", "Please enter a valid email address");
      return;
    }

    final sent = await _apiService.sendOtpEmail(email);
    if (sent) {
      setState(() {
        showOtpField = true;
      });
    }
  }

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();
    final email = widget.emailController.text.trim();

    if (otp.length != 6) {
      Get.snackbar("Invalid OTP", "Please enter 6-digit OTP");
      return;
    }

    final verified = await _apiService.verifyOtpEmail(email, otp);
    if (verified) {
      setState(() {
        isEmailVerified = true;
        _originalEmail = email;
      });
      _otpController.clear();
    }
  }

  @override
  void dispose() {
    widget.emailController.removeListener(_onEmailChanged);
    _otpController.dispose();
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
        width: MediaQuery.of(context).size.width - 96,
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
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Text(city, style: const TextStyle(fontSize: 14)),
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
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.btnColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      filled: true,
      fillColor: Colors.grey.shade50,
    );
  }

  Widget _readOnlyContainer(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: text == 'Not provided' ? Colors.grey.shade500 : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInfoCard("Personal Information", [
          _buildInfoRow(Icons.person_outline, "Full Name", widget.nameController, false),
          _buildEmailRow(),
          _buildPhoneRow(),
          _buildGenderDropdown(),
          _buildDescriptionField(),
        ]),
        const SizedBox(height: 24),
        _buildInfoCard("Address Details", [
          _buildCityRow(),
          _buildInfoRow(Icons.location_on_outlined, "Street Address", widget.streetNameController, false),
          _buildCountryDropdown(), // Now fully selectable
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
                        : Icons.location_on_outlined,
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

  Widget _buildInfoRow(IconData icon, String label, TextEditingController controller, bool isCity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.grey.shade600),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 10),
          widget.isEditing
              ? TextField(
                  controller: controller,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  decoration: _inputDecoration(),
                )
              : _readOnlyContainer(controller.text.isEmpty ? 'Not provided' : controller.text),
        ],
      ),
    );
  }

  Widget _buildEmailRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.email_outlined, size: 20, color: Colors.grey.shade600),
              const SizedBox(width: 10),
              const Text('Email Address*',
                  style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 10),
          widget.isEditing
              ? TextField(
                  controller: widget.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration().copyWith(hintText: "Enter your email"),
                )
              : _readOnlyContainer(
                  widget.emailController.text.isEmpty ? 'Not provided' : widget.emailController.text),

          if (isEmailEdited || showOtpField)
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
              child: _buildEmailVerificationSection(),
            ),
        ],
      ),
    );
  }

  Widget _buildEmailVerificationSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        children: [
          if (!showOtpField)
            ElevatedButton.icon(
              onPressed: _sendOtp,
              icon: const Icon(Icons.send, size: 18),
              label: const Text("Verify Email"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
            ),

          if (showOtpField) ...[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "Enter OTP",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.green, width: 2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.all(16),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 24),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isEmailVerified)
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green.shade700, size: 28),
                  const SizedBox(width: 12),
                  Text(
                    "Verification Success\nOTP sent successfully!",
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
          ],
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
              Icon(Icons.phone_outlined, size: 20, color: Colors.grey.shade600),
              const SizedBox(width: 10),
              const Text('Phone Number',
                  style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600)),
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
                        decoration: _inputDecoration().copyWith(prefixText: '+'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: widget.mobileNoController,
                        decoration: _inputDecoration(),
                      ),
                    ),
                  ],
                )
              : _readOnlyContainer(
                  "${widget.countryCodeController.text.isNotEmpty ? '+${widget.countryCodeController.text}' : ''} ${widget.mobileNoController.text}".trim().isEmpty
                      ? 'Not provided'
                      : "${widget.countryCodeController.text.isNotEmpty ? '+${widget.countryCodeController.text}' : ''} ${widget.mobileNoController.text}".trim(),
                ),
        ],
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.wc_outlined, size: 20, color: Colors.grey.shade600),
              const SizedBox(width: 10),
              const Text('Gender',
                  style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 10),
          widget.isEditing
              ? DropdownButtonFormField<String>(
                  value: _selectedGender,
                  hint: const Text("Select Gender"),
                  items: _genders.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                      widget.genderController.text = value ?? '';
                    });
                  },
                  decoration: _inputDecoration(),
                )
              : _readOnlyContainer(widget.genderController.text.isEmpty ? 'Not provided' : widget.genderController.text),
        ],
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
              Icon(Icons.location_city_outlined, size: 20, color: Colors.grey.shade600),
              const SizedBox(width: 10),
              const Text('City',
                  style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 10),
          widget.isEditing
              ? CompositedTransformTarget(
                  link: _layerLink,
                  child: TextField(
                    controller: widget.cityNameController,
                    onChanged: _onCityTextChanged,
                    decoration: _inputDecoration().copyWith(
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                    ),
                    onTap: () {
                      if (_filteredCities.isNotEmpty) _showOverlay();
                    },
                  ),
                )
              : _readOnlyContainer(widget.cityNameController.text.isEmpty ? 'Not provided' : widget.cityNameController.text),
        ],
      ),
    );
  }

  // UPDATED: Now fully selectable country dropdown
  Widget _buildCountryDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.flag_outlined, size: 20, color: Colors.grey.shade600),
              const SizedBox(width: 10),
              Text('Country',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 10),
          widget.isEditing
              ? DropdownButtonFormField<String>(
                  value: widget.countryNameController.text.isEmpty
                      ? null
                      : widget.countryNameController.text,
                  hint: const Text("Select Country"),
                  items: _countries.map((country) {
                    return DropdownMenuItem(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      widget.countryNameController.text = value;
                    }
                  },
                  decoration: _inputDecoration(),
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                )
              : _readOnlyContainer(
                  widget.countryNameController.text.isEmpty ? 'Not provided' : widget.countryNameController.text),
        ],
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.description_outlined, size: 20, color: Colors.grey.shade600),
              const SizedBox(width: 10),
              const Text('Description',
                  style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 10),
          widget.isEditing
              ? TextField(
                  controller: widget.descriptionController,
                  maxLines: 5,
                  decoration: _inputDecoration(),
                )
              : _readOnlyContainer(
                  widget.descriptionController.text.isEmpty ? 'Not provided' : widget.descriptionController.text),
        ],
      ),
    );
  }
}