import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/Register/LogIn.dart';
import '../components/Container.dart';
import '../main.dart';



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
        Containers.image,
          ListTile(
            title: Text(AppLocalizations.of(context)!.home),
            leading: Icon(
              CupertinoIcons.home,
              size: 30,
            ),
            onTap: (){
              Navigator.of(context).pushReplacementNamed("homepage");
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.contact),
            leading: Icon(
              CupertinoIcons.mail_solid,
              size: 30,
            ),
            onTap: (){
              Navigator.of(context).pushNamed("contactus");

            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.team),
            leading: Icon(
              CupertinoIcons.group_solid,
              size: 30,
            ),
            onTap: (){
              Navigator.of(context).pushNamed("ourteam");
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.communityResources),
            leading: Icon(
              CupertinoIcons.book_circle,
              size: 30,
            ),
            onTap: (){
              Navigator.of(context).pushNamed("community");
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.celebrations),
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
                  leading: Icon(Icons.logout),
                  title: Text(AppLocalizations.of(context)!.logout),
                  onTap: (){
                    auth.signOut();
                    Navigator.of(context).pushNamed("homepage");
                  },
                );
              } else {
                // Return the list tile for signed out users
                return ListTile(
                  leading: Icon(Icons.login),
                  title: Text(AppLocalizations.of(context)!.login),
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute<Widget>(
                        builder: (BuildContext context) {
                      return const Login();
                    },
                    )
                    );
                  },
                );
              }
            },
          ),
          ExpansionTile(
              leading: Icon(
                CupertinoIcons.globe,
              ),
              title: Text(AppLocalizations.of(context)!.language),

              children: <Widget>[
                ListTile(
                  leading: Text("🇬🇧"),
                  title: Text(AppLocalizations.of(context)!.english),
                  onTap: (){
                    MyApp.setLocale(context, Locale("en"));
                  },
                ),
                ListTile(
                  leading: Text("🇸🇦"),
                  title: Text(AppLocalizations.of(context)!.arabic),

                  onTap: (){
                    MyApp.setLocale(context, Locale("ar"));
                  },
                ),

              ],
            ),
        ],
      ),
    );
  }
}

