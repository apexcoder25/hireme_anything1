import 'package:flutter/material.dart';

import '../cutom_widgets/button.dart';
import '../uiltis/color.dart';

class Add_product extends StatefulWidget {
  const Add_product({super.key});

  @override
  State<Add_product> createState() => _Add_productState();
}

class _Add_productState extends State<Add_product> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colors.scaffold_background_color,
      appBar: AppBar(
        backgroundColor: colors.button_color,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: colors.white,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text("Add Product",
            style: TextStyle(
                fontSize: 20,
                color: colors.white,
                fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Radio(
                            activeColor: colors.button_color,
                            value: "Phone",
                            groupValue: button,
                            onChanged: (value) {
                              setState(() {
                                q = 0;
                                button = value.toString();
                              });
                            }),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              q = 0;
                              button = "Phone";
                            });
                          },
                          child: Text("Existing Product",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: q == 0
                                      ? colors.button_color
                                      : colors.hinttext)),
                        ),
                        Radio(
                            activeColor: colors.button_color,
                            value: "Recruiter",
                            groupValue: button,
                            onChanged: (value) {
                              setState(() {
                                q = 1;
                                button = value.toString();
                              });
                            }),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              q = 1;
                              button = "Recruiter";
                            });
                          },
                          child: Text(
                            "New Product",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: q == 1
                                    ? colors.button_color
                                    : colors.hinttext),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: h / 70,
                ),
                e == 1
                    ? Center(
                        child: Material(
                          elevation: 2,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            height: h / 5,
                            width: w / 1.5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text("upload file"),
                            ),
                          ),
                        ),
                      )
                    : Text(""),
                e == 1
                    ? SizedBox(
                        height: h / 2.3,
                      )
                    : Text(""),
                Button_widget(
                  buttontext: "Done",
                  button_height: 20,
                  button_weight: 1,
                  onpressed: () {},
                ),
                SizedBox(
                  height: h / 30,
                ),
              ],
            )),
      ),
    );
  }

  String upload = 'one';
  int e = 0;
  String button = 'Phone';
  int q = 0;
}
