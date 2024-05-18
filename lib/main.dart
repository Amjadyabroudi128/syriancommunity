import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrianadmin/Cubits/auth_cubit/auth_cubit.dart';
import 'package:syrianadmin/Screens/Celebrations/Add/add_celebration_cubit.dart';
import 'package:syrianadmin/Screens/Celebrations/Delete/delete_cubit.dart';
import 'package:syrianadmin/Screens/Celebrations/editCelebrations/edit_celebration_cubit.dart';
import 'package:syrianadmin/appRoute.dart';
import 'package:syrianadmin/components/firebase_options.dart';
import 'Api/Firebase_api.dart';
import 'Screens/HomePage/HomePage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/themes/app_theme.dart';


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
      String? DocID;
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
        BlocProvider(create: (context) => AddCelebrationCubit()),
        BlocProvider(create: (context) => EditCelebrationCubit()),
        BlocProvider(create: (context) => DeleteCubit())
      ],
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
        initialRoute: "homepage",
        title: "Syrian Community ",
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        themeMode: ThemeMode.system, // theme depends on system
        theme: AppTheme.themeData,
        darkTheme: AppTheme.darkTheme,
        home: HomePage(),
        navigatorKey: NavigatorKey,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}


