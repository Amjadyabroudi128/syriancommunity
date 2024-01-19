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
            onTap: (){
              Navigator.of(context).pushReplacementNamed("homepage");

            },
          ),
          ListTile(
            title: Text("contact us "),
            leading: Icon(
              CupertinoIcons.mail_solid,
              size: 30,
            ),
            onTap: (){
              Navigator.of(context).pushNamed("contactus");

            },
          ),
          ListTile(
            title: Text("meet Our Teeam "),
            leading: Icon(
              CupertinoIcons.group_solid,
              size: 30,
            ),
            onTap: (){
              Navigator.of(context).pushNamed("ourteam");
            },
          ),
          ListTile(
            title: Text("community Resources"),
            leading: Icon(
              CupertinoIcons.book_solid,
              size: 30,
            ),
            onTap: (){
              Navigator.of(context).pushNamed("learning");
            },
          ),
          ListTile(
            title: Text("Celebrations"),
            leading: Icon(
              Icons.celebration,
              size: 30,
            ),
            onTap: (){
              Navigator.of(context).pushNamed("celebrations");
            },
          ),
          // these are the pages that i am trying to make
        ],
      ),
    );
  }
}
