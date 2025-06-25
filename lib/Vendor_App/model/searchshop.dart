import 'dart:convert';

import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/add_product/product.dart';

class Ssearch_shop extends StatefulWidget {
  const Ssearch_shop({Key? key}) : super(key: key);

  @override
  State<Ssearch_shop> createState() => _Ssearch_shopState();
}

class _Ssearch_shopState extends State<Ssearch_shop> {
  TextEditingController eeeController = TextEditingController();

  List products = [];
  List filteredProducts = [];
  bool isLoading = true;
  String? retrievedId;

  String? selectedVariant;

  final imageUrl = "http://103.104.74.215:3026/uploads/";

  // @override
  // void initState() {
  //   super.initState();
  //   getIdFromSharedPreferences().then((_) {
  //     if (retrievedId != null) {
  //       print('-------Retrieved data fil shop ID: $retrievedId');
  //       dropdownnew();
  //       // Dataproname();
  //     } else {}
  //   });
  // }

  // Future<void> getIdFromSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   retrievedId = prefs.getString('id');
  //   print("data fill -----------Retrieved ID: $retrievedId");
  // }

  List subtype = [];
  String? selectedValueone;

  //List<String> optionsone = ['meat', 'fish', 'chikan', 'mass'];

  List<String> gstlist = ['0', '5', '12', '18', '28', '8'];
  String selectedgst = "0";

  List<Map<String, dynamic>> categories = [];
  String? selectedCategory;
  String? selectedCategoryId;
  String? caegoryiddd;
  String? code;
  String barcodeResult = "Scan a barcode";

  TextEditingController shopname = TextEditingController();
  TextEditingController productname = TextEditingController();
  TextEditingController brandname = TextEditingController();
  TextEditingController barcodess = TextEditingController();
  TextEditingController varientt = TextEditingController();
  TextEditingController mrpricee = TextEditingController();
  TextEditingController salepricee = TextEditingController();
  TextEditingController descri = TextEditingController();
  TextEditingController searchbyname = TextEditingController();

