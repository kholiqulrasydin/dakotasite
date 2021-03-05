import 'package:flutter/material.dart';

class WebMode extends ChangeNotifier{
  bool _auth = false;
  // String _email;
  // String _password;

  bool get auth => _auth;
  set auth(bool auth){
    _auth = auth;
    notifyListeners();
  }

  // String get email =>  _email;
  // String get password => _password;

  // set password(String password){
  //   _password = password;
  //   notifyListeners();
  // }
  // set email(String email){
  //   _email = email;
  //   notifyListeners();
  // }
}