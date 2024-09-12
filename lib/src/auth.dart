// ignore_for_file: unrelated_type_equality_checks

import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:koala/src/models/auth_data.dart';
import 'package:koala/src/screens/home_screen.dart';
import 'package:koala/src/screens/login_screen.dart';
import 'package:provider/provider.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  // bool isAutheticated = Provider.of<AuthData>(context).isAutheticated;
  final storage = const FlutterSecureStorage();

  String? _isAutheticated;

  Future<void> _loadingIsAutheticated() async {
    try {
      String? isAutheticated = await storage.read(key: 'isAutheticated');
      if (isAutheticated != null) {
        setState(() {
          _isAutheticated = isAutheticated;
        });
      }
    } catch (e) {
      debugPrint('Error _isAutheticated: $e');
      setState(() {
        _isAutheticated = 'false';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadingIsAutheticated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          debugPrint(
              'Auth status ${(_isAutheticated == 'true') ? 'Connected' : 'Not Connected'}');
          // if (snapshot.hasData || __isAutheticated) {
          if (_isAutheticated == 'true') {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        }),
      ),
    );
  }
}
