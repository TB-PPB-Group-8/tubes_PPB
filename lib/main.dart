import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_lazada/firebase_options.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/lazmall_screen.dart';
import 'themes/app_theme.dart';
import 'themes/theme_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
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
