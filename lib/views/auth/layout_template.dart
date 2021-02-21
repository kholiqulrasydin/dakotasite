import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:dakotawebsite/constants/app_colors.dart';
import 'package:dakotawebsite/locator.dart';
import 'package:dakotawebsite/main.dart';
import 'package:dakotawebsite/routing/auth/route_names.dart';
import 'package:dakotawebsite/routing/auth/router.dart';
import 'package:dakotawebsite/services/auth/api.dart';
import 'package:dakotawebsite/services/navigation_service.dart';
import 'package:dakotawebsite/widgets/dashboard/side_navigation/side_navigation.dart';

class ViewAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIMENTAN DASHBOARD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
      ),
      home: LayoutTemplate(),
    );
  }
}

class LayoutTemplate extends StatefulWidget {
  const LayoutTemplate({Key key}) : super(key: key);

  @override
  _LayoutTemplateState createState() => _LayoutTemplateState();
}

class _LayoutTemplateState extends State<LayoutTemplate> {

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
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        appBar: sizingInformation.deviceScreenType == DeviceScreenType.mobile || sizingInformation.deviceScreenType == DeviceScreenType.tablet ? dashboardAppBar() : null,
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile || sizingInformation.deviceScreenType == DeviceScreenType.tablet ? dashboardDrawer() : null,
        backgroundColor: Colors.white,
        body:Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: sizingInformation.deviceScreenType == DeviceScreenType.desktop ? SideNavigation() : null,
              ),
              Expanded(
                child: Navigator(
                  key: locator<NavigationService>().navigatorKey,
                  onGenerateRoute: generateRoute,
                  initialRoute: AdminHomeRoute,
                ),
              )
            ],
          ),
      ),
    );
  }

  Drawer dashboardDrawer() => Drawer(
    child: Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 5),
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
      )
    ),
  );

  AppBar dashboardAppBar() => AppBar(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: primaryColor),
    title: Text('Dashboard', style: TextStyle(color: primaryColor),),
  );

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
          InkWell(
            onTap: () {
              setState(() {
                _buttonCurrentIndex = 2;
              });
            },
            child: _colSingleButton(
                icon: Icons.settings,
                iconColor: _buttonCurrentIndex == 2
                    ? primaryColor
                    : Colors.black,
                borderColor: _buttonCurrentIndex == 2
                    ? primaryColor
                    : Colors.transparent,
                title: 'Pengaturan'
            ),
          ),
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
