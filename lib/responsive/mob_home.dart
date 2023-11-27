
import 'package:appcollege/home_containers/att/att.dart';
import 'package:appcollege/home_containers/fees/fees.dart';
import 'package:appcollege/home_containers/noticebord/notice.dart';
import 'package:appcollege/home_containers/result/result.dart';
import 'package:appcollege/home_containers/test/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../home_containers/att/thelist.dart';
import '../home_containers/fees/thefeeslist.dart';
import '../home_containers/leave/leave.dart';
import '../home_containers/leave/lvyearlist/mainlist.dart';
import '../home_containers/noticebord/notivelist.dart';
import '../home_containers/test/testlist.dart';
import '../home_containers/time/timelist.dart';
import '../model.dart';
import '../util/bottom_navi.dart';
import '../util/home_con.dart';

class mob_home extends StatefulWidget {
  // mob_home({Key? key}) : super(key: key);
  static String routename = 'mob_home';

  const mob_home({super.key});

  @override
  State<mob_home> createState() => _mob_homeState();
}

class _mob_homeState extends State<mob_home> {
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
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.blue,
          weight: 300,
          size: 30,
        ),
        title: Column(
          children: [
            Text(
              "Hi  $namee ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 24,
              ),
            ),
            Text(
              rooll,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 19,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
      endDrawer: const myDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //first 4 boxes in grid
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  itemCount: 8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        switch (index) {
                          case 0:
                            if (rooll == 'Student') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const listPDFPage()),
                              );
                            } else {
                              Navigator.restorablePushNamed(
                                context,
                                attview.routeName,
                              );
                            }
                            break;
                          case 1:
                            if (rooll == 'Student') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const feesliststu()),
                              );
                            } else {
                              Navigator.restorablePushNamed(
                                context,
                                fees.routeName,
                              );
                            }
                            break;
                          case 2:
                            if (rooll == 'Student') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const leaveview()),
                              );
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const mainlist()));
                            }

                            break;
                          case 3:
                            if (rooll == 'Student') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => timePage()),
                              );
                            } else {
                              Navigator.restorablePushNamed(
                                context,
                                timePage.routename,
                              );
                            }
                            break;
                          case 4:
                            if (rooll == 'Student') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => qslist()),
                              );
                            } else {
                              Navigator.restorablePushNamed(
                                context,
                                dailyTest.routeName,
                              );
                            }
                            break;

                          case 5:
                            Navigator.restorablePushNamed(
                              context,
                              resultview.routeName,
                            );
                            break;
                               case 7:
                            
                            
                            break;

                          default:
                            if (rooll == 'Student') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const notPage()),
                              );
                            } else {
                              Navigator.restorablePushNamed(
                                context,
                                notice.routeName,
                              );
                            }
                            break;
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(imagelist[index],fit: BoxFit.cover,),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}
