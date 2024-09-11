import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:koala/src/models/auth_data.dart';
import 'package:koala/src/screens/home_screen.dart';
import 'package:koala/src/screens/login_screen.dart';
import 'package:provider/provider.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    bool isAutheticated = Provider.of<AuthData>(context).isAutheticated;

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          debugPrint(
              'Auth status ${(isAutheticated) ? 'Connected' : 'Not Connected'}');
          // if (snapshot.hasData || isAutheticated) {
          if (isAutheticated) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        }),
      ),
    );
  }
}
