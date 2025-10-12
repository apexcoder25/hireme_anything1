import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  var selectedImages = <String>[].obs; // Local paths for additional images
  var uploadedUrls = <String>[].obs; // URLs for additional images
  var vendorImage = ''.obs; // Single URL for vendor image
  var vehicleImages = <String>[].obs; // URLs for vehicle images
  final ImagePicker _picker = ImagePicker();
  final RxBool _isPicking = false.obs;

  @override
  void onInit() {
    super.onInit();
    clearAll();
  }

  void clearAll() {
    selectedImages.clear();
    uploadedUrls.clear();
    vendorImage.value = '';
    vehicleImages.clear();
  }

  void setVendorImage(String url) {
    vendorImage.value = url;
  }

  void setVehicleImages(List<String> urls) {
    vehicleImages.assignAll(urls);
  }

  Future<void> pickVendorImage(bool fromCamera) async {
    if (_isPicking.value) return;
    _isPicking.value = true;
    try {
      final source = fromCamera ? ImageSource.camera : ImageSource.gallery;
      final image = await _picker.pickImage(source: source, imageQuality: 50);
      if (image != null) {
        final url = await uploadToCloudinary(image.path);
        if (url != null) {
          vendorImage.value = url;
        }
      }
    } catch (e) {
      print("Error picking vendor image: $e");
      Get.snackbar("Error", "Failed to pick image: $e");
    } finally {
      _isPicking.value = false;
    }
  }

  Future<void> pickVehicleImages(bool fromCamera) async {
    if (_isPicking.value) return;
    _isPicking.value = true;
    try {
      if (fromCamera) {
        final image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
        if (image != null) {
          final url = await uploadToCloudinary(image.path);
          if (url != null) {
            vehicleImages.add(url);
          }
        }
      } else {
        final pickedFiles = await _picker.pickMultiImage(imageQuality: 50);
        if (pickedFiles != null) {
          for (var file in pickedFiles) {
            final url = await uploadToCloudinary(file.path);
            if (url != null) {
              vehicleImages.add(url);
            }
          }
        }
      }
    } catch (e) {
      print("Error picking vehicle images: $e");
      Get.snackbar("Error", "Failed to pick images: $e");
    } finally {
      _isPicking.value = false;
    }
  }

  Future<void> pickImages(bool fromCamera) async {
    if (_isPicking.value) return;
    _isPicking.value = true;
    try {
      if (fromCamera) {
        final image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
        if (image != null) {
          selectedImages.add(image.path);
          final url = await uploadToCloudinary(image.path);
          if (url != null) {
            uploadedUrls.add(url);
          }
        }
      } else {
        final pickedFiles = await _picker.pickMultiImage(imageQuality: 50);
        if (pickedFiles != null) {
          for (var file in pickedFiles) {
            selectedImages.add(file.path);
            final url = await uploadToCloudinary(file.path);
            if (url != null) {
              uploadedUrls.add(url);
            }
          }
        }
      }
    } catch (e) {
      print("Error picking additional images: $e");
      Get.snackbar("Error", "Failed to pick images: $e");
    } finally {
      _isPicking.value = false;
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
      if (index < uploadedUrls.length) {
        uploadedUrls.removeAt(index);
      }
    }
  }

  void removeVehicleImage(int index) {
    if (index >= 0 && index < vehicleImages.length) {
      vehicleImages.removeAt(index);
    }
  }

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

      return compressedFile != null ? File(compressedFile.path) : null;
    } catch (e) {
      print("Error compressing image: $e");
      return File(filePath);
    }
  }

  Future<String?> uploadToCloudinary(String filePath) async {
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
        final url = responseData['secure_url'];
        print("Cloudinary Upload Success: $url");
        return url;
      } else {
        print('Upload failed with status: ${response.statusCode}');
        Get.snackbar("Error", "Failed to upload image: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error uploading to Cloudinary: $e");
      Get.snackbar("Error", "Failed to upload image: $e");
      return null;
    }
  }
}