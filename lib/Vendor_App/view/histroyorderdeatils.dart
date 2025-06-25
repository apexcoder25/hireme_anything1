import 'dart:convert';

import 'package:hire_any_thing/Vendor_App/view/Navagation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cutom_widgets/signup_textfilled.dart';
import '../uiltis/color.dart';

class HistroyDetails extends StatefulWidget {
  final String orderId;
  final String userId;

  HistroyDetails({required this.orderId, required this.userId});

  @override
  State<HistroyDetails> createState() => _HistroyDetailsState();
}

class _HistroyDetailsState extends State<HistroyDetails> {
  String? retrievedId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getIdFromSharedPreferences().then((_) {
      if (retrievedId != null) {
        print('Retrieved profile shop ID: $retrievedId');
        orderDetails();
        flatdel();
        CardCalulation();
      } else {}
    });
  }

  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
    print("Retrieved ID order details order details : $retrievedId");
  }

  List<StepData> steps = [
    StepData(
      title: 'Order Placed',
      date: 'jan 23,2023',
    ),
    StepData(
      title: 'Order Accepted',
      date: 'jan 23,2023',
    ),
    StepData(
      title: 'Order Packed',
      date: 'jan 23,2023',
    ),
    StepData(
      title: 'Order Out Of Delivery',
      date: 'jan 23,2023',
    ),
    StepData(
      title: 'Order Delivered',
      date: 'jan 23 ,2023',
    ),
  ];
  List time = ["10:35 PM", "10:40 PM", "10:45 PM", "10:45 PM", "11:15 PM"];

  String? price;
  String? quantity;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: colors.scaffold_background_color,
      appBar: AppBar(
        backgroundColor: colors.button_color,
        title: Text(
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
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: isLoading
                ? Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                    color: Color.fromARGB(255, 12, 110, 42),
                    size: 50,
                  ))
                : Column(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Order Number : $ordernumberneww",
                                        style: TextStyle(
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
                                          "Date : $dateee",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          "$modeee",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 160,
                                          child: Text(
                                            "User Name - $userName",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        // Text(
                                        //   "Number - $mobileNumber",
                                        //   overflow: TextOverflow.ellipsis,
                                        // ),
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
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Icon(Icons.phone,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.location_on,
                                                size: 18, color: Colors.green),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            SizedBox(
                                              width:
                                                  150.0, // Set the desired height
                                              child: Text(
                                                "$addressss",
                                                overflow: TextOverflow.ellipsis,
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
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: steps.length,
                          itemBuilder: (context, index) {
                            int selectedIndex = 0;
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
                                            ? Center(
                                                child: Text(
                                                "✓",
                                                style: TextStyle(
                                                    color: Colors.white),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          steps[index].title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: w / 25,
                                          ),
                                        ),
                                        SizedBox(height: h / 90),
                                        index == 1
                                            ? Text(
                                                "$orderr_acc",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: w / 30,
                                                ),
                                              )
                                            : index == 2
                                                ? Text(
                                                    "$orderr_acc",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: w / 30,
                                                    ),
                                                  )
                                                : index == 3
                                                    ? Text("$orderr_out",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: w / 30,
                                                        ))
                                                    : index == 4
                                                        ? Text(
                                                            "$orderr_dil",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: w / 30,
                                                            ),
                                                          )
                                                        : index == 0
                                                            ? Text(
                                                                "$orderr_pla",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      w / 30,
                                                                ),
                                                              )
                                                            : Text(""),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    selectedIndex == 3
                                        ? index == 3
                                            ? InkWell(
                                                onTap: () {
                                                  latlong_driver();
                                                  printAddressLatLng(
                                                      addressss!);

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
                                                          BorderRadius.circular(
                                                              10.0),
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 1.0)),
                                                  child: Center(
                                                      child: Text(
                                                    "Track Your Order",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                                ),
                                              )
                                            : Text("")
                                        : Text(""),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Expanded(
                                  child: Text("Delivery Address :$addressss",
                                      style: TextStyle(fontSize: 15)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: StreamBuilder(
                          stream: Stream.periodic(Duration(seconds: 0))
                              .asyncMap((i) => orderDetails()),
                          builder: (context, snapshot) {
                            return Material(
                              elevation: 1,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: products.length,
                                    itemBuilder: (context, index) {
                                      String productImage =
                                          'http://103.104.74.215:3026/uploads/' +
                                              products[index]['product_image'];
                                      String productName =
                                          products[index]['product_name'];
                                      String variant = "Basmati";
                                      quantity = "" +
                                          products[index]["qty"].toString();
                                      price =
                                          '\u{20B9} ${products[index]['price']}';

                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height: h / 9,
                                                width: w / 6,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    productImage,
                                                    fit: BoxFit.fill,
                                                    scale: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                height: h / 7,
                                                width: w / 6,
                                                child: Center(
                                                  child: Text(
                                                    productName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: h / 7,
                                                width: w / 6,
                                                child: Center(
                                                  child: Text(
                                                    quantity!,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: h / 7,
                                                width: w / 6,
                                                child: Center(
                                                  child: Text(
                                                    price!,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Center(
                        child: StreamBuilder(
                          stream: Stream.periodic(Duration(seconds: 0))
                              .asyncMap((i) => CardCalulation()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return buildCard(snapshot.data);
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return buildCard(snapshot.data);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  bool buttonsVisible = false;
  int? grandTotal;
  var mobileNumber;
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
    final String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/track_my_order';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> data = {
      'orderId': widget.orderId,
    };

    final String requestBody = json.encode(data);
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: requestBody);

      if (response.statusCode == 200) {
        //print("Response: ${response.body}");
        final jsonResponse = json.decode(response.body);

        Map<String, dynamic> orderData = jsonResponse['data'][0];

        grandTotal = orderData['grand_total'];
        deliveryCharge = orderData['delivery_charge'];
        addressss = orderData['address'];

        dateee = orderData['order_date'];
        ordernum = orderData['orderId'];
        ordernumberneww = orderData['order_no'];
        modeee = orderData['payment_mode'];
        carddnum = orderData['cartId'];

        driverName = orderData['driver_name'];
        mobileNumber = orderData["userId"]['phone'];

        driverAssignStatus = orderData['driver_assign_status'];
        orderstatuss = orderData['order_status'];
        venderstatus = orderData['vender_status'];

        orderr_pla = orderData['order_date'];
        orderr_acc = orderData['in_progress_date'];
        orderr_pac = orderData['asign_date'];
        orderr_out = orderData['delivery_date'];
        orderr_dil = orderData['completed_date'];

        userName = orderData['userId']['user_name'];
        print("Customer Name: $userName");

        List<dynamic> productsData = jsonResponse['data'][0]['products'];
        products = List<Map<String, dynamic>>.from(productsData);
        for (var product in products) {
          String productId = product['productId'];
          String price = '\u{20B9} ${product['price']}';
        }

        for (var product in products) {
          String productImage =
              'http://103.104.74.215:3026/uploads/' + product['product_image'];
          String productName = product['description'];
          String variant = "Basmati";
          String quantity = "1 Kg";
          String price = '\u{20B9} ${product['price']}';
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
    print('Request Body: $requestBody');

    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: requestBody);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

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
          SnackBar(
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
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
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

                      if (parsedQuantity <=
                          int.parse(selectedProductQuantity)) {
                        await updateCard();
                        Navigator.of(context).pop();
                      } else {
                        _orderdaitails(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black, width: 0.3),
                      ),
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
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
      List<Location> locations = await locationFromAddress(addressss);
      if (locations.isNotEmpty) {
        dropeeLatitude = locations.first.latitude;
        dropeeLongitude = locations.first.longitude;

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

  Future<bool> _showDeleteConfirmationPopup(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm Reject'),
              content: Text('Also you reject this product?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Cancel',
                      style: TextStyle(color: Colors.green, fontSize: 16)),
                ),
                TextButton(
                  onPressed: () async {
                    await orderstatusd('Reject', ordernum.toString());
                    Navigator.of(context).pop(true);
                    Get.off(Nav_bar());
                  },
                  child: Text('Reject',
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
    if (data == null) {
      return Text('Data not available');
    }

    return Card(
      // margin: EdgeInsets.only(right: 20.0,left: 20),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Price:'),
                Text('${data['total_price']}'),
              ],
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery Fee:'),
                Text(
                    '${data['delivery_charge'] + data['flat_delivery_charge']}'),
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
                Text('Grand Total:'),
                Text('${data['grand_total']}'),
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
      //"userId": "659650a6472ec6a2086b73fc",
      "userId": widget.userId.toString(),
      // "cartId": "65965452472ec6a2086dfd6b"
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
        // Parse the response body
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

  void _orderdaitails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Maximum Quantity not consider',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Please Enter How Much Quantity you want to reduce'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok',
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
