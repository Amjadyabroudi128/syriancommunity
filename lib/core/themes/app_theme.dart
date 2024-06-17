import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'fontSize.dart';

 class AppTheme {
   static final _border = OutlineInputBorder(
     borderSide: BorderSide(width: 1,
         color: ColorManager.borderColor), //<-- SEE HERE
     borderRadius: BorderRadius.circular(18.0),
   );
   static final _DarkBorder = OutlineInputBorder(
     borderSide: BorderSide(
         color: ColorManager.DarkBorder,
       width: 3
     ),
     borderRadius: BorderRadius.circular(18.0),
   );
   static final darkError = OutlineInputBorder(
     borderSide: BorderSide(
       color: (Colors.red[300])!,
       width: 3,
     ),
     borderRadius: BorderRadius.circular(18.0),
   );
   static final darkTheme = ThemeData(
     brightness: Brightness.dark,
   ).copyWith(
     cardTheme: CardTheme(
       elevation: 0,
       color: Colors.black45,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(18.0),
       ),
     ),
     inputDecorationTheme: InputDecorationTheme(
         suffixIconColor: Colors.white,
         labelStyle: TextStyles.darkLabel,
         floatingLabelStyle: TextStyles.floatingLabel,
         border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
           borderSide: BorderSide(
           ),
         ),
         enabledBorder: _DarkBorder,
         focusedBorder: _DarkBorder,
         errorBorder: darkError,
         errorStyle: TextStyle(
           color: Colors.red[300]
         )
     ),
     popupMenuTheme: PopupMenuThemeData(
       surfaceTintColor: Colors.lightBlueAccent,
       iconColor: Colors.white,
       shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.all(
             Radius.circular(20.0),
           )
       ),
     ),
     drawerTheme: DrawerThemeData(
         endShape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(20),
         )
     ),
     appBarTheme: AppBarTheme(
         shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.only(
                 bottomRight: Radius.circular(20)
             )
         ),
         color: ColorManager.specialGreen,
         centerTitle: true,
         toolbarHeight: 65,
         titleTextStyle: TextStyles.appBarText,

         iconTheme: IconThemeData(
             size: 25,
             color: Colors.white
         )
     ),
     snackBarTheme: SnackBarThemeData(
       insetPadding: EdgeInsets.all(10),
       backgroundColor: Colors.white10,
       contentTextStyle: TextStyles.darkSnackBar,
       showCloseIcon: true,
       closeIconColor: Colors.white54,
       shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.only(
             bottomRight: Radius.circular(6),
           )
       ),
     ),
     listTileTheme: ListTileThemeData(
       iconColor: Colors.white,
       titleTextStyle: TextStyle(
           fontSize: 15,
           color: Colors.white
       ),
     ),
     expansionTileTheme: ExpansionTileThemeData(
       expansionAnimationStyle: AnimationStyle(
           duration: Duration(milliseconds: 200)
       ),
       collapsedIconColor: Colors.white,
       textColor: Colors.white,
       iconColor: Colors.white,
     ),
     iconTheme: IconThemeData(
         size: 30,
         color: Colors.white
     ),
     textSelectionTheme: TextSelectionThemeData(
         selectionColor: Colors.blueAccent,
         cursorColor: Colors.grey,
         selectionHandleColor: Colors.grey
     ),
     buttonTheme: ButtonThemeData(

       shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.all(
             Radius.circular(15),
           )
       ),
       textTheme: ButtonTextTheme.primary, // this gives the best text color for the button
     ),
     textButtonTheme: TextButtonThemeData(
       style: TextButton.styleFrom(
         fixedSize: Size(120, 40),
         backgroundColor: Colors.transparent,
         shadowColor: Colors.transparent,
         shape:  RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(9.0),
         ),
         padding:  EdgeInsets.symmetric(vertical: 9),
       ),
     ),
     dividerTheme: DividerThemeData(
         indent: 40,
         thickness: 1.4,
         color: Colors.grey
     ),
   );

   static final themeData = ThemeData().copyWith(
     inputDecorationTheme: InputDecorationTheme(
         suffixIconColor: Colors.black,
         hintStyle: TextStyles.hintText,
         floatingLabelStyle: TextStyles.lightFloating,
         labelStyle: TextStyles.lightLabel,
         // contentPadding: EdgeInsets.all(25),
         border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
           borderSide: BorderSide(color: ColorManager.hintText),
         ),
         enabledBorder: _border,
         focusedBorder: _border
     ),
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
     textSelectionTheme: TextSelectionThemeData(
       selectionColor: Colors.grey,
       cursorColor: Colors.black,
       selectionHandleColor: Colors.black
     ),
     snackBarTheme: SnackBarThemeData(
       insetPadding: EdgeInsets.all(25),
       backgroundColor: Colors.black.withOpacity(0.55),
       contentTextStyle: TextStyles.darkSnackBar,
       showCloseIcon: true,
       closeIconColor: Colors.white,
       shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.only(
             bottomRight: Radius.circular(6),
           )
       ),
     ),
     textButtonTheme: TextButtonThemeData(
       style: TextButton.styleFrom(
         fixedSize: Size(150, 40),
         backgroundColor: Colors.transparent,
         shadowColor: Colors.transparent,
         shape:  RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(9.0),
         ),
         padding:  EdgeInsets.symmetric(vertical: 9),
       ),
     ),
     drawerTheme: DrawerThemeData(
         backgroundColor: Colors.white,
       endShape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(20),
       )
     ),
     dividerTheme: DividerThemeData(
       indent: 40,
       endIndent: 40,
       thickness: 0.5,
       color: ColorManager.borderColor
     ),
     appBarTheme: AppBarTheme(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.only(
           bottomRight: Radius.circular(20)
         )
       ),
         color: ColorManager.specialGreen,
         centerTitle: true,
         toolbarHeight: 65,
         titleTextStyle: TextStyles.appBarText,
         iconTheme: IconThemeData(
             size: 25,
             color: Colors.white
         )
     ),
     popupMenuTheme: PopupMenuThemeData(
       position: PopupMenuPosition.over,
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
       textTheme: ButtonTextTheme.primary, // his gives the best text color for the button
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
