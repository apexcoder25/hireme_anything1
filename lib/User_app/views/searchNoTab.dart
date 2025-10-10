
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../utilities/constant.dart';

class Searchontab extends StatefulWidget {
  const Searchontab({super.key});

  @override
  State<Searchontab> createState() => _SearchontabState();
}

class _SearchontabState extends State<Searchontab> {
  int _currentPage = 0;
  int _currentPage1 = 0;

  List test = ["Blood", "Urine", "Heart"];
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return SafeArea(
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          // bottomNavigationBar: Navi(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Text(
                      "Location",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: kPrimaryColor,
                    ),
                    Text(
                      " New York, USA",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined,
                        color: Colors.black, size: 20),
                  ],
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15, top: 10, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: w / 1.40,
                          child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search,
                                      color: Colors.grey),
                                  hintText: "abcd",
                                  hintStyle: const TextStyle(fontSize: 14),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.grey)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.grey))))),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Icon(
                                Icons.filter_alt_rounded,
                                color: Colors.white,
                                size: 32,
                              )),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),

                  ),
                  Container(
                    height: h * 0.4,
                    width: w,
                    // color: Colors.red,
                    child: Image.asset("assets/images/Logo13.png",),
                  ),
                  Text(
                    "Sorry No Hire Anything Found",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    height: h * 0.1,
                    width: w * 0.9,
                    padding: EdgeInsets.all(10),
                    // color: Colors.red,
                    child: Text(
                      "Sorry no Hire Anything found, please modify your search and try again",
                      style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                          const Searchontab(),
                        ),
                      );
                    },
                    child: InkWell(
                      onTap: () {
                        // _showAnimatedPopup(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (BuildContext context) => Home(),
                        //   ),
                        // );
                      },
                      child: Container(
                        // height: h * 0.05,
                        // width: w * 0.39,
                        height: 42,
                        width: 150,
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: kTextColor2,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: kTextColor2.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Call us",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  // fontSize isPortrait ? 16 : 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_showAnimatedPopup(BuildContext context) {
  final h = MediaQuery.of(context).size.height;
  final w = MediaQuery.of(context).size.width;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          height: h * 0.40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10),
                child: Text(
                  "Upload prescription",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 5),
                child: Text(
                  "Please upload of valid prescription from your doctor",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff686978),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffF3F7F8)),
                    child: Column(
                      children: [
                        InkWell(
                          // onTap: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (BuildContext context) =>
                          //       const DocList(),
                          //     ),
                          //   );
                          // },
                          child: Container(
                              height: h / 13,
                              width: w / 6,
                              child: Image.asset(
                                "assets/images/uploadfile.png",
                              )),
                        ),
                        Text(
                          "Upload",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xff31C48D)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // height: 104,
                    // width: 155,
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffF3F7F8)),
                    child: Column(
                      children: [
                        Container(
                            height: h / 13,
                            width: w / 6,
                            child: Image.asset(
                              "assets/images/takephoto.png",
                            )),
                        Text(
                          "Take",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xff31C48D)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Note: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xff686978)),
                      ),
                      TextSpan(
                        text:
                        "Always upload a clean version of your prescription for getting better result.",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff686978)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 5),
                child: Text(
                  "Max limit: 5mb",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xff686978)),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
