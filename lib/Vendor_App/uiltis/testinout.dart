// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:salon_hub_beautician/constant/api_url.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../uiltis/color.dart';

// class cinout extends StatefulWidget {
//   const cinout({super.key});

//   @override
//   State<cinout> createState() => _Cate_product_listState();
// }

// class _Cate_product_listState extends State<cinout> {
//   String? retrievedId;
//   String catname = "";
//   String productIds = "";
//   bool isLoading = true;
//   TextEditingController _searchController = TextEditingController();
//   List<Category> categories = [];
//   List<Category> filteredCategories = [];

//   @override
//   void initState() {
//     super.initState();
//     getCategoryFromSharedPreferences();
//     sendPostRequest();
//     getIdFromSharedPreferences().then((_) {
//       if (retrievedId != null) {
//         print('Retrieved Category all shop ID: $retrievedId');
//         print("Product IDs: $productIds");
//         loadListWithLoader();
//       } else {
//         print('Retrieved Category all is empty: $retrievedId');
//       }
//     });
//   }

//   Future getCategoryFromSharedPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     final selectedCategory = prefs.getString('selectedCategory');
//     if (selectedCategory != null) {
//       catname = selectedCategory;
//       print("Selected Category: $selectedCategory");
//     } else {
//       print("No selected category found in shared preferences.");
//     }
//   }

//   Future<void> getIdFromSharedPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     retrievedId = prefs.getString('id');
//     print("Retrieved ID: $retrievedId");
//   }

//   List<List<bool>> isSelectedList = List.generate(500, (_) => [true, false]);

//   void toggleSelection(int itemIndex, int buttonIndex) {
//     setState(() {
//       for (int index = 0; index < isSelectedList[itemIndex].length; index++) {
//         isSelectedList[itemIndex][index] = (index == buttonIndex);
//       }
//     });
//   }

//   Future<void> loadListWithLoader() async {
//     await Future.delayed(Duration(seconds: 1));
//     await sendPostRequest();
//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: colors.scaffold_background_color,
//       appBar: AppBar(
//         backgroundColor: colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           "Sub Product",
//           style: TextStyle(
//               fontSize: 20, color: colors.black, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: isLoading
//           ? Center(
//               child: LoadingAnimationWidget.fourRotatingDots(
//                 color: Color.fromARGB(255, 12, 110, 42),
//                 size: 50,
//               ),
//             )
//           : SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
//                 child: Column(
//                   children: [
//                     TextField(
//                       controller: _searchController,
//                       decoration: InputDecoration(
//                         labelText: 'Search product',
//                         labelStyle: TextStyle(color: Colors.green),
//                         hintText: 'search product',
//                         prefixIcon: Icon(Icons.search, color: Colors.grey),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                           borderSide: BorderSide(color: Colors.green),
//                         ),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           filteredCategories = categories
//                               .where((category) => category.productsname
//                                   .toLowerCase()
//                                   .contains(value.toLowerCase()))
//                               .toList();

