import 'package:koala/screens/home_screen.dart';
import 'package:koala/screens/register_screen.dart';
import 'package:koala/screens/login_screen.dart';
import 'package:koala/auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koala',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      // home: const Auth(),
      routes: {
        '/': (context) => const Auth(),
        'homescreen': (context) => const HomeScreen(),
        'registerscreen': (context) => const RegisterScreen(),
        'loginscreen': (context) => const LoginScreen(),
      },
    );
  }
}
