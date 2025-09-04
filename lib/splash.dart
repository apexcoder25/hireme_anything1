import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Auth/agree.dart';
import 'package:hire_any_thing/data/session_manage/session_user_side_manage.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_profile_controller.dart';
import 'package:hire_any_thing/res/routes/routes.dart';
import 'package:hire_any_thing/views/Introduction/introduction_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Show splash for minimum duration
    await Future.delayed(const Duration(seconds: 3));
    
    try {
      await _checkAppState();
    } catch (e) {
      // Handle errors gracefully
      debugPrint('Error during app initialization: $e');
      _navigateToDefault();
    }
  }

  Future<void> _checkAppState() async {
    final sessionManager = SessionManageerUserSide();
    
    // Check if user has seen onboarding
    final bool hasSeenOnboarding = await sessionManager.getHasSeenOnboarding();
    
    if (!hasSeenOnboarding) {
      _navigateToOnboarding();
      return;
    }

    // Check user authentication
    final String userId = await sessionManager.getUserId();
    final String token = await sessionManager.getToken() ?? "";
    final String roleType = await sessionManager.getRoleType();
    
    debugPrint("userId=> $userId");
    debugPrint("token=> ${token.isNotEmpty ? 'Present' : 'Empty'}");
    debugPrint("roleType=> $roleType");

    // If user has both userId and token, they are logged in
    if (userId.isNotEmpty && token.isNotEmpty) {
      await _validateAndNavigateUser(roleType, userId, token);
    } else {
      // User not logged in, go to agree/login screen
      debugPrint("User not logged in - missing userId or token");
      _navigateToLogin();
    }
  }

  Future<void> _validateAndNavigateUser(String roleType, String userId, String token) async {
    try {
      // Initialize or get existing profile controller
      UserProfileController profileController;
      try {
        profileController = Get.find<UserProfileController>();
      } catch (e) {
        profileController = Get.put(UserProfileController());
      }

      // Refresh token and fetch profile to validate session
      await profileController.refreshToken();
      await profileController.fetchProfile();

      // Check if profile fetch was successful
      if (profileController.isLogin.value && profileController.profile.value != null) {
        debugPrint("User authenticated successfully, navigating to home");
        _navigateBasedOnRole(roleType, userId);
      } else {
        debugPrint("Profile fetch failed, session might be expired");
        // Clear invalid session and go to login
        await _clearSessionAndLogin();
      }
    } catch (e) {
      debugPrint("Error validating user session: $e");
      await _clearSessionAndLogin();
    }
  }

  Future<void> _clearSessionAndLogin() async {
    try {
      final sessionManager = SessionManageerUserSide();
      await sessionManager.removeToken();
      // Clear other session data if needed
      
      // Also clear profile controller state
      try {
        final profileController = Get.find<UserProfileController>();
        await profileController.logout();
      } catch (e) {
        // Controller might not exist, which is fine
      }
    } catch (e) {
      debugPrint("Error clearing session: $e");
    }
    
    _navigateToLogin();
  }

  void _navigateToOnboarding() {
    if (!mounted) return;
    
    debugPrint("Navigating to onboarding");
    Get.offAllNamed(UserRoutesName.introScreen);
  }

  void _navigateBasedOnRole(String roleType, String userId) {
    if (!mounted) return;

    // If roleType is empty or null, but we have userId, assume user role
    if (roleType.isEmpty || roleType.toLowerCase() == 'null') {
      debugPrint("Role type is empty/null, but user is authenticated. Assuming user role.");
      Get.offAllNamed(UserRoutesName.homeUserView);
      return;
    }

    switch (roleType.toLowerCase().trim()) {
      case "user":
        debugPrint("Navigating to user home");
        Get.offAllNamed(UserRoutesName.homeUserView);
        break;
      case "vendor":
        debugPrint("Navigating to vendor home");
        Get.offAllNamed(VendorRoutesName.homeVendorView);
        break;
      default:
        debugPrint("Unknown role: $roleType, defaulting to user home");
        // For unknown roles but valid authentication, default to user home
        Get.offAllNamed(UserRoutesName.homeUserView);
    }
  }

  void _navigateToLogin() {
    if (!mounted) return;
    
    debugPrint("Navigating to login screen");
    // Navigate to agree screen (which leads to login)
    Get.offAll(() => const Agree_screen());
  }

  void _navigateToDefault() {
    if (!mounted) return;
    
    debugPrint("Navigating to default (onboarding)");
    // In case of error, show onboarding
    Get.offAll(() => IntroductionScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/app_logo/SH.png",
              height: 260,
              width: 320,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 260,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey,
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 16),
            const Text(
              'Loading...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
