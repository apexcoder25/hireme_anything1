import 'dart:async';

import 'package:get/get.dart';
import 'package:hire_any_thing/data/api_service/api_service_user_side.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_basic_getx_controller.dart';
import 'package:hire_any_thing/data/session_manage/session_user_side_manage.dart';
import 'package:hire_any_thing/global_file.dart';
import 'package:hire_any_thing/views/Coupon.dart';
import 'package:hire_any_thing/views/TermCondition.dart';
import 'package:hire_any_thing/views/appReview.dart';
import 'package:hire_any_thing/views/faq.dart';
import 'package:hire_any_thing/views/generalSetting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart'
    as insetBox;

import '../navigation_bar.dart';
import '../payment/Address.dart';
import '../splash.dart';
import '../utilities/constant.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => profileState();
}

class profileState extends State<profile> with TickerProviderStateMixin {
  AnimationController? _animationController;

  AnimationController? _animationShareController;

  @override
  void initState() {
//     timerShare = Timer.periodic(Duration(milliseconds: 250), (Timer timer) {
//       setState(() {
//         isSharePressed = !isSharePressed;
//       });
//     });
//
// _animationShareController =
//     new AnimationController(vsync: this, duration: Duration(seconds: 1));
//     _animationShareController?.repeat(reverse: true);
    Future.microtask(() => getUserDetailFromSession()).whenComplete(() {
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  String? name;
  String? mobile;
  String? email;
  String? counrtyCode;
  String? imageName;

  getUserDetailFromSession() async {
    final sessionManager =
        await SessionManageerUserSide(); // Initialize session manager
    name = await sessionManager.getName();
    email = await sessionManager.getEmail();
    mobile = await sessionManager.getEmail();
    counrtyCode = await sessionManager.getCountryCode();
    imageName = await sessionManager.getUserImage();
  }

  bool isPressed = false;
  bool isSharePressed = false;
  Timer? timerShare;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final UserBasicGetxController userBasicGetxController =
        Get.put(UserBasicGetxController());

    Color shadowColor = Colors.lightGreenAccent;
    Color backgroundColor = shadowColor.withOpacity(0.9);
    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
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
            centerTitle: true,
            // backgroundColor: Colors.transparent,
            // surfaceTintColor: Colors.transparent,
            forceMaterialTransparency: true,
            title: Text(
              " My Profile",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            leading: InkWell(
                onTap: () {
                  // setState(() {
                  //   selectedindex = 0;
                  // });
                  userBasicGetxController.setHomePageNavigation(0);
                  setState(() {});
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Navi(),
                    ),
                  );
                },
                child:
                    Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              //height: h / 4.4,
              padding: const EdgeInsets.all(16),
              // margin: const EdgeInsets.all(5),
              // padding: const EdgeInsets.all(16),
              // margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFF295AB3), // Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  // color: Colors.white,
                  color: Color(0xFF295AB3),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  // border: Border.all(width: 1, color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade50,
                      blurRadius: 2,
                    ),
                  ]),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        50), // Adjust the radius as needed
                    child: Image.network(
                      "${appUrlsUserSide.baseUrlImages}${imageName}",
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                      errorBuilder: (BuildContext, Object, StackTrace) {
                        return CircleAvatar(
                            radius: 60,
                            // backgroundImage: AssetImage(
                            //   "assets/images/myprofile.png",
                            // ),
                            child: Icon(
                              Icons.account_circle_sharp,
                              size: 120,
                              color: Colors.white,
                            ));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${name ?? ""}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Container(
                    // color: Colors.red,
                    width: w,
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: h / 15),
                          SizedBox(width: 30),
                          Icon(Icons.phone, size: 24, color: Colors.white),
                          Text(
                            "${counrtyCode ?? ""} ${mobile ?? ""}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '|',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.mail, size: 24, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            "${email ?? ""}",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // height: h / 1,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(5),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const Account(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // width: w * 0.8,
                          // color: Colors.red,
                          child: Row(
                            children: [
                              Container(
                                  height: 25,
                                  width: 25,
                                  child: Image.asset(
                                    "assets/images/acountlogo.png",
                                    color: kPrimaryColor,
                                  )),
                              SizedBox(width: 18),
                              Text(
                                "General Setting",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff454545),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Color(0xff9399A7),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xffF1F5F8),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Address(),
                          ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // width: w * 0.8,
                          // color: Colors.red,
                          child: Row(
                            children: [
                              Container(
                                  height: 25,
                                  width: 25,
                                  child: Image.asset(
                                    "assets/icons/locklogo.png",
                                    color: kPrimaryColor,
                                  )),
                              SizedBox(
                                width: 18,
                              ),
                              Text(
                                "Addressess",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff454545),
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Color(0xff9399A7),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xffF1F5F8),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Future.microtask(() => apiServiceUserSide.getFAQ())
                          .whenComplete(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FAQPage(),
                            ));
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // width: w * 0.8,
                          // color: Colors.red,
                          child: Row(
                            children: [
                              Container(
                                  height: 25,
                                  width: 25,
                                  child: Image.asset(
                                    "assets/icons/questionlogo.png",
                                    color: kPrimaryColor,
                                  )),
                              SizedBox(
                                width: 18,
                              ),
                              Text(
                                "FAQ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff454545),
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Color(0xff9399A7),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xffF1F5F8),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Future.microtask(() => apiServiceUserSide
                              .getCommenTermsPrivacyAboutusModelList(
                                  appUrlsUserSide.privacyPolicyList))
                          .whenComplete(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()));
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // width: w * 0.8,
                          // color: Colors.red,
                          child: Row(
                            children: [
                              Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(
                                    "assets/icons/reportlogo.png",
                                    color: kPrimaryColor,
                                  )),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Privacy Policy",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff454545),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Color(0xff9399A7),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xffF1F5F8),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Future.microtask(() => apiServiceUserSide
                              .getCommenTermsPrivacyAboutusModelList(
                                  appUrlsUserSide.termsConditionList))
                          .whenComplete(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()));
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // width: w * 0.8,
                          // color: Colors.red,
                          child: Row(
                            children: [
                              Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(
                                    "assets/icons/reportlogo.png",
                                    color: kPrimaryColor,
                                  )),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Terms & Conditions",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff454545),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Color(0xff9399A7),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xffF1F5F8),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Future.microtask(() => apiServiceUserSide
                          .getCommenTermsPrivacyAboutusModelList(
                              appUrlsUserSide.aboutUsList)).whenComplete(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()));
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // width: w * 0.8,
                          // color: Colors.red,
                          child: Row(
                            children: [
                              Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(
                                    "assets/icons/reportlogo.png",
                                    color: kPrimaryColor,
                                  )),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "About Us",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff454545),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Color(0xff9399A7),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xffF1F5F8),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyCoupons()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // width: w * 0.8,
                          // color: Colors.red,
                          child: Row(
                            children: [
                              Container(
                                  height: 25,
                                  width: 25,
                                  child: Image.asset(
                                    "assets/icons/questionlogo.png",
                                    color: kPrimaryColor,
                                    fit: BoxFit.fill,
                                  )),
                              SizedBox(
                                width: 18,
                              ),
                              Text(
                                "App Review",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff454545),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Color(0xff9399A7),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xffF1F5F8),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final sessionManager =
                          await SessionManageerUserSide(); // Initialize session manager

                      await sessionManager.setRoleType();
                      Get.offAll(Splash());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // width: w * 0.8,
                          // color: Colors.red,
                          child: Row(
                            children: [
                              Container(
                                  height: 25,
                                  width: 25,
                                  child: Image.asset(
                                    "assets/icons/Vector2.png",
                                    color: kPrimaryColor,
                                  )),
                              SizedBox(
                                width: 18,
                              ),
                              Text(
                                'Log out',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: kPrimaryColor),
                              )
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Color(0xff9399A7),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  final VoidCallback logoutCallback;

  LogoutDialog({required this.logoutCallback});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Logout'),
      content: Text('Are you sure you want to logout?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Call the logout callback function
            logoutCallback();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}
