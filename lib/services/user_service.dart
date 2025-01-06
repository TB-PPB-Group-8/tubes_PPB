import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<String?> getEmailFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  static Future<Map<String, String>> fetchUserData(String email) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var userData = snapshot.docs.first.data() as Map<String, dynamic>;
      return {
        'name': userData['name'] ?? 'No Name',
        'password': userData['password'] ?? 'No Password',
      };
    }
    return {};
  }

  static Future<void> updateUserData(
      String email, String name, String password) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      String docId = snapshot.docs.first.id;
      await FirebaseFirestore.instance.collection('user').doc(docId).update({
        'name': name,
        'password': password,
      });
    }
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
