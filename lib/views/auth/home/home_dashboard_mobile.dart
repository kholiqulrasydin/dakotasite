import 'package:flutter/material.dart';

class HomeDashboardMobile extends StatefulWidget {
  @override
  _HomeDashboardMobileState createState() => _HomeDashboardMobileState();
}

class _HomeDashboardMobileState extends State<HomeDashboardMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Mohon gunakan mode desktop\natau peramban/browser di Komputer\nuntuk melihat website.'),
      ),
    );
  }
}
