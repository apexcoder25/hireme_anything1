
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../utilities/constant.dart';

class CartShort extends StatefulWidget {
  const CartShort({super.key});

  @override
  State<CartShort> createState() => _CartShortState();
}

class _CartShortState extends State<CartShort> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomSheet: Container(
            padding: EdgeInsets.all(8),

            // color: Colors.red,
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xff31C48D),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: CircleAvatar(
                          radius: w / 14,
                          backgroundImage: AssetImage(
                            "assets/images/mainlogo1.png",
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: h / 120,
                        left: w / 9,
                        child: SvgPicture.asset(
                          "assets/images/Starlogo.svg",
                          color: kPrimaryColor,
                        ),
                      ),
                      Positioned(
                        bottom: h / 60,
                        left: w / 7.8,
                        child: SvgPicture.asset(
                          "assets/images/ticklogo.svg",
                          height: 8,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: h * 0.08,
                    // color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Service",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              // fontSize isPortrait ? 16 : 20,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: h * 0.04,
                            width: w * 0.32,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 188, 243, 192),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Center(
                                child: Text(
                                  "View Test List >",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      // fontSize isPortrait ? 16 : 20,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (BuildContext context) =>
                    //       const LabCheckout(),
                    //     ),
                    //   );
                    // },
                    child: Container(
                      height: h * 0.08,
                      width: w * 0.28,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "1 item ₹1200 |",
                            style: TextStyle(
                                color: kTextColor2,
                                fontSize: 12,
                                // fontSize isPortrait ? 16 : 20,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Checkout",
                            style: TextStyle(
                                color: kTextColor2,
                                fontSize: 16,
                                // fontSize isPortrait ? 16 : 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _showAnimatedPopup(context);
                    },
                    child: Container(
                      height: h * 0.08,
                      width: w * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                          child: Container(
                              height: 24,
                              width: 24,
                              child:
                              Image.asset("assets/images/bin.png")
                          )),
                    ),
                  ),
                ]),
          ),
          // bottomNavigationBar: Navi(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 80,
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/icons/carticon.svg',
                  semanticsLabel: 'My SVG Image',
                  // ignore: deprecated_member_use
                  color: Colors.grey,
                  height: h / 35,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/icons/solar_bell-bold.svg',
                  semanticsLabel: 'My SVG Image',
                  // ignore: deprecated_member_use
                  color: Colors.grey,
                  height: h / 35,
                ),
              )
            ],
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
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/SearchInfo1.svg",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          "assets/images/SearchInfo2.svg",
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipRect(
                            child: Banner(
                              message: "20% off",
                              location: BannerLocation.topEnd,
                              color: Colors.red,
                              child: Card(
                                elevation: 1,
                                color: Colors.white,
                                surfaceTintColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Stack(children: [
                                        Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                              radius: w / 12,
                                              backgroundImage: AssetImage(
                                                "assets/images/mainlogo.png",
                                              ),
                                            ),
                                            SizedBox(
                                              width: w / 20,
                                            ),
                                            Text(
                                              "Greenlab Biotech",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        Positioned(
                                          bottom: h / 80,
                                          left: w / 9,
                                          child: SvgPicture.asset(
                                            "assets/images/Starlogo.svg",
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: h / 50,
                                          left: w / 7.8,
                                          child: SvgPicture.asset(
                                            "assets/images/ticklogo.svg",
                                            height: 8,
                                            color: Colors.white,
                                          ),
                                        )
                                      ]),
                                      SizedBox(
                                        height: h / 50,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/star.svg",
                                            height: 20,
                                            color: Colors.yellow,
                                          ),
                                          SizedBox(
                                            width: w / 50,
                                          ),
                                          Text(
                                            "5.0",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            " (1.1k Rating)",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                          SizedBox(
                                            width: w / 20,
                                          ),
                                          SvgPicture.asset(
                                            "assets/images/mingude.svg",
                                            color: kPrimaryColor,
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: w / 50,
                                          ),
                                          Text(
                                            "100+ Tests",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: h / 100,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/midikit.svg",
                                            color: kPrimaryColor,
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: w / 50,
                                          ),
                                          Container(
                                            width: w / 1.4,
                                            child: const Text(
                                              "2972 Westheimer Rd. Santa Ana, lllinois 85486",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: h / 100,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/location.svg",
                                            color: kPrimaryColor,
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: w / 50,
                                          ),
                                          Container(
                                            width: w / 1.5,
                                            child: Text(
                                              "2 km from you",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: h / 100,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/bloodicon1.png",
                                            color: kredTextColor,
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: w / 65,
                                          ),
                                          Container(
                                            width: w / 2.5,
                                            child: const Text(
                                              "Blood Test",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: h * 0.05,
                                              width: w * 0.36,
                                              decoration: BoxDecoration(
                                                color: kTextColor2,
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: kTextColor2
                                                        .withOpacity(0.5),
                                                    blurRadius: 10,
                                                    spreadRadius: 2,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: const Center(
                                                  child: Text(
                                                    "Add To Cart \u{20B9}${1200}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        // fontSize isPortrait ? 16 : 20,
                                                        fontWeight: FontWeight.w600),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                    },
                  )
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
          height: h * 0.30,
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
                  "Are you Sure you want to delete this cart item?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            // height: h * 0.05,
                            // width: w * 0.39,
                            height: 48,
                            width: 100,
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: kTextColor2)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Yes",
                                  style: TextStyle(
                                      color: kTextColor2,
                                      fontSize: 14,
                                      // fontSize isPortrait ? 16 : 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
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
                    ),
                    child: Column(
                      children: [
                        Container(
                          // height: h * 0.05,
                          // width: w * 0.39,
                          height: 48,
                          width: 100,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: kTextColor2,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    // fontSize isPortrait ? 16 : 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
