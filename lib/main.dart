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
import 'package:syrianadmin/components/firebase_options.dart';
import 'package:syrianadmin/themes/app_theme.dart';
import 'Api/Firebase_api.dart';
import 'Screens/Celebrations/AddCelebration.dart';
import 'Screens/Celebrations/CelebrationView.dart';
import 'Screens/HomePage/AddHomePage.dart';
import 'Screens/HomePage/HomePage.dart';
import 'Screens/community/addCommunity.dart';
import 'Screens/community/Community.dart';
import 'Screens/community/editCommunity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}


class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
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
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        theme: appTheme,
        home: HomePage(),
        navigatorKey: NavigatorKey,
        routes: {
         "homepage" : (context) => HomePage(),
          "addInfo" : (context) => AddInfo(),
          "ourteam" : (context) => const MeetOurTeam(),
          "addMember" : (context) => AddMember(),
          "contactus" : (context) => const ContactUs(),
          "addcontact" : (context) => AddContactDetails(),
          "celebrations" : (context) => const Celebrations(),
          "addcelebration" : (context) => const AddCelebration(),
          "editMember" : (context) => const EditMember(DocID: '', oldName: '', oldDetail: '', oldUrl: '',),
          "editCelebration" : (context) => EditCelebration(DocID: "", oldName: "", oldDetail: "", oldUrl: ""),
          "community" : (context) => Community(),
          "addCommunity" : (context) => addCommunity(),
          "editCommunity" : (context) => EditCommunity(DocID: '', oldName: '', oldDetails: '',),
          "editHome" : (context) => const EditHome(DocID: "", oldName: "", oldDetail: ""),
          "login" : (context) => const Login(),
        },
      ),
    );
  }
}


