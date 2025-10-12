import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/utilities/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/document_controller.dart';

class DocumentUploadSection extends StatelessWidget {
  final bool isEditing;
  final DocumentController docController;

  const DocumentUploadSection({
    super.key,
    required this.isEditing,
    required this.docController,
  });

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Error", "Could not open file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.folder_open_outlined,
                    color: Colors.blue.shade600,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  "Legal Documents",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Obx(() => docController.uploadedDocumentUrls.isEmpty
                ? _buildEmptyDocumentsState()
                : _buildDocumentsList()),
            if (isEditing) ...[
              const SizedBox(height: 20),
              _buildUploadDocumentsButton(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyDocumentsState() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.description_outlined,
              size: 56,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            Text(
              "No Documents Available",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Upload your legal documents to complete your business profile",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentsList() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: List.generate(docController.uploadedDocumentUrls.length, (index) {
        final doc = docController.uploadedDocumentUrls[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Stack(
            children: [
              InkWell(
                onTap: () => _launchUrl(doc['url'] ?? ''),
                borderRadius: BorderRadius.circular(14),
                child: Padding(
                  padding: EdgeInsets.all(isEditing ? 36 : 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.insert_drive_file_outlined,
                        color: Colors.blue.shade600,
                        size: 28,
                      ),
                      const SizedBox(width: 14),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 160),
                        child: Text(
                          doc['fileName'] ?? 'Business Document',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isEditing)
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => docController.removeDocument(index),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildUploadDocumentsButton() {
    return Obx(() => GestureDetector(
      onTap: docController.isUploading.value ? null : docController.pickDocuments,
      child: DottedBorder(
        color: docController.isUploading.value ? Colors.grey : AppColors.btnColor,
        strokeWidth: 2,
        dashPattern: const [10, 5],
        borderType: BorderType.RRect,
        radius: const Radius.circular(14),
        child: Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: docController.isUploading.value 
                ? Colors.grey.withOpacity(0.05)
                : AppColors.btnColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: docController.isUploading.value
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.btnColor,
                        strokeWidth: 3,
                      ),
                     SizedBox(height: 12),
                      Text(
                        "Uploading Documents...",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.btnColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const Icon(
                        Icons.cloud_upload_outlined,
                        size: 40,
                        color: AppColors.btnColor,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Upload Legal Documents",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.btnColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "PDF, DOC, DOCX, PNG, JPG formats supported",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    ));
  }
}
