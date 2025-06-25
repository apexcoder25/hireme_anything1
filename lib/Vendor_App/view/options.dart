import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Auth/agree.dart';
import 'package:hire_any_thing/Vendor_App/view/login.dart';
import 'package:hire_any_thing/utilities/constant.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  bool isCheck = false;
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

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.transparent),
                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   // colors: [kPrimaryColor, kSecondaryColor],
                    //
                    // ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: h / 20,
                        ),
                        Image.asset(
                          "assets/app_logo/SH.png",
                          height: 220,
                          width: 280,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Welcome to Hire Anything",
                          style: TextStyle(
                            fontSize: isPortrait ? 20 : 24,
                            // color: Colors.white,
                            color: Color(0xFF004aad),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 10),
                Container(
                  width: w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            "Please Select Usage Type",
                            style: TextStyle(
                              fontSize: isPortrait ? 20 : 24,
                              color: kblackTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "You want to provide services or use services",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: klightblackTextColor,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            Get.to(const Login());
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 25),
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
                              child: Center(
                                  child: Text(
                                "Sign In as Vendor",
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
                            Get.to(const Agree_screen());
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 25),
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
                              child: Center(
                                  child: Text(
                                "Sign In as User",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                          ),
                        ),
                        // Material(
                        //   child: Container(
                        //     height: 60,
                        //     decoration: BoxDecoration(
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: Colors.blue.shade100,
                        //           spreadRadius: 0,
                        //           blurStyle: BlurStyle.outer,
                        //           blurRadius: 10,
                        //         ),
                        //       ],
                        //       border: Border.all(
                        //           color: _phoneNumberError != null
                        //               ? kredTextColor
                        //               : Colors.grey),
                        //       borderRadius: BorderRadius.circular(20.0),
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         Padding(
                        //           padding: const EdgeInsets.only(
                        //               left: 15, right: 10,top: 3.5),
                        //           child: Center(
                        //               child: Text(
                        //                 "+91",
                        //                 style: TextStyle(
                        //                     color: _phoneNumberError != null
                        //                         ? kredTextColor
                        //                         : Colors.black),
                        //               )),
                        //         ),
                        //         Expanded(
                        //           child:
                        //           TextFormField(
                        //
                        //             controller: _phoneNumberController,
                        //             keyboardType: TextInputType.number,
                        //             onChanged: _validatePhoneNumber,
                        //             inputFormatters: [
                        //               LengthLimitingTextInputFormatter(10),
                        //               FilteringTextInputFormatter.allow(
                        //                   RegExp(r'[0-9]')),
                        //             ],
                        //             style: TextStyle(
                        //                 color: _phoneNumberError != null
                        //                     ? kredTextColor
                        //                     : Colors.black),
                        //             decoration: InputDecoration(
                        //               prefixStyle:
                        //               TextStyle(color: Colors.black),
                        //
                        //               border: InputBorder.none,
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 10),
                        // if (_phoneNumberError != null)
                        //   Center(
                        //     child: Text(
                        //       _phoneNumberError!,
                        //       style: TextStyle(color: kredTextColor),
                        //     ),
                        //   ),
                        // const SizedBox(height: 20),
                        // InkWell(
                        //   onTap: () {
                        //     if (_phoneNumberController.text.length == 10) {
                        //       Navigator.pushReplacement(
                        //         context,
                        //         PageRouteBuilder(
                        //           transitionDuration:
                        //           Duration(milliseconds: 250),
                        //           pageBuilder: (_, __, ___) => OtpPage(),
                        //           transitionsBuilder:
                        //               (_, animation, __, child) {
                        //             return SlideTransition(
                        //               position: Tween<Offset>(
                        //                 begin: Offset(1.0,
                        //                     0.0), // Start position off-screen
                        //                 end: Offset
                        //                     .zero, // End position on-screen
                        //               ).animate(animation),
                        //               child: child,
                        //             );
                        //           },
                        //         ),
                        //       );
                        //     } else {
                        //       _validatePhoneNumber(_phoneNumberController
                        //           .text.length
                        //           .toString());
                        //     }
                        //   },
                        //   child: Container(
                        //     height: 60,
                        //     decoration: BoxDecoration(
                        //       color: kPrimaryColor,
                        //       borderRadius: BorderRadius.circular(20.0),
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: kPrimaryColor.withOpacity(0.5),
                        //           blurRadius: 10,
                        //           spreadRadius: 2,
                        //           offset: Offset(0, 2),
                        //         ),
                        //       ],
                        //     ),
                        //     child: Center(
                        //         child: Text(
                        //           "Send OTP",
                        //           style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: isPortrait ? 16 : 20,
                        //               fontWeight: FontWeight.w600),
                        //         )),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  bool isValidEmail(String email) {
    return email.contains('@');
  }

  Widget _buildPage(String title, String text) {
    final w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kTextColor,
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
