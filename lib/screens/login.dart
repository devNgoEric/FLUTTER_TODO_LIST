// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_new, use_build_context_synchronously, prefer_const_constructors_in_immutables, unrelated_type_equality_checks, prefer_is_empty, unused_import

import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list/components/keyboardInput/passwordInput.dart';
import 'package:flutter_todo_list/components/loading/index.dart';
import 'package:flutter_todo_list/services/mutation/auth/login.dart';
import 'package:flutter_todo_list/components/snackBar/showErrorMessage.dart';
import 'package:flutter_todo_list/components/snackBar/showSuccessMessage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final storage = new FlutterSecureStorage();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> triggerLogin() async {
  
    final body = {
      "username": userNameController.text,
      "password": passwordController.text
    };

    var response = await onLogin(body);
    if (response.data['statusCode'] == 200) {
      showSuccessMessage(context, response.data['description']);
      var token = response.data['data']['token'];
      await storage.write(key: "token", value: token);
      openLoadingModal(context, true);
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      });
    } else {
      closeLoadingModal(context);
      showErrorsMessage(context, response.data['description']);
    }
  }

  void handleLogin(){
    if (userNameController.text.length == 0 || passwordController.text.length == 0) {
      showErrorsMessage(context, "Please Enter Username and Password");
      return;
    }
    openLoadingModal(context, false);
    triggerLogin();
  }

  void openLoadingModal(context, isDone) {
    showDialog(
        context: context,
        builder: (context) {
          return LoadingModal(isDone: isDone);
        });
  }

  void closeLoadingModal(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.deepPurple[300]),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Container(
                width: double.maxFinite,
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.deepOrange[100],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: loginForm(
                    userNameController, passwordController, handleLogin)),
          ),
        ),
      ),
    );
  }
}

Widget loginForm(TextEditingController userNameController,
    TextEditingController passwordController, dynamic handleLogin) {
  return Container(
      child: Padding(
    padding: EdgeInsets.all(25),
    child: Column(
      children: [
        Text("Login",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
        SizedBox(height: 30),
        inputText(userNameController, "Type here...", "User Name",
            Icon(Icons.account_circle)),
        SizedBox(height: 15),
        PassWordInput(controller: passwordController),
        SizedBox(height: 15),
        MaterialButton(
          onPressed: handleLogin,
          color: Colors.deepPurple[500],
          padding: EdgeInsets.only(left: 60, right: 60, top: 20, bottom: 20),
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 30),
        Text("Don't have a account REGISTER")
      ],
    ),
  ));
}

TextField inputText(TextEditingController controller, String hintText,
    String labelText, Icon icon) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      suffixIcon: icon,
      hintText: hintText,
      labelText: labelText,
      errorBorder: OutlineInputBorder(
        borderSide: new BorderSide(color: Colors.red, width: 0.0),
      ),
    ),
  );
}
