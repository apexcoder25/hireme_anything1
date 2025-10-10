// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hire_any_thing/Vendor_App/api_service/api_service_vender_side.dart';
// import 'package:hire_any_thing/data/api_service/api_service_user_side.dart';
// import 'package:hire_any_thing/data/getx_controller/user_side/user_profile_controller.dart';
// import 'package:hire_any_thing/res/routes/routes.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import '../utilities/colors.dart';

// class UserLoginScreeen extends StatefulWidget {
//   const UserLoginScreeen({super.key});

//   @override
//   State<UserLoginScreeen> createState() => _UserLoginScreeenState();
// }

// class _UserLoginScreeenState extends State<UserLoginScreeen>
//     with TickerProviderStateMixin {
//   late UserProfileController profileController;
//   late AnimationController _tabAnimationController;
//   late AnimationController _contentAnimationController;
//   late AnimationController _stepAnimationController;
//   late Animation<double> _slideAnimation;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _stepSlideAnimation;

//   // Login Controllers
//   late TextEditingController loginEmailController;
//   late TextEditingController loginPasswordController;

//   // Registration Controllers
//   late TextEditingController firstnameController;
//   late TextEditingController lastnameController;
//   late TextEditingController registerEmailController;
//   late TextEditingController mobileController;
//   late TextEditingController emailOtpController;
//   late TextEditingController phoneOtpController;
//   late TextEditingController passwordController;
//   late TextEditingController confirmPasswordController;

//   bool loader = false;
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;
//   bool _rememberMe = false;
//   bool isLogin = true; // true for Login, false for Register

//   // Registration step management
//   int registrationStep = 1; // 1-5 for registration steps
//   String? phoneNumber;
//   String? countryCode;

//   // Pre-computed constants for better performance
//   static const double _logoSize = 90.0;
//   static const double _containerRadius = 24.0;
//   static const double _inputRadius = 12.0;
//   static const double _buttonHeight = 56.0;
//   static const EdgeInsets _containerPadding = EdgeInsets.all(20.0);
//   static const EdgeInsets _inputPadding = EdgeInsets.all(18);

//   // Animation durations
//   static const Duration _tabAnimationDuration = Duration(milliseconds: 300);
//   static const Duration _contentAnimationDuration = Duration(milliseconds: 400);
//   static const Duration _stepAnimationDuration = Duration(milliseconds: 350);

//   // Static decorations to avoid rebuilding
//   static final BoxDecoration _backButtonDecoration = BoxDecoration(
//     color: AppColors.white,
//     borderRadius: BorderRadius.circular(12),
//     boxShadow: const [
//       BoxShadow(
//         color: AppColors.shadowLight,
//         blurRadius: 8,
//         offset: Offset(0, 2),
//       ),
//     ],
//   );

//   static final BoxDecoration _mainContainerDecoration = BoxDecoration(
//     color: AppColors.white,
//     borderRadius: BorderRadius.circular(_containerRadius),
//     boxShadow: const [
//       BoxShadow(
//         color: AppColors.shadowMedium,
//         blurRadius: 20,
//         spreadRadius: 4,
//         offset: Offset(0, 8),
//       ),
//     ],
//   );

//   static final BoxDecoration _tabContainerDecoration = BoxDecoration(
//     color: AppColors.backgroundDark,
//     borderRadius: BorderRadius.circular(_inputRadius),
//     border: const Border.fromBorderSide(
//       BorderSide(color: AppColors.borderLight, width: 1),
//     ),
//   );

//   static final BoxDecoration _inputFieldDecoration = BoxDecoration(
//     color: AppColors.surfaceLight,
//     borderRadius: BorderRadius.circular(_inputRadius),
//     border: const Border.fromBorderSide(
//       BorderSide(color: AppColors.borderLight),
//     ),
//   );

//   static final BoxDecoration _buttonShadowDecoration = BoxDecoration(
//     borderRadius: BorderRadius.circular(_inputRadius),
//     boxShadow: [
//       BoxShadow(
//         color: AppColors.btnColor.withOpacity(0.4),
//         blurRadius: 12,
//         offset: const Offset(0, 4),
//       ),
//     ],
//   );

//   // Static styles
//   static const TextStyle _titleStyle = TextStyle(
//     fontSize: 22,
//     fontWeight: FontWeight.w700,
//     color: AppColors.black,
//     letterSpacing: 0.5,
//   );

