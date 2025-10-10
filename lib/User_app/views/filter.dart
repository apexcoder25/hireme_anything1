import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:hire_any_thing/User_app/views/searchNoTab.dart';

import '../../utilities/constant.dart';
import 'cart_sort.dart';


class FliterPage extends StatefulWidget {
  const FliterPage({super.key});

  @override
  State<FliterPage> createState() => _FliterPageState();
}

// single choice value
int tag = 3;

// multiple choice value
List<String> tags = ['Education'];

// list of string options
List<String> options = [
  'GreenLab Biotech',
  'GreenLab',
  'AR Lab',
  'Biotech',
  'Lab',
  'Popular Lab',
  'Update Lab',
];



SfRangeValues _values = const SfRangeValues(0.3, 0.7);
SfRangeValues _values2 = const SfRangeValues(4.0, 8.0);
final usersMemoizer = C2ChoiceMemoizer<String>();

class _FliterPageState extends State<FliterPage> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    // RangeValues _values = RangeValues(0.3, 0.7);
    // double _startValue = 20.0;
    // double _endValue = 90.0;
    // RangeSlider(
    //   values: _values,
    //   onChanged: (RangeValues values) {
    //     setState(() {
    //       _values = values;
    //       _startValue = values.start;
    //       _endValue = values.end;
    //     });
    //   },
    // );
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Filter"),
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            },icon: Icon(Icons.clear)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: h,
              width: w,
              // color: Colors.red,
              child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Price",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SfRangeSlider(
                  min: 0.0,
                  max: 10.0,
                  activeColor:  kPrimaryColor,
                  inactiveColor: Color(0xffE3E3E3),
                  values: _values,
                  onChanged: (SfRangeValues newValues) {
                    setState(() {
                      _values = newValues;
                    });
                  },
                ),

                SizedBox(
                  height: 20,
                ),
                // Text(
                //   "Category",
                //   style: TextStyle(
                //     fontWeight: FontWeight.w200,
                //     fontSize: 20,
                //   ),
                // ),
                // ChipsChoice<String>.multiple(
                //   value: tags,
                //   onChanged: (val) => setState(() => tags = val),
                //   choiceItems: C2Choice.listFrom<String, String>(
                //     source: options,
                //     value: (i, v) => v,
                //     label: (i, v) => v,
                //     tooltip: (i, v) => v,
                //     style: (i, v) {
                //       if ([
                //         'Electrician',
                //         'Roofing',
                //         'Cleaning',
                //         'Plumbing',
                //         'Home Repair',
                //         'Pump Set',
                //
                //       ].contains(v)) {
                //         return C2ChipStyle.toned(
                //
                //           borderRadius: const BorderRadius.all(
                //             Radius.circular(20),
                //           ),
                //         );
                //       }
                //       return null;
                //     },
                //   ),
                //   choiceStyle: C2ChipStyle.filled(),
                //   wrapped: true,
                // ),

                SizedBox(height: 20),

                Text(
                  "Distance",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 20,
                  ),
                ),

                SizedBox(height: 10),

                SfRangeSlider(
                  min: 0.0,
                  max: 10.0,
                  values: _values2,
                  activeColor: kPrimaryColor,
                  inactiveColor: Color(0xffE3E3E3),

                  onChanged: (SfRangeValues newValues2) {
                    setState(() {
                      _values2 = newValues2;
                    });
                  },
                ),

                SizedBox(height: 20),
                Text(
                  "Rating",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.star,color: Color(0xffFE8C02),),
                    Icon(Icons.star,color: Color(0xffFE8C02),),
                    Icon(Icons.star,color: Color(0xffFE8C02),),
                    Icon(Icons.star,color: Color(0xffE1E1E1)),
                    Icon(Icons.star,color: Color(0xffE1E1E1)),
                  ],
                ),
                SizedBox(height: h/20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      // onTap: () {
                      //   Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (BuildContext context) =>
                      //       const CartShort(),
                      //     ),
                      //   );
                      // },
                      child: Container(
                        height: h * 0.05,
                        width: w * 0.36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: kPrimaryColor),
                          boxShadow: [
                            BoxShadow(
                              color: kTextColor2.withOpacity(0.5),
                              blurRadius: 3,
                              spreadRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Center(
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 13,
                                  // fontSize isPortrait ? 16 : 20,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const Searchontab(),
                          ),
                        );
                      },
                      child: Container(
                        height: h * 0.05,
                        width: w * 0.36,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: kTextColor2.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Center(
                            child: Text(
                              "Apply",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  // fontSize isPortrait ? 16 : 20,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
                    ),
                  ],
                ),




              ]),
            ),
          ),
        ));
  }
}
