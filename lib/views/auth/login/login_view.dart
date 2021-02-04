import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dakotawebsite/constants/app_colors.dart';
import 'package:dakotawebsite/main.dart';
import 'package:dakotawebsite/viewmodels/web_mode_model.dart';
import 'package:dakotawebsite/widgets/login/login_widgets.dart';


class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIMENTAN DASHBOARD LOGIN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
      ),
      home: _View(),
    );
  }
}

class _View extends StatefulWidget {
  @override
  __ViewState createState() => __ViewState();
}

class __ViewState extends State<_View> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: double.infinity,
                  width: size.width / 2,
                  color: primaryColor,
                ),
                Container(
                    height: double.infinity,
                    width: size.width / 2,
                    color: Colors.white
                ),
              ],
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  "Selamat Datang",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Silakan Login dulu",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Untuk Memasuki SIMENTAN Dashboard dengan gampang,\nhanya membutuhkan waktu kurang dari 30 Detik",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomLeft,
              child: Consumer<WebMode>(
                builder:(context, webMode, _) => FlatButton(
                  onPressed: (){
                    webMode.auth = false;
                    Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                            transitionDuration: Duration.zero,
                            pageBuilder: (_, __, ___) => MainApp()
                        )
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Row(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.white,
                          size: 28,
                        ),

                        SizedBox(
                          width: 8,
                        ),

                        Text(
                          "HOME",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Icon(
                  Icons.menu,
                  color: primaryColor,
                  size: 28,
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Icon(
                      Icons.copyright,
                      color: Colors.grey,
                      size: 24,
                    ),

                    SizedBox(
                      width: 8,
                    ),

                    Text(
                      "Marsell Development App",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),

              //Animation 1
              //transitionBuilder: (widget, animation) => RotationTransition(
              //  turns: animation,
              //  child: widget,
              //),
              //switchOutCurve: Curves.easeInOutCubic,
              //switchInCurve: Curves.fastLinearToSlowEaseIn,

              //Animation 2
              transitionBuilder: (widget, animation) => ScaleTransition(
                  child: widget,
                  scale: animation
              ),

              child: LoginWidgets(),
            ),

          ],
        ),
      ),
    );
  }
}


// class LoginView extends StatefulWidget {
//   @override
//   _LoginViewState createState() => _LoginViewState();
// }
//
// class _LoginViewState extends State<LoginView> {
//   @override
//   Widget build(BuildContext context) {
//
//     Size size = MediaQuery.of(context).size;
//
//     print(size.height);
//     print(size.width);
//
//     return Scaffold(
//       body: Container(
//         width: size.width,
//         height: size.height,
//         child: Stack(
//           children: [
//
//             Row(
//               children: [
//                 Container(
//                   height: double.infinity,
//                   width: size.width / 2,
//                   color: primaryColor,
//                 ),
//                 Container(
//                     height: double.infinity,
//                     width: size.width / 2,
//                     color: Colors.white
//                 ),
//               ],
//             ),
//
//             Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: EdgeInsets.all(32),
//                 child: Text(
//                   "Welcome",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: EdgeInsets.all(32),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     Text(
//                       "Let's Kick Now !",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//
//                     Text(
//                       "It's easy and takes less than 30 seconds",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Padding(
//                 padding: EdgeInsets.all(32),
//                 child: Row(
//                   children: [
//
//                     Icon(
//                       Icons.keyboard_arrow_left,
//                       color: Colors.white,
//                       size: 28,
//                     ),
//
//                     SizedBox(
//                       width: 8,
//                     ),
//
//                     Text(
//                       "HOME",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//
//             Align(
//               alignment: Alignment.topRight,
//               child: Padding(
//                 padding: EdgeInsets.all(32),
//                 child: Icon(
//                   Icons.menu,
//                   color: primaryColor,
//                   size: 28,
//                 ),
//               ),
//             ),
//
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Padding(
//                 padding: EdgeInsets.all(32),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//
//                     Icon(
//                       Icons.copyright,
//                       color: Colors.grey,
//                       size: 24,
//                     ),
//
//                     SizedBox(
//                       width: 8,
//                     ),
//
//                     Text(
//                       "Marsell Development App",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//
//             AnimatedSwitcher(
//               duration: Duration(milliseconds: 500),
//
//               //Animation 1
//               //transitionBuilder: (widget, animation) => RotationTransition(
//               //  turns: animation,
//               //  child: widget,
//               //),
//               //switchOutCurve: Curves.easeInOutCubic,
//               //switchInCurve: Curves.fastLinearToSlowEaseIn,
//
//               //Animation 2
//               transitionBuilder: (widget, animation) => ScaleTransition(
//                   child: widget,
//                   scale: animation
//               ),
//
//               child: LoginWidgets(),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