//   static const TextStyle _subtitleStyle = TextStyle(
//     fontSize: 15,
//     color: AppColors.textSecondary,
//     fontWeight: FontWeight.w400,
//   );

//   static const TextStyle _fieldLabelStyle = TextStyle(
//     fontSize: 14,
//     color: AppColors.textPrimary,
//     fontWeight: FontWeight.w600,
//   );

//   static const TextStyle _inputTextStyle = TextStyle(
//     fontSize: 15,
//     color: AppColors.textPrimary,
//   );

//   static const TextStyle _hintTextStyle = TextStyle(color: AppColors.textLight);

//   static const TextStyle _checkboxTextStyle = TextStyle(
//     fontSize: 13,
//     color: AppColors.textSecondary,
//     fontWeight: FontWeight.w500,
//   );

//   static const TextStyle _forgotPasswordStyle = TextStyle(
//     fontSize: 13,
//     color: AppColors.btnColor,
//     fontWeight: FontWeight.w600,
//   );

//   static const TextStyle _buttonTextStyle = TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.w700,
//     letterSpacing: 0.5,
//   );

//   static const TextStyle _tabActiveStyle = TextStyle(
//     color: AppColors.white,
//     fontWeight: FontWeight.w600,
//     fontSize: 14,
//   );

//   static const TextStyle _tabInactiveStyle = TextStyle(
//     color: AppColors.textSecondary,
//     fontWeight: FontWeight.w600,
//     fontSize: 14,
//   );

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllers();
//     _initializeAnimations();
//     _initializeProfileController();
//     _handleInitialArguments();
//   }

//   void _initializeControllers() {
//     // Login controllers
//     loginEmailController = TextEditingController();
//     loginPasswordController = TextEditingController();
    
//     // Registration controllers
//     firstnameController = TextEditingController();
//     lastnameController = TextEditingController();
//     registerEmailController = TextEditingController();
//     mobileController = TextEditingController();
//     emailOtpController = TextEditingController();
//     phoneOtpController = TextEditingController();
//     passwordController = TextEditingController();
//     confirmPasswordController = TextEditingController();
//   }

//   void _initializeAnimations() {
//     _tabAnimationController = AnimationController(
//       duration: _tabAnimationDuration,
//       vsync: this,
//     );
    
//     _contentAnimationController = AnimationController(
//       duration: _contentAnimationDuration,
//       vsync: this,
//     );

//     _stepAnimationController = AnimationController(
//       duration: _stepAnimationDuration,
//       vsync: this,
//     );

//     // Main content animations
//     _slideAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _contentAnimationController,
//       curve: Curves.easeInOutCubic,
//     ));

//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _contentAnimationController,
//       curve: Curves.easeInOut,
//     ));

//     _scaleAnimation = Tween<double>(
//       begin: 0.95,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _contentAnimationController,
//       curve: Curves.easeOutBack,
//     ));

//     // Step animations for registration
//     _stepSlideAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _stepAnimationController,
//       curve: Curves.easeInOutCubic,
//     ));

//     // Start initial animations
//     _tabAnimationController.forward();
//     _contentAnimationController.forward();
//     _stepAnimationController.forward();
//   }

//   void _initializeProfileController() {
//     try {
//       profileController = Get.find<UserProfileController>();
//     } catch (e) {
//       profileController = Get.put(UserProfileController());
//     }
//   }

//   void _handleInitialArguments() {
//     final args = Get.arguments as Map<String, dynamic>?;
//     if (args != null) {
//       if (args['initialTab'] == 'register') {
//         isLogin = false;
//       } else if (args['initialTab'] == 'login') {
//         isLogin = true;
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _tabAnimationController.dispose();
//     _contentAnimationController.dispose();
//     _stepAnimationController.dispose();
    
//     // Dispose login controllers
//     loginEmailController.dispose();
//     loginPasswordController.dispose();
    
//     // Dispose registration controllers
//     firstnameController.dispose();
//     lastnameController.dispose();
//     registerEmailController.dispose();
//     mobileController.dispose();
//     emailOtpController.dispose();
//     phoneOtpController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
    
//     super.dispose();
//   }

//   Future<void> _switchTab(bool loginTab) async {
//     if (isLogin == loginTab) return;

//     // Start exit animation
//     await _contentAnimationController.reverse();
    
