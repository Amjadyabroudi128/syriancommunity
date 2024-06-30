import 'package:flutter/material.dart';
import 'package:syrianadmin/Register/LogIn.dart';
import 'package:syrianadmin/Screens/Celebrations/Add/screen/AddCelebration.dart';
import 'package:syrianadmin/Screens/Celebrations/CelebrationView/CelebrationView.dart';
import 'package:syrianadmin/Screens/Celebrations/editCelebrations/screen/editCelebrations.dart';
import 'package:syrianadmin/Screens/Contact/AddContactDetails.dart';
import 'package:syrianadmin/Screens/Contact/ContactUS.dart';
import 'package:syrianadmin/Screens/HomePage/AddHomePage.dart';
import 'package:syrianadmin/Screens/HomePage/editHomePage.dart';
import 'package:syrianadmin/Screens/community/Community.dart';
import 'package:syrianadmin/Screens/community/addCommunity.dart';
import 'package:syrianadmin/Screens/community/editCommunity.dart';
import 'package:syrianadmin/Screens/team/EditTeam.dart';
import 'package:syrianadmin/Screens/team/Team.dart';
import 'package:syrianadmin/Screens/team/addTeam.dart';
import 'Screens/HomePage/HomePage.dart';

class  AppRouter{
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case "homepage": return MaterialPageRoute(builder: (_) => const HomePage());
      case "addInfo": return MaterialPageRoute(builder: (_)=> AddInfo());
      case "ourteam": return MaterialPageRoute(builder: (_) => MeetOurTeam());
      case "addMember": return MaterialPageRoute(builder: (_) => AddMember());
      case "contactus": return MaterialPageRoute(builder: (_) => ContactUs());
      case "addcontact": return MaterialPageRoute(builder: (_) => AddContactDetails());
      case "celebrations": return MaterialPageRoute(builder: (_) => Celebrations());
      case "addcelebration": return MaterialPageRoute(builder: (_) => AddCelebration());
      case "editMember": return MaterialPageRoute(builder: (_) => EditMember(DocID: "", oldName: "", oldDetail: ""));
      case "editCelebration": return MaterialPageRoute(builder: (_) => EditCelebration(DocID: "", oldName: "", oldDetail: ""));
      case "community": return MaterialPageRoute(builder: (_) => Community());
      case "addCommunity": return MaterialPageRoute(builder: (_) => addCommunity());
      case "editCommunity": return MaterialPageRoute(builder: (_) => EditCommunity(DocID: "", oldName: "", oldDetails: ""));
      case "editHome": return MaterialPageRoute(builder: (_) => EditHome(DocID: "", oldName: "", oldDetail: ""));
      case "login": return MaterialPageRoute(builder: (_) => Login());
    }
   return null;
  }
}