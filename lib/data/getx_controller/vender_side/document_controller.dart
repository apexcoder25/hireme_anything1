import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DocumentController extends GetxController {
  var selectedDocuments = <String>[].obs; // Local file paths
  var uploadedDocumentUrls = <Map<String, String>>[].obs; // Cloudinary metadata
  var isUploading = false.obs;

  final String cloudinaryUrl = "https://api.cloudinary.com/v1_1/dfzhndoza/raw/upload";
  final String uploadPreset = "Vendor";

  Future<void> pickDocuments() async {
    if (isUploading.value) return;
    isUploading.value = true;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpg', 'jpeg'],
      );

      if (result != null && result.files.isNotEmpty) {
        for (var file in result.files) {
          if (file.path != null) {
            selectedDocuments.add(file.path!);
            await uploadDocument(File(file.path!), file.name);
          }
        }
      }
    } catch (e) {
      print("Error picking documents: $e");
      Get.snackbar("Error", "Failed to pick documents: $e");
    } finally {
      isUploading.value = false;
    }
  }

  Future<void> uploadDocument(File file, String fileName) async {
    try {
      isUploading(true);
      var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl))
        ..fields['upload_preset'] = uploadPreset
        ..fields['resource_type'] = 'raw'
        ..files.add(await http.MultipartFile.fromPath('file', file.path));

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseData);

      print("Cloudinary Response: $jsonResponse");

      if (response.statusCode == 200) {
        uploadedDocumentUrls.add({
          'url': jsonResponse['secure_url'],
          'fileName': fileName,
          'uploadedName': jsonResponse['public_id'].split('/').last,
        });
        print("Document uploaded: ${jsonResponse['secure_url']}");
      } else {
        Get.snackbar("Upload Failed", "Error uploading document: ${jsonResponse['error']}");
      }
    } catch (e) {
      print("Error uploading document: $e");
      Get.snackbar("Error", "Failed to upload document: $e");
    } finally {
      isUploading(false);
    }
  }

  void removeDocument(int index) {
    if (index >= 0 && index < selectedDocuments.length) {
      selectedDocuments.removeAt(index);
    }
    if (index >= 0 && index < uploadedDocumentUrls.length) {
      uploadedDocumentUrls.removeAt(index);
    }
  }

  void setDocumentsFromProfile(List<dynamic> documents) {
    uploadedDocumentUrls.clear();
    selectedDocuments.clear();
    for (var doc in documents) {
      uploadedDocumentUrls.add({
        'url': doc['url']?.toString() ?? '',
        'fileName': doc['fileName']?.toString() ?? '',
        'uploadedName': doc['uploadedName']?.toString() ?? '',
      });
    }
  }
}