// import 'package:flutter/material.dart';

// import '../../cutom_widgets/button.dart';
// import '../../uiltis/color.dart';

// class Assignboy extends StatefulWidget {
//   const Assignboy({super.key});

//   @override
//   State<Assignboy> createState() => _AssignboyState();
// }

// class _AssignboyState extends State<Assignboy> {
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: 5,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 13.0),
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: Material(
//                       elevation: 1,
//                       borderRadius: BorderRadius.circular(15),
//                       child: Container(
//                         width: w / 1,
//                         height: null, // Dynamic height
//                         decoration: BoxDecoration(
//                           color: colors.white,
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                             right: 15.0,
//                             top: 10,
//                             bottom: 8,
//                             left: 15,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Order #12315141541",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                   Text(
//                                     'price[index]',
//                                     style: TextStyle(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: h / 100,
//                               ),
//                               const Text(
//                                 "09 September 2023, 2:25 pm",
//                                 style: TextStyle(
//                                   color: colors.hintext_shop,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: h / 70,
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: w / 3,
//                                     child: const Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text("Rice"),
//                                         Text("Washing Powder"),
//                                         Text("Moog Dal"),
//                                         Text("Soap"),
//                                         Text("Aata"),
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     child: const Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(":  1 kg"),
//                                         Text(":  2 kg"),
//                                         Text(":  2 kg"),
//                                         Text(":  1 pac"),
//                                         Text(":  10 kg"),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: h / 50,
//                               ),
//                               Container(
//                                 width: w / 1,
//                                 height: h / 1000,
//                                 color: Colors.grey,
//                               ),
//                               SizedBox(
//                                 height: h / 100,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Button_widget(
//                                     buttontext: "Assign",
//                                     button_height: 20,
//                                     button_weight: 3,
//                                     onpressed: () {},
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
