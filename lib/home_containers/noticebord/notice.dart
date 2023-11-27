import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../model.dart';
import 'noticeup.dart';
import 'notivelist.dart';

class notice extends StatefulWidget {
  const notice({super.key});

  @override
  State<notice> createState() => _noticeState();
  static String routeName = 'notice';
}

class _noticeState extends State<notice> {
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
              'NOTICE BOARD ',
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
                Tab(text: 'Upload Notice'),
              Tab(text: 'View Notices'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            if (isstu)
              Uploadnot(),
            notPage(),
          ],
        ),
      ),
    );
  }
}
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Center(
//           child: Text(
//             'NOTICE BOARD ',
//             style: TextStyle(
//               color: Colors.blue,
//               fontSize: 21,
//             ),
//           ),
//         ),
//         backgroundColor: Colors.white,
//       ),
//       body: Column(
//         children: [
//           if (isstu)
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: InkWell(
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Uploadnot(),
//                   ),
//                 ),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.white,
                      
//                       boxShadow: const [
//                         BoxShadow(
//                             color: Colors.grey,
//                             blurRadius: 4,
//                             // offset: Offset(8.0, 8.0)
//                             )
//                       ],
//                       border: Border.all(
//                           color: Color.fromARGB(255, 255, 255, 255), width: 3)),
//                   height: 200,
//                   width: MediaQuery.of(context).size.width,
//                   child: Center(
//                     child: Text(
//                       'Upload Department Notice',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: InkWell(
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => notPage(),
//                 ),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                   color: Colors.white,
//                     boxShadow: const [
//                       BoxShadow(
//                           color: Colors.grey,
//                           blurRadius: 4,
//                           // offset: Offset(8.0, 8.0)
//                           )
//                     ],
//                     border: Border.all(
//                         color: Color.fromARGB(255, 248, 248, 248), width: 3)),
//                 height: 200,
//                 width: MediaQuery.of(context).size.width,
//                 child: Center(
//                   child: Text(
//                     'View List of Notice',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
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

