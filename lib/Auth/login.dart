import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/button.dart';
import 'package:hire_any_thing/Vendor_App/view/signup%20form/user_signup_view.dart';
import 'package:hire_any_thing/Vendor_App/api_service/api_service_vender_side.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Vendor_App/uiltis/color.dart';
import '../data/api_service/api_service_user_side.dart';

// import 'verify_otp.dart';

class UserProgressHelper {
  static const String _progressKey = 'user_progress';

  static Future<int> getUserProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_progressKey) ?? 0;
  }

  static Future<void> setUserProgress(int progress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_progressKey, progress);
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key});

  @override
  State<LoginView> createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  int screen = 0;
  String otpValue = '';
  String? id;
  int? shopStatus;
  String? retrievedId;
  var ll = 10;

  @override
  void initState() {
    super.initState();
  }

  // NotificationService notificationService = NotificationService();
  var fcmToken = "0";

  String? number;

  String? countryCode;

  bool loader = false;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f3),
      // backgroundColor: colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            const SizedBox(height: 100),
            // Container(
            //   width: w / 2,
            //   child: Image.asset(
            //     "assets/image/logo1.png",
            //   ),
            // ),
            Image.asset(
              "assets/app_logo/SH.png",
              height: 230,
              width: 290,
            ),
            const Text(
              "Hire Anything User Login",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: IntlPhoneField(
                onCountryChanged: (value) {
                  print("value_fullCountryCode=>${value.fullCountryCode}");
                  setState(() {
                    ll = value.maxLength;
                  });
                },
                controller: mobilelogin,
                flagsButtonPadding: const EdgeInsets.all(8),
                decoration: const InputDecoration(
                  hintText: "Mobile Number",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 0.5,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
                initialCountryCode: 'IN',
                onChanged: (value) {
                  print("onChanged=>${value.number}");
                  print("onChanged=>${value.countryCode}");
                  setState(() {
                    number = value.number;
                    countryCode = value.countryCode;
                  });
                },
                onSubmitted: (phone) {
                  print("phone=>${phone}");

                  // if (phone != null && phone.contains(RegExp(r'[0-5]'))) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content: Text('Please enter a valid number.'),
                  //     ),
                  //   );
                  // }79077
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 30.0, left: 30),
              child: (loader)
                  ? Container(
                      width: 300,
                      height: 45,
                      decoration: BoxDecoration(
                        color: colors.button_color,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: colors.white,
                        ),
                      ))
                  : Button_widget(
                      buttontext: "Continue",
                      button_height: 17,
                      button_weight: 1.1,
                      onpressed: () async {
                        setState(() {
                          loader = true;
                        });
                        print("yes");
                        final mobile = mobilelogin.text;
                        if (mobilelogin.text.isEmpty) {
                          Get.snackbar(
                            "Field required", // Title of the Snackbar
                            "Please Enter Mobile No", // Message to display
                            snackPosition: SnackPosition
                                .BOTTOM, // Position of the snackbar
                            backgroundColor:
                                Colors.redAccent, // Background color
                            colorText: Colors.white, // Text color
                            borderRadius:
                                8.0, // Border radius for rounding corners
                            margin: const EdgeInsets.all(
                                16), // Padding around the snackbar
                            duration: Duration(
                                seconds:
                                    3), // How long the snackbar will be visible
                          );

                          return;
                        }

                        print("ll=>${ll}");
                        print("mobilelogin=>${mobilelogin.text}");
                        Map<String, dynamic>? requestedData = {
                          "country_code": "${countryCode.toString()}",
                          "mobile_no": "${number.toString()}",
                          "fcm_id": "fdgfdg"
                        };

                        Future.microtask(() => apiServiceUserSide
                            .userLoginSignup(requestedData)).whenComplete(() {
                          setState(() {
                            loader = false;
                          });
                        });

                        // Navigator.pushReplacement(
                        //   context,
                        //   PageRouteBuilder(
                        //     transitionDuration:
                        //     Duration(milliseconds: 250),
                        //     pageBuilder: (_, __, ___) => OtpPage(),
                        //     transitionsBuilder:
                        //         (_, animation, __, child) {
                        //       return SlideTransition(
                        //         position: Tween<Offset>(
                        //           begin: Offset(1.0,                              0.0), // Start position off-screen
                        //           end: Offset
                        //               .zero, // End position on-screen
                        //         ).animate(animation),
                        //         child: child,
                        //       );
                        //     },
                        //   ),
                        // );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dont have an account?  "),
                InkWell(
                  onTap: () {
                    Future.microtask(
                            () => apiServiceVenderSide.categoryList(true))
                        .whenComplete(() {
                      Get.to(UserSignUp());
                    });
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  TextEditingController mobilelogin = TextEditingController();
}

//
// class LoginView extends StatefulWidget {
//   const LoginView({Key? key}) : super(key: key);
//
//   @override
//   State<LoginView> createState() => _LoginViewState();
// }
//
// class _LoginViewState extends State<LoginView> {
//   final _formKey = GlobalKey<FormState>();
//   late String _email;
//   late String _password;
//   bool isCheck = false;
//   final controller = PageController(viewportFraction: 0.8, keepPage: true);
//   final TextEditingController _phoneNumberController = TextEditingController();
//   String? _phoneNumberError;
//
//   void _validatePhoneNumber(String value) {
//     if (value.length != 10) {
//       setState(() {
//         _phoneNumberError = "Please enter valid mobile number";
//       });
//     } else {
//       setState(() {
//         _phoneNumberError = null;
//       });
//     }
//   }
//
//   int _currentPage = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
//
//     final AuthUserGetXController authUserGetXController = Get.put(AuthUserGetXController());
//
//     return GestureDetector(
//         onTap: () {
//           FocusManager.instance.primaryFocus?.unfocus();
//         },
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           body: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                    color: Color(0xFFf5f5f3),
//                     border: Border.all(color: Colors.transparent),
//                     // gradient: LinearGradient(
//                     //   begin: Alignment.topCenter,
//                     //   end: Alignment.bottomCenter,
//                     //   // colors: [kPrimaryColor, kSecondaryColor],
//                     //
//                     // ),
//
//                   ),
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           height: h / 20,
//                         ),
//                         Image.asset(
//                           "assets/app_logo/SH.png",
//                           height: 220,width: 280,
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text(
//                           "Welcome to Hire Anything",
//                           style: TextStyle(
//                             fontSize: isPortrait ? 20 : 24,
//                             // color: Colors.white,
//                             color: Color(0xFF004aad),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // SizedBox(height: 10),
//                 Container(
//                   width: w,
//                   decoration: BoxDecoration(
//                       border: Border.all(color: Colors.transparent),
//                       color: Color(0xffF9F9F9),
//                       borderRadius: BorderRadius.circular(15)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         const SizedBox(height: 10),
//                         Center(
//                           child: Text(
//                             "Enter Your Phone Number",
//                             style: TextStyle(
//                               fontSize: isPortrait ? 20 : 24,
//                               color: kblackTextColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           "We’ll send you a Verification code to know you’re real",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: klightblackTextColor,
//                             fontSize: 13,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Material(
//                           child: Container(
//                             height: 60,
//                             decoration: BoxDecoration(
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.blue.shade100,
//                                   spreadRadius: 0,
//                                   blurStyle: BlurStyle.outer,
//                                   blurRadius: 10,
//                                 ),
//                               ],
//                               border: Border.all(
//                                   color: _phoneNumberError != null
//                                       ? kredTextColor
//                                       : Colors.grey),
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 15, right: 10,top: 3.5),
//                                   child: Center(
//                                       child: Text(
//                                     "+91",
//                                     style: TextStyle(
//                                         color: _phoneNumberError != null
//                                             ? kredTextColor
//                                             : Colors.black),
//                                   )),
//                                 ),
//                                 Expanded(
//                                   child:
//                                   TextFormField(
//
//                                     controller: _phoneNumberController,
//                                     keyboardType: TextInputType.number,
//                                     onChanged: _validatePhoneNumber,
//                                     inputFormatters: [
//                                       LengthLimitingTextInputFormatter(10),
//                                       FilteringTextInputFormatter.allow(
//                                           RegExp(r'[0-9]')),
//                                     ],
//                                     style: TextStyle(
//                                         color: _phoneNumberError != null
//                                             ? kredTextColor
//                                             : Colors.black),
//                                     decoration: InputDecoration(
//                                       prefixStyle:
//                                           TextStyle(color: Colors.black),
//
//                                       border: InputBorder.none,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         if (_phoneNumberError != null)
//                           Center(
//                             child: Text(
//                               _phoneNumberError!,
//                               style: TextStyle(color: kredTextColor),
//                             ),
//                           ),
//                         const SizedBox(height: 20),
//                         InkWell(
//                           onTap: () {
//                             if (_phoneNumberController.text.length == 10) {
//                               Navigator.pushReplacement(
//                                 context,
//                                 PageRouteBuilder(
//                                   transitionDuration:
//                                       Duration(milliseconds: 250),
//                                   pageBuilder: (_, __, ___) => OtpPage(),
//                                   transitionsBuilder:
//                                       (_, animation, __, child) {
//                                     return SlideTransition(
//                                       position: Tween<Offset>(
//                                         begin: Offset(1.0,                              0.0), // Start position off-screen
//                                         end: Offset
//                                             .zero, // End position on-screen
//                                       ).animate(animation),
//                                       child: child,
//                                     );
//                                   },
//                                 ),
//                               );
//                             } else {
//                               _validatePhoneNumber(_phoneNumberController
//                                   .text.length
//                                   .toString());
//                             }
//                           },
//                           child: Container(
//                             height: 60,
//                             decoration: BoxDecoration(
//                               color: kPrimaryColor,
//                               borderRadius: BorderRadius.circular(20.0),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: kPrimaryColor.withOpacity(0.5),
//                                   blurRadius: 10,
//                                   spreadRadius: 2,
//                                   offset: Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Center(
//                                 child: Text(
//                               "Send OTP",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: isPortrait ? 16 : 20,
//                                   fontWeight: FontWeight.w600),
//                             )),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
//
//   bool isValidEmail(String email) {
//     return email.contains('@');
//   }
//
//   Widget _buildPage(String title, String text) {
//     final w = MediaQuery.of(context).size.width;
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Center(
//             child: Text(
//               title,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Center(
//               child: Text(
//                 text,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: kTextColor,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }