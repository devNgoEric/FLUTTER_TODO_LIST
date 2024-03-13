// ignore_for_file: prefer_const_constructors_in_immutables, unnecessary_new, prefer_const_constructors, unnecessary_null_comparison, unused_field, prefer_is_empty

import 'package:flutter/material.dart';

class PassWordInput extends StatefulWidget {
  final TextEditingController controller;

  PassWordInput({
    super.key,
    required this.controller
  });

  @override
  State<PassWordInput> createState() => _PassWordInputState();
}

class _PassWordInputState extends State<PassWordInput> {
  late bool _showPasswords;
  late bool _obscureText;
  Icon icon = Icon(Icons.lock);


  @override
  void initState() {
    super.initState();
    _showPasswords = false;
    _obscureText = true;
  }


  void onChangePasswords(String password) {
    if (password.length > 0) {
      icon = Icon(Icons.remove_red_eye);
    } else {
      icon = Icon(Icons.lock);
    }
    setState(() {
      icon;
    });
  }

  void onShowPasswords(){
    _obscureText = !_obscureText;
    if (!_obscureText) {
      icon = Icon(Icons.remove_red_eye_outlined);
    } else {
      icon = Icon(Icons.remove_red_eye);
    }
    setState(() {
      icon;
      _obscureText;
    });
  }


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: TextInputType.text,
      onChanged: (value) => onChangePasswords(value),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: onShowPasswords,
          icon: icon,
        ),
        hintText: "Type here...",
        labelText: "Password",
        errorBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.red, width: 0.0),
        ),
      ),
    );
  }
}
