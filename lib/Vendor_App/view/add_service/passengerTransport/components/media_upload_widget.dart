import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class MediaUploadWidget extends StatefulWidget {
  const MediaUploadWidget({super.key});

  @override
  State<MediaUploadWidget> createState() => _MediaUploadWidgetState();
}

class _MediaUploadWidgetState extends State<MediaUploadWidget> {
  List<String> mediaPaths = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          children: List.generate(mediaPaths.length, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(Icons.insert_drive_file, size: 40, color: Colors.grey),
                  ),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          mediaPaths.removeAt(index);
                        });
                      },
                      child: const Icon(Icons.cancel, color: Colors.redAccent, size: 20),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('Take a Photo'),
                    onTap: () async {
                      // Implement photo taking logic
                      setState(() {
                        mediaPaths.add('photo_${mediaPaths.length + 1}.jpg'); // Placeholder path
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Choose from Gallery'),
                    onTap: () async {
                      // Implement gallery selection logic
                      setState(() {
                        mediaPaths.add('media_${mediaPaths.length + 1}.jpg'); // Placeholder path
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.attach_file),
                    title: const Text('Choose File'),
                    onTap: () async {
                      // Implement file selection logic
                      setState(() {
                        mediaPaths.add('file_${mediaPaths.length + 1}'); // Placeholder path
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
          child: DottedBorder(
            color: Colors.black,
            strokeWidth: 2,
            dashPattern: const [5, 5],
            child: Container(
              height: 100,
              width: double.infinity,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload, color: Colors.grey, size: 30),
                    SizedBox(height: 8),
                    Text(
                      'Choose File',
                      style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'No file chosen',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}