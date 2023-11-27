// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../login/mob_log.dart';
// import '../model.dart';

// class teacher_h extends StatefulWidget {
//   String id;
//   teacher_h({required this.id});

//   @override
//   // ignore: library_private_types_in_public_api
//   _teacher_hState createState() => _teacher_hState(id: id);
// }

// class _teacher_hState extends State<teacher_h> {
//   String id;
//   var rooll;
//   var emaill;
//   var depp;
//   UserModel loggedInUser = UserModel();

//   _teacher_hState({required this.id});
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
//       appBar: AppBar(actions: [Text('you are a teacher')]),
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
