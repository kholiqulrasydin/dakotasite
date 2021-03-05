import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dakotawebsite/constants/app_colors.dart';
import 'package:dakotawebsite/services/auth/api.dart';
import 'package:dakotawebsite/views/auth/wrapper.dart';

class LoginWidgets extends StatefulWidget {
  @override
  _LoginWidgetsState createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends State<LoginWidgets> {
  FToast fToast;
  bool onAsync;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
    onAsync = false;
  }

  void _showToast(String messages, bool alert) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: alert ? Colors.redAccent : Colors.blueAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(alert ? Icons.warning_amber_outlined : Icons.check, color: Colors.white,),
          SizedBox(
            width: 12.0,
          ),
          Text(messages, style: TextStyle(color: Colors.white),),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP_RIGHT,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(size.height > 770 ? 64 : size.height > 670 ? 32 : 16),
      child: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: size.height * (size.height > 770 ? 0.7 : size.height > 670 ? 0.8 : 0.9),
            width: 500,
            color: Colors.white,
            child: Center(
              child: onAsync ? CircularProgressIndicator() : Padding(
                padding: EdgeInsets.all(40),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        "LOG IN",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),

                      SizedBox(
                        height: 8,
                      ),

                      Container(
                        width: 30,
                        child: Divider(
                          color: primaryColor,
                          thickness: 2,
                        ),
                      ),

                      SizedBox(
                        height: 32,
                      ),

                      TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            suffixIcon: Icon(
                              Icons.mail_outline,
                            ),
                          ),
                          autocorrect: true,
                          keyboardType: TextInputType.emailAddress,
                        ),

                      SizedBox(
                        height: 32,
                      ),

                      TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: Icon(
                              Icons.lock_outline,
                            ),
                          ),
                          obscureText: true,
                        ),

                      SizedBox(
                        height: 64,
                      ),

                  FlatButton(
                    onPressed: () async{
                      setState(() {
                        onAsync = true;
                      });
                      await ApiService.getAuth(emailController.text, passwordController.text).then((value) {
                        if(value == 200){
                          _showToast('Login berhasil', false);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthWrapper()));
                        } else if(value == 500){
                          setState(() {
                            onAsync = false;
                          });
                          _showToast('Terjadi kesalahan server', true);
                        }else if(value == 300){
                          setState(() {
                            onAsync = false;
                          });
                          _showToast('Akun tidak diizinkan', true);
                        }
                        else {
                          setState(() {
                            onAsync = false;
                          });
                          _showToast('Email atau password tidak terdaftar', true);
                        }
                      });
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                      SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
