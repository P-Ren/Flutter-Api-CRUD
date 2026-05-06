import 'package:app_blog/app/data/models/req/register_req_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameCon = TextEditingController();
  final _emailCon = TextEditingController();
  final _passCon = TextEditingController();

  // Primary Color to match your Login design
  static const primaryColor = Color(0xFFFFA000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. Matching Orange Header
              _buildHeader(),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Create Account!",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // 2. Name Field
                      _buildPillInput(
                        controller: _nameCon,
                        hint: "Full Name",
                        icon: Icons.person_outline,
                        validator: (v) => (v == null || v.isEmpty) ? "Name is required" : null,
                      ),
                      const SizedBox(height: 20),

                      // 3. Email Field
                      _buildPillInput(
                        controller: _emailCon,
                        hint: "Email Address",
                        icon: Icons.email_outlined,
                        validator: (v) {
                          if (v == null || v.isEmpty) return "Email is required";
                          if (!GetUtils.isEmail(v)) return "Invalid email";
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // 4. Password Field
                      _buildPillInput(
                        controller: _passCon,
                        hint: "Password",
                        icon: Icons.lock_outline,
                        obscureText: true,
                        validator: (v) => (v == null || v.isEmpty) ? "Password is required" : null,
                      ),
                      const SizedBox(height: 30),

                      // 5. Register Button (Stadium Shape)
                      Obx(() => SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(), // Professional pill shape
                            elevation: 3,
                          ),
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              final req = RegisterModel(
                                name: _nameCon.text,
                                email: _emailCon.text,
                                password: _passCon.text,
                              );
                              controller.register(req);
                            }
                          },
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("Register", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      )),

                      const SizedBox(height: 20),

                      // Back to Login
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text("Already have an account? Login", style: TextStyle(color: Colors.grey)),
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

  // --- UI Helpers ---

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: const BoxDecoration(

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: const Center(
        child: Icon(Icons.app_registration, size: 80, color: Colors.blue),
      ),
    );
  }

  Widget _buildPillInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: primaryColor),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30), // Fix for your previous error
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}