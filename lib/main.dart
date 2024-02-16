import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrianadmin/Cubits/auth_cubit.dart';
import 'package:syrianadmin/Register/LogIn.dart';
import 'package:syrianadmin/Screens/Celebrations/editCelebrations.dart';
import 'package:syrianadmin/Screens/Contact/AddContactDetails.dart';
import 'package:syrianadmin/Screens/Contact/ContactUS.dart';
import 'package:syrianadmin/Screens/HomePage/editHomePage.dart';
import 'package:syrianadmin/Screens/team/EditTeam.dart';
import 'package:syrianadmin/Screens/team/Team.dart';
import 'package:syrianadmin/Screens/team/addTeam.dart';
import 'package:syrianadmin/firebase_options.dart';
import 'Api/Firebase_api.dart';
import 'Screens/Celebrations/AddCelebration.dart';
import 'Screens/Celebrations/CelebrationView.dart';
import 'Screens/HomePage/AddHomePage.dart';
import 'Screens/HomePage/HomePage.dart';
import 'Screens/community/addCommunity.dart';
import 'Screens/community/Community.dart';
import 'Screens/community/editCommunity.dart';
 final NavigatorKey = GlobalKey<NavigatorState>();

    void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  await FirebaseMessaging.instance.subscribeToTopic("topic");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
        initialRoute: "homepage",
        title: "Syrian Community ",
        theme: ThemeData(
          useMaterial3: false,
          appBarTheme: AppBarTheme(
            color: Color.fromARGB(255, 33, 173, 168),
            centerTitle: true,
          )
        ),
        home: HomePage(),
        navigatorKey: NavigatorKey,
        routes: {
         "homepage" : (context) => HomePage(),
          "addInfo" : (context) => AddInfo(),
          "ourteam" : (context) => const MeetOurTeam(),
          "addMember" : (context) => AddMember(),
          "contactus" : (context) => const ContactUs(),
          "addcontact" : (context) => AddContactDetails(),
          "celebrations" : (context) => Celebrations(),
          "addcelebration" : (context) => AddCelebration(),
          "editMember" : (context) => EditMember(DocID: '', oldName: '', oldDetail: '', oldUrl: '',),
          "editCelebration" : (context) => EditCelebration(DocID: "", oldName: "", oldDetail: "", oldUrl: ""),
          "community" : (context) => Community(),
          "addCommunity" : (context) => addCommunity(),
          "editCommunity" : (context) => EditCommunity(DocID: '', oldName: '', oldDetails: '',),
          "editHome" : (context) => EditHome(DocID: "", oldName: "", oldDetail: ""),
          "login" : (context) => Login(),
        },
      ),
    );
  }
}


