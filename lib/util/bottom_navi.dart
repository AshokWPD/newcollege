
import 'package:appcollege/profile/mob_profile.dart';
import 'package:appcollege/responsive/mob_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../college/clglist.dart';
import '../college/mob_clg.dart';
import '../home_containers/addstu/addstu.dart';
import '../home_containers/addstu/addstuhome.dart';
import '../model.dart';

class MyBottomNavigation extends StatefulWidget {
  @override
  _MyBottomNavigationState createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
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

  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to home page
        Navigator.pushNamed(
          context,
          mob_home.routename,
        );

        break;

      case 1:
        // Navigate to cart page
        if (rooll == 'Student') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => clglist()),
          );
        } else
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => clgnot()));

        break;
      case 2:
        // Navigate to cart page
        Navigator.pushNamed(
          context,
          mobprof.routeName,
        );

        break;

      default:
        // Navigate to profile page
         Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => addstu(),
                  ),
                );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isadmin = rooll == 'Admin';

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.black,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.food_bank_outlined,
            color: Colors.black,
          ),
          label: 'College',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: Colors.black,
          ),
          label: 'Profile',
        ),
        if (isadmin)
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            label: 'Add User',
          ),
      ],
    );
  }
}
