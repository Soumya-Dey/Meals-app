import 'package:flutter/material.dart';

import '../screens/favorites_screen.dart';
import '../screens/settings_screen.dart';

class DrawerListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function tapHandler;

  DrawerListItem({
    @required this.icon,
    @required this.title,
    @required this.tapHandler,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: Theme.of(context).textTheme.title.copyWith(
              fontFamily: "RopaSans",
            ),
      ),
      onTap: tapHandler,
    );
  }
}

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 150,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/drawer_header.png",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Text(
                  "Cook it up!",
                  style: Theme.of(context).textTheme.title.copyWith(
                        fontFamily: "RopaSans",
                        fontSize: 30,
                        color: Colors.black,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          DrawerListItem(
            icon: Icons.restaurant,
            title: "Meals",
            tapHandler: () {
              Navigator.of(context).pushReplacementNamed(
                "/",
              );
            },
          ),
          DrawerListItem(
            icon: Icons.settings,
            title: "Settings",
            tapHandler: () {
              Navigator.of(context).pushReplacementNamed(
                SettingsScreen.routeName,
              );
            },
          ),
        ],
      ),
    );
  }
}
