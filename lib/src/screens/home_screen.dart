// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:koala/src/components/nav_bar.dart';
import 'package:koala/src/config/theme_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Hello you are logged in',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      drawer: const NavBar(),
      appBar: AppBar(
          backgroundColor: ThemeColors.mainColor,
          foregroundColor: Colors.white),
    );
  }
}
