import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/vender_side_getx_controller.dart';

import '../uiltis/color.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  Future<Map<String, String>>? contactData;

  // @override
  // void initState() {
  //   super.initState();
  //   contactData = fetchContactData();
  // }

  // Future<Map<String, String>> fetchContactData() async {
  //   final Uri url = Uri.parse('');

  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     if (data['result'] == 'true') {
  //       return {
  //         'client_name': data['data'][0]['client_name'],
  //         'email': data['data'][0]['email'],
  //         'phone': data['data'][0]['phone'].toString(),
  //         'whatsapp': data['data'][0]['whatsapp'].toString(),
  //       };
  //     }
  //   }

  //   throw Exception('Error fetching contact data');
  // }

  @override
  Widget build(BuildContext context) {
    final VenderSidetGetXController venderSidetGetXController = Get.put(VenderSidetGetXController());

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
            'Contact us',
            style: TextStyle(color: colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        // body: FutureBuilder<Map<String, String>>(
        //   future: contactData,
        //   builder: (context, snapshot) {
        //     if (false) {
        //       return Center(child: CircularProgressIndicator());
        //     } else if (false) {
        //       return Center(child: Text('Error: ${snapshot.error}'));
        //     } else {
        //       // final clientData = snapshot.data!;
        //       return
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Client Name'),
                    subtitle: Text('${venderSidetGetXController.getContactUsModel.name}'),
                  ),
                  ListTile(
                    title: Text('Email'),
                    subtitle: Text('${venderSidetGetXController.getContactUsModel.email}'),
                  ),
                  ListTile(
                    title: Text('Phone'),
                    subtitle: Text('${venderSidetGetXController.getContactUsModel.phoneNo}'),
                  ),
                  ListTile(
                    title: Text('WhatsApp'),
                    subtitle: Text('${venderSidetGetXController.getContactUsModel.whatsappNo}'),
                  ),
                ],
              ),
            ),
          ),
        )
        // }
        // },
        // ),
        );
  }
}
