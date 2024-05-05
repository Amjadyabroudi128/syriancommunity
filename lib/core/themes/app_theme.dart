import 'package:flutter/material.dart';
import 'colors.dart';
import 'fontSize.dart';

 class AppTheme {
   static final _border = OutlineInputBorder(
     borderSide: BorderSide(width: 1,
         color: ColorManager.borderColor), //<-- SEE HERE
     borderRadius: BorderRadius.circular(18.0),
   );
   static final darkTheme = ThemeData(
     brightness: Brightness.dark,
     cardTheme: CardTheme(
       elevation: 0,
       color: Colors.black45,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(18.0),
       ),
     ),

   );
   static final themeData = ThemeData(
     // useMaterial3: false,
   ).copyWith(
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
         color: Colors.black
     ),
     textButtonTheme: TextButtonThemeData(
       style: TextButton.styleFrom(
         minimumSize: Size(200, 50),
         shape:  RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(9.0),
         ),
         padding:  EdgeInsets.symmetric(vertical: 9),
       ),
     ),
     drawerTheme: DrawerThemeData(
         backgroundColor: Colors.white
     ),
     dividerTheme: DividerThemeData(
       indent: 40,
       endIndent: 40,
       thickness: 0.5,
       color: ColorManager.borderColor
     ),

     appBarTheme: AppBarTheme(
         color: ColorManager.specialGreen,
         centerTitle: true,
         toolbarHeight: 65,
         titleTextStyle: TextStyle(
           fontSize: 22,
           color: Colors.white
         ),
         iconTheme: IconThemeData(
             size: 25,
             color: Colors.white
         )
     ),
     popupMenuTheme: PopupMenuThemeData(
       surfaceTintColor: Colors.white,
       iconColor: Colors.black,
       shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.all(
             Radius.circular(20.0),
           )
       ),
     ),

     expansionTileTheme: ExpansionTileThemeData(
         expansionAnimationStyle: AnimationStyle(
             duration: Duration(milliseconds: 200)
         ),
         collapsedIconColor: Colors.black,
         textColor: Colors.black,
         iconColor: Colors.black,
     ),
     buttonTheme: ButtonThemeData(
       shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.all(
             Radius.circular(15),
           )
       ),
       textTheme: ButtonTextTheme.primary, // this gives the best text color for the button
     ),

     inputDecorationTheme: InputDecorationTheme(
       suffixIconColor: Colors.black,
         hintStyle: TextStyles.hintText,
         // contentPadding: EdgeInsets.all(25),
         border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
           borderSide: BorderSide(color: ColorManager.hintText),
         ),
         enabledBorder: _border,
         focusedBorder: _border
     ),
     listTileTheme: ListTileThemeData(
       iconColor: Colors.black,
       titleTextStyle: TextStyle(
         fontSize: 15,
         color: Colors.black
       ),
     ),
   );
 }
