// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../login/mob_log.dart';
// import '../model.dart';

// class admin extends StatefulWidget {
//   String id;
//   admin({required this.id});

//   @override
//   _adminState createState() => _adminState(id: id);
// }

// class _adminState extends State<admin> {
//   String id;
//   var rooll;
//   var emaill;
//   var depp;
//   UserModel loggedInUser = UserModel();

//   _adminState({required this.id});
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
//       appBar: AppBar(actions: [Text('you are a admin')]),
//       body: Center(
//         child: Column(children: [
//           Center(
//             child: MaterialButton(
//                 height: 20,
//                 minWidth: 20,
//                 onPressed: () {
//                   logout(context);
//                 },
//                 child: Text('log out')),
//           )
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
