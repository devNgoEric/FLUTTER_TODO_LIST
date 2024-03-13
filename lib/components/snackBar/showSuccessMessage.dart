// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';

void showSuccessMessage(BuildContext context, String message) {
  final snackBar = SnackBar(
      duration: Duration(seconds: 2),
      content: Row(children: [
        Icon(Icons.check_circle, color: Colors.green),
        SizedBox(width: 2),
        Text(message)
      ]));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
