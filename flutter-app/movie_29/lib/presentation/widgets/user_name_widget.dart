import 'package:flutter/material.dart';

class UserNameWidget extends StatelessWidget {
  final String name;
  final double fontSize;

  const UserNameWidget({super.key, required this.name, this.fontSize = 18});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
    );
  }
}
