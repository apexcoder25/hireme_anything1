

import 'package:hire_any_thing/utilities/AppConstant.dart';
import 'package:hire_any_thing/utilities/constant.dart';
import 'package:hire_any_thing/utilities/custom_indicator.dart';
import 'package:hire_any_thing/User_app/views/date_timeSelect.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

GlobalFileWidget globalFileWidget=GlobalFileWidget();

class GlobalFileWidget {

  // void showPersistentBottomSheet(BuildContext context) {
  //   Scaffold.of(context).showBottomSheet(
  //     // backgroundColor:Colors.redAccent,
  //         (BuildContext context) {
  //       return Padding(
  //         padding: const EdgeInsets.only(top: 20),
  //         child: Stack(
  //
  //               children: [
  //
  //
  //             Container(
  //               padding: EdgeInsets.all(16.0),
  //               color: Colors.white,
  //               height: 200,
  //               width: MediaQuery.of(context).size.width,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text(
  //                     'Persistent Bottom Sheet',
  //                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //                   ),
  //                   SizedBox(height: 10),
  //                   Text('This is a persistent bottom sheet.'),
  //                   SizedBox(height: 10),
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: Text('Close'),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }


  void showBottomSheet(String image, BuildContext context) {
    int _currentPage1 = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to take more space
      builder: (BuildContext context) {
        final w = MediaQuery.of(context).size.width;
        final h = MediaQuery.of(context).size.height;

        return StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  height: h * 0.8,
                  margin: EdgeInsets.only(bottom: h * 0.07), // Adjusted margin for the button
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hire Anything",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.close, size: 18))
                          ],
                        ),
                        Text(
                          "Combination of Multiple Services",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: w,
                          height: h / 4,
                          child: Container(
                            height: h / 6,
                            width: w / 1,
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey, blurRadius: 3)
                                ]),
                            child: CarouselSlider.builder(
                              itemCount: 3,
                              itemBuilder: (context, index, realIndex) {
                                return Container(
                                  height: h / 6,
                                  width: w / 1,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            image,
                                          ),
                                          fit: BoxFit.fill),
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey, blurRadius: 3)
                                      ]),
                                );
                              },
                              options: CarouselOptions(
                                viewportFraction: 1.0,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentPage1 = index;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomPageIndicator(
                          currentPage: _currentPage1,
                          itemCount: 3,
                          dotColor: kPrimaryColor,
                          activeDotColor: kPrimaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 15),
                          child: Row(
                            children: [
                              Text(
                                "\u{20B9} 199",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none),
                              ),
                              SizedBox(width: 17),
                              Text(
                                "\u{20B9} 499",
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decorationThickness: 3.0,
                                  decorationColor: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 17),
                              SizedBox(
                                height: 12,
                                child: VerticalDivider(
                                  width: 10,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 17),
                              Text(
                                "40% off",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 17),
                              Text(
                                "Time : 30 mins",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 5),
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "\u2022 ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: "Facial Hair Removal: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  TextSpan(
                                    text:
                                    "Eyebrows (Threading), Upper Lips (Threading), Forehead (Threading)",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DateShow()));
                    },
                    child: Container(
                      width: w,
                      color: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        height: h * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "Add To Cart ",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }



}

