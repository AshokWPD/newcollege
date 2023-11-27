// import 'dart:convert';
// import 'dart:io';

// import 'package:app_dsa/home_containers/addstu/listadd.dart';
// import 'package:app_dsa/home_containers/addstu/uploadadstu.dart';
// import 'package:app_dsa/model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:csv/csv.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// // ignore: depend_on_referenced_packages

// class attcsv extends StatefulWidget {
//   const attcsv({super.key});

//   @override
//   State<attcsv> createState() => _attcsvState();
// }

// final FirebaseAuth _auth = FirebaseAuth.instance;
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// class _attcsvState extends State<attcsv> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Attendance CSV'),
//         titleTextStyle: TextStyle(
//             color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 23),
//         backgroundColor: Colors.white,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: InkWell(
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => uploadaddstu(),
//                 ),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     gradient: LinearGradient(colors: [
//                       Color.fromARGB(255, 247, 0, 255),
//                       Color.fromARGB(255, 4, 0, 255),
//                     ]),
//                     boxShadow: const [
//                       BoxShadow(
//                           color: Colors.blue,
//                           blurRadius: 2,
//                           offset: Offset(8.0, 8.0))
//                     ],
//                     border: Border.all(
//                         color: Color.fromARGB(255, 248, 248, 248), width: 3)),
//                 height: 200,
//                 width: MediaQuery.of(context).size.width,
//                 child: Center(
//                   child: Text(
//                     'Upload CSV data',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: InkWell(
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => csvPage(),
//                 ),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     gradient: LinearGradient(colors: [
//                       Color.fromARGB(255, 0, 255, 221),
//                       Color.fromARGB(255, 0, 255, 76),
//                     ]),
//                     boxShadow: const [
//                       BoxShadow(
//                           color: Colors.blue,
//                           blurRadius: 2,
//                           offset: Offset(8.0, 8.0))
//                     ],
//                     border: Border.all(
//                         color: Color.fromARGB(255, 248, 248, 248), width: 3)),
//                 height: 200,
//                 width: MediaQuery.of(context).size.width,
//                 child: Center(
//                   child: Text(
//                     'View List of CSV file',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Future<void> registerAttendeesFromCsv(String csvUrl) async {
//   final CollectionReference attendees =
//       FirebaseFirestore.instance.collection("attendees");

//   // Download the CSV file contents using dart:io
//   final uri = Uri.parse(csvUrl);
//   final request = await HttpClient().getUrl(uri);
//   final response = await request.close();
//   final csvData = await response.transform(utf8.decoder).join();

//   // Convert the CSV data to a 2D list of dynamic values
//   List<List<dynamic>> rows = CsvToListConverter().convert(csvData);

//   // Process the rows as needed
//   // Assuming the CSV data has headers: regnum,name,dep,Ttclass,Atclass,perclass
//   for (int i = 1; i < rows.length; i++) {
//     var attendeeDetails = {
//       'dep': rows[i][2].toString(),
//       'name': rows[i][1].toString(),
//       'regnum': rows[i][0].toString(),
//       'Ttclass': rows[i][3].toString(),
//       'Atclass': rows[i][4].toString(),
//       'perclass': rows[i][5].toString(),
//     };

//     // Add the attendee to Firebase
//     Attendmodel attendee = Attendmodel.fromMap(attendeeDetails);
//     var attendeeDoc = attendees.doc(rows[i][0].toString());
//     await attendeeDoc.set(attendee.toDocument()).then((value) {
//       // Document added successfully
//       print("Attendee added successfully: $Value");
//     }).catchError((error) {
//       // Error adding document
//       print("Error adding attendee: $error");
//     });
//   }
// }




// ///////////////////////////////////////////////////////////////////////////////////////////////////////old//////////////////////////////////////////

// // int emailIndex = rows[0].indexOf("email");
// //     int passwordIndex = rows[0].indexOf("password");
// //     int roolIndex = rows[0].indexOf("rool");
// //     int depIndex = rows[0].indexOf("dep");
// //     int nameIndex = rows[0].indexOf("name");
// //     int regnumIndex = rows[0].indexOf("regnum");

// //     for (int i = 1; i < rows.length; i++) {
// //       String email = rows[i][emailIndex];
// //       String password = rows[i][passwordIndex];
// //       String rool = rows[i][roolIndex];
// //       String dep = rows[i][depIndex];
// //       String name = rows[i][nameIndex];
// //       String regnum = rows[i][regnumIndex];

// //       try {
// //         UserCredential userCredential =
// //             await FirebaseAuth.instance.createUserWithEmailAndPassword(
// //           email: email,
// //           password: password,
// //         );
// //         // User registration successful, store additional details in Firestore
// //         UserModel userModel = UserModel(
// //           uid: userCredential.user!.uid,
// //           email: email,
// //           rool: rool,
// //           dep: dep,
// //           name: name,
// //           regnum: regnum,
// //           password: password,
// //         );
// //         await FirebaseFirestore.instance
// //             .collection("users")
// //             .doc(userCredential.user!.uid)
// //             .set(userModel.toDocument());
// //       } on FirebaseAuthException catch (e) {
// //         if (e.code == 'weak-password') {
// //           // Handle weak password error
// //         } else if (e.code == 'email-already-in-use') {
// //           // Handle email already in use error
// //         } else {
// //           // Handle other FirebaseAuth errors
// //         }
// //       } on FirebaseException catch (e) {
// //         // Handle other Firebase errors
// //       } catch (e) {
// //         // Handle other errors
// //       }
// //     }
// //   } else {
// //     // User canceled the file picker
// //   }