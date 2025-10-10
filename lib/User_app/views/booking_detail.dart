import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utilities/constant.dart';

class Booking_details extends StatefulWidget {
  const Booking_details({super.key});

  @override
  State<Booking_details> createState() => _Booking_detailsState();
}

class _Booking_detailsState extends State<Booking_details> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Booking Details ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: h / 25),
              ListView.builder(
                  itemCount: 1,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: h / 4.5,
                      width: h * 0.4,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300, blurRadius: 3)
                          ]),
                      child: Column(
                        children: [
                          Stack(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xffE7EFF1),
                                    radius: w / 11,
                                    child: Image.asset(
                                        "assets/images/mainlogo.png"),
                                    // backgroundImage: AssetImage(
                                    //     "assets/images/mainlogo.png",
                                    // ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Greenlab Biotech",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "Blood test",
                                        style: TextStyle(
                                            color: Color(0xff686978),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(
                                        height: h / 150,
                                      ),
                                      Container(
                                        height: h / 26,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Color(0xffE6E9EE)),
                                        child: InkWell(
                                          onTap: () {},
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Upcoming',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 9,
                                                  color: Color(0xff3596CD)),
                                            ),
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                  Icon(Icons.more_vert),
                                ],
                              ),
                            ),
                            Positioned(
                              top: h / 22,
                              bottom: h / 320,
                              left: w / 7,
                              child: SvgPicture.asset(
                                "assets/images/Starlogo.svg",
                                color: kPrimaryColor,
                              ),
                            ),
                            Positioned(
                              top: 45,
                              bottom: h / 90,
                              left: w / 6,
                              child: SvgPicture.asset(
                                "assets/images/ticklogo.svg",
                                height: 8,
                                color: Colors.white,
                              ),
                            )
                          ]),
                          SizedBox(
                            height: h / 60,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 34,
                                  width: 34,
                                  child: SvgPicture.asset(
                                    "assets/images/tabler_clock-filled3.svg",
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Appointment Date",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff686978)),
                                      ),
                                      Text(
                                        "12 Jan, 2024",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff000000)),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: w / 18,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 34,
                                      width: 24,
                                      child: SvgPicture.asset(
                                        "assets/images/mingude.svg",
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Type",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff686978)),
                                          ),
                                          Text(
                                            "Pick Up",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff000000)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Patient",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )),
              ),
              ListView.builder(
                itemCount: 1,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // Sample data for images and texts
                  List<String> imageList = [
                    "assets/images/fam.png",
                    "assets/images/fam2.png",
                    "assets/images/fam3.png",
                    "assets/images/fam4.png",
                  ];

                  List<String> textList = [
                    "Kapil Darsan",
                    "Kanak Sharma",
                    "Konika Sharma",
                    "Kartik Sharma",
                  ];

                  List<String> textList2 = [
                    "Father",
                    "Sister",
                    "Daughter",
                    "Son",
                  ];

                  return Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: h / 9,
                        width: MediaQuery.of(context).size.width / 1.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        imageList[
                                            index], // Accessing image from the list
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  textList[
                                      index], // Accessing text from the list
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: h / 45,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Booked Test",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )),
              ),
              SizedBox(
                height: h / 90,
              ),
              ListView.builder(
                  itemCount: 1,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: h / 4.5,
                      width: h * 0.4,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300, blurRadius: 3)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/images/blood23.png'),
                                SizedBox(
                                  width: w / 32,
                                ),
                                Text('Blood Test')
                              ],
                            ),
                            SizedBox(
                              height: h / 50,
                            ),
                            Row(
                              children: [
                                Image.asset('assets/images/urine22.png'),
                                SizedBox(
                                  width: w / 32,
                                ),
                                Text('Urine Test')
                              ],
                            ),
                            SizedBox(
                              height: h / 50,
                            ),
                            Row(
                              children: [
                                Image.asset('assets/images/heart34.png'),
                                SizedBox(
                                  width: w / 32,
                                ),
                                Text('Heart Test')
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Address",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )),
              ),
              SizedBox(
                height: h / 70,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "2972 Westheimer Rd. Santa Ana, Illinois 85486 ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    )),
              ),
              SizedBox(
                height: h / 39,
              ),
              Text(
                "Show this bar code at lab center",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/barcode.png'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
