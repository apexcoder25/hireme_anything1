import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hire_any_thing/views/searchNoTab.dart';

import '../navigation_bar.dart';
import '../utilities/constant.dart';

class HealthRecord extends StatefulWidget {
  const HealthRecord({super.key});

  @override
  State<HealthRecord> createState() => _HealthRecordState();
}

class _HealthRecordState extends State<HealthRecord> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          // bottomNavigationBar: Navi(),
          appBar: AppBar(
            centerTitle: true,
            // backgroundColor: Colors.transparent,
            // surfaceTintColor: Colors.transparent,
            forceMaterialTransparency: true,
            title: Text(
              "HealthRecord",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            leading: InkWell(
                onTap: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Navi(),
                    ),
                  );
                },
                child: Icon(Icons.arrow_back_ios_new_sharp)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: w / 1.35,
                          child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search,
                                      color: Colors.grey),
                                  hintText: "Mo",
                                  hintStyle: const TextStyle(fontSize: 14),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.grey)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.grey))))),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: kTextColor2.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Icon(
                            Icons.filter_alt_rounded,
                            color: Colors.white,
                            size: 32,
                          )),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(3),
                          height: h / 9,
                          width: w * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300, blurRadius: 3)
                              ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Color(0xffE7EEF1)),
                                child: Image.asset(
                                  "assets/images/bluedoc.png",
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Manish_Blood_Test_20241...",
                                    style: TextStyle(
                                        color: Color(0xff0B0B0B),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  Container(
                                    width: w / 1.5,
                                    // color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Prescription",
                                          style: TextStyle(
                                              color: Color(0xff686978),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          "2 Jan, 2024",
                                          style: TextStyle(
                                              color: Color(0xff686978),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
