
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class dbColl {
  static CollectionReference myHome = FirebaseFirestore.instance.collection("home");
  static FirebaseAuth auth = FirebaseAuth.instance;
}