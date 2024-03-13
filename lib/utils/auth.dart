import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth {

  static void logout(BuildContext context) async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: "token");
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

}