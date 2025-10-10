import 'dart:async';

import 'package:hire_any_thing/data/api_service/api_service_user_side.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/auth_user_getx_controller.dart';
import 'package:hire_any_thing/User_app/views/generalinformation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/constant.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int remainingSeconds = 30;  // Total countdown time
  Timer? timer;

  bool canResendOTP = false;


  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  String? _otpError;
  String _enteredOtp = ''; // Variable to store the entered OTP

  void _validateOtp(String value) {
    if (value.length != 4) {
      setState(() {
        _otpError = "Please enter valid OTP";
      });
    } else {
      setState(() {
        _otpError = null;
      });
    }
  }

  void startTimer() {
    canResendOTP = true;
    print("remainingSeconds=>${remainingSeconds}");
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {

        t.cancel();
        setState(() {
          canResendOTP = false;
          remainingSeconds=30;// Enable OTP resend
        });// Stop the timer when it reaches zero
        // You can trigger any other action here, like navigating to another page
      }
    });
  }

  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final AuthUserGetXController authUserGetXController = Get.put(AuthUserGetXController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFf5f5f3),
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

                    // Image.asset(
                    //   "assets/images/logonew.png",height: MediaQuery.of(context).size.height*20/100,
                    //   scale: 2,
                    //   color: Colors.white,
                    //
                    //   // color: Colors.white,
                    // ),

                    SizedBox(
                      height: 10,
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
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              // margin: EdgeInsets.all(15),
              child: Container(
                width: w,
                decoration: BoxDecoration(
                    color: Color(0xffF9F9F9),
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          "Enter Your OTP (${authUserGetXController.userSideDetailsModel.otp})",
                          style: TextStyle(
                            fontSize: isPortrait ? 20 : 24,
                            color: kblackTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Text(
                          "We are automatically detecting a SMS send to your mobile Number ${authUserGetXController.userSideDetailsModel.countryCode}${authUserGetXController.userSideDetailsModel.mobileNo}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: klightblackTextColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          4,
                          (index) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 65,
                                // width: 378,
                                // width: isPortrait ? 40 : 50,
                                // height: isPortrait ? 40 : 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _otpError == null
                                        ? kpinColor
                                        : Colors.red,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xffD8E0F1),
                                      spreadRadius: 0,
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 2,
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: TextFormField(
                                    maxLength: 1,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: isPortrait ? 20 : 24),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      counterText: '', // Remove counter text
                                    ),
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        // Move focus to next TextField
                                        FocusScope.of(context).nextFocus();
                                        _enteredOtp += value;
                                        if (_enteredOtp.length == 4) {
                                          _validateOtp(_enteredOtp);
                                        }
                                      } else {
                                        // Delete character and move focus to previous TextField
                                        setState(() {
                                          _enteredOtp =
                                              _enteredOtp.substring(0, index);
                                        });
                                        FocusScope.of(context).previousFocus();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (_otpError != null)
                        Center(
                          child: Text(
                            _otpError!,
                            style: TextStyle(color: kredTextColor),
                          ),
                        ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          print("_enteredOtp=>${_enteredOtp}");
                          print("_otpError=>${_otpError}");
                          _validateOtp(_enteredOtp);

                          Map<String,dynamic> requestedData={
                            "userId":"${authUserGetXController.userSideDetailsModel.userId}",
                            "otp":"${_enteredOtp}",
                            "token":"${authUserGetXController.userSideDetailsModel.token}"
                          };

                          Future.microtask(() =>apiServiceUserSide.userVerify(requestedData));


                          // if (_otpError == null) {
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     backgroundColor: kPrimaryColor,
                            //     content: Text(
                            //       'Login successful!',
                            //       style: TextStyle(color: Colors.white),
                            //     ),
                            //     duration: Duration(seconds: 2),
                            //   ),
                            // );



                          // }
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: kPrimaryColor.withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: _otpError == null
                                ? Text(
                                    "Verify",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isPortrait ? 16 : 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : Text(
                                    "Try Again",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isPortrait ? 16 : 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // _otpError == null
                      //     ?
                      (
                          canResendOTP)?
                      // Text(
                      //   "You can resend OTP after $remainingSeconds seconds",
                      //   style: TextStyle(fontSize: 16),
                      // )
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "You can resend OTP after ",
                                style: TextStyle(fontSize: 16, color: Colors.black), // Default text style
                              ),
                              TextSpan(
                                text: "$remainingSeconds",
                                style: TextStyle(fontSize: 16, color: Colors.red), // Red color for remainingSeconds
                              ),
                              TextSpan(
                                text: " seconds",
                                style: TextStyle(fontSize: 16, color: Colors.black), // Default text style
                              ),
                            ],
                          ),
                        ),
                      )

                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don’t receive OTP? (${authUserGetXController.userSideDetailsModel.otp})",
                                  style: TextStyle(color: klightblackTextColor),
                                )

                                ,
                                InkWell(
                                  onTap: (){
                                    // resendOtp


                                    startTimer();
                                    Map<String,dynamic>? requestedData={
                                      "country_code":"${authUserGetXController.userSideDetailsModel.countryCode}",
                                      "mobile_no":"${authUserGetXController.userSideDetailsModel.mobileNo}"
                                    };

                                    Future.microtask(() =>apiServiceUserSide.resendOtp(requestedData)).whenComplete(() {

                                      setState(() {

                                      });
                                    });


                                  },
                                  child: Text(
                                    "Resend OTP",
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                ),
                              ],
                            )
                          // : SizedBox(),
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
