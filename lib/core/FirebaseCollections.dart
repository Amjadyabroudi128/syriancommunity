
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class dbColl {
  static CollectionReference myHome = FirebaseFirestore.instance.collection("home");
  static FirebaseAuth auth = FirebaseAuth.instance;
  static  CollectionReference celebration = FirebaseFirestore.instance.collection("Celebrations");
  static CollectionReference members = FirebaseFirestore.instance.collection('members');
  static Query<Map<String, dynamic>> time = FirebaseFirestore.instance.collection("home").orderBy("time", descending: true);
  static User? user = FirebaseAuth.instance.currentUser;
  static  CollectionReference community = FirebaseFirestore.instance.collection('Community');
  static CollectionReference contact = FirebaseFirestore.instance.collection('contact');
  static Future notification = FirebaseMessaging.instance.subscribeToTopic("topic");
}