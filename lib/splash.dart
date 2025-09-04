import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Auth/agree.dart';
import 'package:hire_any_thing/data/session_manage/session_user_side_manage.dart';
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

    // Check user authentication and role
    final String userId = await sessionManager.getUserId();
    final String roleType = await sessionManager.getRoleType();
    
    debugPrint("roleType=> $roleType and userId=> $userId");

    // Navigate based on authentication and role
    if (userId.isNotEmpty && roleType.isNotEmpty) {
      _navigateBasedOnRole(roleType);
    } else {
      // User not logged in, go to agree/login screen
      _navigateToLogin();
    }
  }

  void _navigateToOnboarding() {
    if (!mounted) return;
    
    Get.offAllNamed(UserRoutesName.introScreen);
  }

  void _navigateBasedOnRole(String roleType) {
    if (!mounted) return;

    switch (roleType.toLowerCase().trim()) {
      case "user":
        Get.offAllNamed(UserRoutesName.homeUserView);
        break;
      case "vendor":
        Get.offAllNamed(VendorRoutesName.homeVendorView);
        break;
      default:
        // Unknown role, go to login
        _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    if (!mounted) return;
    
    // Navigate to agree screen (which leads to login)
    Get.offAll(() => const Agree_screen());
  }

  void _navigateToDefault() {
    if (!mounted) return;
    
    // In case of error, show onboarding
    Get.offAll(() =>  IntroductionScreen());
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
