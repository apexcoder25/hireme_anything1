import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/utilities/colors.dart';
import 'controllers/auth_controller.dart';
import 'components/auth_logo.dart';
import 'login/user_login_screen.dart';
import 'register/user_register_screen.dart';

class MainAuthScreen extends StatefulWidget {
  const MainAuthScreen({super.key});

  @override
  State<MainAuthScreen> createState() => _MainAuthScreenState();
}

class _MainAuthScreenState extends State<MainAuthScreen>
    with TickerProviderStateMixin {
  late AuthController authController;
  late AnimationController _contentAnimationController;
  late Animation<double> _contentAnimation;

  late Map<String, TextEditingController> _controllers;

  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
    _initializeControllers();
    _initializeAnimations();
    _handleInitialArguments();
  }

  void _initializeController() {
    authController = Get.put(AuthController(), permanent: true);
  }

  void _initializeControllers() {
    _controllers = {
      'loginEmail': TextEditingController(),
      'loginPassword': TextEditingController(),
      'firstName': TextEditingController(),
      'lastName': TextEditingController(),
      'email': TextEditingController(),
      'mobile': TextEditingController(),
      'emailOtp': TextEditingController(),
      'phoneOtp': TextEditingController(),
      'password': TextEditingController(),
      'confirmPassword': TextEditingController(),
    };
  }

  void _initializeAnimations() {
    _contentAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _contentAnimation = CurvedAnimation(
      parent: _contentAnimationController,
      curve: Curves.easeInOut,
    );

    _contentAnimationController.forward();
  }

  void _handleInitialArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      if (args['initialTab'] == 'register') {
        authController.switchToRegister();
      } else {
        authController.switchToLogin();
      }
    }
  }

  @override
  void dispose() {
    _contentAnimationController.dispose();
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _switchTab(bool loginTab) async {
    if (authController.isLogin == loginTab || _isAnimating) return;

    setState(() => _isAnimating = true);

    // Quick fade out
    await _contentAnimationController.reverse();
    
    // Switch tab
    if (loginTab) {
      authController.switchToLogin();
    } else {
      authController.switchToRegister();
    }

    // Quick fade in
    await _contentAnimationController.forward();
    
    setState(() => _isAnimating = false);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  _buildHeader(),
                  _buildLogoSection(),
                  _buildMainContainer(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.textPrimary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoSection() {
    return MediaQuery.of(context).viewInsets.bottom > 0
        ? const SizedBox(height: 10)
        : GetBuilder<AuthController>(
            builder: (controller) => Column(
              children: [
                const AuthLogo(),
                const SizedBox(height: 20),
                const Text(
                  "Secure Access Portal", 
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  controller.isLogin 
                    ? "Login to Access your account" 
                    : "Create your new account",
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
  }

  Widget _buildMainContainer() {
    return Flexible(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 20,
              spreadRadius: 4,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              _buildSimpleTabButtons(),
              const SizedBox(height: 30),
              _buildAnimatedContent(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleTabButtons() {
    return GetBuilder<AuthController>(
      builder: (controller) => Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.backgroundDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderLight, width: 1),
        ),
        child: Stack(
          children: [
            // SIMPLE animated indicator - no complex calculations
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              left: controller.isLogin ? 4 : null,
              right: controller.isLogin ? null : 4,
              top: 4,
              bottom: 4,
              width: (MediaQuery.of(context).size.width - 88) / 2,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.btnColor.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
            
            // Tab buttons
            Row(
              children: [
                // Login Tab
                Expanded(
                  child: GestureDetector(
                    onTap: () => _switchTab(true),
                    child: Container(
                      height: 56,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.login,
                            size: 18,
                            color: controller.isLogin ? AppColors.white : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Login",
                            style: TextStyle(
                              color: controller.isLogin ? AppColors.white : AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Register Tab
                Expanded(
                  child: GestureDetector(
                    onTap: () => _switchTab(false),
                    child: Container(
                      height: 56,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_add,
                            size: 18,
                            color: !controller.isLogin ? AppColors.white : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Register",
                            style: TextStyle(
                              color: !controller.isLogin ? AppColors.white : AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedContent() {
    return GetBuilder<AuthController>(
      builder: (controller) => FadeTransition(
        opacity: _contentAnimation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(controller.isLogin ? -0.1 : 0.1, 0.0),
            end: Offset.zero,
          ).animate(_contentAnimation),
          child: controller.isLogin 
            ? UserLoginContent(
                authController: authController,
                emailController: _controllers['loginEmail']!,
                passwordController: _controllers['loginPassword']!,
              )
            : UserRegisterContent(
                authController: authController,
                controllers: _controllers,
              ),
        ),
      ),
    );
  }
}
