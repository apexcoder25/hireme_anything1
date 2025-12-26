import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/controller/AddServiceWizardController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/BoatHireService/boat_hire_service_screen.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/ChauffeurHireService/chauffeur_Driven_Prestige_Car_HIre.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/FuneralCarHireService/funeralCarHireService.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/addServiceScreen1/controllers/category_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coachHireService/coach_hire_services.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/horseAndCarriageHireService/horse_and_carriage_hire_service.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/lumosineHireService/limousine_hire_service.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/minibusHireService/minibus_hire_services.dart';
import 'package:hire_any_thing/utilities/colors.dart';

class AddServiceWizardScreen extends StatelessWidget {
  final AddServiceWizardController wizardCtrl = Get.put(AddServiceWizardController());
  final DropdownController dropdownCtrl = Get.put(  DropdownController());

  AddServiceWizardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Create New Service",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                Obx(() => LinearProgressIndicator(
                      value: wizardCtrl.progress,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation(AppColors.btnColor),
                      minHeight: 8,
                    )),
                const SizedBox(height: 12),
                Obx(() => Text(
                      "Step ${wizardCtrl.currentStep.value} of ${wizardCtrl.totalSteps} - ${_getStepTitle(wizardCtrl.currentStep.value)}",
                      style: TextStyle(fontSize: 15, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
                    )),
                const SizedBox(height: 8),
                Obx(() => Text(
                      "${(wizardCtrl.progress * 100).toInt()}%",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.btnColor),
                    )),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Obx(() => _buildStepContent(wizardCtrl.currentStep.value)),
          ),

          // Bottom Buttons
          _buildBottomButtons(),
        ],
      ),
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 1: return "Profile Validation";
      case 2: return "Choose Service Category";
      case 3: return "Choose Subcategory";
      case 4: return "Setup Options";
      default: return "";
    }
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 1: return _buildProfileValidationStep();
      case 2: return _buildCategoryStep();
      case 3: return _buildSubcategoryStep();
      case 4: return _buildSetupOptionsStep();
      default: return Container();
    }
  }

  Widget _buildProfileValidationStep() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text("Profile Setup Required", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text("Before creating services, please complete your profile setup", style: TextStyle(color: Colors.grey.shade600), textAlign: TextAlign.center),
          const SizedBox(height: 40),
          Obx(() {
            if (wizardCtrl.isCheckingProfile.value) return const CircularProgressIndicator();
            return Column(
              children: [
                _buildValidationItem("Company Information", wizardCtrl.hasCompanyInfo.value, "Your company information has been completed successfully."),
                const SizedBox(height: 16),
                _buildValidationItem("Bank Details", wizardCtrl.hasBankDetails.value, "Your bank details have been added successfully."),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildValidationItem(String title, bool completed, String message) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: completed ? Colors.green.shade200 : Colors.grey.shade300)),
      child: Row(
        children: [
          Icon(completed ? Icons.check_circle : Icons.radio_button_unchecked, color: completed ? Colors.green : Colors.grey, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                const SizedBox(height: 4),
                Text(message, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
              ],
            ),
          ),
          if (completed)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
              child: const Text("Completed", style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryStep() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Choose Service Category", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text("Select the category that best matches your service offering"),
          const SizedBox(height: 32),
          const Text("Select Category", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Obx(() {
            if (dropdownCtrl.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return DropdownButtonFormField<String>(
              value: dropdownCtrl.selectedCategory.value,
              hint: const Text("Choose a category..."),
              items: dropdownCtrl.categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
              onChanged: (val) {
                if (val != null) {
                  dropdownCtrl.selectCategory(val);
                  wizardCtrl.selectedCategory.value = val;
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              ),
              isExpanded: true,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSubcategoryStep() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Choose Subcategory", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text("Choose the specific type of service you want to offer"),
          const SizedBox(height: 8),
          Obx(() => Text("Selected: ${dropdownCtrl.selectedCategory.value ?? 'None'}", style: const TextStyle(fontSize: 15, color: Colors.grey))),
          const SizedBox(height: 32),
          Obx(() {
            if (dropdownCtrl.subcategories.isEmpty) {
              return const Center(child: Text("No subcategories available", style: TextStyle(color: Colors.grey)));
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3.2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: dropdownCtrl.subcategories.length,
              itemBuilder: (ctx, i) {
                final subcat = dropdownCtrl.subcategories[i];
                // Use Obx inside itemBuilder to react to selection change
                return Obx(() {
                  final isSelected = dropdownCtrl.selectedSubcategory.value == subcat;

                  return InkWell(
                    onTap: () {
                      dropdownCtrl.selectSubcategory(subcat);
                      wizardCtrl.selectedSubcategory.value = subcat;
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.btnColor : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? AppColors.btnColor : Colors.grey.shade300,
                          width: isSelected ? 2.5 : 1.5,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.btnColor.withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                )
                              ]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        subcat,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                });
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSetupOptionsStep() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Setup Options", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text("Choose how you want to set up your service"),
          const SizedBox(height: 8),
          Obx(() => Text(
                "Selected: ${dropdownCtrl.selectedCategory.value} - ${dropdownCtrl.selectedSubcategory.value ?? ''}",
                style: const TextStyle(fontSize: 15),
              )),
          const SizedBox(height: 32),
          _buildSetupCard(
            title: "Complete Setup",
            subtitle: "Full setup with all features and optimizations",
            features: [
              "Detailed information",
              "Photo gallery",
              "Advanced pricing",
              "SEO optimization",
            ],
            isSelected: wizardCtrl.selectedSetupOption.value == "complete",
            onTap: () => wizardCtrl.selectedSetupOption.value = "complete",
          ),
        ],
      ),
    );
  }

  Widget _buildSetupCard({
    required String title,
    required String subtitle,
    required List<String> features,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppColors.btnColor : Colors.grey.shade300, width: isSelected ? 2.5 : 1.5),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 6)),
          ],
        ),
        child: Row(
          children: [
            Radio<String>(
              value: "complete",
              groupValue: wizardCtrl.selectedSetupOption.value,
              onChanged: (_) => onTap(),
              activeColor: AppColors.btnColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 15)),
                  const SizedBox(height: 16),
                  ...features.map((f) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(children: [
                          Icon(Icons.check_circle, size: 20, color: Colors.green),
                          const SizedBox(width: 10),
                          Text(f, style: const TextStyle(fontSize: 15)),
                        ]),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Back Button (visible from step 2)
            if (wizardCtrl.currentStep.value > 1)
              Expanded(
                flex: 2,
                child: OutlinedButton(
                  onPressed: wizardCtrl.previousStep,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    side: BorderSide(color: Colors.grey.shade400, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back_rounded, size: 20),
                      SizedBox(width: 8),
                      Text("Back", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),

            if (wizardCtrl.currentStep.value > 1) const SizedBox(width: 16),

            // Cancel Button (except last step)
            if (wizardCtrl.currentStep.value < wizardCtrl.totalSteps)
              TextButton(
                onPressed: () => Get.back(),
                child: Text("Cancel", style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
              ),

            if (wizardCtrl.currentStep.value < wizardCtrl.totalSteps) const Spacer(),

            // Continue / Create Button
            Obx(() => Expanded(
                  flex: wizardCtrl.currentStep.value > 1 ? 3 : 4,
                  child: ElevatedButton(
                    onPressed: wizardCtrl.canProceed
                        ? () {
                            if (wizardCtrl.currentStep.value == wizardCtrl.totalSteps) {
                              _createService();
                            } else {
                              wizardCtrl.nextStep();
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.btnColor,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 10,
                      shadowColor: AppColors.btnColor.withOpacity(0.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          wizardCtrl.currentStep.value == wizardCtrl.totalSteps ? "Create Service" : "Continue",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _createService() {
    final category = dropdownCtrl.selectedCategory.value!;
    final subcategory = dropdownCtrl.selectedSubcategory.value!;
    final categoryId = dropdownCtrl.selectedCategoryId.value ?? "";
    final subcategoryId = dropdownCtrl.selectedSubcategoryId.value ?? "";

    if (category == 'Passenger Transport') {
      switch (subcategory) {
        case 'Boat Hire':
          Get.to(() => BoatHireService(category: Rxn<String>(category), subCategory: Rxn<String>(subcategory), categoryId: categoryId, subCategoryId: subcategoryId));
          break;
        case 'Chauffeur Driven Prestige Car Hire':
          Get.to(() => ChauffeurHireService(category: Rxn<String>(category), subCategory: Rxn<String>(subcategory), categoryId: categoryId, subCategoryId: subcategoryId));
          break;
        case 'Limousine Hire':
          Get.to(() => LimousineHireService(category: Rxn<String>(category), subCategory: Rxn<String>(subcategory), categoryId: categoryId, subCategoryId: subcategoryId));
          break;
        case 'Coach Hire':
          Get.to(() => CoachHireService(category: Rxn<String>(category), subCategory: Rxn<String>(subcategory), categoryId: categoryId, subCategoryId: subcategoryId));
          break;
        case 'Minibus Hire':
          Get.to(() => MinibusHireService(category: Rxn<String>(category), subCategory: Rxn<String>(subcategory), categoryId: categoryId, subCategoryId: subcategoryId));
          break;
        case 'Funeral Car Hire':
          Get.to(() => FuneralCarHireService(category: Rxn<String>(category), subCategory: Rxn<String>(subcategory), categoryId: categoryId, subCategoryId: subcategoryId));
          break;
        case 'Horse and Carriage Hire':
          Get.to(() => HorseAndCarriageHireService(Category: Rxn<String>(category), SubCategory: Rxn<String>(subcategory), CategoryId: categoryId, SubCategoryId: subcategoryId));
          break;
        default:
          Get.snackbar("Coming Soon", "This service form is under development");
      }
    } else {
      Get.snackbar("Coming Soon", "Service creation for $category is under development");
    }
  }
}