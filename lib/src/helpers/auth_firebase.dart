import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:koala/src/helpers/Alert.dart';

class AuthFirebase {
  static BuildContext? context;
  static User? user;
  static FirebaseAuth auth = FirebaseAuth.instance;

  static currentUser() {
    debugPrint('AuthFirebase currentUser()');
    return auth.currentUser;
  }

  static String currentUserName() {
    debugPrint('AuthFirebase currentUserName()');
    String currentUserName = (currentUser().displayName != '')
        ? currentUser().displayName
        : currentUser().email;
    return currentUserName;
  }

  static bool logout() {
    debugPrint('AuthFirebase logout()');
    try {
      auth.signOut();
      return true;
    } catch (e) {
      debugPrint('Error firebase logout : $e');
      return false;
    }
  }

  static Future<String> login(String email, String password) async {
    debugPrint('AuthFirebase login()');

    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint('xxxxxxxxx : $email');
      debugPrint('yyyyyyyyyyyyy : $password');

      return 'true';
    } on FirebaseAuthException catch (e) {
      debugPrint('Error login: $e');
      return "These credentials do not match our records";
    } catch (e) {
      debugPrint('Error firebase login : $e');
      return "Login Error";
    }
  }

  static Future<String> register(
      String email, String password, String displayName) async {
    debugPrint('AuthFirebase register()');

    try {
      debugPrint('xxxxxxxxx : $email');
      debugPrint('yyyyyyyyyyyyy : $password');
      debugPrint('wwwwwwwwwwww : $displayName');

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user!.updateProfile(displayName: displayName);
      await user?.reload();
      user = auth.currentUser;

      return 'true';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email";
      }
      debugPrint('Error firebase register : $e');
      return "System Error";
    } catch (e) {
      debugPrint('Error firebase register : $e');
      return "System Error";
    }
  }
}
