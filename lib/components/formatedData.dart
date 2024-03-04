import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

String formattedDate(timeStamp, context){
  var dateFromTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
  var locale = Localizations.localeOf(context).toString(); // get the device locale
  return DateFormat.yMMMEd(locale).format(dateFromTimeStamp);
}