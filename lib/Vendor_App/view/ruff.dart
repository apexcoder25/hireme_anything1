// import 'package:flutter/material.dart';

// class MyDropdownPage extends StatefulWidget {
//   @override
//   _MyDropdownPageState createState() => _MyDropdownPageState();
// }

// class _MyDropdownPageState extends State<MyDropdownPage> {
//   String selectedValue = 'Option 1'; // Initially selected value

//   List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dropdown Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Selected Option:',
//               style: TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 10),
//             DropdownButton<String>(
//               value: selectedValue,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedValue = newValue ?? dropdownItems[0];
//                 });
//               },
//               items: dropdownItems.map<DropdownMenuItem<String>>((String item) {
//                 return DropdownMenuItem<String>(
//                   value: item,
//                   child: Text(item),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
