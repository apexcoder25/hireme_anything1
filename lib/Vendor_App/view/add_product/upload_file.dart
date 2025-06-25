import 'dart:io';

import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/view/Navagation_bar.dart';
import 'package:csv/csv.dart'; // Import the csv package
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:open_file/open_file.dart';

class FileUploadPage extends StatefulWidget {
  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  File? csv;
  bool isUploading = false;
  List<List<dynamic>> csvData = [];

  Future<void> updateImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      PlatformFile pickedFile = result.files.single;

      if (pickedFile.extension == 'csv') {
        setState(() {
          csv = File(pickedFile.path!);
        });

        await loadCsvData(csv!);
      } else {
        print("Invalid file type selected");
      }
    } else {
      print("No file selected");
    }
  }

  Future<void> loadCsvData(File file) async {
    String csvString = await file.readAsString();
    List<List<dynamic>> rowsAsListOfValues =
        CsvToListConverter().convert(csvString);

    setState(() {
      csvData = rowsAsListOfValues;
    });
  }

  Future<void> _uploadFile({File? document}) async {
    print(document!.path);
    if (document == null) {
      print("No file selected for upload");
      return;
    }

    setState(() {
      isUploading = true;
    });

    try {
      print('Uploading file...');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/product_to_csv"),
      );
      request.files.add(await http.MultipartFile.fromPath(
        'images',
        document.path,
        contentType: MediaType('text', 'csv'),
      ));

      http.StreamedResponse response = await request.send();
      print(response.stream);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(' csv Upload successfully'),
            duration: Duration(seconds: 2), // Adjust the duration as needed
            backgroundColor: Colors.green,
          ),
        );
        print('File uploaded successfully');
        OpenFile.open(document.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(' Something  Error File is not upload'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
        print('File upload failed with status ${response.statusCode}');
        print('Response body: ${await response.stream.bytesToString()}');
      }

      print('File analysis completed.');
    } catch (e, stackTrace) {
      print("Failed to upload file: $e");
      print("Stack trace: $stackTrace");
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.button_color,
        title: Text(
          "Upload CSV File",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            SizedBox(
                height: 130,
                child: GestureDetector(
                    onTap: () {
                      updateImage();
                    },
                    child: Image.asset("assets/image/csvvv.png"))),
            SizedBox(height: 30),
            if (isUploading) CircularProgressIndicator(),
            if (csvData.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: csvData[0]
                      .map((header) =>
                          DataColumn(label: Text(header.toString())))
                      .toList(),
                  rows: csvData
                      .skip(1)
                      .map(
                        (row) => DataRow(
                          cells: row
                              .map((cell) => DataCell(Text(cell.toString())))
                              .toList(),
                        ),
                      )
                      .toList(),
                ),
              ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await _uploadFile(document: csv);

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Nav_bar(),
                    ));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (csv == null) {
                      return Colors.grey;
                    }
                    return Colors.green;
                  },
                ),
              ),
              child: Text('Upload CSV File'),
            ),
          ],
        ),
      ),
    );
  }
}
