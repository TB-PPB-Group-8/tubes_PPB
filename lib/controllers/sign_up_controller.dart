import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(
    BuildContext context,
    String email,
    String password,
    String confirmPassword,
    String name,
  ) async {
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showError(context, "Please fill in all fields.");
      return;
    }

    if (password != confirmPassword) {
      _showError(context, "Passwords do not match.");
      return;
    }

    try {
      // Create user with Firebase Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user data to Firestore
      await _firestore.collection('user').doc(userCredential.user?.uid).set({
        'email': email,
        'password': password, // Ideally, hash this password before saving
        'name': name,
        'created_at': FieldValue.serverTimestamp(),
      });

      // Show success snackbar and navigate to login screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Sign up berhasil"),
          duration: const Duration(seconds: 2),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    } catch (e) {
      print("Error during sign up: $e");
      _showError(context, "Sign up failed. Please try again.");
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