  @override
  void initState() {
    super.initState();
    getIdFromSharedPreferences();
  }

  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
    print("Retrieved Category ID: $retrievedId");
    shopProducts();
  }

  Future<void> stockstatus(String productId) async {
    if (retrievedId == null) {
      return;
    }

    final url =
        Uri.parse('http://103.104.74.215:3026/needoo/digital/shopStock');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'shopId': retrievedId!,
        'productId': productId.toString(),
      }),
    );

    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
    } else {
      print('POST request failed with status: ${response.statusCode}');
      print('Response data: ${response.body}');
    }
  }

  // Future shopProducts() async {
  //   print("Retrieved 1Category ID: $retrievedId");
  //   setState(() {
  //     isLoading = true;
  //   });
  // //  final shopId = "65a7a4549a6b7c44ffd7d879";
  //   final apiUrl = "http://103.104.74.215:3026/needoo/digital/shop_product_list";
  //   print("Retrieved2 Category ID: $retrievedId");
  //   try {
  //     print("Retrieved3 Category ID: $retrievedId");
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       body: {
  //         'shopId': retrievedId.toString()},
  //     );
  //
  //     print("Retrieved4 Category ID: $retrievedId");
  //     if (response.statusCode == 200) {
  //       print("Retrieved5 Category ID: $retrievedId");
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       if (responseData['result'] == 'true') {
  //         setState(() {
  //           products = List<Map<String, dynamic>>.from(responseData['data']);
  //           filteredProducts = List<Map<String, dynamic>>.from(responseData['data']);
  //           isLoading = false;
  //         });
  //       } else {
  //         print("API returned an error: ${responseData['message']}");
  //       }
  //     } else {
  //       print("HTTP request failed with status: ${response.statusCode}");
  //     }
  //   } catch (error) {
  //     print("Error during HTTP request: $error");
  //   }
  // }
  Future shopProducts() async {
    print("Retrieved 1Category ID: $retrievedId");
    setState(() {
      isLoading = true;
    });

    if (retrievedId == null) {
      print("Retrieved ID is null. Unable to make the request.");
      // Handle the case where retrievedId is null
      return;
    }

    final apiUrl =
        "http://103.104.74.215:3026/needoo/digital/shop_product_list";
    print("Retrieved 2 Category ID: $retrievedId");

    try {
      print("Retrieved 3 Category ID: $retrievedId");
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'shopId': retrievedId.toString()},
      );

      print("Retrieved 4 Category ID: $retrievedId");
      if (response.statusCode == 200) {
        print("Retrieved 5 Category ID: $retrievedId");
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['result'] == 'true') {
          setState(() {
            products = List<Map<String, dynamic>>.from(responseData['data']);
            filteredProducts =
                List<Map<String, dynamic>>.from(responseData['data']);
            isLoading = false;
          });
        } else {
          print("API returned an error: ${responseData['message']}");
        }
      } else {
        print("HTTP request failed with status: ${response.statusCode}");
      }
    } catch (error) {
      print("Error during HTTP request: $error");
    }
  }

  String? selectedProductId;

  Future deleteProduct() async {
    print("$selectedProductId");
    print("$retrievedId");
    final String apiUrl =
        'http://103.104.74.215:3026/needoo/digital/delete_shopProduct';
    final Map<String, dynamic> data = {
      'shopId': retrievedId.toString(),
      'productId': selectedProductId.toString(),
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      setState(() {
        products.removeWhere(
            (product) => product["productId"] == selectedProductId);
        filteredProducts.removeWhere(
            (product) => product["productId"] == selectedProductId);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product deleted successfully'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: colors.button_color,
          // Replace with your desired color
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Search products",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 20, right: 8, bottom: 15),
                    child: TextField(
                      controller: eeeController,
                      onChanged: (value) {
                        print(value);
                        searchProducts(value);
                      },
                      decoration: const InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 5),
                        labelText: 'Search product',
                        labelStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                        hintText: 'search product',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Total Products: ${filteredProducts.length}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            isLoading
                ? LoadingAnimationWidget.fourRotatingDots(
                    color: const Color.fromARGB(255, 12, 110, 42),
                    size: 50,
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredProducts.length,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 13.0),
                            child: GestureDetector(
                              onTap: () {
                                showProductDetails(filteredProducts[index]);
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 12,
                                  width: MediaQuery.of(context).size.width / 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 13.0,
                                      top: 10,
                                      right: 15,
                                      bottom: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              12,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10,
                                          child: Image.network(
                                            'http://103.104.74.215:3026/uploads/${filteredProducts[index]["image"][0]}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2, left: 5),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            child: Text(
                                              filteredProducts[index]
                                                  ["products_name"],
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          child: filteredProducts[index]
                                                      ["stock_status"] ==
                                                  1
                                              ? Container(
                                                  child: const Text(
                                                    'Out of stock',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                )
                                              : const Text(
                                                  'In stock',
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                21.5),
                                        Row(
                                          children: [
                                            Text(
                                              '₹ ${filteredProducts[index]["price"].toString()}',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            PopupMenuButton<int>(
                                              onSelected: (value) async {
                                                if (value == 1) {
                                                  // Update functionality
                                                } else if (value == 2) {
                                                  selectedProductId =
                                                      filteredProducts[index]
                                                          ["productId"];
                                                  print(
                                                      "Product ID: $selectedProductId");
                                                  await deleteProduct();
                                                }
                                              },
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return <PopupMenuEntry<int>>[
                                                  PopupMenuItem<int>(
                                                    value: 1,
                                                    child: const Text('Update'),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => Product(
                                                              mrp: filteredProducts[
                                                                      index]
                                                                  ["mrp_price"],
                                                              sale:
                                                                  filteredProducts[
                                                                          index]
                                                                      [
                                                                      "price"]),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  PopupMenuItem<int>(
                                                    value: 2,
                                                    child: const Text('Delete'),
                                                    onTap: () async {
                                                      selectedProductId =
                                                          filteredProducts[
                                                                  index]
                                                              ["productId"];
                                                      print(
                                                          "Product ID: $selectedProductId");
                                                      await deleteProduct();
                                                    },
                                                  ),
                                                  filteredProducts[index][
                                                              "stock_status"] ==
                                                          1
                                                      ? PopupMenuItem<int>(
                                                          value: 3,
                                                          child: const Text(
                                                            'In Stock',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                          onTap: () async {
                                                            await stockstatus(
                                                                filteredProducts[
                                                                        index][
                                                                    "productId"]);
                                                            setState(() {
                                                              filteredProducts[
                                                                      index][
                                                                  "stock_status"] = 0;
                                                            });
                                                          },
                                                        )
                                                      : PopupMenuItem<int>(
                                                          value: 3,
                                                          child: const Text(
                                                            'Out Stock',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          onTap: () async {
                                                            await stockstatus(
                                                                filteredProducts[
                                                                        index][
                                                                    "productId"]);
                                                            setState(() {
                                                              filteredProducts[
                                                                      index][
                                                                  "stock_status"] = 1;
                                                            });
                                                          },
                                                        ),
                                                ];
                                              },
                                              child: const Icon(
                                                Icons.more_vert,
                                                size: 18,
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
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void searchProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
              (product["products_name"] as String?)
                      ?.toLowerCase()
                      ?.contains(query.toLowerCase()) ==
                  true ||
              (product["barcodes"].toString())
                      ?.toLowerCase()
                      ?.contains(query.toLowerCase()) ==
                  true)
          .toList();
    });
  }

  showProductDetails(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Text(product["products_name"],
              style: const TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'http://103.104.74.215:3026/uploads/${product["image"][0]}',
                  height: 100,
                ),
                const SizedBox(height: 10),
                Text('Price: ₹ ${product["price"]}'),
                Text('MRP Price: ₹ ${product["mrp_price"]}'),
                Text(
                    'Stock Status: ${product["stock_status"] == 1 ? 'Out of Stock' : 'In Stock'}'),
                Text('GST: ${product["gst"]}%'),
                Text('Variants: ${product["variants"]}'),
                for (var entry in product.entries)
                  if (entry.key != 'image' &&
                      entry.key != 'productId' &&
                      entry.key != 'price' &&
                      entry.key != 'stock_status' &&
                      entry.key != 'variants' &&
                      entry.key != 'products_name' &&
                      entry.key != 'shopId' &&
                      entry.key != 'mrp_price' &&
                      entry.key != 'act_status' &&
                      entry.key != 'gst' &&
                      entry.key != 'mrp')
                    Text('${entry.key}: ${entry.value}'),
              ],
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  // Button color
                  borderRadius: BorderRadius.circular(25),
                  // Button border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.5), // Shadow color
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.teal.shade300],
                    // Gradient colors
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 16,
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
}
