import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetUserLoginDataForFuture {

  static setUserLoginData({required String email, required String password}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('UserLoginEmail', email);
    pref.setString('UserLoginPassword', password);
  }

  static Future<String?> getLastUserLoginEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? loginEmail = pref.getString('UserLoginEmail');
    return loginEmail;
  }
  static Future<String?> getLastUserLoginPassword() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? loginPassword = pref.getString('UserLoginPassword');
    return loginPassword;
  }

  final email = TextEditingController();
  final password = TextEditingController();

  setLastUserLoginEmail() async {
    final emailRaw = await getLastUserLoginEmail() ?? '';
    email.text = emailRaw;
  }

  setLastUserLoginPassword() async {
    final passwordRaw = await getLastUserLoginPassword() ?? '';
    password.text = passwordRaw;
  }


}