import 'package:flutter/material.dart';
import 'package:dakotawebsite/routing/route_names.dart';
import 'package:dakotawebsite/widgets/navbar_item/navbar_item.dart';
import 'package:dakotawebsite/widgets/navigation_bar/navbar_logo_pemda.dart';

class NavigationBarTabletDesktop extends StatelessWidget {
  const NavigationBarTabletDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          NavBarLogoPemda(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NavBarItem('Galeri', EpisodesRoute),
              SizedBox(
                width: 60,
              ),
              NavBarItem('Tentang', AboutRoute),
            ],
          )
        ],
      ),
    );
  }
}
