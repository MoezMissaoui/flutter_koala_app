import 'package:flutter/material.dart';

class AuthData extends ChangeNotifier {
  bool isAutheticated = false;

  void changeAuthentication(bool value) {
    isAutheticated = value;
    notifyListeners();
  }
}
