import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/api_service/api_service_user_side.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_basic_getx_controller.dart';
import 'package:hire_any_thing/global_file.dart';

import '../../navigation_bar.dart';
import '../../utilities/constant.dart';

class EnquiryFormActivity extends StatefulWidget {
  const EnquiryFormActivity({super.key});

  @override
  State<EnquiryFormActivity> createState() => _EnquiryFormActivityState();
}

class _EnquiryFormActivityState extends State<EnquiryFormActivity> {

  TextEditingController nameController= TextEditingController();
  TextEditingController contactController= TextEditingController();
  TextEditingController emailIdController= TextEditingController();
  TextEditingController desController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final UserBasicGetxController userBasicGetxController = Get.put(UserBasicGetxController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Enquiry Form",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Full name',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff686978),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h / 90),
              Container(
                height: 45,
                width: w / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Color(0xffD8E0F1)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter here',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: h / 50),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(

                    'Contact no',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff686978),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h / 90),
              Container(
                height: 45,
                width: w / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Color(0xffD8E0F1)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: contactController,
                    decoration: InputDecoration(
                      hintText: 'Enter here',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: h / 50),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email id',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff686978),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h / 90),

              Container(
                height: 45,
                width: w / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Color(0xffD8E0F1)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: emailIdController,
                    decoration: InputDecoration(
                      hintText: 'Enter here',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: h / 50),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(

                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff686978),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h / 90),
              Container(
                height: 150,
                width: w / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Color(0xffD8E0F1)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: desController,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: 'Enter here',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: h / 20),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                height: 50,
                width: w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: kPrimaryColor,
                ),
                child: InkWell(
                  onTap: () {

                    Map<String,dynamic> requestedData={
                      "name":"${nameController.text.trim()}",
                      "contact_no":"${contactController.text.trim()}",
                      "email":"${emailIdController.text.trim()}",
                      "description":"${desController.text.trim()}"
                    };

                    Future.microtask(() =>apiServiceUserSide.addEnquiry(requestedData));

                  },
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
