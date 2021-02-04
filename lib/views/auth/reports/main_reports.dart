import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:dakotawebsite/views/auth/reports/reports_desktop.dart';
import 'package:dakotawebsite/views/auth/reports/reports_mobile.dart';

class MainReports extends StatefulWidget {
  @override
  _MainReportsState createState() => _MainReportsState();
}

class _MainReportsState extends State<MainReports> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: ReportsMobile(),
      desktop: ReportsDesktop(),
    );
  }
}
