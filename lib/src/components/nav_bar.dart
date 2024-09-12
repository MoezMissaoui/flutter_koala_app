// ignore_for_file: prefer_const_constructors, avoid_returning_null_for_void

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:koala/src/config/constants.dart';
import 'package:koala/src/config/theme_colors.dart';
import 'package:koala/src/helpers/auth_firebase.dart';
import 'package:koala/src/models/auth_data.dart';
import 'package:koala/src/screens/home_screen.dart';
import 'package:koala/src/screens/task_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NavBar> {
  final storage = const FlutterSecureStorage();

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
            onTap: () => {
              Navigator.of(context).pushReplacementNamed('homescreen')

              // Navigator.push(
              //   context,
              //   PageTransition(
              //     type: PageTransitionType.rightToLeftWithFade,
              //     duration: const Duration(milliseconds: 300),
              //     child: const HomeScreen(),
              //   ),
              // )
            },
          ),
          ListTile(
            leading: Icon(Icons.task),
            title: Text('Today DO'),
            onTap: () => {
              Navigator.of(context).pushReplacementNamed('taskscreen')

              // Navigator.push(
              //   context,
              //   PageTransition(
              //     type: PageTransitionType.rightToLeftWithFade,
              //     duration: const Duration(milliseconds: 300),
              //     child: const TodayDo(),
              //   ),
              // )
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Request'),
            onTap: () => null,
            trailing: ClipOval(
              child: Container(
                color: ThemeColors.secondColor,
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
            onTap: () async {
              if (AuthFirebase.logout()) {
                Provider.of<AuthData>(context, listen: false)
                    .changeAuthentication(false);
                await storage.write(key: 'isAutheticated', value: 'false');
                Navigator.of(context).pushReplacementNamed('/');
              }
            },
          ),
        ],
      ),
    );
  }
}
