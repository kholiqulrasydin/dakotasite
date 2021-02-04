import 'package:flutter/material.dart';
import 'package:dakotawebsite/locator.dart';
import 'package:dakotawebsite/services/navigation_service.dart';

class NavBarLogo extends StatelessWidget {
  const NavBarLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: InkWell(
        onTap: () {
          locator<NavigationService>().navigateTo('HomeRoute');
        },
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
