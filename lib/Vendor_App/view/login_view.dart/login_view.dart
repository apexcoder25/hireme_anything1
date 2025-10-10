// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hire_any_thing/Vendor_App/api_service/api_service_vender_side.dart';
// import 'package:hire_any_thing/res/routes/routes.dart';
// import 'package:hire_any_thing/Vendor_App/uiltis/color.dart' as app_colors; // Rename to avoid potential conflicts

// class VendorLoginScreen extends StatefulWidget {
//   const VendorLoginScreen({super.key});

//   @override
//   State<VendorLoginScreen> createState() => _VendorLoginScreenState();
// }

// class _VendorLoginScreenState extends State<VendorLoginScreen> {
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _loader = false;
//   bool _isLoginTab = true;

//   @override
//   void dispose() {
//     passwordController.dispose();
//     emailController.dispose();
//     super.dispose();
//   }

//   void _toggleTab(bool loginTab) {
//     if (_isLoginTab != loginTab) {
//       setState(() {
//         _isLoginTab = loginTab;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: app_colors.colors.scaffold_background_color,
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               // Logo
//               Image.asset("assets/app_logo/hireme_anything_logo.png", height: 90, fit: BoxFit.contain),
//               const SizedBox(height: 20),
//               const Text(
//                 "Partner Login",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
//               ),
//               const SizedBox(height: 8),
//               const Padding(
//                 padding: EdgeInsets.only(bottom: 10),
//                 child: Text(
//                   "Access your partner dashboard",
//                   style: TextStyle(fontSize: 14, color: Colors.black54),
//                 ),
//               ),
//               // Main Card
//               Container(
//                 width: width * 0.91,
//                 margin: const EdgeInsets.symmetric(vertical: 8),
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(18),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.07),
//                       blurRadius: 19,
//                       offset: const Offset(0, 7),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     // Tabs
//                     Container(
//                       height: 48,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Stack(
//                         children: [
//                           AnimatedAlign(
//                             alignment:
//                                 _isLoginTab ? Alignment.centerLeft : Alignment.centerRight,
//                             duration: const Duration(milliseconds: 250),
//                             child: FractionallySizedBox(
//                               widthFactor: 0.5,
//                               child: Container(
//                                 height: 44,
//                                 margin: const EdgeInsets.all(2),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xff0e53ce),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: InkWell(
//                                   borderRadius: BorderRadius.circular(12),
//                                   onTap: () => _toggleTab(true),
//                                   child: Container(
//                                     height: 48,
//                                     alignment: Alignment.center,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.login,
//                                             size: 18,
//                                             color: _isLoginTab ? Colors.white : Colors.grey),
//                                         const SizedBox(width: 6),
//                                         Text(
//                                           "Login",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 16,
//                                             color: _isLoginTab ? Colors.white : Colors.grey,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: InkWell(
//                                   borderRadius: BorderRadius.circular(12),
//                                   onTap: () => _toggleTab(false),
//                                   child: Container(
//                                     height: 48,
//                                     alignment: Alignment.center,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.person_add,
//                                             size: 18,
//                                             color: !_isLoginTab ? Colors.white : Colors.grey),
//                                         const SizedBox(width: 6),
//                                         Text(
//                                           "Register",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 16,
//                                             color: !_isLoginTab ? Colors.white : Colors.grey,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 22),

//                     // Login Form
//                     if (_isLoginTab) ...[
//                       const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 2.0),
//                         child: Text("Email / Mobile Number",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 14)),
//                       ),
//                       const SizedBox(height: 7),
//                       TextField(
//                         controller: emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(Icons.mail_outline),
//                           hintText: "Enter email or mobile",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(color: Colors.grey.shade300),
//                           ),
//                           filled: true,
//                           fillColor: Colors.grey[100],
//                         ),
//                       ),
//                       const SizedBox(height: 17),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 2.0),
//                         child: Text("Password",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 14)),
//                       ),
//                       const SizedBox(height: 7),
//                       TextField(
//                         controller: passwordController,
//                         obscureText: _obscurePassword,
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(Icons.lock_outline),
//                           hintText: "Enter password",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(color: Colors.grey.shade300),
//                           ),
//                           filled: true,
//                           fillColor: Colors.grey[100],
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                               color: Colors.grey,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _obscurePassword = !_obscurePassword;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 22),
//                       SizedBox(
//                         width: double.infinity,
//                         height: 49,
//                         child: ElevatedButton(
//                           onPressed: _loader
//                               ? null
//                               : () async {
//                                   if (!mounted) return;
//                                   setState(() => _loader = true);

//                                   if (emailController.text.trim().isNotEmpty &&
//                                       passwordController.text.trim().isNotEmpty) {
//                                     final isRegistered =
//                                         await apiServiceVenderSide.vendorLogin({
//                                       "email": emailController.text.trim(),
//                                       "password": passwordController.text.trim(),
//                                     });
//                                     if (!mounted) return;
//                                     if (isRegistered) {
//                                       Get.offAllNamed(VendorRoutesName.homeVendorView);
//                                     } else {
//                                       Get.snackbar(
//                                         "Invalid",
//                                         "Invalid login credentials!",
//                                         snackPosition: SnackPosition.BOTTOM,
//                                         backgroundColor: Colors.redAccent,
//                                         colorText: Colors.white,
//                                         borderRadius: 8.0,
//                                         margin: const EdgeInsets.all(16),
//                                         duration: const Duration(seconds: 3),
//                                       );
//                                     }
//                                   } else {
//                                     Get.snackbar(
//                                       "Error",
//                                       "Email/mobile and password required!",
//                                       snackPosition: SnackPosition.BOTTOM,
//                                       backgroundColor: Colors.redAccent,
//                                       colorText: Colors.white,
//                                       borderRadius: 8.0,
//                                       margin: const EdgeInsets.all(16),
//                                       duration: const Duration(seconds: 3),
//                                     );
//                                   }

//                                   if (mounted) setState(() => _loader = false);
//                                 },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xff0e53ce),
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             elevation: 0,
//                           ),
//                           child: _loader
//                               ? const SizedBox(
//                                   height: 22,
//                                   width: 22,
//                                   child: CircularProgressIndicator(
//                                     color: Colors.white,
//                                     strokeWidth: 2.3,
//                                   ),
//                                 )
//                               : const Text(
//                                   "Access Dashboard",
//                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                                 ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             "Don't have an account?",
//                             style: TextStyle(
//                               fontSize: 15,
//                               color: Colors.black54,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                           TextButton(
//                             child: const Text(
//                               "Sign Up",
//                               style: TextStyle(
//                                   color: Color(0xff0e53ce), fontWeight: FontWeight.bold),
//                             ),
//                             onPressed: () {
//                               Get.offNamed(VendorRoutesName.registerVendorView);
//                             },
//                           )
//                         ],
//                       ),
//                     ],

//                     // Register Tab Placeholder
//                     if (!_isLoginTab)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 38.0),
//                         child: Column(
//                           children: const [
//                             Icon(Icons.person_add, size: 34, color: Color(0xff0e53ce)),
//                             SizedBox(height: 10),
//                             Text(
//                               "Registration coming soon!",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black54,
//                                 fontSize: 16,
//                               ),
//                               textAlign: TextAlign.center,
//                             )
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
