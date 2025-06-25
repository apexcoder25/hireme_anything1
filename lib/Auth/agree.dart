import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Auth/login.dart';
import 'package:hire_any_thing/res/routes/routes.dart';

import '../utilities/constant.dart';
import '../utilities/custom_indicator.dart';

class Agree_screen extends StatefulWidget {
  const Agree_screen({super.key});

  @override
  State<Agree_screen> createState() => _Agree_screenState();
}

class _Agree_screenState extends State<Agree_screen> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  final TextEditingController _phoneNumberController = TextEditingController();
  String? _phoneNumberError;

  void _validatePhoneNumber(String value) {
    if (value.length != 10) {
      setState(() {
        _phoneNumberError = "Please enter valid mobile number";
      });
    } else {
      setState(() {
        _phoneNumberError = null;
      });
    }
  }

  List description = [
    {
      "title": "Ride Your Way",
      "des":
          "we have the perfect vehicle for every adventure! Discover freedom on the road today!",
    },
    {
      "title": "Drive Your Dreams",
      "des":
          "Explore our diverse fleet of cars and vehicles tailored for every journey. Your perfect ride awaits!"
    },
    {
      "title": "Unlock the Road",
      "des":
          "Choose from a wide range of vehicles for every occasion. Adventure starts with the right ride!"
    },
  ];
  int _currentPage = 0;
  var chekbox = true;
  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;
    // final isPortrait =
    //     MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 24,
                    ),
                    Image.asset(
                      "assets/new/limousine.jpg", height: 250, fit: BoxFit.fill,
                      scale: 1.2,
                      // color: Colors.white,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 5.5,
                      child: CarouselSlider.builder(
                          itemCount: 3,
                          itemBuilder: (context, index, realIndex) {
                            // print("index=>${index}");
                            // print("realIndex=>${realIndex}");
                            return InkWell(
                              onTap: () async {},
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
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
                                            color: kblackTextColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          " Hire Anything",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: kSecondaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    _buildPage(
                                        "${description[index]["title"].toString()}",
                                        "${description[index]["des"].toString()}")
                                  ],
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            viewportFraction: 1.0,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 1.40,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    CustomPageIndicator(
                      currentPage: _currentPage,
                      itemCount: 3, // Replace 3 with your actual item count
                      dotColor: Colors.grey, // Customize dot color
                      activeDotColor: Colors.blue, // Customize active dot color
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 32,
                    // ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 250),
                              pageBuilder: (_, __, ___) => LoginView(),
                              transitionsBuilder: (_, animation, __, child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset(
                                        1.0, 0.0), // Start position off-screen
                                    end: Offset.zero, // End position on-screen
                                  ).animate(animation),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(UserRoutesName.loginUserView);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25),
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: kPrimaryColor.withOpacity(0.5),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                      child: Text(
                                    "Sign in as an user",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                Get.toNamed(UserRoutesName.registerUserView);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25),
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: kPrimaryColor.withOpacity(0.5),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                      child: Text(
                                    "Sign up as an user",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                 Get.toNamed(VendorRoutesName.loginVendorView);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25),
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: kPrimaryColor.withOpacity(0.5),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                      child: Text(
                                    "Sign in as a Partner/Vendor",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                Get.toNamed(VendorRoutesName.registerVendorView);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25),
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: kPrimaryColor.withOpacity(0.5),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                      child: Text(
                                    "Sign up as a Partner/Vendor",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            activeColor: kPrimaryColor,
                            side: BorderSide(
                                color: chekbox == true
                                    ? kPrimaryColor
                                    : Colors.red),
                            value: chekbox,
                            onChanged: (value) {
                              setState(() {
                                chekbox = value!;
                              });
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.35,
                            child: RichText(
                                maxLines: 2,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "I agree to the ",
                                        style: TextStyle(
                                            height: 2,
                                            color: chekbox == true
                                                ? Colors.grey
                                                : Colors.red)),
                                    TextSpan(
                                        text:
                                            "Terms & Conditions, Privacy Policy",
                                        style: TextStyle(
                                            color: chekbox == true
                                                ? kPrimaryColor
                                                : Colors.red,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationStyle:
                                                TextDecorationStyle.solid)),
                                    TextSpan(
                                        text: " and ",
                                        style: TextStyle(
                                            height: 1.5,
                                            color: chekbox == true
                                                ? Colors.grey
                                                : Colors.red)),
                                    TextSpan(
                                        text: "Consent",
                                        style: TextStyle(
                                            color: chekbox == true
                                                ? kPrimaryColor
                                                : Colors.red,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationStyle:
                                                TextDecorationStyle.solid)),
                                    TextSpan(
                                        text:
                                            " for accessing the credit report ",
                                        style: TextStyle(
                                            color: chekbox == true
                                                ? Colors.grey
                                                : Colors.red)),
                                  ],
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(String title, String text) {
    final w = MediaQuery.of(context).size.width;
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
