import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hire_any_thing/Vendor_App/view/home_new.dart';
import 'package:hire_any_thing/Vendor_App/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/services_list_screen.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/vender_side_getx_controller.dart';

import '../uiltis/color.dart';
import 'home.dart';

class Nav_bar extends StatefulWidget {
  const Nav_bar({super.key});

  @override
  State<Nav_bar> createState() => _Nav_barState();
}

class _Nav_barState extends State<Nav_bar> {

  // int selectedIndex = 0;

  void onItemTapped(int index) {

  }


  static final List<Widget> _widgetOptions = <Widget>[
    HomeNew(),
    Home(),
    ServicesListScreen(),
    Profile(),
  ];

  // NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();

    //   notificationService.requrstNotificationPermission();
    //   notificationService.firebaseinit(context);
    //   notificationService.setupIntractMessage(context);
    //   notificationService.isDeviceTokenRefresh();
    //   notificationService.getDeviceToken().then((value) {
    //     print("I Got Token ${value}");
    //   });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final VenderSidetGetXController venderSidetGetXController = Get.put(VenderSidetGetXController());
    return Scaffold(
      body: IndexedStack(
        index: venderSidetGetXController.selectedIndexVenderHomeNavi,
        children: _widgetOptions,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: venderSidetGetXController.selectedIndexVenderHomeNavi,
        onTap: (value){
          // setState(() {
          venderSidetGetXController.setselectedIndexVenderHomeNavi(value);
          setState(() {


          });

        },
        type: BottomNavigationBarType.fixed,
        fixedColor: colors.button_color,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.design_services_sharp),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}
