import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'mytask.dart';

class EditTask extends StatefulWidget {
  const EditTask({Key? key}) : super(key: key);

  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController stime = TextEditingController();
  TextEditingController etime = TextEditingController();
  TextEditingController des = TextEditingController();
  late String docId;
  final CollectionReference todo =
      FirebaseFirestore.instance.collection('tasks');
  void Editdata(docId) {
    final data = {
      'name': name.text,
      'date': date.text,
      'startTime': stime.text,
      'endTime': etime.text,
      'description': des.text,
    };
    todo.doc(docId).update(data).then((value) {
      Fluttertoast.showToast(
        msg: "Task updated successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
      );
      Navigator.pop(context);
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: "Failed to update task",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    name.text = args['name'];
    date.text = args['date'];
    stime.text = args['startTime'].toString();
    etime.text = args['endTime'].toString();
    des.text = args['description'];
    docId = args['id'];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task",
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
                    builder: (context) => Mytask(),
                  ));
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromRGBO(0, 112, 173, 1),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 20),
              child: Text(
                'Task Name',
                style: TextStyle(
                    color: Color.fromRGBO(0, 112, 173, 1),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35, top: 10),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(0, 112, 173, 1),
                  ),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 20),
              child: Text(
                'Date & Time',
                style: TextStyle(
                    color: Color.fromRGBO(0, 112, 173, 1),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35, top: 10),
              child: TextFormField(
                controller: date,
                onTap: () async {
                  DateTime? datepick = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2025));
                  if (datepick != null) {
                    print(datepick);
                    String formatdate =
                        DateFormat("yyyy-MM-dd").format(datepick);
                    print(formatdate);
                    setState(() {
                      date.text = formatdate;
                    });
                  }
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_month,
                      color: Color.fromRGBO(0, 112, 173, 1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 112, 173, 1),
                      ),
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 20),
                        child: Text(
                          'Start Time',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 112, 173, 1),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35, top: 10),
                        child: TextFormField(
                          controller: stime,
                          onTap: () async {
                            TimeOfDay? timepick = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.input,
                            );
                            if (timepick != null) {
                              print(timepick);
                              String formattedTime = timepick.format(context);
                              print(formattedTime);
                              setState(() {
                                stime.text = formattedTime;
                              });
                            }
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                              ),
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Color.fromRGBO(0, 112, 173, 1),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 112, 173, 1),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 0, right: 25, top: 20),
                        child: Text(
                          'End Time',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 112, 173, 1),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 35, top: 10),
                        child: TextFormField(
                          controller: etime,
                          onTap: () async {
                            TimeOfDay? timepick = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.input,
                            );
                            if (timepick != null) {
                              print(timepick);
                              String formattedTime = timepick.format(context);
                              print(formattedTime);
                              setState(() {
                                etime.text = formattedTime;
                              });
                            }
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                              ),
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Color.fromRGBO(0, 112, 173, 1),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 112, 173, 1),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 20),
                    child: Text(
                      'Description',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 112, 173, 1),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 35, top: 10, right: 35),
                    child: SizedBox(
                      height: 200,
                      width: 300,
                      child: TextFormField(
                        controller: des,
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(0, 112, 173, 1),
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                child: ElevatedButton(
                  onPressed: () {
                    Editdata(docId);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(0, 112, 173, 1),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: Container(
                    width: 330,
                    height: 40,
                    alignment: Alignment.center,
                    child: const Text(
                      'Create Task',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
