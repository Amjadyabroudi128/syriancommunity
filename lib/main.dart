import 'package:flutter/material.dart';

import 'Screens/HomePage.dart';

void main() {
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
    //     theme: ThemeData(
    //     // Define the default brightness and colors.
    //     colorScheme: ColorScheme.f(
    //     seedColor: Color.fromARGB(255, 33, 173, 168),
    //       brightness: Brightness.light
    // ),
    // ),
      home: HomePage(),
      routes: {
       "homepage" : (context) => HomePage(),

      },
    );
  }
}


