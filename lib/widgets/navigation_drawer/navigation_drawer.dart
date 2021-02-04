import 'package:flutter/material.dart';
import 'package:dakotawebsite/routing/route_names.dart';
import 'package:dakotawebsite/widgets/navbar_item/navbar_item.dart';
import 'package:dakotawebsite/widgets/navigation_drawer/navigation_drawer_header.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 16),
        ],
      ),
      child: Column(
        children: <Widget>[
          NavigationDrawerHeader(),
          // BONUS: Combine the UI for this widget with the NavBarItem and make it responsive.
          // The UI for the current DrawerItem shows when it's in mobile, else it shows the NavBarItem ui.
          NavBarItem(
            'Galeri',
            EpisodesRoute,
            icon: Icons.videocam,
          ),
          NavBarItem(
            'Tentang',
            AboutRoute,
            icon: Icons.help,
          ),
        ],
      ),
    );
  }
}
