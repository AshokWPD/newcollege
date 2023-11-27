
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../model.dart';
import 'clglist.dart';
import 'clgup.dart';

class clgnot extends StatefulWidget {
  const clgnot({super.key});

  @override
  State<clgnot> createState() => _clgnotState();
  static String routeName = 'clgnot';
}

class _clgnotState extends State<clgnot> {
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
        loggedInUser = UserModel.fromMap(value.data());
      }).whenComplete(() {
        const CircularProgressIndicator();
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
      length: 2, // Two tabs: Upload Notice and View List of Notice
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              'College Notice ',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 21,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upload Notice'),
              Tab(text: 'View List of Notice'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            clgup(),
            clglist(),
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
//                     builder: (context) => Uploadnot(),
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
//                       'Upload notice',
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
//               MaterialPageRoute(builder: (context) => notPage()),
//             );
//           },
//           child: Text('View NOTICE'),
//         ),
//       ]),
//     );
//   }
// }
