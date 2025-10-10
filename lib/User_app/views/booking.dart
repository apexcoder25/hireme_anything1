import 'package:get/get.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_basic_getx_controller.dart';
import 'package:hire_any_thing/User_app/views/widget/custom_card_my_booking.dart';
import 'package:flutter/material.dart';

import '../../navigation_bar.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final UserBasicGetxController userBasicGetxController = Get.put(UserBasicGetxController());


    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          // backgroundColor: Colors.transparent,
          // surfaceTintColor: Colors.transparent,
          forceMaterialTransparency: true,
          title: Text(
            "Booking",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          leading: InkWell(
              onTap: () {
                userBasicGetxController.setHomePageNavigation(0);
                setState(() {
                });


                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Navi(),
                  ),
                );
              },
              child: Icon(Icons.arrow_back_ios_new_sharp)),

          bottom: TabBar(
            labelColor: Color(0xFF001F54),
            // Set the color for selected tab text
            unselectedLabelColor: Colors.grey,
            // Set the color for unselected tab text
            indicatorColor: Color(0xFF001F54),
            labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
            labelStyle: TextStyle(fontSize: 16.0),
            indicatorWeight: 3.0,
            isScrollable: true,

            tabs: [
              Tab(
                child: Text(
                  'Upcoming',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  'Completed',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  'Cancelled',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Center(
                  child: Column(
                children: [
                  SizedBox(height: h / 32),
                  ListView.builder(
                      itemCount: 4,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomCardMyBooking();
                      }),
                ],
              )),
            ),
            SingleChildScrollView(
              child: Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: h / 32,
                  ),
                  ListView.builder(
                      itemCount: 3,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomCardMyBooking();
                      }),
                ],
              )),
            ),
            SingleChildScrollView(
              child: Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: h / 35,
                  ),
                  ListView.builder(
                      itemCount: 1,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomCardMyBooking();
                      }),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