//     setState(() {
//       isLogin = loginTab;
//       if (!loginTab) {
//         registrationStep = 1; // Reset to first registration step
//       }
//     });

//     // Start enter animation
//     await _contentAnimationController.forward();
//   }

//   Future<void> _nextRegistrationStep() async {
//     if (registrationStep < 5) {
//       await _stepAnimationController.reverse();
//       setState(() {
//         registrationStep++;
//       });
//       await _stepAnimationController.forward();
//     }
//   }

//   String _getRegistrationStepTitle() {
//     switch (registrationStep) {
//       case 1:
//         return "Personal Information";
//       case 2:
//         return "Email Verification";
//       case 3:
//         return "Mobile Number";
//       case 4:
//         return "Mobile Verification";
//       case 5:
//         return "Create Password";
//       default:
//         return "Registration";
//     }
//   }

//   String _getRegistrationButtonText() {
//     switch (registrationStep) {
//       case 5:
//         return "Create Account";
//       default:
//         return "Next";
//     }
//   }

//   Future<void> _handleLogin() async {
//     if (loginEmailController.text.trim().isEmpty ||
//         loginPasswordController.text.trim().isEmpty) {
//       _showErrorSnackbar("Email and password cannot be empty!");
//       return;
//     }

//     if (!GetUtils.isEmail(loginEmailController.text.trim())) {
//       _showErrorSnackbar("Please enter a valid email address!");
//       return;
//     }

//     if (!mounted) return;
    
//     setState(() {
//       loader = true;
//     });

//     try {
//       final isRegistered = await apiServiceUserSide.userLogin({
//         "email": loginEmailController.text.trim(),
//         "password": loginPasswordController.text.trim(),
//       });

//       if (!mounted) return;

//       if (isRegistered) {
//         await profileController.refreshToken();
//         await profileController.fetchProfile();

//         if (profileController.isLogin.value) {
//           Get.offAllNamed(UserRoutesName.homeUserView);
//         } else {
//           _showErrorSnackbar("Failed to load user profile. Please try again.");
//         }
//       } else {
//         _showErrorSnackbar(
//             "Invalid credentials. Please check your email and password.");
//       }
//     } catch (e) {
//       if (mounted) {
//         _showErrorSnackbar(
//             "Login failed. Please check your connection and try again.");
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           loader = false;
//         });
//       }
//     }
//   }

//   Future<void> _handleRegistrationNext() async {
//     if (!mounted) return;

//     setState(() {
//       loader = true;
//     });

//     try {
//       switch (registrationStep) {
//         case 1:
//           if (firstnameController.text.trim().isEmpty ||
//               lastnameController.text.trim().isEmpty ||
//               registerEmailController.text.trim().isEmpty) {
//             _showErrorSnackbar("Please fill all fields");
//             return;
//           }
//           if (!GetUtils.isEmail(registerEmailController.text.trim())) {
//             _showErrorSnackbar("Please enter a valid email");
//             return;
//           }

//           final isEmailValid = await apiServiceVenderSide
//               .checkEmail(registerEmailController.text.trim());
//           if (isEmailValid) {
//             final isEmailOtpSent = await apiServiceVenderSide
//                 .sendOtpEmail(registerEmailController.text.trim());
//             if (isEmailOtpSent) {
//               await _nextRegistrationStep();
//             }
//           }
//           break;

//         case 2:
//           if (emailOtpController.text.trim().isEmpty) {
//             _showErrorSnackbar("Please enter OTP");
//             return;
//           }

//           final isEmailOtpValid = await apiServiceVenderSide.verifyOtpEmail(
//               registerEmailController.text.trim(),
//               emailOtpController.text.trim());
//           if (isEmailOtpValid) {
//             await _nextRegistrationStep();
//           }
//           break;

//         case 3:
//           if (phoneNumber == null || countryCode == null) {
//             _showErrorSnackbar("Please enter mobile number");
//             return;
//           }

//           final isPhoneOtpSent = await apiServiceVenderSide
//               .sendOtpPhone(phoneNumber!, countryCode!);
//           if (isPhoneOtpSent) {
//             await _nextRegistrationStep();
//           }
//           break;

//         case 4:
//           if (phoneOtpController.text.trim().isEmpty) {
//             _showErrorSnackbar("Please enter OTP");
//             return;
//           }

