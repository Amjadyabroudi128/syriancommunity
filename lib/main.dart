import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrianadmin/Screens/Celebrations/Delete/bloc/delete_bloc.dart';
import 'package:syrianadmin/Screens/Celebrations/editCelebrations/controller/edit_celebration_bloc.dart';
import 'package:syrianadmin/appRoute.dart';
import 'package:syrianadmin/components/firebase_options.dart';
import 'package:syrianadmin/simple_bloc_observer.dart';
import 'Api/Firebase_api.dart';
import 'Register/Bloc/auth_bloc.dart';
import 'Screens/Celebrations/Add/controller/add_bloc.dart';
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
  Bloc.observer = SimpleBlocObserver();
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
        BlocProvider(create: (context) => EditCelebrationBloc()),
        BlocProvider(create: (context) => DeleteBloc()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => AddBloc()),
      ],
      child: ScreenUtilInit(
        splitScreenMode: true,
        minTextAdapt: true,
        // only call it once in the app
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
      ),
    );
  }
}


