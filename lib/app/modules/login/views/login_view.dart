import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_blog/app/routes/app_pages.dart';
import 'package:app_blog/app/modules/login/controllers/login_controller.dart';
import 'package:app_blog/app/data/models/req/login_required_model.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});


  @override
  final controller = Get.put(LoginController());

  final _formKey = GlobalKey<FormState>();
  final _emailCon = TextEditingController();
  final _passCon = TextEditingController();

  // Primary Theme Color (Matching image_0.png)
  static const primaryColor = Color(0xFFFFA000); // Amber 700

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              _buildOrangeHeader(context),

              // Login Form Section
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                  child: Column(
                    children: [
                      // "hello!" welcome text
                      Text(
                        "hello!",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Username/Email Field
                      _buildPillTextField(
                        controller: _emailCon,
                        hintText: "Email",
                        icon: Icons.email_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) return "Email is required";
                          if (!GetUtils.isEmail(value)) return "Enter a valid email";
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password Field (With Obscure Text toggle logic)
                      Obx(() => _buildPillTextField(
                        controller: _passCon,
                        hintText: "Password",
                        icon: Icons.lock_outlined,
                        obscureText: !controller.isPasswordVisible.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            controller.isPasswordVisible.toggle();
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return "Password required";
                          return null;
                        },
                      )),
                      const SizedBox(height: 24),

                      // SIGN UP/LOGIN BUTTON
                      Obx(() => SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            elevation: 4,
                          ),
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              final req = LoginReqModel(
                                email: _emailCon.text,
                                password: _passCon.text,
                              );
                              controller.login(req);
                            }
                          },
                          child: controller.isLoading.value
                              ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                              : const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )),
                      const SizedBox(height: 30),

                      // Divider "or"
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade400)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("or", style: TextStyle(color: Colors.grey)),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade400)),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // GOOGLE LOGIN BUTTON (Added as requested)
                      _buildGoogleLoginButton(),
                      const SizedBox(height: 30),

                      // Don't have an account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () => Get.toNamed(Routes.REGISTER),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- UI Component Helper Methods ---

  // Top header with the logo
  Widget _buildOrangeHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for Logo (Like the N-icon)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.account_balance,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "YourApp.com",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // Consistent Pill-shaped TextFormField
  Widget _buildPillTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: Colors.grey),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // New Google Sign-In Button
  Widget _buildGoogleLoginButton() {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: MaterialButton(
        onPressed: () {
          // TODO: Call Google Login logic from your controller
          // controller.loginWithGoogle();
          Get.snackbar("Notice", "Google Login tapped.");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset('assets/images/google_logo.png', height: 24),
            SizedBox(width: 6),
            Text(
              "Continue with Google",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}