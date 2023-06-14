import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Fluttertoast.showToast(
        msg: "Logged out successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
      );
      // Navigate to the login screen or any other desired screen after logout
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Failed to log out",
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
      appBar: AppBar(
        title: const Text("Profile",
            style: TextStyle(
              color: Color.fromRGBO(0, 112, 173, 1),
              fontSize: 17,
            )),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        elevation: 2.00,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.notification_add,
              color: Color.fromRGBO(0, 112, 173, 1),
            ),
          )
        ],
        leading: Container(
          margin: EdgeInsets.only(left: 8, top: 6, bottom: 6, right: 8),
          decoration: BoxDecoration(
            color: Color.fromRGBO(229, 246, 247, 1.000),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ));
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromRGBO(0, 112, 173, 1),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.account_circle,
                  size: 80,
                )),
            SizedBox(height: 16),
            Text(
              'Shiju',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('shiju@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('123456789'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: OutlinedButton(onPressed: logout, child: Text('Log Out')),
            )
          ],
        ),
      ),
    );
  }
}
