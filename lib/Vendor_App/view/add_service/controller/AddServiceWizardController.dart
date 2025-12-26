import 'package:get/get.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';

class AddServiceWizardController extends GetxController {
  final ApiServiceVenderSide apiService = Get.find<ApiServiceVenderSide>();

  // Steps
  var currentStep = 1.obs;
  final totalSteps = 4;

  // Profile validation
  var hasCompanyInfo = false.obs;
  var hasBankDetails = false.obs;
  var isCheckingProfile = true.obs;

  // Selected values
  var selectedCategory = Rxn<String>();
  var selectedSubcategory = Rxn<String>();
  var selectedSetupOption = Rxn<String>(); // "complete" or "quick"

  @override
  void onInit() {
    super.onInit();
    if (currentStep.value == 1) {
      checkProfileCompletion();
    }
  }

  Future<void> checkProfileCompletion() async {
    try {
      isCheckingProfile.value = true;

      final token = await SessionVendorSideManager().getToken();
      final vendorId = await SessionVendorSideManager().getVendorId();

      if (token == null || vendorId == null) {
        Get.snackbar("Error", "Session expired. Please login again.");
        return;
      }

      // Check company info
      try {
        final companyRes = await apiService.getCompanyInfo(token);
        hasCompanyInfo.value = companyRes != null &&
            companyRes['success'] == true &&
            companyRes['companyData'] != null &&
            (companyRes['companyData']['companyName'] ?? '').toString().trim().isNotEmpty;
      } catch (e) {
        hasCompanyInfo.value = false;
      }

      // Check bank details
      try {
        final bankRes = await apiService.getApi('check-bank-details/$vendorId');
        hasBankDetails.value = bankRes['hasAccountDetails'] == true ||
            bankRes['result'] == 'true';
      } catch (e) {
        hasBankDetails.value = false;
      }
    } finally {
      isCheckingProfile.value = false;
    }
  }

  void nextStep() {
    if (currentStep.value < totalSteps) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }

  double get progress => currentStep.value / totalSteps;

  bool get canProceed {
    switch (currentStep.value) {
      case 1:
        return hasCompanyInfo.value && hasBankDetails.value;
      case 2:
        return selectedCategory.value != null;
      case 3:
        return selectedSubcategory.value != null;
      case 4:
        return selectedSetupOption.value != null;
      default:
        return false;
    }
  }

  void reset() {
    currentStep.value = 1;
    selectedCategory.value = null;
    selectedSubcategory.value = null;
    selectedSetupOption.value = null;
  }
}