// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

class MyBtn extends StatelessWidget {
  final String text;
  VoidCallback onPress;
  
  MyBtn({super.key, required this.text, required this.onPress });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      color: Theme.of(context).primaryColor,
      child: Text(text, style: TextStyle(color: Colors.white),),
    );
  }
}