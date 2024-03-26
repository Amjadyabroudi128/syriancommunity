import 'package:flutter/material.dart';
import 'colors.dart';
import 'fontSize.dart';

 ThemeData appTheme = ThemeData(

     useMaterial3: false,
     cardColor: ColorManager.cardColor,
     cardTheme: CardTheme(
       elevation: 0,
       color: ColorManager.cardColor,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(18.0),
       ),
     ),

     iconTheme: IconThemeData(
       size: 30,
     ),
     textButtonTheme: TextButtonThemeData(
       style: TextButton.styleFrom(
         minimumSize: Size(200, 50),
         shape:  RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(9.0),
         ),
         backgroundColor: ColorManager.addEdit,
         padding:  EdgeInsets.symmetric(vertical: 9),
       ),
     ),
     drawerTheme: DrawerThemeData(
       backgroundColor: Colors.white
     ),
     appBarTheme: AppBarTheme(
       color: ColorManager.specialGreen,
       centerTitle: true,
       toolbarHeight: 65,
       iconTheme: IconThemeData(
         size: 25,
         color: ColorManager.expanstionTile
       )
     ),

   popupMenuTheme: PopupMenuThemeData(
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.all(
         Radius.circular(20.0),
       )
     )
   ),

   expansionTileTheme: ExpansionTileThemeData(
     backgroundColor: ColorManager.expanstionTile,
     expansionAnimationStyle: AnimationStyle(
       duration: Duration(milliseconds: 200)
     ),
     collapsedIconColor: Colors.black,
     textColor: Colors.black,
     iconColor: Colors.black
   ),
   buttonTheme: ButtonThemeData(
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.all(
         Radius.circular(15),
       )
     ),
     textTheme: ButtonTextTheme.primary,
   ),
   inputDecorationTheme: InputDecorationTheme(
     hintStyle: TextStyles.hintText,
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
       ),

   ),

 );