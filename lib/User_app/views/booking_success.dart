import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_basic_getx_controller.dart';
import 'package:hire_any_thing/User_app/views/Home.dart';
import 'package:hire_any_thing/User_app/views/booking.dart';
import 'package:hire_any_thing/User_app/views/profile.dart';

import '../../navigation_bar.dart';
import '../../utilities/constant.dart';
import 'faq.dart';

class BookingSuccessfulPage extends StatefulWidget {
  const BookingSuccessfulPage({super.key});

  @override
  State<BookingSuccessfulPage> createState() => _BookingSuccessfulPageState();
}

class _BookingSuccessfulPageState extends State<BookingSuccessfulPage> {

  // userBasicGetxController.setHomePageNavigation(0);
  // setState(() {
  // });

  @override
  Widget build(BuildContext context) {

    final UserBasicGetxController userBasicGetxController = Get.put(UserBasicGetxController());


    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
             radius: 50,
              backgroundColor: kPrimaryColor,
              child: Icon(Icons.check,size: 50,color: kwhiteColor,),

            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0, top: 20.0),
                      child: Text(
                        'Booking successful!',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                      child: Text("We will start Work on Time\nThank You!",
                          style: TextStyle(fontSize: 14, color: Colors.black45),
                          textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50.0, right: 50),
                          child: ElevatedButton(
                              onPressed: () async{

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

                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1cae81),
                              ),
                              child: const Text(
                                "View Booking",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50.0, right: 50),
                          child: ElevatedButton(
                              onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => const Navi(),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 173, 154, 144),
                              ),
                              child: const Text(
                                "Continue Booking",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 255, 162, 108)),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
