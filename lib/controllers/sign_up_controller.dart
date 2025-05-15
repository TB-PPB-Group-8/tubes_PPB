import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:flutter/material.dart';

class SignUpController {
  Future<void> signUp(
    BuildContext context,
    String email,
    String password,
    String confirmPassword,
    String name,
    VoidCallback onSuccess,
    Function(String field, String error) onValidationError,
  ) async {
    // Validasi email
    if (!email.endsWith("@gmail.com")) {
      onValidationError("email", "Email harus menggunakan @gmail.com");
      return;
    }

    // Validasi nama
    if (name.length < 3) {
      onValidationError("name", "Nama minimal 3 karakter");
      return;
    }

    // Validasi password
    if (password.length < 6) {
      onValidationError("password", "Password minimal 6 karakter");
      return;
    }

    // Validasi konfirmasi password
    if (confirmPassword != password) {
      onValidationError("confirmPassword", "Konfirmasi password tidak cocok");
      return;
    }

    try {
      // Menggunakan FirebaseAuth untuk mendaftar pengguna
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Menambahkan nama pengguna di FirebaseAuth
      await userCredential.user?.updateDisplayName(name);

      // Panggil callback sukses jika pendaftaran berhasil
      onSuccess();

      // Tampilkan SnackBar sukses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Akun berhasil dibuat")),
      );

      // Navigasi ke halaman login
      Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      // Tangani error FirebaseAuth, misalnya email sudah terdaftar atau password lemah
      if (e.code == 'weak-password') {
        onValidationError("password", "Password terlalu lemah");
      } else if (e.code == 'email-already-in-use') {
        onValidationError("email", "Email sudah digunakan");
      } else {
        onValidationError("email", "Terjadi kesalahan, silakan coba lagi");
      }
    }
  }
}
