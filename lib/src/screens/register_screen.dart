// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:koala/src/config/constants.dart';
import 'package:koala/src/helpers/Alert.dart';
import 'package:koala/src/config/theme_colors.dart';
import 'package:koala/src/helpers/validator_rules.dart';
import 'package:koala/src/screens/login_screen.dart';
import 'package:page_transition/page_transition.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future register() async {
    try {
      User? user;
      FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      user = userCredential.user;
      await user!
          .updateProfile(displayName: _displayNameController.text.trim());
      await user.reload();
      user = auth.currentUser;

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed('/');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Alert.of(context).showError("The password provided is too weak");
      } else if (e.code == 'email-already-in-use') {
        Alert.of(context)
            .showError("The account already exists for that email");
      }
    } catch (e) {
      Alert.of(context).showError("System Error");
    }
  }

  void openLoginScreen() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRightWithFade,
        duration: const Duration(milliseconds: 500),
        child: const LoginScreen(),
      ),
    );

    // Navigator.of(context).pushReplacementNamed('loginscreen');
  }

  @override
  void dispose() {
    super.dispose();
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                constraints: BoxConstraints(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image
                      Image.asset(
                        Constants.logo,
                        height: 100,
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      // Title
                      Text("REGISTER",
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          )),

                      // subtitle

                      Text("Welcome! Here you can register :-)",
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 18,
                          )),

                      SizedBox(
                        height: 30,
                      ),

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
                              controller: _displayNameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required Field';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
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

                      SizedBox(
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

                      SizedBox(
                        height: 10,
                      ),

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
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirm Password',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required Field';
                                }

                                if (!validatePasswordLength(value, 6)) {
                                  return 'Password length shoud be at least 6';
                                }

                                if (!validateConfirmPassword(
                                    value, _passwordController.text.trim())) {
                                  return 'Error Password Confirmation';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      // Register Button

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: ThemeColors.mainColor,
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
                              register();
                            }
                          },
                          child: const Text('Register'),
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      // Text: sign up

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already a member ? ',
                            style: GoogleFonts.robotoCondensed(
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: openLoginScreen,
                            child: Text(
                              'Login here',
                              style: GoogleFonts.robotoCondensed(
                                color: ThemeColors.secondColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
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
