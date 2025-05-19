import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    if (!email.endsWith("@gmail.com")) {
      onValidationError("email", "Email harus menggunakan @gmail.com");
      return;
    }
    if (name.length < 3) {
      onValidationError("name", "Nama minimal 3 karakter");
      return;
    }
    if (password.length < 6) {
      onValidationError("password", "Password minimal 6 karakter");
      return;
    }
    if (confirmPassword != password) {
      onValidationError("confirmPassword", "Konfirmasi password tidak cocok");
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(name);

      onSuccess();

      Fluttertoast.showToast(
        msg: "Akun berhasil dibuat",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );

      Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
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
