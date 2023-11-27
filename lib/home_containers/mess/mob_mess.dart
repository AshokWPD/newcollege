import 'package:flutter/material.dart';

class mobMess extends StatelessWidget {
  const mobMess({Key? key}) : super(key: key);
  static String routename = 'mobMess';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat '),
      ),
    );
  }
}
