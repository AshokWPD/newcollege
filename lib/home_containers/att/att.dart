
import 'package:appcollege/home_containers/att/attup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../model.dart';
import 'list.dart';

class attview extends StatefulWidget {
  @override
  _attviewState createState() => _attviewState();
  static String routeName = 'attview';
}

class _attviewState extends State<attview> {
  // late String pdfurl;

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

    return DefaultTabController(
      length: isstu ? 2 : 1, // Set the length based on student status
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              'ATTENDANCE ',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 21,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            tabs: [
              if (isstu)
                Tab(text: 'Upload Attendance'),
              Tab(text: 'View Uploads'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            if (isstu)
              UploadPDF(),
            PDFPage(),
          ],
        ),
      ),
    );
  }
}





























//       body: Column(children: [
//         if (isstu)
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => UploadPDF(),
//                   ),
//                 );
//               },
//               child: Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(20)),
//                   width: 200,
//                   height: 50,
//                   child: const Center(
//                     child: Text(
//                       'Upload Attanance',
//                       style: TextStyle(
//                         color: Color.fromARGB(255, 255, 255, 255),
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ElevatedButton(
//           onPressed: () async {
//             // ignore: use_build_context_synchronously
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => PDFPage()),
//             );
//           },
//           child: Text('View PDF List'),
//         ),
//       ]),
//     );
//   }
// }
