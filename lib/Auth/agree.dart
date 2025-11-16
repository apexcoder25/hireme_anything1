import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/res/routes/routes.dart';

import '../utilities/colors.dart';
import '../utilities/custom_indicator.dart';

class Agree_screen extends StatefulWidget {
  const Agree_screen({super.key});

  @override
  State<Agree_screen> createState() => _Agree_screenState();
}

class _Agree_screenState extends State<Agree_screen> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  List description = [
    "Ride Your Way",
    "Drive Your Dreams",
    "Unlock The Road",
  ];
  int _currentPage = 0;
  var chekbox = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [
            // Top section with vehicle image and carousel
            Container(
              height: screenHeight * 0.55,
              color: Colors.white,
              child: Stack(
                children: [
                  // Premium Badge
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 10,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        "Premium",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 50,
                    ),
                    child: Column(
                      children: [
                        // Vehicle Image
                        Container(
                          height: 200,
                          width: screenWidth * 0.9,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/new/limousine.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Carousel
                        SizedBox(
                          width: screenWidth,
                          height: 100,
                          child: CarouselSlider.builder(
                              itemCount: 3,
                              itemBuilder: (context, index, realIndex) {
                                return Container(
                                  width: screenWidth,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Welcome to",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: AppColors.textPrimary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            " HireAnything",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: AppColors.blueAccent2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        description[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                viewportFraction: 1.0,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 4),
                                enlargeCenterPage: true,
                                aspectRatio: 4.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentPage = index;
                                  });
                                },
                              )),
                        ),
                        const SizedBox(height: 15),

                        // Page Indicator
                        CustomPageIndicator(
                          currentPage: _currentPage,
                          itemCount: 3,
                          dotColor: Colors.grey.shade300,
                          activeDotColor: AppColors.primaryDark,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom white container with buttons
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),

                    // Sign in as User Button
                    InkWell(
                      onTap: () {
                        Get.toNamed('/auth', arguments: {'initialTab': 'login'});
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.primaryDark,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryDark.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Sign in as an user",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Sign up as User Button
                    InkWell(
                      onTap: () {
                        Get.toNamed('/auth', arguments: {'initialTab': 'register'});
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.disabledBtnColor,
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_add,
                              color: Colors.grey.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Sign up as an user",
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Join as Partner Button
                    InkWell(
                      onTap: () {
                        Get.toNamed(VendorRoutesName.loginVendorView);
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.handshake,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Join as Partner",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Terms and Conditions
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          activeColor: AppColors.primary,
                          side: BorderSide(
                              color: chekbox == true
                                  ? AppColors.primary
                                  : Colors.red),
                          value: chekbox,
                          onChanged: (value) {
                            setState(() {
                              chekbox = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: RichText(
                                text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                        height: 1.4,
                                        color: chekbox == true
                                            ? Colors.grey.shade600
                                            : Colors.red)),
                                TextSpan(
                                    text: "terms and conditions",
                                    style: TextStyle(
                                        color: chekbox == true
                                            ? AppColors.primary
                                            : Colors.red,
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.solid)),
                                TextSpan(
                                    text: ", ",
                                    style: TextStyle(
                                        color: chekbox == true
                                            ? Colors.grey.shade600
                                            : Colors.red)),
                                TextSpan(
                                    text: "privacy policy",
                                    style: TextStyle(
                                        color: chekbox == true
                                            ? AppColors.primary
                                            : Colors.red,
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.solid)),
                                TextSpan(
                                    text: " and ",
                                    style: TextStyle(
                                        color: chekbox == true
                                            ? Colors.grey.shade600
                                            : Colors.red)),
                                TextSpan(
                                    text: "consent",
                                    style: TextStyle(
                                        color: chekbox == true
                                            ? AppColors.primary
                                            : Colors.red,
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.solid)),
                                TextSpan(
                                    text: " for accessing the services.",
                                    style: TextStyle(
                                        color: chekbox == true
                                            ? Colors.grey.shade600
                                            : Colors.red)),
                              ],
                            )),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(String title, String text) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
