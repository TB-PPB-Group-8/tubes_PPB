import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // Mendapatkan email pengguna yang sedang login
  static Future<String?> getEmailFromPreferences() async {
    // Menggunakan FirebaseAuth untuk mendapatkan email pengguna yang sedang login
    User? user = FirebaseAuth.instance.currentUser;
    return user?.email;
  }

  // Mendapatkan data pengguna dari FirebaseAuth (nama dan email)
  static Future<Map<String, String>> fetchUserData(String email) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.email == email) {
      return {
        'name':
            user.displayName ?? 'No Name', // Mengambil nama dari displayName
        'password':
            'Password is hidden', // Tidak ada password di sini karena Firebase Auth menangani password
      };
    }
    return {}; // Jika pengguna tidak ditemukan
  }

  // Mengupdate data pengguna (hanya nama) di FirebaseAuth
  static Future<void> updateUserData(String email, String name) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.email == email) {
      await user.updateDisplayName(name); // Update nama pengguna
    }
  }

  // Logout pengguna
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear SharedPreferences jika diperlukan

    await FirebaseAuth.instance.signOut(); // Logout dari FirebaseAuth
  }
}
