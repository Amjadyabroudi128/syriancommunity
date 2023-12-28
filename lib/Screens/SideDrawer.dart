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
            title: Text("About us "),
            leading: Icon(
              Icons.person
            ),
            onTap: (){},
          )
        ],
      ),
    );
  }
}
