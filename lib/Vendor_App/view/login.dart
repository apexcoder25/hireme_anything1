import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/button.dart';
import 'package:hire_any_thing/Vendor_App/view/signup%20form/signup.dart';
import 'package:hire_any_thing/data/api_service/api_service_vender_side.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int screen = 0;
  String otpValue = '';
  String? id;
  int? shopStatus;
  String? retrievedId;
  var ll = 10;

  String? number;
  String? countryCode;

  @override
  void initState() {
    super.initState();
    // notificationService.getDeviceToken().then((value) {
    //   fcmToken = value;
    //   print("I Got Token ${value}");
    // });
    getIdFromSharedPreferences();
  }

  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
    print("Retrieved login ID: $retrievedId");
  }

  // NotificationService notificationService = NotificationService();
  var fcmToken = "0";

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f3),
      // backgroundColor: colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Image.asset(
                "assets/app_logo/SH.png",
                height: 230,
                width: 290,
              ),
              const Text(
                "Hire Anything Vendor Login",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: IntlPhoneField(
                  onChanged: (value) {
                    print("value=>${value}");
                    setState(() {
                      number = value.number;
                      countryCode = value.countryCode;
                    });
                  },
                  onCountryChanged: (value) {
                    print("ll=>${ll}");
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
                  onSubmitted: (phone) {
                    if (phone != null && phone.contains(RegExp(r'[0-5]'))) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid number.'),
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30.0, left: 30),
                child: Button_widget(
                  buttontext: "Continue",
                  button_height: 17,
                  button_weight: 1.1,
                  onpressed: () async {
                    print("yes");
                    // Get.to(Verify(otp: '', id: 'null', fcmToken: 'sdgs', mobilenumm: '25235',));
                    final mobile = mobilelogin.text.trim();

                    Map<String, dynamic> requestedData = {
                      "country_code": "${countryCode}",
                      "mobile_no": "${mobile}"
                    };

                    Future.microtask(
                        () => apiServiceVenderSide.userLogin(requestedData));
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
                        Get.to(Signup());
                      });
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController mobilelogin = TextEditingController();
}
