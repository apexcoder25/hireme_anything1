import 'package:hire_any_thing/utilities/constant.dart';
import 'package:hire_any_thing/views/trackorder.dart';
import 'package:flutter/material.dart';

class CustomCardMyBooking extends StatefulWidget {
  const CustomCardMyBooking({super.key});

  @override
  State<CustomCardMyBooking> createState() => _CustomCardMyBookingState();
}

class _CustomCardMyBookingState extends State<CustomCardMyBooking> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TrackOrder()));
      },
      child: Container(
        width: h * 0.4,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 3)]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Image.asset(
                      "assets/new/minibus.jpeg",
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "limousine",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      // Text(
                      //   "Plumbing Repairs",
                      //   style: TextStyle(
                      //       color: kPrimaryColor,
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w800),
                      // ),
                      const Text(
                        "Order Id #123456",
                        style: TextStyle(
                            color: klightblackTextColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w800),
                      ),
                      const Text(
                        "\$ 320.00",
                        style: TextStyle(
                            color: klightblackTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: h / 100,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            size: 17,
                            color: kPrimaryColor,
                          ),
                          Text(
                            "  20 Feb,2020  ",
                            style: TextStyle(
                                color: klightblackTextColor, fontSize: 10),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Icon(
                            Icons.timer,
                            color: kPrimaryColor,
                            size: 17,
                          ),
                          Text(
                            "08:00 AM",
                            style: TextStyle(
                                fontSize: 10, color: klightblackTextColor),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