//           final isPhoneOtpValid = await apiServiceVenderSide.verifyOtpPhone(
//             phoneNumber!,
//             countryCode!,
//             phoneOtpController.text.trim(),
//           );
//           if (isPhoneOtpValid) {
//             await _nextRegistrationStep();
//           }
//           break;

//         case 5:
//           if (passwordController.text.trim().isEmpty ||
//               confirmPasswordController.text.trim().isEmpty) {
//             _showErrorSnackbar("Please fill all password fields");
//             return;
//           }

//           if (passwordController.text.trim() !=
//               confirmPasswordController.text.trim()) {
//             _showErrorSnackbar("Passwords do not match!");
//             return;
//           }

//           final data = {
//             "email": registerEmailController.text.trim(),
//             "firstName": firstnameController.text.trim(),
//             "lastName": lastnameController.text.trim(),
//             "password": passwordController.text.trim(),
//             "country_code": countryCode,
//             "mobile_no": phoneNumber,
//             "role_type": "user"
//           };

//           final isRegistered = await apiServiceVenderSide.registerUser(data);
//           if (isRegistered) {
//             Get.offAllNamed(UserRoutesName.homeUserView);
//           }
//           break;
//       }
//     } catch (e) {
//       if (mounted) {
//         _showErrorSnackbar("An error occurred. Please try again.");
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           loader = false;
//         });
//       }
//     }
//   }

//   void _showErrorSnackbar(String message) {
//     Get.snackbar(
//       "Error",
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.error,
//       colorText: AppColors.textWhite,
//       borderRadius: 8.0,
//       margin: const EdgeInsets.all(16),
//       duration: const Duration(seconds: 3),
//     );
//   }

//   void _togglePasswordVisibility() {
//     setState(() {
//       _obscurePassword = !_obscurePassword;
//     });
//   }

//   void _toggleConfirmPasswordVisibility() {
//     setState(() {
//       _obscureConfirmPassword = !_obscureConfirmPassword;
//     });
//   }

//   void _toggleRememberMe(bool? value) {
//     setState(() {
//       _rememberMe = value ?? false;
//     });
//   }

//   // Widget builders
//   Widget _buildBackButton() {
//     return GestureDetector(
//       onTap: () => Get.back(),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: _backButtonDecoration,
//         child: const Icon(
//           Icons.arrow_back,
//           color: AppColors.textPrimary,
//           size: 20,
//         ),
//       ),
//     );
//   }

