import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
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
      // Menggunakan FirebaseAuth untuk login pengguna
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Mengakses data pengguna dari userCredential
      User? user = userCredential.user;

      // Cek apakah user berhasil login
      if (user != null) {
        // Menggunakan null-aware operator untuk mengambil displayName, jika null, set "User"
        String name =
            user.displayName ?? "User"; // Nama default jika displayName null

        // Menyimpan email dan nama pengguna di SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', user.email ?? '');
        await prefs.setString('name', name);

        print('Email: $email');
        print('Name: $name'); // Menyimpan nama, jika displayName null

        // Log keberhasilan login
        print("Login berhasil! Email dan nama disimpan di SharedPreferences.");

        setErrorMessage(null);

        // Navigasi ke halaman utama setelah login berhasil
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Jika user null, beri pesan error
        setErrorMessage("Login gagal. Coba lagi.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setErrorMessage("Email tidak terdaftar.");
      } else if (e.code == 'wrong-password') {
        setErrorMessage("Password salah.");
      } else {
        setErrorMessage("Terjadi kesalahan, silakan coba lagi.");
      }
    }
  }
}
