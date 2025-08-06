import 'dart:async';
import 'dart:convert';

import 'package:hire_any_thing/Vendor_App/view/login.dart';
import 'package:hire_any_thing/Vendor_App/view/signup%20form/Screenb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/api_service/api_service_vender_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:hire_any_thing/splash.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../setting/contect.dart';
import '../setting/faq.dart';
import '../setting/privacy.dart';
import '../setting/termlist.dart';
import '../uiltis/color.dart';
import 'add_service/add_service_screen_1.dart';
import 'home.dart';

SessionVendorSideManager sessionVendorSideManager=SessionVendorSideManager();

class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? retrievedId;
  String? result;
  String response = "";
  SharedPreferences? prefs;
  late Timer _timer;
  String apiUrl =
      'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/getVenderProfile';

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      getIdFromSharedPreferences().then((_) {
        if (retrievedId != null) {
          print('Retrieved profile shop ID: $retrievedId');
          mob_shop();
        } else {}
        if (result != null) {
          print('Retrieved profile shop ID: $result');
        } else {}
      });
    });
  }

  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
    result = prefs.getString('result');
    // print("Retrieved ID: $retrievedId");
    // print("fetsssssssssssssssssssssresult");
    // print("Retrieved ID: $result");
  }

  final homeScreen = Home();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    List info = [
      _buildMenuItem('assets/image/businessman.png', "Profile", (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profileee()));
      }),
      _buildMenuItem('assets/icons/add_service.png', "Add Service",
          (){
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => AddServiceScreenFirst()));
  } ),
      _buildMenuItem(
          'assets/image/termcond.png', "Terms and Conditions",
          // termscreen()
    (){

          Future.microtask(() =>apiServiceVenderSide.commonForAboutUsTermsPrivacyContactAountUsList(appUrlsVendorSide.termsConditionList)).whenComplete((){

            setState(() {

            });
          });

    }
      ),
      _buildMenuItem(
          'assets/image/privacy1.png', "Privacy Policy",
              (){

            apiServiceVenderSide.commonForAboutUsTermsPrivacyContactAountUsList(appUrlsVendorSide.privacyPolicyList);

          }
      ),
      _buildMenuItem('assets/image/contact.png', "Contact Us",
          // ContactScreen()
          (){

        Future.microtask(() => apiServiceVenderSide.contactUs()).whenComplete((){

          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>   ContactScreen()));

        });
          }
      ),
      _buildMenuItem('assets/image/about.png', "About", (){
        apiServiceVenderSide.commonForAboutUsTermsPrivacyContactAountUsList(appUrlsVendorSide.aboutUsList);

        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) =>   FAQScreen()));
      }),
      _buildMenuItem('assets/image/logout.png', "Sign Out", () => showPopup(context)),
    ];

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF295AB3), // AppBar background color
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF295AB3), // Border color
                  width: 2.0, // Border width
                ),
              ),
            ),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor:
                  colors.button_color, // Set your preferred background color
              elevation: 0, // No shadow
              title: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    //"Hey ! $shopName",
                    "Menu",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: colors.white,
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Container(
                height: h,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // childAspectRatio: 6 / 7,
                      crossAxisSpacing: w / 45,
                      mainAxisSpacing: h / 100),
                  itemCount: info.length,
                  itemBuilder: (BuildContext context, int index) {
                    return info[index];
                  },
                ),
              ),
            ),
          ]),
        )

        );
  }

  final namecontroller = TextEditingController();

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/vendor_logout';
    final Map<String, dynamic> data = {
      'shopId': retrievedId.toString(),
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      await prefs.remove('id');
      await prefs.remove('loyaltyId');

      Get.offAll(const Login());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged out successfully'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } else {}
  }

  // void showPopup(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Are you sure !'),
  //         content: Text('You want to logout'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () async {
  //             await  logout();
  //
  //             },
  //             child: Text('Yes',
  //                 style: TextStyle(color: Colors.green, fontSize: 18)),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('No',
  //                 style: TextStyle(color: Colors.green, fontSize: 18)),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final h = MediaQuery.of(context).size.height;
        final w = MediaQuery.of(context).size.width;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green, Colors.teal],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Are you sure?',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'You want to logout',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        sessionVendorSideManager.deleteSession();
                        Get.offAll(Splash());
                      },
                      style: ElevatedButton.styleFrom(
                        //  todo primary: Colors.white,
                        // primary: Colors.white,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      child: const Text(
                        'Yes',
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        // todo primary: Colors.red,
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      child: const Text(
                        'No',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        );
      },
    );
  }

  Future mob_shop() async {
    if (retrievedId == null) {
      print('Retrieved ID is null');
      return;
    }

    final url = Uri.parse(
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/getVenderProfile');
    print("inside api $retrievedId");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'shopId': retrievedId!,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      setState(() {
        shopName = responseData['data']['shop_name'];
        mobileNumber = responseData['data']['mobile'];
      });
    } else {}
  }

  String shopName = '';
  int? mobileNumber;

  Widget _buildMenuItem(String imgPath, String label, dynamic onPressed) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon(
                //   icon,
                //   color: Colors.black,
                //   size: 50,
                // ),
                Image.asset(
                  imgPath,
                  height: 45,
                  width: 45,
                ),
                Text(
                  label,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                  // overflow: TextOverflow.ellipsis,
                ),
                // const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
