// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:koala/src/config/constants.dart';
import 'package:koala/src/config/theme_colors.dart';
import 'package:koala/src/helpers/auth_firebase.dart';
import 'package:koala/src/helpers/validator_rules.dart';
import 'package:koala/src/helpers/alert.dart';
import 'package:koala/src/models/auth_data.dart';
import 'package:koala/src/screens/register_screen.dart';
import 'package:koala/src/services/biometric_auth_service.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final storage = const FlutterSecureStorage();

  late final String _storeduserEmail;
  late final String _storedUserPassword;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future login() async {
    try {
      // UserCredential successFirevaseSignIn =
      //     await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: _emailController.text.trim(),
      //   password: _passwordController.text.trim(),
      // );

      String loginResponse = await AuthFirebase.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (loginResponse == 'true') {
        // Store a key-value pair
        await storage.write(
            key: 'userEmail', value: _emailController.text.trim());
        await storage.write(
            key: 'userPassword', value: _passwordController.text.trim());

        Provider.of<AuthData>(context, listen: false)
            .changeAuthentication(true);

        Navigator.of(context).pushReplacementNamed('/');
      } else {
        Alert.of(context).showError(loginResponse);
      }
    } catch (e) {
      debugPrint('Error simple login $e');
      Alert.of(context).showError("System Error");
    }
  }

  Future biometricLogin() async {
    try {
      if (_storeduserEmail == '' || _storedUserPassword == '') {
        Alert.of(context).showError(
            "Can't use biometric autentication without stored creds");
        return false;
      }

      // UserCredential successFirevaseSignIn =
      //     await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: _storeduserEmail,
      //   password: _storedUserPassword,
      // );

      if (await BiometricAuthService.authenticate()) {
        String loginResponse = await AuthFirebase.login(
          _storeduserEmail,
          _storedUserPassword,
        );

        if (loginResponse == 'true') {
          Provider.of<AuthData>(context, listen: false)
              .changeAuthentication(true);
          Navigator.of(context).pushReplacementNamed('/');
        } else {
          Alert.of(context).showError(loginResponse);
        }
      }
    } catch (e) {
      debugPrint('Error biometric login $e');
      Alert.of(context).showError("System Error");
    }
  }

  Future<void> _loadCredentials() async {
    try {
      String? storedUsername = await storage.read(key: 'userEmail');
      String? storedPassword = await storage.read(key: 'userPassword');

      if (storedUsername != null) {
        setState(() {
          _storeduserEmail = storedUsername;
        });
      }

      if (storedPassword != null) {
        setState(() {
          _storedUserPassword = storedPassword;
        });
      }
    } catch (e) {
      debugPrint('Error loading credentials: $e');
    }
  }

  void openRegisterScreen() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeftWithFade,
        duration: const Duration(milliseconds: 400),
        child: const RegisterScreen(),
      ),
    );
    // Navigator.of(context).pushReplacementNamed('registerscreen');
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image
                      Image.asset(
                        Constants.logo,
                        height: 120,
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // Title
                      Text("LOGIN",
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          )),

                      // subtitle

                      Text("Welcome back! Nice to see you again 😊",
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 18,
                          )),

                      const SizedBox(
                        height: 30,
                      ),

                      // Email Textfiled
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _emailController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required Field';
                                }

                                if (!validateEmailForm(value)) {
                                  return 'Invalid Email Form';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // Pasword TextField
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required Field';
                                }

                                if (!validatePasswordLength(value, 6)) {
                                  return 'Password length shoud be at least 6';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // Login Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: ThemeColors.secondColor,
                            minimumSize: const Size.fromHeight(45),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Sets the button's border radius
                            ),
                          ),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              login();
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: GestureDetector(
                          onTap: () {
                            biometricLogin();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  width: 2, color: ThemeColors.secondColor),
                            ),
                            child: Icon(
                              Icons.fingerprint,
                              size: 50,
                              color: ThemeColors.secondColor,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      // Text: Register
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not yes a member ? ',
                            style: GoogleFonts.robotoCondensed(
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: openRegisterScreen,
                            child: Text(
                              'Register Now',
                              style: GoogleFonts.robotoCondensed(
                                color: ThemeColors.secondColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
