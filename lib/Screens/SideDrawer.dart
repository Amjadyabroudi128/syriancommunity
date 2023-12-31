import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
        Container(
        height: 250,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: AssetImage("images/syrianlogo.jpg"),
            fit: BoxFit.cover,
          ),
          ),
          ),
          ListTile(
            title: Text("Home"),
            leading: Icon(
              CupertinoIcons.home,
              size: 30,
            ),
          ),
          ListTile(
            title: Text("About us "),
            leading: Icon(
              CupertinoIcons.person_fill,
              size: 30,

            ),
            onTap: (){},
          ),
          ListTile(
            title: Text("Latest News"),
            leading: Icon(
              CupertinoIcons.news_solid,
              size: 30,

            ),
            onTap: (){},
          ),
          ListTile(
            title: Text("meet Our Teeam "),
            leading: Icon(
              CupertinoIcons.group_solid,
              size: 30,
            ),
            onTap: (){},
          ),
          ListTile(
            title: Text("Learning Resources"),
            leading: Icon(
              CupertinoIcons.book_solid,
              size: 30,
            ),
          ),
          ListTile(
            title: Text("Links"),
            leading: Icon(
              CupertinoIcons.link,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
