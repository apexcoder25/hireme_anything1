import 'dart:async';

import 'package:flutter/material.dart';
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
    Timer(const Duration(seconds: 4), () {
      Future.microtask(() => checkOnboardingAndLoginStatus());
    });
  }

  Future<void> checkOnboardingAndLoginStatus() async {
    final sessionManager = SessionManageerUserSide();
    final bool hasSeenOnboarding = await sessionManager.getHasSeenOnboarding();

    if (!hasSeenOnboarding) {
      // Show onboarding screen for first-time users
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => IntroductionScreen()),
        (route) => false,
      );
      return;
    }
    else{
      // Onboarding already seen, navigate to the main screen
      Navigator.pushNamed(
        context,
        UserRoutesName.homeUserView
      );
    }

    // Onboarding already seen, check login status and role type
    final String userId = await sessionManager.getUserId();
    final String roleType = await sessionManager.getRoleType();

    print("roleType=> $roleType and userId $userId");

  //   if (roleType == "user") {
  //     Get.offAll(() => Navi());
  //   } else if (roleType == "vendor") {
  //     Get.offAll(() => Nav_bar());
  //   } else {
  //     Get.offAll(() => Navi()); // Default to user navigation if no role
  //   }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f3),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/app_logo/SH.png",
                height: 260,
                width: 320,
              )
            ],
          ),
        ),
      ),
    );
  }
}