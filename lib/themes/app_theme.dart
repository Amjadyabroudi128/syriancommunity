import 'package:flutter/material.dart';
import 'colors.dart';

 ThemeData appTheme = ThemeData(
     useMaterial3: false,
     cardColor: ColorManager.cardColor,
     cardTheme: CardTheme(
       elevation: 0
     ),
     appBarTheme: AppBarTheme(
       color: ColorManager.specialGreen,
       centerTitle: true,

     ),
   inputDecorationTheme: InputDecorationTheme(
     // contentPadding: EdgeInsets.all(30),
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(30),
         borderSide: BorderSide(color: ColorManager.hintText),
       ),
     enabledBorder: OutlineInputBorder(
       borderSide: BorderSide(width: 1, color: ColorManager.hintText), //<-- SEE HERE
       borderRadius: BorderRadius.circular(50.0),
     ),
       focusedBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(30),
           borderSide:  BorderSide(
                color: ColorManager.hintText
           )
       )
   ),
 );