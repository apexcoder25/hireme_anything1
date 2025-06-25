import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  final String shopId;

  NotificationScreen({required this.shopId});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, String>> notifications = [];

  // @override
  // void initState() {
  //   super.initState();
  //   fetchNotifications();
  // }

  // Future<void> fetchNotifications() async {
  //   final response = await http.post(
  //     Uri.parse(
  //         ''),
  //     body: json.encode({"shopId": widget.shopId}),
  //     headers: {'Content-Type': 'application/json'},
  //   );

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> jsonResponse = json.decode(response.body);

  //     if (jsonResponse['result'] == 'true') {
  //       List<dynamic> data = jsonResponse['data'];

  //       setState(() {
  //         notifications = List<Map<String, String>>.from(data.map(
  //           (dynamic item) {
  //             return Map<String, String>.from(item.map(
  //               (key, value) => MapEntry(key, value.toString()),
  //             ));
  //           },
  //         ));
  //       });
  //     } else {
  //       // Handle error case if needed
  //       print('Error: ${jsonResponse['message']}');
  //     }
  //   } else {
  //     // Handle error case if needed
  //     print('Error: ${response.statusCode}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: colors.button_color,
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      // body: notifications.isEmpty
      //     ? Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     :
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20, bottom: 10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: ListTile(
                    // title: Text(notifications[index]['title'] ?? ''),
                    subtitle: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/app_logo/SH.png',
                          ),
                          radius: 25.0,
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Text('notification'),
                        ),
                      ],
                    ),
                    trailing: Text('01-03-24'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: NotificationScreen(
        shopId: "65698899a286659227113e6f", // Replace with your shopId
      ),
    ),
  );
}
