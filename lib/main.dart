import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/Screens/Add%20information.dart';
import 'package:syrianadmin/Screens/Celebrations/editCelebrations.dart';
import 'package:syrianadmin/Screens/Contact/AddContactDetails.dart';
import 'package:syrianadmin/Screens/Contact/ContactUS.dart';
import 'package:syrianadmin/Screens/team/EditTeam.dart';
import 'package:syrianadmin/Screens/team/Team.dart';
import 'package:syrianadmin/Screens/team/addTeam.dart';
import 'Screens/Celebrations/AddCelebration.dart';
import 'Screens/Celebrations/CelebrationView.dart';
import 'Screens/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: "syriancommunity-5239d",
    options: FirebaseOptions(
        apiKey: "AIzaSyDSQtMlQwLsEkK5B1P4fjASVfZ0GCq1eLU",
        appId: "syriancommunity-5239d",
        messagingSenderId:
        "362925763810",
        projectId: "syriancommunity-5239d",
      storageBucket: "syriancommunity-5239d.appspot.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      initialRoute: "homepage",
      title: "Syrian Community ",
      home: HomePage(),
      routes: {
       "homepage" : (context) => HomePage(),
        "addInfo" : (context) => AddInfo(),
        "ourteam" : (context) => MeetOurTeam(),
        "addMember" : (context) => AddMember(),
        "contactus" : (context) => ContactUs(),
        "addcontact" : (context) => AddContactDetails(),
        "celebrations" : (context) => Celebrations(),
        "addcelebration" : (context) => AddCelebration(),
        "editMember" : (context) => EditMember(DocID: '', oldName: '', oldDetail: '', oldUrl: '',),
        "editCelebration" : (context) => EditCelebration(DocID: "", oldName: "", oldDetail: "", oldUrl: "")
      },
    );
  }
}


