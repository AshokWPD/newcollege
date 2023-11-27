
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model.dart';
import '../att/list.dart';
import 'timelist.dart';
import 'timeup.dart';

class timeTable extends StatefulWidget {
  const timeTable({super.key});

  @override
  State<timeTable> createState() => _timeTableState();
  static String routeName = 'timeTable';
}

class _timeTableState extends State<timeTable> {
  late String pdfurl;

  User? user;
  UserModel loggedInUser = UserModel();
  String rooll = '';
  var emaill;
  String id = '';
  String namee = '';
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        this.loggedInUser = UserModel.fromMap(value.data());
      }).whenComplete(() {
        CircularProgressIndicator();
        setState(() {
          emaill = loggedInUser.email.toString();
          rooll = loggedInUser.rool.toString();
          id = loggedInUser.uid.toString();
          namee = loggedInUser.name.toString();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isstu = rooll != 'Student';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'TIME TABLE ',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 21,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Uploadtime(),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 247, 0, 255),
                      Color.fromARGB(255, 4, 0, 255),
                    ]),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.blue,
                          blurRadius: 2,
                          offset: Offset(8.0, 8.0))
                    ],
                    border: Border.all(
                        color: Color.fromARGB(255, 248, 248, 248), width: 3)),
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    'Upload TimeTable',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => timePage(),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 0, 255, 221),
                      Color.fromARGB(255, 0, 255, 76),
                    ]),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.blue,
                          blurRadius: 2,
                          offset: Offset(8.0, 8.0))
                    ],
                    border: Border.all(
                        color: Color.fromARGB(255, 248, 248, 248), width: 3)),
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    'View List of TimeTable',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
