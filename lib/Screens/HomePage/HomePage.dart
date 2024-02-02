import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../SideDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String formattedDate(timeStamp){
    var dateFromTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy').format(dateFromTimeStamp);
  }
  @override
  Widget build(BuildContext context) {
    final CollectionReference home =
    FirebaseFirestore.instance.collection('home');
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.list),
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        toolbarHeight: 70,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text("Syrian Community"),
        ),
        backgroundColor: Color.fromARGB(255, 33, 173, 168),
      ),
      drawer: SideDrawer(),
      // i prefer the drawer to the DropDownMenu
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Column(
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                  height: 40,
                  minWidth: 230,
                  color: Colors.grey,
                  child: Text("Add things +"),
                  onPressed: (){
                    Navigator.of(context).pushNamed("addInfo");
                  },
                ),
                SizedBox(height: 12,),
                Text("here you will see the latest news for the Community"),
                StreamBuilder(
                  stream: home.snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    return SingleChildScrollView(
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        children: snapshot.data!.docs.map((DocumentSnapshot document){
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return Column(
                      children: [
                        Container(
                          child: Card(
                            color: Colors.grey[300],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(formattedDate(
                                    data["time"]
                                  ), style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, bottom: 3),
                                  child: Text(data["name"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                )
                              ],
                            ),

                          ),
                          width: MediaQuery.of(context).size.width,
                        ),
                      ],
                    );
                    },
                      ).toList(),
                    )
                    );
                  },
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
