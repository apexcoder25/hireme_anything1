import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/view/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelWidget extends StatefulWidget {
  const CancelWidget({super.key});

  @override
  State<CancelWidget> createState() => _CancelWidgetState();
}

class _CancelWidgetState extends State<CancelWidget> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 8,
          itemBuilder: (context, index) {
            if ("Cancel" == "Cancel") {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: GestureDetector(
                  onTap: () {
                    // String orderId =
                    //     yourDataList[index]["orderNumber"];
                    // String userId =
                    //     yourDataList[index]["userid"];
                    Get.to(Details(
                      orderId: 'orderId',
                      userId: ' userId',
                    ));
                  },
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(15),
                    child: IntrinsicHeight(
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 15.0,
                            top: 10,
                            bottom: 8,
                            left: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order Number: 12",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'GHS 222',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: h / 100),
                              Text(
                                "Date:29-02-24",
                                style: const TextStyle(
                                  color: colors.hintext_shop,
                                ),
                              ),
                              const Text(
                                "Product List: ",
                                style: TextStyle(
                                  color: colors.hintext_shop,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // for (var i = 0; i < 1; i++)
                              Row(
                                children: [
                                  Container(
                                    width: w / 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'item name',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ":  2",
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
                              SizedBox(
                                  height: 50,
                                  child: Image.asset(
                                    "assets/image/cancelled.png",
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                child: Text("tata"),
              );
            }
          },
        ),
      ),
    );
  }
}
