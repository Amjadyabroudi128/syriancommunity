import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syrianadmin/Register/LogIn.dart';
import 'package:syrianadmin/components/ListTile.dart';
import 'package:syrianadmin/components/icons.dart';
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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.69,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
          Containers.image,
            MYlist(
              title: Text(AppLocalizations.of(context)!.home),
              leading: myIcons.home,
              onTap: (){
                Navigator.of(context).pushReplacementNamed("homepage");
              },
            ),
            MYlist(
              title: Text(AppLocalizations.of(context)!.contact),
              leading: myIcons.email,
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).pushNamed("contactus");

              },
            ),
            MYlist(
              title: Text(AppLocalizations.of(context)!.team),
              leading: myIcons.ourGroup,
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).pushNamed("ourteam");
              },
            ),
            MYlist(
              title: Text(AppLocalizations.of(context)!.communityResources),
              leading: myIcons.communityResources,
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).pushNamed("community");
              },
            ),
            MYlist(
              title: Text(AppLocalizations.of(context)!.celebrations),
              leading: myIcons.celebrations,
              onTap: (){
                Navigator.pop(context);
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
                  return MYlist(
                    leading: Icon(Icons.logout),
                    title: Text(AppLocalizations.of(context)!.logout),
                    onTap: (){
                      auth.signOut();
                      ScaffoldMessenger.of(context).showSnackBar
                        (  SnackBar(content: Text(AppLocalizations.of(context)!.signedOut),));
                      Navigator.of(context).pushNamed("homepage");
                    },
                  );
                } else {
                  // Return the list tile for signed out users
                  return MYlist(
                    leading: Icon(Icons.login),
                    title: Text(AppLocalizations.of(context)!.login),
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute<Widget>(
                          builder: (BuildContext context) {
                            return  Login();
                      },
                      )
                      );

                    },
                  );
                }
              },
            ),

            ExpansionTile(
                leading: myIcons.language,
                title: Text(AppLocalizations.of(context)!.language),

                children: <Widget>[
                  MYlist(
                    leading: Text(myIcons.english),
                    title: Text(AppLocalizations.of(context)!.english),
                    onTap: (){
                      MyApp.setLocale(context, Locale("en"));
                    },
                  ),
                  MYlist(
                    leading: Text(myIcons.Arabic),
                    title: Text(AppLocalizations.of(context)!.arabic),
                    onTap: (){
                      MyApp.setLocale(context, Locale("ar"));
                    },
                  ),

                ],
              ),
          ],
        ),
      ),
    );

  }
}


