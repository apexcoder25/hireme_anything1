import 'package:flutter/material.dart';

import '../../navigation_bar.dart';
import '../../utilities/constant.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        // surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,

        title: Text(
          "Track Booking",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const Navi(),
                ),
              );
            },
            child: Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 100 / 100,
        width: MediaQuery.of(context).size.width * 100 / 100,
        color: Colors.grey.shade100,
        child: SingleChildScrollView(
          // physics: ScrollPhysics(),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                width: w,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Service Date",
                          style: TextStyle(
                              color: klightblackTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "2024-08-22",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Service Time",
                          style: TextStyle(
                              color: klightblackTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "08:00 AM",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Booked Service",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            height: h / 8,
                            width: w / 4.2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/new/minibus.jpeg"),
                                    fit: BoxFit.fill),
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 3)
                                ])),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Limousine",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "\$ 99.00",
                      style: TextStyle(
                          color: klightblackTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox()
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 10 / 100,
                      width: MediaQuery.of(context).size.width * 80 / 100,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Your Booking code: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "#800715",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "1 Services ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\$${109.00})",
                                style: TextStyle(color: kredTextColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green[50]),
                              child: CircleAvatar(
                                backgroundColor: kwhiteColor,
                                child: CircleAvatar(
                                  backgroundColor: kPrimaryColor,
                                  radius: 12,
                                  child: Icon(
                                    Icons.check,
                                    color: kgreyColor,
                                    size: 20,
                                  ),
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Booking Placed",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "We have recieved your order",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686978)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 2,
                            color: kPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green[50]),
                              child: CircleAvatar(
                                backgroundColor: kwhiteColor,
                                child: CircleAvatar(
                                  backgroundColor: kPrimaryColor,
                                  radius: 12,
                                  child: Icon(
                                    Icons.check,
                                    color: kgreyColor,
                                    size: 20,
                                  ),
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Confirmed",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "Your booking has been confirmed",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686978)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         height: 40,
                    //         width: 2,
                    //         color: Color(0xff31C48D),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //           height: 40,
                    //           width: 40,
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(20),
                    //               color: Colors.green[50]),
                    //           child: CircleAvatar(
                    //             backgroundColor: kwhiteColor,
                    //             child: CircleAvatar(
                    //               backgroundColor: kPrimaryColor,
                    //               radius: 12,
                    //               child: Icon(
                    //                 Icons.check,
                    //                 color: kgreyColor,
                    //                 size: 20,
                    //               ),
                    //             ),
                    //           )),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Container(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               "Hire Anything on the way",
                    //               style: TextStyle(
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.w400),
                    //             ),
                    //             Text(
                    //               "Estimated for 20Jul, 2024",
                    //               style: TextStyle(
                    //                   fontSize: 12,
                    //                   fontWeight: FontWeight.w400,
                    //                   color: Color(0xff686978)),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         height: 40,
                    //         width: 2,
                    //         color: Color(0xff31C48D),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         height: 40,
                    //         width: 40,
                    //         // decoration: BoxDecoration(
                    //         //     borderRadius: BorderRadius.circular(20),
                    //         //     color: Colors.green[50]),
                    //         child: Center(
                    //           child: Container(
                    //             height: 24,
                    //             width: 24,
                    //             alignment: Alignment.center,
                    //             // child: Icon(
                    //             //   Icons.access_time,
                    //             //   color: Color(0xff31C48D),
                    //             // ),
                    //             child: Image.asset(
                    //               "assets/images/circledot.png",
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Container(
                    //         alignment: Alignment.topLeft,
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               "Reached at location",
                    //               style: TextStyle(
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.w400),
                    //             ),
                    //             Text(
                    //               "Estimated for  20Jul, 2024",
                    //               style: TextStyle(
                    //                   fontSize: 12,
                    //                   fontWeight: FontWeight.w400,
                    //                   color: Color(0xff686978)),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 2,
                            color: Color(0xffE6E6E6),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(20),
                            //     color: Colors.green[50]),
                            child: Center(
                              child: Container(
                                height: 24,
                                width: 24,
                                alignment: Alignment.center,
                                // child: Icon(
                                //   Icons.access_time,
                                //   color: Color(0xff31C48D),
                                // ),
                                child: Image.asset(
                                  "assets/images/circledot.png",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Work Done",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "Estimated for 20 Jul, 2024",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686978)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: w,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Booking Summary",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "\$ 99",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Platform Charge 10%",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "\$ 10",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discount Applied",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "\$ 200",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Price",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "\$ 109",
                          style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Address :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "xyz 1234567",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 6 / 100,
          width: MediaQuery.of(context).size.width * 90 / 100,
          margin: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              color: kPrimaryColor, borderRadius: BorderRadius.circular(25)),
          child: Text(
            "Back to Home",
            style: TextStyle(
                color: kwhiteColor, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
    );
  }
}

// Container(
// height: h / 6.5,
// width: w / 3.5,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(20),
// gradient: LinearGradient(
// colors: [
// Colors.white,
// Colors.white
// ],
// begin: Alignment.bottomCenter,
// end: Alignment.topCenter)),
// child: Center(
// child: Column(mainAxisAlignment: MainAxisAlignment.center,
// children: [
// CircleAvatar(
// radius: 25,
//
// child: Image.asset(
// "assets/icons/roof.png",height: 40,
// ),
// ),
// SizedBox(
// height: 5,
// ),
// Text(
// "Roofing",
// style: TextStyle(
// fontWeight: FontWeight.w500, fontSize: 14),
// ),
// ],
// )),
// ),
