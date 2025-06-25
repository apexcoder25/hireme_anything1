import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/upload_image.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/drawer.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/edit_avtar.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/document_controller.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/profile_controller.dart';
import 'package:hire_any_thing/data/models/vender_side_model/profile_model.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final apiService = Get.put(ApiServiceVenderSide(), tag: 'apiService');
  late final ProfileController controller;
  final ImageController imgcntroller = Get.put(ImageController(), tag: 'imageController');
  final DocumentController docController = Get.put(DocumentController(), tag: 'documentController');
  bool isEditing = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController cityNameController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController countryNameController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProfileController(apiService: apiService), tag: 'profileController');
    ever(controller.profile, (ProfileModel? profile) {
      if (profile != null) {
        print("Profile Data Loaded: ${profile.toJson()}");
        nameController.text = profile.name;
        emailController.text = profile.email;
        mobileNoController.text = profile.mobileNo;
        countryCodeController.text = profile.countryCode;
        companyNameController.text = profile.companyName;
        cityNameController.text = profile.cityName;
        streetNameController.text = profile.streetName;
        countryNameController.text = profile.countryName;
        pincodeController.text = profile.pincode;
        genderController.text = profile.gender;
        descriptionController.text = profile.description;
        docController.setDocumentsFromProfile(profile.legalDocuments);
        imgcntroller.setVendorImage(profile.vendorImage);
        imgcntroller.setVehicleImages(profile.vehicleImages);
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileNoController.dispose();
    countryCodeController.dispose();
    companyNameController.dispose();
    cityNameController.dispose();
    streetNameController.dispose();
    countryNameController.dispose();
    pincodeController.dispose();
    genderController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

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
    return Scaffold(
      backgroundColor: colors.scaffold_background_color,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: "Drawer",
              barrierColor: Colors.black.withOpacity(0.5),
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (context, anim1, anim2) {
                return const CustomDrawer();
              },
              transitionBuilder: (context, anim1, anim2, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  ).animate(anim1),
                  child: child,
                );
              },
            );
          },
          icon: const Icon(
            Icons.menu,
            color: colors.white,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.profile.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("No profile data found!", style: TextStyle(color: Colors.red, fontSize: 18)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.fetchProfile,
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }
        var profile = controller.profile.value!;
        print("Rendering Profile: ${profile.toJson()}");
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EditableAvatar(
                imageUrl: imgcntroller.vendorImage.value,
                isEditing: isEditing,
                onImagePicked: (newImageUrl) {
                  imgcntroller.setVendorImage(newImageUrl);
                },
              ),
              const SizedBox(height: 10),
              Text(
                profile.name.isNotEmpty ? profile.name : "No Name",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildInfoSection("Basic Information", [
                _buildEditableRow("Name", nameController),
                _buildEditableRow("Email", emailController),
                _buildEditableRow("Phone Number", mobileNoController, countryCode: countryCodeController),
                _buildEditableRow("Gender", genderController),
              ]),
              _buildInfoSection("Company Details", [
                _buildEditableRow("Company Name", companyNameController),
                _buildEditableRow("City", cityNameController),
                _buildEditableRow("Street", streetNameController),
                _buildEditableRow("Country", countryNameController),
                _buildEditableRow("Pincode", pincodeController),
                _buildEditableRow("Description", descriptionController),
              ]),
              const SizedBox(height: 20),
              _buildDocumentSection(),
              const SizedBox(height: 20),
              _buildVehicleImageSection(),
              const SizedBox(height: 20),
           
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (isEditing) {
                      final updatedProfile = ProfileModel(
                        id: profile.id,
                        name: nameController.text,
                        email: emailController.text,
                        mobileNo: mobileNoController.text,
                        countryCode: countryCodeController.text,
                        companyName: companyNameController.text,
                        streetName: streetNameController.text,
                        cityName: cityNameController.text,
                        countryName: countryNameController.text,
                        pincode: pincodeController.text,
                        gender: genderController.text,
                        description: descriptionController.text,
                        vendorImage: imgcntroller.vendorImage.value,
                        legalDocuments: docController.uploadedDocumentUrls.toList(),
                        vehicleImages: imgcntroller.vehicleImages.toList(),
                      );
                      controller.updateProfile(
                        updatedProfile,
                        docController.uploadedDocumentUrls.toList(),
                        imgcntroller.vehicleImages.toList(),
                      );
                    }
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) => Colors.green,
                    ),
                  ),
                  child: Text(
                    isEditing ? "Save" : "Edit Profile",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Column(children: children),
      ],
    );
  }

  Widget _buildEditableRow(String label, TextEditingController controller, {TextEditingController? countryCode}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              "$label:",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 8,
            child: isEditing
                ? Row(
                    children: [
                      if (countryCode != null)
                        SizedBox(
                          width: 80,
                          child: TextField(
                            controller: countryCode,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            ),
                          ),
                        ),
                      if (countryCode != null) const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          ),
                        ),
                      ),
                    ],
                  )
                : Text(
                    countryCode != null
                        ? "+${countryCode.text.isNotEmpty ? countryCode.text : 'N/A'} ${controller.text.isNotEmpty ? controller.text : 'N/A'}"
                        : controller.text.isNotEmpty ? controller.text : 'N/A',
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Documents",
          style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Obx(() => docController.uploadedDocumentUrls.isEmpty
            ? const Text("No Document uploaded yet", style: TextStyle(color: Colors.grey))
            : Wrap(
                children: List.generate(docController.uploadedDocumentUrls.length, (index) {
                  final doc = docController.uploadedDocumentUrls[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () => _launchUrl(doc['url']!),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.insert_drive_file, color: Colors.blue),
                                const SizedBox(width: 5),
                                Text(
                                  doc['fileName'] ?? 'Document',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isEditing)
                          Positioned(
                            top: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: () => docController.removeDocument(index),
                              child: const Icon(Icons.close, color: Colors.redAccent),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              )),
        if (isEditing) ...[
          const SizedBox(height: 20),
          GestureDetector(
            onTap: docController.pickDocuments,
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
                        "Upload Documents \nSupported formats: PDF, DOC, DOCX, PNG, JPG, JPEG",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildVehicleImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Vehicle Images",
          style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Obx(() => imgcntroller.vehicleImages.isEmpty
            ? const Text("No Vehicle Image uploaded yet", style: TextStyle(color: Colors.grey))
            : Wrap(
                children: List.generate(imgcntroller.vehicleImages.length, (index) {
                  final url = imgcntroller.vehicleImages[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () => _launchUrl(url),
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            height: 60,
                            width: 60,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                          ),
                        ),
                        if (isEditing)
                          Positioned(
                            top: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: () => imgcntroller.removeVehicleImage(index),
                              child: const Icon(Icons.close, color: Colors.redAccent),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              )),
        if (isEditing) ...[
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.camera),
                        title: const Text('Take a Photo'),
                        onTap: () {
                          imgcntroller.pickVehicleImages(true);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.photo_library),
                        title: const Text('Choose from Gallery'),
                        onTap: () {
                          imgcntroller.pickVehicleImages(false);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
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
                        "Upload Vehicle Images \nSupported formats: JPG, PNG, JPEG",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

 
}