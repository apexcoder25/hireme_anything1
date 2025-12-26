import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/image_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/components/profile_header.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/components/profile_info_section.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/widgets/floating_edit_button.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/widgets/profile_error_widget.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/widgets/profile_loading_widget.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/document_controller.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/profile_controller.dart';
import 'package:hire_any_thing/data/models/vender_side_model/profile_model.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  final apiService = Get.put(ApiServiceVenderSide(), tag: 'apiService');
  late final ProfileController controller;
  final ImageController imgController = Get.put(ImageController(), tag: 'imageController');
  final DocumentController docController = Get.put(DocumentController(), tag: 'documentController');
  bool isEditing = false;
  bool openedFromValidation = false;
  final GlobalKey<ProfileInfoSectionState> _infoSectionKey = GlobalKey<ProfileInfoSectionState>();

  late AnimationController _animationController;
  late AnimationController _editButtonController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _editButtonAnimation;

  Worker? _profileWorker;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController cityNameController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController countryNameController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Public GlobalKey to access ProfileInfoSection state safely
  

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

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _editButtonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _editButtonController, curve: Curves.elasticOut),
    );
  }

  void _initializeController() {
    if (Get.isRegistered<ProfileController>(tag: 'profileController')) {
      controller = Get.find<ProfileController>(tag: 'profileController');
      controller.fetchProfile();
    } else {
      controller = Get.put(ProfileController(apiService: apiService), tag: 'profileController');
    }

    final args = Get.arguments;
    if (args != null && args is Map) {
      if (args['openCompanyInfo'] == true || args['openBankDetails'] == true) {
        openedFromValidation = true;
        isEditing = true;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
      _editButtonController.forward();

      if (controller.profile.value != null) {
        _populateControllers(controller.profile.value!);
      }

      _profileWorker = ever(controller.profile, (ProfileModel? profile) {
        if (profile != null && mounted) {
          _populateControllers(profile);
        }
      });
    });
  }

  void _populateControllers(ProfileModel profile) {
    if (!mounted) return;

    nameController.text = profile.name ?? '';
    emailController.text = profile.email ?? '';
    mobileNoController.text = profile.mobileNo ?? '';
    countryCodeController.text = profile.countryCode ?? '';
    cityNameController.text = profile.cityName ?? '';
    streetNameController.text = profile.streetName ?? '';
    countryNameController.text = profile.countryName ?? 'United Kingdom';
    pincodeController.text = profile.pincode ?? '';
    genderController.text = profile.gender ?? '';
    descriptionController.text = profile.description ?? '';

    docController.setDocumentsFromProfile(profile.legalDocuments ?? []);
    imgController.setVendorImage(profile.vendorImage ?? '');
    imgController.setVehicleImages(profile.vehicleImages ?? []);
  }

  @override
  void dispose() {
    _profileWorker?.dispose();
    _animationController.dispose();
    _editButtonController.dispose();
    nameController.dispose();
    emailController.dispose();
    mobileNoController.dispose();
    countryCodeController.dispose();
    cityNameController.dispose();
    streetNameController.dispose();
    countryNameController.dispose();
    pincodeController.dispose();
    genderController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _toggleEditMode() async {
    if (isEditing) {
      if (openedFromValidation && !_validateRequiredFields()) {
        Get.snackbar(
          'Required Information',
          'Please fill in all required company information fields',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      await _saveProfile();
    }

    setState(() {
      isEditing = !isEditing;
    });

    _editButtonController.reset();
    _editButtonController.forward();
  }

  bool _validateRequiredFields() {
    return cityNameController.text.trim().isNotEmpty &&
           streetNameController.text.trim().isNotEmpty;
  }
Future<void> _saveProfile() async {
  final currentProfile = controller.profile.value!;
  final oldEmail = currentProfile.email?.trim().toLowerCase() ?? '';
  final newEmail = emailController.text.trim().toLowerCase();

  // Check if email changed
  if (oldEmail != newEmail && newEmail.isNotEmpty) {
    final state = _infoSectionKey.currentState;
    if (state is ProfileInfoSectionState) {
      if (!state.isEmailVerified) {
        Get.snackbar(
          "Email Verification Required",
          "Please verify your new email address before saving.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
        return;
      }
    }
  }

  // Proceed with saving...
  final updatedProfile = ProfileModel(
    id: currentProfile.id,
    name: nameController.text.trim(),
    email: emailController.text.trim(),
    mobileNo: mobileNoController.text.trim(),
    countryCode: countryCodeController.text.trim(),
    companyName: currentProfile.companyName,
    streetName: streetNameController.text.trim(),
    cityName: cityNameController.text.trim(),
    countryName: countryNameController.text.trim(), // From dropdown
    pincode: pincodeController.text.trim(),
    gender: genderController.text.trim(),
    description: descriptionController.text.trim(),
    vendorImage: imgController.vendorImage.value,
    legalDocuments: docController.uploadedDocumentUrls.toList(),
    vehicleImages: imgController.vehicleImages.toList(),
  );

  await controller.updateProfile(
    updatedProfile,
    docController.uploadedDocumentUrls.toList(),
    imgController.vehicleImages.toList(),
  );
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (openedFromValidation && !_validateRequiredFields()) {
          Get.snackbar(
            'Required Information',
            'Please complete all required company information before going back',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        floatingActionButton: FloatingEditButton(
          isEditing: isEditing,
          animation: _editButtonAnimation,
          onToggle: _toggleEditMode,
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const ProfileLoadingWidget();
          }
          if (controller.profile.value == null) {
            return ProfileErrorWidget(onRetry: controller.fetchProfile);
          }
          return _buildProfileContent(controller.profile.value!);
        }),
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
                expandedHeight: 280,
                floating: false,
                pinned: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: ProfileHeader(
                    profile: profile,
                    isEditing: isEditing,
                    imgController: imgController,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    ProfileInfoSection(
                      key: _infoSectionKey, // Attach the key here
                      isEditing: isEditing,
                      nameController: nameController,
                      emailController: emailController,
                      mobileNoController: mobileNoController,
                      countryCodeController: countryCodeController,
                      genderController: genderController,
                      cityNameController: cityNameController,
                      streetNameController: streetNameController,
                      countryNameController: countryNameController,
                      pincodeController: pincodeController,
                      descriptionController: descriptionController,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}