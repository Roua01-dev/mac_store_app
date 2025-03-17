import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mac_store_app/controllers/auth_controller.dart';
import 'package:mac_store_app/views/screens/authentification_screen/login.screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //const RegisterScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthController _authController = AuthController();

  // late because currently assigning any value to it at the moment
  late String email;

  late String fullname;

  late String password;
  bool isLoading = false;
  registerUser() async {
    setState(() {
      isLoading = true;
    });
    await _authController
        .signUpUsers(
          context: context,
          email: email,
          password: password,
          fullname: fullname,
        )
        .whenComplete(() {
          _formKey.currentState!.reset();
          setState(() {
            isLoading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  'Create Your Account',
                  style: GoogleFonts.getFont(
                    "Lato",
                    fontSize: 24,
                    color: Color(0xFF0d120E),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                  ),
                ),
                Text(
                  'To explore the word exclusives',
                  style: GoogleFonts.getFont(
                    "Lato",
                    fontSize: 14,
                    color: Color(0xFF0d120E),
                    letterSpacing: 0.2,
                  ),
                ),
                Image.asset(
                  'assets/images/Illustration.png',
                  width: 150,
                  height: 150,
                ),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Email",
                    style: GoogleFonts.getFont(
                      'Nunito Sans',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter your email',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelStyle: GoogleFonts.getFont(
                      'Nunito Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.1,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/icons/user.jpeg',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Full Name",
                    style: GoogleFonts.getFont(
                      'Nunito Sans',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    fullname = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Full Name is required';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'enter your full name',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelStyle: GoogleFonts.getFont(
                      'Nunito Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.1,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/icons/email.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20), //hedha espace bin hajet
                TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    } else {
                      return null;
                    }
                  },
                  // ne affiche pas ce que ecrit dans password field
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Enter your password',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelStyle: GoogleFonts.getFont(
                      'Nunito Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.1,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/icons/password.png',
                        width: 20,
                        height: 20,
                      ),
                    ),

                    suffixIcon: Icon(Icons.visibility),
                  ),
                ),
                SizedBox(height: 20), //hedha espace bin hajet
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      registerUser();
                    } else {
                      log('incorrect form');
                    }
                  },

                  child: Container(
                    width: 319,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        colors: [Color(0xFF102DE1), Color(0xCC0D6EFF)],
                      ),
                    ),
                    child: Center(
                      child:
                          isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : Text(
                                'Sign Up',
                                style: GoogleFonts.getFont(
                                  'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  ),
                ),
                //already have an account ? SignIn link
                SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an Account?',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },

                      child: Text(
                        'Sign In',
                        style: GoogleFonts.getFont(
                          'Lato',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF102DE1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
