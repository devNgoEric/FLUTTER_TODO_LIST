// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MenuDrawerPage extends StatefulWidget {
  final onPressed;
  MenuDrawerPage({super.key, required this.onPressed});

  @override
  State<MenuDrawerPage> createState() => _MenuDrawerPageState();
}

class _MenuDrawerPageState extends State<MenuDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.deepPurple[100],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.amber),
            child: Container(
                child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 48,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: widget.onPressed,
                    child: IntrinsicWidth(
                      child: Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 8),
                          Text('Log Out'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ),
          ListTile(
            title: Text('Home'),
            // selected: _selectedIndex == 0,
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Business'),
            // selected: _selectedIndex == 1,
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('School'),
            // selected: _selectedIndex == 2,
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
