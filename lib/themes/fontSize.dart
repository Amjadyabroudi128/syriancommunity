import 'package:flutter/material.dart';
import 'package:syrianadmin/themes/colors.dart';

import 'font_weight_helper.dart';

 class TextStyles {
   static TextStyle font15 = TextStyle(
     fontSize: 15,
   );
   static TextStyle font20white = TextStyle(
     fontSize: 20,
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
 }