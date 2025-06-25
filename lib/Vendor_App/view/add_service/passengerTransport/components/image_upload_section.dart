// components/image_upload_section.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/upload_image.dart';

class ImageUploadSection extends StatefulWidget {
  const ImageUploadSection({super.key});

  @override
  State<ImageUploadSection> createState() => _ImageUploadSectionState();
}

class _ImageUploadSectionState extends State<ImageUploadSection> {
  @override
  Widget build(BuildContext context) {
    final imageController = Get.find<ImageController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Service Images *", style: TextStyle(color: Colors.black87, fontSize: 16)),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Obx(() => Wrap(
                  children: List.generate(
                    imageController.selectedImages.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Image.file(
                            File(imageController.selectedImages[index]),
                            fit: BoxFit.cover,
                            height: 60,
                            width: 60,
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: () => imageController.removeImage(index),
                              child: const Icon(Icons.close, color: Colors.redAccent),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera),
                    title: const Text('Take a Photo'),
                    onTap: () {
                      imageController.pickImages(true);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Choose from Gallery'),
                    onTap: () {
                      imageController.pickImages(false);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
          child: DottedBorder(
            color: Colors.black,
            strokeWidth: 1,
            dashPattern: const [5, 5],
            child: Container(
              height: 150,
              width: double.infinity,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload_outlined, size: 40, color: Colors.grey),
                    Text(
                      "Click to upload or drag and drop PNG, JPG (MAX. 800x400px)",
                      style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}