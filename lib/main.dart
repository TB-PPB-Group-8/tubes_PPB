import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/lazmall_screen.dart';
import 'themes/app_theme.dart';
import 'themes/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Pastikan widget diinisialisasi sebelum Firebase
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDZggSaehxXKhdlzGxT7Mn2Z8-k9Rb1i8A",
        authDomain: "tubes-ppb-b319e.firebaseapp.com",
        projectId: "tubes-ppb-b319e",
        storageBucket: "tubes-ppb-b319e.firebasestorage.app",
        messagingSenderId: "985030920269",
        appId: "1:985030920269:web:ad01625dabb79a0f037404",
        measurementId: "G-PJ3HLWYFZN"),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lazada Clone',
      theme: AppTheme.lightTheme, // Tema terang
      darkTheme: AppTheme.darkTheme, // Tema gelap
      themeMode: themeProvider.themeMode, // Mode tema (light/dark)
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/lazmall': (context) => LazMall(),
      },
    );
  }
}
