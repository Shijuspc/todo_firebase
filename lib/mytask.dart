import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_firebase/newtask.dart';

import 'calender.dart';

import 'edittask.dart';
import 'home.dart';
import 'notification.dart';
import 'profile.dart';

class Mytask extends StatefulWidget {
  const Mytask({super.key});

  @override
  State<Mytask> createState() => _MytaskState();
}

class _MytaskState extends State<Mytask> {
  final CollectionReference todo =
      FirebaseFirestore.instance.collection('tasks');
  void delete(docId) {
    todo.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Task",
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
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: StreamBuilder(
          stream: todo.snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot todosnap = snapshot.data!.docs[index];
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
                        title: Text(todosnap['name'],
                            style: TextStyle(
                                color: Color.fromRGBO(0, 112, 173, 1),
                                fontWeight: FontWeight.w600)),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(todosnap['startTime'].toString()),
                              Container(
                                height: 1,
                                width: 6,
                                margin: EdgeInsets.only(left: 5, right: 5),
                                color: Color.fromARGB(255, 89, 89, 89),
                              ),
                              Text(todosnap['endTime'].toString()),
                            ],
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/edittask',
                                    arguments: {
                                      'name': todosnap['name'],
                                      'date': todosnap['date'],
                                      'startTime': todosnap['startTime'],
                                      'endTime': todosnap['endTime'],
                                      'description':
                                          todosnap['description'].toString(),
                                      'id': todosnap.id,
                                    });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Color.fromRGBO(0, 112, 173, 1),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  delete(todosnap.id);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Color.fromRGBO(0, 112, 173, 1),
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No Task'),
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
