import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/avtar_upload.dart';
import 'package:image_picker/image_picker.dart';

class EditableAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isEditing;
  final Function(String) onImagePicked;

   EditableAvatar({
    required this.imageUrl,
    required this.isEditing,
    required this.onImagePicked,
    super.key,
  });

   final AvtarUploadController imageController = Get.put(AvtarUploadController());

  // Flag to prevent multiple simultaneous image picker calls
  final RxBool _isPicking = false.obs;

  Future<void> _pickImage() async {
    // Prevent multiple picker calls
    if (_isPicking.value) {
      print("Image picker is already active, ignoring request.");
      return;
    }

    _isPicking.value = true;

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );

      if (image != null) {
        print("Image picked: ${image.path}");
        await imageController.uploadToCloudinary(image.path);
        if (imageController.uploadedUrl.isNotEmpty) {
          print("Uploaded URL: ${imageController.uploadedUrl.value}");
          onImagePicked(imageController.uploadedUrl.value);
        } else {
          print("Failed to upload image to Cloudinary.");
          Get.snackbar("Error", "Failed to upload image.");
        }
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: isEditing ? _pickImage : null,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl)
                : const NetworkImage(
                    "https://static.vecteezy.com/system/resources/previews/012/850/918/non_2x/line-icon-for-avtar-vector.jpg",
                  ),
          ),
        ),
        if (isEditing)
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.edit,
                color: Colors.blue,
                size: 18,
              ),
            ),
          ),
      ],
    );
  }
}