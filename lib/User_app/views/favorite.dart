import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_basic_getx_controller.dart';
import 'package:hire_any_thing/utilities/AppImages.dart';

import '../../navigation_bar.dart';
import '../../utilities/constant.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final UserBasicGetxController userBasicGetxController =
        Get.put(UserBasicGetxController());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        // surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
        title: Text(
          "Favorite",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        leading: InkWell(
            onTap: () {
              userBasicGetxController.setHomePageNavigation(0);
              setState(() {});
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const Navi(),
                ),
              );
            },
            child: Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: Center(
            child: Column(
          children: [
            SizedBox(height: h / 32),
            ListView.builder(
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  String $rating = "";
                  return Container(
                    height: h / 7.5,
                    width: h * 0.4,
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade300, blurRadius: 3)
                        ]),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Color(0xffE7EFF1),
                                radius: w / 12,
                                child: Image.asset(
                                    "assets/icons/skin-treatment.png"),
                                // backgroundImage: AssetImage(
                                //     "assets/images/mainlogo.png",
                                // ),
                              ),
                              SizedBox(
                                width: w / 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Waxing",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: h / 100,
                                  ),
                                  Text(
                                    "Full Hand",
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    height: h / 100,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RatingBar.builder(
                                        initialRating: 4,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 15.0,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      Text(
                                        "320",
                                        style: TextStyle(
                                            color: klightblackTextColor,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: h / 150,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: w / 7,
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.blue.shade100,
                                      child: Icon(
                                        Icons.favorite_border_rounded,
                                        color: Colors.red,
                                      )),
                                  SizedBox(
                                    height: h / 30,
                                  ),
                                  Text(
                                    '\u{20B9}20',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 15),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ],
        )),
      ),
    );
  }
}
