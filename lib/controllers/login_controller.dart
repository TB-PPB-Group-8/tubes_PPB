import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginController {
  Future<void> login(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Email dan Password tidak boleh kosong.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        Fluttertoast.showToast(
          msg: "Login berhasil!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
        );

        await Navigator.pushReplacementNamed(context, '/home');
      } else {
        Fluttertoast.showToast(
          msg: "Login gagal. Coba lagi.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: code=${e.code}, message=${e.message}');
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: "Email tidak terdaftar.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: "Password salah.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Terjadi kesalahan, silakan coba lagi.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }
}
