import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../navigation_bar.dart';
import '../../../utilities/constant.dart';
import 'electricianDetail.dart';

class ElectricianSubcategory extends StatefulWidget {
  const ElectricianSubcategory({super.key});

  @override
  State<ElectricianSubcategory> createState() => _ElectricianSubcategoryState();
}

class _ElectricianSubcategoryState extends State<ElectricianSubcategory> {
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
          "Electricians",
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
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 100 / 100,
        width: MediaQuery.of(context).size.width * 100 / 100,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
                width: MediaQuery.of(context).size.width * 100 / 100,
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 100 / 100,
                    child: Material(
                      elevation: 0.9,
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        height: h * 0.24,
                        child: CarouselSlider.builder(
                            itemCount: 3,
                            itemBuilder: (context, index, realIndex) {
                              return Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                elevation: 3,
                                shadowColor: Colors.white,
                                child: Container(
                                  height: h / 4,
                                  width: w / 1.1,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/electpr.jpg",
                                        ),
                                        fit: BoxFit.fill),
                                    color: Color(0xffE6F4EF),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              viewportFraction: 1.0,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 1.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  var _currentPage = index;
                                });
                              },
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 10 / 100,
                    child: ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                height: MediaQuery.of(context).size.height *
                                    7 /
                                    100,
                                width: MediaQuery.of(context).size.width *
                                    70 /
                                    100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.star,
                                          color: kPrimaryColor,
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Save 15% on your booking",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            "Get Plus now",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                    color: Colors.grey.shade100,
                  ),
                  Container(
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 9 ~/ 3,
                        itemBuilder: (BuildContext context, int index) {
                          List<String> images = [
                            "assets/icons/switch.png",
                            "assets/icons/fans.png",
                            "assets/icons/light.png",
                            "assets/icons/wiring.png",
                            "assets/icons/doorbell.png",
                            "assets/icons/mcb.png",
                            "assets/icons/stabilizator.png",
                            "assets/icons/appliances.png",
                            "assets/icons/otherserv.jpg"
                          ];
                          List<String> names = [
                            "Switch",
                            "Fan",
                            "Light",
                            "Wiring",
                            "Door Bell",
                            "MCB",
                            "Stablizer",
                            "Mixer",
                            "Other Service",
                          ];

                          int startIndex = index *
                              3; // Calculate the starting index of each row
                          String imageUrl1 = images[startIndex % images.length];
                          String name1 = names[startIndex % names.length];

                          String imageUrl2 =
                              images[(startIndex + 1) % images.length];
                          String name2 = names[(startIndex + 1) % names.length];

                          String imageUrl3 =
                              images[(startIndex + 2) % images.length];
                          String name3 = names[(startIndex + 2) % names.length];

                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: h / 9,
                                          width: w / 4,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(imageUrl1),
                                                  fit: BoxFit.fill),
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade300,
                                                    blurRadius: 3)
                                              ]),
                                          child: Center(child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ElectricianDetail()));
                                            },
                                          )),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          name1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ElectricianDetail()));
                                        },
                                        child: Container(
                                          height: h / 9,
                                          width: w / 4,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(imageUrl2),
                                                  fit: BoxFit.fill),
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade300,
                                                    blurRadius: 3)
                                              ]),
                                          child: Center(child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ElectricianDetail()));
                                            },
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        name2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ElectricianDetail()));
                                        },
                                        child: Container(
                                          height: h / 9,
                                          width: w / 4,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(imageUrl3),
                                                  fit: BoxFit.fill),
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade300,
                                                    blurRadius: 3)
                                              ]),
                                          child: Center(
                                              child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ElectricianDetail()));
                                            },
                                            child: Container(
                                              height: h / 13,
                                              width: w / 6,
                                            ),
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        name3,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        }),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                    color: Colors.grey.shade100,
                  ),
                  Container(
                    height: 50,
                    color: Colors.white,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
