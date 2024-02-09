import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:syrianadmin/main.dart';

class FirebaseApi {
   FirebaseMessaging messaging = FirebaseMessaging.instance;

   Future<void> initNotifications() async {
     await messaging.requestPermission();
     final fcmToken = await messaging.getToken();
     FirebaseFirestore.instance.collection("tokens").doc().set(
       {
       "token" : fcmToken
       }
     );
    //  initNotifications();
}
   void handleMessage(RemoteMessage? message) {
     if (message == null ) return;
     NavigatorKey.currentState?.pushNamed("homepage", arguments: message);
   }


   Future initPushNotifications() async {
     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
   }
}