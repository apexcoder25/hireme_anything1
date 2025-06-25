import 'dart:convert';

import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/view/add_product/notificationn.dart';
import 'package:hire_any_thing/Vendor_App/view/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/api_service/api_service_vender_side.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/vender_side_getx_controller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeNew extends StatefulWidget {
  const HomeNew({super.key});

  @override
  State<HomeNew> createState() => _HomeNewState();
}

bool isSelect = false;

class _HomeNewState extends State<HomeNew> {
  @override
  void initState() {
    Future.microtask(() => apiServiceVenderSide.dashboard()).whenComplete(() {
      setState(() {});
    });

    // TODO: implement initState
    super.initState();
  }

  Future getDataSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("name_app");
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final VenderSidetGetXController venderSidetGetXController =
        Get.put(VenderSidetGetXController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // Use a transparent background
        elevation: 2,
        // Add a subtle elevation
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300],
            child: ClipOval(
              child: Image.asset(
                "assets/image/rashmika.jpg",
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
            ),
          ),
        ),

        actions: [
          /*  IconButton(
                  onPressed: () {
                    Get.to(const Qr_code());
                  },
                  icon: const Icon(
                    Icons.qr_code_2,
                    color: Colors.white,
                    size: 25,
                  ),
                ),*/
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationScreen(
                    shopId: ' retrievedId.toString()',
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_active,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colors.button_color,
                colors.button_color,
              ], // Use your preferred gradient colors
            ),
          ),
        ),
        title: FutureBuilder(
          future: getDataSession(),
          builder: (ctx, snapshot) {
            // Displaying LoadingSpinner to indicate waiting state
            return Text(
              // '${snapshot.data.toString()}',
              'ABC',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            );
          },
        ),
        // Text(
        //   'Dummy Test User 1234',
        //   style: const TextStyle(
        //     color: Colors.white,
        //     fontWeight: FontWeight.bold,
        //     fontSize: 20,
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Orders",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //grid//
              Container(
                height: 350,
                // color: Colors.red,
                child: GridView(
                  primary: false,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 7 / 4),
                  children: [
                    InkWell(
                      onTap: () {
                        // Get.to(DashbordItem(name: 'Completed'));
                        Get.to(Home(
                          index: 2,
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 8)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${venderSidetGetXController.getVendorDashboardDataModelDetail.totalCompleted ?? "0"}",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Completed",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    child: Image.asset(
                                      'assets/image/success1.png',
                                      // color: colors.button_color,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Get.to(DashbordItem(name: 'In Progress'));
                        Get.to(
                          Home(
                            index: 1,
                          ),
                        );
                        // In Progress
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 8)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${venderSidetGetXController.getVendorDashboardDataModelDetail.totalInProgress ?? "0"}",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "In Progress",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.deepPurple),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    child: Image.asset(
                                      'assets/image/dropbox.png',
                                      color: Colors.deepPurple,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Get.to(DashbordItem(name: 'In Progress'));
                        Get.to(Home(
                          index: 0,
                        ));
                        // In Progress
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 8)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${venderSidetGetXController.getVendorDashboardDataModelDetail.totalPending ?? "0"}",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "New Orders",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.lightBlue),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    child: Image.asset(
                                      'assets/new/minibus.jpeg',
                                      color: Colors.lightBlue,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Get.to(DashbordItem(name: 'Cancel'));
                        Get.to(Home(
                          index: 4,
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 8)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${venderSidetGetXController.getVendorDashboardDataModelDetail.totalCancelled ?? "0"}",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Cancelled",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red.shade600),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    child: Image.asset(
                                      'assets/image/x-button.png',
                                      // color: Colors.grey,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.to(Home(
                    //       index: 3,
                    //     ));
                    //     // Get.to(DashbordItem(name: 'Rejected'));
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(10),
                    //         boxShadow: [
                    //           BoxShadow(
                    //               color: Colors.grey.withOpacity(0.4),
                    //               spreadRadius: 2,
                    //               blurRadius: 8)
                    //         ]),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(15),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Column(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 "3",
                    //                 style: TextStyle(
                    //                     fontSize: 22,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //               Text(
                    //                 "Rejected",
                    //                 style: TextStyle(
                    //                     fontSize: 18,
                    //                     fontWeight: FontWeight.w500,
                    //                     color: Colors.deepPurple),
                    //               ),
                    //             ],
                    //           ),
                    //           Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Container(
                    //                 height: 35,
                    //                 width: 35,
                    //                 child: Image.asset(
                    //                   'assets/image/refund.png',
                    //                   color: Colors.deepPurple,
                    //                 ),
                    //               )
                    //             ],
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),

              ///////chart////////
              SizedBox(
                height: h / 80,
              ),
              // Row(
              //   children: [
              //     Text(
              //       "Earning Statistics",
              //       style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: h / 80,
              // ),

              // Container(
              //     height: h / 3,
              //     padding: const EdgeInsets.all(4),
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(5),
              //         boxShadow: [
              //           BoxShadow(color: Colors.grey.shade300, blurRadius: 2)
              //         ]),
              //     child: SfCartesianChart(
              //         primaryXAxis: CategoryAxis(),
              //         series: <LineSeries<_SalesData, String>>[
              //           LineSeries<_SalesData, String>(
              //               dataSource: <_SalesData>[
              //                 _SalesData('Jan', 35),
              //                 _SalesData('Feb', 28),
              //                 _SalesData('Mar', 34),
              //                 _SalesData('Apr', 32),
              //                 _SalesData('May', 40)
              //               ],
              //               xValueMapper: (_SalesData sales, _) => sales.year,
              //               yValueMapper: (_SalesData sales, _) => sales.sales)
              //         ]))
            ],
          ),
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

Future OpncloseManually() async {
  const String apiUrl =
      'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/manually_open_close';
  final Map<String, dynamic> data = {
    'shopId': '',
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    print("Response: ${response.body}");
    print("Check the Status true or not");
    print(data);
  } else {
    print("Error: ${response.statusCode}");
  }
}
