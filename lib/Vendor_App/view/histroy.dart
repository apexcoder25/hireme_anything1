import 'dart:convert';

import 'package:hire_any_thing/Vendor_App/constant/api_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/date_shop_order_list.dart';
import '../model/monthly_shop_order_list.dart';
import '../model/today_shop_orderlist_model.dart';
import '../model/weekly_shop_orderlist.dart';
import '../uiltis/color.dart';
import 'histroyorderdeatils.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String? retrievedId;

  @override
  void initState() {
    super.initState();
    getIdFromSharedPreferences().then((_) {
      if (retrievedId != null) {
        print('Retrieved history shop ID: $retrievedId');
      } else {}
    });
  }

  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');

    print("Retrieved ID: $retrievedId");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: colors.button_color,
          title: const Text('Report',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 4.0, color: Colors.white),
            ),
            tabs: const [
              Tab(
                child: Text("Today",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              Tab(
                  child: Text("This Week",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white))),
              Tab(
                  child: Text("This Month",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white))),
              Tab(
                  child: Text("Select Date",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white))),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                TodayContent(),
              ],
            ),
            ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                weekhist(),
              ],
            ),
            ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                thidmonth(),
              ],
            ),
            ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Selectdate(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TodayContent extends StatefulWidget {
  @override
  _TodayContentState createState() => _TodayContentState();
}

class _TodayContentState extends State<TodayContent> {
  List<Map<String, dynamic>> orderData = [];
  TodayShopOrderListModel? todayShopOrderListModel;
  String? retrievedId;

  bool isLoading = true;

  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
    print("Retrieved ID: $retrievedId");
  }

  @override
  void initState() {
    super.initState();
    getIdFromSharedPreferences().then((_) {
      if (retrievedId != null) {
        print('Retrieved history shop ID: $retrievedId');
        todayHistory();
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Future<void> todayHistory() async {
    const url =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/today_shop_order_list';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> body = {
      //"shopId": "6571c0b49d0b22207f1d9829"
      "shopId": retrievedId.toString(),
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      print("aaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");

      if (response.statusCode == 200) {
        print("+++++++++++++++++++++++today+++++++++++++++++++++++++++");
        final jsonResponse = jsonDecode(response.body);
        todayShopOrderListModel =
            TodayShopOrderListModel.fromJson(jsonResponse);
        print("modeldatadddddddddddddddddddddddddddddddddddddddddddd");
        print(todayShopOrderListModel?.data);
        print(todayShopOrderListModel?.data[0]["total_sells"]);
        print(todayShopOrderListModel?.data[0]["total_sells"]);
        print("orderlenthdddddddddddddddddddssss");
        print(todayShopOrderListModel.toString().length);
        if (jsonResponse['result'] == 'true' &&
            jsonResponse.containsKey('data')) {
          setState(() {
            print("orderlengthddddd)))))))))))))))))))))))");
            print(orderData.length);
            orderData = List<Map<String, dynamic>>.from(
                jsonResponse['data'] ?? []); // Use the null-aware operator
          });

          setState(() {
            isLoading = false; // Stop showing loader after data is loaded
          });
        } else {
          print('API Response has unexpected format.');
        }

        print('API Response: ${response.body}');
      } else {
        print('API Error: ${response.statusCode}');
        print('API Response: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false; // Stop showing loader on error
      });
    }
  }

  Widget buildSummaryItem(String title, String value, Color textColor) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Column(
      children: [
        if (isLoading)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: const Color(0xFF000000), // Green color
                rightDotColor: const Color(0xFF000000), // Black color
                size: 30,
              ),
            ),
          )
        else
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colors.white,
                // gradient: const LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                //   colors: [Colors.green, Colors.teal],
                // ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Today Orders Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildSummaryItem(
                          'No. of Orders',
                          todayShopOrderListModel?.data != null
                              ? "${todayShopOrderListModel?.data[0]["no_of_order"]}"
                              : 'N/A',
                          Colors.black),
                      buildSummaryItem(
                          'Order Value',
                          todayShopOrderListModel?.data != null
                              ? '\u{20b9} ${todayShopOrderListModel?.data[0]['order_value']}'
                              : 'N/A',
                          Colors.black),
                      buildSummaryItem(
                          'Settlements',
                          todayShopOrderListModel?.data != null
                              ? "${todayShopOrderListModel?.data[0]['settlements']}"
                              : 'N/A',
                          Colors.black),
                    ],
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 20),
        if (todayShopOrderListModel?.data == null)
          Center(
            child: Column(
              children: [
                Lottie.asset(
                  'assets/gif/homeempty.json',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const Text(
                  "No Orders Today",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            itemCount: todayShopOrderListModel?.data.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final order = todayShopOrderListModel?.data[index];
              // final orderId = order['order_no'] ?? '';
              // final totalAmount = order['total_ammount'] ?? '';
              // final totalSells = order['total_sells'] ?? '';
              // final orderDate = order['order_date'] ?? '';
              // final orderstatus = order['order_status'] ?? '';
              // //final productName = order['products'][0]['product_name'] ?? 'No Product';

              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(HistroyDetails(
                      orderId: todayShopOrderListModel?.data[index]["orderId"],
                      userId: todayShopOrderListModel?.data[index]["userId"],
                    ));
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Text(
                                    'Order Number:',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  '\u{20B9}${todayShopOrderListModel!.data[index]['order_no'].toString()}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                todayShopOrderListModel?.data[index]
                                    ['order_date'],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            todayShopOrderListModel
                                        ?.data[index]['products'].length !=
                                    null
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: todayShopOrderListModel
                                        ?.data[index]['products'].length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Text(todayShopOrderListModel
                                                  ?.data[index]['products']
                                              [index]["product_name"] ??
                                          "");
                                    },
                                  )
                                : const Text(
                                    "",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red),
                                  ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10.0, right: 5),
                                  child: Text(
                                    'Total Ammount :',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    '\u{20B9}${todayShopOrderListModel!.data[index]['total_ammount'].toString()}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

class weekhist extends StatefulWidget {
  @override
  _weekhistState createState() => _weekhistState();
}

class _weekhistState extends State<weekhist> {
  Widget buildSummaryItem(String title, String value, Color textColor) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> orderData2 = [];
  String? retrievedId;
  bool isLoading = true;
  WeeklyShopOrderListModel? weeklyShopOrderListModel;
  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
    print("Retrieved ID: $retrievedId");
  }

  @override
  void initState() {
    super.initState();
    getIdFromSharedPreferences().then((_) {
      if (retrievedId != null) {
        print('Retrieved history shop ID: $retrievedId');
        weekHistory();
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Future<void> weekHistory() async {
    final url = ApiUrl.baseUrl + ApiUrl.weeklyShopOrderListUrl;
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> body = {
      "shopId": retrievedId.toString(),
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print("+++++++++++++++++++++++week+++++++++++++++++++++++++++");
        print("${orderData2.length}");

        final jsonResponse = jsonDecode(response.body);
        weeklyShopOrderListModel =
            WeeklyShopOrderListModel.fromJson(jsonResponse);
        print("teshdddddddddddddddddddingggggggggggddddddddddddddd bbbbbbbbb");
        print(weeklyShopOrderListModel?.data);
        if (jsonResponse['result'] == 'true' &&
            jsonResponse.containsKey('data')) {
          setState(() {
            orderData2 =
                List<Map<String, dynamic>>.from(jsonResponse['data'] ?? []);
          });
          setState(() {
            isLoading = false;
          });
        } else {
          print('API Response has unexpected format.');
        }

        print('API Response: ${response.body}');
      } else {
        print('API Error: ${response.statusCode}');
        print('API Response: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false; // Stop showing loader on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    // return Center(
    //   child: Column(
    //     children: [
    //       Container(
    //         height: 60,
    //         width: double.infinity,
    //         decoration: BoxDecoration(color: Colors.black12),
    //         child: Padding(
    //           padding: const EdgeInsets.only(left: 10.0, right: 10),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text('No: of Orders'),
    //               Text('Order Value'),
    //               Text('Settlements'),
    //             ],
    //           ),
    //         ),
    //       ),
    //       SizedBox(height: 20),
    //       if (orderData2.isEmpty)
    //         Center(
    //           child: Column(
    //             children: [
    //               Lottie.asset(
    //                 'assets/gif/homeempty.json',
    //                 width: 150,
    //                 height: 150,
    //                 fit: BoxFit.cover,
    //               ),
    //               Text(
    //                 "No Orders",
    //                 style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       // ListView.builder(
    //       //   shrinkWrap: true,
    //       //   itemCount: orderData2.length,
    //       //   physics: NeverScrollableScrollPhysics(),
    //       //   itemBuilder: (context, index) {
    //       //     final order = orderData2[index];
    //       //     final orderId = order['order_no'] ?? '';
    //       //     final totalAmount = order['total_ammount'] ?? '';
    //       //     final totalSells = order['total_sells'] ?? '';
    //       //     final orderDate = order['order_date'] ?? '';
    //       //     final orderstatus = order['order_status'] ?? '';
    //       //     //final Userid = order[''] ?? '';
    //       //     //final productName = order['products'] ?? '';
    //       //
    //       //     return Padding(
    //       //       padding: const EdgeInsets.only(bottom: 15.0),
    //       //       child: GestureDetector(
    //       //         onTap: (){
    //       //           Get.to(HistroyDetails(
    //       //             orderId: orderData2[index]["orderId"],
    //       //             userId: orderData2[index]["userId"],));
    //       //         },
    //       //         child: Material(
    //       //           borderRadius: BorderRadius.circular(10),
    //       //           elevation: 2,
    //       //           child: Container(
    //       //             decoration: BoxDecoration(
    //       //                 color: Colors.white,
    //       //                 borderRadius: BorderRadius.circular(10)),
    //       //             child: Padding(
    //       //               padding: const EdgeInsets.all(20.0),
    //       //               child: Column(
    //       //                 crossAxisAlignment: CrossAxisAlignment.start,
    //       //                 children: [
    //       //                   Row(
    //       //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       //                     children: [
    //       //                       SizedBox(
    //       //                         width: 40,
    //       //                         child: Text("$totalSells",
    //       //                             style: TextStyle(
    //       //                                 fontSize: 16,
    //       //                                 fontWeight: FontWeight.bold),
    //       //                             overflow: TextOverflow.ellipsis),
    //       //                       ),
    //       //                       Text(
    //       //                         '\u{20b9} $totalAmount',
    //       //                         style: TextStyle(
    //       //                             fontWeight: FontWeight.bold, fontSize: 16),
    //       //                       ),
    //       //                       Text("$totalSells",
    //       //                           style: TextStyle(
    //       //                               fontSize: 16,
    //       //                               fontWeight: FontWeight.bold)),
    //       //                     ],
    //       //                   ),
    //       //                   Padding(
    //       //                     padding: const EdgeInsets.only(top: 10.0),
    //       //                     child:
    //       //                         Text(orderDate, style: TextStyle(fontSize: 14)),
    //       //                   ),
    //       //                   Text("$orderId",
    //       //                       style: TextStyle(
    //       //                           fontSize: 16, fontWeight: FontWeight.bold),
    //       //                       overflow: TextOverflow.ellipsis),
    //       //
    //       //                   order['products'].length!=0?
    //       //                  ListView.builder(shrinkWrap: true,itemCount: order['products'].length,
    //       //                    physics: NeverScrollableScrollPhysics(),
    //       //                    itemBuilder: (context, index) {
    //       //                    return Text(order['products'][index]["product_name"] ?? "" );
    //       //                  },):
    //       //
    //       //                 Text("Product deleted by you"  , style: TextStyle(fontSize: 14,color: Colors.red)),
    //       //                   Text(orderstatus, style: TextStyle(fontSize: 14)),
    //       //                 ],
    //       //               ),
    //       //             ),
    //       //           ),
    //       //         ),
    //       //       ),
    //       //     );
    //       //   },
    //       // ),
    //       ListView.builder(
    //         shrinkWrap: true,
    //         itemCount: orderData2.length,
    //         physics: NeverScrollableScrollPhysics(),
    //         itemBuilder: (context, index) {
    //           final order = orderData2[index];
    //           final orderId = order['order_no'] ?? '';
    //           final totalAmount = order['total_ammount'] ?? '';
    //           final totalSells = order['total_sells'] ?? '';
    //           final orderDate = order['order_date'] ?? '';
    //           final orderstatus = order['order_status'] ?? '';
    //           //final productName = order['products'][0]['product_name'] ?? 'No Product';
    //
    //           return Padding(
    //             padding: const EdgeInsets.only(bottom: 15.0),
    //             child: GestureDetector(
    //               onTap: (){
    //                 Get.to(HistroyDetails(
    //                   orderId: orderData2[index]["orderId"],
    //                   userId: orderData2[index]["userId"],));
    //               },
    //               child: Material(
    //                 borderRadius: BorderRadius.circular(10),
    //                 elevation: 2,
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       borderRadius: BorderRadius.circular(10)),
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(20.0),
    //                     child:Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             SizedBox(
    //                               width: 40,
    //                               child: Text(
    //                                 "${order['total_sells']}", // Assuming 'total_sells' is the correct property
    //                                 style: TextStyle(
    //                                   fontSize: 16,
    //                                   fontWeight: FontWeight.bold,
    //                                 ),
    //                                 overflow: TextOverflow.ellipsis,
    //                               ),
    //                             ),
    //                             Text(
    //                               '\u{20b9} ${order['total_ammount']}', // Assuming 'total_ammount' is the correct property
    //                               style: TextStyle(
    //                                 fontWeight: FontWeight.bold,
    //                                 fontSize: 16,
    //                               ),
    //                             ),
    //                             Text(
    //                               "${order['settlements']}", // Assuming 'settlements' is the correct property
    //                               style: TextStyle(
    //                                 fontSize: 16,
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(top: 10.0),
    //                           child: Text(
    //                             order['order_date'],
    //                             style: TextStyle(fontSize: 14),
    //                           ),
    //                         ),
    //                         Text(
    //                           "${order['orderId']}",
    //                           style: TextStyle(
    //                             fontSize: 16,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                           overflow: TextOverflow.ellipsis,
    //                         ),
    //                         // order['products'].length != 0
    //                         //     ? ListView.builder(
    //                         //   shrinkWrap: true,
    //                         //   itemCount: order['products'].length,
    //                         //   physics: NeverScrollableScrollPhysics(),
    //                         //   itemBuilder: (context, index) {
    //                         //     return Text(order['products'][index]["product_name"] ?? "");
    //                         //   },
    //                         // )
    //                         //     : Text(
    //                         //   "Product deleted by you",
    //                         //   style: TextStyle(fontSize: 14, color: Colors.red),
    //                         // ),
    //                         // Text(
    //                         //   "${order['order_status']}", // Assuming 'order_status' is the correct property
    //                         //   style: TextStyle(fontSize: 14),
    //                         // ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    // );
    return Column(
      children: [
        if (isLoading)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: const Color(0xFF000000), // Green color
                rightDotColor: const Color(0xFF000000), // Black color
                size: 30,
              ),
            ),
          )
        else
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green, Colors.teal],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Week Orders Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildSummaryItem(
                          'No. of Orders',
                          weeklyShopOrderListModel?.data != null
                              ? "${weeklyShopOrderListModel?.data[0]['no_of_order']}"
                              : 'N/A',
                          Colors.white),
                      buildSummaryItem(
                          'Order Value',
                          weeklyShopOrderListModel?.data != null
                              ? '\u{20b9} ${weeklyShopOrderListModel?.data[0]['order_value']}'
                              : 'N/A',
                          Colors.white),
                      buildSummaryItem(
                          'Settlements',
                          weeklyShopOrderListModel?.data != null
                              ? "${weeklyShopOrderListModel?.data[0]['settlements']}"
                              : 'N/A',
                          Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 20),
        if (weeklyShopOrderListModel?.data == null)
          Center(
            child: Column(
              children: [
                Lottie.asset(
                  'assets/gif/homeempty.json',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const Text(
                  "No Orders",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            itemCount: weeklyShopOrderListModel?.data.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final order = weeklyShopOrderListModel?.data[index];
              final orderId = order['order_no'] ?? '';
              final totalAmount = order['total_ammount'] ?? '';
              final totalSells = order['total_sells'] ?? '';
              final orderDate = order['order_date'] ?? '';
              final orderstatus = order['order_status'] ?? '';
              //final productName = order['products'][0]['product_name'] ?? 'No Product';

              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(HistroyDetails(
                      orderId: weeklyShopOrderListModel?.data[index]["orderId"],
                      userId: weeklyShopOrderListModel?.data[index]["userId"],
                    ));
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Text(
                                    'Order Number:',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  '\u{20B9}${weeklyShopOrderListModel!.data[index]['order_no'].toString()}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                weeklyShopOrderListModel?.data[index]
                                    ['order_date'],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            weeklyShopOrderListModel
                                        ?.data[index]['products'].length !=
                                    0
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: weeklyShopOrderListModel
                                        ?.data[index]['products'].length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Text(weeklyShopOrderListModel
                                                  ?.data[index]['products']
                                              [index]["product_name"] ??
                                          "");
                                    },
                                  )
                                : const Text(
                                    "",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red),
                                  ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10.0, right: 5),
                                  child: Text(
                                    'Total Ammount :',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    '\u{20B9}${weeklyShopOrderListModel!.data[index]['total_ammount'].toString()}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

class thidmonth extends StatefulWidget {
  @override
  _thidmonthState createState() => _thidmonthState();
}

class _thidmonthState extends State<thidmonth> {
  List<Map<String, dynamic>> orderData3 = [];

  Widget buildSummaryItem(String title, String value, Color textColor) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  late String formattedMonth;
  String? retrievedId;
  bool isLoading = true;
  MonthlyShopOrderListModel? monthlyShopOrderListModel;
  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
    print("Retrieved ID: $retrievedId");
  }

  @override
  void initState() {
    super.initState();
    formattedMonth = getCurrentMonth();
    getIdFromSharedPreferences().then((_) {
      if (retrievedId != null) {
        print('Retrieved history shop ID: $retrievedId');
        monthHistory();
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  String getCurrentMonth() {
    var now = DateTime.now();
    var formatter = DateFormat('MMMM');
    return formatter.format(now);
  }

  Future<void> monthHistory() async {
    const url = ApiUrl.baseUrl + ApiUrl.monthlyShopOrderListUrl;
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> body = {
      // "shopId": "65698899a286659227113e6f",
      "shopId": retrievedId.toString(),
      "month": formattedMonth.toString()
    };

    print("$formattedMonth");
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print("+++++++++++++++++++++++month+++++++++++++++++++++++++++");
        final jsonResponse = jsonDecode(response.body);
        monthlyShopOrderListModel =
            MonthlyShopOrderListModel.fromJson(jsonResponse);
        print("teshin()))))))))))))))))))))))((((((((((((((((((((((((((sssss");
        print(monthlyShopOrderListModel?.data);
        if (jsonResponse['result'] == 'true' &&
            jsonResponse.containsKey('data')) {
          setState(() {
            orderData3 =
                List<Map<String, dynamic>>.from(jsonResponse['data'] ?? []);
          });
          setState(() {
            isLoading = false; // Stop showing loader on error
          });
        } else {
          print('API Response has unexpected format.');
        }

        print('API Response: ${response.body}');
      } else {
        print('API Error: ${response.statusCode}');
        print('API Response: ${response.body}');
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Stop showing loader on error
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    // return Center(
    //   child: Column(
    //     children: [
    //       Container(
    //         height: 60,
    //         width: double.infinity,
    //         decoration: BoxDecoration(color: Colors.black12),
    //         child: Padding(
    //           padding: const EdgeInsets.only(left: 10.0, right: 10),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text('No: of Orders'),
    //               Text('Order Value'),
    //               Text('Settlements'),
    //             ],
    //           ),
    //         ),
    //       ),
    //       SizedBox(height: 20),
    //       if (orderData3.isEmpty)
    //         // LoadingAnimationWidget.fourRotatingDots(
    //         //   color: Color.fromARGB(255, 12, 110, 42),
    //         //   size: 50,
    //         // ),
    //         Center(
    //           child: Column(
    //             children: [
    //               Lottie.asset(
    //                 'assets/gif/homeempty.json',
    //                 width: 150,
    //                 height: 150,
    //                 fit: BoxFit.cover,
    //               ),
    //               Text(
    //                 "No Orders",
    //                 style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ListView.builder(
    //         shrinkWrap: true,
    //         itemCount: orderData3.length,
    //         physics: NeverScrollableScrollPhysics(),
    //         itemBuilder: (context, index) {
    //           final order = orderData3[index];
    //           final orderId = order['order_no'] ?? '';
    //           final totalAmount = order['total_ammount'] ?? '';
    //           final totalSells = order['total_sells'] ?? '';
    //           final orderDate = order['order_date'] ?? '';
    //           final orderstatus = order['order_status'] ?? '';
    //           //final productName = order['products'][0]['product_name'] ?? 'No Product';
    //
    //           return Padding(
    //             padding: const EdgeInsets.only(bottom: 15.0),
    //             child: GestureDetector(
    //               onTap: (){
    //                 Get.to(HistroyDetails(
    //                   orderId: orderData3[index]["orderId"],
    //                   userId: orderData3[index]["userId"],));
    //               },
    //               child: Material(
    //                 borderRadius: BorderRadius.circular(10),
    //                 elevation: 2,
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       borderRadius: BorderRadius.circular(10)),
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(20.0),
    //                     child:Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             SizedBox(
    //                               width: 40,
    //                               child: Text(
    //                                 "${order['total_sells']}", // Assuming 'total_sells' is the correct property
    //                                 style: TextStyle(
    //                                   fontSize: 16,
    //                                   fontWeight: FontWeight.bold,
    //                                 ),
    //                                 overflow: TextOverflow.ellipsis,
    //                               ),
    //                             ),
    //                             Text(
    //                               '\u{20b9} ${order['total_ammount']}', // Assuming 'total_ammount' is the correct property
    //                               style: TextStyle(
    //                                 fontWeight: FontWeight.bold,
    //                                 fontSize: 16,
    //                               ),
    //                             ),
    //                             Text(
    //                               "${order['settlements']}", // Assuming 'settlements' is the correct property
    //                               style: TextStyle(
    //                                 fontSize: 16,
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(top: 10.0),
    //                           child: Text(
    //                             order['order_date'],
    //                             style: TextStyle(fontSize: 14),
    //                           ),
    //                         ),
    //                         Text(
    //                           "${order['orderId']}",
    //                           style: TextStyle(
    //                             fontSize: 16,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                           overflow: TextOverflow.ellipsis,
    //                         ),
    //                         // order['products'].length != 0
    //                         //     ? ListView.builder(
    //                         //   shrinkWrap: true,
    //                         //   itemCount: order['products'].length,
    //                         //   physics: NeverScrollableScrollPhysics(),
    //                         //   itemBuilder: (context, index) {
    //                         //     return Text(order['products'][index]["product_name"] ?? "");
    //                         //   },
    //                         // )
    //                         //     : Text(
    //                         //   "Product deleted by you",
    //                         //   style: TextStyle(fontSize: 14, color: Colors.red),
    //                         // ),
    //                         // Text(
    //                         //   "${order['order_status']}", // Assuming 'order_status' is the correct property
    //                         //   style: TextStyle(fontSize: 14),
    //                         // ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    // );
    return Column(
      children: [
        if (isLoading)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: const Color(0xFF000000), // Green color
                rightDotColor: const Color(0xFF000000), // Black color
                size: 30,
              ),
            ),
          )
        else
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green, Colors.teal],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Month Orders Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildSummaryItem(
                          'No. of Orders',
                          monthlyShopOrderListModel?.data != null
                              ? "${monthlyShopOrderListModel?.data[0]['no_of_order']}"
                              : 'N/A',
                          Colors.white),
                      buildSummaryItem(
                          'Order Value',
                          monthlyShopOrderListModel?.data != null
                              ? '\u{20b9} ${monthlyShopOrderListModel?.data[0]['order_value']}'
                              : 'N/A',
                          Colors.white),
                      buildSummaryItem(
                          'Settlements',
                          monthlyShopOrderListModel?.data != null
                              ? "${monthlyShopOrderListModel?.data[0]['settlements']}"
                              : 'N/A',
                          Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 20),
        if (orderData3.isEmpty)
          Center(
            child: Column(
              children: [
                Lottie.asset(
                  'assets/gif/homeempty.json',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const Text(
                  "No Orders ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            itemCount: monthlyShopOrderListModel?.data.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final order = monthlyShopOrderListModel?.data[index];
              final orderId = order['order_no'] ?? '';
              final totalAmount = order['total_ammount'] ?? '';
              final totalSells = order['total_sells'] ?? '';
              final orderDate = order['order_date'] ?? '';
              final orderstatus = order['order_status'] ?? '';
              //final productName = order['products'][0]['product_name'] ?? 'No Product';

              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(HistroyDetails(
                      orderId: monthlyShopOrderListModel?.data[index]
                          ["orderId"],
                      userId: monthlyShopOrderListModel?.data[index]["userId"],
                    ));
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Text(
                                    'Order Number:',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  '\u{20B9}${monthlyShopOrderListModel!.data[index]['order_no'].toString()}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                monthlyShopOrderListModel?.data[index]
                                    ['order_date'],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            monthlyShopOrderListModel
                                        ?.data[index]['products'].length !=
                                    0
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: monthlyShopOrderListModel
                                        ?.data[index]['products'].length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Text(monthlyShopOrderListModel
                                                  ?.data[index]['products']
                                              [index]["product_name"] ??
                                          "");
                                    },
                                  )
                                : const Text(
                                    "",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red),
                                  ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10.0, right: 5),
                                  child: Text(
                                    'Total Ammount :',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    '\u{20B9}${monthlyShopOrderListModel!.data[index]['total_ammount'].toString()}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

class Selectdate extends StatefulWidget {
  @override
  _SelectdateState createState() => _SelectdateState();
}

class _SelectdateState extends State<Selectdate> {
  List<Map<String, dynamic>> orderData4 = [];
  bool isLoading = false;
  String? retrievedId;
  DateShopOrderListModel? dateShopOrderListModel;
  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
    print("Retrieved ID: $retrievedId");
  }

  @override
  void initState() {
    super.initState();
    getIdFromSharedPreferences().then((_) {
      if (retrievedId != null) {
        print('Retrieved history shop ID: $retrievedId');
        String startDate = selectedDate1 ?? "";
        String endDate = selectedDate2 ?? "";
        selectHistory(startDate, endDate);
      } else {}
    });
  }

  final TextEditingController dateInput = TextEditingController();
  String? selectedDate1;
  String? selectedDate2;

  Future<String?> _selectINDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.highContrastLight(
                primary: colors.button_color),
            dialogBackgroundColor: Colors.white,
            textTheme:
                const TextTheme(bodyLarge: TextStyle(color: Colors.black)),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      return formattedDate;
    } else {
      return null;
    }
  }

  Future<void> selectHistory(String startDate, String endDate) async {
    print("datatimedsiplaydfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdf");
    print("$startDate");
    print("$endDate");
    print("$retrievedId");
    setState(() {
      isLoading = true;
    });

    const url = ApiUrl.baseUrl + ApiUrl.dateShopOrderListUrl;
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> body = {
      "shopId": retrievedId.toString(),
      "startDate": startDate,
      "endDate": startDate,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        dateShopOrderListModel = DateShopOrderListModel.fromJson(jsonResponse);
        print("controlingsgsgfsggggggggggggggggggggggggghhddggg");
        print(dateShopOrderListModel);
        if (jsonResponse['result'] == 'true' &&
            jsonResponse.containsKey('data')) {
          setState(() {
            orderData4 =
                List<Map<String, dynamic>>.from(jsonResponse['data'] ?? []);
            isLoading = false;
          });
        } else {
          print('API Response has unexpected format.');
        }

        print('API Response: ${response.body}');
      } else {
        print('API Error: ${response.statusCode}');
        print('API Response: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget buildSummaryItem(String title, String value, Color textColor) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Column(
    //     children: [
    //       Container(
    //         height: 60,
    //         width: double.infinity,
    //         decoration: BoxDecoration(color: Colors.black12),
    //         child: Padding(
    //           padding: const EdgeInsets.only(left: 10.0, right: 10),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text('No: of Orders'),
    //               Text('Order Value'),
    //               Text('Settlements'),
    //             ],
    //           ),
    //         ),
    //       ),
    //       SizedBox(height: 20),
    //       Padding(
    //         padding: const EdgeInsets.only(left: 10.0, right: 10),
    //         child: Row(
    //           children: [
    //             Expanded(
    //               child: GestureDetector(
    //                 onTap: () async {
    //                   String? selectedDate = await _selectINDate();
    //                   if (selectedDate != null) {
    //                     setState(() {
    //                       selectedDate1 = selectedDate;
    //                     });
    //                   }
    //                 },
    //                 child: Container(
    //                   height: 40,
    //                   decoration: BoxDecoration(
    //                       color: colors.button_color,
    //                       border: Border.all(color: Colors.black, width: 0.3),
    //                       borderRadius: BorderRadius.circular(10)),
    //                   child: Center(
    //                     child: Text(selectedDate1 ?? 'Start Date',
    //                         style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             color: Colors.white)),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             SizedBox(width: 10),
    //             Expanded(
    //               child: GestureDetector(
    //                 onTap: () async {
    //                   String? selectedDate = await _selectINDate();
    //                   if (selectedDate != null) {
    //                     setState(() {
    //                       selectedDate2 = selectedDate;
    //                     });
    //                   }
    //                 },
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                       color: colors.button_color,
    //                       border: Border.all(color: Colors.black, width: 0.3),
    //                       borderRadius: BorderRadius.circular(10)),
    //                   height: 40,
    //                   child: Center(
    //                     child: Text(selectedDate2 ?? 'End Date',
    //                         style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             color: Colors.white)),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             SizedBox(width: 20),
    //             GestureDetector(
    //               onTap: () async {
    //                 selectHistory(selectedDate1 ?? "", selectedDate2 ?? "");
    //               },
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   border: Border.all(color: Colors.black, width: 0.3),
    //                   borderRadius: BorderRadius.circular(10),
    //                 ),
    //                 height: 40,
    //                 width: 40,
    //                 child: Center(
    //                   child: Icon(Icons.search),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       SizedBox(height: 20),
    //       if (isLoading)
    //         Center(
    //           child: Column(
    //             children: [
    //               Lottie.asset(
    //                 'assets/gif/homeempty.json',
    //                 width: 150,
    //                 height: 150,
    //                 fit: BoxFit.cover,
    //               ),
    //               Text(
    //                 "No Orders",
    //                 style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         )
    //       else
    //         // ListView.builder(
    //         //   shrinkWrap: true,
    //         //   itemCount: orderData4.length,
    //         //   physics: NeverScrollableScrollPhysics(),
    //         //   itemBuilder: (context, index) {
    //         //     final order = orderData4[index];
    //         //     final orderId = order['order_no'] ?? '';
    //         //     final totalAmount = order['total_ammount'] ?? '';
    //         //     final totalSells = order['total_sells'] ?? '';
    //         //     final orderDate = order['order_date'] ?? '';
    //         //     final orderstatus = order['order_status'] ?? '';
    //         //   //  final productName = order['products'][0]['product_name'] ?? 'No Product';
    //         //
    //         //     return Padding(
    //         //       padding: const EdgeInsets.only(bottom: 15.0),
    //         //       child: GestureDetector(
    //         //         onTap: (){
    //         //           Get.to(HistroyDetails(
    //         //             orderId: orderData4[index]["orderId"],
    //         //             userId: orderData4[index]["userId"],));
    //         //         },
    //         //         child: Material(
    //         //           borderRadius: BorderRadius.circular(10),
    //         //           elevation: 2,
    //         //           child: Container(
    //         //             decoration: BoxDecoration(
    //         //                 color: Colors.white,
    //         //                 borderRadius: BorderRadius.circular(10)),
    //         //             child: Padding(
    //         //               padding: const EdgeInsets.all(20.0),
    //         //               child: Column(
    //         //                 crossAxisAlignment: CrossAxisAlignment.start,
    //         //                 children: [
    //         //                   Row(
    //         //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         //                     children: [
    //         //                       SizedBox(
    //         //                         width: 40,
    //         //                         child: Text(
    //         //                           "$totalSells",
    //         //                           style: TextStyle(
    //         //                               fontSize: 16,
    //         //                               fontWeight: FontWeight.bold),
    //         //                           overflow: TextOverflow.ellipsis,
    //         //                         ),
    //         //                       ),
    //         //                       Text(
    //         //                         '\u{20b9} $totalAmount',
    //         //                         style: TextStyle(
    //         //                             fontWeight: FontWeight.bold,
    //         //                             fontSize: 16),
    //         //                       ),
    //         //                       Text("$totalSells",
    //         //                           style: TextStyle(
    //         //                               fontSize: 16,
    //         //                               fontWeight: FontWeight.bold)),
    //         //                     ],
    //         //                   ),
    //         //                   Padding(
    //         //                     padding: const EdgeInsets.only(top: 10.0),
    //         //                     child: Text(orderDate,
    //         //                         style: TextStyle(fontSize: 14)),
    //         //                   ),
    //         //                   Text("$orderId",
    //         //                       style: TextStyle(
    //         //                           fontSize: 16, fontWeight: FontWeight.bold),
    //         //                       overflow: TextOverflow.ellipsis),
    //         //                   order['products'].length!=0?
    //         //                   ListView.builder(shrinkWrap: true,itemCount: order['products'].length,
    //         //                     physics: NeverScrollableScrollPhysics(),
    //         //                     itemBuilder: (context, index) {
    //         //                       return Text(order['products'][index]["product_name"] ?? "" );
    //         //                     },):
    //         //
    //         //                   Text("Product deleted by you"  , style: TextStyle(fontSize: 14,color: Colors.red)),
    //         //                   // Text(productName, style: TextStyle(fontSize: 14)),
    //         //                   Text(orderstatus, style: TextStyle(fontSize: 14)),
    //         //                 ],
    //         //               ),
    //         //             ),
    //         //           ),
    //         //         ),
    //         //       ),
    //         //     );
    //         //   },
    //         // ),
    //         ListView.builder(
    //           shrinkWrap: true,
    //           itemCount: orderData4.length,
    //           physics: NeverScrollableScrollPhysics(),
    //           itemBuilder: (context, index) {
    //             final order = orderData4[index];
    //             final orderId = order['order_no'] ?? '';
    //             final totalAmount = order['total_ammount'] ?? '';
    //             final totalSells = order['total_sells'] ?? '';
    //             final orderDate = order['order_date'] ?? '';
    //             final orderstatus = order['order_status'] ?? '';
    //             //final productName = order['products'][0]['product_name'] ?? 'No Product';
    //
    //             return Padding(
    //               padding: const EdgeInsets.only(bottom: 15.0),
    //               child: GestureDetector(
    //                 onTap: (){
    //                   Get.to(HistroyDetails(
    //                     orderId: orderData4[index]["orderId"],
    //                     userId: orderData4[index]["userId"],));
    //                 },
    //                 child: Material(
    //                   borderRadius: BorderRadius.circular(10),
    //                   elevation: 2,
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         borderRadius: BorderRadius.circular(10)),
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(20.0),
    //                       child:Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Row(
    //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               SizedBox(
    //                                 width: 40,
    //                                 child: Text(
    //                                   "${order['total_sells']}", // Assuming 'total_sells' is the correct property
    //                                   style: TextStyle(
    //                                     fontSize: 16,
    //                                     fontWeight: FontWeight.bold,
    //                                   ),
    //                                   overflow: TextOverflow.ellipsis,
    //                                 ),
    //                               ),
    //                               Text(
    //                                 '\u{20b9} ${order['total_ammount']}', // Assuming 'total_ammount' is the correct property
    //                                 style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 16,
    //                                 ),
    //                               ),
    //                               Text(
    //                                 "${order['settlements']}", // Assuming 'settlements' is the correct property
    //                                 style: TextStyle(
    //                                   fontSize: 16,
    //                                   fontWeight: FontWeight.bold,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           Padding(
    //                             padding: const EdgeInsets.only(top: 10.0),
    //                             child: Text(
    //                               order['order_date'],
    //                               style: TextStyle(fontSize: 14),
    //                             ),
    //                           ),
    //                           Text(
    //                             "${order['orderId']}",
    //                             style: TextStyle(
    //                               fontSize: 16,
    //                               fontWeight: FontWeight.bold,
    //                             ),
    //                             overflow: TextOverflow.ellipsis,
    //                           ),
    //                           // order['products'].length != 0
    //                           //     ? ListView.builder(
    //                           //   shrinkWrap: true,
    //                           //   itemCount: order['products'].length,
    //                           //   physics: NeverScrollableScrollPhysics(),
    //                           //   itemBuilder: (context, index) {
    //                           //     return Text(order['products'][index]["product_name"] ?? "");
    //                           //   },
    //                           // )
    //                           //     : Text(
    //                           //   "Product deleted by you",
    //                           //   style: TextStyle(fontSize: 14, color: Colors.red),
    //                           // ),
    //                           // Text(
    //                           //   "${order['order_status']}", // Assuming 'order_status' is the correct property
    //                           //   style: TextStyle(fontSize: 14),
    //                           // ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //     ],
    //   ),
    // );
    return Column(
      children: [
        if (dateShopOrderListModel?.data != null)
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green, Colors.teal],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Select dates Orders Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildSummaryItem(
                          'No. of Orders',
                          dateShopOrderListModel?.data != null
                              ? "${dateShopOrderListModel?.data[0]['no_of_order']}"
                              : 'N/A',
                          Colors.white),
                      buildSummaryItem(
                          'Order Value',
                          dateShopOrderListModel?.data != null
                              ? '\u{20b9} ${dateShopOrderListModel?.data[0]['order_value']}'
                              : 'N/A',
                          Colors.white),
                      buildSummaryItem(
                          'Settlements',
                          dateShopOrderListModel?.data != null
                              ? "${dateShopOrderListModel?.data[0]['settlements']}"
                              : 'N/A',
                          Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5, top: 10),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    String? selectedDate = await _selectINDate();
                    if (selectedDate != null) {
                      setState(() {
                        selectedDate1 = selectedDate;
                      });
                    }
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.green, Colors.teal],
                        ),
                        //color: colors.button_color,
                        border: Border.all(color: Colors.black, width: 0.3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(selectedDate1 ?? 'Start Date',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    String? selectedDate = await _selectINDate();
                    if (selectedDate != null) {
                      setState(() {
                        selectedDate2 = selectedDate;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        // color: colors.button_color,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.green, Colors.teal],
                        ),
                        border: Border.all(color: Colors.black, width: 0.3),
                        borderRadius: BorderRadius.circular(10)),
                    height: 40,
                    child: Center(
                      child: Text(selectedDate2 ?? 'End Date',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () async {
                  selectHistory(selectedDate1 ?? "", selectedDate2 ?? "")
                      .then((value) => () {
                            print(
                                "success or fffffffffffffffffffffffffffffffffffnot ");
                          });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 40,
                  width: 40,
                  child: const Center(
                    child: Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (dateShopOrderListModel?.data == null)
          Center(
            child: Column(
              children: [
                Lottie.asset(
                  'assets/gif/homeempty.json',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const Text(
                  "No Orders",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            itemCount: dateShopOrderListModel?.data.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final order = dateShopOrderListModel?.data[index];
              // final orderId = order['order_no'] ?? '';
              // final totalAmount = order['tot al_ammount'] ?? '';
              // final totalSells = order['total_sells'] ?? '';
              // final orderDate = order['order_date'] ?? '';
              // final orderstatus = order['order_status'] ?? '';
              //final productName = order['products'][0]['product_name'] ?? 'No Product';

              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(HistroyDetails(
                      orderId: dateShopOrderListModel?.data[index]["orderId"],
                      userId: dateShopOrderListModel?.data[index]["userId"],
                    ));
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Text(
                                    'Order Number:',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  '\u{20B9}${dateShopOrderListModel!.data[index]['order_no'].toString()}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                dateShopOrderListModel?.data[index]
                                    ['order_date'],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            dateShopOrderListModel
                                        ?.data[index]['products'].length !=
                                    0
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: dateShopOrderListModel
                                        ?.data[index]['products'].length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Text(dateShopOrderListModel
                                                  ?.data[index]['products']
                                              [index]["product_name"] ??
                                          "");
                                    },
                                  )
                                : const Text(
                                    "",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red),
                                  ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10.0, right: 5),
                                  child: Text(
                                    'Total Ammount :',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    '\u{20B9}${dateShopOrderListModel!.data[index]['total_ammount'].toString()}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
