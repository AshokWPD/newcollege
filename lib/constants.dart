
import 'package:appcollege/about.dart';
import 'package:appcollege/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login/mob_log.dart';

final auth = FirebaseAuth.instance;
var defaultBackgroundColor = Colors.white;
var appBarColor = Colors.grey[900];
// String ResultURL='https://www.onlinesbi.sbi/sbicollect/';

String ResultURL='http://exam.cutn.ac.in:8080/exams-2022-even/result/';
var myAppBar = AppBar(
  backgroundColor: appBarColor,
  title: const Text(' '),
  // centerTitle: false,
);
var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);

class myDrawer extends StatelessWidget {
  const myDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[150],
      elevation: 0,
      child: Column(
        children: [
          DrawerHeader(
            child: Image.asset(
              'assets/image/logoo.png',
              width: 250,
              height: 250,
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'D A S H B O A R D',
                style: drawerTextColor,
              ),
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, moblog.routeName, (route) => true),
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: Icon(Icons.info),
              title: Text(
                'A B O U T',
                style: drawerTextColor,
              ),
              onTap: () => Navigator.restorablePushNamed(
                context,
                about.routeName,
              ),
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: Icon(Icons.help),
              title: Text(
                'H E L P',
                style: drawerTextColor,
              ),
              onTap: () => Navigator.restorablePushNamed(
                context,
                setting.routeName,
              ),
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  'L O G O U T',
                  style: drawerTextColor,
                ),
                onTap: () => auth.signOut().then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => moblog()),
                    ))),
          ),
        ],
      ),
    );
  }
}

// set color for correct answer
const Color correct = Color(0xFF32AB58);
// set color for incorrect answer
const Color incorrect = Color(0xFFAB3232);
// set a neutral color
// not going to take pure white because it hurts eyes.
const Color neutral = Color(0xFFE7E7E7);
// set some background color
const Color background = Color(0xFF1A3464);
