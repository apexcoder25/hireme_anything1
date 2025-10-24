import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/api_service/api_service_user_side.dart';
import 'package:hire_any_thing/User_app/views/UserHomePage/user_home_page.dart';
import 'package:hire_any_thing/utilities/colors.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _enquiryType;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  bool loader = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && _enquiryType != null) {
      setState(() => loader = true);
      
      // Format the data as the server expects - single input field with formatted text
      final formattedInput = "Name: ${nameController.text}\nEmail: ${emailController.text}\nPhone: ${phoneController.text}\nSubject: $_enquiryType\nMessage: ${messageController.text}";
      
      final isSubmitted = await apiServiceUserSide.contactUs({
        "input": formattedInput,
        "email": emailController.text,
      });
      if (isSubmitted) {
        Get.offAllNamed('/user_main_dashboard');
      }
      setState(() => loader = false);
    } else if (_enquiryType == null) {
      Get.snackbar(
        'Enquiry Type Required',
        'Please select your enquiry type.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange[700],
        colorText: Colors.white,
        icon: Icon(Icons.info_outline, color: Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
          child: Card(
            elevation: 5,
            shadowColor: Colors.blue.withOpacity(0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: Colors.blue[100]!, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contact Info Card Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact our Team',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.1),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.email_outlined, size: 19, color: Colors.white70),
                              SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  'hireanything2024@gmail.com',
                                  style: TextStyle(color: Colors.white70, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, size: 19, color: Colors.white70),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  'HIRE ANYTHING LTD, 96 Greenside, Slough, Berkshire, England, SL2 1ST, United Kingdom',
                                  style: TextStyle(color: Colors.white70, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Form Title
                    Row(
                      children: [
                        Icon(Icons.chat_bubble_outline, color: Colors.blue[700]),
                        SizedBox(width: 8),
                        Text(
                          'Send us a Message',
                          style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),

                    _buildLabel(' Name'),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: nameController,
                      decoration: _inputDecoration(hintText: 'Enter your name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter your name';
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 16),

                    _buildLabel('Email'),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: emailController,
                      decoration: _inputDecoration(hintText: 'Enter your email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter your email';
                        if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) return 'Please enter a valid email';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    _buildLabel('Phone'),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: phoneController,
                      decoration: _inputDecoration(hintText: 'Enter phone number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter your phone number';
                        if (!RegExp(r'^\+?1?\d{9,16}$').hasMatch(value)) return 'Please enter a valid phone number';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    _buildLabel('Enquiry Type'),
                    SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[100]!),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[50],
                      ),
                      child: Column(
                        children: [
                          _buildRadioListTile('General Enquiries'),
                          _buildRadioListTile('Customer Support'),
                          _buildRadioListTile('Partnership & Collaboration'),
                          _buildRadioListTile('Technical Support'),
                          _buildRadioListTile('Account Management'),
                          _buildRadioListTile('Security & Privacy'),
                          _buildRadioListTile('Service Provider Registration'),
                          _buildRadioListTile('Existing Booking Enquiry'),
                          _buildRadioListTile('Legal & Compliance'),
                          _buildRadioListTile('Payment & Billing'),
                          _buildRadioListTile('Feedback & Complaints'),
                          _buildRadioListTile('Something Else'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Message'),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: messageController,
                      decoration: _inputDecoration(hintText: 'Enter your message'),
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter your message';
                        return null;
                      },
                    ),
                    const SizedBox(height: 28),

                    Center(
                      child: SizedBox(
                        width: 220,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: loader ? null : _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.btnColor,
                            foregroundColor: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          icon: loader
                              ? SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.2,
                                  ),
                                )
                              : Icon(Icons.send_rounded),
                          label: Text(
                            loader ? "PLEASE WAIT..." : 'SEND MESSAGE',
                            style: TextStyle(fontSize: 16.7, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.blueGrey[900],
          fontWeight: FontWeight.bold,
          letterSpacing: 0.1,
        ),
      );

  InputDecoration _inputDecoration({required String hintText}) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.blue[100]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.blue[100]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
      ),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey[500]),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _buildRadioListTile(String title) {
    return RadioListTile<String>(
      title: Text(title, style: TextStyle(fontSize: 15, color: Colors.blueGrey[800])),
      value: title,
      groupValue: _enquiryType,
      onChanged: (value) {
        setState(() {
          _enquiryType = value;
        });
      },
      activeColor: Colors.blue[700],
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.symmetric(horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
