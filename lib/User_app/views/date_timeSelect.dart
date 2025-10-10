import 'package:flutter/material.dart';
import 'package:hire_any_thing/payment/Createorder.dart';
import 'package:hire_any_thing/utilities/constant.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intl/intl.dart';

import '../../navigation_bar.dart';
import '../../payment/Address.dart';

class DateShow extends StatefulWidget {
  const DateShow({Key? key}) : super(key: key);

  @override
  State<DateShow> createState() => _DateShowState();
}

class _DateShowState extends State<DateShow> {
  late DateTime selectedDate;
  String selectedTime = '';
  List<String> timeList = [
    '12:00 PM', '12:30 PM', '01:00 PM', '01:30 PM',
    '02:00 PM', '02:30 PM', '03:00 PM', '03:30 PM',
    '04:00 PM', '04:30 PM', '05:00 PM', '05:30 PM',
    '06:00 PM', '06:30 PM', '07:00 PM', '07:30 PM',
    '08:00 PM', '08:30 PM', '09:00 PM', '09:30 PM',
    '10:00 PM', '10:30 PM', '11:00 PM', '11:30 PM', '12:00 AM'
  ];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  void selectTime(String time) {
    setState(() {
      selectedTime = time;
    });
  }

  bool _isTimePassed(String timeString, DateTime selectedDatePass) {
    DateFormat format = DateFormat('hh:mm a');  // 12-hour format with AM/PM
    DateTime inputTime = format.parse(timeString);

    // Adjust the input time to today's date
    inputTime = DateTime(
      selectedDatePass.year, selectedDatePass.month, selectedDatePass.day,
      inputTime.hour, inputTime.minute,
    );

    // Handle midnight ('12:00 AM')
    if (timeString == '12:00 AM') {
      inputTime = inputTime.add(const Duration(days: 1));
    }

    return inputTime.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Select Date",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) => const Navi()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            _buildAddressSection(context),
            const SizedBox(height: 20),
            const Text(
              "When would you like your service?",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildDatePicker(),
            _buildTimeSelection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildAddressSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Address", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kPrimaryColor)),
                Text("Type: Home", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
              ],
            ),
            const SizedBox(height: 10),
            const Text("123, Main Street Indore 453555", style: TextStyle(fontSize: 14, color: Colors.black87)),
            const SizedBox(height: 18),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Address()));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 160,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 2, blurRadius: 1)],
                  ),
                  child: const Text("Edit", style: TextStyle(color: kwhiteColor, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 3)],
        ),
        child: DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: kPrimaryColor,
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            setState(() {
              selectedDate = date;
            });
          },
        ),
      ),
    );
  }

  Widget _buildTimeSelection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        children: List.generate(timeList.length, (index) {
          String time = timeList[index];
          bool isPassed = _isTimePassed(time, selectedDate);

          return GestureDetector(
            onTap: isPassed ? null : () => selectTime(time),
            child: Container(
              margin: const EdgeInsets.all(5),
              alignment: Alignment.center,
              height: 40,
              width: 90,
              decoration: BoxDecoration(
                color: selectedTime == time ? kPrimaryColor : kwhiteColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Text(
                time,
                style: TextStyle(color: isPassed ? Colors.grey:(selectedTime==time)?Colors.white : Colors.black),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 160,
            decoration: const BoxDecoration(color: kwhiteColor),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("\$320", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("View Details", style: TextStyle(fontSize: 12, color: kPrimaryColor)),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (selectedTime.isNotEmpty) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CreateOrder(
                    selectedDate: selectedDate,
                    selectedTime: selectedTime,
                  ),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text("Please Select Time"),
                  ),
                );
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 60,
              width: 160,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: const Text(
                "Create Order",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: kwhiteColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
