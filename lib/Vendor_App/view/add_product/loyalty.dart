// import 'package:flutter/material.dart';

// void main() {
//   runApp(Lloy());
// }

// class LoyaltyCard {
//   String title;
//   String description;
//   int pointsPer100Rupees;

//   LoyaltyCard(
//       {required this.title,
//       required this.description,
//       required this.pointsPer100Rupees});
// }

// class Lloy extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoyaltyCardForm(),
//     );
//   }
// }

// class LoyaltyCardForm extends StatefulWidget {
//   @override
//   _LoyaltyCardFormState createState() => _LoyaltyCardFormState();
// }

// class _LoyaltyCardFormState extends State<LoyaltyCardForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   LoyaltyCard _loyaltyCard =
//       LoyaltyCard(title: '', description: '', pointsPer100Rupees: 0);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Loyalty Card Form'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Title'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a title';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _loyaltyCard.title = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Description'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a description';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _loyaltyCard.description = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Points per 100 Rupees'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter points per 100 Rupees';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _loyaltyCard.pointsPer100Rupees = int.parse(value!);
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 child: Text('Submit'),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: _updateForm,
//                 child: Text('Update'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       // Perform actions with the loyalty card data (e.g., send to server, update local storage, etc.)
//       // For now, we'll just print the data.
//       print('Title: ${_loyaltyCard.title}');
//       print('Description: ${_loyaltyCard.description}');
//       print('Points per 100 Rupees: ${_loyaltyCard.pointsPer100Rupees}');
//     }
//   }

//   void _updateForm() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       // Perform actions to update the loyalty card data
//       // For now, we'll just print the updated data.
//       print('Updated Title: ${_loyaltyCard.title}');
//       print('Updated Description: ${_loyaltyCard.description}');
//       print(
//           'Updated Points per 100 Rupees: ${_loyaltyCard.pointsPer100Rupees}');
//     }
//   }
// }
