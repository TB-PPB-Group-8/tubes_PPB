import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    Function(String?) setErrorMessage,
  ) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setErrorMessage("Email dan Password tidak boleh kosong.");
      return;
    }

    try {
      // Query Firestore untuk mencocokkan email dan password
      QuerySnapshot userSnapshot = await _firestore
          .collection('user')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        // Login berhasil
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'email', email); // Simpan email ke SharedPreferences
        print("Login berhasil! Email disimpan di SharedPreferences.");
        setErrorMessage(null); // Reset pesan error jika ada
        Navigator.pushReplacementNamed(context, '/home'); // Navigasi ke Home
      } else {
        // Login gagal
        setErrorMessage("Email atau Password salah.");
      }
    } catch (e) {
      print("Error saat login: $e");
      setErrorMessage("Terjadi kesalahan. Silakan coba lagi.");
    }
  }
}
