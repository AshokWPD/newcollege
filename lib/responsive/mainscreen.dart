// import 'package:app_dsa/college/mob_clg.dart';
// import 'package:app_dsa/home_containers/addstu/addstuhome.dart';
// import 'package:app_dsa/login/mob_log.dart';
// import 'package:app_dsa/profile/mob_profile.dart';
// import 'package:app_dsa/responsive/mob_home.dart';
// import 'package:app_dsa/test/quiz/welcome/welcome_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// import '../model.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   User? user;
//   UserModel loggedInUser = UserModel();
//   String rooll = '';
//   var emaill;
//   String id = '';
//   String namee = '';
//   @override
//   void initState() {
//     super.initState();
//     user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       FirebaseFirestore.instance
//           .collection("users")
//           .doc(user!.uid)
//           .get()
//           .then((value) {
//         this.loggedInUser = UserModel.fromMap(value.data());
//       }).whenComplete(() {
//         CircularProgressIndicator();
//         setState(() {
//           emaill = loggedInUser.email.toString();
//           rooll = loggedInUser.rool.toString();
//           id = loggedInUser.uid.toString();
//           namee = loggedInUser.name.toString();
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isadmin = rooll == 'Admin';
//     // bool isathenticated = true;

//     return CupertinoTabScaffold(
//         tabBar: CupertinoTabBar(
//             backgroundColor: Colors.black,
//             items: <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.home,
//                   color: Color.fromARGB(255, 0, 238, 255),
//                 ),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.edit_document,
//                   color: Color.fromARGB(255, 0, 180, 252),
//                 ),
//                 label: 'Online Test',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.food_bank_outlined,
//                   color: Color.fromARGB(255, 2, 233, 250),
//                 ),
//                 label: 'College',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.person,
//                   color: Color.fromARGB(255, 0, 247, 255),
//                 ),
//                 label: 'Profile',
//               ),
//               if (isadmin)
//                 BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.settings,
//                     color: Color.fromARGB(255, 0, 247, 255),
//                   ),
//                   label: 'Add User',
//                 )
//             ]),
//         tabBuilder: (context, index) {
//           switch (index) {
//             case 0:
//               return CupertinoTabView(
//                 builder: (context) {
//                   return CupertinoPageScaffold(child: mob_home());
//                 },
//               );
//               break;

//             case 1:
//               return CupertinoTabView(
//                 builder: (context) {
//                   return CupertinoPageScaffold(child: (WelcomeScreen()));
//                 },
//               );
//               break;
//             case 2:
//               return CupertinoTabView(
//                 builder: (context) {
//                   return CupertinoPageScaffold(child: (clgnot()));
//                 },
//               );
//               break;
//             case 3:
//               return CupertinoTabView(
//                 builder: (context) {
//                   return CupertinoPageScaffold(child: (mobprof()));
//                 },
//               );
//               break;

//             case 4:
//               return CupertinoTabView(
//                 builder: (context) {
//                   return CupertinoPageScaffold(child: (addstuhome()));
//                 },
//               );
//               break;
//             default:
//               return CupertinoTabView(
//                 builder: (context) {
//                   return CupertinoPageScaffold(child: (mob_home()));
//                 },
//               );
//               break;
//           }
//         });
//     // : moblog(onLoginSuccess: () {
//     //     setState(() {
//     //       isathenticated = true;
//     //     });
//     //   });
//   }
// }
