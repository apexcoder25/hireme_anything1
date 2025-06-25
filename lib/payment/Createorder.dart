import 'package:hire_any_thing/main.dart';
import 'package:hire_any_thing/utilities/AppConstant.dart';
import 'package:hire_any_thing/utilities/constant.dart';
import 'package:hire_any_thing/views/booking_success.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../navigation_bar.dart';

class CreateOrder extends StatefulWidget {
  final DateTime selectedDate;
  final String selectedTime;

  const CreateOrder({
    required this.selectedDate,
    required this.selectedTime,
    Key? key,
  }) : super(key: key);

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  bool toggle = false;
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kwhiteColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          "Create order",
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
          child: Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 100 / 100,
          width: MediaQuery.of(context).size.width * 100 / 100,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selected Services",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "1 Service",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 12 / 100,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      List<String> image = [
                        // "assets/icons/fans.png",
                        // "assets/icons/splitac.jpg"
                        "assets/new/limousine.jpg",
                        "assets/new/Horse and Carriage.jpeg",
                      ];
                      int imageIndex = index % image.length;
                      String imageUrl = image[imageIndex];
                      double productPrice = double.parse(
                          selectedProduct?.productPrice?.toString() ?? "650");

                      if (productPrice != null) {
                        totalPrice += productPrice;
                      }

                      return Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 9 / 100,
                          padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    10 /
                                    100,
                                width: MediaQuery.of(context).size.width *
                                    20 /
                                    100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(imageUrl),
                                        fit: BoxFit.fill)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height *
                                    8 /
                                    100,
                                width: MediaQuery.of(context).size.width *
                                    28 /
                                    100,
                                child: Text(
                                  selectedProduct != null
                                      ? selectedProduct!.productName ?? "Fan"
                                      : "Limousine",
                                  style: AppConstant.OrderList,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    20 /
                                    100,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height *
                                    8 /
                                    100,
                                width: MediaQuery.of(context).size.width *
                                    20 /
                                    100,
                                child: Text(
                                  selectedProduct != null
                                      ? selectedProduct!.productPrice
                                              .toString() ??
                                          "500"
                                      : "\$650",
                                  style: AppConstant.OrderListprice,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 60 / 100,
                width: MediaQuery.of(context).size.width * 95 / 100,
                decoration: BoxDecoration(
                  color: kwhiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selected Date & Time",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${DateFormat('dd/MMM/yyyy').format(widget.selectedDate)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: kPrimaryColor),
                            ),
                            Text(
                              widget.selectedTime,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Bill Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Service Charge",
                              style: AppConstant.OrderListBill),
                          Text(
                            "\$1300",
                            style: AppConstant.OrderListprice,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Assurance Tax",
                              style: AppConstant.OrderListBill),
                          Text(
                            "\$20",
                            style: AppConstant.OrderListprice,
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Service Tax", style: AppConstant.OrderListBill),
                          Text("\$20", style: AppConstant.OrderListprice),
                        ],
                      ),
                      SizedBox(height: 20),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "\$1340",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BookingSuccessfulPage()));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: kPrimaryColor,
                          ),
                          child: Text(
                            "Create Order",
                            style: TextStyle(
                              fontSize: 18,
                              color: kwhiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
