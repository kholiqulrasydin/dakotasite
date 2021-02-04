import 'package:flutter/material.dart';

class HomeDashboardDesktop extends StatefulWidget {
  @override
  _HomeDashboardDesktopState createState() => _HomeDashboardDesktopState();
}

class _HomeDashboardDesktopState extends State<HomeDashboardDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      body: SingleChildScrollView(
        child: Center(
          child: Text('Ini Adalah Dashboard mode desktop'),
        ),
      ),
    );
  }
}
