import 'package:flutter/material.dart';

import 'home.dart';

class Notifiy extends StatefulWidget {
  const Notifiy({super.key});

  @override
  State<Notifiy> createState() => _NotifiyState();
}

class _NotifiyState extends State<Notifiy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification",
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
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
        child: Card(
          elevation: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color.fromRGBO(1, 166, 255, 1),
                width: 1,
              ),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                child: Icon(
                  Icons.notifications,
                ),
              ),
              title: Text("Welcome",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 112, 173, 1),
                      fontWeight: FontWeight.w600)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Hello word",
                    ),
                  ],
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color.fromRGBO(0, 112, 173, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
