
import 'package:flutter/cupertino.dart';
import 'about.dart';
import 'college/mob_clg.dart';
import 'home_containers/addstu/addstu.dart';
import 'home_containers/att/att.dart';
import 'home_containers/att/list.dart';
import 'home_containers/fees/fees.dart';
import 'home_containers/fees/feeslist.dart';
import 'home_containers/leave/leave.dart';
import 'home_containers/mess/mob_mess.dart';
import 'home_containers/noticebord/notice.dart';
import 'home_containers/noticebord/notivelist.dart';
import 'home_containers/result/result.dart';
import 'home_containers/test/test.dart';
import 'home_containers/time/time.dart';
import 'home_containers/time/timelist.dart';
import 'login/mob_log.dart';
import 'profile/mob_profile.dart';
import 'responsive/mob_home.dart';
import 'setting.dart';
import 'splash screen/mob_splash.dart';

Map<String, WidgetBuilder> routes = {
  mobsplash.routename: (context) => mobsplash(),
  moblog.routeName: (context) => moblog(),
  mob_home.routename: (context) => mob_home(),
  attview.routeName: (context) => attview(),
  fees.routeName: (context) => fees(),
  leaveview.routeName: (context) => leaveview(),
  mobMess.routename: (context) => mobMess(),
  resultview.routeName: (context) => resultview(),
  clgnot.routeName: (context) => clgnot(),
  mobprof.routeName: (context) => mobprof(),
  about.routeName: (context) => about(),
  setting.routeName: (context) => setting(),
  addstu.routename: (context) => addstu(),
  timeTable.routeName: (context) => timeTable(),
  dailyTest.routeName: (context) => dailyTest(),
  PDFPage.routename: (context) => PDFPage(),
  FeesPage.routename: (context) => FeesPage(),
  timePage.routename: (context) => timePage(),
  notPage.routename: (context) => notPage(),
  notice.routeName: (context) => notice(),
};
