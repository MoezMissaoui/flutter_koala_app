import 'package:koala/src/screens/home_screen.dart';
import 'package:koala/src/screens/register_screen.dart';
import 'package:koala/src/screens/login_screen.dart';
import 'package:koala/src/auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:koala/src/screens/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

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
          seedColor: const Color(0xFFFF6F00),
        ),
        useMaterial3: true,
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS:
              PageTransition(type: PageTransitionType.fade, child: this)
                  .matchingBuilder,
        }),
      ),
      // home: const Auth(),

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return PageTransition(
              child: const SplashScreen(),
              type: PageTransitionType.theme,
              settings: settings,
              reverseDuration: const Duration(seconds: 3),
            );

          case 'homescreen':
            return PageTransition(
              child: const HomeScreen(),
              type: PageTransitionType.theme,
              settings: settings,
              reverseDuration: const Duration(seconds: 3),
            );

          case 'registerscreen':
            return PageTransition(
              child: const RegisterScreen(),
              type: PageTransitionType.theme,
              settings: settings,
              reverseDuration: const Duration(seconds: 3),
            );

          case 'loginscreen':
            return PageTransition(
              child: const LoginScreen(),
              type: PageTransitionType.theme,
              settings: settings,
              reverseDuration: const Duration(seconds: 3),
            );

          default:
            return null;
        }
      },

      // routes: {
      //   '/': (context) => const Auth(),
      //   'homescreen': (context) => const HomeScreen(),
      //   'registerscreen': (context) => const RegisterScreen(),
      //   'loginscreen': (context) => const LoginScreen(),
      // },
    );
  }
}
