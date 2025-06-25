// import 'dart:convert';
// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:salon_hub_beautician/constant/api_url.dart';
// import 'package:path/path.dart' as path;

// class FileUploadPage extends StatefulWidget {
//   @override
//   _FileUploadPageState createState() => _FileUploadPageState();
// }

// class _FileUploadPageState extends State<FileUploadPage> {
//   File? _file;
//   String _uploadResponse = '';
//   String? _uploadedFileLink;

//   File? image;

//   File? pdf;

//   Future<String> updateImage() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: [
//         'jpg',
//         'jpeg',
//         'png',
//         'pdf',
//         'doc',
//         'docx',
//         'xls',
//         'xlsx',
//         'csv',
//       ],
//     );

//     if (result != null) {
//       PlatformFile pickedFile = result.files.single;

//       if (pickedFile.extension == 'jpg' ||
//           pickedFile.extension == 'jpeg' ||
//           pickedFile.extension == 'png' ||
//           pickedFile.extension == 'gif' ||
//           pickedFile.extension == 'pdf' ||
//           pickedFile.extension == 'doc' ||
//           pickedFile.extension == 'docx' ||
//           pickedFile.extension == 'xls' ||
//           pickedFile.extension == 'xlsx' ||
//           pickedFile.extension == 'csv') {
//         pdf = File(pickedFile.path!);
//         return "Pdf"; // Image was selected
//         // Video was selected
//       }
//     }
//     print("No supported file type selected");
//     return "";
//   }

//   _uploadFile({
//     File? document,
//   }) async {
//     var uri =
//         Uri.parse(ApiUrl.baseUrl+ApiUrl.productToCsvUrl);
//     var request = http.MultipartRequest('POST', uri);
//     print(document.toString() + "this is audio");

//     if (document != null) {
//       print('--------------------$document');
//       var stream2 = http.ByteStream(document.openRead());
//       var length2 = await document.length();
//       var multipartFile2 = http.MultipartFile(
//         'images',
//         stream2,
//         length2,
//         filename: path.basename(document.path),
//         contentType: MediaType('image', 'csv'),
//       );
//       request.files.add(multipartFile2);
//     }

//     try {
//       var response = await request.send();

//       var responseString = await response.stream.bytesToString();
//       var jsonResponse = json.decode(responseString);
//       print(jsonResponse);
//       if (response.statusCode == 200) {
//         return "done";
//       } else {
//         print("Failed to update profile. Status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Failed to update profile: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 updateImage();
//               },
//               child: Text('Select File'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 var res = await _uploadFile(document: pdf);

//                 if (res.toString() == "done") {
//                   print("doneeee");
//                 }
//               },
//               child: Text('Upload File'),
//             ),
//             if (_file != null) Text('File Path: ${_file!.path}'),
//             Text(_uploadResponse),
//             if (_uploadedFileLink != null)
//               Text('Uploaded File Link: $_uploadedFileLink'),
//           ],
//         ),
//       ),
//     );
//   }
// }
