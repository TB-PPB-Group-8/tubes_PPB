import 'package:flutter/material.dart';
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
  String _password = '';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    String? email = await UserService.getEmailFromPreferences();
    if (email != null) {
      setState(() {
        _email = email;
      });
      Map<String, String> userData = await UserService.fetchUserData(email);
      setState(() {
        _name = userData['name'] ?? 'No Name';
        _password = userData['password'] ?? 'No Password';
      });
    }
  }

  void _updateProfile(String name, String password) async {
    await UserService.updateUserData(_email, name, password);
    setState(() {
      _name = name;
      _password = password;
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
              password: _password,
            ),
            const SizedBox(height: 20),
            ProfileButtons(
              onEditProfile: () => _showEditProfileDialog(),
              onLogout: () async {
                await UserService.logout();
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
    TextEditingController passwordController =
        TextEditingController(text: _password);

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
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
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
                String newPassword = passwordController.text;
                _updateProfile(newName, newPassword);
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
