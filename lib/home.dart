import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'calender.dart';
import 'mytask.dart';
import 'newtask.dart';
import 'notification.dart';
import 'profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Map<String, dynamic>>> getData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('tasks').get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page",
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
        leading: Icon(
          Icons.menu,
          color: Color.fromRGBO(0, 112, 173, 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Card(
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
                            Icons.account_circle_rounded,
                          ),
                        ),
                        title: Text(snapshot.data![index]['name'],
                            style: TextStyle(
                                color: Color.fromRGBO(0, 112, 173, 1),
                                fontWeight: FontWeight.w600)),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(snapshot.data![index]['startTime']
                                  .toString()),
                              Container(
                                height: 1,
                                width: 6,
                                margin: EdgeInsets.only(left: 5, right: 5),
                                color: Color.fromARGB(255, 89, 89, 89),
                              ),
                              Text(snapshot.data![index]['endTime'].toString()),
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Mytask(),
                                ));
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color.fromRGBO(0, 112, 173, 1),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text('No Notification'),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewTask(),
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(0, 112, 173, 1),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: BottomAppBar(
            color: Colors.white,
            elevation: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Color.fromRGBO(0, 112, 173, 1),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: IconButton(
                    icon: Icon(
                      Icons.calendar_month,
                      color: Color.fromRGBO(0, 112, 173, 1),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Calender(),
                          ));
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.message,
                    color: Color.fromRGBO(0, 112, 173, 1),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Notifiy(),
                        ));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.account_circle,
                    color: Color.fromRGBO(0, 112, 173, 1),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
