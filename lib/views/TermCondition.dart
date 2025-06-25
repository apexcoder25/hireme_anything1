import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_basic_getx_controller.dart';
import 'package:hire_any_thing/views/Home.dart';
import '../navigation_bar.dart';
import '../utilities/constant.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final UserBasicGetxController userBasicGetxController =
        Get.put(UserBasicGetxController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text(
          "${userBasicGetxController.commenTermsPrivacyAboutusModel!.title ?? ""}",
          style: TextStyle(color: Colors.white, fontSize: w / 18),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: kPrimaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: h / 50),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(w / 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: h / 20),
                      buildTermsAndConditions(
                        '${userBasicGetxController.commenTermsPrivacyAboutusModel!.description ?? ""}',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTermsAndConditions(String text) {
    return Expanded(
      child: SingleChildScrollView(
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}
