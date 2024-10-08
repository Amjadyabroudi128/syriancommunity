import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';
import 'font_weight_helper.dart';

 class TextStyles {
   static TextStyle font20white = TextStyle(
     fontSize: 19.sp,
     color: Colors.white
   );
   static TextStyle font20grey = TextStyle(
       fontSize: 20,
       color: Colors.grey
   );
   static TextStyle font16green = TextStyle(
       fontSize: 16,
       color: ColorManager.specialGreen,
       fontWeight: FontWeightHelper.bold,
   );
   static TextStyle font14green = TextStyle(
     fontSize: 14,
     color: ColorManager.specialGreen,
     fontWeight: FontWeightHelper.bold,
   );
   static TextStyle font17 = TextStyle(
     fontSize: 17,
   );
   static TextStyle fontdate = TextStyle(
     fontSize: 15.sp,
     color: ColorManager.dateColor
   );
   static TextStyle hintText = TextStyle(
     fontSize: 13,
     color: ColorManager.hintText
   );
   static TextStyle fbText = TextStyle(
     fontSize: 14,
     color: ColorManager.fbColor
   );
   static TextStyle delete = TextStyle(
     color: ColorManager.delete
   );
   static TextStyle ListTile = TextStyle(
     color: Colors.black,
     fontSize: 15
   );
   static TextStyle emailLink = TextStyle(
     color: ColorManager.specialGreen,
     decoration: TextDecoration.underline,
       fontSize: 16
   );
   static TextStyle  appBarText = TextStyle(
       fontSize: 22,
       color: Colors.white
   );
   static TextStyle  lightSnackBar = TextStyle(
       color: Colors.white,
       fontSize: 20,
       fontWeight: FontWeightHelper.medium
   );
   static TextStyle darkSnackBar = TextStyle(
       color: Colors.white,
       fontSize: 20,
       fontWeight: FontWeightHelper.medium
   );
   static TextStyle darkLabel = TextStyle(
     color: Colors.grey,
     fontSize: 15,
     fontWeight: FontWeightHelper.medium
   );
   static TextStyle floatingLabel = TextStyle(
       fontSize: 22,
       color: Colors.white70
   );
   static TextStyle lightLabel = TextStyle(
     color: Colors.black,
     fontSize: 15,
     fontWeight: FontWeightHelper.medium
   );
   static TextStyle lightFloating = TextStyle(
     fontSize: 22,
     color: ColorManager.hintText
   );
   static TextStyle loginAdmin = TextStyle(
     fontSize: 25,
     fontWeight: FontWeightHelper.bold,
     decorationThickness: 2,
   );
   static TextStyle darkErrorText = TextStyle (
       fontSize: 18,
       color: ColorManager.darkError
   );
   static TextStyle expansionE = TextStyle(
       fontSize: 16, fontWeight: FontWeightHelper.medium
   );
   static TextStyle expansionA = TextStyle(
       fontSize: 18, fontWeight: FontWeightHelper.medium
   );
   static TextStyle IconA = TextStyle(
       fontSize: 30,
   );
   static TextStyle IconE = TextStyle(
     fontSize: 30,
   );
 }