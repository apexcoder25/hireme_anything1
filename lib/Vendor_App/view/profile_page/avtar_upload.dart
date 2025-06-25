import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AvtarUploadController extends GetxController {
  var uploadedUrl = ''.obs;
  final ImagePicker _picker = ImagePicker();
  final RxBool _isPicking = false.obs;

  /// Function to pick an image
  Future<void> pickImage() async {
    if (_isPicking.value) {
      print("Image picker is already active, ignoring request.");
      Get.snackbar("Error", "Image picker is already active, please try again.");
      return;
    }

    _isPicking.value = true;

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (image != null) {
        print("Image picked: ${image.path}");
        await uploadToCloudinary(image.path);
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
      if (e.toString().contains("already_active")) {
        Get.snackbar("Error", "Image picker is already active, please try again.");
      } else {
        Get.snackbar("Error", "Failed to pick image: $e");
      }
    } finally {
      _isPicking.value = false;
    }
  }

  /// Function to compress an image
  Future<File?> compressImage(String filePath) async {
    try {
      String extension = filePath.split('.').last.toLowerCase();

      if (!['jpg', 'jpeg', 'png'].contains(extension)) {
        print("Unsupported file format: $filePath");
        return File(filePath);
      }

      String outPath = filePath.replaceAll(RegExp(r'\.(jpg|jpeg|png)$'), '_compressed.jpg');

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        quality: 80,
        format: CompressFormat.jpeg,
      );

      if (compressedFile == null) {
        print("Image compression failed for: $filePath");
        return File(filePath);
      }

      print("Image compressed: ${compressedFile.path}");
      return File(compressedFile.path);
    } catch (e) {
      print("Error compressing image: $e");
      Get.snackbar("Error", "Failed to compress image.");
      return File(filePath);
    }
  }

  /// Function to upload an image to Cloudinary
  Future<void> uploadToCloudinary(String filePath) async {
    try {
      var compressedFile = await compressImage(filePath) ?? File(filePath);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.cloudinary.com/v1_1/dfzhndoza/image/upload'),
      );

      request.files.add(await http.MultipartFile.fromPath('file', compressedFile.path));
      request.fields['upload_preset'] = 'Vendor';
      request.fields['cloud_name'] = 'dfzhndoza';

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = json.decode(await response.stream.bytesToString());
        uploadedUrl.value = responseData['secure_url'];
        print("Cloudinary Upload Success: ${uploadedUrl.value}");
      } else {
        print('Upload failed with status: ${response.statusCode}');
        Get.snackbar("Error", "Failed to upload image to Cloudinary: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading to Cloudinary: $e");
      Get.snackbar("Error", "Failed to upload image: $e");
    }
  }
}