import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisible = false;
  var email = TextEditingController();
  var password = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> login() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // Login successful, display a success toast
      Fluttertoast.showToast(
        msg: "Login successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // Navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Home()), // Replace `Home()` with your actual home page widget
      );
    } catch (e) {
      // Handle login errors
      print('Login failed: $e');

      // Display an error toast
      Fluttertoast.showToast(
        msg: "Login failed: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: "Password reset email sent",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Failed to send reset email",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              SizedBox(height: 35),
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 100),
                  color: Color.fromRGBO(229, 246, 247, 1.000),
                  height: 450,
                  width: 360,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "TODO",
                          style: TextStyle(
                              fontSize: 40,
                              color: Color.fromRGBO(0, 112, 173, 1),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 100, bottom: 0),
                          child: TextFormField(
                            controller: email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your Email";
                              }
                              if (!value.contains("@")) {
                                return "Enter Valid Email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Email",
                                contentPadding: EdgeInsets.only(left: 30),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10, bottom: 0),
                          child: TextFormField(
                            controller: password,
                            obscureText: passwordVisible,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your Password";
                              } else if (value.length < 6) {
                                return "atleast 6 characters";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Password",
                              contentPadding:
                                  EdgeInsets.only(left: 30, right: 30),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color.fromRGBO(0, 112, 173, 1),
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      passwordVisible = !passwordVisible;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextButton(
                            onPressed: () {
                              resetPassword(email.text);
                            },
                            child: Text(
                              'Lost Password?',
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 112, 173, 1),
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: ElevatedButton(
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      login();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(0, 112, 173, 1),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: Container(
                    width: 360,
                    height: 40,
                    alignment: Alignment.center,
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 50.0,
                    ),
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png',
                      width: 30,
                      height: 30,
                      scale: 1.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 50.0),
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Twitter_2012_logo.svg/450px-Twitter_2012_logo.svg.png',
                      width: 40,
                      height: 40,
                      scale: 1.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Image.network(
                      'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png',
                      width: 30,
                      height: 30,
                      scale: 1.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signup(),
                          ));
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(0, 112, 173, 1),
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
