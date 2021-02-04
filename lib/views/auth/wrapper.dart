import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dakotawebsite/views/auth/layout_template.dart';
import 'package:dakotawebsite/views/auth/login/login_view.dart';

class AuthWrapper extends StatelessWidget {

  Future<bool> verifying() async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString('token') == null){
      return false;
    }else{
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: verifying(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        bool verified;
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        } else {
          verified = snapshot.data;
        }

        return verified ? LayoutTemplate() : LoginView();
      });
  }
}
