import 'package:flutter/material.dart';
import '../controllers/sign_up_controller.dart';
import '../widgets/custom_text_field.dart'; 

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final SignUpController _controller = SignUpController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A7DF4),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 30),
              const Text(
                "Sign up",
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 50),
              CustomTextField(
                label: "Email",
                labelStyle: const TextStyle(color: Colors.black), 
                controller: _emailController,
                hintText: "example@gmail.com",
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: "Name",
                labelStyle: const TextStyle(color: Colors.black), 
                controller: _nameController,
                hintText: "your name",
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: "Create password",
                labelStyle: const TextStyle(color: Colors.black), 
                controller: _passwordController,
                hintText: "Must be 6 characters",
                isPassword: true,
                onTogglePassword: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                isPasswordVisible: _isPasswordVisible,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: "Confirm password",
                labelStyle: const TextStyle(color: Colors.black), 
                controller: _confirmPasswordController,
                hintText: "Repeat password",
                isPassword: true,
                onTogglePassword: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                isPasswordVisible: _isPasswordVisible,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _controller.signUp(
                    context,
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                    _confirmPasswordController.text.trim(),
                    _nameController.text.trim(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.black,
                ),
                child: const Text(
                  "Sign up",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/login'),
                child: Center(
                  child: RichText(
                    text: const TextSpan(
                      text: "Already have an Account? ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60), 
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/lazada_logo2.png', 
                      height: 60, 
                    ),
                    const SizedBox(height: 8), 
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
