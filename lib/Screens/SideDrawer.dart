import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final FirebaseAuth auth = FirebaseAuth.instance;
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
              CupertinoIcons.book_circle,
              size: 30,
            ),
            onTap: (){
              Navigator.of(context).pushNamed("community");
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
      StreamBuilder<User?>(
        // The stream is the auth state changes from Firebase
        stream: auth.authStateChanges(),
        // The builder takes a snapshot of the stream data
        builder: (context, snapshot) {
          // If the snapshot has data, it means the user is signed in
          if (snapshot.hasData) {
            // Return the list tile for signed in users
            return ListTile(
              title: Text("SignOut"),
              leading: Icon(Icons.logout),
              onTap: () {
                // Perform sign out logic here
                auth.signOut();
                Navigator.of(context).pushNamed("homepage");
              },
            );
          } else {
            // Return the list tile for signed out users
            return ListTile(
              leading: Icon(Icons.login),
              title: Text('Sign in'),
              onTap: () {
                Navigator.of(context).pushNamed("signup");
              },
            );
          }
        },
      ),
          // these are the pages that i am trying to make
        ],
      ),
    );
  }
}
