import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model.dart';
import 'feeslist.dart';
import 'feesup.dart';

class fees extends StatefulWidget {
  const fees({super.key});

  @override
  State<fees> createState() => _feesState();
  static String routeName = 'feesview';
}

class _feesState extends State<fees> {
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
    bool isStudent = rooll != 'Student';
    return DefaultTabController(
      length: isStudent ? 2 : 1, // Set the length based on student status
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              'FEES DETAILS ',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 21,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            tabs: [
              if (isStudent)
                Tab(text: 'Upload Fees'),
              Tab(text: 'View Uploads'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            if (isStudent)
              UploadFees(),
            FeesPage(),
          ],
        ),
      ),
    );
  }
}