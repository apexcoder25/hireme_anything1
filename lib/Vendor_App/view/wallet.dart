// import 'package:flutter/material.dart';

// import '../uiltis/color.dart';

// class Wallet extends StatefulWidget {
//   const Wallet({super.key});

//   @override
//   State<Wallet> createState() => _WalletState();
// }

// class _WalletState extends State<Wallet> {
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: colors.scaffold_background_color,
//       appBar: AppBar(
//         backgroundColor: colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text("Wallet",
//             style: TextStyle(
//                 fontSize: 20,
//                 color: colors.black,
//                 fontWeight: FontWeight.bold)),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Material(
//                 elevation: 2,
//                 borderRadius: BorderRadius.circular(10),
//                 child: Container(
//                   height: h / 7,
//                   width: w / 1,
//                   decoration: BoxDecoration(
//                       color: colors.button_color,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Row(children: [
//                     SizedBox(
//                       width: w / 25,
//                     ),
//                     const Icon(
//                       Icons.account_balance_wallet_rounded,
//                       color: colors.white,
//                       size: 60,
//                     ),
//                     SizedBox(
//                       width: w / 35,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: h / 25,
//                         ),
//                         const Text(
//                           "Wallet Amount",
//                           style: TextStyle(
//                             color: colors.white,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         const Text(
//                           "\u{20b9}1000.50",
//                           style: TextStyle(
//                               color: colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 27),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       width: w / 10,
//                     ),
//                     Row(
//                       children: [
//                         GestureDetector(
//                             onTap: () {},
//                             child: const Text(
//                               "Withdraw ",
//                               style: TextStyle(
//                                   color: colors.white,
//                                   fontWeight: FontWeight.w300),
//                             )),
//                         GestureDetector(
//                             onTap: () {},
//                             child: const Icon(
//                               Icons.keyboard_arrow_down_outlined,
//                               color: colors.white,
//                             )),
//                       ],
//                     )
//                   ]),
//                 ),
//               ),
//               SizedBox(
//                 height: h / 30,
//               ),
//               GridView.builder(
//                 shrinkWrap: true,
//                 itemCount: 4,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     childAspectRatio: (15 / 8),
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 8,
//                     mainAxisSpacing: 8),
//                 itemBuilder: (BuildContext context, int index) {
//                   return Material(
//                     elevation: 2,
//                     borderRadius: BorderRadius.circular(7),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: colors.white,
//                           borderRadius: BorderRadius.circular(7)),
//                       child: Column(
//                         children: [
//                           SizedBox(height: h / 50),
//                           Text(
//                             price[index],
//                             style: const TextStyle(
//                                 color: colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20),
//                           ),
//                           SizedBox(height: h / 50),
//                           Text(
//                             price_name[index],
//                             style: const TextStyle(
//                                 color: colors.black,
//                                 fontWeight: FontWeight.w300),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(
//                 height: h / 30,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Transcation",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: const Text(
//                       "viewall",
//                       style: TextStyle(color: colors.button_color),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: h / 60,
//               ),
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: 5,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 13.0),
//                     child: Material(
//                       borderRadius: BorderRadius.circular(10),
//                       elevation: 2,
//                       child: Container(
//                         height: h / 12,
//                         width: w / 1,
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 13.0, top: 10, right: 15, bottom: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               SizedBox(
//                                 width: w / 30,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 2),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(tran[index],
//                                         style: const TextStyle(fontSize: 15)),
//                                     SizedBox(
//                                       height: h / 200,
//                                     ),
//                                     Text("Order id:- " + order_id[index]),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: w / 3.5,
//                               ),
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     price_tra[index],
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16),
//                                   ),
//                                   Text(date[index],
//                                       style: const TextStyle(fontSize: 10)),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   List tran = [
//     "Received from",
//     "withdraw",
//     "Received from",
//     "Received from",
//     "Received from",
//   ];
//   List price_tra = [
//     "\u{20b9} 500",
//     "\u{20b9} 400",
//     "\u{20b9} 200",
//     "\u{20b9} 200",
//     "\u{20b9} 200",
//   ];
//   List date = [
//     "19-09-2023",
//     "18-09-2023",
//     "17-09-2023",
//     "16-09-2023",
//     "15-09-2023",
//   ];
//   List order_id = [
//     "1254",
//     "5632",
//     "6589",
//     "5874",
//     "1793",
//   ];
//   List price = [
//     "\u{20b9} 0.00",
//     "\u{20b9} 1000",
//     "\u{20b9} 900",
//     "\u{20b9} 10000",
//   ];
//   List price_name = [
//     "Pending withdraw",
//     "withdraw",
//     "Cash Collection",
//     "Total earnings",
//   ];
// }
