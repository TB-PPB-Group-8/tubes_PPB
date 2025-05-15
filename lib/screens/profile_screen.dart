import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import '../widgets/profile_avatar.dart';
import '../widgets/profile_card.dart';
import '../widgets/profile_buttons.dart';
import '../services/user_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _email = '';
  String _name = '';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // Memuat data profil dari Firebase Authentication
  Future<void> _loadProfileData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        _email = user.email ?? 'No Email';
        _name = user.displayName ?? 'No Name';
      });
    }
  }

  void _updateProfile(String name) async {
    await UserService.updateUserData(_email, name); // Update nama pengguna
    setState(() {
      _name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : const Color(0xFFEEF1F8),
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: isDarkMode ? Colors.grey[850] : Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileAvatar(isDarkMode: isDarkMode),
            const SizedBox(height: 70),
            ProfileCard(
              email: _email,
              name: _name,
              password:
                  'Password is hidden', // Tidak menampilkan password di sini
            ),
            const SizedBox(height: 20),
            ProfileButtons(
              onEditProfile: () => _showEditProfileDialog(),
              onLogout: () async {
                await UserService.logout(); // Logout pengguna
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog() {
    TextEditingController nameController = TextEditingController(text: _name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String newName = nameController.text;
                _updateProfile(newName);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
