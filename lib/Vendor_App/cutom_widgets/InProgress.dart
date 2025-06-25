import 'package:hire_any_thing/Vendor_App/cutom_widgets/button.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/view/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InProgressWidget extends StatefulWidget {
  const InProgressWidget({super.key});

  @override
  State<InProgressWidget> createState() => _InProgressWidgetState();
}

class _InProgressWidgetState extends State<InProgressWidget> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Container(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: 8,
          itemBuilder: (context, index) {
            if (true) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: GestureDetector(
                  onTap: () {
                    // String orderId = yourDataList[index]
                    //     ["orderNumber"];
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
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: h / 15,
                                    // width: w/5,
                                    child:
                                        Image.asset('assets/image/product.png'),
                                  ),
                                  SizedBox(
                                    width: w / 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Order Number: 123",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(
                                            width: w / 7,
                                          ),
                                          Text(
                                            'GHS 542',
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: h / 100),
                                      Text(
                                        "Date: 29-02-24",
                                        style: const TextStyle(
                                          color: colors.hintext_shop,
                                        ),
                                      ),
                                      const Text(
                                        "Product List:",
                                        style: TextStyle(
                                          color: colors.hintext_shop,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      // for (var i = 0; i < 5; i++)
                                      Row(
                                        children: [
                                          Container(
                                            width: w / 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('product name'),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ": 3",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: h / 50),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: w / 1,
                                height: h / 1000,
                                color: Colors.grey,
                              ),
                              SizedBox(height: h / 100),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  if (true) ...[
                                    Button_widget(
                                      buttontext: "In Progress",
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
                                  ],
                                  if (false) ...[
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                      ),
                                      onPressed: () async {
                                        // await orderstatus(
                                        //     "Reject",
                                        //     yourDataList[
                                        //             index]
                                        //         [
                                        //         "orderNumber"],
                                        //     yourDataList[index]
                                        //             [
                                        //             "userid"]
                                        //         .toString());
                                        // ScaffoldMessenger.of(
                                        //         context)
                                        //     .showSnackBar(
                                        //   const SnackBar(
                                        //     content: Text(
                                        //         'Order Reject Successfully'),
                                        //     duration: Duration(
                                        //         seconds:
                                        //             2),
                                        //     backgroundColor:
                                        //         Colors
                                        //             .red,
                                        //   ),
                                        // );
                                        print("hello");
                                      },
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
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                      ),
                                      onPressed: () async {
                                        // await orderstatus(
                                        //     "Accept",
                                        //     yourDataList[index]
                                        //             [
                                        //             "orderNumber"]
                                        //         .toString(),
                                        //     yourDataList[index]
                                        //             [
                                        //             "userid"]
                                        //         .toString());
                                        // print("jkjkjkgjkghjkgjkg" +
                                        //     yourDataList[index]
                                        //             [
                                        //             "orderNumber"]
                                        //         .toString());
                                        // ScaffoldMessenger.of(
                                        //         context)
                                        //     .showSnackBar(
                                        //   const SnackBar(
                                        //     content: Text(
                                        //         'Order Accept Successfully'),
                                        //     duration: Duration(
                                        //         seconds:
                                        //             2),
                                        //     backgroundColor:
                                        //         Colors
                                        //             .green,
                                        //   ),
                                        // );
                                        print("hello");
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              // If driverAssignStatus is not "0", return an empty container.
              return Container();
            }
          },
        )),
      ),
    );
  }
}
