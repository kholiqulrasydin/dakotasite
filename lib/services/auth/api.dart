import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<int> getAuth(
      String email,
      String password,
      ) async {
    final prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.post(
        Uri.parse('https://simentan.ponorogo.go.id/api/public/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{'email': email, 'password': password}));

    if(response.statusCode == 200){
      int code;
      Map<String, dynamic> abstract = jsonDecode(response.body);
      Map<String, dynamic> user = abstract['success'];
      print(user['token']);
      prefs.setString('token', user['token']);
      bool authenticated = await getPrivileges();
      if(authenticated){
        code = 200;
      }else{
        prefs.setString('token', null);
        code = 300;
      }

      return code;
    } else {
      print('login gagal');

      return response.statusCode;
    }

  }

  static Future<int> signOut() async {
    print('Loging Out API');
    final prefs = await SharedPreferences.getInstance();
    final http.Response response = await http.post(
      Uri.parse('https://simentan.ponorogo.go.id/api/public/api/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> abstract = jsonDecode(response.body);
      print(abstract);
      prefs.setString('token', null);
    } else {
      print('Logout Error');
    }

    return response.statusCode;

  }

  static Future<bool> getPrivileges() async {
    final prefs = await SharedPreferences.getInstance();
    bool ok;
    await http.get(
        Uri.parse('https://simentan.ponorogo.go.id/api/public/api/account/getUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        }).then((response){
          print(response.statusCode.toString());
          if(response.statusCode == 200){
            List<dynamic> userInfo = jsonDecode(response.body);
            Map<String, dynamic> usr = userInfo.first;
            int userPrivileges = usr['privileges'];
            print('authenticated = $userPrivileges');
            if(userPrivileges == 1){
              ok = true;
            }else{
              ok = false;
            }
          }else{
            ok = false;
          }
    });
    return ok;
  }


}
