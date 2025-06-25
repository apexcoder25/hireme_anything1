import 'package:get/get.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_basic_getx_controller.dart';
import 'package:hire_any_thing/global_file.dart';
import 'package:hire_any_thing/utilities/constant.dart';
import 'package:hire_any_thing/views/service_detail_screen.dart';
import 'package:flutter/material.dart';

import '../../navigation_bar.dart';

class ServiceListScreen extends StatefulWidget {
  final cat_name;

  const ServiceListScreen({super.key, this.cat_name});

  @override
  State<ServiceListScreen> createState() =>
      _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  List<bool> isExpandedList = List.filled(4, false);
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    int _currentPage1 = 0;
    final UserBasicGetxController userBasicGetxController = Get.put(UserBasicGetxController());

    print("userBasicGetxController.getServiceListModel=>${userBasicGetxController.getServiceListModel.length}");
    print("userBasicGetxController.getServiceListModel.isNotEmpty=>${userBasicGetxController.getServiceListModel.isNotEmpty}");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        // surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,

        title: Text(
          widget.cat_name.toString(),
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
      body: (userBasicGetxController.getServiceListModel.length == 0)?Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Service Unavailable",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "The service you're looking for is not available at the moment.",
              textAlign:TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ): Container(
        height: h,
        width: w,
        color: Colors.white12,
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(
                height: 20,
              ),
              ListView.builder(
                  itemCount: userBasicGetxController.getServiceListModel.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    // if(userBasicGetxController.getServiceListModel.length != 0){
                      return GestureDetector(
                        onTap: () {
                          Future.microtask(() => userBasicGetxController.setServiceSeriveDetailSingle(userBasicGetxController.getServiceListModel[index])).whenComplete((){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ServiceDetailScreen(
                                          cat_name: widget.cat_name,
                                          image:
                                          "assets/new/Horse and Carriage.jpeg",
                                        )));
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: h * .36,
                              margin: EdgeInsets.only(
                                  left: 15, right: 15, bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    // Shadow color
                                    spreadRadius: 2,
                                    // How much the shadow spreads
                                    blurRadius: 1,
                                    // How blurred the shadow is
                                    offset: Offset(0, 1), // Shadow offset
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Container(
                                      height: h * .2,
                                      width: double.infinity,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child:
                                          // Image.asset(
                                          Image.network(
                                            "${appUrlsUserSide.baseUrlImages}${userBasicGetxController.getServiceListModel[index].serviceImage![0]}",
                                            alignment: Alignment.center,
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${userBasicGetxController.getServiceListModel[index].serviceName}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "%\$${userBasicGetxController.getServiceListModel[index].discountPrice}",
                                                  style: TextStyle(

                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      color:Colors.green),
                                                ),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text(
                                                  "\$${userBasicGetxController.getServiceListModel[index].servicePrice}",
                                                  style: TextStyle(
                                                      decoration: TextDecoration.lineThrough,
                                                      decorationThickness: 2.0,
                                                      decorationColor: Colors.grey[600],

                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey[600]),
                                                ),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text(
                                                  "\$${userBasicGetxController.getServiceListModel[index].finalPrice}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      color: kPrimaryColor),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.grey.shade400,
                                              size: 17,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "${userBasicGetxController.getServiceListModel[index].cityName}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade400,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "-",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade400,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.star_border,
                                              color: Colors.grey.shade400,
                                              size: 17,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "4.9 (12.6k)",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        //  3 containe rs
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: w * .25,
                                              height: h * .05,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.person_outline,
                                                    size: 17,
                                                  ),
                                                  SizedBox(
                                                    width: h * .01,
                                                  ),
                                                  Text(
                                                    "${userBasicGetxController.getServiceListModel[index].no_of_booking} Guests",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: h * .03,
                              right: w * .1,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isLiked = !isLiked;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    size: 17,
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border, // Unliked icon
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    // }

                  })

            ],
          ),
        ),
      ),
    );
  }
}
