import 'package:get/get.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_basic_getx_controller.dart';
import 'package:hire_any_thing/global_file.dart';
import 'package:hire_any_thing/utilities/constant.dart';
import 'package:hire_any_thing/views/date_timeSelect.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ServiceDetailScreen extends StatefulWidget {
  final image;
  final cat_name;

  const ServiceDetailScreen({super.key, this.image, this.cat_name});

  @override
  State<ServiceDetailScreen> createState() =>
      _ServiceDetailScreenState();
}

class _ServiceDetailScreenState
    extends State<ServiceDetailScreen> {
  int _currentPage1 = 0;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final UserBasicGetxController userBasicGetxController = Get.put(UserBasicGetxController());

    print("userBasicGetxController.getServiceSeriveDetailSingle.serviceImage=>${userBasicGetxController.getServiceSeriveDetailSingle.serviceImage?.length}");

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
            
                CarouselSlider.builder(
                  itemCount: userBasicGetxController.getServiceSeriveDetailSingle.serviceImage?.length,
                  itemBuilder: (context, index, realIndex) {
            
            
                    return Container(
                        // height: h / 2,
                        height: 100,
                        width: double.infinity,
                      decoration: BoxDecoration(
                        //  color: color,
                        borderRadius: BorderRadius.circular(10),
                        // boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)],
                      ),
                      // padding: EdgeInsets.only(left: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "${appUrlsUserSide.baseUrlImages.toString()}${userBasicGetxController.getServiceSeriveDetailSingle.serviceImage?[index].toString()}"
                          ,
                          width: 130,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    height: 300,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    // aspectRatio: isPortrait ? 1.40 : 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentPage1 = index;
                      });
                    },
                  ),
                ),
            
                SizedBox(
                  height: 10,
                ),
                Padding(
                  // padding: EdgeInsets.symmetric(horizontal: w * .04),
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        // "Horse and Carriage",
                        "${userBasicGetxController.getServiceSeriveDetailSingle.serviceName}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Padding(
                  // padding: EdgeInsets.symmetric(horizontal: w * .04),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                        size: 17,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${userBasicGetxController.getServiceSeriveDetailSingle.cityName}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.star_border,
                        color: Colors.grey,
                        size: 17,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "4.9 (12.6k)",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
            
                  // padding: EdgeInsets.symmetric(horizontal: w * .04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: w * .25,
                        height: h * .05,
                        child: Row(
                          children: [
                            Icon(Icons.person_outline),
                            SizedBox(
                              width: h * .01,
                            ),
                            Text(
                              "${userBasicGetxController.getServiceSeriveDetailSingle.no_of_booking} Guests",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
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
        
                // margin: EdgeInsets.only(bottom: h * 0.07),
                margin: EdgeInsets.only(bottom: 10),
                // Adjusted margin for the button
                child: Padding(
                  // padding: EdgeInsets.symmetric(
                  //     horizontal: w * .04, vertica
                      padding: EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
        
                       Padding(
                        padding:  EdgeInsets.only(top: 10, bottom: 15),
                        child: Row(
                          children: [
                            Text(
                              "\$199 USD",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none),
                            ),
                            Spacer(),
        
                            Text(
                              // Todo
                              // "Time : ${userBasicGetxController.getServiceSeriveDetailSingle.}",
                              "Time : ${userBasicGetxController.getServiceSeriveDetailSingle.booking_time ?? ""}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                              "${userBasicGetxController.getServiceSeriveDetailSingle.description}"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
     bottomNavigationBar: Container(
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.only(
           topLeft: Radius.circular(25),
           topRight: Radius.circular(25),
         ),
         boxShadow: [
           BoxShadow(
             color: Colors.black.withOpacity(0.1),
             spreadRadius: 1,
             blurRadius: 5,
             offset: Offset(0, -3), // Negative offset for top shadow
           ),
         ],
       ),
       padding: EdgeInsets.all(15.0),
       child: Padding(
         padding: EdgeInsets.symmetric(horizontal: w * .03),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             // Price Label
             Text(
               "\$ ${userBasicGetxController.getServiceSeriveDetailSingle.finalPrice} Total",
               style: TextStyle(
                 fontSize: 18,
                 fontWeight: FontWeight.bold,
                 color: kPrimaryColor,
               ),
             ),

             // Book Now Button
             ElevatedButton(
               onPressed: () async {
                 Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) => const DateShow()));
                 // //  Display the date picker when the button is clicked
                 // DateTime? selectedDate = await showDatePicker(
                 //   context: context,
                 //   initialDate: DateTime.now(),
                 //   firstDate: DateTime(2000),
                 //   lastDate: DateTime(2100),
                 // );
                 //
                 // if (selectedDate != null) {
                 //
                 //   print("Selected Date: $selectedDate");
                 // }
               },
               style: ElevatedButton.styleFrom(
                 backgroundColor: kPrimaryColor,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(12), // Low radius
                 ),
                 padding: EdgeInsets.symmetric(
                     horizontal: 32.0, vertical: 12.0),
               ),
               child: Text(
                 'Book Now',
                 style: TextStyle(
                   color: Colors.white,
                 ),
               ),
             ),
           ],
         ),
       ),
     ),
    );
  }
}
