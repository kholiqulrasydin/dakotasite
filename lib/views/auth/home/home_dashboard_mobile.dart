import 'package:flutter/material.dart';

class HomeDashboardMobile extends StatefulWidget {
  @override
  _HomeDashboardMobileState createState() => _HomeDashboardMobileState();
}

class _HomeDashboardMobileState extends State<HomeDashboardMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text('Ini Adalah Dashboard mode Mobile'),
            ],
          ),
        ),
      ),
    );
  }
}
