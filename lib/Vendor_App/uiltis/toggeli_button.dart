// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Stock Status Toggle'),
//         ),
//         body: StockStatusToggle(),
//       ),
//     );
//   }
// }

// class StockStatusToggle extends StatefulWidget {
//   @override
//   _StockStatusToggleState createState() => _StockStatusToggleState();
// }

// class _StockStatusToggleState extends State<StockStatusToggle> {
//   bool isInStock = true;

//   void toggleStockStatus() {
//     setState(() {
//       isInStock = !isInStock;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             isInStock ? 'In Stock' : 'Out of Stock',
//             style: TextStyle(fontSize: 24),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: toggleStockStatus,
//             child: Text('Toggle Stock Status'),
//           ),
//         ],
//       ),
//     );
//   }
// }
