import 'package:flutter/material.dart';
import '../controllers/sign_up_controller.dart'; // Tetap gunakan import controller
import '../widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _emailError;
  String? _nameError;
  String? _passwordError;
  String? _confirmPasswordError;

  bool _emailTouched = false;
  bool _nameTouched = false;
  bool _passwordTouched = false;
  bool _confirmPasswordTouched = false;

  final SignUpController _controller = SignUpController();

  void _updateError(String field, String? error) {
    setState(() {
      if (field == "email") _emailError = error;
      if (field == "name") _nameError = error;
      if (field == "password") _passwordError = error;
      if (field == "confirmPassword") _confirmPasswordError = error;
    });
  }

  void _onFieldChanged(String field, String value) {
    setState(() {
      if (field == "email") {
        _emailTouched = true;
        _emailError = value.endsWith("@") ? null : "format email tidak valid";
      }
      if (field == "name") {
        _nameTouched = true;
        _nameError = value.length >= 3 ? null : "Nama minimal 3 karakter";
      }
      if (field == "password") {
        _passwordTouched = true;
        _passwordError =
            value.length >= 6 ? null : "Password minimal 6 karakter";
      }
      if (field == "confirmPassword") {
        _confirmPasswordTouched = true;
        _confirmPasswordError =
            value == _passwordController.text ? null : "Konfirmasi tidak cocok";
      }
    });
  }

  Future<void> _saveToFirebase() async {
    _controller.signUp(
      context,
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _confirmPasswordController.text.trim(),
      _nameController.text.trim(),
      () async {
        // Callback ketika registrasi berhasil
        Navigator.pushReplacementNamed(context, '/login');
      },
      (field, message) {
        // Callback untuk error validasi
        _updateError(field, message);
        setState(() {
          if (field == "email") _emailTouched = true;
          if (field == "name") _nameTouched = true;
          if (field == "password") _passwordTouched = true;
          if (field == "confirmPassword") _confirmPasswordTouched = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A7DF4),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            IconButton(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(0),
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            const Text(
              "Sign up",
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: "Email",
              controller: _emailController,
              hintText: "example@gmail.com",
              errorText: _emailError,
              showError: _emailTouched,
              onChanged: (value) => _onFieldChanged("email", value),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: "Name",
              controller: _nameController,
              hintText: "your name",
              errorText: _nameError,
              showError: _nameTouched,
              onChanged: (value) => _onFieldChanged("name", value),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: "Create password",
              controller: _passwordController,
              hintText: "Must be 6 characters",
              isPassword: true,
              isPasswordVisible: _isPasswordVisible,
              onTogglePassword: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              errorText: _passwordError,
              showError: _passwordTouched,
              onChanged: (value) => _onFieldChanged("password", value),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: "Confirm password",
              controller: _confirmPasswordController,
              hintText: "Repeat password",
              isPassword: true,
              isPasswordVisible: _isPasswordVisible,
              onTogglePassword: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              errorText: _confirmPasswordError,
              showError: _confirmPasswordTouched,
              onChanged: (value) => _onFieldChanged("confirmPassword", value),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveToFirebase,
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
            const SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  Image.asset('assets/images/lazada_logo2.png', height: 60),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
