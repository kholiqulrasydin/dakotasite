import 'package:flutter/material.dart';

class ReportsMobile extends StatefulWidget {
  @override
  _ReportsMobileState createState() => _ReportsMobileState();
}

class _ReportsMobileState extends State<ReportsMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      body: Center(
        child: Text('Mohon gunakan mode desktop\natau peramban/browser di Komputer\nuntuk melihat website.'),
      ),
    );
  }
}
