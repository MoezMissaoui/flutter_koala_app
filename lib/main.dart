import 'package:koala/src/config/theme_colors.dart';
import 'package:koala/src/models/auth_data.dart';
import 'package:koala/src/models/task_data.dart';
import 'package:koala/src/screens/home_screen.dart';
import 'package:koala/src/screens/register_screen.dart';
import 'package:koala/src/screens/login_screen.dart';
import 'package:koala/src/auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:koala/src/screens/task_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskData()),
        ChangeNotifierProvider(create: (context) => AuthData()),
      ],
      child: MaterialApp(
        title: 'Koala',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: ThemeColors.mainColor,
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
                child: const Auth(),
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

            case 'taskscreen':
              return PageTransition(
                child: TaskScreen(),
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
      ),
    );
  }
}
