import 'package:hire_any_thing/utilities/constant.dart';
import 'package:flutter/material.dart';

import '../navigation_bar.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        // surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
        title: Text(
          "Notification",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const Navi(),
                ),
              );
            },
            child: Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              height: h / 8,
              width: w * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 3)
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: kredTextColor,
                    child: Icon(
                      Icons.cancel,
                      color: kwhiteColor,
                      size: 30,
                    ),
                    radius: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Booking Cancel",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                        maxLines: 2,
                      ),
                      Text(
                        "Booking #107 has been cancel",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        maxLines: 2,
                      ),
                      Text(
                        "9:41 PM",
                        style: TextStyle(
                            color: Color(0xff9399A7),
                            fontWeight: FontWeight.w400,
                            fontSize: 10),
                      ),
                    ],
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
