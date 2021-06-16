import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Main Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.globe),
            title: Text('Countries'),
            onTap: () => {Navigator.pushNamed(context, '/')},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.solidStar),
            title: Text('Favourites'),
            onTap: () => {Navigator.pushNamed(context, '/favourites')},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.plane),
            title: Text('Visited'),
            onTap: () => {Navigator.pushNamed(context, '/visited')},
          ),
        ],
      ),
    );
  }
}
