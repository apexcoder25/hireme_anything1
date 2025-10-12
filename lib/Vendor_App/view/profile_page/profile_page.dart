import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/image_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/components/document_upload_section.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/components/profile_header.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/components/profile_info_section.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/components/vehicle_gallery_section.dart';
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
    imgController.setVendorImage(profile.vendorImage);
    imgController.setVehicleImages(profile.vehicleImages);
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
    return Scaffold(
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
                      isEditing: isEditing,
                      nameController: nameController,
                      emailController: emailController,
                      mobileNoController: mobileNoController,
                      countryCodeController: countryCodeController,
                      genderController: genderController,
                      companyNameController: companyNameController,
                      cityNameController: cityNameController,
                      streetNameController: streetNameController,
                      countryNameController: countryNameController,
                      pincodeController: pincodeController,
                      descriptionController: descriptionController,
                    ),
                    const SizedBox(height: 24),
                    DocumentUploadSection(
                      isEditing: isEditing,
                      docController: docController,
                    ),
                    const SizedBox(height: 24),
                    VehicleGallerySection(
                      isEditing: isEditing,
                      imgController: imgController,
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
