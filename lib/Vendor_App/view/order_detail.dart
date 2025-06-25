import 'dart:convert';

import 'package:hire_any_thing/Vendor_App/view/Navagation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cutom_widgets/signup_textfilled.dart';
import '../uiltis/color.dart';

class Details extends StatefulWidget {
  final String orderId;
  final String userId;

  Details({required this.orderId, required this.userId});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String? retrievedId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // getIdFromSharedPreferences().then((_) {
    //   if (retrievedId != null) {
    //     print('Retrieved profile shop ID: $retrievedId');
    //     orderDetails();
    //     flatdel();
    //     CardCalulation();
    //   } else {}
    // });
  }

  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
    print("Retrieved ID order details order details : $retrievedId");
    CardCalulation();
  }

  // List<StepData> steps = [
  //   StepData(
  //     title: 'Order Placed',
  //     date: 'jan 23,2023',
  //   ),
  //   StepData(
  //     title: 'Order Accepted',
  //     date: 'jan 23,2023',
  //   ),
  //   StepData(
  //     title: 'Order assigned',
  //     date: 'jan 23,2023',
  //   ),
  //   StepData(
  //     title: 'Order Out Of Delivery',
  //     date: 'jan 23,2023',
  //   ),
  //   StepData(
  //     title: 'Order Delivered',
  //     date: 'jan 23 ,2023',
  //   ),
  // ];

  List<StepData> steps = [
    StepData(
      title: 'Order Placed',
      date: 'Jan 23, 2023',
    ),
    StepData(
      title: 'Order Accepted',
      date: 'Jan 23, 2023',
    ),
    StepData(
      title: 'Order Delivered',
      date: 'Jan 23, 2023',
    ),
  ];

  List time = ["10:35 PM", "10:40 PM", "10:45 PM", "10:45 PM", "11:15 PM"];

  String? price;
  String? quantity;
  String? variantsss;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: colors.scaffold_background_color,
      appBar: AppBar(
        backgroundColor: colors.button_color,
        foregroundColor: colors.white,
        title: const Text(
          "Order Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                // isLoading
                // ? Center(
                // child: LoadingAnimationWidget.fourRotatingDots(
                //   color: const Color.fromARGB(255, 12, 110, 42),
                //   size: 50,
                // ))
                // :
                Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 20),
                  child: Material(
                    elevation: 1,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20.0, top: 20, right: 10, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order Number : 13212",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Date : 12-08-2024",
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    "${modeee ?? ""}",
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    // width:280,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Text(
                                            "Payment Mode",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          'Cash',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Text(
                                  //   "Number - $mobileNumber",
                                  //   overflow: TextOverflow.ellipsis,
                                  // ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _makePhoneCall('$mobileNumber');
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 0.5),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Icon(Icons.phone,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 10.0),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Row(
                            //         children: [
                            //           Icon(Icons.location_on,
                            //               size: 18, color: Colors.green),
                            //           SizedBox(
                            //             width: 5,
                            //           ),
                            //           SizedBox(
                            //             width:
                            //                 150.0, // Set the desired height
                            //             child: Text(
                            //               "$addressss",
                            //               overflow: TextOverflow.ellipsis,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                /*         Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: steps.length,
                    itemBuilder: (context, index) {
                      int selectedIndex = 1;
                      if (orderstatuss.toString() == "In Progress") {
                        selectedIndex = 1;
                      } else if (orderstatuss.toString() == "Packed") {
                        selectedIndex = 2;
                      } else if (orderstatuss.toString() == "Ready") {
                        selectedIndex = 3;
                      } else if (orderstatuss.toString() == "Completed") {
                        selectedIndex = 4;
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: w / 8,
                            height: h / 13,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Container(
                                  width: w / 25,
                                  height: h / 30,
                                  decoration: BoxDecoration(
                                    color: index <= selectedIndex
                                        ? colors.button_color
                                        : Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                  child: index <= selectedIndex
                                      ? const Center(
                                          child: Text(
                                          "✓",
                                          style: TextStyle(color: Colors.white),
                                        ))
                                      : null,
                                ),
                                if (index < steps.length - 1)
                                  Expanded(
                                    child: Container(
                                      width: 2,
                                      color: index <= selectedIndex
                                          ? colors.button_color
                                          : Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    steps[index].title ?? "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: w / 25,
                                    ),
                                  ),
                                  SizedBox(height: h / 90),
                                  index == 1
                                      ? Text(
                                          "${orderr_acc ?? ""}",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: w / 30,
                                          ),
                                        )
                                      : index == 2
                                          ? Text(
                                              "${orderr_acc ?? ""}",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: w / 30,
                                              ),
                                            )
                                          : index == 3
                                              ? Text("${orderr_out ?? ""}",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: w / 30,
                                                  ))
                                              : index == 4
                                                  ? Text(
                                                      "${orderr_dil ?? ""}",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: w / 30,
                                                      ),
                                                    )
                                                  : index == 0
                                                      ? Text(
                                                          "${orderr_pla ?? ""}",
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: w / 30,
                                                          ),
                                                        )
                                                      : const Text(""),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              selectedIndex == 1
                                  ? index == 1
                                      ? InkWell(
                                          onTap: () {
                                            latlong_driver();
                                            printAddressLatLng("addressss");

                                            // Navigator.pushReplacement(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           LiveTrackingMap(
                                            //             destination: addressss
                                            //                 .toString(),
                                            //             orderId: widget
                                            //                 .orderId
                                            //                 .toString(),
                                            //           ),
                                            //     ));
                                          },
                                          child: Container(
                                            height: h / 20,
                                            width: w / 2.9,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0)),
                                            child: const Center(
                                                child: Text(
                                              "Track Your Order",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                          ),
                                        )
                                      : const Text("")
                                  : const Text(""),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),  */
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    int selectedIndex = 1;
                    if (orderstatuss.toString() == "In Progress") {
                      selectedIndex = 1;
                    } else if (orderstatuss.toString() == "Packed") {
                      selectedIndex = 2;
                    } else if (orderstatuss.toString() == "Completed") {
                      selectedIndex = 3;
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Step circle logic (remains the same)
                        Container(
                          width: w / 8,
                          height: h / 13,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                width: w / 25,
                                height: h / 30,
                                decoration: BoxDecoration(
                                  color: index <= selectedIndex
                                      ? colors.button_color
                                      : Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                child: index <= selectedIndex
                                    ? const Center(
                                        child: Text(
                                        "✓",
                                        style: TextStyle(color: Colors.white),
                                      ))
                                    : null,
                              ),
                              if (index < steps.length - 1)
                                Expanded(
                                  child: Container(
                                    width: 2,
                                    color: index <= selectedIndex
                                        ? colors.button_color
                                        : Colors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // Step details (adjust as necessary)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              steps[index].title ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: w / 25,
                              ),
                            ),
                            SizedBox(height: h / 90),
                            index == 1
                                ? Text(
                                    "${orderr_acc ?? ""}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: w / 30,
                                    ),
                                  )
                                : index == 2
                                    ? Text(
                                        "${orderr_dil ?? ""}",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: w / 30,
                                        ),
                                      )
                                    : const Text(""),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Expanded(
                            child: Text("Delivery Address : XYZ 1234567",
                                style: const TextStyle(fontSize: 15)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Padding(
  //     padding: const EdgeInsets.only(bottom: 20.0),
  //     child:
  //         // StreamBuilder(
  //         //   stream: Stream.periodic(const Duration(seconds: 0))
  //         //       .asyncMap((i) => orderDetails()),
  //         //   builder: (context, snapshot) {
  //         //     return
  //         Material(
  //       elevation: 1,
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(10),
  //       child: Container(
  //         width: w,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.only(top: 15, bottom: 10),
  //           child: ListView.builder(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             itemCount: 4,
  //             itemBuilder: (context, index) {
  //               // String productImage = 'http://103.104.74.215:3092/uploads/' + products[index]['product_image'];
  //               // String productName = products[index]['product_name'];
  //
  //               // quantity = "" +" "+ products[index]["qty"].toString();
  //               quantity = "" + " " "1";
  //               price = '\u{20B9} 149.75';
  //               variantsss = 'variants';
  //
  //               return Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment:
  //                     MainAxisAlignment.spaceAround,
  //                 children: [
  //                   Column(
  //                     children: [
  //                       Container(
  //                         height: h / 9,
  //                         width: w / 6,
  //                         decoration: BoxDecoration(
  //                           borderRadius:
  //                               BorderRadius.circular(10),
  //                         ),
  //                         child: ClipRRect(
  //                           borderRadius:
  //                               BorderRadius.circular(10),
  //                           child:
  //                               // Text("productImage")
  //                               Image.asset(
  //                             "assets/app_logo/salon_at_home.jpg",
  //                             fit: BoxFit.fill,
  //                             scale: 10,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   Row(
  //                     mainAxisAlignment:
  //                         MainAxisAlignment.spaceAround,
  //                     children: [
  //                       Container(
  //                         height: h / 7,
  //                         width: w / 6,
  //                         child: Center(
  //                           child: Text(
  //                             "Facial",
  //                             overflow: TextOverflow.ellipsis,
  //                             style: const TextStyle(
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         height: h / 7,
  //                         width: w / 6,
  //                         child: Center(
  //                           child: Text(
  //                             quantity!,
  //                             style: const TextStyle(
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         height: h / 7,
  //                         width: w / 8,
  //                         child: Center(
  //                           child: Text(
  //                             variantsss!,
  //                             style: const TextStyle(
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         height: h / 7,
  //                         width: w / 6,
  //                         child: Center(
  //                           child: Text(
  //                             price!,
  //                             style: const TextStyle(
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                       ),
  //                       driverAssignStatus == '0' &&
  //                               orderstatuss == 'Pending'
  //                           ? PopupMenuButton<String>(
  //                               onSelected: (value) async {
  //                                 if (value == 'delete' &&
  //                                     products.isNotEmpty) {
  //                                   var product = products[index];
  //                                   productIdToDelete =
  //                                       product['productId']
  //                                           .toString();
  //                                   priceToDelete =
  //                                       product['price']
  //                                           .toString();
  //
  //                                   String productIdString =
  //                                       productIdToDelete
  //                                           .toString();
  //                                   String priceString =
  //                                       priceToDelete.toString();
  //
  //                                   print(
  //                                       "Tapped Product ID: $productIdString");
  //
  //                                   if (products.length == 1 &&
  //                                       product["qty"] == 1) {
  //                                     //if (products.length == 1 &&   products[index]["qty"] == "1" ) {
  //                                     bool shouldDelete =
  //                                         await _showDeleteConfirmationPopup(
  //                                             context);
  //                                     if (shouldDelete) {
  //                                       _showDeleteConfirmationPopup(
  //                                           context);
  //                                       //await deleteCard();
  //                                       print(
  //                                           "Tapped Product Price: $priceString");
  //                                     }
  //                                   } else {
  //                                     _showPopupdelete(context);
  //                                     //await deleteCard();
  //                                     print(
  //                                         "Tapped Product Price: $priceString");
  //                                   }
  //                                 } else if (value == 'edit') {
  //                                   var product = products[index];
  //                                   productIdToupdtee =
  //                                       product['productId']
  //                                           .toString();
  //                                   print(
  //                                       "Tapped productIdToupdtee ID: $productIdToupdtee");
  //                                   print(
  //                                       "Tapped Product ID: $quantity");
  //                                   print(
  //                                       "Product Quantity: ${product["qty"]}");
  //
  //                                   selectedProductQuantity =
  //                                       product["qty"].toString();
  //                                   print(
  //                                       "Product Quantity: $selectedProductQuantity");
  //                                   if (products.length >= 1) {
  //                                     _showPopup(context);
  //                                   }
  //                                 }
  //                               },
  //                               itemBuilder:
  //                                   (BuildContext context) =>
  //                                       <PopupMenuEntry<String>>[
  //                                 const PopupMenuItem<String>(
  //                                   value: 'delete',
  //                                   child: Text('Delete'),
  //                                 ),
  //                                 const PopupMenuItem<String>(
  //                                   value: 'edit',
  //                                   child: Text('Edit'),
  //                                 ),
  //                               ],
  //                             )
  //                           : const SizedBox.shrink(),
  //                     ],
  //                   ),
  //                 ],
  //               );
  //             },
  //           ),
  //         ),
  //       ),
  //     )
  //     //   },
  //     // ),
  //     ),
  // Center(
  //   child: StreamBuilder(
  //     stream: Stream.periodic(const Duration(seconds: 0))
  //         .asyncMap((i) => CardCalulation()),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return buildCard(snapshot.data);
  //       } else if (snapshot.hasError) {
  //         return Text('Error: ${snapshot.error}');
  //       } else {
  //         return buildCard(snapshot.data);
  //       }
  //     },
  //   ),
  // ),
  // Visibility(
  //   visible: orderstatuss == "Pending",
  //   child: Padding(
  //     padding: const EdgeInsets.only(bottom: 20.0, top: 20),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Container(
  //           width: w / 3,
  //           height: h / 20,
  //           child: ElevatedButton(
  //             onPressed: () async {
  //               await orderstatusd('Reject', ordernum.toString());
  //               Navigator.pushReplacement(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => const Nav_bar(),
  //                   ));
  //             },
  //             style: ButtonStyle(
  //               shape: MaterialStateProperty.all(
  //                 RoundedRectangleBorder(
  //                   side: const BorderSide(color: Colors.red),
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //               ),
  //               backgroundColor:
  //                   MaterialStateProperty.all(Colors.white),
  //             ),
  //             child: const Text(
  //               "Reject",
  //               style: TextStyle(color: Colors.red, fontSize: 17),
  //             ),
  //           ),
  //         ),
  //         Container(
  //           width: w / 3,
  //           height: h / 20,
  //           child: ElevatedButton(
  //             onPressed: () async {
  //               await orderstatusd('Accept', ordernum.toString());
  //               Navigator.pushReplacement(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => const Nav_bar(),
  //                   ));
  //             },
  //             style: ButtonStyle(
  //               shape: MaterialStateProperty.all(
  //                 RoundedRectangleBorder(
  //                   side: const BorderSide(color: Colors.green),
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //               ),
  //               backgroundColor:
  //                   MaterialStateProperty.all(Colors.white),
  //             ),
  //             child: const Text(
  //               "Accept",
  //               style:
  //                   TextStyle(color: Colors.green, fontSize: 17),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // ),

  bool buttonsVisible = false;
  int? grandTotal;
  var mobileNumber;
  var pramentMode;
  int? deliveryCharge;

  String? addressss;
  String? ordernum;
  String? carddnum;
  String? dateee;
  String? modeee;
  String? productIdToDelete;
  String? productIdToupdtee;
  String? priceToDelete;
  String? driverName;
  String? userName;
  String? driverAssignStatus;
  String? orderstatuss;
  String? venderstatus;
  int? ordernumberneww;
  // int? phonenumberrrr;

  String? orderr_pla;
  String? orderr_acc;
  String? orderr_pac;
  String? orderr_out;
  String? orderr_dil;

  List<Map<String, dynamic>> products = [];

  Future<void> orderDetails() async {
    const String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/track_my_order';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> data = {
      'orderId': widget.orderId,
    };
    print(data);
    print("+++++++++++");
    final String requestBody = json.encode(data);
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: requestBody);

      if (response.statusCode == 200) {
        //print("Response: ${response.body}");
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        print("+++++++++++--------");
        Map<String, dynamic> orderData = jsonResponse['data'][0];
        print(orderData);
        print("+++++++++++--------3333");
        grandTotal = orderData['grand_total'];
        deliveryCharge = orderData['delivery_charge'];
        addressss = orderData['address'];

        dateee = orderData['order_date'];
        ordernum = orderData['orderId'];
        ordernumberneww = orderData['order_no'];
        modeee = orderData['payment_mode'];
        carddnum = orderData['cartId'];

        driverName = orderData['driver_name'];
        //  mobileNumber = orderData["userId"]['phone'];

        driverAssignStatus = orderData['driver_assign_status'];
        orderstatuss = orderData['order_status'];
        venderstatus = orderData['vender_status'];

        orderr_pla = orderData['order_date'];
        orderr_acc = orderData['in_progress_date'];
        orderr_pac = orderData['asign_date'];
        orderr_out = orderData['delivery_date'];
        orderr_dil = orderData['completed_date'];

        // userName = orderData['userId']['user_name'];
        print("Customer Name: $userName");

        List<dynamic> productsData = jsonResponse['data'][0]['products'];
        products = List<Map<String, dynamic>>.from(productsData);
        for (var product in products) {
          String productId = product['productId'];
          String price = 'GHS ${product['price']}';
        }

        for (var product in products) {
          String productImage =
              'http://103.104.74.215:3092/uploads/' + product['product_image'];
          String productName = product['description'];
          String variant = "Basmati";
          String quantity = "1 Kg";
          String price = 'GHS ${product['price']}';
        }

        setState(() {
          isLoading = false;
        });
      } else {
        print("API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> orderstatusd(String action, String ordernum) async {
    if (ordernum == null) {
      print("Error: orderId is null");
      return;
    }
    print("****$widget.userId");

    final String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/update_order_status';
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    final Map<String, String> data = {
      'orderId': ordernum.toString(),
      'userId': widget.userId.toString(),
      'order_status': (action == 'Accept') ? 'In Progress' : 'Cancel',
      'vender_status': (action == 'Accept') ? 'accept' : 'reject',
    };

    final String requestBody = json.encode(data);
    //print('Request Body: $requestBody');

    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: requestBody);
      print('Response Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('Decoded Response: $jsonResponse');
        //await orderDetails();
      } else {
        print("API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error in orderstatus: $e");
    }
  }

  Future<void> deleteCard() async {
    final String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/delete_cart';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> data = {
      'cartId': carddnum.toString(),
      'orderId': ordernum.toString(),
      'productId': productIdToDelete.toString(),
      'price': priceToDelete.toString(),
    };

    final String requestBody = json.encode(data);
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: requestBody);

      if (response.statusCode == 200) {
        print("Delete Response: ${response.body}");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Product Delete successfully'),
        //     duration: Duration(seconds: 2), // Adjust the duration as needed
        //     backgroundColor: Colors.red,
        //   ),
        // );
        final jsonResponse = json.decode(response.body);
      } else {
        print(
            "Delete API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Delete Error: $e");
    }
  }

  TextEditingController priceee = TextEditingController();
  TextEditingController qunanity = TextEditingController();

  Future<void> updateCard() async {
    final String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/update_cart';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> data = {
      'cartId': carddnum.toString(),
      'orderId': ordernum.toString(),
      'productId': productIdToupdtee.toString(),
      //'price': priceee.text.toString(),
      'qty': qunanity.text.toString(),
    };

    print('Upload Data: $data');
    final String requestBody = json.encode(data);
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: requestBody);

      if (response.statusCode == 200) {
        print("Delete Response: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product Update successfully'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
        final jsonResponse = json.decode(response.body);
      } else {
        print(
            "update API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("update Error: $e");
    }
  }

  String selectedProductQuantity = '';

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10),
              child: Text(" Please specify the quantity you want to reduce ..",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10),
                child: Text("Quantity",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Signup_textfilled(
                textfilled_height: 17,
                textfilled_weight: 1,
                textcont: qunanity,
                length: 50,
                keytype: TextInputType.name,
                hinttext: "$selectedProductQuantity",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () async {
                      int parsedQuantity = int.parse(qunanity.text.toString());

                      if (parsedQuantity > 0 &&
                          parsedQuantity < int.parse(selectedProductQuantity)) {
                        await updateCard();
                        Navigator.of(context).pop();
                      } else {
                        _orderdaitailssss(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.black, width: 0.3),
                      ),
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  double driverLatitude = 0.0;
  double driverLongitude = 0.0;
  double dropeeLatitude = 0.0;
  double dropeeLongitude = 0.0;

  void _showPopupdelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text(
              '"Do you really want to remove this item from the order?"'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await deleteCard();
                Navigator.of(context).pop();
              },
              child: const Text('Delete',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  Future<void> latlong_driver() async {
    final String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/get_driver_latlog';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> data = {
      'shopId': retrievedId.toString(),
      'orderId': ordernum.toString(),
    };

    print('Upload Data: $data');
    final String requestBody = json.encode(data);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        final location = jsonResponse['data']['location']['coordinates'];
        driverLatitude = location[0];
        driverLatitude = location[1];

        print('Latitude of driver : $driverLatitude');
        print('Longitude: of driver  $driverLatitude');
      } else {
        print(
            "Update API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Update Error: $e");
    }
  }

  Future<void> printAddressLatLng(String addressss) async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        print('Location permissions are denied');
        return;
      }

      // List<Location> locations = await locationFromAddress(addressss);
      // Get current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double dropeeLatitude = position.latitude;
      double dropeeLongitude = position.longitude;

      // List<Location> locations =position;
      if (position.latitude != null) {
        dropeeLatitude = position.latitude;
        dropeeLongitude = position.longitude;
        // openMap(position.latitude,position.longitude);
        print('Longitude of drop location $addressss');
        print('Longitude of  drop location $dropeeLatitude');
        print('Longitude of  drop location $dropeeLongitude');
      } else {
        print('No coordinates found for $addressss');
      }
    } catch (e) {
      print('Error getting coordinates: $e');
    }
  }

  // Future<void> openMap(double latitude, double longitude) async {
  //   final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  //
  //   if (await canLaunch(googleMapsUrl)) {
  //     await launch(googleMapsUrl);
  //   } else {
  //     throw 'Could not open the map.';
  //   }
  // }
  Future<bool> _showDeleteConfirmationPopup(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Reject'),
              content: const Text(
                  ' "Do you really want to remove all items from this order and reject this order?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.green, fontSize: 16)),
                ),
                TextButton(
                  onPressed: () async {
                    await orderstatusd('Reject', ordernum.toString());
                    Navigator.of(context).pop(false);
                    Get.off(const Nav_bar());
                  },
                  child: const Text('Reject',
                      style: TextStyle(color: Colors.green, fontSize: 16)),
                ),
              ],
            );
          },
        ) ??
        false; // Handle the case where showDialog returns null
  }

  _makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  int? flatDeliveryCharge;
  int? deliveryChargeeeee;

  Future<void> flatdel() async {
    if (retrievedId == null) {
      print('Retrieved ID is null');
      return;
    }

    final url = Uri.parse(
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/getVenderProfile');
    print("inside api $retrievedId");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'shopId': retrievedId!,
      }),
    );

    if (response.statusCode == 200) {
      print('POST request successful');
      print('Response data: ${response.body}');

      final parsedResponse = jsonDecode(response.body);

      if (parsedResponse['data'] != null) {
        flatDeliveryCharge = parsedResponse['data']['flat_delivery_charge'];
        deliveryChargeeeee = parsedResponse['data']['delivery_charge'];

        print('Flat Delivery Charge: $flatDeliveryCharge');
        print('Delivery Charge: $deliveryCharge');
      } else {
        print('Response does not contain "data" property.');
      }
    } else {
      print('POST request failed with status: ${response.statusCode}');
      print('Response data: ${response.body}');
    }
  }

  Widget buildCard(Map<String, dynamic>? data) {
    // if (data == null) {
    //   return const Text('Data not available');
    // }

    return Card(
      // margin: EdgeInsets.only(right: 20.0,left: 20),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Price:'),
                Text(
                  '\u{20B9} 599',
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery Fee:'),
                Text('\u{20B9} 51'),
              ],
            ),
          ),
          // ListTile(
          //   title: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text('Service Charge: '),
          //       Text(' ${data['service_charge']}'),
          //     ],
          //   ),
          // ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Grand Total:'),
                Text('\u{20B9} 650'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> CardCalulation() async {
    final String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/cart_calculation';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> requestData = {
      "userId": widget.userId.toString(),
      "cartId": carddnum.toString()
    };

    final String requestBody = json.encode(requestData);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        print("API request failed with status code: ${response.statusCode}");
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load data');
    }
  }

  void _orderdaitailssss(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
              'You cannot reduce the quantity to 0 or lesser. Kindly delete the item from the order, in case you want to remove the item...',
              style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 18)),
            ),
          ],
        );
      },
    );
  }
}

class StepData {
  final String title;
  final String? subtitle;
  final String date;

  final String? assetImage;

  StepData({
    required this.title,
    this.subtitle,
    required this.date,
    this.assetImage,
  });
}