//   Widget _buildLogo() {
//     return SizedBox(
//       width: _logoSize,
//       height: _logoSize,
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.primary.withOpacity(0.2),
//               blurRadius: 15,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: Image.asset(
//             'assets/app_logo/hireme_anything_logo.png',
//             width: _logoSize,
//             height: _logoSize,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) => _buildFallbackLogo(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFallbackLogo() {
//     return DecoratedBox(
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [AppColors.primary, AppColors.primaryDark],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Stack(
//         children: [
//           const Center(
//             child: Icon(Icons.directions_car, size: 45, color: AppColors.white),
//           ),
//           Positioned(
//             bottom: 8,
//             left: 8,
//             right: 8,
//             child: Container(
//               height: 20,
//               decoration: BoxDecoration(
//                 color: AppColors.white.withOpacity(0.95),
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: const Center(
//                 child: Text(
//                   "HireAnything",
//                   style: TextStyle(
//                     fontSize: 8,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAnimatedTabButtons() {
//     return AnimatedBuilder(
//       animation: _tabAnimationController,
//       builder: (context, child) {
//         return DecoratedBox(
//           decoration: _tabContainerDecoration,
//           child: Stack(
//             children: [
//               // Animated tab indicator
//               AnimatedAlign(
//                 alignment: isLogin ? Alignment.centerLeft : Alignment.centerRight,
//                 duration: _tabAnimationDuration,
//                 curve: Curves.easeInOutCubic,
//                 child: FractionallySizedBox(
//                   widthFactor: 0.5,
//                   child: Container(
//                     margin: const EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryDark,
//                       borderRadius: BorderRadius.circular(_inputRadius - 4),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.btnColor.withOpacity(0.3),
//                           blurRadius: 8,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     height: 48,
//                   ),
//                 ),
//               ),
              
//               // Tab buttons
//               Row(
//                 children: [
//                   // Login Tab
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () => _switchTab(true),
//                       child: AnimatedContainer(
//                         duration: _tabAnimationDuration,
//                         curve: Curves.easeInOutCubic,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             AnimatedScale(
//                               scale: isLogin ? 1.0 : 0.9,
//                               duration: _tabAnimationDuration,
//                               child: Icon(
//                                 Icons.login,
//                                 size: 18,
//                                 color: isLogin ? AppColors.white : AppColors.textSecondary,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             AnimatedDefaultTextStyle(
//                               style: isLogin ? _tabActiveStyle : _tabInactiveStyle,
//                               duration: _tabAnimationDuration,
//                               child: const Text("Login"),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Register Tab
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () => _switchTab(false),
//                       child: AnimatedContainer(
//                         duration: _tabAnimationDuration,
//                         curve: Curves.easeInOutCubic,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             AnimatedScale(
//                               scale: !isLogin ? 1.0 : 0.9,
//                               duration: _tabAnimationDuration,
//                               child: Icon(
//                                 Icons.person_add,
//                                 size: 18,
//                                 color: !isLogin ? AppColors.white : AppColors.textSecondary,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             AnimatedDefaultTextStyle(
//                               style: !isLogin ? _tabActiveStyle : _tabInactiveStyle,
//                               duration: _tabAnimationDuration,
//                               child: const Text("Register"),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildProgressIndicator() {
//     if (isLogin) return const SizedBox();
    
//     return Column(
//       children: [
//         Row(
//           children: List.generate(5, (index) {
//             final isActive = index < registrationStep;
//             return Expanded(
//               child: Container(
//                 height: 4,
//                 margin: EdgeInsets.only(right: index < 4 ? 8 : 0),
//                 decoration: BoxDecoration(
//                   color: isActive ? AppColors.btnColor : AppColors.borderLight,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//             );
//           }),
//         ),
//         const SizedBox(height: 15),
//         Text(
//           _getRegistrationStepTitle(),
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimary,
//           ),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           "Step $registrationStep of 5",
//           style: const TextStyle(
//             fontSize: 12,
//             color: AppColors.textSecondary,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildInputField({
//     required TextEditingController controller,
//     required String hintText,
//     required IconData prefixIcon,
//     TextInputType? keyboardType,
//     bool obscureText = false,
//     Widget? suffixIcon,
//     int? maxLength,
//   }) {
//     return DecoratedBox(
//       decoration: _inputFieldDecoration,
//       child: TextField(
//         controller: controller,
//         keyboardType: keyboardType,
//         obscureText: obscureText,
//         style: _inputTextStyle,
//         maxLength: maxLength,
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: _hintTextStyle,
//           prefixIcon: Icon(prefixIcon, color: AppColors.textLight),
//           suffixIcon: suffixIcon,
//           border: InputBorder.none,
//           contentPadding: _inputPadding,
//           counterText: "",
//         ),
//       ),
//     );
//   }

//   Widget _buildPhoneField() {
//     return Container(
//       decoration: _inputFieldDecoration,
//       child: IntlPhoneField(
//         controller: mobileController,
//         flagsButtonPadding: const EdgeInsets.all(8),
//         decoration: const InputDecoration(
//           hintText: "Mobile Number",
//           hintStyle: _hintTextStyle,
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
//         ),
//         style: _inputTextStyle,
//         initialCountryCode: 'IN',
//         onChanged: (value) {
//           setState(() {
//             phoneNumber = value.number;
//             countryCode = value.countryCode;
//           });
//         },
//       ),
//     );
//   }

//   Widget _buildAnimatedContent() {
//     return AnimatedBuilder(
//       animation: _contentAnimationController,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset(
//             (isLogin ? -1 : 1) * (1 - _slideAnimation.value) * 50,
//             0,
//           ),
//           child: Transform.scale(
//             scale: _scaleAnimation.value,
//             child: Opacity(
//               opacity: _fadeAnimation.value,
//               child: Column(
//                 children: [
//                   // Progress indicator for registration
//                   _buildProgressIndicator(),
//                   if (!isLogin) const SizedBox(height: 20),
                  
//                   // Content based on tab
//                   isLogin ? _buildLoginContent() : _buildRegistrationContent(),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildLoginContent() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // Email Field
//         const Text("Email", style: _fieldLabelStyle),
//         const SizedBox(height: 10),
//         _buildInputField(
//           controller: loginEmailController,
//           hintText: "Enter email",
//           prefixIcon: Icons.email_outlined,
//           keyboardType: TextInputType.emailAddress,
//         ),
        
//         const SizedBox(height: 20),
        
//         // Password Field
//         const Text("Password", style: _fieldLabelStyle),
//         const SizedBox(height: 10),
//         _buildInputField(
//           controller: loginPasswordController,
//           hintText: "Enter password",
//           prefixIcon: Icons.lock_outline,
//           obscureText: _obscurePassword,
//           suffixIcon: GestureDetector(
//             onTap: _togglePasswordVisibility,
//             child: Icon(
//               _obscurePassword ? Icons.visibility_off : Icons.visibility,
//               color: AppColors.textLight,
//             ),
//           ),
//         ),
        
//         const SizedBox(height: 15),
        
//         // Remember me and Forgot Password
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Transform.scale(
//                   scale: 0.9,
//                   child: Checkbox(
//                     value: _rememberMe,
//                     onChanged: _toggleRememberMe,
//                     activeColor: AppColors.btnColor,
//                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   ),
//                 ),
//                 const Text("Remember me", style: _checkboxTextStyle),
//               ],
//             ),
//             TextButton(
//               onPressed: () {
//                 // Handle forgot password
//               },
//               child: const Text("Forgot Password?", style: _forgotPasswordStyle),
//             ),
//           ],
//         ),
        
//         const SizedBox(height: 25),
        
//         // Login Button
//         _buildAnimatedButton(
//           onPressed: loader ? null : _handleLogin,
//           text: "Login",
//         ),
//       ],
//     );
//   }

//   Widget _buildRegistrationContent() {
//     return AnimatedBuilder(
//       animation: _stepAnimationController,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset((1 - _stepSlideAnimation.value) * 30, 0),
//           child: Opacity(
//             opacity: _stepSlideAnimation.value,
//             child: _buildRegistrationStep(),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildRegistrationStep() {
//     switch (registrationStep) {
//       case 1:
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text("First Name", style: _fieldLabelStyle),
//             const SizedBox(height: 10),
//             _buildInputField(
//               controller: firstnameController,
//               hintText: "Enter first name",
//               prefixIcon: Icons.person_outline,
//               keyboardType: TextInputType.name,
//             ),
//             const SizedBox(height: 20),
//             const Text("Last Name", style: _fieldLabelStyle),
//             const SizedBox(height: 10),
//             _buildInputField(
//               controller: lastnameController,
//               hintText: "Enter last name",
//               prefixIcon: Icons.person_outline,
//               keyboardType: TextInputType.name,
//             ),
//             const SizedBox(height: 20),
//             const Text("Email", style: _fieldLabelStyle),
//             const SizedBox(height: 10),
//             _buildInputField(
//               controller: registerEmailController,
//               hintText: "Enter email",
//               prefixIcon: Icons.email_outlined,
//               keyboardType: TextInputType.emailAddress,
//             ),
//             const SizedBox(height: 25),
//             _buildAnimatedButton(
//               onPressed: loader ? null : _handleRegistrationNext,
//               text: _getRegistrationButtonText(),
//             ),
//           ],
//         );

//       case 2:
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text("OTP", style: _fieldLabelStyle),
//             const SizedBox(height: 10),
//             _buildInputField(
//               controller: emailOtpController,
//               hintText: "Enter OTP",
//               prefixIcon: Icons.sms_outlined,
//               keyboardType: TextInputType.number,
//               maxLength: 6,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "We've sent a verification code to ${registerEmailController.text}",
//               style: const TextStyle(
//                 fontSize: 12,
//                 color: AppColors.textSecondary,
//               ),
//             ),
//             const SizedBox(height: 25),
//             _buildAnimatedButton(
//               onPressed: loader ? null : _handleRegistrationNext,
//               text: _getRegistrationButtonText(),
//             ),
//           ],
//         );

//       case 3:
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text("Mobile Number", style: _fieldLabelStyle),
//             const SizedBox(height: 10),
//             _buildPhoneField(),
//             const SizedBox(height: 25),
//             _buildAnimatedButton(
//               onPressed: loader ? null : _handleRegistrationNext,
//               text: _getRegistrationButtonText(),
//             ),
//           ],
//         );

//       case 4:
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text("OTP", style: _fieldLabelStyle),
//             const SizedBox(height: 10),
//             _buildInputField(
//               controller: phoneOtpController,
//               hintText: "Enter OTP",
//               prefixIcon: Icons.sms_outlined,
//               keyboardType: TextInputType.number,
//               maxLength: 6,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "We've sent a verification code to $countryCode$phoneNumber",
//               style: const TextStyle(
//                 fontSize: 12,
//                 color: AppColors.textSecondary,
//               ),
//             ),
//             const SizedBox(height: 25),
//             _buildAnimatedButton(
//               onPressed: loader ? null : _handleRegistrationNext,
//               text: _getRegistrationButtonText(),
//             ),
//           ],
//         );

//       case 5:
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text("Create Password", style: _fieldLabelStyle),
//             const SizedBox(height: 10),
//             _buildInputField(
//               controller: passwordController,
//               hintText: "Enter password",
//               prefixIcon: Icons.lock_outline,
//               obscureText: _obscurePassword,
//               suffixIcon: GestureDetector(
//                 onTap: _togglePasswordVisibility,
//                 child: Icon(
//                   _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                   color: AppColors.textLight,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text("Confirm Password", style: _fieldLabelStyle),
//             const SizedBox(height: 10),
//             _buildInputField(
//               controller: confirmPasswordController,
//               hintText: "Confirm password",
//               prefixIcon: Icons.lock_outline,
//               obscureText: _obscureConfirmPassword,
//               suffixIcon: GestureDetector(
//                 onTap: _toggleConfirmPasswordVisibility,
//                 child: Icon(
//                   _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
//                   color: AppColors.textLight,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 25),
//             _buildAnimatedButton(
//               onPressed: loader ? null : _handleRegistrationNext,
//               text: _getRegistrationButtonText(),
//             ),
//           ],
//         );

//       default:
//         return const SizedBox();
//     }
//   }

//   Widget _buildAnimatedButton({
//     required VoidCallback? onPressed,
//     required String text,
//   }) {
//     return TweenAnimationBuilder<double>(
//       duration: const Duration(milliseconds: 200),
//       tween: Tween(begin: 1.0, end: onPressed == null ? 0.95 : 1.0),
//       builder: (context, scale, child) {
//         return Transform.scale(
//           scale: scale,
//           child: DecoratedBox(
//             decoration: _buttonShadowDecoration,
//             child: SizedBox(
//               width: double.infinity,
//               height: _buttonHeight,
//               child: ElevatedButton(
//                 onPressed: onPressed,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.btnColor,
//                   foregroundColor: AppColors.white,
//                   disabledBackgroundColor: AppColors.disabledBtnColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(_inputRadius),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: loader
//                     ? const SizedBox(
//                         height: 24,
//                         width: 24,
//                         child: CircularProgressIndicator(
//                           color: AppColors.white,
//                           strokeWidth: 2.5,
//                         ),
//                       )
//                     : Text(text, style: _buttonTextStyle),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               physics: const ClampingScrollPhysics(),
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(minHeight: constraints.maxHeight),
//                 child: IntrinsicHeight(
//                   child: Column(
//                     children: [
//                       // Header with back button
//                       Padding(
//                         padding: _containerPadding,
//                         child: Row(
//                           children: [_buildBackButton()],
//                         ),
//                       ),

//                       // Logo and titles - hide when keyboard is open
//                       MediaQuery.of(context).viewInsets.bottom > 0
//                           ? const SizedBox(height: 10)
//                           : Column(
//                               children: [
//                                 _buildLogo(),
//                                 const SizedBox(height: 20),
//                                 const Text("Secure Access Portal", style: _titleStyle),
//                                 const SizedBox(height: 8),
//                                 Text(
//                                   isLogin 
//                                     ? "Login to Access your account" 
//                                     : "Create your new account",
//                                   style: _subtitleStyle,
//                                 ),
//                                 const SizedBox(height: 30),
//                               ],
//                             ),

//                       // Main Authentication Container with Shadow
//                       Flexible(
//                         child: Container(
//                           width: double.infinity,
//                           margin: const EdgeInsets.symmetric(horizontal: 20),
//                           decoration: _mainContainerDecoration,
//                           child: Padding(
//                             padding: _containerPadding,
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const SizedBox(height: 20),
                                
//                                 // Animated Tab Buttons
//                                 _buildAnimatedTabButtons(),
//                                 const SizedBox(height: 30),
                                
//                                 // Animated Content
//                                 _buildAnimatedContent(),
//                                 const SizedBox(height: 20),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
