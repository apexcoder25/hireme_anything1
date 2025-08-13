// // Create a new file: lib/data/api_services/vendor_docs_api.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class VendorDocsApi {
//   static const String baseUrl = 'https://stag-api.hireanything.com';

//   Future<bool> updateVendorDocsInfo(Map<String, dynamic> docsData) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/vendor/update-vendor-docs-info'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization':
//                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3N2ZhZGY0MTM2NmU2ZjMzMDMwMDFkYSIsImlhdCI6MTc1NDE0MDUwNiwiZXhwIjoxNzU0NzQ1MzA2fQ.EgQEldM6P0hw_jbvOtaOWpdRl-4_NJ-x--8qfTj4X94'
//         },
//         body: json.encode({"docs": docsData}),
//       );

//       if (response.statusCode == 200) {
//         print('Documents updated successfully');
//         print(response.body);
//         return true;
//       } else {
//         print('Failed to update document s: ${response.statusCode}');
//         print('Response body: ${response.body}');
//         return false;
//       }
//     } catch (e) {
//       print('Error updating vendor docs: $e');
//       return false;
//     }
//   }
// }