//                           sortFilteredCategories(value);
//                         });
//                       },
//                     ),
//                     SizedBox(
//                       height: h / 60,
//                     ),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: filteredCategories.length,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 13.0),
//                           child: GestureDetector(
//                             onTap: () {
//                               //Get.to(Cate_product_list());
//                               //Navigator.push(context, MaterialPageRoute(builder: (context) => Product(),));
//                             },
//                             child: Material(
//                               borderRadius: BorderRadius.circular(10),
//                               elevation: 2,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.white,
//                                 ),
//                                 height: h / 12,
//                                 width: w / 1,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 13.0,
//                                       top: 10,
//                                       right: 15,
//                                       bottom: 10),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     children: [
//                                       SizedBox(
//                                         height: h / 12,
//                                         width: w / 10,
//                                         child: Image.network(
//                                             filteredCategories[index].image),
//                                       ),
//                                       Padding(
//                                         padding:
//                                             EdgeInsets.only(top: 2, left: 5),
//                                         child: SizedBox(
//                                           width: w / 6,
//                                           child: Text(
//                                               filteredCategories[index]
//                                                   .productsname,
//                                               style: TextStyle(fontSize: 15)),
//                                         ),
//                                       ),
//                                       Container(
//                                         height: 30,
//                                         child: ToggleButtons(
//                                           children: <Widget>[
//                                             Text('In'),
//                                             Text('Out'),
//                                           ],
//                                           isSelected: isSelectedList[index],
//                                           onPressed: (buttonIndex) {
//                                             toggleSelection(index, buttonIndex);
//                                             print(
//                                                 "Product ID: ${filteredCategories[index].productId}, Toggle Index: $buttonIndex");
//                                             stockstatus(
//                                                 filteredCategories[index]
//                                                     .productId);
//                                           },
//                                           selectedColor: Colors.white,
//                                           fillColor: filteredCategories[index]
//                                                       .stockStatus ==
//                                                   0
//                                               ? Colors.green
//                                               : colors.button_color,
//                                           borderColor: filteredCategories[index]
//                                                       .stockStatus ==
//                                                   0
//                                               ? Colors.green
//                                               : colors.button_color,
//                                           borderRadius:
//                                               BorderRadius.circular(100.0),
//                                           borderWidth: 2.0,
//                                         ),
//                                       ),
//                                       SizedBox(width: w / 21.5),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             '₹ ${filteredCategories[index].price.toString()}',
//                                             style: TextStyle(
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           PopupMenuButton<int>(
//                                             onSelected: (value) async {
//                                               if (value == 1) {
//                                                 final selectedProductId =
//                                                     filteredCategories[index]
//                                                         .productId;
//                                                 SharedPreferences prefs =
//                                                     await SharedPreferences
//                                                         .getInstance();
//                                                 prefs.setString(
//                                                     'selectedProductId',
//                                                     selectedProductId);
//                                                 print(
//                                                     "Selected Product ID for Update category screen: $selectedProductId");
//                                               } else if (value == 2) {
//                                                 final selectedProductId =
//                                                     filteredCategories[index]
//                                                         .productId;
//                                                 print(selectedProductId);
//                                                 showDeleteConfirmationDialog(
//                                                     selectedProductId);
//                                                 sendPostRequest();
//                                               }
//                                               // Add more cases as needed
//                                             },
//                                             itemBuilder:
//                                                 (BuildContext context) {
//                                               return <PopupMenuEntry<int>>[
//                                                 PopupMenuItem<int>(
//                                                   value: 1,
//                                                   child: Text('Update'),
//                                                   onTap: () {
//                                                     // Navigator.push(
//                                                     //   context,
//                                                     //   MaterialPageRoute(
//                                                     //     builder: (context) =>
//                                                     //         Product(),
//                                                     //   ),
//                                                     // );
//                                                   },
//                                                 ),
//                                                 PopupMenuItem<int>(
//                                                   value: 2,
//                                                   child: Text('Delete'),
//                                                   onTap: () {
//                                                     // Handle delete option
//                                                   },
//                                                 ),
//                                                 // Add more PopupMenuItem entries as needed
//                                               ];
//                                             },
//                                             child: Icon(
//                                               Icons.more,
//                                               size: 18,
//                                             ),
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   Future<void> deleteProduct(String productId) async {
//     final String apiUrl =
//         ApiUrl.baseUrl+ApiUrl.deleteShopProductUrl;
//     final Map<String, dynamic> data = {
//       'shopId': retrievedId.toString(),
//       'productId': productId,
//     };

//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(data),
//     );

//     if (response.statusCode == 200) {
//       print("Response: ${response.body}");
//       // Update the product list after deletion
//       await sendPostRequest();
//     } else {
//       print("Error: ${response.statusCode}");
//     }
//   }

//   void showDeleteConfirmationDialog(String productId) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Are you sure!"),
//           content: Text("You want to delete this product -"),
//           actions: <Widget>[
//             TextButton(
//               child: Text("Cancel",
//                   style: TextStyle(color: Colors.green, fontSize: 18)),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text("Delete",
//                   style: TextStyle(color: Colors.green, fontSize: 18)),
//               onPressed: () async {
//                 await deleteProduct(productId);
//                 await sendPostRequest();
//                 Navigator.of(context).pop();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Product Delete Successfully'),
//                     duration: Duration(seconds: 2),
//                     backgroundColor: Colors.green,
//                   ),
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void sortFilteredCategories(String query) {
//     filteredCategories.sort((a, b) {
//       bool aMatches =
//           a.productsname.toLowerCase().startsWith(query.toLowerCase());
//       bool bMatches =
//           b.productsname.toLowerCase().startsWith(query.toLowerCase());

//       if (aMatches && !bMatches) {
//         return -1;
//       } else if (!aMatches && bMatches) {
//         return 1;
//       } else {
//         return 0;
//       }
//     });
//   }

//   Future<void> stockstatus(String productId) async {
//     if (retrievedId == null) {
//       print('Retrieved ID is null');
//       return;
//     }

//     final url =
//         Uri.parse(ApiUrl.baseUrl+ApiUrl.shopStockUrl);
//     print("inside api $retrievedId");

//     final response = await http.post(
//       url,
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(<String, String>{
//         'shopId': retrievedId!,
//         'productId': productId.toString(),
//       }),
//     );
//     print('------------------------------------------ $productId');

//     if (response.statusCode == 200) {
//       print('------------------------------------------ successful');
//       print('Response data: ${response.body}');
//       final responseData = jsonDecode(response.body);
//     } else {
//       print('POST request failed with status: ${response.statusCode}');
//       print('Response data: ${response.body}');
//     }
//   }

//   Future sendPostRequest() async {
//     print("11111111");
//     print("$catname");
//     print("11111111");
//     final apiUrl =
//         Uri.parse(ApiUrl.baseUrl+ApiUrl.productListUrl);
//     final data = {
//       'shopId': retrievedId,
//       'category_name': catname.toString(),
//     };
//     try {
//       final response = await http.post(
//         apiUrl,
//         body: data,
//       );
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonResponse = json.decode(response.body);
//         final List<dynamic> categoryData = jsonResponse['data'];

//         setState(() {
//           categories = categoryData
//               .map((category) => Category.fromJson(category))
//               .toList();
//           filteredCategories =
//               categories; // Initialize filteredCategories with all categories
//         });

//         for (var product in categories) {
//           print(
//               "Product ID: ${product.productId}, Stock Status: ${product.stockStatus}");
//         }
//         print("***********************************************************");
//         print("Response data: ${response.body}");
//         print("***********************************************************");
//       } else {
//         print("Request failed with status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
// }

// class Category {
//   final String productsname;
//   final String image;
//   final int price;
//   final String productId;
//   final int stockStatus;

//   Category({
//     required this.productsname,
//     required this.image,
//     required this.price,
//     required this.productId,
//     required this.stockStatus,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       productsname: json['products_name'],
//       image: 'http://103.104.74.215:3026/uploads/${json['image'][0]}',
//       price: json['price'],
//       productId: json['productId'],
//       stockStatus: json['stock_status'],
//     );
//   }
// }
