import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dakotawebsite/constants/app_colors.dart';
import 'package:dakotawebsite/locator.dart';
import 'package:dakotawebsite/main.dart';
import 'package:dakotawebsite/routing/auth/route_names.dart';
import 'package:dakotawebsite/services/auth/api.dart';
import 'package:dakotawebsite/services/navigation_service.dart';

class SideNavigation extends StatefulWidget {
  @override
  _SideNavigationState createState() => _SideNavigationState();
}

class _SideNavigationState extends State<SideNavigation> {
  int _buttonCurrentIndex = 0;
  FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: 165,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurRadius: 2,
              offset: Offset(0.5, 0.0),
              spreadRadius: 2)
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.18),
            _logoWidget(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            _colButtons(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
            _logoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _logoWidget() {
    return Container(
      width: 45,
      height: 45,
      child: Image.asset("assets/logo.png"),
    );
  }

  Widget _colSingleButton({IconData icon, Color borderColor,Color iconColor, @required String title}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: Container(
        width: 135,
        child: Row(
          children: [
            Icon(icon,color: iconColor,),
            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
            Text(title, style: TextStyle(color: iconColor),)
          ],
        ),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 2,
              color: borderColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _colButtons() {
    return Container(
      child: Column(
        children: [
          InkWell(
              onTap: () {
                setState(() {
                  _buttonCurrentIndex = 0;
                  locator<NavigationService>().navigateTo(AdminHomeRoute);
                });
              },
              child: _colSingleButton(
                  icon: Icons.widgets,
                  iconColor: _buttonCurrentIndex == 0
                      ? primaryColor
                      : Colors.black,
                  borderColor: _buttonCurrentIndex == 0
                      ? primaryColor
                      : Colors.transparent,
                  title: 'Dashboard'
              )),
          InkWell(
              onTap: () {
                setState(() {
                  _buttonCurrentIndex = 1;
                  locator<NavigationService>().navigateTo(ReportsRoute);
                });
              },
              child: _colSingleButton(
                  icon: Icons.score,
                  iconColor: _buttonCurrentIndex == 1
                      ? primaryColor
                      : Colors.black,
                  borderColor: _buttonCurrentIndex == 1
                      ? primaryColor
                      : Colors.transparent,
                  title: 'Laporan'
              )),
          // InkWell(
          //   onTap: () {
          //     setState(() {
          //       _buttonCurrentIndex = 2;
          //     });
          //   },
          //   child: _colSingleButton(
          //       icon: Icons.settings,
          //       iconColor: _buttonCurrentIndex == 2
          //           ? primaryColor
          //           : Colors.black,
          //       borderColor: _buttonCurrentIndex == 2
          //           ? primaryColor
          //           : Colors.transparent,
          //       title: 'Pengaturan'
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _logoutButton() {
    return InkWell(
        child: Column(
          children: [
            Icon(Icons.exit_to_app),
            Text('Logout')
          ],
        ),
      onTap: () async {
          await ApiService.signOut().then((value) {
            if (value == 200){
              _showToast('Logout berhasil!', false);
              Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                      transitionDuration: Duration.zero,
                      pageBuilder: (_, __, ___) => MainApp()
                  )
              );
            } else if (value == 500){
              _showToast('Terjadi masalah dengan server, silakan refresh', true);
            }
          });
      },
    );
  }
}
