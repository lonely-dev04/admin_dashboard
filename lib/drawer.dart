import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ExpansionTile(title: Text('Verification'), children: [
            ListTile(
              title: Text('Student'),
              onTap: () {
                Navigator.pushNamed(context, '/studentVerification');
              },
            ),
            ListTile(
              title: Text('Staff'),
              onTap: () {
                Navigator.pushNamed(context, '/staffVerification');
              },
            ),
          ]),
          ExpansionTile(title: Text('Report'), children: [
            ListTile(
              title: Text('Student'),
              onTap: () {
                Navigator.pushNamed(context, '/studentReport');
              },
            ),
            ListTile(
              title: Text('Staff'),
              onTap: () {
                Navigator.pushNamed(context, '/staffReport');
              },
            ),
          ]),
          ExpansionTile(
            title: Text('Pages'),
            children: [
              ListTile(title: Text('Home'), onTap: () {}),
              ListTile(title: Text('My Event'), onTap: () {}),
              ListTile(title: Text('Jobs'), onTap: () {}),
              ListTile(title: Text('Courses'), onTap: () {}),
              ListTile(title: Text('Profile'), onTap: () {}),
            ],
          ),
          ExpansionTile(
            title: Text('Support'),
            children: [
              ListTile(title: Text('Support'), onTap: () {}),
              ListTile(title: Text('FAQ'), onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
