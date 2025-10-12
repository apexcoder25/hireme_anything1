import 'package:hire_any_thing/Vendor_App/view/add_product/existing_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/searchshop.dart';
import '../uiltis/color.dart';
import 'cate_product_list.dart';

class Add_category extends StatefulWidget {
  const Add_category({super.key});

  @override
  State<Add_category> createState() => _Add_categoryState();
}

class _Add_categoryState extends State<Add_category> {
  String? retrievedId;
  // List<Category> categories = [1,2,3,4,5,6];

  List<int> categories = [1, 2, 3, 4, 5, 6];

  // @override
  // void initState() {
  //   super.initState();
  //   getIdFromSharedPreferences().then((_) {
  //     if (retrievedId != null) {
  //       print('Retrieved Category shop ID: $retrievedId');
  //       fetchCategories();
  //     } else {
  //       print('Retrieved Category is empty: $retrievedId');
  //     }
  //   });
  // }

  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
    print("Retrieved Category ID: $retrievedId");
  }

  // fetchCategories() async {
  //   final apiUrl = 'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/category_list';
  //   final data = {'shopId': retrievedId};
  //
  //   try {
  //     final response = await http.post(Uri.parse(apiUrl), body: data);
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> jsonResponse = json.decode(response.body);
  //
  //       if (jsonResponse['result'] == 'true') {
  //         final List<dynamic> categoryData = jsonResponse['data'];
  //
  //         setState(() {
  //           categories = categoryData
  //               .map((category) => Category.fromJson(category))
  //               .toList();
  //         });
  //         // print("================================================================");
  //         //print("Response data: ${response.body}");
  //         //print("================================================================");
  //       } else {
  //         print('API returned an error message: ${jsonResponse['message']}');
  //       }
  //     } else {
  //       print(
  //           'Failed to make the API request. Status code: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //     print("tessssssstttttttttt");
  //   }
  // }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // Future<void> _refreshData() async {
  //   await fetchCategories();
  // }

  TextEditingController rrrsearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        //backgroundColor: colors.scaffold_background_color,
        appBar: AppBar(
          backgroundColor: colors.button_color,
          // Replace with your desired color
          foregroundColor: colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Products",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          backgroundColor: Colors.white,
          color: Colors.green,
          displacement: BorderSide.strokeAlignCenter,
          // onRefresh: _refreshData,
          onRefresh: () async {
            // return true;
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Ssearch_shop()),
                      );
                    },
                    child: Container(
                      height: 55,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Search product',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(color: Colors.grey, width: 0.8),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h / 60,
                  ),
                  // StreamBuilder(
                  //   stream: Stream.periodic(Duration(seconds: 0))
                  //       .asyncMap((i) => fetchCategories()),
                  //   builder: (context, snapshot) {
                  //     return
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: categories.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            // final prefs =
                            // await SharedPreferences.getInstance();
                            // final selectedCategory =
                            //     categories[index].category;
                            // await prefs.setString(
                            //     'selectedCategory', selectedCategory);

                            print("----------------------------");
                            // print(selectedCategory);
                            print("----------------------------");

                            // Navigate to the next screen
                            Get.to(Cate_product_list());
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              height: h / 12,
                              width: w / 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        height: h / 12,
                                        width: w / 10,
                                        child: Text("Categories Image")
                                        // Image.network(
                                        //     categories[index].image),
                                        ),
                                    Text("category name",
                                        // categories[index].category,
                                        style: TextStyle(fontSize: 15)),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Total product",
                                            style: TextStyle(fontSize: 12)),
                                        Text(
                                          "20",
                                          // categories[index]
                                          //     .products
                                          //     .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: SpeedDial(
        //     backgroundColor: colors.button_color,
        //     child: Icon(Icons.add, size: 30),
        //     children: [
        //       SpeedDialChild(
        //           onTap: () {
        //             Get.to(FileUploadPage());
        //           },
        //           child: Icon(
        //             Icons.file_upload_outlined,
        //             color: colors.black,
        //           ),
        //           label: "file upload"),
        //       SpeedDialChild(
        //           onTap: () {
        //             Get.to(ExistingProduct());
        //           },
        //           child: Icon(
        //             Icons.search,
        //             color: colors.black,
        //           ),
        //           label: "Add New product"),
        //     ],
        //   ),
        // ));
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SpeedDial(
            backgroundColor: colors.button_color,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colors.button_color.withOpacity(0.8),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Icon(Icons.add, color: Colors.white, size: 36),
            ),
            children: [
              // _buildSpeedDialChild(
              //     Icons.file_upload_outlined, "File Upload", () {
              //   Get.to(FileUploadPage());
              // }),
              _buildSpeedDialChild(Icons.search, "Add New Product", () {
                Get.to(ExistingProduct());
              }),
            ],
          ),
        ));
  }

  SpeedDialChild _buildSpeedDialChild(
      IconData icon, String label, VoidCallback onTap) {
    return SpeedDialChild(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            icon,
            color: colors.black,
            size: 24,
          ),
        ),
      ),
      label: label,
      labelStyle: TextStyle(fontSize: 14),
    );
  }

  TextEditingController category_name = TextEditingController();
  TextEditingController category_description = TextEditingController();
}

class Category {
  final String category;
  final String image;
  final int products;

  Category({
    required this.category,
    required this.image,
    required this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      category: json['category'],
      image: 'http://103.104.74.215:3092/uploads/${json['image']}',
      products: json['products'],
    );
  }
}
