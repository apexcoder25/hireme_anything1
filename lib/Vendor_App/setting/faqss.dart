import 'package:flutter/material.dart';

import '../uiltis/color.dart';

class FAQHomePage extends StatefulWidget {
  @override
  _FAQHomePageState createState() => _FAQHomePageState();
}

class _FAQHomePageState extends State<FAQHomePage> {
  List faqData = [];

  // @override
  // void initState() {
  //   super.initState();
  //   faqqqqq();
  // }

  // Future faqqqqq() async {
  //   print("-----------------------------------------------------------");
  //   final Uri url = Uri.parse('');

  //   try {
  //     final response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       print("-----1------------------------------------------------------");
  //       print("-----1------------------------------------------------------");

  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       print(
  //           "-----666666------------------------------------------------------");
  //       print(responseData);

  //       print(
  //           "-----666666------------------------------------------------------");
  //       if (responseData['result'].toString() == true.toString()) {
  //         print(responseData['result'].toString());
  //         setState(() {
  //           faqData = responseData['data'];
  //           print(
  //               "-----666666--------------543546----------------------------------------");
  //           print(faqData);
  //         });
  //       } else {
  //         print('API returned false result');
  //       }
  //     } else {
  //       print('Error: ${response.statusCode}');
  //       print(response.body);
  //       print("-----------------------------------------------------------2");
  //       throw Exception('Failed to load FAQ data');
  //     }
  //   } catch (error) {
  //     print('Exception during data fetching: $error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print('Building UI');
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: colors.white,
          ),
        ),
        backgroundColor: colors.button_color,
        centerTitle: true,
        title: Text(
          'FAQs Screen',
          style: TextStyle(color: colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      // body: faqData.isEmpty
      //     ? Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     :
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                'No question',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: Text('No answer'),
              ),
            ),
          );
        },
      ),
    );
  }
}
