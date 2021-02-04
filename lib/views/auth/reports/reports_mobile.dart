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
      body: SingleChildScrollView(
        child: Center(
          child: Text('Ini Adalah Reports Mobile mode'),
        ),
      ),
    );
  }
}
