import 'package:flutter/material.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'New Tasks',
      style: TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
    ),);
  }
}
