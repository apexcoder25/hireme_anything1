import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/vendor_auth_controller.dart';
import 'components/auth_logo.dart';
import 'login/vendor_login_screen.dart';
import 'register/vendor_register_screen.dart';

class VendorMainAuthScreen extends StatefulWidget {
  const VendorMainAuthScreen({super.key});

  @override
  State<VendorMainAuthScreen> createState() => _VendorMainAuthScreenState();
}

class _VendorMainAuthScreenState extends State<VendorMainAuthScreen>
    with TickerProviderStateMixin {
  late VendorAuthController authController;
  late AnimationController _contentAnimationController;
  late Animation<double> _contentAnimation;

  bool _isAnimating = false;
  bool _isLoginTab = true;

  @override
  void initState() {
    super.initState();
    _initializeController();
    _initializeAnimations();
    _handleInitialArguments();
  }

  void _initializeController() {
    authController = Get.put(VendorAuthController(), permanent: true);
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
        setState(() {
          _isLoginTab = false;
        });
      } else {
        setState(() {
          _isLoginTab = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _contentAnimationController.dispose();
    super.dispose();
  }

  Future<void> _switchTab(bool loginTab) async {
    if (_isLoginTab == loginTab || _isAnimating) return;

    setState(() {
      _isAnimating = true;
    });

    // Quick fade out
    await _contentAnimationController.reverse();

    // Switch tab
    setState(() {
      _isLoginTab = loginTab;
    });

    if (!loginTab) {
      authController.resetRegistration();
    }

    // Quick fade in
    await _contentAnimationController.forward();

    setState(() {
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black87,
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
        : Column(
            children: [
              const VendorAuthLogo(
                height: 80,
              ),
              const SizedBox(height: 20),
              Text(
                _isLoginTab ? 'Partner Login' : 'Partner Sign Up',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _isLoginTab
                    ? 'Access your partner dashboard'
                    : 'Join us as a service provider',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),
            ],
          );
  }

  Widget _buildMainContainer() {
    return Flexible(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
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
              _buildTabButtons(),
              const SizedBox(height: 30),
              _buildAnimatedContent(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButtons() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Stack(
        children: [
          // Animated indicator
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            left: _isLoginTab ? 4 : null,
            right: _isLoginTab ? null : 4,
            top: 4,
            bottom: 4,
            width: (MediaQuery.of(context).size.width - 88) / 2,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff0e53ce),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff0e53ce).withOpacity(0.4),
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
                          color: _isLoginTab ? Colors.white : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Login',
                          style: TextStyle(
                            color: _isLoginTab ? Colors.white : Colors.grey,
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
                          Icons.business,
                          size: 18,
                          color: !_isLoginTab ? Colors.white : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Register',
                          style: TextStyle(
                            color: !_isLoginTab ? Colors.white : Colors.grey,
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
    );
  }

  Widget _buildAnimatedContent() {
    return FadeTransition(
      opacity: _contentAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(_isLoginTab ? -0.1 : 0.1, 0.0),
          end: Offset.zero,
        ).animate(_contentAnimation),
        child: _isLoginTab
            ? VendorLoginContent(
                authController: authController,
                emailController: authController.emailController,
                passwordController: authController.passwordController,
              )
            : VendorRegisterContent(
                authController: authController,
              ),
      ),
    );
  }
}
