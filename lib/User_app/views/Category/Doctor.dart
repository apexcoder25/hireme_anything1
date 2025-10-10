import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/User_app/views/subCategoryPage/BloodCollectionDetail.dart';

import '../../../navigation_bar.dart';
import '../../../utilities/AppConstant.dart';
import '../../../utilities/constant.dart';
import 'HomeCare.dart';
class Doctor_Screen extends StatefulWidget {
  const Doctor_Screen({super.key});

  @override
  State<Doctor_Screen> createState() => _Doctor_ScreenState();
}

class _Doctor_ScreenState extends State<Doctor_Screen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        // surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,

        title: Text(
          "Health Worker",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const Navi(),
                ),
              );
            },
            child: Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 100 / 100,
        width: MediaQuery.of(context).size.width * 100 / 100,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
                width: MediaQuery.of(context).size.width * 100 / 100,
              ),

              

              SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Column(
                        children: [
                          Container(
                            height: h / 10.5,
                            width: w / 3.5,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                                child: InkWell(
                                  onTap: () {
                                    _showDialog(context);

                                  },
                                  child: Container(
                                      height: h / 13,
                                      width: w / 6,
                                      child: Image.asset(
                                        "assets/icons/medicine.png",
                                      )),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Medicines",
                              style: AppConstant.HomeCategori),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: w / 60,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BloodCollection_Detail()));
                          },
                          child: Container(
                            height: h / 10.5,
                            width: w / 3.5,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                                child: Container(
                                    height: h / 13,
                                    width: w / 6,
                                    child: Image.asset(
                                      "assets/icons/bloodsample.png",
                                    ))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Blood Collection", style: AppConstant.HomeCategori),
                      ],
                    ),
                    SizedBox(
                      width: w / 60,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeCare()));
                          },
                          child: Container(
                            height: h / 10.5,
                            width: w / 3.5,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                                child: Container(
                                    height: h / 13,
                                    width: w / 6,
                                    child: Image.asset(
                                      "assets/icons/patient.png",
                                    ))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Home care", style: AppConstant.HomeCategori),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _showDialog(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: Colors.white,
          title: Text(
            "Upload prescription",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Please upload a valid prescription from your doctor",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: w / 3.5,
                    height: h / 8,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _showDialogs(context);
                        },
                        child: Column(
                          children: [
                            Image.asset("assets/images/upload2.png"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Upload file",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: kindicatorColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: w / 3.5,
                    height: h / 8,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Image.asset("assets/images/camera2.png"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Take Photo",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: kindicatorColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                'Note: Always upload a clean version of your prescription for getting better result. ',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Max limit: 5mb'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showDialogs(BuildContext context) {
    final selectedValue = 'Info'.obs;

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Upload Health Records",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please upload of valid Health Records from your doctor",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
                SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset("assets/images/uploadsf.png")),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Manish_Blood_Test_20241...",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                    color: kindicatorColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Myself',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: w / 1.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Myself',
                              style: TextStyle(
                                  color: Color(0xff2B2B2B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(() => DropdownButton<String>(
                                value: selectedValue.value,
                                onChanged: (newValue) {
                                  selectedValue.value = newValue!;
                                },
                                items: <String>['Info', 'Warning', 'Error']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Type of record',
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    )),
                SizedBox(height: 15),
                Container(
                  height: 50,
                  width: w / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Report',
                          style: TextStyle(
                              color: Color(0xff2B2B2B),
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => DropdownButton<String>(
                            value: selectedValue.value,
                            onChanged: (newValue) {
                              selectedValue.value = newValue!;
                            },
                            items: <String>['Info', 'Warning', 'Error']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            SizedBox(height: 15),
            Container(
              height: 50,
              width: w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: kPrimaryColor,
              ),
              child: InkWell(
                onTap: () {},
                child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    )),
              ),
            ),
          ],
        );
      },
    );
  }
}
