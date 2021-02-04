import 'package:flutter/material.dart';

class WebMode extends ChangeNotifier{
  bool _auth = false;

  bool get auth => _auth;
  set auth(bool auth){
    _auth = auth;
    notifyListeners();
  }
}