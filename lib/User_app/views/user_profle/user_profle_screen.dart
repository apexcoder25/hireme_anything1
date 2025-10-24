import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Auth/agree.dart';
import 'package:hire_any_thing/User_app/views/user_profle/controller/user_profile_controller.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with TickerProviderStateMixin {
  final UserProfileController profileController =
      Get.put(UserProfileController());
  bool isEditing = false;
  bool _animationsInitialized = false;

  late AnimationController _animationController;
  late AnimationController _editButtonController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _editButtonAnimation;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();

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

    _animationsInitialized = true;
  }

  void _initializeController() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.fetchProfile();
      _animationController.forward();
      _editButtonController.forward();

      ever(profileController.profile, (profile) {
        if (profile?.data != null) {
          _populateControllers(profile?.data);
        }
      });
    });
  }

  void _populateControllers(dynamic profileData) {
    firstNameController.text = profileData.firstName ?? '';
    lastNameController.text = profileData.lastName ?? '';
    emailController.text = profileData.email ?? '';
    mobileController.text = profileData.mobileNo ?? '';
    countryCodeController.text = profileData.countryCode ?? '';
  }

  @override
  void dispose() {
    if (_animationsInitialized) {
      _animationController.dispose();
      _editButtonController.dispose();
    }
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    countryCodeController.dispose();
  }

  void _toggleEditMode() async {
    if (isEditing) {
      await _saveProfile();
    }

    setState(() {
      isEditing = !isEditing;
    });

    if (_animationsInitialized) {
      _editButtonController.reset();
      _editButtonController.forward();
    }
  }

  Future<void> _saveProfile() async {
    final success = await profileController.updateProfile(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      mobileNo: mobileController.text.trim(),
      countryCode: countryCodeController.text.trim(),
    );

    if (!success) {
      setState(() {
        isEditing = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      floatingActionButton: _buildFloatingEditButton(),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return _buildLoadingWidget();
        }
        if (!profileController.isLogin.value ||
            profileController.profile.value == null ||
            profileController.profile.value!.data == null) {
          return _buildErrorWidget();
        }
        return _buildProfileContent(profileController.profile.value!.data!);
      }),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
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

  Widget _buildErrorWidget() {
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
                Icons.person_off_outlined,
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
              "Please log in to view your profile information.",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Get.offAll(() => const Agree_screen()),
              icon: const Icon(Icons.login, size: 22),
              label: const Text(
                "Login / Sign Up",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
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

  Widget _buildProfileContentWithoutAnimation(dynamic profileData) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 260,
          floating: false,
          pinned: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            background: _buildProfileHeader(profileData),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildProfileInfoSection(profileData),
              const SizedBox(height: 4),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileContent(dynamic profileData) {
    if (!_animationsInitialized) {
      return _buildProfileContentWithoutAnimation(profileData);
    }

    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildProfileHeader(profileData),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildProfileInfoSection(profileData),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(dynamic profileData) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildEditableAvatar(),
            const SizedBox(height: 4),
            _buildBasicInfo(profileData),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableAvatar() {
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
            child: Container(
              color: Colors.grey.shade100,
              child: Icon(
                Icons.person_outline,
                size: 50,
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ),
        // Edit indicator
        if (isEditing)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
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
      ],
    );
  }

  Widget _buildBasicInfo(dynamic profileData) {
    String fullName = _getFullName(profileData);

    return Column(
      children: [
        // Name
        Text(
          fullName.isNotEmpty ? fullName : "User Profile",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProfileInfoSection(dynamic profileData) {
    return _buildInfoCard(
        "Personal Information",
        [
          _buildInfoRow(Icons.person_outline, "Name", firstNameController,
              secondController: lastNameController),
          _buildInfoRow(Icons.email_outlined, "Email Address", emailController),
          _buildPhoneRow(),
        ],
        Icons.person_outline,
        Colors.blue.shade600);
  }

  Widget _buildInfoCard(String title, List<Widget> children, IconData titleIcon,
      Color accentColor) {
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
                    color: accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    titleIcon,
                    color: accentColor,
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

  Widget _buildInfoRow(
      IconData icon, String label, TextEditingController controller,
      {TextEditingController? secondController}) {
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

          // If secondController is provided, show two fields side by side (for first and last name)
          if (secondController != null && isEditing)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'First Name',
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
                        borderSide:
                            BorderSide(color: Colors.blue.shade600, width: 2),
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
                    controller: secondController,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Last Name',
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
                        borderSide:
                            BorderSide(color: Colors.blue.shade600, width: 2),
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

          // If secondController is provided but not editing, show combined display
          else if (secondController != null && !isEditing)
            Container(
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
                _getCombinedText(controller, secondController),
                style: TextStyle(
                  fontSize: 16,
                  color: _getCombinedText(controller, secondController) !=
                          'Not provided'
                      ? Colors.black87
                      : Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )

          // Single field (normal case)
          else
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
                        borderSide:
                            BorderSide(color: Colors.blue.shade600, width: 2),
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
                      controller.text.isNotEmpty
                          ? controller.text
                          : 'Not provided',
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

// Helper method to combine first and last name
  String _getCombinedText(TextEditingController firstController,
      TextEditingController secondController) {
    String firstName = firstController.text.trim();
    String lastName = secondController.text.trim();
    String combined = '$firstName $lastName'.trim();

    return combined.isNotEmpty ? combined : 'Not provided';
  }

  Widget _buildReadOnlyInfoRow(IconData icon, String label, String value) {
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
          Container(
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
              value.isNotEmpty ? value : 'Not provided',
              style: TextStyle(
                fontSize: 16,
                color: value.isNotEmpty ? Colors.black87 : Colors.grey.shade500,
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
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                        ],
                        decoration: InputDecoration(
                          isDense: true,
                          prefixText: countryCodeController.text.startsWith('+')
                              ? ''
                              : '+',
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
                            borderSide: BorderSide(
                                color: Colors.blue.shade600, width: 2),
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
                        controller: mobileController,
                        style: const TextStyle(fontSize: 16),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
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
                            borderSide: BorderSide(
                                color: Colors.blue.shade600, width: 2),
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
                    _getMobileNumber(),
                    style: TextStyle(
                      fontSize: 16,
                      color: _getMobileNumber() == 'Not provided'
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

  Widget _buildFloatingEditButtonWithoutAnimation() {
    return Obx(() => FloatingActionButton.extended(
          onPressed: profileController.isLoading.value ? null : _toggleEditMode,
          backgroundColor:
              isEditing ? Colors.green.shade600 : Colors.blue.shade600,
          foregroundColor: Colors.white,
          elevation: 12,
          heroTag: "edit_profile",
          label: profileController.isLoading.value
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Row(
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
        ));
  }

  Widget _buildFloatingEditButton() {
    if (!_animationsInitialized) {
      return _buildFloatingEditButtonWithoutAnimation();
    }

    return AnimatedBuilder(
      animation: _editButtonAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _editButtonAnimation.value,
          child: Obx(() => FloatingActionButton.extended(
                onPressed:
                    profileController.isLoading.value ? null : _toggleEditMode,
                backgroundColor:
                    isEditing ? Colors.green.shade600 : Colors.blue.shade600,
                foregroundColor: Colors.white,
                elevation: 12,
                heroTag: "edit_profile",
                label: profileController.isLoading.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isEditing
                                ? Icons.save_outlined
                                : Icons.edit_outlined,
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
              )),
        );
      },
    );
  }

  String _getFullName(dynamic profileData) {
    String firstName = profileData.firstName ?? 'a';
    String lastName = profileData.lastName ?? '';
    String fullName = '$firstName $lastName'.trim();

    if (fullName.isEmpty) {
      return profileData.name ?? '';
    }

    return fullName;
  }

  String _getMobileNumber() {
    String countryCode = countryCodeController.text;
    String mobile = mobileController.text;

    if (countryCode.isEmpty && mobile.isEmpty) {
      return 'Not provided';
    }

    if (countryCode.isEmpty) {
      return mobile;
    }

    if (mobile.isEmpty) {
      return 'Not provided';
    }

    String formattedCode =
        countryCode.startsWith('+') ? countryCode : '+$countryCode';
    return '$formattedCode $mobile';
  }
}
