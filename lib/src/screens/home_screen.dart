// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:koala/src/components/nav_bar.dart';
import 'package:koala/src/config/theme_colors.dart';
import 'package:koala/src/helpers/auth_firebase.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              '🤗',
              style: TextStyle(
                fontSize: 70,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Hello you are logged in',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            Text(
              AuthFirebase.currentUser().displayName ??
                  AuthFirebase.currentUser().email,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: ThemeColors.secondColor,
              ),
            ),
          ],
        ),
      ),
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: ThemeColors.mainColor,
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
