import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dakotawebsite/routing/auth/route_names.dart';
import 'package:dakotawebsite/views/auth/home/home_dashboard.dart';
import 'package:dakotawebsite/views/auth/login/login_view.dart';
import 'package:dakotawebsite/views/auth/reports/main_reports.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginRoute:
      return _getPageRoute(LoginView(), settings);
    case AdminHomeRoute:
      return _getPageRoute(HomeDashboard(), settings);
    case ReportsRoute:
      return _getPageRoute(MainReports(), settings);
    default:
      return _getPageRoute(LoginView(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({this.child, this.routeName})
      : super(
    settings: RouteSettings(name: routeName),
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    child,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}