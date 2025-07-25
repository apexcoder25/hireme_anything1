// faq_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../uiltis/color.dart';

class termscreen extends StatefulWidget {
  @override
  _termscreenState createState() => _termscreenState();
}

class _termscreenState extends State<termscreen> {
  List<Map<String, String>> faqList = [];

  @override
  void initState() {
    super.initState();
    termscreenlist();
  }

  Future<void> termscreenlist() async {
    final Uri url = Uri.parse('');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['result'] == 'true') {
        List<Map<String, String>> tempList = [];
        for (var faq in data['data']) {
          tempList.add({
            'title': faq['title'],
            'text': faq['text'],
          });
        }
        setState(() {
          faqList = tempList;
        });
      }
    }
  }

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
            color: colors.white,
          ),
        ),
        backgroundColor: colors.button_color,
        centerTitle: true,
        title: Text(
          'Term List Screen',
          style: TextStyle(color: colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      // body: faqList.isEmpty
      //     ? Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     :
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('title',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              ),
            );
          },
        ),
      ),
    );
  }
}
