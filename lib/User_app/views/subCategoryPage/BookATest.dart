import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hire_any_thing/User_app/views/BloodTestSearchBar.dart';

import '../../../main.dart';
import '../../../navigation_bar.dart';
import '../../../utilities/constant.dart';
import '../Searchlist.dart';
import '../date_timeSelect.dart';
import 'electricianDetail.dart';

class BookATest extends StatefulWidget {
  const BookATest({super.key});

  @override
  State<BookATest> createState() => _BookATestState();
}

class _BookATestState extends State<BookATest> {
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
          "Book A Test",
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
      body: SingleChildScrollView(
        child: Container(padding: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const BloodTestSearchBar(),
                        ),
                      );
                    },
                    child: SizedBox(
                        height: h / 15,
                        width: w / 1.1,
                        child: TextFormField(
        
                            readOnly: false,
                            showCursor: true,
                            cursorColor: Colors.black,
                            cursorWidth: 2.0,
                            cursorHeight: 24.0,
                            textAlign: TextAlign.left,
                            autofocus: true,
                            onChanged: (text) {},
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (BuildContext context) => const Search(),
                              //   ),
                              // );
                            },
                            enabled: false,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search, color: Colors.grey),
                                hintText: "Search For Test",
                                hintStyle: TextStyle(fontSize: 14),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(width: 1, color: Colors.grey)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey))))),
                  ),
                ],
              ),
              ListView.builder(
                  itemCount: 4,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    List<String> images = [
                      "assets/icons/bloodcbc.jpg",
                      "assets/icons/liver.jpg",
                      "assets/icons/kidney.jpg",
                      "assets/icons/heart.jpg",
                    ];
                    List<String> names = [
                      "Complete Blood Count",
                      "Liver Function Test",
                      "Kidney Function Test",
                      "Lipid Profile",
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
                                                        fontSize: 13,
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
                                                          fontSize: 11,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
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
                                      "Book Now",
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
    );
  }
}
