import 'package:intl/intl.dart';

String formattedDate(timeStamp){
  var dateFromTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
  return DateFormat('yMMMEd').format(dateFromTimeStamp);
}