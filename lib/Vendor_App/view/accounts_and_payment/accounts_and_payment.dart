import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/signup_textfilled.dart';
import 'package:hire_any_thing/Vendor_App/view/accounts_and_payment/controllers/accounts_and_payment._controller.dart';

class AccountsAndManagementScreen extends StatelessWidget {
  const AccountsAndManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountsAndManagementController controller = Get.put(AccountsAndManagementController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vendor Account Management"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vendor ID
              const Text(
                "Vendor ID",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Signup_textfilled(
                hinttext: "Vendor ID",
                textcont: TextEditingController(text: controller.vendorId.value),
                keytype: TextInputType.text,
                length: 50,
                textfilled_height: 16,
                textfilled_weight: 1.1,
                isPassword: false,
                readOnly: true,
                maxLines: 1,
              ),
              const SizedBox(height: 20),

              // Conditional UI: Show details or form
              if (controller.hasAccountDetails.value && !controller.isEditing.value) ...[
                // Show existing details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Current Account Details",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton.icon(
                      onPressed: controller.resetForm,
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text("Edit Details"),
                      style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildDetailField("Account Number", controller.accountDetails.value!.accountNumber),
                _buildDetailField("Bank Name", controller.accountDetails.value!.bankName),
                _buildDetailField("Sort Code", controller.accountDetails.value!.ifscCode),
                _buildDetailField("IBAN Number", controller.accountDetails.value!.ibanNumber),
                _buildDetailField("Account Holder Name", controller.accountDetails.value!.bankAccountHolderName),
                _buildDetailField("SWIFT Code", controller.accountDetails.value!.swiftCode),
                _buildDetailField("PayPal ID", controller.accountDetails.value!.paypalId),
              ] else ...[
                // Show form for adding or editing
                Text(
                  controller.hasAccountDetails.value ? "Edit Account Details" : "Add Account Details",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Account Number
                      const Text("Account Number *", style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Signup_textfilled(
                        hinttext: "Enter Account Number",
                        textcont: controller.accountNumberController,
                        keytype: TextInputType.text,
                        length: 50,
                        textfilled_height: 16,
                        textfilled_weight: 1.1,
                        isPassword: false,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),

                      // Bank Name
                      const Text("Bank Name *", style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Signup_textfilled(
                        hinttext: "Enter Bank Name",
                        textcont: controller.bankNameController,
                        keytype: TextInputType.text,
                        length: 50,
                        textfilled_height: 16,
                        textfilled_weight: 1.1,
                        isPassword: false,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),

                      // Sort Code
                      const Text("Sort Code *", style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Signup_textfilled(
                        hinttext: "Enter Sort Code",
                        textcont: controller.sortCodeController,
                        keytype: TextInputType.text,
                        length: 50,
                        textfilled_height: 16,
                        textfilled_weight: 1.1,
                        isPassword: false,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),

                      // IBAN Number
                      const Text("IBAN Number *", style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Signup_textfilled(
                        hinttext: "Enter IBAN Number",
                        textcont: controller.ibanNumberController,
                        keytype: TextInputType.text,
                        length: 50,
                        textfilled_height: 16,
                        textfilled_weight: 1.1,
                        isPassword: false,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),

                      // Account Holder Name
                      const Text("Account Holder Name *", style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Signup_textfilled(
                        hinttext: "Enter Account Holder Name",
                        textcont: controller.accountHolderNameController,
                        keytype: TextInputType.text,
                        length: 50,
                        textfilled_height: 16,
                        textfilled_weight: 1.1,
                        isPassword: false,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),

                      // SWIFT Code
                      const Text("SWIFT Code *", style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Signup_textfilled(
                        hinttext: "Enter SWIFT Code",
                        textcont: controller.swiftCodeController,
                        keytype: TextInputType.text,
                        length: 50,
                        textfilled_height: 16,
                        textfilled_weight: 1.1,
                        isPassword: false,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),

                      // PayPal ID
                      const Text("PayPal ID *", style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Signup_textfilled(
                        hinttext: "Enter PayPal ID",
                        textcont: controller.paypalIdController,
                        keytype: TextInputType.text,
                        length: 50,
                        textfilled_height: 16,
                        textfilled_weight: 1.1,
                        isPassword: false,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 20),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.submitAccountDetails,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            controller.hasAccountDetails.value ? "Update Account Details" : "Add Account Details",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDetailField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(value, style: const TextStyle(fontSize: 16)),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}