import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/signup_textfilled.dart';
import 'package:hire_any_thing/Vendor_App/view/accounts_and_payment/controllers/accounts_and_payment._controller.dart';
import 'package:hire_any_thing/utilities/colors.dart';

class AccountsAndManagementScreen extends StatelessWidget {
  const AccountsAndManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountsAndManagementController controller = Get.put(AccountsAndManagementController());

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildLoadingState();
        }

        
        if (!controller.isAnimationInitialized.value) {
          return _buildContent(controller); 
        }

        return AnimatedBuilder(
          animation: controller.slideAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, (1 - controller.slideAnimation.value) * 50),
              child: Opacity(
                opacity: controller.slideAnimation.value,
                child: _buildContent(controller),
              ),
            );
          },
        );
      }),
    );
  }


  Widget _buildLoadingState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.btnColor),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Loading account details...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(AccountsAndManagementController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(controller),
          const SizedBox(height: 24),
          
          if (controller.hasAccountDetails.value && !controller.isEditing.value) ...[
            _buildAccountDetailsView(controller),
          ] else ...[
            _buildAccountDetailsForm(controller),
          ],
        ],
      ),
    );
  }

  Widget _buildHeaderSection(AccountsAndManagementController controller) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.btnColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  color: AppColors.btnColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account Management',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage your payment methods and banking details securely',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.btnColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.btnColor.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: AppColors.btnColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'Vendor ID: ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                  child: Text(
                    controller.vendorId.value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.btnColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: controller.vendorId.value));
                    Get.snackbar(
                      'Copied',
                      'Vendor ID copied to clipboard',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.btnColor,
                      colorText: Colors.white,
                      borderRadius: 12.0,
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 2),
                      icon: const Icon(Icons.check_circle, color: Colors.white, size: 20),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.btnColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.copy,
                      color: AppColors.btnColor,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountDetailsView(AccountsAndManagementController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.verified_outlined,
                    color: Colors.green.shade700,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Account Details Verified',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your payment information is set up and ready',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton.icon(
                    onPressed: controller.toggleEditMode,
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: AppColors.btnColor,
                    ),
                    label: Text(
                      "Edit",
                      style: TextStyle(
                        color: AppColors.btnColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildDetailCard("Bank Name", controller.accountDetails.value!.bankName, Icons.account_balance),
                _buildDetailCard("Account Holder", controller.accountDetails.value!.bankAccountHolderName, Icons.person_outline),
                _buildDetailCard("Account Number", _maskAccountNumber(controller.accountDetails.value!.accountNumber), Icons.credit_card),
                _buildDetailCard("Sort Code/IFSC", controller.accountDetails.value!.ifscCode, Icons.code),
                _buildDetailCard("IBAN Number", _maskIBAN(controller.accountDetails.value!.ibanNumber), Icons.account_balance_wallet),
                _buildDetailCard("SWIFT Code", controller.accountDetails.value!.swiftCode, Icons.swap_horiz),
                if (controller.accountDetails.value!.paypalId.isNotEmpty)
                  _buildDetailCard("PayPal ID", controller.accountDetails.value!.paypalId, Icons.payment),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountDetailsForm(AccountsAndManagementController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.btnColor.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.btnColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    controller.hasAccountDetails.value ? Icons.edit : Icons.add_card,
                    color: AppColors.btnColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.hasAccountDetails.value ? "Edit Account Details" : "Add Account Details",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Complete your payment setup to receive earnings',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (controller.isEditing.value)
                  TextButton(
                    onPressed: controller.cancelEdit,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildTabSelector(controller),
                const SizedBox(height: 24),
                Form(
                  key: controller.formKey,
                  child: Obx(() {
                    if (controller.selectedTab.value == 0) {
                      return _buildBankForm(controller);
                    } else {
                      return _buildPayPalForm(controller);
                    }
                  }),
                ),
                const SizedBox(height: 32),
                _buildSubmitButton(controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSelector(AccountsAndManagementController controller) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => GestureDetector(
              onTap: () => controller.changeTab(0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: controller.selectedTab.value == 0 ? AppColors.btnColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_balance,
                      size: 20,
                      color: controller.selectedTab.value == 0 ? Colors.white : Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Bank Account',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: controller.selectedTab.value == 0 ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ),
          Expanded(
            child: Obx(() => GestureDetector(
              onTap: () => controller.changeTab(1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: controller.selectedTab.value == 1 ? AppColors.btnColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.payment,
                      size: 20,
                      color: controller.selectedTab.value == 1 ? Colors.white : Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'PayPal',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: controller.selectedTab.value == 1 ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildBankForm(AccountsAndManagementController controller) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildFormField('Bank Name', controller.bankNameController, Icons.account_balance, true)),
            const SizedBox(width: 16),
            Expanded(child: _buildFormField('Account Holder Name', controller.accountHolderNameController, Icons.person_outline, true)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _buildFormField('Account Number', controller.accountNumberController, Icons.credit_card, true)),
            const SizedBox(width: 16),
            Expanded(child: _buildFormField('Sort Code/IFSC', controller.sortCodeController, Icons.code, true)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _buildFormField('IBAN Number', controller.ibanNumberController, Icons.account_balance_wallet, true)),
            const SizedBox(width: 16),
            Expanded(child: _buildFormField('SWIFT Code', controller.swiftCodeController, Icons.swap_horiz, true)),
          ],
        ),
      ],
    );
  }

  Widget _buildPayPalForm(AccountsAndManagementController controller) {
    return Column(
      children: [
        _buildFormField('PayPal Email ID', controller.paypalIdController, Icons.email_outlined, true),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade600, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PayPal Information',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Make sure this email is associated with your active PayPal account for receiving payments.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue.shade700,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormField(String label, TextEditingController controller, IconData icon, bool required) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.btnColor),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            if (required)
              const Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Signup_textfilled(
            hinttext: 'Enter $label',
            textcont: controller,
            keytype: label.toLowerCase().contains('email') ? TextInputType.emailAddress : TextInputType.text,
            length: 100,
            textfilled_height: 16,
            textfilled_weight: 1.1,
            isPassword: false,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(AccountsAndManagementController controller) {
    return Obx(() => Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.btnColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: controller.isLoading.value ? null : controller.submitAccountDetails,
        icon: controller.isLoading.value
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Icon(
                controller.hasAccountDetails.value ? Icons.update : Icons.add_card,
                size: 20,
              ),
        label: Text(
          controller.isLoading.value
              ? 'Processing...'
              : controller.hasAccountDetails.value
                  ? 'Update Account Details'
                  : 'Add Account Details',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.btnColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    ));
  }

  Widget _buildDetailCard(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.btnColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: AppColors.btnColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value.isNotEmpty ? value : "Not provided",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: value.isNotEmpty ? Colors.black87 : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return '*' * (accountNumber.length - 4) + accountNumber.substring(accountNumber.length - 4);
  }

  String _maskIBAN(String iban) {
    if (iban.length <= 8) return iban;
    return iban.substring(0, 4) + '*' * (iban.length - 8) + iban.substring(iban.length - 4);
  }

  void _showHelpDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.help_outline, color: AppColors.btnColor),
            const SizedBox(width: 12),
            const Text(
              'Help & Support',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHelpItem('Bank details are required for receiving payments from customers'),
            _buildHelpItem('PayPal can be used as an alternative payment method'),
            _buildHelpItem('All information is encrypted and stored securely'),
            _buildHelpItem('You can edit your payment details anytime'),
            _buildHelpItem('Contact support if you need assistance setting up payments'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Got it',
              style: TextStyle(
                color: AppColors.btnColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 8),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.btnColor,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
