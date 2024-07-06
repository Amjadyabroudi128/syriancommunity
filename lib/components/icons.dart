import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/themes/colors.dart';

class myIcons {
  static Icon goBack = Icon(Icons.arrow_back);
  static Icon drawer = Icon(CupertinoIcons.list_bullet,);
  static Icon clear = Icon(Icons.clear);
  static Icon home = Icon(CupertinoIcons.home,);
  static Icon ourGroup = Icon(CupertinoIcons.group_solid,);
  static Icon email = Icon(CupertinoIcons.mail_solid,);
  static Icon normalEmail = Icon(Icons.email);
  static String marker = "images/arrow.png" ;
  static Icon facebook = Icon(Icons.facebook, color: ColorManager.fbColor, size: 38,);
  static Icon phone = Icon(Icons.phone);
  static Icon communityResources = Icon(CupertinoIcons.book_circle,);
  static Icon celebrations = Icon(Icons.celebration,);
  static Icon language = Icon(CupertinoIcons.globe);
  static String Arabic = "🇸🇦";
  static String english = "🇬🇧";
  static Icon Login = Icon(Icons.login);
  static Icon logout = Icon(Icons.logout);
  static Icon visible = Icon(Icons.visibility);
  static Icon nonVisible = Icon(Icons.visibility_off);
  static String logo = "images/syrianlogo.jpg";
  static Icon pass = Icon(Icons.lock, size: 24,);
  static Icon error = Icon(CupertinoIcons.exclamationmark);
}