import 'package:flutter/material.dart';

class ReportsDesktop extends StatefulWidget {
  @override
  _ReportsDesktopState createState() => _ReportsDesktopState();
}

class _ReportsDesktopState extends State<ReportsDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      body: SingleChildScrollView(
        child: Center(
          child: Text('Ini Adalah Reports desktop mode'),
        ),
      ),
    );
  }
}
