import 'dart:async';
import 'dart:convert';

import 'package:hire_any_thing/Vendor_App/view/Navagation_bar.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/vender_side_getx_controller.dart';
import 'package:hire_any_thing/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/api_service/api_service_vender_side.dart';
import '../cutom_widgets/button.dart';
import '../uiltis/color.dart';

class Verify extends StatefulWidget {


  Verify();

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  String otp = '';
  String otpResendValue = '';
  String mobiles = '';
  bool showCenter = false;
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

  int _secondsRemaining = 30;
  late Timer _timer;
  TextEditingController otpController = TextEditingController();

  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel(); // Stop the timer when it reaches 0
        }
      });
    });
    // otp = widget.otp;
    getMobileFromPrefs();
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted) {
        setState(() {
          showCenter = true;
        });
      }
    });
  }

  void getMobileFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mobiles = prefs.getString('mobile') ?? '';
    });
  }

  Future<bool> verifyOTP(mobiles, String otp) async {
    final Uri url = Uri.parse(
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/Verifyotp');

    final Map<String, String> requestBody = {
      'mobile': mobiles,
      'otp': otp,
    };

    try {
      final http.Response response = await http.post(
        url,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['result'] == 'true') {
          return true;
        } else {
          return false;
        }
      } else {
        print('HTTP Error: Status Code ${response.statusCode}');
        if (response.body.isNotEmpty) {
          print('Response Body: ${response.body}');
        }
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  String errorMessage = '';
  String existingOTP = "1111";

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final VenderSidetGetXController venderSidetGetXController = Get.put(VenderSidetGetXController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: colors.black,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Verify Mobile Number",
                      style: TextStyle(
                        color: colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      venderSidetGetXController.vendorSideDetailsModel.mobileNo.toString(),
                      style: const TextStyle(
                        color: colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      venderSidetGetXController.vendorSideDetailsModel.otp.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
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
                                  style:
                                      TextStyle(fontSize: isPortrait ? 20 : 24),
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
                                      print("_enteredOtp=>${_enteredOtp}");
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


                    const SizedBox(
                      height: 20,
                    ),
                    Button_widget(
                      onpressed: () async {
                        print("_enteredOtp=>${_enteredOtp}");

                        Map<String,dynamic> data={
                          "vendorId":"${venderSidetGetXController.vendorSideDetailsModel.vendorId}",
                          "otp":"${_enteredOtp}"
                        };
                        Future.microtask(() => apiServiceVenderSide.verifyVederOtp(data));



                      },
                      button_height: 17,
                      button_weight: 1,
                      buttontext: 'Verify & Continue',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Time Remaining: $_secondsRemaining seconds',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      errorMessage,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    if (showCenter)
                      Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Didn't receive OTP?",
                                  style: TextStyle(color: Color(0xff707684)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // resendOTP(widget.mobilenumm,
                                    //     widget.fcmToken.toString());
                                    Map<String,dynamic> data={
                                      "country_code":"${venderSidetGetXController.vendorSideDetailsModel.countryCode}" ,
                                      "mobile_no":"${venderSidetGetXController.vendorSideDetailsModel.mobileNo}"
                                    };
                                    Future.microtask(() => apiServiceVenderSide.resendOtp(data)).whenComplete((){
                                      setState(() {

                                      });
                                    });
                                  },
                                  child: const Text("Resend OTP",
                                      style: TextStyle(
                                          color: colors.button_color)),
                                )
                              ],
                            ),
                            Text(
                              'Your Resent OTP: $otpResendValue',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
