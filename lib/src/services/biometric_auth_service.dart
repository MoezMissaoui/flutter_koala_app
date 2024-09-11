import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class BiometricAuthService {
  static final _auth = LocalAuthentication();

  static Future<bool> _canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) return false;

      return await _auth.authenticate(
          localizedReason:
              'Scan your fingerprint (or face or whatever) to authenticate',
          authMessages: const [
            AndroidAuthMessages(
              signInTitle: 'Sign in',
              cancelButton: 'No Thanks',
              biometricSuccess: 'Hello',
            ),
            IOSAuthMessages(
              cancelButton: 'No Thanks',
            ),
          ],
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
            useErrorDialogs: true,
          ));
    } catch (e) {
      debugPrint('Error $e');
      return false;
    }
  }
}
