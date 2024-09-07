// ignore_for_file: prefer_const_constructors, avoid_returning_null_for_void

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:koala/src/config/constants.dart';
import 'package:koala/src/config/theme_colors.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NavBar> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(currentUser.displayName ?? ''),
            accountEmail: Text(currentUser.email ?? ''),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  Constants.logo,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: ThemeColors.mainColor,
              image: const DecorationImage(
                image: AssetImage(Constants.navBarBG),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {Navigator.of(context).pushNamed('/')},
          ),
          ListTile(
            leading: Icon(Icons.task),
            title: Text('To do'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Request'),
            onTap: () => null,
            trailing: ClipOval(
              child: Container(
                color: ThemeColors.mainColor,
                width: 20,
                height: 20,
                child: Center(
                  child: Text(
                    '8',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Policies'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Exit'),
            onTap: () => {FirebaseAuth.instance.signOut()},
          ),
        ],
      ),
    );
  }
}
