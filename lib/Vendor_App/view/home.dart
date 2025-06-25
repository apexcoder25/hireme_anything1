import 'dart:async';
import 'dart:convert';

import 'package:hire_any_thing/Vendor_App/cutom_widgets/button.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'order_detail.dart';

class Home extends StatefulWidget {
  int? index;

  Home({super.key, this.index});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  String? retrievedId;
  int? status;
  final shopName = ''.obs;

  @override
  void initState() {
    _tabController = TabController(
      length: 5, // Number of tabs
      vsync: this,
      initialIndex:
          int.parse("${widget.index ?? 0}"), // Set the initial index here
    );
    _tabController?.addListener(() {
      if (_tabController!.indexIsChanging) {
        setState(() {
          // Any state update if needed
        });
      }
    });

    // getIdFromSharedPreferences('id');
    loadPreviousLength();
    super.initState();
  }

  Future<void> getIdFromSharedPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString(key);
    print("Retrieved ID for------------------ $key: $retrievedId");
    checkStatus();
    Shopnaem();
    listhome();
    rejectOrder();
    //flatdel();
  }

  // void ring() {
  //   FlutterRingtonePlayer.play(
  //     fromAsset: "assets/sound/Old.mp3",
  //     looping: false,
  //     volume: 2,
  //     asAlarm: false,
  //   );
  //   Future.delayed(const Duration(seconds: 5), () {
  //     FlutterRingtonePlayer.stop();
  //   });
  // }

  bool isSelect = false;
  String urll = "";
  String shopnameee = "";

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKeys =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refreshData() async {
    await listhome();
    Shopnaem();
    rejectOrder();
    //flatdel();
    setState(() {});
  }

  int previousLength = 0;

  void loadPreviousLength() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      previousLength = prefs.getInt('previousLength') ?? 0;
    });
  }

  void savePreviousLength(int newLength) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      previousLength = newLength;
    });
    prefs.setInt('previousLength', newLength);
  }

  List<int> dataList = [1, 2, 3, 4, 5, 6, 7, 8];

  @override
  Widget build(BuildContext context) {
    print("index=>${widget.index}");
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: colors.button_color,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: colors.button_color,
          title: Text(
            'Oreders',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                color: colors.white,
                width: w,
                height: h / 15,
                child: TabBar(
                  controller: _tabController,
                  automaticIndicatorColorAdjustment: true,
                  isScrollable: true,
                  indicatorColor: Colors.red,
                  labelPadding: EdgeInsets.only(top: 5, right: 25, bottom: 5),
                  indicator: UnderlineTabIndicator(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        width: 2.0, color: colors.button_color),
                  ),
                  tabs: const [
                    // Text(
                    //   " All Order",
                    //   style: TextStyle(
                    //       color: colors.white,
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    Text(
                      "New Orders",
                      style: TextStyle(
                          color: colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "In Progress",
                      style: TextStyle(
                          color: colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Completed",
                      style: TextStyle(
                          color: colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rejected",
                      style: TextStyle(
                          color: colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Cancel",
                      style: TextStyle(
                          color: colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              RefreshIndicator(
                key: _refreshIndicatorKeys,
                backgroundColor: Colors.white,
                color: Colors.green,
                displacement: BorderSide.strokeAlignCenter,
                onRefresh: () => refreshData(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    color: colors.scaffold_background_color,
                    height: h / 1.3,
                    width: w,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20,
                        top: 20,
                        bottom: 60,
                      ),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            // itemCount: yourDataList.length,
                            itemCount: dataList.length,

                            itemBuilder: (context, index) {
                              if (6 > 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // String orderId =
                                      // yourDataList[index]
                                      // ["orderNumber"];
                                      // String userId =
                                      // yourDataList[index]
                                      // ["userid"];
                                      Get.to(Details(
                                        orderId: "123456",
                                        userId: "12324",
                                      ));
                                    },
                                    child: Material(
                                      elevation: 1,
                                      borderRadius: BorderRadius.circular(15),
                                      child: IntrinsicHeight(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 15.0,
                                              top: 10,
                                              bottom: 8,
                                              left: 15,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Order Number:123456789",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      '\$ 599',
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: h / 100),
                                                Text(
                                                  "Date: 12-08-2024",
                                                  style: const TextStyle(
                                                    color: colors.hintext_shop,
                                                  ),
                                                ),
                                                const Text(
                                                  "Product List :",
                                                  style: TextStyle(
                                                    color: colors.hintext_shop,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                for (var i = 0; i < 3; i++)
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: w / 3,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Item Name" ?? "",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              ":  limousine" ??
                                                                  "",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                SizedBox(height: h / 50),
                                                Container(
                                                  width: w / 1,
                                                  height: h / 1000,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(height: h / 100),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    if ("accept" ==
                                                        "accept") ...[Text("")],
                                                    if ("acceptsas" !=
                                                        "accept") ...[
                                                      ElevatedButton(
                                                        style: ButtonStyle(
                                                          shape:
                                                              MaterialStateProperty
                                                                  .all(
                                                            RoundedRectangleBorder(
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .red),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                          ),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .white),
                                                        ),
                                                        onPressed:
                                                            // yourDataList[index]["driverAssignStatus"] != "1" &&
                                                            //                               yourDataList[index]["driverAssignStatus"] != "2"
                                                            //                               ?
                                                            () async {
                                                          // await orderstatus("Reject", yourDataList[index]["orderNumber"], yourDataList[index]["userid"].toString());
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                  'Order Reject Successfully'),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          2),
                                                              backgroundColor:
                                                                  Colors.red,
                                                            ),
                                                          );
                                                        },
                                                        // : null,
                                                        child: const Text(
                                                          "Reject",
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        style: ButtonStyle(
                                                          shape:
                                                              MaterialStateProperty
                                                                  .all(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                          ),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .white),
                                                        ),
                                                        onPressed:
                                                            // yourDataList[index]["driverAssignStatus"] != "1" &&
                                                            //     yourDataList[index]["driverAssignStatus"] != "2"
                                                            //     ?
                                                            () async {
                                                          // await orderstatus("Accept", yourDataList[index]["orderNumber"].toString(), yourDataList[index]["userid"].toString());
                                                          // print("jkjkjkgjkghjkgjkg" + yourDataList[index]["orderNumber"].toString());
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                  'Order Accept Successfully'),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          2),
                                                              backgroundColor:
                                                                  Colors.green,
                                                            ),
                                                          );
                                                        },
                                                        // : null,
                                                        child: const Text(
                                                          "Accept",
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                                // Text(
                                                //   'Order No: ${yourDataList[index]["orderNumbertt"]}',
                                                //   style: TextStyle(
                                                //     color: colors.hintext_shop,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: 30.0),
                          //   child: Container(
                          //     child: FutureBuilder(
                          //       future: listhome(),
                          //       builder: (context, snapshot) {
                          //         if (snapshot.hasError) {
                          //           return const Center(
                          //             child: Text('Error loading data'),
                          //           );
                          //         } else {
                          //           if (yourDataList.isEmpty) {
                          //             return Center(
                          //               child: Column(
                          //                 children: [
                          //                   Lottie.asset(
                          //                     'assets/gif/homeempty.json',
                          //                     width: 150,
                          //                     height: 150,
                          //                     fit: BoxFit.cover,
                          //                   ),
                          //                   const Text(
                          //                     "No Orders Today",
                          //                     style: TextStyle(
                          //                       color: Colors.black,
                          //                       fontSize: 14,
                          //                       fontWeight: FontWeight.bold,
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             );
                          //           } else {
                          //             if (yourDataList.length >
                          //                 previousLength) {
                          //               ring();
                          //               savePreviousLength(
                          //                   yourDataList.length);
                          //             }
                          //
                          //             return ListView.builder(
                          //               shrinkWrap: true,
                          //               // itemCount: yourDataList.length,
                          //               itemCount: dataList.length,
                          //
                          //               itemBuilder: (context, index) {
                          //                 if (yourDataList[index][
                          //                 "driverAssignStatus"] ==
                          //                     "0" &&
                          //                     yourDataList[index]
                          //                     ["orderStatus"] !=
                          //                         "Cancel" &&
                          //                     yourDataList[index]["items"]
                          //                         .length >
                          //                         0) {
                          //                   return Padding(
                          //                     padding: const EdgeInsets.only(
                          //                         bottom: 15.0),
                          //                     child: GestureDetector(
                          //                       onTap: () {
                          //                         String orderId =
                          //                         yourDataList[index]
                          //                         ["orderNumber"];
                          //                         String userId =
                          //                         yourDataList[index]
                          //                         ["userid"];
                          //                         Get.to(Details(
                          //                           orderId: orderId,
                          //                           userId: userId,
                          //                         ));
                          //                       },
                          //                       child: Material(
                          //                         elevation: 1,
                          //                         borderRadius:
                          //                         BorderRadius.circular(
                          //                             15),
                          //                         child: IntrinsicHeight(
                          //                           child: Container(
                          //                             decoration:
                          //                             BoxDecoration(
                          //                               color: colors.white,
                          //                               borderRadius:
                          //                               BorderRadius
                          //                                   .circular(15),
                          //                             ),
                          //                             child: Padding(
                          //                               padding:
                          //                               const EdgeInsets
                          //                                   .only(
                          //                                 right: 15.0,
                          //                                 top: 10,
                          //                                 bottom: 8,
                          //                                 left: 15,
                          //                               ),
                          //                               child: Column(
                          //                                 crossAxisAlignment:
                          //                                 CrossAxisAlignment
                          //                                     .start,
                          //                                 children: [
                          //                                   Row(
                          //                                     mainAxisAlignment:
                          //                                     MainAxisAlignment
                          //                                         .spaceBetween,
                          //                                     children: [
                          //                                       Text(
                          //                                         "Order Number: ${yourDataList[index]["orderNumbertt"]}",
                          //                                         style:
                          //                                         const TextStyle(
                          //                                           fontWeight:
                          //                                           FontWeight
                          //                                               .bold,
                          //                                           fontSize:
                          //                                           15,
                          //                                         ),
                          //                                       ),
                          //                                       Text(
                          //                                         'GHS ${NumberFormat('#,##,###').format(int.parse(yourDataList[index]["price"]))}',
                          //                                         style:
                          //                                         const TextStyle(
                          //                                           fontSize:
                          //                                           17,
                          //                                           fontWeight:
                          //                                           FontWeight
                          //                                               .bold,
                          //                                         ),
                          //                                       ),
                          //                                     ],
                          //                                   ),
                          //                                   SizedBox(
                          //                                       height:
                          //                                       h / 100),
                          //                                   Text(
                          //                                     "Date: ${yourDataList[index]["date"]}",
                          //                                     style:
                          //                                     const TextStyle(
                          //                                       color: colors
                          //                                           .hintext_shop,
                          //                                     ),
                          //                                   ),
                          //                                   const Text(
                          //                                     "Product List :",
                          //                                     style:
                          //                                     TextStyle(
                          //                                       color: colors
                          //                                           .hintext_shop,
                          //                                     ),
                          //                                   ),
                          //                                   const SizedBox(
                          //                                       height: 4),
                          //                                   for (var i = 0;
                          //                                   i <
                          //                                       yourDataList[index]
                          //                                       [
                          //                                       "items"]
                          //                                           .length;
                          //                                   i++)
                          //                                     Row(
                          //                                       children: [
                          //                                         Container(
                          //                                           width:
                          //                                           w / 3,
                          //                                           child:
                          //                                           Column(
                          //                                             crossAxisAlignment:
                          //                                             CrossAxisAlignment.start,
                          //                                             children: [
                          //                                               Text(
                          //                                                 yourDataList[index]["items"][i]["name"] ??
                          //                                                     "",
                          //                                               ),
                          //                                             ],
                          //                                           ),
                          //                                         ),
                          //                                         Container(
                          //                                           child:
                          //                                           Column(
                          //                                             crossAxisAlignment:
                          //                                             CrossAxisAlignment.start,
                          //                                             children: [
                          //                                               Text(
                          //                                                 ":  ${yourDataList[index]["items"][i]["quantity"]}" ??
                          //                                                     "",
                          //                                               ),
                          //                                             ],
                          //                                           ),
                          //                                         ),
                          //                                       ],
                          //                                     ),
                          //                                   SizedBox(
                          //                                       height:
                          //                                       h / 50),
                          //                                   Container(
                          //                                     width: w / 1,
                          //                                     height:
                          //                                     h / 1000,
                          //                                     color:
                          //                                     Colors.grey,
                          //                                   ),
                          //                                   SizedBox(
                          //                                       height:
                          //                                       h / 100),
                          //                                   Row(
                          //                                     mainAxisAlignment:
                          //                                     MainAxisAlignment
                          //                                         .spaceAround,
                          //                                     children: [
                          //                                       if (yourDataList[
                          //                                       index]
                          //                                       [
                          //                                       "vendorStatus"] ==
                          //                                           "accept") ...[
                          //
                          //                                             Text("")
                          //                                         // Button_widget(
                          //                                         //   buttontext: yourDataList[index]["driverAssignStatus"] ==
                          //                                         //       "0"
                          //                                         //       ? "Assign"
                          //                                         //       : yourDataList[index]["driverAssignStatus"] == "1"
                          //                                         //       ? "In Progress"
                          //                                         //       : yourDataList[index]["driverAssignStatus"] == "2"
                          //                                         //       ? "Done"
                          //                                         //       : "",
                          //                                         //   button_height:
                          //                                         //   20,
                          //                                         //   button_weight:
                          //                                         //   3,
                          //                                         //   onpressed:
                          //                                         //       () async {
                          //                                         //     if (yourDataList[index]["driverAssignStatus"] !=
                          //                                         //         "1" &&
                          //                                         //         yourDataList[index]["driverAssignStatus"] !=
                          //                                         //             "2") {
                          //                                         //       String
                          //                                         //       orderId =
                          //                                         //       yourDataList[index]["orderNumber"];
                          //                                         //       String
                          //                                         //       userId =
                          //                                         //           yourDataList[index]["userid"] ?? "N/A";
                          //                                         //
                          //                                         //       SharedPreferences
                          //                                         //       prefs =
                          //                                         //       await SharedPreferences.getInstance();
                          //                                         //       prefs.setString(
                          //                                         //           'orderId',
                          //                                         //           orderId);
                          //                                         //       prefs.setString(
                          //                                         //           'userId',
                          //                                         //           userId);
                          //                                         //
                          //                                         //       print(
                          //                                         //           "OrderId: $orderId, UserId: $userId");
                          //                                         //       // Navigator
                          //                                         //       //     .push(
                          //                                         //       //   context,
                          //                                         //       //   MaterialPageRoute(
                          //                                         //       //     builder: (context) => const asigndelivery(),
                          //                                         //       //   ),
                          //                                         //       // );
                          //                                         //     }
                          //                                         //   },
                          //                                         // ),
                          //                                       ],
                          //                                       if (yourDataList[
                          //                                       index]
                          //                                       [
                          //                                       "vendorStatus"] !=
                          //                                           "accept") ...[
                          //                                         ElevatedButton(
                          //                                           style:
                          //                                           ButtonStyle(
                          //                                             shape: MaterialStateProperty
                          //                                                 .all(
                          //                                               RoundedRectangleBorder(
                          //                                                 side:
                          //                                                 const BorderSide(color: Colors.red),
                          //                                                 borderRadius:
                          //                                                 BorderRadius.circular(20),
                          //                                               ),
                          //                                             ),
                          //                                             backgroundColor:
                          //                                             MaterialStateProperty.all(Colors.white),
                          //                                           ),
                          //                                           onPressed: yourDataList[index]["driverAssignStatus"] != "1" &&
                          //                                               yourDataList[index]["driverAssignStatus"] != "2"
                          //                                               ? () async {
                          //                                             await orderstatus("Reject", yourDataList[index]["orderNumber"], yourDataList[index]["userid"].toString());
                          //                                             ScaffoldMessenger.of(context).showSnackBar(
                          //                                               const SnackBar(
                          //                                                 content: Text('Order Reject Successfully'),
                          //                                                 duration: Duration(seconds: 2),
                          //                                                 backgroundColor: Colors.red,
                          //                                               ),
                          //                                             );
                          //                                           }
                          //                                               : null,
                          //                                           child:
                          //                                           const Text(
                          //                                             "Reject",
                          //                                             style:
                          //                                             TextStyle(
                          //                                               color:
                          //                                               Colors.red,
                          //                                               fontSize:
                          //                                               17,
                          //                                             ),
                          //                                           ),
                          //                                         ),
                          //                                         ElevatedButton(
                          //                                           style:
                          //                                           ButtonStyle(
                          //                                             shape: MaterialStateProperty
                          //                                                 .all(
                          //                                               RoundedRectangleBorder(
                          //                                                 borderRadius:
                          //                                                 BorderRadius.circular(20),
                          //                                               ),
                          //                                             ),
                          //                                             backgroundColor:
                          //                                             MaterialStateProperty.all(Colors.white),
                          //                                           ),
                          //                                           onPressed: yourDataList[index]["driverAssignStatus"] != "1" &&
                          //                                               yourDataList[index]["driverAssignStatus"] != "2"
                          //                                               ? () async {
                          //                                             await orderstatus("Accept", yourDataList[index]["orderNumber"].toString(), yourDataList[index]["userid"].toString());
                          //                                             print("jkjkjkgjkghjkgjkg" + yourDataList[index]["orderNumber"].toString());
                          //                                             ScaffoldMessenger.of(context).showSnackBar(
                          //                                               const SnackBar(
                          //                                                 content: Text('Order Accept Successfully'),
                          //                                                 duration: Duration(seconds: 2),
                          //                                                 backgroundColor: Colors.green,
                          //                                               ),
                          //                                             );
                          //                                           }
                          //                                               : null,
                          //                                           child:
                          //                                           const Text(
                          //                                             "Accept",
                          //                                             style:
                          //                                             TextStyle(
                          //                                               color:
                          //                                               Colors.green,
                          //                                               fontSize:
                          //                                               17,
                          //                                             ),
                          //                                           ),
                          //                                         ),
                          //                                       ],
                          //                                     ],
                          //                                   ),
                          //                                   // Text(
                          //                                   //   'Order No: ${yourDataList[index]["orderNumbertt"]}',
                          //                                   //   style: TextStyle(
                          //                                   //     color: colors.hintext_shop,
                          //                                   //   ),
                          //                                   // ),
                          //                                 ],
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   );
                          //                 } else {
                          //                   return Container();
                          //                 }
                          //               },
                          //             );
                          //           }
                          //         }
                          //       },
                          //     ),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: 30.0),
                          //   child: Container(
                          //       child: ListView.builder(
                          //         shrinkWrap: true,
                          //         itemCount: yourDataList.length,
                          //         itemBuilder: (context, index) {
                          //           if (yourDataList[index]
                          //           ["driverAssignStatus"] ==
                          //               "1" ||
                          //               yourDataList[index]["orderStatus"] ==
                          //                   "Ready") {
                          //             return Padding(
                          //               padding:
                          //               const EdgeInsets.only(bottom: 15.0),
                          //               child: GestureDetector(
                          //                 onTap: () {
                          //                   String orderId = yourDataList[index]
                          //                   ["orderNumber"];
                          //                   String userId =
                          //                   yourDataList[index]["userid"];
                          //                   Get.to(Details(
                          //                     orderId: orderId,
                          //                     userId: userId,
                          //                   ));
                          //                 },
                          //                 child: Material(
                          //                   elevation: 1,
                          //                   borderRadius:
                          //                   BorderRadius.circular(15),
                          //                   child: IntrinsicHeight(
                          //                     child: Container(
                          //                       decoration: BoxDecoration(
                          //                         color: colors.white,
                          //                         borderRadius:
                          //                         BorderRadius.circular(15),
                          //                       ),
                          //                       child: Padding(
                          //                         padding: const EdgeInsets.only(
                          //                           right: 15.0,
                          //                           top: 10,
                          //                           bottom: 8,
                          //                           left: 15,
                          //                         ),
                          //                         child: Column(
                          //                           crossAxisAlignment:
                          //                           CrossAxisAlignment.start,
                          //                           children: [
                          //                             Row(
                          //                               mainAxisAlignment:
                          //                               MainAxisAlignment
                          //                                   .spaceBetween,
                          //                               children: [
                          //                                 Text(
                          //                                   "Order Number: ${yourDataList[index]["orderNumbertt"]}",
                          //                                   style: const TextStyle(
                          //                                     fontWeight:
                          //                                     FontWeight.bold,
                          //                                     fontSize: 15,
                          //                                   ),
                          //                                 ),
                          //                                 Text(
                          //                                   'ghs ${NumberFormat('#,##,###').format(int.parse(yourDataList[index]["price"]))}',
                          //                                   style: const TextStyle(
                          //                                     fontSize: 17,
                          //                                     fontWeight:
                          //                                     FontWeight.bold,
                          //                                   ),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                             SizedBox(height: h / 100),
                          //                             Text(
                          //                               "Date: ${yourDataList[index]["date"]}",
                          //                               style: const TextStyle(
                          //                                 color:
                          //                                 colors.hintext_shop,
                          //                               ),
                          //                             ),
                          //                             const Text(
                          //                               "Product List:",
                          //                               style: TextStyle(
                          //                                 color:
                          //                                 colors.hintext_shop,
                          //                               ),
                          //                             ),
                          //                             const SizedBox(height: 4),
                          //                             for (var i = 0;
                          //                             i <
                          //                                 yourDataList[index]
                          //                                 ["items"]
                          //                                     .length;
                          //                             i++)
                          //                               Row(
                          //                                 children: [
                          //                                   Container(
                          //                                     width: w / 3,
                          //                                     child: Column(
                          //                                       crossAxisAlignment:
                          //                                       CrossAxisAlignment
                          //                                           .start,
                          //                                       children: [
                          //                                         Text(
                          //                                           yourDataList[index]["items"]
                          //                                           [
                          //                                           i]
                          //                                           [
                          //                                           "name"] ??
                          //                                               "",
                          //                                         ),
                          //                                       ],
                          //                                     ),
                          //                                   ),
                          //                                   Container(
                          //                                     child: Column(
                          //                                       crossAxisAlignment:
                          //                                       CrossAxisAlignment
                          //                                           .start,
                          //                                       children: [
                          //                                         Text(
                          //                                           ":  ${yourDataList[index]["items"][i]["quantity"]}" ??
                          //                                               "",
                          //                                         ),
                          //                                       ],
                          //                                     ),
                          //                                   ),
                          //                                 ],
                          //                               ),
                          //                             SizedBox(height: h / 50),
                          //                             Container(
                          //                               width: w / 1,
                          //                               height: h / 1000,
                          //                               color: Colors.grey,
                          //                             ),
                          //                             SizedBox(height: h / 100),
                          //                             Row(
                          //                               mainAxisAlignment:
                          //                               MainAxisAlignment
                          //                                   .spaceAround,
                          //                               children: [
                          //                                 if (yourDataList[index][
                          //                                 "vendorStatus"] ==
                          //                                     "accept") ...[
                          //                                   Button_widget(
                          //                                     buttontext: yourDataList[ index]
                          //                                     ["driverAssignStatus"] == "0"
                          //                                         ? "Assign"
                          //                                         : yourDataList[index] ["driverAssignStatus"] == "1"
                          //                                         ? "Completed"
                          //                                         : yourDataList[index]["driverAssignStatus"] == "2"
                          //                                         ? "Completed"
                          //                                         : "",
                          //                                     button_height: 20,
                          //                                     button_weight: 3,
                          //                                     onpressed:
                          //                                         () async {
                          //                                           await completeOrederApi( yourDataList[index]["orderNumber"], "Completed");
                          //                                       // if (yourDataList[
                          //                                       // index]
                          //                                       // [
                          //                                       // "driverAssignStatus"] !=
                          //                                       //     "1" &&
                          //                                       //     yourDataList[
                          //                                       //     index]
                          //                                       //     [
                          //                                       //     "driverAssignStatus"] !=
                          //                                       //         "2") {
                          //                                       //   String orderId =
                          //                                       //   yourDataList[
                          //                                       //   index]
                          //                                       //   [
                          //                                       //   "orderNumber"];
                          //                                       //   String userId =
                          //                                       //       yourDataList[index]
                          //                                       //       [
                          //                                       //       "userid"] ??
                          //                                       //           "N/A";
                          //                                       //
                          //                                       //   SharedPreferences
                          //                                       //   prefs =
                          //                                       //   await SharedPreferences
                          //                                       //       .getInstance();
                          //                                       //   prefs.setString(
                          //                                       //       'orderId',
                          //                                       //       orderId);
                          //                                       //   prefs.setString(
                          //                                       //       'userId',
                          //                                       //       userId);
                          //                                       //
                          //                                       //   print(
                          //                                       //       "OrderId: $orderId, UserId: $userId");
                          //                                       //   // Navigator.push(
                          //                                       //   //   context,
                          //                                       //   //   MaterialPageRoute(
                          //                                       //   //     builder:
                          //                                       //   //         (context) =>
                          //                                       //   //     const asigndelivery(),
                          //                                       //   //   ),
                          //                                       //   // );
                          //                                       // }
                          //                                     },
                          //                                   ),
                          //                                 ],
                          //                                 if (yourDataList[index][
                          //                                 "vendorStatus"] !=
                          //                                     "accept") ...[
                          //                                   ElevatedButton(
                          //                                     style: ButtonStyle(
                          //                                       shape:
                          //                                       MaterialStateProperty
                          //                                           .all(
                          //                                         RoundedRectangleBorder(
                          //                                           side: const BorderSide(
                          //                                               color: Colors
                          //                                                   .red),
                          //                                           borderRadius:
                          //                                           BorderRadius
                          //                                               .circular(
                          //                                               20),
                          //                                         ),
                          //                                       ),
                          //                                       backgroundColor:
                          //                                       MaterialStateProperty
                          //                                           .all(Colors
                          //                                           .white),
                          //                                     ),
                          //                                     onPressed: yourDataList[index]
                          //                                     [
                          //                                     "driverAssignStatus"] !=
                          //                                         "1" &&
                          //                                         yourDataList[index]
                          //                                         [
                          //                                         "driverAssignStatus"] !=
                          //                                             "2"
                          //                                         ? () async {
                          //                                       await orderstatus(
                          //                                           "Reject",
                          //                                           yourDataList[index]
                          //                                           [
                          //                                           "orderNumber"],
                          //                                           yourDataList[index]["userid"]
                          //                                               .toString());
                          //                                       ScaffoldMessenger.of(
                          //                                           context)
                          //                                           .showSnackBar(
                          //                                         const SnackBar(
                          //                                           content:
                          //                                           Text('Order Reject Successfully'),
                          //                                           duration:
                          //                                           Duration(seconds: 2),
                          //                                           backgroundColor:
                          //                                           Colors.red,
                          //                                         ),
                          //                                       );
                          //                                     }
                          //                                         : null,
                          //                                     child: const Text(
                          //                                       "Reject",
                          //                                       style: TextStyle(
                          //                                         color:
                          //                                         Colors.red,
                          //                                         fontSize: 17,
                          //                                       ),
                          //                                     ),
                          //                                   ),
                          //                                   ElevatedButton(
                          //                                     style: ButtonStyle(
                          //                                       shape:
                          //                                       MaterialStateProperty
                          //                                           .all(
                          //                                         RoundedRectangleBorder(
                          //                                           borderRadius:
                          //                                           BorderRadius
                          //                                               .circular(
                          //                                               20),
                          //                                         ),
                          //                                       ),
                          //                                       backgroundColor:
                          //                                       MaterialStateProperty
                          //                                           .all(Colors
                          //                                           .white),
                          //                                     ),
                          //                                     onPressed: yourDataList[index]
                          //                                     [
                          //                                     "driverAssignStatus"] !=
                          //                                         "1" &&
                          //                                         yourDataList[index]
                          //                                         [
                          //                                         "driverAssignStatus"] !=
                          //                                             "2"
                          //                                         ? () async {
                          //                                       await orderstatus(
                          //                                           "Accept",
                          //                                           yourDataList[index]["orderNumber"]
                          //                                               .toString(),
                          //                                           yourDataList[index]["userid"]
                          //                                               .toString());
                          //                                       print("jkjkjkgjkghjkgjkg" +
                          //                                           yourDataList[index]["orderNumber"]
                          //                                               .toString());
                          //                                       ScaffoldMessenger.of(
                          //                                           context)
                          //                                           .showSnackBar(
                          //                                         const SnackBar(
                          //                                           content:
                          //                                           Text('Order Accept Successfully'),
                          //                                           duration:
                          //                                           Duration(seconds: 2),
                          //                                           backgroundColor:
                          //                                           Colors.green,
                          //                                         ),
                          //                                       );
                          //                                     }
                          //                                         : null,
                          //                                     child: const Text(
                          //                                       "Accept",
                          //                                       style: TextStyle(
                          //                                         color: Colors
                          //                                             .green,
                          //                                         fontSize: 17,
                          //                                       ),
                          //                                     ),
                          //                                   ),
                          //                                 ],
                          //                               ],
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             );
                          //           } else {
                          //             // If driverAssignStatus is not "0", return an empty container.
                          //             return Container();
                          //           }
                          //         },
                          //       )),
                          // )
                          ListView.builder(
                            shrinkWrap: true,
                            // itemCount: yourDataList.length,
                            itemCount: dataList.length - 4,

                            itemBuilder: (context, index) {
                              if (6 > 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // String orderId =
                                      // yourDataList[index]
                                      // ["orderNumber"];
                                      // String userId =
                                      // yourDataList[index]
                                      // ["userid"];
                                      Get.to(
                                        Details(
                                          orderId: "32321",
                                          userId: "45465",
                                        ),
                                      );
                                    },
                                    child: Material(
                                      elevation: 1,
                                      borderRadius: BorderRadius.circular(15),
                                      child: IntrinsicHeight(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 15.0,
                                              top: 10,
                                              bottom: 8,
                                              left: 15,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Order Number:123456789",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      '\$ 599',
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: h / 100),
                                                Text(
                                                  "Date: 12-08-2024",
                                                  style: const TextStyle(
                                                    color: colors.hintext_shop,
                                                  ),
                                                ),
                                                const Text(
                                                  "Product List :",
                                                  style: TextStyle(
                                                    color: colors.hintext_shop,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                for (var i = 0; i < 1; i++)
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: w / 3,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Item Name" ?? "",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              ":  5" ?? "",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                SizedBox(height: h / 50),
                                                Container(
                                                  width: w / 1,
                                                  height: h / 1000,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(height: h / 100),
                                                Center(
                                                  child: Button_widget(
                                                    buttontext: "In Progress",
                                                    button_height: 20,
                                                    button_weight: 2.5,
                                                    onpressed: () async {
                                                      // if ('0' != "1" &&
                                                      //     '1' != "2") {
                                                      //   String orderId =
                                                      //       "orderNumber";
                                                      //   String userId =
                                                      //       "userid";

                                                      //   SharedPreferences
                                                      //       prefs =
                                                      //       await SharedPreferences
                                                      //           .getInstance();
                                                      //   prefs.setString(
                                                      //       'orderId',
                                                      //       orderId);
                                                      //   prefs.setString(
                                                      //       'userId',
                                                      //       userId);

                                                      //   print(
                                                      //       "OrderId: $orderId, UserId: $userId");
                                                      // Navigator.push(
                                                      //   context,
                                                      //   MaterialPageRoute(
                                                      //     builder:
                                                      //         (context) =>
                                                      //             const asigndelivery(),
                                                      //   ),
                                                      // );
                                                      // }
                                                    },
                                                  ),
                                                ),
                                                // Text(
                                                //   'Order No: ${yourDataList[index]["orderNumbertt"]}',
                                                //   style: TextStyle(
                                                //     color: colors.hintext_shop,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            // itemCount: yourDataList.length,
                            itemCount: dataList.length - 2,

                            itemBuilder: (context, index) {
                              if (6 > 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // String orderId =
                                      // yourDataList[index]
                                      // ["orderNumber"];
                                      // String userId =
                                      // yourDataList[index]
                                      // ["userid"];
                                      Get.to(Details(
                                        orderId: "546546",
                                        userId: "5465",
                                      ));
                                    },
                                    child: Material(
                                      elevation: 1,
                                      borderRadius: BorderRadius.circular(15),
                                      child: IntrinsicHeight(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 15.0,
                                              top: 10,
                                              bottom: 8,
                                              left: 15,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Order Number:123456789",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      '\$ 599',
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: h / 100),
                                                Text(
                                                  "Date: 12-08-2024",
                                                  style: const TextStyle(
                                                    color: colors.hintext_shop,
                                                  ),
                                                ),
                                                const Text(
                                                  "Product List :",
                                                  style: TextStyle(
                                                    color: colors.hintext_shop,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                for (var i = 0; i < 4; i++)
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: w / 3,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Item Name" ?? "",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              ":  5" ?? "",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                SizedBox(height: h / 50),
                                                Container(
                                                  width: w / 1,
                                                  height: h / 1000,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(height: h / 100),
                                                Center(
                                                  child: Button_widget(
                                                    buttontext: "Completed",
                                                    button_height: 20,
                                                    button_weight: 2.5,
                                                    onpressed: () async {
                                                      // if ('0' != "1" &&
                                                      //     '1' != "2") {
                                                      //   String orderId =
                                                      //       "orderNumber";
                                                      //   String userId =
                                                      //       "userid";

                                                      //   SharedPreferences
                                                      //       prefs =
                                                      //       await SharedPreferences
                                                      //           .getInstance();
                                                      //   prefs.setString(
                                                      //       'orderId',
                                                      //       orderId);
                                                      //   prefs.setString(
                                                      //       'userId',
                                                      //       userId);

                                                      //   print(
                                                      //       "OrderId: $orderId, UserId: $userId");
                                                      // Navigator.push(
                                                      //   context,
                                                      //   MaterialPageRoute(
                                                      //     builder:
                                                      //         (context) =>
                                                      //             const asigndelivery(),
                                                      //   ),
                                                      // );
                                                      // }
                                                    },
                                                  ),
                                                ),
                                                // Text(
                                                //   'Order No: ${yourDataList[index]["orderNumbertt"]}',
                                                //   style: TextStyle(
                                                //     color: colors.hintext_shop,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          )
                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: 30.0),
                          //   child: Container(
                          //     child: ListView.builder(
                          //       shrinkWrap: true,
                          //       itemCount: yourDataList.length,
                          //       itemBuilder: (context, index) {
                          //         if (yourDataList[index]
                          //         ["driverAssignStatus"] ==
                          //             "3") {
                          //           return Padding(
                          //             padding:
                          //             const EdgeInsets.only(bottom: 15.0),
                          //             child: GestureDetector(
                          //               onTap: () {
                          //                 String orderId = yourDataList[index]
                          //                 ["orderNumber"];
                          //                 String userId =
                          //                 yourDataList[index]["userid"];
                          //                 Get.to(Details(
                          //                   orderId: orderId,
                          //                   userId: userId,
                          //                 ));
                          //               },
                          //               child: Material(
                          //                 elevation: 1,
                          //                 borderRadius:
                          //                 BorderRadius.circular(15),
                          //                 child: IntrinsicHeight(
                          //                   child: Container(
                          //                     decoration: BoxDecoration(
                          //                       color: colors.white,
                          //                       borderRadius:
                          //                       BorderRadius.circular(15),
                          //                     ),
                          //                     child: Padding(
                          //                       padding:
                          //                       const EdgeInsets.only(
                          //                         right: 15.0,
                          //                         top: 10,
                          //                         bottom: 8,
                          //                         left: 15,
                          //                       ),
                          //                       child: Column(
                          //                         crossAxisAlignment:
                          //                         CrossAxisAlignment
                          //                             .start,
                          //                         children: [
                          //                           Row(
                          //                             mainAxisAlignment:
                          //                             MainAxisAlignment
                          //                                 .spaceBetween,
                          //                             children: [
                          //                               Text(
                          //                                 "Order Number: ${yourDataList[index]["orderNumbertt"]}",
                          //                                 style: const TextStyle(
                          //                                   fontWeight:
                          //                                   FontWeight
                          //                                       .bold,
                          //                                   fontSize: 15,
                          //                                 ),
                          //                               ),
                          //                               Text(
                          //                                 'GHS ${NumberFormat('#,##,###').format(int.parse(yourDataList[index]["price"]))}',
                          //                                 style: const TextStyle(
                          //                                   fontSize: 17,
                          //                                   fontWeight:
                          //                                   FontWeight
                          //                                       .bold,
                          //                                 ),
                          //                               ),
                          //                             ],
                          //                           ),
                          //                           SizedBox(height: h / 100),
                          //                           Text(
                          //                             "Date: ${yourDataList[index]["date"]}",
                          //                             style: const TextStyle(
                          //                               color: colors
                          //                                   .hintext_shop,
                          //                             ),
                          //                           ),
                          //                           const Text(
                          //                             "Product List:",
                          //                             style: TextStyle(
                          //                               color: colors
                          //                                   .hintext_shop,
                          //                             ),
                          //                           ),
                          //                           SizedBox(height: h / 70),
                          //                           for (var i = 0;
                          //                           i <
                          //                               yourDataList[
                          //                               index]
                          //                               ["items"]
                          //                                   .length;
                          //                           i++)
                          //                             Row(
                          //                               children: [
                          //                                 Container(
                          //                                   width: w / 3,
                          //                                   child: Column(
                          //                                     crossAxisAlignment:
                          //                                     CrossAxisAlignment
                          //                                         .start,
                          //                                     children: [
                          //                                       Text(
                          //                                         yourDataList[index]["items"][i]
                          //                                         [
                          //                                         "name"] ??
                          //                                             "",
                          //                                       ),
                          //                                     ],
                          //                                   ),
                          //                                 ),
                          //                                 Container(
                          //                                   child: Column(
                          //                                     crossAxisAlignment:
                          //                                     CrossAxisAlignment
                          //                                         .start,
                          //                                     children: [
                          //                                       Text(
                          //                                         ":  ${yourDataList[index]["items"][i]["quantity"]}" ??
                          //                                             "",
                          //                                       ),
                          //                                     ],
                          //                                   ),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                           SizedBox(height: h / 50),
                          //                           Container(
                          //                             width: w / 1,
                          //                             height: h / 1000,
                          //                             color: Colors.grey,
                          //                           ),
                          //                           SizedBox(height: h / 100),
                          //                           Row(
                          //                             mainAxisAlignment:
                          //                             MainAxisAlignment
                          //                                 .spaceAround,
                          //                             children: [
                          //                               if (yourDataList[
                          //                               index][
                          //                               "vendorStatus"] ==
                          //                                   "accept") ...[
                          //                                     Text("Completed",style: TextStyle(
                          //                                       color: Colors.green,
                          //                                       fontSize: 18,
                          //                                       fontWeight: FontWeight.bold
                          //                                     ),)
                          //                                 // Button_widget(
                          //                                 //   buttontext: yourDataList[
                          //                                 //   index]
                          //                                 //   [
                          //                                 //   "driverAssignStatus"] ==
                          //                                 //       "0"
                          //                                 //       ? "Assign"
                          //                                 //       : yourDataList[index]
                          //                                 //   [
                          //                                 //   "driverAssignStatus"] ==
                          //                                 //       "1"
                          //                                 //       ? "In Progress"
                          //                                 //       : yourDataList[index]["driverAssignStatus"] ==
                          //                                 //       "3"
                          //                                 //       ? "Done"
                          //                                 //       : "",
                          //                                 //   button_height: 20,
                          //                                 //   button_weight: 3,
                          //                                 //   onpressed:
                          //                                 //       () async {
                          //                                 //      completeOrederApi( yourDataList[index]["orderNumber"], "Completed");
                          //                                 //
                          //                                 //
                          //                                 //     // if (yourDataList[index]
                          //                                 //     // [
                          //                                 //     // "driverAssignStatus"] !=
                          //                                 //     //     "1" &&
                          //                                 //     //     yourDataList[index]
                          //                                 //     //     [
                          //                                 //     //     "driverAssignStatus"] !=
                          //                                 //     //         "2") {
                          //                                 //     //   String
                          //                                 //     //   orderId =
                          //                                 //     //   yourDataList[
                          //                                 //     //   index]
                          //                                 //     //   [
                          //                                 //     //   "orderNumber"];
                          //                                 //     //   String
                          //                                 //     //   userId =
                          //                                 //     //       yourDataList[index]
                          //                                 //     //       [
                          //                                 //     //       "userid"] ??
                          //                                 //     //           "N/A";
                          //                                 //     //
                          //                                 //     //   SharedPreferences
                          //                                 //     //   prefs =
                          //                                 //     //   await SharedPreferences
                          //                                 //     //       .getInstance();
                          //                                 //     //   prefs.setString(
                          //                                 //     //       'orderId',
                          //                                 //     //       orderId);
                          //                                 //     //   prefs.setString(
                          //                                 //     //       'userId',
                          //                                 //     //       userId);
                          //                                 //     //
                          //                                 //     //   print(
                          //                                 //     //       "OrderId: $orderId, UserId: $userId");
                          //                                 //     //   // Navigator
                          //                                 //     //   //     .push(
                          //                                 //     //   //   context,
                          //                                 //     //   //   MaterialPageRoute(
                          //                                 //     //   //     builder:
                          //                                 //     //   //         (context) =>
                          //                                 //     //   //             asigndelivery(),
                          //                                 //     //   //   ),
                          //                                 //     //   // );
                          //                                 //     // }
                          //                                 //   },
                          //                                 // ),
                          //                               ],
                          //                               if (yourDataList[
                          //                               index][
                          //                               "vendorStatus"] !=
                          //                                   "accept") ...[
                          //                                 ElevatedButton(
                          //                                   style:
                          //                                   ButtonStyle(
                          //                                     shape:
                          //                                     MaterialStateProperty
                          //                                         .all(
                          //                                       RoundedRectangleBorder(
                          //                                         side: const BorderSide(
                          //                                             color: Colors
                          //                                                 .red),
                          //                                         borderRadius:
                          //                                         BorderRadius.circular(
                          //                                             20),
                          //                                       ),
                          //                                     ),
                          //                                     backgroundColor:
                          //                                     MaterialStateProperty
                          //                                         .all(Colors
                          //                                         .white),
                          //                                   ),
                          //                                   onPressed: yourDataList[index]
                          //                                   [
                          //                                   "driverAssignStatus"] !=
                          //                                       "1" &&
                          //                                       yourDataList[index]
                          //                                       [
                          //                                       "driverAssignStatus"] !=
                          //                                           "2"
                          //                                       ? () async {
                          //                                     await orderstatus(
                          //                                         "Reject",
                          //                                         yourDataList[index]
                          //                                         [
                          //                                         "orderNumber"],
                          //                                         yourDataList[index]["userid"]
                          //                                             .toString());
                          //                                     ScaffoldMessenger.of(
                          //                                         context)
                          //                                         .showSnackBar(
                          //                                       const SnackBar(
                          //                                         content:
                          //                                         Text('Order Reject Successfully'),
                          //                                         duration:
                          //                                         Duration(seconds: 2),
                          //                                         backgroundColor:
                          //                                         Colors.red,
                          //                                       ),
                          //                                     );
                          //                                   }
                          //                                       : null,
                          //                                   child: const Text(
                          //                                     "Reject",
                          //                                     style:
                          //                                     TextStyle(
                          //                                       color: Colors
                          //                                           .red,
                          //                                       fontSize: 17,
                          //                                     ),
                          //                                   ),
                          //                                 ),
                          //                                 ElevatedButton(
                          //                                   style:
                          //                                   ButtonStyle(
                          //                                     shape:
                          //                                     MaterialStateProperty
                          //                                         .all(
                          //                                       RoundedRectangleBorder(
                          //                                         borderRadius:
                          //                                         BorderRadius.circular(
                          //                                             20),
                          //                                       ),
                          //                                     ),
                          //                                     backgroundColor:
                          //                                     MaterialStateProperty
                          //                                         .all(Colors
                          //                                         .white),
                          //                                   ),
                          //                                   onPressed: yourDataList[index]
                          //                                   [
                          //                                   "driverAssignStatus"] !=
                          //                                       "1" &&
                          //                                       yourDataList[index]
                          //                                       [
                          //                                       "driverAssignStatus"] !=
                          //                                           "2"
                          //                                       ? () async {
                          //                                     await orderstatus(
                          //                                         "Accept",
                          //                                         yourDataList[index]["orderNumber"]
                          //                                             .toString(),
                          //                                         yourDataList[index]["userid"]
                          //                                             .toString());
                          //                                     print("jkjkjkgjkghjkgjkg" +
                          //                                         yourDataList[index]["orderNumber"]
                          //                                             .toString());
                          //                                     ScaffoldMessenger.of(
                          //                                         context)
                          //                                         .showSnackBar(
                          //                                       const SnackBar(
                          //                                         content:
                          //                                         Text('Order Accept Successfully'),
                          //                                         duration:
                          //                                         Duration(seconds: 2),
                          //                                         backgroundColor:
                          //                                         Colors.green,
                          //                                       ),
                          //                                     );
                          //                                   }
                          //                                       : null,
                          //                                   child: const Text(
                          //                                     "Accept",
                          //                                     style:
                          //                                     TextStyle(
                          //                                       color: Colors
                          //                                           .green,
                          //                                       fontSize: 17,
                          //                                     ),
                          //                                   ),
                          //                                 ),
                          //                               ],
                          //                             ],
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         } else {
                          //           // If driverAssignStatus is not "0", return an empty container.
                          //           return Container();
                          //         }
                          //       },
                          //     ),
                          //   ),
                          // )
                          ,
                          ListView.builder(
                            shrinkWrap: true,
                            // itemCount: yourDataList.length,
                            itemCount: dataList.length - 2,

                            itemBuilder: (context, index) {
                              if (6 > 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // String orderId =
                                      // yourDataList[index]
                                      // ["orderNumber"];
                                      // String userId =
                                      // yourDataList[index]
                                      // ["userid"];
                                      Get.to(Details(
                                        orderId: "322",
                                        userId: "236215",
                                      ));
                                    },
                                    child: Material(
                                      elevation: 1,
                                      borderRadius: BorderRadius.circular(15),
                                      child: IntrinsicHeight(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 15.0,
                                              top: 10,
                                              bottom: 8,
                                              left: 15,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Order Number:123456789",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      '\$ 599',
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: h / 100),
                                                Text(
                                                  "Date: 12-08-2024",
                                                  style: const TextStyle(
                                                    color: colors.hintext_shop,
                                                  ),
                                                ),
                                                const Text(
                                                  "Product List :",
                                                  style: TextStyle(
                                                    color: colors.hintext_shop,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                for (var i = 0; i < 2; i++)
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: w / 3,
                                                        child: const Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Item Name" ?? "",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              ":  5" ?? "",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                SizedBox(height: h / 50),
                                                Container(
                                                  width: w / 1,
                                                  height: h / 1000,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(height: h / 100),
                                                Center(
                                                  child: Button_widget(
                                                    buttontext: "Rejected",
                                                    button_height: 20,
                                                    button_weight: 3,
                                                    onpressed: () async {
                                                      // if ('0' != "1" &&
                                                      //     '1' != "2") {
                                                      //   String orderId =
                                                      //       "orderNumber";
                                                      //   String userId =
                                                      //       "userid";

                                                      //   SharedPreferences
                                                      //       prefs =
                                                      //       await SharedPreferences
                                                      //           .getInstance();
                                                      //   prefs.setString(
                                                      //       'orderId',
                                                      //       orderId);
                                                      //   prefs.setString(
                                                      //       'userId',
                                                      //       userId);

                                                      //   print(
                                                      //       "OrderId: $orderId, UserId: $userId");
                                                      // Navigator.push(
                                                      //   context,
                                                      //   MaterialPageRoute(
                                                      //     builder:
                                                      //         (context) =>
                                                      //             const asigndelivery(),
                                                      //   ),
                                                      // );
                                                      // }
                                                    },
                                                  ),
                                                ),
                                                // Text(
                                                //   'Order No: ${yourDataList[index]["orderNumbertt"]}',
                                                //   style: TextStyle(
                                                //     color: colors.hintext_shop,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          )
                          // orders.isEmpty
                          //     ? Center(
                          //   child: Column(
                          //     children: [
                          //       Lottie.asset(
                          //         'assets/gif/homeempty.json',
                          //         width: 150,
                          //         height: 150,
                          //         fit: BoxFit.cover,
                          //       ),
                          //       const Text(
                          //         "No Rejected Orders",
                          //         style: TextStyle(
                          //           color: Colors.black,
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                          //     : StreamBuilder(
                          //     stream:
                          //     Stream.periodic(const Duration(seconds: 0))
                          //         .asyncMap((i) => rejectOrder()),
                          //     builder: (BuildContext context,
                          //         AsyncSnapshot<dynamic> snapshot) {
                          //       return ListView.builder(
                          //         itemCount: orders.length,
                          //         itemBuilder: (context, index) {
                          //           final order = orders[index];
                          //           final productList = order['products']
                          //           as List<dynamic>;
                          //
                          //           return Card(
                          //             child: ListTile(
                          //               title: Row(
                          //                 mainAxisAlignment:
                          //                 MainAxisAlignment
                          //                     .spaceBetween,
                          //                 children: [
                          //                   Padding(
                          //                     padding:
                          //                     const EdgeInsets.only(
                          //                         top: 10.0),
                          //                     child: Text(
                          //                       'Order Number: ${order['order_no']}',
                          //                       style: const TextStyle(
                          //                         color: Colors.black,
                          //                         fontWeight:
                          //                         FontWeight.bold,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   Text(
                          //                       '${order['grand_total']}',
                          //                       style: const TextStyle(
                          //                           fontWeight:
                          //                           FontWeight.bold)),
                          //                 ],
                          //               ),
                          //               subtitle: Column(
                          //                 crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //                 children: [
                          //                   const SizedBox(
                          //                     height: 5,
                          //                   ),
                          //                   Row(
                          //                     mainAxisAlignment:
                          //                     MainAxisAlignment
                          //                         .spaceBetween,
                          //                     children: [
                          //                       Text(
                          //                           'Date ${order['order_date']}'),
                          //                       SizedBox(
                          //                           height: 40,
                          //                           child: Image.asset(
                          //                               "assets/image/rejectedorders.png")),
                          //                     ],
                          //                   ),
                          //                   const Text('Product List: '),
                          //                   const SizedBox(height: 8.0),
                          //                   Column(
                          //                     children: productList
                          //                         .map(
                          //                             (product) =>
                          //                             Padding(
                          //                               padding:
                          //                               const EdgeInsets
                          //                                   .all(
                          //                                   4.0),
                          //                               child: Row(
                          //                                 children: [
                          //                                   Expanded(
                          //                                     child: Text(
                          //                                         '${product['product_name']}',
                          //                                         style:
                          //                                         const TextStyle(color: Colors.black)),
                          //                                   ),
                          //                                   Expanded(
                          //                                     child: Text(
                          //                                         '${product['variants']}',
                          //                                         style:
                          //                                         const TextStyle(color: Colors.black)),
                          //                                   ),
                          //                                 ],
                          //                               ),
                          //                             ))
                          //                         .toList(),
                          //                   ),
                          //                   const SizedBox(height: 10.0),
                          //                 ],
                          //               ),
                          //               onTap: () {},
                          //             ),
                          //           );
                          //         },
                          //       );
                          //     })
                          ,
                          ListView.builder(
                            shrinkWrap: true,
                            // itemCount: yourDataList.length,
                            itemCount: dataList.length - 2,

                            itemBuilder: (context, index) {
                              if (6 > 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // String orderId =
                                      // yourDataList[index]
                                      // ["orderNumber"];
                                      // String userId =
                                      // yourDataList[index]
                                      // ["userid"];
                                      Get.to(Details(
                                        orderId: "231545",
                                        userId: "232",
                                      ));
                                    },
                                    child: Material(
                                      elevation: 1,
                                      borderRadius: BorderRadius.circular(15),
                                      child: IntrinsicHeight(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 15.0,
                                              top: 10,
                                              bottom: 8,
                                              left: 15,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Order Number:123456789",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      '\$ 599',
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: h / 100),
                                                const Text(
                                                  "Date: 12-08-2024",
                                                  style: const TextStyle(
                                                    color: colors.hintext_shop,
                                                  ),
                                                ),
                                                const Text(
                                                  "Product List :",
                                                  style: TextStyle(
                                                    color: colors.hintext_shop,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                for (var i = 0; i < 1; i++)
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: w / 3,
                                                        child: const Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Item Name" ?? "",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: const Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              ":  5" ?? "",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                SizedBox(height: h / 50),
                                                Container(
                                                  width: w / 1,
                                                  height: h / 1000,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(height: h / 100),
                                                Center(
                                                  child: Button_widget(
                                                    buttontext: "Cancel",
                                                    button_height: 20,
                                                    button_weight: 3,
                                                    onpressed: () async {
                                                      // if ('0' != "1" &&
                                                      //     '1' != "2") {
                                                      //   String orderId =
                                                      //       "orderNumber";
                                                      //   String userId =
                                                      //       "userid";

                                                      //   SharedPreferences
                                                      //       prefs =
                                                      //       await SharedPreferences
                                                      //           .getInstance();
                                                      //   prefs.setString(
                                                      //       'orderId',
                                                      //       orderId);
                                                      //   prefs.setString(
                                                      //       'userId',
                                                      //       userId);

                                                      //   print(
                                                      //       "OrderId: $orderId, UserId: $userId");
                                                      // Navigator.push(
                                                      //   context,
                                                      //   MaterialPageRoute(
                                                      //     builder:
                                                      //         (context) =>
                                                      //             const asigndelivery(),
                                                      //   ),
                                                      // );
                                                      // }
                                                    },
                                                  ),
                                                ),
                                                // Text(
                                                //   'Order No: ${yourDataList[index]["orderNumbertt"]}',
                                                //   style: TextStyle(
                                                //     color: colors.hintext_shop,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          )
                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: 30.0),
                          //   child: ListView.builder(
                          //     shrinkWrap: true,
                          //     itemCount: yourDataList.length,
                          //     itemBuilder: (context, index) {
                          //       if (yourDataList[index]["orderStatus"] ==
                          //           "Cancel") {
                          //         return Padding(
                          //           padding:
                          //           const EdgeInsets.only(bottom: 15.0),
                          //           child: GestureDetector(
                          //             onTap: () {
                          //               String orderId = yourDataList[index]
                          //               ["orderNumber"];
                          //               String userId =
                          //               yourDataList[index]["userid"];
                          //               //Get.to(Details(orderId: orderId, userId: userId,));
                          //             },
                          //             child: Material(
                          //               elevation: 1,
                          //               borderRadius:
                          //               BorderRadius.circular(15),
                          //               child: IntrinsicHeight(
                          //                 child: Container(
                          //                   decoration: BoxDecoration(
                          //                     color: colors.white,
                          //                     borderRadius:
                          //                     BorderRadius.circular(15),
                          //                   ),
                          //                   child: Padding(
                          //                     padding: const EdgeInsets.only(
                          //                       right: 15.0,
                          //                       top: 10,
                          //                       bottom: 8,
                          //                       left: 15,
                          //                     ),
                          //                     child: Column(
                          //                       crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                       children: [
                          //                         Row(
                          //                           mainAxisAlignment:
                          //                           MainAxisAlignment
                          //                               .spaceBetween,
                          //                           children: [
                          //                             Text(
                          //                               "Order Number: ${yourDataList[index]["orderNumbertt"]}",
                          //                               style: const TextStyle(
                          //                                 fontWeight:
                          //                                 FontWeight.bold,
                          //                                 fontSize: 15,
                          //                               ),
                          //                             ),
                          //                             Text(
                          //                               'GHS ${NumberFormat('#,##,###').format(int.parse(yourDataList[index]["price"]))}',
                          //                               style: const TextStyle(
                          //                                 fontSize: 17,
                          //                                 fontWeight:
                          //                                 FontWeight.bold,
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                         SizedBox(height: h / 100),
                          //                         Text(
                          //                           "Date: ${yourDataList[index]["date"]}",
                          //                           style: const TextStyle(
                          //                             color:
                          //                             colors.hintext_shop,
                          //                           ),
                          //                         ),
                          //                         const Text(
                          //                           "Product List: ",
                          //                           style: TextStyle(
                          //                             color:
                          //                             colors.hintext_shop,
                          //                           ),
                          //                         ),
                          //                         const SizedBox(height: 4),
                          //                         for (var i = 0;
                          //                         i <
                          //                             yourDataList[index]
                          //                             ["items"]
                          //                                 .length;
                          //                         i++)
                          //                           Row(
                          //                             children: [
                          //                               Container(
                          //                                 width: w / 3,
                          //                                 child: Column(
                          //                                   crossAxisAlignment:
                          //                                   CrossAxisAlignment
                          //                                       .start,
                          //                                   children: [
                          //                                     Text(
                          //                                       yourDataList[index]["items"]
                          //                                       [
                          //                                       i]
                          //                                       [
                          //                                       "name"] ??
                          //                                           "",
                          //                                     ),
                          //                                   ],
                          //                                 ),
                          //                               ),
                          //                               Container(
                          //                                 child: Column(
                          //                                   crossAxisAlignment:
                          //                                   CrossAxisAlignment
                          //                                       .start,
                          //                                   children: [
                          //                                     Text(
                          //                                       ":  ${yourDataList[index]["items"][i]["quantity"]}" ??
                          //                                           "",
                          //                                     ),
                          //                                   ],
                          //                                 ),
                          //                               ),
                          //                             ],
                          //                           ),
                          //                         SizedBox(height: h / 50),
                          //                         Container(
                          //                           width: w / 1,
                          //                           height: h / 1000,
                          //                           color: Colors.grey,
                          //                         ),
                          //                         SizedBox(height: h / 100),
                          //                         SizedBox(
                          //                             height: 50,
                          //                             child: Image.asset(
                          //                               "assets/image/cancelled.png",
                          //                             ))
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         );
                          //       } else {
                          //         return Container();
                          //       }
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //assets/image/rejectedorders.png
  String? singleOrderDate;
  int? grandTotal;
  String? Priceee;
  String? Orderidd;
  String? userid;
  List<Map<String, dynamic>> yourDataList = [];

  Future<void> listhome() async {
    final String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/shop_order_list';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "shopId": retrievedId.toString(),
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(response.body);
      //print("-----------------------------");

      if (data.containsKey('data')) {
        List<dynamic> orderList = data['data'];

        setState(() {
          yourDataList.clear();
        });

        for (var order in orderList) {
          if (order.containsKey('order_date')) {
            singleOrderDate = order['order_date'];
            Orderidd = order['orderId'];
            userid = order['userId'];
            Priceee = order['grand_total'].toString();
            grandTotal = int.tryParse(Priceee ?? '');
          }

          if (order.containsKey('products')) {
            List<dynamic> products = order['products'];
            List<Map<String, dynamic>> productList = [];

            for (var product in products) {
              if (product.containsKey('product_name') &&
                  product.containsKey('variants')) {
                String productName = product['product_name'];
                String variant = product['variants'];

                productList.add({
                  "name": productName,
                  "quantity": variant,
                });
              }
            }

            setState(() {
              yourDataList.add({
                "orderNumbertt": order['order_no'].toString(),
                "orderNumber": Orderidd ?? "",
                "userid": userid ?? "",
                "price": Priceee ?? "",
                "date": singleOrderDate ?? "",
                "items": productList,
                "vendorStatus": order['vender_status'],
                "orderStatus": order['order_status'],
                "driverAssignStatus": order['driver_assign_status'],
              });
            });
          }
        }
      }
    } else {
      print('Request failed');
    }
  }

  Future<void> orderstatus(
      String action, String orderId, String useridforaccept) async {
    if (orderId == null) {
      print("Error: orderId is null");
      return;
    }

    final String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/update_order_status';
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    final Map<String, String> data = {
      'orderId': orderId,
      'userId': useridforaccept.toString(),
      'order_status': (action == 'Accept') ? 'In Progress' : 'Cancel',
      'vender_status': (action == 'Accept') ? 'accept' : 'reject',
    };

    final String requestBody = json.encode(data);
    print('Request Body: $requestBody');

    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: requestBody);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('Decoded Response: $jsonResponse');
        await listhome();
      } else {
        print("API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error in orderstatus: $e");
    }
  }

  Future<void> completeOrederApi(String orderId, String status) async {
    if (orderId == null) {
      print("Error: orderId is null");
      return;
    }

    final String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/completed_order_status';
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    final Map<String, String> data = {
      'orderId': orderId,
      "order_status": status
    };

    final String requestBody = json.encode(data);
    print('Request Body: $requestBody');

    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: requestBody);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('Decoded Response: $jsonResponse');
        await listhome();
      } else {
        print("API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error in orderstatus: $e");
    }
  }

  Future checkStatus() async {
    var response = await http.post(
        Uri.parse(
            "https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/getStatus"),
        body: {"shopId": retrievedId});
    var res_data = json.decode(response.body);
    print(response.body);
    print(res_data);
    if (response.statusCode == 200 &&
        res_data["result"].toString() == "true".toString()) {
      final status = res_data['data']['status'];
      if (status == 1) {
        setState(() {
          print(status);
          isSelect = false;
        });
      } else {
        setState(() {
          print(status);
          isSelect = true;
        });
      }
    } else {
      print("Not Found");
    }
  }

  Future Opnclose() async {
    const String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/shopOpen_close';
    final Map<String, dynamic> data = {
      'shopId': retrievedId,
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
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  Future OpncloseManually() async {
    const String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/manually_open_close';
    final Map<String, dynamic> data = {
      'shopId': retrievedId,
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

  Future Shopnaem() async {
    final String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/getVenderProfile';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> data = {
      'shopId': "656556",
    };

    final String requestBody = json.encode(data);
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: requestBody);

      if (response.statusCode == 200) {
        //print("***********************************shopnamehome*****************************************************");
        // print("Response: ${response.body}");
        final jsonResponse = json.decode(response.body);
        shopnameee = jsonResponse['data']['shop_name'];
        urll = jsonResponse['data']['shop_image'][0];
        //print("----------------------------");
        //print("$shopnameee");
        //print("$urll");
        //print("----------------------------");
      } else {
        print("API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  List<Map<String, dynamic>> orders = [];

  Future<void> rejectOrder() async {
    const String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/reject_order_list';
    final Map<String, dynamic> data = {
      'shopId': retrievedId,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print(response.body);
      final List<dynamic> responseData = jsonDecode(response.body)['data'];
      setState(() {
        orders = List<Map<String, dynamic>>.from(responseData);
      });
    } else {
      print("Error: ${response.statusCode}");
    }
  }
}
