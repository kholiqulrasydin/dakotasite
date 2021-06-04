import 'package:flutter/material.dart';

class NavBarItemTabletDesktop extends StatelessWidget {
  final dynamic model;
  NavBarItemTabletDesktop(this.model);

  @override
  Widget build(BuildContext context) {
    return Text(
      model.title,
      style: TextStyle(fontSize: 18),
    );
  }
}
