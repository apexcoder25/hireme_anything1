import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../main.dart';
import '../../../navigation_bar.dart';
import '../../../utilities/constant.dart';
import '../date_timeSelect.dart';

class ElectricianDetail extends StatefulWidget {
   ElectricianDetail({super.key});
  @override
  State<ElectricianDetail> createState() => _ElectricianDetailState();
}

class _ElectricianDetailState extends State<ElectricianDetail> {
  List<bool> isExpandedList = List.filled(4, false);
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
          "Service",
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
        height: h,
        width: w,
        color: Colors.white12,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
            SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
          Container(height: MediaQuery.of(context).size.height*0.1/100,
          color: Colors.grey,),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 100,
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 5 / 100,
                      width: MediaQuery.of(context).size.width * 40 / 100,
                      color: kwhiteColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top Rated",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1 / 100,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 5 / 100,
                      width: MediaQuery.of(context).size.width * 25 / 100,
                      color: kwhiteColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.sort_by_alpha_sharp),
                          Text(
                            "Sort",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1 / 100,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 5 / 100,
                      width: MediaQuery.of(context).size.width * 25 / 100,
                      color: kwhiteColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.filter_alt_rounded),
                          Text(
                            "Filter",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1 / 100,
                  color: Colors.grey.shade200,
                ),
                SizedBox(height: 10,),
                ListView.builder(
                    itemCount: 4,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      List<String> images = [
                        "assets/icons/hairwaxing.png",
                        "assets/icons/facewax.png",
                        "assets/icons/detain(1) .png",
                        "assets/icons/fecialicon.png",
                      ];
                      List<String> names = [
                        "Waxing",
                        "Face Wax",
                        "Detain",
                        "Facial",
                      ];
                      List<String> price = [
                        "500",
                        "600",
                        "900",
                        "800",
                      ];

                      int imageIndex = index % images.length;
                      int nameIndex = index % names.length;
                      int priceIndex = index % price.length;

                      String imageUrl = images[imageIndex];
                      String name = names[nameIndex];
                      String Price = price[priceIndex];
                      String $rating = "";
                      String description =
                          "Provide better service and description goes here. It can be more than two lines and will show a 'More' button if expanded.";

                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpandedList[index] = !isExpandedList[index];
                            });
                          },
                          child: Stack(children: [
                            Container(
                                height: MediaQuery.of(context).size.height *
                                    23 /
                                    100,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ClipRect(
                                  child: Card(
                                    elevation: 0.5,
                                    color: Colors.white,
                                    surfaceTintColor: Colors.transparent,
                                    shadowColor: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        children: [
                                          Row(

                                            children: [
                                              Container(width: MediaQuery.of(context).size.height*25/100,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      name,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Container(
                                                      width: w / 2.5,
                                                      child:  Text(
                                                        "\u{20B9}$Price",
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/images/star.svg",
                                                          height: 12,
                                                          color: kPrimaryColor,
                                                        ),
                                                        SizedBox(
                                                          width: w / 150,
                                                        ),
                                                        Text(
                                                          "5.0",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,color: kPrimaryColor),
                                                        ),
                                                        Text(
                                                          " (1.1k Rating)",
                                                          style: TextStyle(
                                                              color: Colors.black54,

                                                              fontSize: 10),
                                                        ),
                                                        SizedBox(
                                                          width: w / 20,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Container(
                                                      width: w / 2,
                                                      child: Text(
                                                        description,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        maxLines:
                                                            isExpandedList[index]
                                                                ? null
                                                                : 2,
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              // SizedBox(width: 10,),

                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    16 /
                                                    100,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    36 /
                                                    100,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            imageUrl),
                                                        fit: BoxFit.fill)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                            Positioned(
                              top: 110,
                              left: 214,
                              child: InkWell(
                                onTap: () {
                                  selectedProduct = ProductDetails(name, double.parse(Price));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DateShow()));
                                },
                                child: Container(
                                  height: h * 0.05,
                                  width: w * 0.28,
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
                                        // fontSize isPortrait ? 16 : 20,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                              ),
                            ),
                          ]));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class ProductDetails {
  final String productName;
  final double productPrice;

  ProductDetails(this.productName, this.productPrice);
}
