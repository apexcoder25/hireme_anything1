import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_basic_getx_controller.dart';

import '../navigation_bar.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final text =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse nec nunc imperdiet mauris tincidunt ornare nec eget ipsum. In bibendum sapien imperdiet magna malesuada varius.";

  Map<int, bool> state = {};

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final UserBasicGetxController userBasicGetxController =
        Get.put(UserBasicGetxController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "FAQ",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
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
      body: SingleChildScrollView(
        child: Column(
            children: List.generate(
                userBasicGetxController
                    .getFaqModelsListList!.faqModelsList.length, (index) {
          return expentionTitle(
              "${userBasicGetxController.getFaqModelsListList!.faqModelsList[index].question}",
              "${userBasicGetxController.getFaqModelsListList!.faqModelsList[index].answer}");
        })

            // [
            //
            //   expentionTitle("How to send my package?",text),
            //   SizedBox(
            //     height: 8.0,
            //   ),
            //
            //   expentionTitle("Can i change pick up location?",text),
            //   SizedBox(
            //     height: 8.0,
            //   ),
            //   expentionTitle("How to Edit Profile ?",text),
            //   SizedBox(
            //     height: 8.0,
            //   ),
            //   expentionTitle("What does Lorem Ipsum mean ?",text),
            //   SizedBox(
            //     height: 8.0,
            //   ),
            //   expentionTitle("Can i send a fragile package?",text),
            //   SizedBox(
            //     height: 8.0,
            //   ),
            //
            // ],
            ),
      ),
    );
  }

  expentionTitle(title, des) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor:
            Colors.transparent, // Remove divider between the title and content
      ),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        color: Colors
            .blueAccent, // Background color for the title and trailing icon
        child: ExpansionTile(
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          onExpansionChanged: (bool expanded) {
            setState(() => isExpanded = expanded);
          },
          title: Text(
            "$title",
            style: TextStyle(
              color: Colors
                  .white, // White text color to contrast with the background
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            // Only the title part will have the background color; children remain unaffected
            Container(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  des.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
