import 'package:flutter/material.dart';
import 'package:hire_any_thing/User_app/views/profile.dart';
import '../../navigation_bar.dart';
import '../../utilities/constant.dart';

class address extends StatefulWidget {
  const address({Key? key}) : super(key: key);

  @override
  State<address> createState() => _addressState();
}

class _addressState extends State<address> {
  String? dropdownValueState;
  String? dropdownValueCountry;
  int? selectedRadio;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Address",
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
                    'Address Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff686978),
                    ),
                  ),
                ),
              ),
              RadioListTile(
                selectedTileColor: kPrimaryColor,
                activeColor: kPrimaryColor,
                title: Text('Work'),
                value: 1,
                groupValue: selectedRadio,
                onChanged: (int? value) {
                  setState(() {
                    selectedRadio = value;
                  });
                },
              ),
              RadioListTile(
                selectedTileColor: kPrimaryColor,
                activeColor: kPrimaryColor,
                title: Text('Home'),
                value: 2,
                groupValue: selectedRadio,
                onChanged: (int? value) {
                  setState(() {
                    selectedRadio = value;
                  });
                },
              ),
              SizedBox(height: h / 30),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Address',
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
                    'City',
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
                    'State',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select State',
                        style: TextStyle(
                          color: Color(0xff2B2B2B),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor: Colors.white,
                          value: dropdownValueState,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValueState = newValue;
                            });
                          },
                          icon: Icon(Icons.keyboard_arrow_down),
                          items: <String>['MP', 'UP', 'Goa']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: h / 50),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Country',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Country',
                        style: TextStyle(
                          color: Color(0xff2B2B2B),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor: Colors.white,
                          value: dropdownValueCountry,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValueCountry = newValue;
                            });
                          },
                          icon: Icon(Icons.keyboard_arrow_down),
                          items: <String>['India', 'UK', 'Himachal']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
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
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const Navi(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                       color: Colors.white,
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
