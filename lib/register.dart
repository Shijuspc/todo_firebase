import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool passwordVisible = false;
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmpassword = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signup() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      Fluttertoast.showToast(
        msg: "Registration successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // Navigate to the login screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } catch (e) {
      // User registration failed
      print('Registration failed: $e');

      Fluttertoast.showToast(
        msg: "Registration failed: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 35),
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 80),
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
                              left: 15.0, right: 15.0, top: 80, bottom: 0),
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
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10, bottom: 10),
                          child: TextFormField(
                            controller: confirmpassword,
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Confirm Password";
                              }
                              if (value != password.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
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
                      signup();
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
                      'Sign Up',
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
                  Text("You already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    },
                    child: Text(
                      'Login',
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
