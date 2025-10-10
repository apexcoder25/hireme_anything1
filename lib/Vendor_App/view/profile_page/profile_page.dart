import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/upload_image.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/document_controller.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/profile_controller.dart';
import 'package:hire_any_thing/data/models/vender_side_model/profile_model.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/utilities/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  final apiService = Get.put(ApiServiceVenderSide(), tag: 'apiService');
  late final ProfileController controller;
  final ImageController imgcntroller = Get.put(ImageController(), tag: 'imageController');
  final DocumentController docController = Get.put(DocumentController(), tag: 'documentController');
  bool isEditing = false;

  late AnimationController _animationController;
  late AnimationController _editButtonController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _editButtonAnimation;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController cityNameController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController countryNameController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeController();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _editButtonController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _editButtonAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _editButtonController,
      curve: Curves.elasticOut,
    ));
  }

  void _initializeController() {
    controller = Get.put(ProfileController(apiService: apiService), tag: 'profileController');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
      _editButtonController.forward();
      
      ever(controller.profile, (ProfileModel? profile) {
        if (profile != null) {
          _populateControllers(profile);
        }
      });

      controller.fetchProfile();
    });
  }

  void _populateControllers(ProfileModel profile) {
    nameController.text = profile.name;
    emailController.text = profile.email;
    mobileNoController.text = profile.mobileNo;
    countryCodeController.text = profile.countryCode;
    companyNameController.text = profile.companyName;
    cityNameController.text = profile.cityName;
    streetNameController.text = profile.streetName;
    countryNameController.text = profile.countryName;
    pincodeController.text = profile.pincode;
    genderController.text = profile.gender;
    descriptionController.text = profile.description;

    docController.setDocumentsFromProfile(profile.legalDocuments);
    imgcntroller.setVendorImage(profile.vendorImage);
    imgcntroller.setVehicleImages(profile.vehicleImages);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _editButtonController.dispose();
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    mobileNoController.dispose();
    countryCodeController.dispose();
    companyNameController.dispose();
    cityNameController.dispose();
    streetNameController.dispose();
    countryNameController.dispose();
    pincodeController.dispose();
    genderController.dispose();
    descriptionController.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Error", "Could not open file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      floatingActionButton: _buildFloatingEditButton(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildLoadingState();
        }
        if (controller.profile.value == null) {
          return _buildErrorState();
        }
        var profile = controller.profile.value!;
        return _buildProfileContent(profile);
      }),
    );
  }

  Widget _buildFloatingEditButton() {
    return AnimatedBuilder(
      animation: _editButtonAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _editButtonAnimation.value,
          child: FloatingActionButton.extended(
            onPressed: _toggleEditMode,
            backgroundColor: isEditing ? Colors.green.shade600 : AppColors.btnColor,
            foregroundColor: Colors.white,
            elevation: 12,
            heroTag: "edit_profile",
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isEditing ? Icons.save_outlined : Icons.edit_outlined,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  isEditing ? 'Save Profile' : 'Edit Profile',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _toggleEditMode() async {
    if (isEditing) {
      await _saveProfile();
    }
    
    setState(() {
      isEditing = !isEditing;
    });
    
    _editButtonController.reset();
    _editButtonController.forward();
  }

  Future<void> _saveProfile() async {
    final profile = controller.profile.value!;
    
    final updatedProfile = ProfileModel(
      id: profile.id,
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      mobileNo: mobileNoController.text.trim(),
      countryCode: countryCodeController.text.trim(),
      companyName: companyNameController.text.trim(),
      streetName: streetNameController.text.trim(),
      cityName: cityNameController.text.trim(),
      countryName: countryNameController.text.trim(),
      pincode: pincodeController.text.trim(),
      gender: genderController.text.trim(),
      description: descriptionController.text.trim(),
      vendorImage: imgcntroller.vendorImage.value,
      legalDocuments: docController.uploadedDocumentUrls.toList(),
      vehicleImages: imgcntroller.vehicleImages.toList(),
    );

    await controller.updateProfile(
      updatedProfile,
      docController.uploadedDocumentUrls.toList(),
      imgcntroller.vehicleImages.toList(),
    );

    _showSuccessMessage();
  }

  void _showSuccessMessage() {
    Get.snackbar(
      'Profile Updated',
      'Your profile has been successfully updated',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      margin: const EdgeInsets.all(20),
      borderRadius: 12,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      shouldIconPulse: false,
      duration: const Duration(seconds: 3),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.btnColor),
              strokeWidth: 4,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Loading Profile...',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please wait while we fetch your information',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 20,
              offset: const Offset(0, 10),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 60,
                color: Colors.red.shade400,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Profile Unavailable",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "We couldn't load your profile data at this time. Please check your internet connection and try again.",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: controller.fetchProfile,
              icon: const Icon(Icons.refresh_rounded, size: 22),
              label: const Text(
                "Retry Loading",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.btnColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent(ProfileModel profile) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 308,
                floating: false,
                pinned: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildSimpleHeader(profile),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildInfoCard("Personal Information", [
                      _buildInfoRow(Icons.person_outline, "Full Name", nameController),
                      _buildInfoRow(Icons.email_outlined, "Email Address", emailController),
                      _buildPhoneRow(),
                      _buildInfoRow(Icons.wc_outlined, "Gender", genderController),
                    ]),
                    const SizedBox(height: 24),
                    _buildInfoCard("Business Information", [
                      _buildInfoRow(Icons.business_outlined, "Company Name", companyNameController),
                      _buildInfoRow(Icons.location_city_outlined, "City", cityNameController),
                      _buildInfoRow(Icons.location_on_outlined, "Street Address", streetNameController),
                      _buildInfoRow(Icons.flag_outlined, "Country", countryNameController),
                      _buildInfoRow(Icons.pin_drop_outlined, "Postal Code", pincodeController),
                      _buildDescriptionRow(),
                    ]),
                    const SizedBox(height: 24),
                    _buildDocumentCard(),
                    const SizedBox(height: 24),
                    _buildVehicleImageCard(),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSimpleHeader(ProfileModel profile) {
    return Container(
      decoration: const BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          // bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 40, 32, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileAvatar(),
              const SizedBox(height: 24),
              _buildBasicInfo(profile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Clean circular background
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade50,
            border: Border.all(
              color: Colors.grey.shade200,
              width: 2,
            ),
          ),
        ),
        // Avatar container
        Container(
          width: 108,
          height: 108,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipOval(
            child: imgcntroller.vendorImage.value.isNotEmpty
                ? Image.network(
                    imgcntroller.vendorImage.value,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(),
                  )
                : _buildDefaultAvatar(),
          ),
        ),
        // Edit indicator
        if (isEditing)
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                // Handle image picker
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.btnColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: Colors.grey.shade100,
      child: Icon(
        Icons.person_outline,
        size: 50,
        color: Colors.grey.shade400,
      ),
    );
  }

  Widget _buildBasicInfo(ProfileModel profile) {
    return Column(
      children: [
        // Name
        Text(
          profile.name.isNotEmpty ? profile.name : "Vendor Profile",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 12),
        
        // Email
        if (profile.email.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.email_outlined,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Text(
                  profile.email,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
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
                    controller.text.isNotEmpty ? controller.text : 'Not provided',
                    style: TextStyle(
                      fontSize: 16,
                      color: controller.text.isNotEmpty 
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

  Widget _buildDescriptionRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                size: 20,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 10),
              Text(
                'Business Description',
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
                  controller: descriptionController,
                  maxLines: 4,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(18),
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
                    hintText: 'Describe your business, services, and expertise...',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                  ),
                )
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    descriptionController.text.isNotEmpty 
                        ? descriptionController.text 
                        : 'No business description provided',
                    style: TextStyle(
                      fontSize: 16,
                      color: descriptionController.text.isNotEmpty 
                          ? Colors.black87 
                          : Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard() {
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
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.folder_open_outlined,
                    color: Colors.blue.shade600,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  "Legal Documents",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Obx(() => docController.uploadedDocumentUrls.isEmpty
                ? _buildEmptyDocumentsState()
                : _buildDocumentsList()),
            if (isEditing) ...[
              const SizedBox(height: 20),
              _buildUploadDocumentsButton(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyDocumentsState() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.description_outlined,
              size: 56,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            Text(
              "No Documents Available",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Upload your legal documents to complete your business profile",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentsList() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: List.generate(docController.uploadedDocumentUrls.length, (index) {
        final doc = docController.uploadedDocumentUrls[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Stack(
            children: [
              InkWell(
                onTap: () => _launchUrl(doc['url']!),
                borderRadius: BorderRadius.circular(14),
                child: Padding(
                  padding: EdgeInsets.all(isEditing ? 36 : 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.insert_drive_file_outlined,
                        color: Colors.blue.shade600,
                        size: 28,
                      ),
                      const SizedBox(width: 14),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 160),
                        child: Text(
                          doc['fileName'] ?? 'Business Document',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isEditing)
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => docController.removeDocument(index),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildUploadDocumentsButton() {
    return GestureDetector(
      onTap: docController.pickDocuments,
      child: DottedBorder(
        color: AppColors.btnColor,
        strokeWidth: 2,
        dashPattern: const [10, 5],
        borderType: BorderType.RRect,
        radius: const Radius.circular(14),
        child: Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.btnColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 40,
                  color: AppColors.btnColor,
                ),
                const SizedBox(height: 12),
                Text(
                  "Upload Legal Documents",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.btnColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "PDF, DOC, DOCX, PNG, JPG formats supported",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleImageCard() {
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
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.directions_car_outlined,
                    color: Colors.green.shade600,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  "Vehicle Gallery",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Obx(() => imgcntroller.vehicleImages.isEmpty
                ? _buildEmptyVehicleImagesState()
                : _buildVehicleImageGrid()),
            if (isEditing) ...[
              const SizedBox(height: 20),
              _buildUploadVehicleImagesButton(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyVehicleImagesState() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.image_outlined,
              size: 56,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            Text(
              "No Vehicle Images",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Showcase your fleet by uploading high-quality vehicle photos",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: imgcntroller.vehicleImages.length,
      itemBuilder: (context, index) {
        final url = imgcntroller.vehicleImages[index];
        return Stack(
          children: [
            GestureDetector(
              onTap: () => _launchUrl(url),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.grey.shade400,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (isEditing)
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => imgcntroller.removeVehicleImage(index),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildUploadVehicleImagesButton() {
    return GestureDetector(
      onTap: _showImageSourceBottomSheet,
      child: DottedBorder(
        color: AppColors.btnColor,
        strokeWidth: 2,
        dashPattern: const [10, 5],
        borderType: BorderType.RRect,
        radius: const Radius.circular(14),
        child: Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.btnColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 40,
                  color: AppColors.btnColor,
                ),
                const SizedBox(height: 12),
                const Text(
                  "Add Vehicle Photos",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.btnColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                 Text(
                  "JPG, PNG, JPEG formats supported",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImageSourceBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Select Image Source',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildImageSourceOption(
                    icon: Icons.camera_alt_outlined,
                    title: 'Camera',
                    subtitle: 'Take a new photo',
                    onTap: () {
                      imgcntroller.pickVehicleImages(true);
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildImageSourceOption(
                    icon: Icons.photo_library_outlined,
                    title: 'Gallery',
                    subtitle: 'Choose from existing photos',
                    onTap: () {
                      imgcntroller.pickVehicleImages(false);
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.btnColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: AppColors.btnColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}