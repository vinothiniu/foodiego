import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/constants/assets_constants.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create controllers locally within the build method
    final TextEditingController emailController = TextEditingController(text: "vinothiniumaidurai0810@gmail.com");
    final TextEditingController passwordController = TextEditingController(text: "password");
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Stack(
        children: [
          // Background design
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
              ),
            ),
          ),

          // Top design curves
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),

          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),

          // Main content - Use SingleChildScrollView to fix overflow
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    SizedBox(height: 40),

                    // Title
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    // Subtitle
                    Text(
                      'Sign in to continue',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),

                    SizedBox(height: 40),

                    // Login form
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          // Email field
                          _buildTextField(
                            controller: emailController,
                            hint: "Email",
                            prefixIcon: Icons.email_outlined,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!GetUtils.isEmail(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20),

                          // Password field - Fix by directly accessing observable property
                          GetBuilder<AuthController>(
                            builder: (ctrl) => _buildTextField(
                              controller: passwordController,
                              hint: "Password",
                              prefixIcon: Icons.lock_outline,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                          ),

                          SizedBox(height: 15),

                          // Remember me and forgot password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Remember me - Fix by properly using Obx
                              Row(
                                children: [
                                  Obx(() => Checkbox(
                                    value: controller.rememberMe.value,
                                    onChanged: (value) {
                                      controller.toggleRememberMe();
                                    },
                                    activeColor: Theme.of(context).colorScheme.secondary,
                                    checkColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  )),
                                  Text(
                                    'Remember me',
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),

                              // Forgot password
                              TextButton(
                                onPressed: () {
                                  // Implement forgot password functionality
                                  Get.snackbar(
                                    'Info',
                                    'Forgot password functionality not implemented',
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 30),

                          // Login button - Fix by properly using Obx
                          Obx(() => ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : () => _handleLogin(formKey, emailController, passwordController, controller),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Theme.of(context).colorScheme.secondary,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            child: controller.isLoading.value
                                ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                                : Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),

                          SizedBox(height: 20),

                          // Register link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Navigate to register screen
                                  Get.snackbar(
                                    'Info',
                                    'Registration functionality not implemented',
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Add bottom padding for scrolling
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white60),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.white70,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15),
      ),
      validator: validator,
    );
  }

  void _handleLogin(GlobalKey<FormState> formKey, TextEditingController emailController,
      TextEditingController passwordController, AuthController controller) {
    if (formKey.currentState!.validate()) {
      // Hide keyboard
      FocusScope.of(Get.context!).unfocus();

      // Login with entered credentials
      controller.login(
        emailController.text.trim(),
        passwordController.text,
      );
    }
  }
}