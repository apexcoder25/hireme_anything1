import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/view/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompletedWidget extends StatefulWidget {
  const CompletedWidget({super.key});

  @override
  State<CompletedWidget> createState() => _CompletedWidgetState();
}

class _CompletedWidgetState extends State<CompletedWidget> {
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
              if ("3" == "3") {
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
                        userId: 'userId',
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
                            child: Row(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Order Number: 34",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(
                                          width: w / 6,
                                        ),
                                        Text(
                                          'GHS 453',
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: h / 100),
                                    Text(
                                      "Date:29-2-24",
                                      style: const TextStyle(
                                        color: colors.hintext_shop,
                                      ),
                                    ),
                                    // const Text(
                                    //   "Product List:",
                                    //   style: TextStyle(
                                    //     color:
                                    //         colors.hintext_shop,
                                    //   ),
                                    // ),
                                    SizedBox(height: h / 70),
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
                                                ":  3",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: h / 50),
                                    // Container(
                                    //   width: w / 1,
                                    //   height: h / 1000,
                                    //   color: Colors.grey,
                                    // ),
                                    // SizedBox(height: h / 100),
                                    ///////////////////////////////////////////////////////////////////////

                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment
                                    //           .spaceAround,
                                    //   children: [
                                    //     if (yourDataList[index][
                                    //             "vendorStatus"] ==
                                    //         "accept") ...[
                                    //       Button_widget(
                                    //         buttontext: yourDataList[
                                    //                         index]
                                    //                     [
                                    //                     "driverAssignStatus"] ==
                                    //                 "0"
                                    //             ? "Assign"
                                    //             : yourDataList[index]
                                    //                         [
                                    //                         "driverAssignStatus"] ==
                                    //                     "1"
                                    //                 ? "In Progress"
                                    //                 : yourDataList[index]
                                    //                             [
                                    //                             "driverAssignStatus"] ==
                                    //                         "3"
                                    //                     ? "Done"
                                    //                     : "",
                                    //         button_height: 20,
                                    //         button_weight: 3,
                                    //         onpressed: () async {
                                    //           if (yourDataList[
                                    //                           index]
                                    //                       [
                                    //                       "driverAssignStatus"] !=
                                    //                   "1" &&
                                    //               yourDataList[
                                    //                           index]
                                    //                       [
                                    //                       "driverAssignStatus"] !=
                                    //                   "2") {
                                    //             String orderId =
                                    //                 yourDataList[
                                    //                         index]
                                    //                     [
                                    //                     "orderNumber"];
                                    //             String userId =
                                    //                 yourDataList[
                                    //                             index]
                                    //                         [
                                    //                         "userid"] ??
                                    //                     "N/A";

                                    //             SharedPreferences
                                    //                 prefs =
                                    //                 await SharedPreferences
                                    //                     .getInstance();
                                    //             prefs.setString(
                                    //                 'orderId',
                                    //                 orderId);
                                    //             prefs.setString(
                                    //                 'userId',
                                    //                 userId);

                                    //             print(
                                    //                 "OrderId: $orderId, UserId: $userId");
                                    //             // Navigator
                                    //             //     .push(
                                    //             //   context,
                                    //             //   MaterialPageRoute(
                                    //             //     builder:
                                    //             //         (context) =>
                                    //             //             asigndelivery(),
                                    //             //   ),
                                    //             // );
                                    //           }
                                    //         },
                                    //       ),
                                    //     ],
                                    //     if (yourDataList[index][
                                    //             "vendorStatus"] !=
                                    //         "accept") ...[
                                    //       ElevatedButton(
                                    //         style: ButtonStyle(
                                    //           shape:
                                    //               MaterialStateProperty
                                    //                   .all(
                                    //             RoundedRectangleBorder(
                                    //               side: const BorderSide(
                                    //                   color: Colors
                                    //                       .red),
                                    //               borderRadius:
                                    //                   BorderRadius
                                    //                       .circular(
                                    //                           20),
                                    //             ),
                                    //           ),
                                    //           backgroundColor:
                                    //               MaterialStateProperty
                                    //                   .all(Colors
                                    //                       .white),
                                    //         ),
                                    //         onPressed: yourDataList[
                                    //                             index]
                                    //                         [
                                    //                         "driverAssignStatus"] !=
                                    //                     "1" &&
                                    //                 yourDataList[
                                    //                             index]
                                    //                         [
                                    //                         "driverAssignStatus"] !=
                                    //                     "2"
                                    //             ? () async {
                                    //                 await orderstatus(
                                    //                     "Reject",
                                    //                     yourDataList[
                                    //                             index]
                                    //                         [
                                    //                         "orderNumber"],
                                    //                     yourDataList[index]
                                    //                             [
                                    //                             "userid"]
                                    //                         .toString());
                                    //                 ScaffoldMessenger.of(
                                    //                         context)
                                    //                     .showSnackBar(
                                    //                   const SnackBar(
                                    //                     content: Text(
                                    //                         'Order Reject Successfully'),
                                    //                     duration: Duration(
                                    //                         seconds:
                                    //                             2),
                                    //                     backgroundColor:
                                    //                         Colors
                                    //                             .red,
                                    //                   ),
                                    //                 );
                                    //               }
                                    //             : null,
                                    //         child: const Text(
                                    //           "Reject",
                                    //           style: TextStyle(
                                    //             color: Colors.red,
                                    //             fontSize: 17,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       ElevatedButton(
                                    //         style: ButtonStyle(
                                    //           shape:
                                    //               MaterialStateProperty
                                    //                   .all(
                                    //             RoundedRectangleBorder(
                                    //               borderRadius:
                                    //                   BorderRadius
                                    //                       .circular(
                                    //                           20),
                                    //             ),
                                    //           ),
                                    //           backgroundColor:
                                    //               MaterialStateProperty
                                    //                   .all(Colors
                                    //                       .white),
                                    //         ),
                                    //         onPressed: yourDataList[
                                    //                             index]
                                    //                         [
                                    //                         "driverAssignStatus"] !=
                                    //                     "1" &&
                                    //                 yourDataList[
                                    //                             index]
                                    //                         [
                                    //                         "driverAssignStatus"] !=
                                    //                     "2"
                                    //             ? () async {
                                    //                 await orderstatus(
                                    //                     "Accept",
                                    //                     yourDataList[index]
                                    //                             [
                                    //                             "orderNumber"]
                                    //                         .toString(),
                                    //                     yourDataList[index]
                                    //                             [
                                    //                             "userid"]
                                    //                         .toString());
                                    //                 print("jkjkjkgjkghjkgjkg" +
                                    //                     yourDataList[index]
                                    //                             [
                                    //                             "orderNumber"]
                                    //                         .toString());
                                    //                 ScaffoldMessenger.of(
                                    //                         context)
                                    //                     .showSnackBar(
                                    //                   const SnackBar(
                                    //                     content: Text(
                                    //                         'Order Accept Successfully'),
                                    //                     duration: Duration(
                                    //                         seconds:
                                    //                             2),
                                    //                     backgroundColor:
                                    //                         Colors
                                    //                             .green,
                                    //                   ),
                                    //                 );
                                    //               }
                                    //             : null,
                                    //         child: const Text(
                                    //           "Accept",
                                    //           style: TextStyle(
                                    //             color:
                                    //                 Colors.green,
                                    //             fontSize: 17,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ],
                                    // ),
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
          ),
        ),
      ),
    );
  }
}
