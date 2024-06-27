
import 'package:cloud_firestore/cloud_firestore.dart';

class dbColl {
  static CollectionReference myHome = FirebaseFirestore.instance.collection("home");
}