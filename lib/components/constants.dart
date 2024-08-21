
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syrianadmin/components/icons.dart';
import 'package:syrianadmin/core/themes/fontSize.dart';
 import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../core/themes/colors.dart';

 Text kNothing =  Text("nothing to see here yet :( ", style: TextStyles.font20grey,);
 Text wrong = Text("something went wrong");
 Text kLoading = Text("Loading");
  Icon email = Icon(CupertinoIcons.mail_solid,);
  Duration passDuration = Duration(seconds: 1);
  Icon home =  myIcons.home;
  Icon locked = Icon(Icons.lock);
  Icon unLocked = Icon(Icons.lock_open);
  Color cancelClr = ColorManager.delete;
  Color? add = ColorManager.addEdit;
  Color? submit = ColorManager.submit;
  Color empty = ColorManager.emptyLogin;
