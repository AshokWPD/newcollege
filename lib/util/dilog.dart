import 'package:flutter/material.dart';

class MyAlertDialogFb1 extends StatelessWidget {
  final String title;
  final String description;

  final List<TextButton> actions;

  const MyAlertDialogFb1(
      {required this.title,
      required this.description,
      required this.actions,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: actions,
    );
  }
}
