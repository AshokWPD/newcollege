// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../login/mob_log.dart';
// import '../model.dart';

// class student_h extends StatefulWidget {
//   String id;
//   student_h({required this.id});

//   @override
//   _student_hState createState() => _student_hState(id: id);
// }

// class _student_hState extends State<student_h> {
//   String id;
//   var rooll;
//   var emaill;
//   var depp;
//   UserModel loggedInUser = UserModel();

//   _student_hState({required this.id});
//   @override
//   void initState() {
//     super.initState();
//     FirebaseFirestore.instance
//         .collection("users") //.where('uid', isEqualTo: user!.uid)
//         .doc(id)
//         .get()
//         .then((value) {
//       this.loggedInUser = UserModel.fromMap(value.data());
//     }).whenComplete(() {
//       CircularProgressIndicator();
//       setState(() {
//         emaill = loggedInUser.email.toString();
//         rooll = loggedInUser.rool.toString();
//         id = loggedInUser.uid.toString();
//         depp = loggedInUser.dep.toString();
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(actions: [Text('you are a student')]),
//       body: Center(
//         child: Column(children: [
//           MaterialButton(
//               onPressed: () {
//                 logout(context);
//               },
//               child: Text('log out'))
//         ]),
//       ),
//     );
//   }
// }

// Future<void> logout(BuildContext context) async {
//   CircularProgressIndicator();
//   await FirebaseAuth.instance.signOut();

//   Navigator.of(context).pushReplacement(
//     MaterialPageRoute(
//       builder: (context) => moblog(),
//     ),
//   );
// }
