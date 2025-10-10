import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_basic_getx_controller.dart';
import 'package:hire_any_thing/utilities/constant.dart';
import 'package:hire_any_thing/User_app/views/HealthPlan.dart';
import 'package:hire_any_thing/User_app/views/Home.dart';
import 'package:hire_any_thing/User_app/views/booking.dart';
import 'package:hire_any_thing/User_app/views/profile.dart';

// int selectedindex = 0;
class Navi extends StatefulWidget {
  const Navi({Key? key}) : super(key: key);



  @override
  State<Navi> createState() => _NaviState();
}


class _NaviState extends State<Navi> {


 // int selectedindex = 0;

  final List<Widget> screens = [
    Home(),
    HealthPlan(),
    Booking(),
    profile(),


  ];

  DateTime? currentBackPressTime;


  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    final UserBasicGetxController userBasicGetxController = Get.put(UserBasicGetxController());
    print("userBasicGetxController.homePageNavigation=>${userBasicGetxController.homePageNavigation}");

    return WillPopScope(
      onWillPop: () async {
        if (userBasicGetxController.homePageNavigation != 0) {
          // If not on the home screen, navigate back to home screen
          // setState(() {
          //   selectedindex = 0;
          // });
          userBasicGetxController.setHomePageNavigation(0);
          setState(() {

          });
          return false;
        } else {
          // If on the home screen, show exit confirmation dialog
          if (currentBackPressTime == null ||
              DateTime.now().difference(currentBackPressTime!) >
                  Duration(seconds: 2)) {
            currentBackPressTime = DateTime.now();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Press back again to exit'),
              ),
            );
            return false;
          } else {
            return true;
          }
        }
      },
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: Colors.grey,
              selectedItemColor: kPrimaryColor,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: userBasicGetxController.homePageNavigation,
              onTap: (index) {
                userBasicGetxController.setHomePageNavigation(index);
                setState(() {
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/images/home.svg",
                      height: 25,
                      color: userBasicGetxController.homePageNavigation == 0 ? kPrimaryColor : Colors.grey,
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.question_mark_sharp,
                      size: 25,
                      color: userBasicGetxController.homePageNavigation == 1 ? kPrimaryColor : Colors.grey,
                    ),
                    label: "Enquiry"),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/ic_enquiry.png",
                      height: 25,
                      color: userBasicGetxController.homePageNavigation == 2 ? kPrimaryColor : Colors.grey,
                    ),
                    label: "My Booking"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/images/userss.svg",
                      height: 25,
                      color: userBasicGetxController.homePageNavigation == 3 ? kPrimaryColor : Colors.grey,
                    ),
                    label: "Profile")
              ]),
          backgroundColor: Colors.white,
          body: screens[userBasicGetxController.homePageNavigation]),
    );
  }
}
