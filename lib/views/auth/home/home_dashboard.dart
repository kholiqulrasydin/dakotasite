import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:dakotawebsite/views/auth/home/home_dashboard_desktop.dart';
import 'package:dakotawebsite/views/auth/home/home_dashboard_mobile.dart';

class HomeDashboard extends StatefulWidget {
  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HomeDashboardMobile(),
      desktop: HomeDashboardDesktop(),
    );
  }
}
